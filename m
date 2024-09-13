Return-Path: <bpf+bounces-39824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D2977FAF
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6BCB289E3
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9E1DA0F5;
	Fri, 13 Sep 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbHOZ0kb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5B1D88D3;
	Fri, 13 Sep 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229811; cv=none; b=l/T/HE16DVD0qw1RZx6c73fAgASKsPlZOOtpitAVDIIC/HwNytVBDnTEArKoMfDU3PF4NjOPYDGifWWy88hNDt0icXhLGYAqNW7LhaqfF9u5K79bYzbrM3h+og0izfVMfvYMNsQH4cHcc+ra2ubDVC0/XWKNEBZrxBNCbRZqX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229811; c=relaxed/simple;
	bh=O0hIV/6nB2rRddlD11VmsyTXzTX0q92fiXgW3yR8Qfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQ3/rM5IApzvZ84v2ZVnSFO30NujQp5MJ7VkJLIvNHlWqOhzMKXEqlJOOUfCQ469IfEBWqHc2NGfKtjXzrRukqBgLiHgbrQ7tGgnwXXdoXybJJpxmYnzKOkln8PRTdrIOoC7FfdBIryF34h/UoR+W8g5zUxEMwoeywQQeeqzE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbHOZ0kb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7178df70f28so1618454b3a.2;
        Fri, 13 Sep 2024 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726229809; x=1726834609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbCGTiN11FXVDbAkkViGrjdz04Y2hBtYS4VFXBmy4tQ=;
        b=CbHOZ0kbAkcxJIxpXVJjsFqukNKI3KuIGXH+F2yEgjfQI/pjY83hRqmj3wJ9p2v+1Y
         F2XAy9YaUvTLaurhaRG9BoIRi6TYrXjafPq4UA9rdNaWa+FYPvq/w+Vo7bG8dd6HH7IK
         we1YgnRCbNY58FuJ/5O4NPvvoLTqyyxuadcRuZRQ17b+D+mVQNSk1TZzr+JwmWWUHCeK
         h3+sLJqrOPKSqoeb+Cr21DGepnhKOeYH3Q2AOLHM6U/CbFuZ5jPT3BsR7tQhqyZ4KhhW
         SO0rGjBNkHlyo2wV5q9nlQOwH//OlYE8zN3q+iv7uZJQYsrn2yvXT+EXjrExNURlDyeK
         Ydww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229809; x=1726834609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbCGTiN11FXVDbAkkViGrjdz04Y2hBtYS4VFXBmy4tQ=;
        b=SHov920XHjseYxbm88XMIHdvuAElXmDSxH1pUIz2Govo0SCFsNr8ne/2FfaT9Gua2M
         IZgMd0ITbqRssYG0moiI4tk8yhnuPnjVQnFTf3HWJjb8PMKAfrjKZ5eysz3V3OnekYtW
         0v+y/eLPVbbmIE201BaRtSpLW5r0XLK8MQ1bTRBDeeIU5LCEVL+83DYxf4UFNsu0Hki4
         agK5nZqJY2TazIls34dtGdEfGY42KC4O6F6QAmY8s721hCYcZEpyPpEsbxz/d4Ij0ZA+
         7Ll0dzxJCA+OSrHzVxcNjKwEnIuC9i6u0bVT9KHwmQcSL0jPNGYLGVmcmJZEXkG7AumC
         OPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUohlnkzPwf+xywZCEpVvJERHdC6JegmN+x5X0kfxYRlaUTggaolN0aeCkzY5M9dXE9Chik0ettPDsT0/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN/Fwqx6Zawki9UdAeDYGNEsvIlomJcAGkQQdrDpjM61atRip
	JIMFeaUd+jtMSaD3sMM+N41y2XopAT45vyvfNF14R/ODKeHhNx6r
X-Google-Smtp-Source: AGHT+IGEntuO0AfIyn2/27Csp9RurnaARnS88M+fUAOsKJoNa02/MLOdAFJCt2QX9JfbWN6i+OsKzg==
X-Received: by 2002:a05:6a00:2daa:b0:717:9154:b5b6 with SMTP id d2e1a72fcca58-7192606ce9emr9929623b3a.7.1726229808646;
        Fri, 13 Sep 2024 05:16:48 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909252esm5986331b3a.124.2024.09.13.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:16:48 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next] libbpf: Fix expected_attach_type set when kernel not support
Date: Fri, 13 Sep 2024 20:16:27 +0800
Message-Id: <20240913121627.153898-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "5902da6d8a52" set expected_attach_type again with
filed of bpf_program after libpf_prepare_prog_load, which makes
expected_attach_type = 0 no sense when kenrel not support the
attach_type feature, so fix it.

Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..9035edf763a3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7343,7 +7343,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 	/* old kernels might not support specifying expected_attach_type */
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
-		opts->expected_attach_type = 0;
+		prog->expected_attach_type = 0;
 
 	if (def & SEC_SLEEPABLE)
 		opts->prog_flags |= BPF_F_SLEEPABLE;
-- 
2.25.1


