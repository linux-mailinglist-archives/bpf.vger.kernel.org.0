Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5E53726E
	for <lists+bpf@lfdr.de>; Sun, 29 May 2022 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiE2UQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2UQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 16:16:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6854BD7;
        Sun, 29 May 2022 13:16:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C61105C0097;
        Sun, 29 May 2022 16:15:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 29 May 2022 16:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1653855359; x=1653941759; bh=4yxj77r4xtmn7VVg4M5Kx65OM
        Vx5pZUm+BegY1jUTqs=; b=qFVVB8EdYI/9IgSbYsKayEAOkKTcupcNibIro0Pal
        g7jYea+fwsEFrbRG0ohFwgecGlaDmIy/v62MH/qHJlTITYpMRNnzXtHCT3ygObbQ
        uR2vFjbUpSB7Nbs+kbbLR2kNTQyj2VXK4yPyRdwT4/zjTztVHoof3Fgh6s5IuuCV
        Aig+8kVMX+/UA7emAZQeTHlJJgf3KTxLnTJtn1ex/sXPt1JabvoXF6AA63Wqf8Uf
        f39+cvq9craC6HTwYCJQqm/M7GyGQOYbr6oW0jJ+UKWFVbEI0LvyFs9sd6yhdfym
        NxBEYL6guLuwxZqlS8yU0i8ZgCwCuT170POLZT63pon0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653855359; x=1653941759; bh=4yxj77r4xtmn7VVg4M5Kx65OMVx5pZUm+Be
        gY1jUTqs=; b=x65kk18DVeSJm9vKbbAAYk+W6Ho3liePfwKiHAZBH6nWyDk8Jvw
        4TO5VHYi1lijUQD5RjcjMpdFXS6cG6gme/vvK2eyNEC3uUP/3nqLBVqLJy0/jUpF
        dN8TSdoC1bTfHF/LrdxFFUIbOwMBqFBTe4NBnREucKTNTt1AAMEPI6ueVaWkJJ8O
        wZNhCbUczxExfq4BmovbpU6qfNEygM/+Ji17y6LAv9cnm4yXmmYqQheLxAgsFDZ0
        2Zib/oT5CuKdYoYPxvLAH36DJywIvkDPRvI0dTrDPUcirfWQunI8enQC0kdYcVqm
        cRW3AcYo3VKyO2oDRtmWXDRONESTOdXt2mA==
X-ME-Sender: <xms:f9STYvKa3KrRDyaZGZOLlpkhiouPRsGkclMybPRqhUxcIIuW6ud4pQ>
    <xme:f9STYjKBMe4Wgd-D5YkECJIFERka1a8vxivlYsqpvY7zySDcKRjuh1bSr9N3h2bqT
    sAvDW-OdMkkX3fLfw>
X-ME-Received: <xmr:f9STYntGn1LUp2GJ72Vp4O_8AVwYkvjyDUv3uUvoF1AQyOzl01FMDIfDxiB2aUoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeeggddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:f9STYobwai9dcQuLeUHni-PPXrL40xEBTlohxdZ6YW1WeLlowbN6OQ>
    <xmx:f9STYmaRbHC7akBeIj5zolO1BpTOiBAslce8sU8y63789WzSRs__0w>
    <xmx:f9STYsAoyme5Vx15GHrYEfMzqH55pDwg2sYGrUpuISM0JlmNfVS8Rg>
    <xmx:f9STYtXcqmSPTF6pTsDj5jskbBw12Qz98BplBA0G-Qv5BscO-fJorw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 May 2022 16:15:58 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, test_run: Remove unnecessary prog type checks
Date:   Sun, 29 May 2022 15:15:41 -0500
Message-Id: <0a9aaac329f76ddb17df1786b001117823ffefa5.1653855302.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These checks were effectively noops b/c there's only one way these
functions get called: through prog_ops dispatching. And since there's no
other callers, we can be sure that `prog` is always the correct type.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/bpf/test_run.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56f059b3c242..2ca96acbc50a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1420,9 +1420,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	void *data;
 	int ret;
 
-	if (prog->type != BPF_PROG_TYPE_FLOW_DISSECTOR)
-		return -EINVAL;
-
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
@@ -1487,9 +1484,6 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	u32 retval, duration;
 	int ret = -EINVAL;
 
-	if (prog->type != BPF_PROG_TYPE_SK_LOOKUP)
-		return -EINVAL;
-
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
-- 
2.36.1

