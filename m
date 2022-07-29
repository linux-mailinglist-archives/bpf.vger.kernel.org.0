Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D55855B2
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiG2Try (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2Trx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 15:47:53 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491067586;
        Fri, 29 Jul 2022 12:47:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 992A0320085B;
        Fri, 29 Jul 2022 15:47:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 29 Jul 2022 15:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659124069; x=1659210469; bh=gBa96b9MFSOKIkAQUuKyhWNI9
        gnNQPrOWjHllrefEKQ=; b=DMw+2TH4p+EGsByQMMnfEmDk7MOAFql/S3rJLmwTi
        HDpDD67r+CqezaXRZ5O4nfFC0E5Xfx3QY7YIjZIhGnGF+LLoFJ3T6xy7PgnO3E9x
        uUIMY9B9xs+mYGkoGeHHBHYJcXD+lsg/JTyQquYKD6od99tJmjNBHAXy0cl6aED9
        ZwCIPILC1vCnk4t0+eY3RdbxaEtgftrQLoqy2QjeaAYiuZkAhcAFTrvNJ00kjNaT
        IAFBHf6+WHqTLyy+0/rZ1tmmoQbjrXFIa4cLt1BbwD1WFu3nSAsRMQqqgGteig1X
        +94kR4xUnDhQomxw56iVQ9ao/8skkvP+7fxc+LFbV5/sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659124069; x=1659210469; bh=gBa96b9MFSOKIkAQUuKyhWNI9gnNQPrOWjH
        llrefEKQ=; b=1E4CKwbQ5XIjXKz36456d/ffDHyU/2IwHkMxy/1mNazZ4YvRpdU
        A2ljIqse8I1Vx6yz77SURPN2hJeH4kC0qWCvk8FYJjrXX0elIBNLAyeqSHTiPYt5
        UWHnX/joR8UXq1Mxvb0O9muJne0xSMrzgmRWNte5+UnOeN2S2kTu5ZrsXR4aIpWw
        cNM6XfdGz0l1lBaaj8LnT/PeeMkvsQNTE8v1px+YNwxUzgLkJ9U7mUcw7Swjp53S
        D/9E5Ov+Acey1lzQwZRlRCzQ8MQTOav51rS4ofTppUKzTTdPfV2LjTH6XJetHKI0
        oQP9hpiXNSkabFVFyFkMO7WkVdZHRIJL7Jw==
X-ME-Sender: <xms:ZDnkYvbg_5MxdkoycBIWhETxDpUnmN4KB_i4coJUf2HvI2TkXUKfNg>
    <xme:ZDnkYubozeZg38Zo7jv2EdTU70Pjij4gBHEyEd2mjZfu5nqfK-otl8xwXnWrPGAoP
    Ta6j0KaCWE37e6-rg>
X-ME-Received: <xmr:ZDnkYh8mU2Qk6BYVm3k6viPSfRp_ep3iVOjeZ8PTD5mzPJ1pxbl28redj0vjfPW0tWXCXCfvzMJB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ZDnkYlqBHrdT1_g0_b7eiBGaZKtiaB7Aqh2mmYMwg4XyjTn0Z9oGmw>
    <xmx:ZDnkYqqzb-fq00BTAYrLTtPD3RwgDL2eZ0d2iMCRBz31su013nwGNg>
    <xmx:ZDnkYrTXmHMNDW6TCjxpKIyNvq7fKdMUFfkduHNq7eiOWKz0WhgOvg>
    <xmx:ZTnkYjnrrblwJsKW4BtqWiq15cYh6X6FKN2swtfm8fD7TQKKPYjp1w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 15:47:48 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix oudated __bpf_skc_lookup() comment
Date:   Fri, 29 Jul 2022 14:45:41 -0500
Message-Id: <2c105a1ff3071796189093c536218e44ea3b1aa0.1659122785.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function returns a pointer now.

Fixes: edbf8c01de5a ("bpf: add skc_lookup_tcp helper")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/core/filter.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5d16d66727fc..866ca05f95e0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6463,8 +6463,6 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 
 /* bpf_skc_lookup performs the core lookup for different types of sockets,
  * taking a reference on the socket if it doesn't have the flag SOCK_RCU_FREE.
- * Returns the socket as an 'unsigned long' to simplify the casting in the
- * callers to satisfy BPF_CALL declarations.
  */
 static struct sock *
 __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-- 
2.37.1

