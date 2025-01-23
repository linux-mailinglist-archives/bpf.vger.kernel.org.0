Return-Path: <bpf+bounces-49583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 443E3A1A87E
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C50188E4D3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D882153FE;
	Thu, 23 Jan 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwcNeAsf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579D2153F8;
	Thu, 23 Jan 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651963; cv=none; b=ocuMugrmyiYo9jNHVyqfYO8/yPSm5oqfEAo+t9BsopqfZVaW12/hVq0YQibs/Dm9WN3iq+QHvXNxPE7jV6eHoVU5kWxanzXwvWK2jT/lDnwrVzLYbhFGOU3TpzOcAUxdJthCqBcby/DnFqvhtR6s5FoqSe5hc5X3Rz8EZFMeWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651963; c=relaxed/simple;
	bh=57gNsFeGAMlR0TbDCGi1s/wIv4wDl8lGHmb+XUT1DpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwEzg4/alVp2B1DGHo8PzCKEGj8bgqf0kWCTc9QDYBPVfa3hy2XvZwWaFFDHN1nokg08wPuQoytcWaW1n0qR2bCU46Z2DWDjZ/lstQ7PcxyoYWFefZXdaF+uE7gDpvUSEbcRTmCj8R8g2PqEW7Fa1xULgkV07HIACSpHb5V93Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwcNeAsf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21649a7bcdcso20657225ad.1;
        Thu, 23 Jan 2025 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651960; x=1738256760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5cHnouL9ni1UHHCnJzcDlfamXCkVHhgw5c2JHRsxX4=;
        b=jwcNeAsfd+YSE8oIKYZE8VFLTPwvekWAa8QCKKP6mQ4V57AlnGvZjydKaQpwMlRsgS
         laZ3XnfbMlzAcVrtLksaBe8oJEJP3IVOfYKoyLa4hlwJHBJyT/sg7UWW/ggsXBPmj113
         By1d3PSEQMfNRoXLCKkfXhwmIpDllT8mevvvoENGqZCqOZLSJp1yxy6hsnPc3G3iOTCs
         7meZjV9P5Swn+QO8SiM7KGQ181v4LG9th9vWm+MVHMDJDJhEzebn2H5vBO7Uf6bNOmXU
         vx7BM21HNQysvYQjfB5IecoHhSPz1IP1QTnEP/FEaS2ObCC2XHIAyqLQPQLrQvYv6FYv
         pKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651960; x=1738256760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5cHnouL9ni1UHHCnJzcDlfamXCkVHhgw5c2JHRsxX4=;
        b=hfWMzn7cq48yb34TpuGG/01xQa2oL+IHVze5eB6WumrRM01TW4KcP8v2OgDlqO9Qls
         eNvnyS+ezPTSJn32dlpFFsufH9+geEzKWThCtYVH7SXbRHT1OrOKCezd8JF0YQ9xdvQj
         bsc349TBSohPrm40Ng0lrUYCW4kwpKmZs7Zj6Wio69shsBqjivcb5JL77pJ1TU6EsiFI
         zXyHzX9NHN9C9mHrM3CgD3uyv//neRoRTpXogYXf64Miw1WbKGxT1PcsgVfL1luXwu5k
         CJUwGi882BF92Do0W1VbD43kJyIcDl0txvNUPBVbiF54cOrhXpxemIXZqSIn9WtSIgLr
         fLpA==
X-Forwarded-Encrypted: i=1; AJvYcCXzmEExF0TPHONFofS7CIhR0cJjVSB6URanzHgdVNjFW0XezwaP31EEIfFMNEL8HeQYszV1RORpJw8Mr2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIml2pCZxwcFO7GT7edbMtVsDJ27ng7myc9vaW4lH9CJcMOXY
	GkcYEKEywem0lCrPE871vW6B/g7qUkIEVyLZKDtZ0+3JavO6zlmOvmX2EQ==
X-Gm-Gg: ASbGncsSStR34f50yMqFufA09S5apeAUvEpTTR3roAp9YF+x4wK44alkmA40S5wJRcc
	MGyG2LFapY7ZCMsVah7E79mceXCU78sj3+FvfEvoVaEqwawmkTnBlGBNEyd4hPksbYg5i9VK5K5
	FX0VlG3a80ieDSuVoKLffAyo5jeaDg8/Pqd5vvhyDLWjZpYtbhIC9LHXj0HJxX086ZjEobe+VO2
	uy2KM1wbhYhtucWp6uyAGBBUFyY07l85/UqdKNtruMgbkW1xGkIN/8XqELil/pcXFtilr5DdQhS
	UKVHiIHUlu7I0A==
X-Google-Smtp-Source: AGHT+IGe4Tc5dEPr4EJZV499oDB8Rri/Jwzh+JlFyJfsEgbVKhhIiDMsx9SsWs5HcTLohzRokgdzRA==
X-Received: by 2002:a17:902:ebcd:b0:21c:7e22:7844 with SMTP id d9443c01a7336-21c7e22789fmr264511535ad.51.1737651958989;
        Thu, 23 Jan 2025 09:05:58 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c5d6sm1428095ad.52.2025.01.23.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:05:58 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Add prog_kfunc feature probe
Date: Fri, 24 Jan 2025 01:05:53 +0800
Message-Id: <20250123170555.291896-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Change list:
- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - chenk verifier info when kfunc id invalid

Revisions:
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (2):
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        | 17 ++++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_probes.c                 | 47 +++++++++++++++++++
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 ++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.43.0


