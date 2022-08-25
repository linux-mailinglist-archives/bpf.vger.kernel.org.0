Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908195A0EA2
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiHYLCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 07:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiHYLCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 07:02:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF1AD9BB
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 04:02:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so24159009wrq.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SJBMg00diCd3yjsVHr1vRSQzlkH+CAlJdA3yNULUpyw=;
        b=GKDVSPDbMTQ/VpwHSZ1a6C9hAg8+gBAh244RLBDfMF60uda4iBus8koZ2IJ7AmRaX8
         lcUDEWaEp1BvMDUVp7Wh4t2zHasRon8/KAC/BJ1DqnbHwMD+mL3zDA1m0rq53khvA71C
         KVNMyz+GEj87zwEH3TF/GvJud+6p8X0psPshMmURiZqQBU6wcxwmWGysW6C4HcMy/tAh
         9H4azy4bl4//DXrh/371Bvo83ufZTdk3yDcbjr6VTh3ygxV1u6pI3O5t1rhmD49Cvw7T
         FjZa2/EgDHMUoWCeep1Qxk9Jx0f3XtAhcAFnzcub1oHLN2k37qIqlNi9w4iihSpQHhSR
         hOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SJBMg00diCd3yjsVHr1vRSQzlkH+CAlJdA3yNULUpyw=;
        b=EkmM68PMXgNe7ohDqlhMf352jdnzRfdNxBPyHSYQGPJ5shOUWzQ+XVKu9VnXQmIooT
         U7x+aNxgSx6PXCcDJcilFP4nizpgiA5dtnzKXHLKvkLe/y3/UHfrNK7R0b1BHThl0JY+
         eVtO+jkvy16SpLbCg4qyrAHEhrpnMfbIzF2W5IrMLwKSgskzshqYA2sVvIOIhftsFQFT
         ohiY9Yry2YYohpd1x6tyCZptLAKlvT9XTqTe28d7jYbXbGhPmlI13B7nchrqVgs/hCl6
         UQ9Xsz1kT8dSTO+tLZlVp+q+0qjgRUkWACUIEeGLgGEaqK3kM28jj7l540WITnIGCCz5
         bZmw==
X-Gm-Message-State: ACgBeo3QIRtp7ZDfvC6EcV8l/sUhrLPOt6VHM9kmgHqYThSpgod41Vha
        cXTI9t82nENMNqTQ2loSr3AJ0+fCGlfBrQ==
X-Google-Smtp-Source: AA6agR61JQV836r6DZk1E9BvJTqquAbMk2h1et6kEo+mVuPRg5f7bwUIZ94S96ZssPAcVdR3/vsrjw==
X-Received: by 2002:a05:6000:104f:b0:225:29be:a39c with SMTP id c15-20020a056000104f00b0022529bea39cmr1853091wrx.641.1661425340198;
        Thu, 25 Aug 2022 04:02:20 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id bp25-20020a5d5a99000000b0021f0c0c62d1sm19231084wrb.13.2022.08.25.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:02:19 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Fix a few typos in BPF helpers documentation
Date:   Thu, 25 Aug 2022 12:02:16 +0100
Message-Id: <20220825110216.53698-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Address a few typos in the documentation for the BPF helper functions.
They were reported by Jakub [0], who ran spell checkers on the generated
man page [1].

Sync-up the UAPI header with its version in tools/.

[0] https://lore.kernel.org/linux-man/d22dcd47-023c-8f52-d369-7b5308e6c842@gmail.com/T/#mb02e7d4b7fb61d98fa914c77b581184e9a9537af
[1] https://lore.kernel.org/linux-man/eb6a1e41-c48e-ac45-5154-ac57a2c76108@gmail.com/T/#m4a8d1b003616928013ffcd1450437309ab652f9f

v2: Turn a ',' into a ';'

