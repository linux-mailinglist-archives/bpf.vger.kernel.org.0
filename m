Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369D06ED91B
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 02:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjDYAB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjDYABx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 20:01:53 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC99658F
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 17:01:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1a94e68e8dfso22356035ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682380906; x=1684972906;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/rpqhpRIOtlKSihwGkZnVdOZR4ACOJ0OGirVHh0Jg=;
        b=TAsLtu5dAMbjjUcSTcJmvzS1zE2yVVzVA9qIyktnncSFwx+Mv6n14U0lKj4Vg+Ywpr
         GGNMrmF6KHrj3fdmX9baPnW4PWwfpufR3mpFcRoj1zA3BklRvRFGQ167yftEvj3JUuqC
         Ql8toeDntE1SlRRtXVpOWEaSjRJRQp8dWeUmt9ordSngIhUy7uRObH18lJjVHE1bqnUM
         bg01KJzHcnkYV4gMb4wSCcQD5l11n648SYrE2CWdyDRCWgyxYaDiE+Y0P37wox10bflS
         m+NnjembZ2LjnnnbpEhsZ4D2zA/hmf1n68wcAHOpv4e9ZCFxSDMTpTpFfuLri8j77aPY
         DGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380906; x=1684972906;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp/rpqhpRIOtlKSihwGkZnVdOZR4ACOJ0OGirVHh0Jg=;
        b=WUNUKcfQPal8zvjUIzpv/ife2hwTqCGAAFNTBjml35PyaGRcnJHdi7AMYN4j4LCkwu
         fHS25MVfdCCp42zSDzbaHZDqRovUeiatwDeEcpoBjMCTQ5+mbOFOoFSYmfs2htawT0Qi
         N/+8+6ExcO+jC49O8wjuswiCYyi3o6p7WnurWdhFiD80SLCDRhuzC7vQcZ2jzv9NRcHT
         pO6HunYhMhn7Iu7FUN8zX1+KtBWQP1GXa/DfWaV/LSigNGhVV5X4xhbkKLbZcp3ny9si
         InOGnu4i4U9B/mB/8oQsg+uG+mEikSpJmgyMw/AqRNy4AWfg29UjyAlb7BFKbXR1OqmD
         m3pQ==
X-Gm-Message-State: AAQBX9eYJ9iYVNQTFx6msUKzopbkTNQ0VI49l6eL/SZCliTqnDBOu8qL
        ocjPA0CKK2lUHqacvH8zYIt28QfioihmP5Q/o5OQuURZsu4CSoNW3h6yE5DWyOuqqwlhYx27vY/
        Q7KqOZSnYkHKhK76zGv5ID1ISH/rwRkjVrMKZJetBqm9V4xjU8w==
X-Google-Smtp-Source: AKy350bA1+JdPQZSRp2VjeOH8P3HVUPbiJltF4fYw61X/UXeQEOyHmkMy3nYobV3kfOPexQOvvblyjM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e751:b0:1a6:c110:900a with SMTP id
 p17-20020a170902e75100b001a6c110900amr5137457plf.3.1682380906106; Mon, 24 Apr
 2023 17:01:46 -0700 (PDT)
Date:   Mon, 24 Apr 2023 17:01:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230425000144.3125269-1-sdf@google.com>
Subject: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peng Wei <pengweiprc@google.com>

Compiling C++ BPF programs with existing bpf_helper_defs.h is not
possible due to stricter C++ type conversions. C++ complains
about (void *) type conversions:

bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98void*=E2=
=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissive]
   57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D=
 (void *) 1;
      |                                                                   ^=
~~~~~~~~~
      |                                                                   |
      |                                                                   v=
oid*

Extend bpf_doc.py to use proper function type instead of void.

Before:
static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (void *=
) 1;

After:
static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (void *=
(*)(void *map, const void *key)) 1;

Signed-off-by: Peng Wei <pengweiprc@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 scripts/bpf_doc.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..fa21137a90e7 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -827,6 +827,9 @@ COMMANDS
                 print(' *{}{}'.format(' \t' if line else '', line))
=20
         print(' */')
+        fptr_type =3D '%s%s(*)(' % (
+            self.map_type(proto['ret_type']),
+            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
         print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
                                       proto['ret_star'], proto['name']), e=
nd=3D'')
         comma =3D ''
@@ -845,8 +848,10 @@ COMMANDS
                 one_arg +=3D '{}'.format(n)
             comma =3D ', '
             print(one_arg, end=3D'')
+            fptr_type +=3D one_arg
=20
-        print(') =3D (void *) %d;' % helper.enum_val)
+        fptr_type +=3D ')'
+        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
         print('')
=20
 ##########################################################################=
#####
--=20
2.40.0.634.g4ca3ef3211-goog

