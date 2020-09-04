Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB525D748
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgIDL3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2AFC061233
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so5718147wmh.4
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsZcPNRuXjAj8BE6HDRDUYJhFGRJK7BfcdRk8sZ8GDQ=;
        b=YtuBg19GPz8DWrNVVsU8ZrW/10qMfj50ogiJo08i8yu17bpZh8aQ0EKI823xkmTKrV
         eWqaBcILybItyqNwyrdvKaM69rCXJ72EINmS2O+fXF+i5s27oIV2HD4YOElwxvamGD8O
         fBUT+4MCgwgeFjuk8D4RWPwvZA7HHc1MywWbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsZcPNRuXjAj8BE6HDRDUYJhFGRJK7BfcdRk8sZ8GDQ=;
        b=RZDXRLLOqAebdVpW4Ijy37DmytIrDELe1xtDRByP9YWIi9f9FRq1a8Hdr8sglmnq0w
         nM4Fvm+YbFmhilsBP/TL0NhGjpOIBvFsLBMh0P6OU6ed+mmSh+HdQXRa0yWJGiv9/jGM
         VXwG/MsZxZwOhh8dCam+Hx4vFYEm4gnNaGtpbyFF0NA9DXzKHjXfDJ4O1kvl4pI4l7si
         5Mo3Sku40ogmaplba2jsxLwa3VrMFOMWa9PnUGH3kmWbouksxyU1redYIgim7jHBEKa7
         zxmJS/TvTcR3zXxk+hKler4ChjfBGAH44cfAouga9FUHC+rUOGLRpyY1BAj3lJLkhC6N
         QK9g==
X-Gm-Message-State: AOAM531/waw+ZdAo1dvSyjl9OlfKjwRaHWYrPvmB1Zii5XJdjjEBtpRa
        4Kx7zRmURw+oNnzHXmTMY2eh6Q==
X-Google-Smtp-Source: ABdhPJxwtNebf6IeEa0Jv492IQAbM2vaZWF56FrY2QjO0a1OdHsPeLnw/83uQm6aBdwGdUO12W8Z6A==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr7026992wmh.152.1599218653412;
        Fri, 04 Sep 2020 04:24:13 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:12 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 01/11] btf: Fix BTF_SET_START_GLOBAL macro
Date:   Fri,  4 Sep 2020 12:23:51 +0100
Message-Id: <20200904112401.667645-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The extern symbol declaration should be on the BTF_SET_START macro, not
on BTF_SET_START_GLOBAL, since in the global case the symbol will be
declared in a header somewhere.

Fixes: eae2e83e6263 ("bpf: Add BTF_SET_START/END macros")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/btf_ids.h       | 6 +++---
 tools/include/linux/btf_ids.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 210b086188a3..42aa667d4433 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -121,7 +121,8 @@ asm(							\
 
 #define BTF_SET_START(name)				\
 __BTF_ID_LIST(name, local)				\
-__BTF_SET_START(name, local)
+__BTF_SET_START(name, local)				\
+extern struct btf_id_set name;
 
 #define BTF_SET_START_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)				\
@@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
 ".size __BTF_ID__set__" #name ", .-" #name "  \n"	\
-".popsection;                                 \n");	\
-extern struct btf_id_set name;
+".popsection;                                 \n");
 
 #else
 
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 210b086188a3..42aa667d4433 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -121,7 +121,8 @@ asm(							\
 
 #define BTF_SET_START(name)				\
 __BTF_ID_LIST(name, local)				\
-__BTF_SET_START(name, local)
+__BTF_SET_START(name, local)				\
+extern struct btf_id_set name;
 
 #define BTF_SET_START_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)				\
@@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
 ".size __BTF_ID__set__" #name ", .-" #name "  \n"	\
-".popsection;                                 \n");	\
-extern struct btf_id_set name;
+".popsection;                                 \n");
 
 #else
 
-- 
2.25.1

