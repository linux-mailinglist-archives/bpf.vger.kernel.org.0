Return-Path: <bpf+bounces-20358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F354D83D0B1
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C86B22C73
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 23:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D4134A3;
	Thu, 25 Jan 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT81gQ1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB9125AE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225472; cv=none; b=A6aSTYQrEWniZx9SE9Ek/OfDHZq1tKXZQgbQgxW6NnIWQuQsr079mDmW+kw2+cB/+3ZU5VRyMRDqL1+iNJU0t0wK+azdyNYbyLFEHb/wpwELOTCBTmcbhgncxo759MiqIf2YDzO2/pdsD0KuGAm2+3aYSJfGBi3LlhTbUblGTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225472; c=relaxed/simple;
	bh=UTVG5/bDPM53vXqM22Os28Aaj8dFCJWQXskj6ft8sYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ci+kOxhFejv8zQsDUYevOg2XwAc5zjhHYn5GZCGbEUe3LHIjjzUAfUZrjZSx0clIRiht1WCXW0Bm9kXqHwIgotwEEqrq6fiGZ4LvQgOx/f1LXnrekUlurRmJ3sQqC/SOEgDTJA5kbEl3+uv1seBi88HsVry0km5+UtS6w3M5GQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT81gQ1M; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-602a0a45dd6so22357377b3.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706225470; x=1706830270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+8Gfg2C1Z1vOBYS7U8DGgBSjvRAua4UolLUgiLd/u0=;
        b=PT81gQ1MO/nll7sGKEQC+5SeW5GCnaIzLchl4Xg+WTffz+CyXF1NJOZECTQpdm05gK
         BeNloHVzASdudFH5PjwknNqWvnlHMhr6k0roTuUAoZO65zLeMfgkaGGtvTfR+d7he1Tp
         dQYE+wkMkpCMMF5rHhcdzIrGUqR+9r2KPbdyGsqE/Fwsz5phN6/WjnhANp1ozY15MrQZ
         84DczgPdSFghgPifD/qF4m/d6R6+vCbT+5G6Ss/KmDkMpvw4xz0X6mMUEeWTtX/CkrZT
         k2hxwh30iS8Kve4AzJgHH508rMm3+CzyUyDLUkSDWqZTdayL/qg/OWsUqRIhaFFqGOzN
         C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706225470; x=1706830270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+8Gfg2C1Z1vOBYS7U8DGgBSjvRAua4UolLUgiLd/u0=;
        b=p9hgwwdT6uhh6+rkCZXSWTo2CfwcYaomwSP8q3uGX0ySrxnATTIpue5IGvdnBMHUR2
         irPqRoOazPTjeL59wWnM9QbW5/I9eORGPsNVCH+ZmkB2A6tLQnfr8mFSiyWeswOMNKPj
         GHIp5DwC5AMYi+OjU+or/vsrwDo2U2biUupqu0Tj6RD/G5wz2FnQtMZtDcgeWUy04x76
         sO9H+7oiBQDeHaZ9bhffJY0SEG8A+SEc8vdfevaHZmF0fgiosHdnT8xieHDkKcePXR+I
         hfr6nIx3t0+GMKvky8LwEx06J0tXh+Y8sznqZuUh8CkMRJciNTtzfUOWl/M0m2RA4rgD
         AMVA==
X-Gm-Message-State: AOJu0YzmhxlRLcq7tO0OPDMQwJgLkWCNXUzD6ZWZSpIX7c4LeTn1+zDY
	Q+EPEy7xMsSMItFuVgVtYVeTN2eHnYkJo+E3fUFzhEEVo/RX6NTJKPhEX2c7
X-Google-Smtp-Source: AGHT+IGik5t+5yijGT4iINsNDzu3PoGFFFrgXzBp2/z/TP/VNR1ah2MUs0mmbLIECFFvpthErw4oNw==
X-Received: by 2002:a81:98c7:0:b0:5ff:a9bc:b7f with SMTP id p190-20020a8198c7000000b005ffa9bc0b7fmr579413ywg.21.1706225469060;
        Thu, 25 Jan 2024 15:31:09 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:f81f:566c:c5f6:9b00])
        by smtp.gmail.com with ESMTPSA id ci26-20020a05690c0a9a00b005ff6419ec70sm959752ywb.109.2024.01.25.15.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:31:08 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: Fix error checks against bpf_get_btf_vmlinux().
Date: Thu, 25 Jan 2024 15:31:05 -0800
Message-Id: <20240125233105.1096036-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Check whether the returned pointer is NULL. Previously, it was assumed that
an error code would be returned if BTF is not available or fails to
parse. However, it actually returns NULL if BTF is disabled.

In the function check_struct_ops_btf_id(), we have stopped using
btf_vmlinux as a backup because attach_btf is never null when attach_btf_id
is set. However, the function test_libbpf_probe_prog_types() in
libbpf_probes.c does not set both attach_btf_obj_fd and attach_btf_id,
resulting in attach_btf being null, and it expects ENOTSUPP as a
result. So, if attach_btf_id is not set, it will return ENOTSUPP.

Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/00000000000040d68a060fc8db8c@google.com/
Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops subsystem")
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 ++
 kernel/bpf/verifier.c       | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index defc052e4622..0decd862dfe0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -669,6 +669,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(btf))
 			return ERR_CAST(btf);
+		if (!btf)
+			return ERR_PTR(-ENOTSUPP);
 	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe833e831cb6..64a927784c54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20298,7 +20298,13 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+	if (!prog->aux->attach_btf_id)
+		return -ENOTSUPP;
+
+	btf = prog->aux->attach_btf;
+	if (!btf)
+		return -ENOTSUPP;
+
 	if (btf_is_module(btf)) {
 		/* Make sure st_ops is valid through the lifetime of env */
 		env->attach_btf_mod = btf_try_get_module(btf);
-- 
2.34.1