Cc: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jakub Wilk <jwilk@jwilk.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: linux-man@vger.kernel.org
Reported-by: Jakub Wilk <jwilk@jwilk.net>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 include/uapi/linux/bpf.h       | 16 ++++++++--------
 tools/include/uapi/linux/bpf.h | 18 +++++++++---------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 644600dbb114..0487ee06edef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4437,7 +4437,7 @@ union bpf_attr {
  *
  *		**-EEXIST** if the option already exists.
  *
- *		**-EFAULT** on failrue to parse the existing header options.
+ *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
@@ -4646,7 +4646,7 @@ union bpf_attr {
  *		a *map* with *task* as the **key**.  From this
  *		perspective,  the usage is not much different from
  *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
- *		helper enforces the key must be an task_struct and the map must also
+ *		helper enforces the key must be a task_struct and the map must also
  *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
  *
  *		Underneath, the value is stored locally at *task* instead of
@@ -4704,7 +4704,7 @@ union bpf_attr {
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
- *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		Returns the stored IMA hash of the *inode* (if it's available).
  *		If the hash is larger than *size*, then only *size*
  *		bytes will be copied to *dst*
  *	Return
@@ -4728,12 +4728,12 @@ union bpf_attr {
  *
  *		The argument *len_diff* can be used for querying with a planned
  *		size change. This allows to check MTU prior to changing packet
- *		ctx. Providing an *len_diff* adjustment that is larger than the
+ *		ctx. Providing a *len_diff* adjustment that is larger than the
  *		actual packet size (resulting in negative packet size) will in
- *		principle not exceed the MTU, why it is not considered a
- *		failure.  Other BPF-helpers are needed for performing the
- *		planned size change, why the responsability for catch a negative
- *		packet size belong in those helpers.
+ *		principle not exceed the MTU, which is why it is not considered
+ *		a failure.  Other BPF helpers are needed for performing the
+ *		planned size change; therefore the responsibility for catching
+ *		a negative packet size belongs in those helpers.
  *
  *		Specifying *ifindex* zero means the MTU check is performed
  *		against the current net device.  This is practical if this isn't
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4fb685591035..0487ee06edef 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -79,7 +79,7 @@ struct bpf_insn {
 /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
-	__u8	data[0];	/* Arbitrary size */
+	__u8	data[];	/* Arbitrary size */
 };
 
 struct bpf_cgroup_storage_key {
@@ -4437,7 +4437,7 @@ union bpf_attr {
  *
  *		**-EEXIST** if the option already exists.
  *
- *		**-EFAULT** on failrue to parse the existing header options.
+ *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
@@ -4646,7 +4646,7 @@ union bpf_attr {
  *		a *map* with *task* as the **key**.  From this
  *		perspective,  the usage is not much different from
  *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
- *		helper enforces the key must be an task_struct and the map must also
+ *		helper enforces the key must be a task_struct and the map must also
  *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
  *
  *		Underneath, the value is stored locally at *task* instead of
@@ -4704,7 +4704,7 @@ union bpf_attr {
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
- *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		Returns the stored IMA hash of the *inode* (if it's available).
  *		If the hash is larger than *size*, then only *size*
  *		bytes will be copied to *dst*
  *	Return
@@ -4728,12 +4728,12 @@ union bpf_attr {
  *
  *		The argument *len_diff* can be used for querying with a planned
  *		size change. This allows to check MTU prior to changing packet
- *		ctx. Providing an *len_diff* adjustment that is larger than the
+ *		ctx. Providing a *len_diff* adjustment that is larger than the
  *		actual packet size (resulting in negative packet size) will in
- *		principle not exceed the MTU, why it is not considered a
- *		failure.  Other BPF-helpers are needed for performing the
- *		planned size change, why the responsability for catch a negative
- *		packet size belong in those helpers.
+ *		principle not exceed the MTU, which is why it is not considered
+ *		a failure.  Other BPF helpers are needed for performing the
+ *		planned size change; therefore the responsibility for catching
+ *		a negative packet size belongs in those helpers.
  *
  *		Specifying *ifindex* zero means the MTU check is performed
  *		against the current net device.  This is practical if this isn't
-- 
2.34.1

