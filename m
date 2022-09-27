Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B525EC4BC
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiI0Nl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiI0Nl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 09:41:57 -0400
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828C80496;
        Tue, 27 Sep 2022 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664286113;
        bh=FFf1dHRKhXrk3PKGx9saouG6aqJXZ6yxcjdD4Cnnmd4=;
        h=From:To:Cc:Subject:Date;
        b=fgy/9PIgVjbtaAckRGcJrVryjJYPFzMjgsy+x5cai/ahx3ENTpBMEiymK/EOX2//e
         sHDh5iHekQwx93f9laob0vpx5c3/qjwqhcbjMoMuBzC8qoUpfnq+0ruM6qAOacRF6q
         RjhAWO+h7pQHBIh77C6W9y20c9BU0zELyM2qP1bc=
Received: from localhost.localdomain ([111.199.187.40])
        by newxmesmtplogicsvrsza30.qq.com (NewEsmtp) with SMTP
        id A71BFC6D; Tue, 27 Sep 2022 21:41:49 +0800
X-QQ-mid: xmsmtpt1664286109tkdbqhgo3
Message-ID: <tencent_4BD12CC4558335A1CD2C9B4B22159957D507@qq.com>
X-QQ-XMAILINFO: M6WIou+qBrFGC/Uh3QoYUE0UwOdjV4WTAOVayaLj9Yjuwd5jzCPmSlV1xJZG7G
         kCwty5ehZ2w94OMd4dpIJFoijPsGoB7IRKrPGCb5hot6by2TsHLtKwRVJNSTQ9W35ey/4moZeCgg
         vn0N9S2lAOsdhH7bUhpbAwc60IX92qhuMRNZWSHhI8flanJ6dqdtZoCFpwAOGiCvzehEwZ3P0gta
         rgM3q5st6brv3M9qeY+zHnPOrXvA25QSy5mhiy9qlIvpgLp8SePQsfuMkZ9txlqcz4kyrL1o33Cu
         5J3bVCMAJfP15z0SlD7Lp95jruLYytYBBer+AYZdwdwFx/XqN+gnbn7+gTsRONfFTeDrUT+Rfeyh
         7fXnM2Sbabslmi00zIb3PlxaxSLv5POxdqyTGaREJR5RW8amIZqwmsw3DH7qJUaXKkMXljLFEPWR
         TNkWeA9rohkWLJvkYe9xy6PGPVL36VA6dJdqQEUtpUGzqqYzhJYArmW4DvIjNQMON36iD2k1YlOa
         btKj5M5+Zz6ZZT09+Iaq5rNNIAuZqdOpVHiIUXj95mbyt3kZ7pIZpU5X/4JGIWXnK8ffxg1hkxqc
         UsH7/GMd0XX0vO+8bGz/BHyvGicTEycgP9JPmJHNs3lwXiradQivic3QVVlkvJ1apBn7RjmT4MWA
         tvmhc+rMkL9DupSp6U1BQWApoJZHUJswSVP2YgnLTMJz64uDhxdbopMNpPgpT/x4TUVoSNS1KkOt
         bUqlieFCfhKIMcz8mHfng16JC6AfW6X72dSF5ZmXybaeq5PaPjLUoMkD8oPBJGs0zY2rMY8egYUS
         XpKgBUKxbKzUs1F6aXwvYgCylgfz9/DtYQYWljNZ0wGae+AmwVSBYWA6Ce3xDFau2plPbvBUiHMH
         GUm9mesdhvVl5wZljV8PAXuK2U8kvOWdxLB+eaNFdRBUjEVuZkxS8hd5WSp6JSwVgC6wZUfYoMiE
         iaR6zYnEA8L+i9HQoRbFqSeFGcLvT4ypdJvqOfQJ8TVBqAdrdQbg==
From:   Rong Tao <rtoax@foxmail.com>
To:     rostedt@goodmis.org
Cc:     Rong Tao <rtoax@foxmail.com>, Jan Kara <jack@suse.cz>,
        Heiko Carstens <hca@linux.ibm.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:BPF [MISC])
Subject: [PATCH] samples: bpf: add CONFIG_SAMPLES_BPF
Date:   Tue, 27 Sep 2022 21:41:47 +0800
X-OQ-MSGID: <20220927134148.17503-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
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

Add the entry to samples/Makefile to put this into the build bot
coverage.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 samples/Kconfig  | 6 ++++++
 samples/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 470ee3baf2e1..f436e3616226 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -6,6 +6,12 @@ menuconfig SAMPLES
 
 if SAMPLES
 
+config SAMPLE_BPF
+	bool "bpf sample"
+	depends on BPF
+	help
+	  This build several bpf examples.
+
 config SAMPLE_AUXDISPLAY
 	bool "auxdisplay sample"
 	depends on CC_CAN_LINK
diff --git a/samples/Makefile b/samples/Makefile
index 701e912ab5af..a15d691a6817 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,6 +2,7 @@
 # Makefile for Linux samples code
 
 subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
+subdir-$(CONFIG_SAMPLE_BPF)		+= bpf
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
-- 
2.31.1

