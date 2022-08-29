Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F895A5535
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 22:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2UAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2UAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 16:00:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF361721;
        Mon, 29 Aug 2022 13:00:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so8763305wme.1;
        Mon, 29 Aug 2022 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=O8RhKIZc2yZtz2lAJUXOlbXsU53P4O5YbHxV7ztn1WQ=;
        b=illYhjhFWB7pTcWsXZ7sYKMvl92Ex3/EjGhmOFJ/fafPeg1C67rWXORf8DsuQg93Vx
         O1rBWeqfNb1p0BeT7xDzhhGPeEaXjCC5aKFXmCG2edGZlAfQSXSHfkzsEFKhDrgfmNml
         DQYHHTWwSQXhayyj7kWNwHcUTySz0XNQPEPh7So/7vlPJ++XXDdMQcNwZLtnRiA+Si3d
         mUI5LI747+Sg/HBFTJkEqNItX37zgL2xwrw+X5Fc/By4unhwEVrDceExI/SHhRWO+VF+
         29ofjiJfy4EQtrnDoc0SE61JUvVBlprAKWsfOuTdyJEwx4yqIH5yRMa5vMxTrSnpsr0Z
         06Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O8RhKIZc2yZtz2lAJUXOlbXsU53P4O5YbHxV7ztn1WQ=;
        b=yi/nK/ghb6ulHf6jDw/wtacX5UCC0TeiNA9ODHBGZq+6Xx3p53QxDMUA635XG3Wt4C
         ReLApl3xkPCY4l3YJtbYeNBe9sr7mIFu/Dm3QmJ1irFwz+UgCdZIFj9yKhQaSfidTeMF
         tlQciw8HJ77nYMUbCxYTK8lz9VciyG/NL8CfEcFeCRokSMzFKN7lIHuRUAl9VFPwsAGK
         oaiw8JtkSdvf1mn1QY9wI8dcVsItdp6yX8ybgbEs53yk5+XWcXWhIOAmyQl+rnIe6Z9M
         hUY4zdjObbKuLCbqPFCeYPCRDOlCYl3P68Tdcb9tDBQ0eZc9PM6irpNEjxOuPEbpiOCG
         +RJQ==
X-Gm-Message-State: ACgBeo0vTmrVTlgAP2f9ZDKVUZybyKBFoV0df2MzswQLcwcwn9QkoFmQ
        Bp+0PIzAIpTHqb3O2FrODmo=
X-Google-Smtp-Source: AA6agR4fiTyjRSfl/A1iZbb6uhyJb1CwVrd6qmxTxRHDHm+iYIscnBz1QwW5oNhkorckn9VuoxRerQ==
X-Received: by 2002:a05:600c:3d05:b0:3a5:dd21:e201 with SMTP id bh5-20020a05600c3d0500b003a5dd21e201mr7654637wmb.132.1661803250430;
        Mon, 29 Aug 2022 13:00:50 -0700 (PDT)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05600c3b9200b003a846a014c1sm5273193wms.23.2022.08.29.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:00:50 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
Subject: [PATCH v2] Fit lines in 80 columns
Date:   Mon, 29 Aug 2022 21:58:44 +0200
Message-Id: <20220829195842.85290-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825175653.131125-1-alx.manpages@gmail.com>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4314; i=alx.manpages@gmail.com;
 h=from:subject; bh=SXQKA7DgCgoz0zVpxVE3/r5g24gf6ZrgXIg75ha3hYQ=;
 b=owEBbQKS/ZANAwAKAZ6MGvu+/9syAcsmYgBjDRpw7r3tuY2d7WmsoCLYpljp7VhH48Ik3WYMztV5
 JCCgmeCJAjMEAAEKAB0WIQTqOofwpOugMORd8kCejBr7vv/bMgUCYw0acAAKCRCejBr7vv/bMnfeD/
 9JRdgnXkzJa19u7maUnVQV1Hcw50RBDTUV6vHekiYA/rmxIyL64YZMQ/EuHLIb2gen9MsrAn16UCs+
 06/EJGED3fg/MQ/HI/nlO/mWmhS0u386dTC56AR3p9Lq4w2OmMTPkOUl/See3QC+s9wdVafjvUbQFE
 6dfJdIWZ4GGQNmpqfczpEu0HScIu7zGPnlr0wsu038ev+yfXlK43nIBkykvXzCtnd6LgM4tqlsI4hD
 SXZUGDLf8ozln278Y/lTxT2pQclozNdkIUFlDzxlxrrDhPJcF9MtUKBAlc410ve4N7ZvP2zvIpbF6/
 Jrss42kyghaTWemxZTZCx6r9J/Ad23ih9epO6PxxBOybBHw3/U5r+NA56TlUcLDdPp1lHfvhkRRxWu
 1hcv1lUtA292jbyobhjdilNmRoF/GYr5z2MU4kZzJPP3quwPUG/2Jat8DBEqZeot3lNnlR3oPv6g01
 fbqm90hdzk8sxhoXqLRbuQv//w52g6ihtVh/QcKZpjmcfM+2vNyb9iY/Zf0TLQZGX3LcivUu9eGg6g
 OlCv5cgRCWxwEeg6+9g8ebEnBwCdLGvbkWQ85WIrX1icxXSjRgCdeB/YhLfuGloF/5EwulA59kU6iO
 Uid8lyelQIngr5AnwXXT4NNzP+uPlqv9DHPjffx13e4Xj8rrVUCVJJoezLPA==
