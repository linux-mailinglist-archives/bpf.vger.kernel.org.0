Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA746E867D
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjDTA2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDTA2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:28:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12630ED
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:28:36 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fc337a650so23131267b3.4
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950515; x=1684542515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SthL6OHqX6FzuwDi0PaNEc2NoQeNojtmQVxNqnY9Lc=;
        b=UXCJ+jE/8haW4LtFwim+TPRw8ZumTxs63Y9R/KNzIArfxiJXUCdhj3HCrQmQoPgvhi
         vavaFxDj59WE35f77k6bQLwjlfTIA17gD/0mc6M7X1Rk20ynqsjqaTHxRPSeDzdn8bAR
         ONmbYAQv0u6HzbmD48c3xyTmhjzOEReHMkhCXcagNpDMhdWryotmAX8UTHaqqvj8YD43
         /m22A/pwBfNtAe+OPpOTCpNXm/A1otXdGOPHD1qMGocGuvF8Ia08atiUX50Wcr6j9Gr9
         aFEyFObgTeFzSKITdhHG127cPnCZI9zL1UXi7GzVZx2yLWaxEEGSTWS4KYrTTyMNQBs3
         97Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950515; x=1684542515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SthL6OHqX6FzuwDi0PaNEc2NoQeNojtmQVxNqnY9Lc=;
        b=I+AEBlfbzubWm0hlJC+c90IyV/NC0+6SL+yVGxrClPDPgeSIOn6KF5OYRdRR3kR1mv
         jqHyB1Wr7tANNiePYr+VJdeUVM2V9+lD4f4FGh7VMu82RVAskstcxj/kW7D+dHExoJAh
         OMM5zGyNMjSCl5UbkPTjyUwMaopuQzm1VZSqvp4LD04oV+cE9jKZ09r6MH8vgBZn7VrR
         KhEaM4B31xsOlrsNZPsAj2OXVvYJvzfZp/NKvkDC+HMSoQUj9gLfputUQqc6MbLPs5cq
         N+xptSqKx0Sv2ww3msIfdNTzUl9B8YjkFzQjqlqA4bXUfT7wcXNkLdObNGzCbD1q9K28
         /hUw==
X-Gm-Message-State: AAQBX9fvQQYJ5UdR/tVzCHiGDySVG1D3ei8oIiy7eFt2mKsDiiw0iCnz
        kdP8MfSn2E5BqSWoOltnfzOIaud1IIc=
X-Google-Smtp-Source: AKy350Y75qKmArDKR1fKcJc8vd0D6L7H/Ng6l+AVS1KYxXuI1jDX0gkq7uy2nA7wHyVBagkAAW39AA==
X-Received: by 2002:a81:4e0b:0:b0:54b:fd2a:7288 with SMTP id c11-20020a814e0b000000b0054bfd2a7288mr4666284ywb.39.1681950515447;
        Wed, 19 Apr 2023 17:28:35 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7d97:458e:fc71:f392])
        by smtp.gmail.com with ESMTPSA id j1-20020a0df901000000b0054f9dc9c7f2sm30822ywf.44.2023.04.19.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 17:28:35 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, quentin@isovalent.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 2/2] bpftool: Update doc to explain struct_ops register subcommand.
Date:   Wed, 19 Apr 2023 17:28:22 -0700
Message-Id: <20230420002822.345222-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420002822.345222-1-kuifeng@meta.com>
References: <20230420002822.345222-1-kuifeng@meta.com>
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
 .../bpf/bpftool/Documentation/bpftool-struct_ops.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
index ee53a122c0c7..8022b5321dbe 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
@@ -26,7 +26,7 @@ STRUCT_OPS COMMANDS
 
 |	**bpftool** **struct_ops { show | list }** [*STRUCT_OPS_MAP*]
 |	**bpftool** **struct_ops dump** [*STRUCT_OPS_MAP*]
-|	**bpftool** **struct_ops register** *OBJ*
+|	**bpftool** **struct_ops register** *OBJ* [*LINK_DIR*]
 |	**bpftool** **struct_ops unregister** *STRUCT_OPS_MAP*
 |	**bpftool** **struct_ops help**
 |
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

