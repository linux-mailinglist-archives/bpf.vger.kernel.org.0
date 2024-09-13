Return-Path: <bpf+bounces-39841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE497860D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD481F25C6B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDB7C6D4;
	Fri, 13 Sep 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJcrHDf+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA462D052;
	Fri, 13 Sep 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245848; cv=none; b=ofRE8dRZiiXkRnb+eaDmPLupXastC8ExWL5vHU9KGFGcalHXWo59a1cT/9GoB8HSFbW06eCdJCvqpcgPP07MUjoptLYtXbyFB2RqhHyZ/mzydIQP/E/PSVxfszXgvOdJFTBu86EPzQlrrlsShvGJdzuBok0T400CukR1HIq3ybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245848; c=relaxed/simple;
	bh=9P3KKNeOdf/QArfyD1XcZIiZNM202mA/m+9ClQY2USo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBS1PvVmIHEdMVgyU0wtd4h971jaEqrbtdp6qAmCBy9d+9VvNA3LPIYOlPJszn7oh8YqjvppU6TcnIk3MWNYP4SJ1mxPy1FPhdbIVN2isfQJSgVgUWVIIAvt20B7n6E6vbu9UFysve27K6LYh9E0R08d6H0oK7Wj0gm9ik3NuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJcrHDf+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so1983122a91.3;
        Fri, 13 Sep 2024 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726245846; x=1726850646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hu6phz1hzShHnKdfRtYKMNvyuzN1209rgixPm1lxEo=;
        b=RJcrHDf+85g7Z228LOy83FtmJniVPrlYgYbm8rXVAjM0GpLSLCbyAhDdctTEmO9OEP
         6crrYEm97yfsxwyfwrMh66e3fzBxRNPvlF7JhuSlYZlDFtLh5lw5z5nQj4VHkc0fColt
         2LsatnoeVKlYUDkkQ3ikUR3xG6mJe9LdMQm1MT5AxHosTP5xfF8RkOEE1MP0MLQqOCiR
         uoI6K8H12qKByiKIcyzQoHRwO2+ve/HGac0mTSZUDqCtX+oXj4yhy96N/rCS01pycBJW
         ylR1FprxLArVnUaDsQrYUAzGrilUZGmgyjhUE158tUuHqfalOpC0Hq2sngVH1rRAp7sO
         typA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726245846; x=1726850646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hu6phz1hzShHnKdfRtYKMNvyuzN1209rgixPm1lxEo=;
        b=oY2Enq0x/T/KwWydsDD958kPX07EwIirshjxwMbMUeFrEjNEWD0t0g7AUtjycmabkN
         U6xPmQKjldNAAYg+tpUHZvjJFhlX9YGBHg0o1FDi7cO0Brx4eUQDRRuhftPC6jwk7+qR
         Q3n4wAsEvbWOSVZRMefAs7hvg8uSXnWPzpqlDAtnnASk6wGxJA8fCeOdJG2NGBq7lrs1
         OcYamhzXezyTKX+9cCGbbgm/R7B3aazk+V8EngDXAmbXGCz0wzaOaXKRiLU4nxN46kbN
         vaeJqvUtLF4/v0/5icwUe+XoYImKFhhkODZN9EEs09madngpBXw9vIB5Wuu196wTcWMj
         R+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhUTyfZue7fo8/wV5cfKmQO/+AzofHQ3+xPAgUAIaqFT0pqP47XFh0JKq/vBlMhXtoeYD+d+Ik473VHXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFc2mvqAxxdPe1PuNUpyc57Uja6qgrnB886fnpRW6f+VgZCgf5
	dLklBWPvvIAQ/x4iaxuxJkgdnEpF5awH1likltEYuRjEp0vHoLyj
X-Google-Smtp-Source: AGHT+IETR1pLw22OESSlqZ9K710vB5OgYjNJAcUs9DZzWF3wNd4u2+qR5UXoBqYfsY2HHH9UPXj9sA==
X-Received: by 2002:a17:90a:9308:b0:2da:d766:1925 with SMTP id 98e67ed59e1d1-2dba007f632mr7941267a91.37.1726245845652;
        Fri, 13 Sep 2024 09:44:05 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d98963sm1984722a91.53.2024.09.13.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:44:05 -0700 (PDT)
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
Subject: [PATCH bpf-next RESEND v2] libbpf: Fix expected_attach_type set when kernel not support
Date: Sat, 14 Sep 2024 00:43:55 +0800
Message-Id: <20240913164355.176021-1-chen.dylane@gmail.com>
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
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Change list:
- v1 -> v2:
    - restore the original initialization way suggested by Jiri

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..df2244397ba1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
-		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
@@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
@@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
-	/* allow prog_prepare_load_fn to change expected_attach_type */
-	load_attr.expected_attach_type = prog->expected_attach_type;
-
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
-- 
2.25.1