X-Developer-Key: i=alx.manpages@gmail.com; a=openpgp; fpr=A9348594CE31283A826FBDD8D57633D441E25BB5
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

Those lines is used to generate the bpf-helpers(7) manual page.
They are no-fill lines, since they represent code, which means
that the formatter can't break the line, and instead just runs
across the right margin (in most set-ups this means that the pager
will break the line).

Using <fmt> makes it end exactly at the 80-col right margin, both
in the header file, and also in the manual page, and also seems to
be a sensible name to me.

In the other case, the fix has been to separate the variable
definition and its use, as the kernel coding style recommends.

Nacked-by: Alexei Starovoitov <ast@kernel.org>
Cc: bpf <bpf@vger.kernel.org>
Cc: linux-man <linux-man@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/uapi/linux/bpf.h       | 11 ++++++-----
 tools/include/uapi/linux/bpf.h | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ef78e0e1a754..1443fa2a1915 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1619,7 +1619,7 @@ union bpf_attr {
  *
  * 		::
  *
- * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <formatted msg>
+ * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <fmt>
  *
  * 		In the above:
  *
@@ -1636,8 +1636,7 @@ union bpf_attr {
  * 			* ``419421.045894`` is a timestamp.
  * 			* ``0x00000001`` is a fake value used by BPF for the
  * 			  instruction pointer register.
- * 			* ``<formatted msg>`` is the message formatted with
- * 			  *fmt*.
+ * 			* ``<fmt>`` is the message formatted with *fmt*.
  *
  * 		The conversion specifiers supported by *fmt* are similar, but
  * 		more limited than for printk(). They are **%d**, **%i**,
@@ -3860,8 +3859,10 @@ union bpf_attr {
  * 			void bpf_sys_open(struct pt_regs *ctx)
  * 			{
  * 			        char buf[PATHLEN]; // PATHLEN is defined to 256
- * 			        int res = bpf_probe_read_user_str(buf, sizeof(buf),
- * 				                                  ctx->di);
+ * 			        int res;
+ *
+ * 			        res = bpf_probe_read_user_str(buf, sizeof(buf),
+ * 				                              ctx->di);
  *
  * 				// Consume buf, for example push it to
  * 				// userspace via bpf_perf_event_output(); we
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ef78e0e1a754..1443fa2a1915 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1619,7 +1619,7 @@ union bpf_attr {
  *
  * 		::
  *
- * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <formatted msg>
+ * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <fmt>
  *
  * 		In the above:
  *
@@ -1636,8 +1636,7 @@ union bpf_attr {
  * 			* ``419421.045894`` is a timestamp.
  * 			* ``0x00000001`` is a fake value used by BPF for the
  * 			  instruction pointer register.
- * 			* ``<formatted msg>`` is the message formatted with
- * 			  *fmt*.
+ * 			* ``<fmt>`` is the message formatted with *fmt*.
  *
  * 		The conversion specifiers supported by *fmt* are similar, but
  * 		more limited than for printk(). They are **%d**, **%i**,
@@ -3860,8 +3859,10 @@ union bpf_attr {
  * 			void bpf_sys_open(struct pt_regs *ctx)
  * 			{
  * 			        char buf[PATHLEN]; // PATHLEN is defined to 256
- * 			        int res = bpf_probe_read_user_str(buf, sizeof(buf),
- * 				                                  ctx->di);
+ * 			        int res;
+ *
+ * 			        res = bpf_probe_read_user_str(buf, sizeof(buf),
+ * 				                              ctx->di);
  *
  * 				// Consume buf, for example push it to
  * 				// userspace via bpf_perf_event_output(); we
-- 
2.37.2

