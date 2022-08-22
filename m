Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA26759C92E
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiHVTpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbiHVTpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:45:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0750076
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lp15-20020a17090b4a8f00b001f50db32814so7892083pjb.0
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hPvdfxYdjpcqJ6S3vyKTC7fQbD4P716afvt4JxjTBik=;
        b=hqUkximtQHSnRRAxnvJF4IZldlKOvI3Mk8eQH6iJGM5ulIN6H95gQOFsW0pJQOuJbp
         GqA67XxVz96kj7BowC8toGPe/jSdDDnk9zUGnEoeVUaMLLaPPMZPwiL0tA51SqTBU0vG
         mV/3iH2I5oEghGgAkHzD0ip3jjU52NkZxao8Jqlj9EC5pm63tL077LRh16432SIXTZjN
         K0g/X0ds30iNZgFGIPYNyb1xaX+LldYiJ7SFb4oqxD/+xyjDVZVPBzC7Pl0i+xeTluaD
         wtP07/S1HZAx3dTVJiRs90ch4xQExuT/LOLto3vbOGk/j+RwX+wLiw0QmsO6Wc+Nt7m/
         TP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hPvdfxYdjpcqJ6S3vyKTC7fQbD4P716afvt4JxjTBik=;
        b=eatXe1IuriTf2rVlbQo21d8S5D8FmsGgTQ3xFyC8debCenx7KGK7SJ2P7lDWE0mktz
         ebRrDV08YhLQTAFubZKL6qNWKXEcYjErV7ucx7+p3782hsYiosNGevZitqqgzuNA484O
         weVVUUq/tAuPPUqgwYGrJmj/i4cIizVtI0G6ehUPHs93Mm9QkLSCYBmv/AKqchYD3tj0
         x+RElpx5h01OkOLSKBm5CBYBZf4mI9cezkIHbnxJDn/DGCvMGzI9Xu2ooEX0CeSVOVvE
         wOvgocUy887g7owEvwzQgOtZkROMug6fjjnGHwugyVV321etNiYBY2kmBqUHfRdx5yqu
         KASQ==
X-Gm-Message-State: ACgBeo1PyiuahaR5axgUljRaiFyoa1MW4KisduknP6XCnVJxtXE1kvba
        7rLZFTka9FM0Iv8EKNOqDV6DI1twyW+e+CtDn8T95EQelfXXFA7LkV0TnEARdvwzsWDDtcNYB7y
        9fiepbcWzl3BbxknPJLQ6z7EFYa/VuDf5R4wLZL8vgqxJNiNl+w==
X-Google-Smtp-Source: AA6agR5s495BmvNAvZ49UM/jSHZWmbPzSaBpVulCQxCOVDL5w2R//9cXPfnG7AAJKcWhVXWMmHPtlUw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e801:b0:172:fb87:d4d5 with SMTP id
 u1-20020a170902e80100b00172fb87d4d5mr1888804plg.161.1661197521761; Mon, 22
 Aug 2022 12:45:21 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:45:12 -0700
In-Reply-To: <20220822194513.2655481-1-sdf@google.com>
Message-Id: <20220822194513.2655481-5-sdf@google.com>
Mime-Version: 1.0
References: <20220822194513.2655481-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v4 4/5] bpf: update bpf_{g,s}et_retval documentation
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

