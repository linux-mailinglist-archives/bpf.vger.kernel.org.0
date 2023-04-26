Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73656EF803
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbjDZPyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjDZPx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 11:53:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04B6588
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 08:53:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2470e26b570so4146685a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682524438; x=1685116438;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8StZ9v7+npJf4QTWtBrbESsLcSma5y/BndiRsu/T0yk=;
        b=7ALJW2oMr/CRRNAa0GEOJYHZwHS6WBiKcQQGaNR22npC7YqG6dR93YTErQ+5OztCIb
         M/EfS8E1F1f+C3Ukx46A/uolSO3gotH5pjKs4c5tf1ScM3xkcc6bEGXnrxhrpbjIpOaT
         lJquPqkk0OEcIBvhHogzV69Kf9952VnAriygn04tbDM33nx3NyzqlqSpBmKX/qaQs8UI
         pBNTG6NoQMvITVCCYXV9wz5fR+Lput8XW3nds6Sq+PlPCl7AfMxwGhj9oeRMQ3Qp6kWZ
         p/hCRkeF19jil5XjzGRUzzfbNJ5RSvbI9NY7TUv2/rv3F7/Rx0+CLD34FNbd9H4tyFcq
         7ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682524438; x=1685116438;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8StZ9v7+npJf4QTWtBrbESsLcSma5y/BndiRsu/T0yk=;
        b=aJQEYbbpbOtmBoQYy+iWTmYwHUZd+9S6i2j+EVlBRXqqtIA4hAueyJWPAHzquuA41e
         56eC5YJVdJhvoeBwurRpQOm28I3YkVkRfwn2T5x2JUEk9UqhoY4ClFWOk/e0CBHbr9rO
         Ry64aoRuqYm647ddQS1fZwk0btuafh7/Dy9dq+jHpvTmlrjF70RsSltauFSIgeaKaLF5
         FXUPu76h9MKsJYQOLsQzEN1VZ/RySYEdbQ/Nef6b5hGaqF/LERvIYeYFU5FKkfI+Y8VJ
         /ttpjegvikf9/MHTfi8O0eb8Om4pYK8NZcKmydK34As1m5nPbhGofGBJVWjLeWpTNT1C
         zokw==
X-Gm-Message-State: AAQBX9fHJ2LZk3ekJYwoH8lFItI6GLEvCNpUbc4b+tcnfbb4oI9NRHD9
        BLEZLKQOEZfgE6YHUE7paJacSuCWXwCyCyXtJbLyVtG3homLvZsJB6VP/Mz8C/df2l1V+F69oSX
        xmIotrCZDIdDgP0+PG+hdR23FPL5iaqrsDcYtX4NnrIFwOlZQgw==
X-Google-Smtp-Source: AKy350YlF86e8XFbdDuDk+FqWf+8KB86KKO4l+AdqMGmhR/dYDB4HOLlSnTMNk/4MUehu6hY5HQVL5Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:a4e:b0:247:1639:9650 with SMTP id
 o72-20020a17090a0a4e00b0024716399650mr5028745pjo.2.1682524438292; Wed, 26 Apr
 2023 08:53:58 -0700 (PDT)
Date:   Wed, 26 Apr 2023 08:53:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426155357.4158846-1-sdf@google.com>
Subject: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>, Yonghong Song <yhs@meta.com>
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

$ clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h

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

v2:
- add clang++ invocation example (Yonghong)

Cc: Yonghong Song <yhs@meta.com>
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
2.40.1.495.gc816e09b53d-goog

