Return-Path: <bpf+bounces-20875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0288449F2
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 22:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307601F218C1
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657039854;
	Wed, 31 Jan 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfukBuZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4639851
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736391; cv=none; b=Z9sKhXRZUsnXA7l8i1ypiCdGQITde6eUO4bRsXCXr0dFOJHw1bCZ974Ez+gtzUkUiR+1uJCKsV5NKpUL+9P3L3fcjZjrF22C1aWIIeWN1VgEW3wkb6ibw2U9mGlgy9DYkf/3rs18PcIz+gSsJptbCof9WfonRM4RGE0WzHUzuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736391; c=relaxed/simple;
	bh=ULpcU/1TIn5c0lUjmlZOtbUTfKgaEnUmmototxkV9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hun5B534x07oxbLCj7OaRGJMFpp0ts0Lhbm6zwUVrvsfM4+zEIlthx+whFybXxiAcZ3QrfoVYppzgJE0Ss1pYuNvt9A7tXk3pJnWZLPqJ8buPsVPz6WwY+Yvzc76ecPbiNH7O7ZCcsB+Nh15P0Znj0EcuH/FLrCV4DvI6ZwnoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfukBuZb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394b892691so82635f8f.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706736387; x=1707341187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmXE/zA2tQPT63xOvGuLd3DNscD1babk6AzaC2F081s=;
        b=GfukBuZbfmAD8FFF20A4orliyw5lzU4h1MNPSFwmRZIqwaqSfZ2J1mmaaH769PJVvD
         dq6Xtlu8fzV60LdRucSq58MxSslvOxEvj5eNz7f0qxKGcbwqBFJsNXIt+SZ/JJ5m8UAv
         7Yv+BAm7HrQqyUHiOgwB/wmMw47RkYb/a5xI9o/XzYSAVMTKRUuHN64C6E84jZtvs56g
         eHRPlcdeh2sWr4bsLN9C4l0QdLm5v2RRaZTdwSpwBUcNSnshYcyu0eJLc0rf9Gop0ESy
         lsWJp6kF9XB3+r3Tf4U+RsG8UDSiP/jTYzcDyhKy3o3RRWFqNPfC+5s2UgMctsH+SDoM
         51AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706736387; x=1707341187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmXE/zA2tQPT63xOvGuLd3DNscD1babk6AzaC2F081s=;
        b=eBdz4xQHHA8z+Iyo1awA7WMEEfOZ1WJphT4dzi8gCcr+FSfLcZeHW1uuXb537O++Nz
         0cOZz+W9GoXMjGXjc4KPbFcOdUSHmWdbqzhWOTmXtzXMW67Rj19eWHZAx0sE+UKECQ/J
         u2/B/wqVBTzSZU0V04rkDIUQuQRufmhOaF8QghPbobw4V7o5bi9GDEoVEpzpxwIa4qRp
         N5Suf767wJKmY4+7XqIcIGOlRo/nyz1L8JT2+uGgxeeH8EjBal7h/L+6LVpm6nC2BwGb
         54LDEnpzJMe7rkKcL4MgnJWu8v0DQ0FlDM8Do02067v2d0gvZyb1gIsdiQvSAUGdJBkH
         1Z6w==
X-Gm-Message-State: AOJu0YzrzIEaY94lGEI633Ajnf/DZshzJelPhEeqLZNu7ZGYh8KwAleS
	sIIcnEN+HboTL5fd7ffNPs4SHjjkJ9fxiKW9kCegvtXvs3NNpC9cLDM634/8
X-Google-Smtp-Source: AGHT+IEMwSA6GR+eUKLroleu+nwedoZmGcHf5q6j6izyd4dYWQuHOs9vGPwT6Dm4g47/zL1D+6B/Lg==
X-Received: by 2002:adf:e8c2:0:b0:33a:f277:8f6 with SMTP id k2-20020adfe8c2000000b0033af27708f6mr5273446wrn.14.1706736387134;
        Wed, 31 Jan 2024 13:26:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXypFzjBBFsyofm5t9NXwpvCMpIj88LqysTVEDUXkuBP/IRLO4/q1rPQrE26oVWEWt/q+R5zgOCX+hGVM8G/e9ryJ+xekx/xM0ydz8WdzpAy7w6HIv9q64UZNCOIdsSSnQbJ3te/dn+dMjGfPoqNvbLmVL64aphB/+fbL5cvvxcgPBLxiUEDv+HAeqd95XShGgYInXOON01vRugjiG+GisvN+PGo+HxeB5dMQ==
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a056000170500b0033aef083fbfsm8619995wrc.31.2024.01.31.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:26:26 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] [libbpf] remove unnecessary null check in kernel_supports()
Date: Wed, 31 Jan 2024 23:26:15 +0200
Message-ID: <20240131212615.20112-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After recent changes, Coverity complained about inconsistent null
checks in kernel_supports() function:

    kernel_supports(const struct bpf_object *obj, ...)
    ...
    // var_compare_op: Comparing obj to null implies that obj might be null
    if (obj && obj->gen_loader)
        return true;

    // var_deref_op: Dereferencing null pointer obj
    if (obj->token_fd)
        return feat_supported(obj->feat_cache, feat_id);
    ...

- The original null check was introduced by commit [0],
  which introduced a call `kernel_supports(NULL, ...)`
  in function bump_rlimit_memlock();
- This call was refactored to use `feat_supported(NULL, ...)`
  in commit [1].

Looking at all places where kernel_supports() is called:
- there is either `obj->...` access before the call;
- or `obj` comes from `prog->obj` expression, where `prog` comes from
  enumeration of programs in `obj`;
- or `obj` comes from `prog->obj`, where `prog` is a parameter to one
  of the API functions:
  - bpf_program__attach_kprobe_opts;
  - bpf_program__attach_kprobe;
  - bpf_program__attach_ksyscall.

Assuming correct API usage, it appears that `obj` can never be null
when passed to kernel_supports(). Silence the Coverity warning by
removing redundant null check.

[0] e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
[1] d6dd1d49367a ("libbpf: Further decouple feature checking logic from bpf_object")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index db65ea59a05a..f6953d7faff1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4661,7 +4661,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
-	if (obj && obj->gen_loader)
+	if (obj->gen_loader)
 		/* To generate loader program assume the latest kernel
 		 * to avoid doing extra prog_load, map_create syscalls.
 		 */
-- 
2.43.0


