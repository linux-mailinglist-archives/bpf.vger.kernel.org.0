Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC557CDB8
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiGUOcm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGUOcl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 10:32:41 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4685D40
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 07:32:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8249A320093C;
        Thu, 21 Jul 2022 10:32:39 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 21 Jul 2022 10:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1658413959; x=1658500359; bh=d+wMcGL9vVMgIKHl7WfNA2IbpNJZo+pqTly
        MAWc2dZw=; b=ZXRcaRLLMci1tvvooXJ44M4nUzC0C84NxuUmOUlEOu3MB4vLUmr
        DmduznJriXWNGa1ikurfkA4Js4hpYd/gg8vvIXO5Nt5YuUr7galg72iGayA6od04
        PIjhDull4JnTJ5eNL18mHJ/RRRh4+sKFfwzxKyS6unyJRfzTHrTzNyVYJMBF6x7F
        09kmU3XAw+5jHTJQ+si/3+mJdYpI0ALa9gBpZQ8vGwh6q7Kt52q0N6bSBsWXYQUu
        2vcBWX1WwDuNB+BWrJ9on66eLTvZeYthi8jlzhgFh0uBPdAVMt9oCAx3saeCCStB
        J7Ac4LqzXeH3ePLa0HJb51r34d3Rw8o/3KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658413959; x=
        1658500359; bh=d+wMcGL9vVMgIKHl7WfNA2IbpNJZo+pqTlyMAWc2dZw=; b=1
        riaEIDGTOS2sNO9fNJPXtnng8U0VAaSho9llzmz8TQzKaNx/lfLngSgSkvZeoGJa
        ideoqugQIyAVbtYL5BDnesOHkIis2d/Alazns7FMXSb77EZ6U/TNngqhCBJtLbmo
        81RExTeVyhhBmUKFtmuS/JQX29glxhrxWbxkfTiCzYUV9RhfqdQTMgCXJCc8WTuw
        TObTUaD3YyxfyytvfkxOtMnMT1KfXHmqtglvt9FImQx+4vpXUpw4aSWmecRe+I65
        WkkbAsSQoTC670OPDJk8IsXngB7vur93ii6MCu351BSM2SO6J6IgiwljxP7+io+P
        EvwpOAwXwQH7yJyKc7iRg==
X-ME-Sender: <xms:hmPZYoOLcfX65XbWtkc_FGaAm_csPKWYC8N7y2aQXLFFnVbm3MUkzg>
    <xme:hmPZYu80agONk_V-_cJkIaRdBGzwtooKSgLH0wR36PICGGoK2dPGm47fOrfTezK8w
    kqeZvBdClEo7BlpNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddttddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfnfhorhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhi
    oheqnecuggftrfgrthhtvghrnhepgeehteegheeuffelhefgvedugfdvheeukeeutdfhvd
    etveeltedvhefhfffgtdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhtrggt
    khhovhgvrhhflhhofidrtghomhdpshhouhhrtggvghhrrghphhdrtghomhdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepohhssheslhhmsgdrihho
X-ME-Proxy: <xmx:hmPZYvSbe-XCwzzYJ1bv33PH84R0U-iwkG0DZRK1PyFZKSUy_yVrBg>
    <xmx:hmPZYgsLkmWLcVzkw26fkHpA9ZUys3WT5D_VtEsJK0mJEypbM3SVJw>
    <xmx:hmPZYgdagmmPYCWEuTeHidUqJlltIQA8dDAJq1er4HIYhl9SifGqPw>
    <xmx:h2PZYonDXJn7QBpcLHx-7VZQCo_QkK_L9cswAu8Z2WhFjli6ntqxyA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C97A415A0087; Thu, 21 Jul 2022 10:32:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
Date:   Thu, 21 Jul 2022 15:31:38 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     yhs@fb.com, andrii@kernel.org, bpf@vger.kernel.org
Subject: Signedness of char in BTF
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong and Andrii,

I have some questions re: signedness of chars in BTF. According to [1] BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL. If I read [2] correctly the signedness of char is implementation defined. Does this mean that I need to know which implementation generated the BTF to interpret CHAR correctly?

Somewhat related, how to I make clang emit BTF_INT_CHAR in the first place? I've tried with clang-14, but only ever get

    [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
    [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED

The kernel seems to agree that CHAR isn't a thing [3].

Thanks!
Lorenz

1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
2: https://stackoverflow.com/a/2054941/19544965
3: https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
