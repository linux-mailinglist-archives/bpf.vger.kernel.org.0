Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0802558DCE8
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbiHIROP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbiHIROO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:14:14 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1724F18;
        Tue,  9 Aug 2022 10:14:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E7AF432007E8;
        Tue,  9 Aug 2022 13:14:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 13:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660065251; x=1660151651; bh=J4
        gpiV71j0xKQ3FtJFMd2wIZaka/D1TIWpUk5i2bNWw=; b=jESG/Hpr8Q121hxrB7
        3p8jpraFEzmRUnx2scQOkcwk3Hp0JYaxPri4/XMj87PA6yEk8ULRV0T4uOVy7/NP
        SZNPo4+ah1TQDk9k1+P3OFfi0GDbWYzZmghufnz/LSQQERvNY79QAoOUR+4N3xqJ
        5NXDgbyID59kBDlTQqi4uK2zoRtdiwQaFDQ8k0tjyxejjBYGCj0Q07K8hytZpl6Q
        tAiOtO9T44q0KCyFK5jygSzMhVHeDz7CEhEhxW8pv9LcK4uVtpkSHl6KfY8m0J0j
        ixKlPKP3nWYQd7Va7i+MJRpCALwnE2dODHbkH5B8dRTolYV5Rtqt0+zHC4Kf6WWO
        qaEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660065251; x=1660151651; bh=J4gpiV71j0xKQ
        3FtJFMd2wIZaka/D1TIWpUk5i2bNWw=; b=FThzYY0uIS5SIPv8vCNy7LkRFdpGH
        ASVbigxf79HR/4oAFlHi69N9DNwRbDJCddqG+vhslB5l14f5jxiuNNeZMnZt/87n
        yb2iLjdKgG+ThhIQGj/ni7ZQbb99QvKHqSKxGrzvilyj7echnAFQQ0xP4LDMl9zS
        pXdraZbyBPAiwNM4fIx5hXEw8Zv8vFJkqBirUEXeEcPONp8Cen7OommedeAFqAnk
        E4iTZ+tsxov0uNnwQX3n3NSgm3qthsSbapFxQ9FtRAXgDJGTDa+w8UHG/DCi1MHz
        O4QclSCbQq+T1Opdg5hXrVYaLmVE/29fIgJdJAzWZGjZ/6bZbiF1DqVdg==
X-ME-Sender: <xms:4pXyYg9w5aB-KACNIXIywemVt3KKCb0a1vYHBCdnGJY-oB_2YBKGgQ>
    <xme:4pXyYotMKDywonsH_5keXBl6zJ91gnO0vqJfnKquBHOn9qOp8O9RlefqUelPzoYT0
    iTiJVSJYFJeHbfHOA>
X-ME-Received: <xmr:4pXyYmDRcePklYRu7yOooIZNtArw6iaoyjRemhcKb7gFG_7GWgplLdKOcCkLGpocSqDPtcx0fcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:45XyYgfS9aK_p9Fk7REePY5A4XuGox4bMqg4W3gnf_geuMFvPbbKRg>
    <xmx:45XyYlN7FCrIWB9Ea3xApwQABgJ3mnwSxhxj_eW5qRfb4Vsho2w3JQ>
    <xmx:45XyYqmw73yxL0CoxLZzrSqEOGIW_aiolEpkl--KTv4KBfdVPCQ3Qg>
    <xmx:45XyYo1U0l4wi_WMJtpZ9L6VhJ8q2ul5OnJ9o0_kBP7-xZzu6STPGw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 13:14:09 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix vmtest.sh getopts optstring
Date:   Tue,  9 Aug 2022 11:11:10 -0600
Message-Id: <0f93b56198328b6b4da7b4cf4662d05c3edb5fd2.1660064925.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660064925.git.dxu@dxuuu.xyz>
References: <cover.1660064925.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before, you could see the following errors:

```
$ ./vmtest.sh -j
./vmtest.sh: option requires an argument -- j
./vmtest.sh: line 357: OPTARG: unbound variable

$ ./vmtest.sh -z
./vmtest.sh: illegal option -- z
./vmtest.sh: line 357: OPTARG: unbound variable
```

Fix by adding ':' as first character of optstring. Reason is that
getopts requires ':' as the first character for OPTARG to be set in the
`?` and `:` error cases.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 976ef7585b33..a29aa05ebb3e 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -333,7 +333,7 @@ main()
 	local exit_command="poweroff -f"
 	local debug_shell="no"
 
-	while getopts 'hskid:j:' opt; do
+	while getopts ':hskid:j:' opt; do
 		case ${opt} in
 		i)
 			update_image="yes"
-- 
2.37.1

