Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059063C4EF
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiK2QQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 11:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2QQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 11:16:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211CBC3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:16:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 62so13443786pgb.13
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHJMtC2gH4h73e5hkDbdLaUuVwt6LMWbfkEwLO0XiPI=;
        b=j2VMfKtqpu3PHbYjDfQ+Svk3tHxmbjS/8KrVwNwHdxR+4lT35OWl32dxqyDTefXq69
         o8GiklVmleTb96/GgfGUDKC4/KDSP8OzmfEdNxV3JzDEzWShHaGUvNWWnl7Dp+4WYjaf
         7fJFaV3b0sf1z+94oYbDFA10AAzvcOhMpaBixzF4x7JCdPgJPYoxex3WoXxVzoHv9yO/
         GfnCcO5ctc71r4quMbqEQTaztgr4Dv28c0wn1jEIC6tcZjeeLQo373nO309c/UhK/ugc
         QEt8vjJbkKC8AZK8Z7fa/WpxQV2zsiqRN/HVdQ+NrD+Ojk5zSqfRbOWZ3v48CnPB3YtV
         sPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHJMtC2gH4h73e5hkDbdLaUuVwt6LMWbfkEwLO0XiPI=;
        b=6jzLYO2KQmRv9WYBQwyOrTbhUUUM95LBOvcMwKaBHJN0xDiGA09I2Ok+lT8cQHK8re
         w8iqH107v3VY81ArHohyKPHN+oYj4dXHlB7BCHD4KlQgd3bx/NbrrgI2d9wFGvXOocg2
         j6akOQpKDAoL4E8FewZeFVPcXV2CoErYMG4SFiQsgAsu+QSzMWEMOiDIjQekEJv9PLhA
         NysNkbSnpMx+DrmpAGTcgEurWkA4JQiwDkWLEr5Z9MlJKPTtP9qPOUVVU7rtUha4TTWM
         C6WBXFdh7eexieQdlB4MyhpJFmRVYGTecUxzAG6/r3ob2Nf8ent0NUjNiUHHqFFcdRBh
         Q7gw==
X-Gm-Message-State: ANoB5pm9GpaKWhzKaUpWdH/RYhkCj6Uq/bhXm91pBeEKyjtXp0NAIWC5
        Z45GNIxJ9ONlyEtf3nBCDlkLjTOuaWGlY/Oh
X-Google-Smtp-Source: AA0mqf5esn6+F5wOAGzkrX16qZw0XrSYP9UjkiinfAArXUTD+AlG//h51g1LNsf0FBpJ/9jQnw3m2Q==
X-Received: by 2002:a63:131a:0:b0:476:f92f:885a with SMTP id i26-20020a63131a000000b00476f92f885amr33553962pgl.478.1669738580815;
        Tue, 29 Nov 2022 08:16:20 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:1b4:5400:4ff:fe39:b072])
        by smtp.gmail.com with ESMTPSA id e66-20020a621e45000000b0057488230704sm10084746pfe.219.2022.11.29.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:16:20 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
Date:   Tue, 29 Nov 2022 16:16:12 +0000
Message-Id: <20221129161612.45765-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the containerized envriomentation, if a container is not
privileged but with CAP_BPF, it is not easy to debug bpf created in this
container, let alone using bpftool. Because these bpf objects are
invisible if they are not pinned in bpffs. Currently we have to
interact with the process which creates these bpf objects to get the
information. It may be better if we can control the access to each
object the same way as we control the file in bpffs, but now I think we
should allow the accessibility of these objects with CAP_BPF.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..9cd6b41e2d2b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3660,7 +3660,7 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable())
 		return -EPERM;
 
 	next_id++;
@@ -3741,7 +3741,7 @@ static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_PROG_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable())
 		return -EPERM;
 
 	prog = bpf_prog_by_id(id);
@@ -3768,7 +3768,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	    attr->open_flags & ~BPF_OBJ_FLAG_MASK)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable())
 		return -EPERM;
 
 	f_flags = bpf_get_file_flag(attr->open_flags);
@@ -4345,7 +4345,7 @@ static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable())
 		return -EPERM;
 
 	return btf_get_fd_by_id(attr->btf_id);
@@ -4769,7 +4769,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_LINK_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable())
 		return -EPERM;
 
 	link = bpf_link_by_id(id);
-- 
2.30.1 (Apple Git-130)

