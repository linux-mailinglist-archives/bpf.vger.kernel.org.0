Return-Path: <bpf+bounces-39451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F91973A25
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8611C21416
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE46195B1A;
	Tue, 10 Sep 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYLPuO8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94675194C88;
	Tue, 10 Sep 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979278; cv=none; b=S1xwkGcv/fHMm3KZRF03GZS4G1s+nuLOm6MGG7ssXhTYQwb4zlAqhrcEhAF/XJIfUpvE10MJtVBsUS0Qc4cRP03OmZgpXk8i0hbZ9jghcfIuuUi/5vuwjuN3m1Ah77CPrBDdJx4c8VMXcy4JoAPcdIbbTZcvZkhxrdOWvRgJID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979278; c=relaxed/simple;
	bh=27rcGA6KTtaKZoQk3gB9D/jwRNFVQnfog3vV/i9zYrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7I+v2sNMAjdct3il5W5MT98GCEqMm2UhIS94Jhv18v2QJULfYxKLPbtbPKs8q2TILcytiAibhyP4quzks604PecCwgBjOmHRbzt3yw5rmptTIcWP6lSJJNDg0bcOGOVe2zeZ2D/k4kV+HhwsDZEhU+X6ENQPkNzCtdoMSM/Q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYLPuO8o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71911585ac4so458424b3a.1;
        Tue, 10 Sep 2024 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725979277; x=1726584077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNCu0caYG1HESfoq6HexwenbSSZR3vVfpE74goxAn0o=;
        b=SYLPuO8osI+NTQ2GAciU2ye4faGpAXRV5eNdnj2Jww8VBcA1hCkbFmUXgsVBHTwjtR
         ZvBIyZrLISvw8rsFTb7jUY1pX84b5hEH8TGmbuua6LMyvQM24SOTKJnulzi5oWfQascy
         Su3CxZQe48mY4rLPWGCtskS4Wl9wXrImttHATes0NIfX27LIIWfMItayz+fJ9zadVt0D
         2m1B/hUo4RGXC6UKxGZEBx7emopq3rkQPQNXGl0uOpOPuZl8PVji4d47wD/1XN5f+cpF
         ZdLd6a2KjD+/Xa4KDKsHrJO04nDyBqytevLbWtAHSjNLdprKGLP3+yyUlVrDDO3bEQGb
         b22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979277; x=1726584077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNCu0caYG1HESfoq6HexwenbSSZR3vVfpE74goxAn0o=;
        b=vid/m9bXViTY1Ci9UB4b/TXW5vkJG8Gtk/jGRGfyMjjM+wB10Ccyyd7r26XKr66Jw7
         HZ2RHKpyzUQ5v2POpygXeC3DMs2s6+IrVPOcp+s9TmQoJR3b5OFpeiFwHK8MskQp8STQ
         ffz2U1qje7wwEnmZqWP3yZgnzuHrTtFfty57oiK0QUEvfQXDp0pg3qNZ02P2FmbheDPi
         Re2y8JfS8/RplcSzc7JMsHWoC0wkhGXic70ForUFrbdUMGLl9vvk2sRpV6leOxpTY3YS
         RJyWLyD6XqZ7F53orWCAC+hdCpxGJ0mZTHT7xHcu/G596GfjTfdv+kJSz3//3TMb678D
         ACDw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FIR1YN6+116u/2VU61olH2kF+QJRPTwaxhU8oPjZTZ/Faz6yrlh42BpfFRtScbsS7kU=@vger.kernel.org, AJvYcCVYInMra/kTWsYTN0VdM4wnX/X9qJHJ618aFgvJ4RGLvYUTJN7G/C/bCt+vafA6mDz5hOy/JIJI5rPExKPm@vger.kernel.org
X-Gm-Message-State: AOJu0YxeP0K6xK0I80GlTuHlj67x0MFRXKQ0UtXPJSFjhd6mBEkMw5qp
	x+Wl/5ASr3TJv18wBLPFUsYr44Y+puc+dBqypsG3o6Z4wD6kQ3Yoa4t0og==
X-Google-Smtp-Source: AGHT+IEJziLgImQNSIUyFTR7Nc/8CJ/Aw+5lRsMm2rvhlQZ/GCjIAqMGc11NxlrUnlKmWYOxDftg1w==
X-Received: by 2002:a05:6a00:1a89:b0:717:8568:8cee with SMTP id d2e1a72fcca58-718d5e5ca7dmr20526167b3a.12.1725979276469;
        Tue, 10 Sep 2024 07:41:16 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909092335sm1442966b3a.113.2024.09.10.07.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:41:16 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Tao Chen <chen.dylane@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH bpf-next 0/2] bpf: Add percpu map value size check
Date: Tue, 10 Sep 2024 22:41:09 +0800
Message-Id: <20240910144111.1464912-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check percpu map value size first and add the test case in selftest.

Change list:
- v2 -> v3:
    - use bpf_map_create API and mv test case in map_percpu_stats.c
- v1 -> v2:
    - round up map value size with 8 bytes in patch 1
    - add selftest case in patch 2

Tao Chen (2):
  bpf: Check percpu map value size first
  bpf/selftests: Check errno when percpu map value size exceeds

 kernel/bpf/arraymap.c                          |  3 +++
 kernel/bpf/hashtab.c                           |  3 +++
 .../selftests/bpf/map_tests/map_percpu_stats.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

-- 
2.43.0


