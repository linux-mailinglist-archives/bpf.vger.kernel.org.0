Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7F5A1840
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiHYSCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiHYSCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:02:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E96AB06F;
        Thu, 25 Aug 2022 11:02:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z16so6784285wrh.10;
        Thu, 25 Aug 2022 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JVZlynWOLHadDkGpb6xqip5q+dk6r5Nqr1lqxxPuSJg=;
        b=P3+u+73NQi0pKrukaUosIJpXtcy4uEqOFSzu66tok4KXobHKj6nYuOjUleS+B3XyCC
         ZSA3MF5FC1OFj/WdslybEZ9gbZbV4Lpr6vGpU4L+yYA2B9Lwufl73nxRfdlsBzv6+LdB
         IayPAAcwjJGNSw0tAKyHuS8dKyhtzSQBax+qCariiOX+RWucSVu14WnHmT/HQlY7rTX5
         s6MmVsuNoCamNbSxrAIVarDmTGRQzxxYD5cDas4UYu6RnghNIY2GSH6WogwITQK3m1LX
         2GpxuCaJLDObY8JwRvi61NDhWFVe0I2m1m2lAkbUij3jMcCSAGqd5i7t95SQsj4Io4kb
         8Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JVZlynWOLHadDkGpb6xqip5q+dk6r5Nqr1lqxxPuSJg=;
        b=HyEfb51NM7QCzeJWkyR77QkqCx9NOh8nI//gXYG/4CSl9ETcHkyW7Qgso5dLTz4Z57
         9/sDUkGB5SR8ss9T1NrzxV9w2sCKWbmh86gpfoNlf/1HSnP4ruclcJAh5SBK1QgeFW2h
         CbgrSRW5c4iJE999FoIZiULdLTTfLcQSwnryf4lOY3owPX0AFKYITroKVV8wyIwsoqBw
         1GevOQNsMY2yUXfNkef9JcE3JJ5cBQ9PcVPNHeSj63pU5/LGKNVgJbgNBKy3MyeVJOlI
         4fKY9w/bd9E/y8XlYCTH3QM7hsb7ZxL7wqxFqoPQ12mLjqmSecVUKT9r/Eapkrn5/Ao3
         RAJw==
X-Gm-Message-State: ACgBeo375x8+H1/qjohZsvG7QIt5JR4J3fspwUVAcKTRaEjwUJMjbzPz
        LWn/gm9ShSYtfa/Tuh9yf00=
X-Google-Smtp-Source: AA6agR75XvG55zFVAQkaqqDMzbniDIUuI9039QzoceqanMnHnkej1dYO+oyvdre2IrLXt6OAy46e0Q==
X-Received: by 2002:a05:6000:15c3:b0:225:6e25:a9e3 with SMTP id y3-20020a05600015c300b002256e25a9e3mr2985611wry.286.1661450569529;
        Thu, 25 Aug 2022 11:02:49 -0700 (PDT)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id r18-20020adfda52000000b0021badf3cb26sm24725376wrl.63.2022.08.25.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:02:49 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH] Fit line in 80 columns
Date:   Thu, 25 Aug 2022 19:56:54 +0200
Message-Id: <20220825175653.131125-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992; i=alx.manpages@gmail.com;
 h=from:subject; bh=i0YcmwgMyZWKI4KLVYcQlAYzI8nilqOZ6SAGVYhEL/s=;
 b=owEBbQKS/ZANAwAKAZ6MGvu+/9syAcsmYgBjB7fUeDJh8cujGbOwyxbQjPyNKkN3p9UGWgM33RRP
 PSSPaN+JAjMEAAEKAB0WIQTqOofwpOugMORd8kCejBr7vv/bMgUCYwe31AAKCRCejBr7vv/bMr/ZEA
 Camuy5gZ4CNrgsWsxNYBe+5ruNOqtJNy75ff3fvGxQrqfR0nPjb0ieqyso48oW/CPwilLaHI6OQJ/G
 UJMsRWKMG+vubWtyQ+m1ePany3aikCBhlr6wi5qPdBVZNNBW7ASXYCmkmlzHZvZ9Mid+KYynxHUOGS
 W2xK5Xt6AbMe+zJzt6YybZgzkxPrMM5oBcasEFN+YW2GOMmrGpjC/PMJVhFjJ72OKwBoGXGLl+D+AP
 bAxuIYMPVFRDDADah+8JUNxHa6ifDuC8wyHLih78PynxV5HcNx+KIXQruLcqKcUqRMoiee5gy8jOA5
 jU02QNwJKmKhSYMrIdKfyhCjHXanVwY0qniuR7SwleQKGrrfnJ1N86lIC9+w8JauovQuT2mgWOMLdp
 Y6B9qEUBHTljN4+2veW2s5fw6w3iQqY/gRexw2GqgFfRShG8QIbcfqogCn2PKPtKym+BpESwyLci5m
 BCu+dQNv+HbvFu957c4nPMcdn3SLS9LOJoVe3L8DWMTj7W14fXWE4pHWUXOZsLxZO6oiMBPngy8nno
 wohswIOL2JAbQkNMqyzbtHODMn/zcNgvZTAaxm6R6e+DHtKzva57cG/vfP6AKx8ZLNDcl5DRXnbiXs
 5boNCK7Awt4byNL5XlCgb7sgIeJ45XcRmuyElqKBNeH4xVHMykykdCKWLHkQ==
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

That line is used to generate the bpf-helpers(7) manual page.  It
is a no-fill line, since it represents a command, which means that
the formatter can't break the line, and instead just runs across
the right margin (in most set-ups this means that the pager will
break the line).

Using <fmt> makes it end exactly at the 80-col right margin, both
in the header file, and also in the manual page, and also seems to
be a sensible name.

Cc: bpf <bpf@vger.kernel.org>
Cc: linux-man <linux-man@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
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
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

Hi,

We are adding another linter to the manual pages, which lints
about output going past the right margin of the terminal.

The following results triggered in the bpf-helpers(7) page:

$ make lint-man-groff
LINT (groff)	tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch
an.tmac:man7/bpf-helpers.7:3: style: .TH missing third argument; suggest document modification date in ISO 8601 format (YYYY-MM-DD)
an.tmac:man7/bpf-helpers.7:3: style: .TH missing fourth argument; suggest package/project name and version (e.g., "groff 1.23.0")
an.tmac:man7/bpf-helpers.7:3: style: .TH missing fifth argument and second argument '7' not a recognized manual section; specify volume title
114:                        telnet-470   [001] .N.. 419421.045894: 0x00000001: <formatted msg>
2642:                                int res = bpf_probe_read_user_str(buf, sizeof(buf),
found style problems; aborting
make: *** [lib/lint-man.mk:50: tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch] Error 1


This patch addresses the issue in line 114 (that line count is in
the output rendered page, not in the man(7) source file).

I'm not sure which of those files are used to produce the manual
page, but for consistency I thought it was best to fix both in the
same way.

Cheers,

Alex


 include/uapi/linux/bpf.h       | 5 ++---
 tools/include/uapi/linux/bpf.h | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ef78e0e1a754..c03ae39c03b2 100644
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ef78e0e1a754..c03ae39c03b2 100644
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
-- 
2.37.2

