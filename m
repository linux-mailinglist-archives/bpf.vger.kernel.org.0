Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A056E715D
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 04:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjDSC4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 22:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSC4t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 22:56:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4976A56
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 19:56:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-555bc7f6746so39107557b3.6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681873007; x=1684465007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7wxsVQZbvReMl/l4p93VYTf90czgDsihU+utzmnvKA=;
        b=F/g7zFJQjSY9GWhwi4VmAX5Lm88bOdsWn8U4jZPix0/GiQEhB90rPe4QwwBLQng39v
         xuQOsgVtL4VGUlgYG2O5O4bxQmqPFQkwEM5FrKVUbXh4hbrIzs5m1+7/a7/K8WI3GPbC
         YotPM/qsMVxxFQTMMu/FMHOAis44qgu08zqv701DGW8x/Y1FKSgEWo5LAQzUcmUqjsnh
         BUq8TAdnxdebyu0+x4YQH6TeJxBVgIS9Wrwp+NXK+Ub1Rr3qutxN7GndmhZkj3WZKRzN
         Q+BphaBrU1mX5M+YII/9tbVJqT6VPJu/Pqa1F5F7xQZYvu1tFcODh/1cVppLm9hsdK2F
         pf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873007; x=1684465007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7wxsVQZbvReMl/l4p93VYTf90czgDsihU+utzmnvKA=;
        b=BTBSrQyko76wTcI+R7cr+ZcAE4W3W2kwBvUT/kn3zjUYZNzuvRazWInL5qxfMN5zVi
         NN9eIsxAOcXoSr7XcWOJsFlPkDTbzTW+KEnEzE2z+TXjLGu98NLtCpf4IeacaKo1xyb9
         Up1rJn1XwDsA+Ex4oMs+WbGneI6f6qf/1z6RiG7/58T7/NMJMO741EsxA3NliGgb+zN4
         LKa50NPQnprMW8O6J6n++uk46SVgPoFFCb58Gqmwcn9l4hXTYCTCFI92rol406qgMS6n
         dGcUb0B7EqamRBRpqxl1Qttz5nEMYZ3GW1z+CxOk4h4zbESaLeJBMekVQa3uXLY4PYG1
         TO5A==
X-Gm-Message-State: AAQBX9cfDSoqKll8sYezYnmGetfj8kHWsKS2POikFXM4jbOCxVCWVXUn
        71ewIR32eZHr7WoWzbMaX+o+ModymnY=
X-Google-Smtp-Source: AKy350ZqqmWOj+KDApy1dnWSsbOJp5gfV/pVCFMViWI8zvXNQlvKOdVZc03sIgF0CCqOQAm/+m2XEg==
X-Received: by 2002:a0d:c8c2:0:b0:54f:ddb9:95e7 with SMTP id k185-20020a0dc8c2000000b0054fddb995e7mr1810137ywd.34.1681873006873;
        Tue, 18 Apr 2023 19:56:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d7b6:a335:3f56:2311])
        by smtp.gmail.com with ESMTPSA id eo9-20020a05690c2c0900b0054fa9e39be0sm2667585ywb.56.2023.04.18.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 19:56:46 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 2/2] bpftool: Update doc to explain struct_ops register subcommand.
Date:   Tue, 18 Apr 2023 19:56:25 -0700
Message-Id: <20230419025625.1289594-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419025625.1289594-1-kuifeng@meta.com>
References: <20230419025625.1289594-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "struct_ops register" subcommand now allows for an optional *LINK_DIR*
to be included. This specifies the directory path where bpftool will pin
struct_ops links with the same name as their corresponding map names.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
index ee53a122c0c7..2111c9550938 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
@@ -51,10 +51,14 @@ DESCRIPTION
 		  for the given struct_ops.  Otherwise, it dumps all struct_ops
 		  currently existing in the system.
 
-	**bpftool struct_ops register** *OBJ*
+	**bpftool struct_ops register** *OBJ* [*LINK_DIR*]
 		  Register bpf struct_ops from *OBJ*.  All struct_ops under
-		  the ELF section ".struct_ops" will be registered to
-		  its kernel subsystem.
+		  the ELF section ".struct_ops" and ".struct_ops.link" will
+		  be registered to its kernel subsystem.  For each
+		  struct_ops in the ".struct_ops.link" section, a link
+		  will be created.  You can give *LINK_DIR* to provide a
+		  directory path where these links will be pinned with the
+		  same name as their corresponding map name.
 
 	**bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
 		  Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.
-- 
2.34.1

