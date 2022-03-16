Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F54DB159
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348851AbiCPNZO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348712AbiCPNZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 09:25:13 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A135874;
        Wed, 16 Mar 2022 06:23:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 447013201FCE;
        Wed, 16 Mar 2022 09:23:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 16 Mar 2022 09:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkourt.io; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=mesmtp; bh=dYa12N5Sg9tXSwbjxJtKclSjJTp
        ajHZmkUfVIRdsj38=; b=kSE4RlqsmHUlUktT1PSYJiifZBMJXmA7efnOjx/hwwJ
        Uy8o5Q4sl/yz4DY2KwKd95VBJ/06Xc8+LhBbSRy9gZ+SnagsUTtJWPnRRIOEi+Kp
        h/oMn5RpJzN1bDrgujfX7bNetJSExCS8D8vULTy+bhYq8a9Igu9vNp31f0cGSn2Y
        =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dYa12N
        5Sg9tXSwbjxJtKclSjJTpajHZmkUfVIRdsj38=; b=Q8MW9/qbn9j5vhUiHHiBPY
        wZj3ebXeZKapMmVBeEceGP7kmMgbcz8vrqw5DR80o+qyZ0zeYnIDZTcdMZLi+Ztm
        9wDaR6wXMfyLUGEn4BqdUSn+4rJ0lOW6arGUpbkirMg69AG5MZoJKPOvRY/6ESd1
        XQJ38vyebIWYGHoxPO27w/GTZLaITGe55O/8vpa0Tds9DbAfztWcV9nO2EFsdAQg
        O3Zhi+6oBTZNjrOh1Bijf3KaA6Uc6OInoHsBBkpnK3EZJ1lpc7FsdM+mlkHJbYct
        q0y+JFYls1OdLmGkapjQ2a1VAEUO4/UFv2RJCppdda1DrBX3kLm1JsB67VzgKZBA
        ==
X-ME-Sender: <xms:7eQxYlHYgfJvfcBe73lbkVpMZ7ZFuCE3S92FFZFODzzFi8pfxl3pRw>
    <xme:7eQxYqX8Q9o6P3S45zPmIc5VIvLF-HrYLHmh6Hx1Sga-1ZtytKn4sZ8laMrgBbHxx
    eu5hV9MZJ8vkW-H1g>
X-ME-Received: <xmr:7eQxYnIoa_kIqP216-nIivS94p2req-tiDgxdJmQCBwi2Nigbv6zOjAcs8Uwl_Iu71QKBluqZhmsz7hIDQkQCVn9xB6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkkhhouhhr
    theskhhkohhurhhtrdhiohenucggtffrrghtthgvrhhnpedtfeeileevgfetgfehjedthe
    fgvdetheetgeeuffejgeekjeefteetgfegffevfeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehkkhhouhhrtheskhhkohhurhhtrdhioh
X-ME-Proxy: <xmx:7eQxYrEQ8uITEuEiOQeiIz7vJb4LgC_5JyYIUV8HDIreWR1qpyEmbQ>
    <xmx:7eQxYrXlfzngyCuzxNbXdZ9CpeBbLxbiivClGD2i2wUCGIa1vnyE7A>
    <xmx:7eQxYmMImJ2N7r1uKz8Prx7h7q3umZEMVzxAUQnyj5XlZYtDaKeZ3w>
    <xmx:7eQxYmT3xVa_rPdk2JWklO0ewz9efk2KU3aFUINhZLCMvK49BAd-fA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 09:23:57 -0400 (EDT)
Received: by kkourt.io (Postfix, from userid 1000)
        id 4C1682541B5C; Wed, 16 Mar 2022 14:23:56 +0100 (CET)
From:   kkourt@kkourt.io
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: [PATCH 2/2] dwarves: cus__load_files: set errno if load fails
Date:   Wed, 16 Mar 2022 14:23:54 +0100
Message-Id: <20220316132354.3226908-1-kkourt@kkourt.io>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YjHjLkYBk/XfXSK0@tinh>
References: <YjHjLkYBk/XfXSK0@tinh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kornilios Kourtis <kornilios@isovalent.com>

This patch improves the error seen by the user by setting errno in
cus__load_files(). Otherwise, we get a "No such file or directory" error
which might be confusing.

Before the patch, using a bogus file:
$ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
pahole: ./vmlinux-5.3.18-24.102-default.debug: No such file or directory
$ ls ./vmlinux-5.3.18-24.102-default.debug
/home/kkourt/src/hubble-fgs/vmlinux-5.3.18-24.102-default.debug

After the patch:
$ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
pahole: ./vmlinux-5.3.18-24.102-default.debug: Unknown error -22

Which is not very helpful, but less confusing.

Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
---
 dwarves.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 89b58ef..5d0b420 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2399,8 +2399,11 @@ int cus__load_files(struct cus *cus, struct conf_load *conf,
 	int i = 0;
 
 	while (filenames[i] != NULL) {
-		if (cus__load_file(cus, conf, filenames[i]))
+		int err = cus__load_file(cus, conf, filenames[i]);
+		if (err) {
+			errno = err;
 			return -++i;
+		}
 		++i;
 	}
 
-- 
2.25.1

