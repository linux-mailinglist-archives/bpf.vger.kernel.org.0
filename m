Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89865EEE0
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAEOhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 09:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAEOhw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 09:37:52 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 06:37:49 PST
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4359337;
        Thu,  5 Jan 2023 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1672929467;
        bh=3tPdRO47uzjqDz/kcaWbYMUahaQxKcrA7demosetVcM=;
        h=From:To:Cc:Subject:Date;
        b=Nytg0sCgJ9JBlCaoTuZwG3RHCB72oHHlHRpcNieOLjkD5nzP79pz/NFihnB4r75s8
         2c9GOhZ27bMWWMIwtENz4TPd607x4hKzfYWRPEr4KcHp+nEeuYMitIy6eHkXWyR3UW
         u36yft5+MkqPk9FLh+qsBC1AkOdXfK8SuJGgeBRw=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 92383400; Thu, 05 Jan 2023 22:36:35 +0800
X-QQ-mid: xmsmtpt1672929395tmioqcc4u
Message-ID: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
X-QQ-XMAILINFO: MyHh0PQai9FptsYZjeGyA4xOuh2HhEr4BPPfP44xe/bb/TVbOgidXF62o1O4I7
         LAtNMi/1Hg7Y0HP8Ne/MEc8nF5IzSU3Ben/9WWffdHB4cNn5YNHy3BnUPoI0dk8p24/bBzUyKyJr
         d2UStuh1Ep5rqzDC4uBHmsXngjkSLyVGC46XjHLWG63ZY8kGv7JHlbaOE2FP92EA/WsN9QkooKe/
         gcp5bSuavwxWqbGcDotO33swBHcnTqAmfYfLDj9ccUxugi+4gGIdSeQ0actBGDQ8NnyUmxTfhnXU
         W1MUb6JrF6e/NF2pHTpTqo//VhdVy/vbbfvc+0Yqt7K0gxTeKpYoZ0bfejTH0013PQDkREa1zafp
         ojLTbCrzKpBGaSqMMnpQA6gsZ/YAdoTTlcYv/qTnbnEDFFqcFFI6o34bU3rO0C3xOk5tf0zLfOrJ
         8AwtgYAbw4ZBJl2tihHKuavLrPincuKbUljN/7iWvZ9cDcRDkTRriTsO8S9n+fOqQsqC5MFcTqGd
         LbAsuunhWSHQ528XstyU92wYrhUtj+uD7UynuAVdw9coHliJs3R71S02/TcUIn9amJ+Cklv5fHy/
         2pREbTVcFivh6fyN1ls4PrtrblNObWyoeRmBhiGCVahwcPm9ClsA3jR2UQRXEv6/ogp6M152YSMF
         7wN/n5Bz1D9l3nblzbul0Ya55yVvCywjIEzIaNdF/PNjSHVZHYbVdzsNLkOtccjqoGNpeMyCOHey
         IeoY/RJtmXQxYMMsd2xNhoFPPWLW5CITuj35apGpbJtKnmxg/TrVNGXzkVPfHWV5RfXJcefH5uS4
         bjFqfERw1BDTUHXJ6nEDUXzzXB2v1zOIXEimKvl+Ghwnqaf08xpOEvwiA00niwsYQTZF9xg2Km9Z
         yvVEdZ+veBZLRdxXv0m28g+IeJ7S/Pa++EuZQoeHPmf6ayr+DQ9V42YqrqLZr97oqb+j3OoiESwB
         hp7mSaaOKimFWRC/pb3H+vAW2tWtW2
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii@kernel.org
Cc:     rongtao@cestc.cn, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] libbpf: poison strlcpy()
Date:   Thu,  5 Jan 2023 22:36:33 +0800
X-OQ-MSGID: <20230105143634.119201-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and use
it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a poison
list to prevent accidental use of it.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..2d26ded383ca 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -20,8 +20,8 @@
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
-/* prevent accidental re-addition of reallocarray() */
-#pragma GCC poison reallocarray
+/* prevent accidental re-addition of reallocarray()/strlcpy() */
+#pragma GCC poison reallocarray strlcpy
 
 #include "libbpf.h"
 #include "btf.h"
-- 
2.39.0

