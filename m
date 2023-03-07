Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AD6AE462
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCGPTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCGPS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 10:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05D20577
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WvISTS/f4ZrOg4Qn5jDzcftulng+Jaj+2XVbo0ebuCg=;
        b=GP1HwulQxkUK7Itg4wDOctfyszCyizv/ZbcwRgXhplbA3ZVswel+Rp3JmTaily9UU4rio3
        +qW4u9X/rsGAw4dOzT82IMy96TYPV0u0hCymohWtKWZwNoxD35YKax8yyC56hHV3mA+/Y8
        u8+zIYxCumz1UD/rs6uvy4WCeRgygQM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-OkCV2_rfN92tkfIrr9WmGw-1; Tue, 07 Mar 2023 10:13:30 -0500
X-MC-Unique: OkCV2_rfN92tkfIrr9WmGw-1
Received: by mail-qk1-f198.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso7530894qka.22
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 07:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvISTS/f4ZrOg4Qn5jDzcftulng+Jaj+2XVbo0ebuCg=;
        b=QhqOwR3qXLnZ7OrGnDQSi2MVqcuiKW7CYj8VfffC3+m4hBAJHqYtFpqUpjMyB7AER2
         rp8mwxaPb5AounHu8SaQ5n/eSm0nCC/IQOvS0HTM5ZlchV1W18ZJN8eFuEM9iRtFzvtc
         YMA7csreIxmK7EGxr5F6B+1CcN62U8DOKlAwbSU/yp9wATGFRAPMzUSnVVVYTUY8XguV
         Ar+G7gYdooTiFELPJ2cae9qAehMDQ7e78N3yQco4enVMJNPLlkXO9pFTx9IQrSzahH//
         goua46NyhKaQskqz3bRHZVVuHyieSbHQ/EWLRtBFjM6YpMYI3T9rsTft3Jqnx5+w2qPq
         6OoQ==
X-Gm-Message-State: AO0yUKV7GMiNRUFty3jelDyAV6CNAmhASyxb9XYQlszayuJsV8d9uFZY
        TD3lU8hc5PBgKS0iswAKAH5jX8EJT2sa2F94dRdvwVy4dt8oW4XjyOXm4f7xgiaK1p4LUfQWn5e
        A978ZopZzod+y
X-Received: by 2002:a05:622a:1443:b0:3bf:c994:c9b6 with SMTP id v3-20020a05622a144300b003bfc994c9b6mr23589680qtx.29.1678201992403;
        Tue, 07 Mar 2023 07:13:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9TmvzsR4HqKIqb+BcjJiWtp9AaRyGnpSJemAFjbkf0yUgxhC8H5Nq/lMkoHAF+O/d53/mIuQ==
X-Received: by 2002:a05:622a:1443:b0:3bf:c994:c9b6 with SMTP id v3-20020a05622a144300b003bfc994c9b6mr23589642qtx.29.1678201992132;
        Tue, 07 Mar 2023 07:13:12 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d79-20020ae9ef52000000b007296805f607sm9712804qkg.17.2023.03.07.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:13:11 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, joannelkoong@gmail.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: extend btf id list
Date:   Tue,  7 Mar 2023 10:12:39 -0500
Message-Id: <20230307151239.1994179-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang and W=1, there is this error

kernel/bpf/verifier.c:10298:24: error: array index 16 is past
 the end of the array (that has type 'u32[16]'
 (aka 'unsigned int[16]')) [-Werror,-Warray-bounds]
    meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
                    ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
BTF_ID_LIST(special_kfunc_list)
^
./include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];

When KF_bpf_dynptr_slice_rdwr was added to the enum special_kfunc_type
the total exceeded 16.  Increase the array size to 32.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 3a4f7cd882ca..166c387b48f7 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[32];
 #define BTF_ID(prefix, name)
 #define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
-- 
2.27.0

