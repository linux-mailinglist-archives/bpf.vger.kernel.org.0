Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7105A1BEC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiHYWIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiHYWIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:08:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C8785BB
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:08:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bs25so26259888wrb.2
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=e+2mbE3EY6LbH66yMZs6iOUEPtcQI1RliOTDWT7QbUU=;
        b=zvJEuOr15C+reSrV6n1lt6n9fUPlqz8u2HSF5ZxWNQeLyRTSrQx9yljTSaTGcAKD9c
         AsJEP64rM/fk2/V1Pscd7qRi3saEioGiObGdmhdDxxXfNata/NkSUNLVWsWTT8FiDtvi
         bhr3a4I+pG1Tukl5IFPz0FpfIEXhZm5Ar4eug24uVgdwKMuqFpyDVAC4Rlff4euN2WO+
         HADFO2meL4vvp5UR8wf6IByv/THnaZqiujtxO9p+unCapYnkgGHKCHQQNYTaxIL1xyDA
         2AT9XJY3beOSgbfa7uArsK1XZUtSsnasXNTS5YzOd3uhHMASj83cd5vKvEne3mBejK87
         idLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=e+2mbE3EY6LbH66yMZs6iOUEPtcQI1RliOTDWT7QbUU=;
        b=4vARFQ26MgWcUnt+C1uz4nWItlzq9yR6VAmBmRSfj6eseuIIUkr53osLXHPYMnxF2R
         QRcnw5xciBRvCd23Vac+JeHFUo8iQkN86iOvHcwaB+msmMjc/ObwP3SJNEvDQf9faoYe
         beMhK2bUECIzN/Y+fO/HNTdl47tkNvZEvQ07DDka1fSHnogyNwbfg7/ng3qLngrkwtvV
         ZdgNKkd0sN+fC+qVAAp1mnPZVBw285ySghxNxdKB2AXbAeuHmoDh7gWLDFAmhe1pe4m4
         E40065SZ6p40n07eJv8iCxwMcplS6Ga+SCQe8FDSPKmRi1ySBVLbVV0CLwNLeLnAqfSp
         /2Ug==
X-Gm-Message-State: ACgBeo0YBoo1GfIXhAz6Kfzla2kwWhjhGyYs+xC0OTRFe1phphteqUM/
        ZzsZp8ed4gtkSwpiPqSld2JYPA==
X-Google-Smtp-Source: AA6agR71Zf6kI4YOh6gSdWKYscZ7sIGMO+p9S/VewZaVH/Om3SbSGE6SDKtJiVJoVAaklTpdZ9lF3A==
X-Received: by 2002:a05:6000:1a8e:b0:225:644c:59a0 with SMTP id f14-20020a0560001a8e00b00225644c59a0mr3343913wry.67.1661465290601;
        Thu, 25 Aug 2022 15:08:10 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b0020e6ce4dabdsm254192wrn.103.2022.08.25.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:08:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers documentation
Date:   Thu, 25 Aug 2022 23:08:06 +0100
Message-Id: <20220825220806.107143-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Address a few typos in the documentation for the BPF helper functions.
They were reported by Jakub [0], who ran spell checkers on the generated
man page [1].

[0] https://lore.kernel.org/linux-man/d22dcd47-023c-8f52-d369-7b5308e6c842@gmail.com/T/#mb02e7d4b7fb61d98fa914c77b581184e9a9537af
[1] https://lore.kernel.org/linux-man/eb6a1e41-c48e-ac45-5154-ac57a2c76108@gmail.com/T/#m4a8d1b003616928013ffcd1450437309ab652f9f

v3: Do not copy unrelated (and breaking) elements to tools/ header
v2: Turn a ',' into a ';'

Cc: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jakub Wilk <jwilk@jwilk.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: linux-man@vger.kernel.org
Reported-by: Jakub Wilk <jwilk@jwilk.net>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 include/uapi/linux/bpf.h       | 16 ++++++++--------
 tools/include/uapi/linux/bpf.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f61f09f467a..01c54a462352 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4456,7 +4456,7 @@ union bpf_attr {
  *
  *		**-EEXIST** if the option already exists.
  *
- *		**-EFAULT** on failrue to parse the existing header options.
+ *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
@@ -4665,7 +4665,7 @@ union bpf_attr {
  *		a *map* with *task* as the **key**.  From this
  *		perspective,  the usage is not much different from
  *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
- *		helper enforces the key must be an task_struct and the map must also
+ *		helper enforces the key must be a task_struct and the map must also
  *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
  *
  *		Underneath, the value is stored locally at *task* instead of
@@ -4723,7 +4723,7 @@ union bpf_attr {
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
- *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		Returns the stored IMA hash of the *inode* (if it's available).
  *		If the hash is larger than *size*, then only *size*
  *		bytes will be copied to *dst*
  *	Return
@@ -4747,12 +4747,12 @@ union bpf_attr {
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
index 5056cef2112f..d45dda46aa42 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4456,7 +4456,7 @@ union bpf_attr {
  *
  *		**-EEXIST** if the option already exists.
  *
- *		**-EFAULT** on failrue to parse the existing header options.
+ *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
@@ -4665,7 +4665,7 @@ union bpf_attr {
  *		a *map* with *task* as the **key**.  From this
  *		perspective,  the usage is not much different from
  *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
- *		helper enforces the key must be an task_struct and the map must also
+ *		helper enforces the key must be a task_struct and the map must also
  *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
  *
  *		Underneath, the value is stored locally at *task* instead of
@@ -4723,7 +4723,7 @@ union bpf_attr {
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
- *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		Returns the stored IMA hash of the *inode* (if it's available).
  *		If the hash is larger than *size*, then only *size*
  *		bytes will be copied to *dst*
  *	Return
@@ -4747,12 +4747,12 @@ union bpf_attr {
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

