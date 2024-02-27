Return-Path: <bpf+bounces-22757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0D8688C9
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 06:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368DDB21CED
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468B52F9F;
	Tue, 27 Feb 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+VB4dW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641F52F92
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013162; cv=none; b=Eb65H9x7gkGDe0QayeNX1ZhAdunagVXm7egbfTsrN7ARLw0JAJbEsKGf/ze7yltcs49FPPlCdzqFtczZv2mElBa7PwvtJXMA6fqH3x9EuPWeD7JD7eT/vZ+dginl6onhVhXXWPSj/HWpqeumGp2rOaP6Tbs2sdVF1KsDXFy0+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013162; c=relaxed/simple;
	bh=fnXZHGmWzAuEnCnYE5OL1zu4wlRE6bzaLqhba6MLQoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3UCLhe7o3TJuzSJirj1/JAmerzNnf9ZT2o+eq1pgmNogQpjUDTqU2cAmIUNAubyyY/K7iKrq91d52NwYAiPl5qk510Tw0o/S0kWphEUdUGmhNFX4aJFaxj2RvQ34jAEBKXeGi6XnHKdXs4ljEgQdpvtkPhKHZlG87dNi6Pr3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+VB4dW6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bba50cd318so2885575b6e.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709013159; x=1709617959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGZju2tT2aaQF6fTSFt6TrvOttMOGZGcCO9gHvxhcc8=;
        b=f+VB4dW6+ihmsgvOmE5KfeEGbBRuy/05IbyU9lhESQowMlJsaa4ZW5trEokCQ7olBl
         KJHr2hv7eRabkne4dVb+SZh4EtHT56KrwyHU9w05/ym+UWPgh4GeeiWrfeNQONcbwnR+
         eFjTWyNFAmj3HaalltaB52mI0B3BjM4+VkIKFUnXeqFR1dlQRvhushAb8sLerVtxHM1N
         iAkC6sIiYoAObvmops6AjD+QIRmyeOG+0tC80AtBg8U4NYPvHMkeR5zUuyZM4WefZRFj
         DLVg2wO+KJrSbkVm1vGJyC0szWoFAN3ITlSwS+EdSsH/WVzSYdwwc/cWQSs7TQRsI9E3
         RO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709013159; x=1709617959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGZju2tT2aaQF6fTSFt6TrvOttMOGZGcCO9gHvxhcc8=;
        b=mepkz5Oh2Y3QKTU6PSEWxTk8nkme6pIbYG/mb3+BjOoridoRgxf3C6jIEXZO1xRfTE
         7hDILSmk1duv2ivVh1IQ38G1hRZj+GDk1jBpLUOHN4uhm4M34Sotq1s1tlQ/HccdpPQU
         jlGqMacD2Mv98P/9jDOeLGtwDDG+qzGmPvAVRBWQSs47E2YMwseWd4bW1O61mQDfwVIA
         G0G+wbkYP/Jz1zPcM/iddaAH18L8pnYpoWKdsn8eymitWHgDTJd1UEHCZduMrYR5ohjc
         mxzJhMzWUjngyR3Xh3LxEILL/1Z3GPE6tY1+Y5qyg8BwIg0jWZz0iQD9uUaVjpyaIS3j
         QUmw==
X-Gm-Message-State: AOJu0YwgNW0QHfW4uFatOocqiV8/vSm4uM9aLx544lJRRH17xgNC0df+
	rzYjdyLQDpKQHNRzc05GXMW+PTn9a3u6gd77ixSx13Fx+kPzWuDqrGpu+6rt
X-Google-Smtp-Source: AGHT+IFTqu8IY3ciD6Ge0BchEQe6TT1zs+JTy3UsvZ3WyhfxJwUuiBe2VxkZZixnfVK3xBsj9AB1rg==
X-Received: by 2002:a05:6808:23ce:b0:3c1:ae1d:6f2 with SMTP id bq14-20020a05680823ce00b003c1ae1d06f2mr905118oib.7.1709013159096;
        Mon, 26 Feb 2024 21:52:39 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id qj7-20020a17090b28c700b002904cba0ffbsm7633812pjb.32.2024.02.26.21.52.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Feb 2024 21:52:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/2] bpf: Introduce bpf_can_loop
Date: Mon, 26 Feb 2024 21:52:33 -0800
Message-Id: <20240227055235.23463-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Address Eduard's feedback: factor out get_iter_reg
- Add comment that stack_extra adjustment logic supports bpf_can_loop only for now
- More tests
- Fixed minor bug in stack_extra in subprog

Alexei Starovoitov (2):
  bpf: Introduce bpf_can_loop() kfunc
  selftests/bpf: Test bpf_can_loop

 include/linux/bpf_verifier.h                  |   3 +
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/verifier.c                         | 163 +++++++++++++++---
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../bpf/progs/verifier_iterating_callbacks.c  |  47 +++++
 5 files changed, 198 insertions(+), 28 deletions(-)

-- 
2.34.1


