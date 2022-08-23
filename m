Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272E59EF2B
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiHWW0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiHWW0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFA6DF93
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c135-20020a624e8d000000b0053617082770so4836950pfb.8
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hPvdfxYdjpcqJ6S3vyKTC7fQbD4P716afvt4JxjTBik=;
        b=dHgCHYtCSLjv/qkmVdimKyjFUIYngc/zmTEmo46e+5Zy+p2UOkxgCAOZsCGEqUv9gH
         nxTokGES8KXfp61MArrJSaSdiFUiOAU74uPO0vEAMnkaTyHWE2H+gpqlWBLAP2cQAir0
         ROILWzY/0AVtFipib8A34aFRNDP9sDImZ027FA7jUzozlGEYpMjtr0w/ZvueV4utIrau
         UAm8xIv7l64NAop1cJTAxx6h/jkoohUhxJ0J9gzinlFXp0qpxAZoiv5HJHK47MMh3Vtf
         RtnqNRieu3pwTH120xwo/WS/44XQqjwZ86UvIoMe+vDMn0AwcpOFi4evcjGq4L0JRqT0
         RYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hPvdfxYdjpcqJ6S3vyKTC7fQbD4P716afvt4JxjTBik=;
        b=5ue1mgTuc/2HJ6tCQfXH3RrlN/NdyCSc2pv3s/e1Ub30h8skbHxfEVj0c9/f1E57sE
         o/+39o66rwMvg0cHF1V0cgV5wosJHC0YBAX6/W4r1RJiyb2SN6Zdymt6vkGr0VgZhW4W
         bAFVzlJCmykyl2JEqUMwXxLoAg0iaFHpu923rvEwqSgZ/+bp5udCcKx//2IMh6Y9tNtB
         I+gjDwgslx2lCexFoErXwx0b7dbHfkXhg/4Triccq4GiBivkUUtB2wMxgCbL4qgayye/
         vpHqF3LvUiG1iU4FnKIIvd0rD9J6cCwezfy8x4c3XcoLs6d0rlmwrY9avpVwvni2HCQe
         ENaQ==
X-Gm-Message-State: ACgBeo0Vyu9wCp8WptGj/GZo+YwKMHZX8yXjA9BJRGL6MpREKEQ8pBjv
        JaUhBkLUqR2HmZUDUqBgBrfQ6uTTZ6qxVR1kgl9BZjKBzr/3FGnr7jBlv4BzG2pixKu1jp1izw7
        qcFmntOPyfzsPaGZktkEnpgnFu/xrD6dUVwq5n23skZRQ+hn0uw==
X-Google-Smtp-Source: AA6agR4yfUBy8Cbz5kLYPr1kbXk1WT32852Ad6/vpVM+OR1RoAxVI5LOc4oIo2NkFCkltD1ygUlhdXY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4c81:b0:1fb:5419:89af with SMTP id
 my1-20020a17090b4c8100b001fb541989afmr5091106pjb.64.1661293564357; Tue, 23
 Aug 2022 15:26:04 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:25:54 -0700
In-Reply-To: <20220823222555.523590-1-sdf@google.com>
Message-Id: <20220823222555.523590-5-sdf@google.com>
Mime-Version: 1.0
References: <20220823222555.523590-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v5 4/5] bpf: update bpf_{g,s}et_retval documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* replace 'syscall' with 'upper layers', still mention that it's being
  exported via syscall errno
* describe what happens in set_retval(-EPERM) + return 1
* describe what happens with bind's 'return 3'

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h       | 22 +++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..954b897a631e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5085,17 +5085,29 @@ union bpf_attr {
  *
  * int bpf_get_retval(void)
  *	Description
- *		Get the syscall's return value that will be returned to userspace.
+ *		Get the BPF program's return value that will be returned to the upper layers.
  *
- *		This helper is currently supported by cgroup programs only.
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
  *	Return
- *		The syscall's return value.
+ *		The BPF program's return value.
  *
  * int bpf_set_retval(int retval)
  *	Description
- *		Set the syscall's return value that will be returned to userspace.
+ *		Set the BPF program's return value that will be returned to the upper layers.
+ *
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
+ *
+ *		Note that there is the following corner case where the program exports an error
+ *		via bpf_set_retval but signals success via 'return 1':
+ *
+ *			bpf_set_retval(-EPERM);
+ *			return 1;
+ *
+ *		In this case, the BPF program's return value will use helper's -EPERM. This
+ *		still holds true for cgroup/bind{4,6} which supports extra 'return 3' success case.
  *
- *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d6085e15fc8..b99ff5f34c61 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5085,17 +5085,29 @@ union bpf_attr {
  *
  * int bpf_get_retval(void)
  *	Description
- *		Get the syscall's return value that will be returned to userspace.
+ *		Get the BPF program's return value that will be returned to the upper layers.
  *
- *		This helper is currently supported by cgroup programs only.
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
  *	Return
- *		The syscall's return value.
+ *		The BPF program's return value.
  *
  * int bpf_set_retval(int retval)
  *	Description
- *		Set the syscall's return value that will be returned to userspace.
+ *		Set the BPF program's return value that will be returned to the upper layers.
+ *
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
+ *
+ *		Note that there is the following corner case where the program exports an error
+ *		via bpf_set_retval but signals success via 'return 1':
+ *
+ *			bpf_set_retval(-EPERM);
+ *			return 1;
+ *
+ *		In this case, the BPF program's return value will use helper's -EPERM. This
+ *		still holds true for cgroup/bind{4,6} which supports extra 'return 3' success case.
  *
- *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
-- 
2.37.1.595.g718a3a8f04-goog

