Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DA4DA609
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiCOXLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 19:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiCOXLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 19:11:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B8B52E6C;
        Tue, 15 Mar 2022 16:10:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B4A963201FDA;
        Tue, 15 Mar 2022 19:10:08 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Tue, 15 Mar 2022 19:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=nKjQkzPzNXMCrBv5rZd2TPMn58+ud5Ed8qE7Xp
        7qsjw=; b=I6RTIHk8Zsx3TPDaTGo0z9yk1uNeRZu6rXreRrxDzhJGmVF6j4Zebc
        sOX3Fqp5Hftz91zOgnwWWc5OZtD+0r1DurynvAZx7NwmBQxVcLUIVPzGjAmPkImL
        ZLF03vNpZdgRBO2qkfZphUPw/u09eBJRIM22kAPvbzqTfwd0qFaJDRpn/YsOE4UY
        MALX+yza10fyv1tranZKcofbu8EmviCW7eTtgFQ3Ue4boMucKWSvxIauA9a4J6W9
        FShl6MCd1kOh+nHoag9LEghs9fahZuSJXIsZdlVDqUEIR8oWiT5C+bb2XiuC9UHO
        ijXLonXBAY94TD4AOcUJaDk6nFSehLbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nKjQkzPzNXMCrBv5r
        Zd2TPMn58+ud5Ed8qE7Xp7qsjw=; b=Pv2ucQTI4Zdi0OnPFmDaADIFGCJLisE1y
        bKY10UyrYlSnck3aUDvFVGHQHT4NcKeFX5IIT0lXk648lFpcqacAecvux6mDmIxI
        1Vz9pU6ZCdkawh6eP64W+NK0YzQMCcMl5lB3oi5t0xyiyD17cx0+k89X+/39z1jZ
        hkFsW/ZmpgJ61BShkc5T0NW1AWjy7ODaJTYA7qDMQGUX17UOZuCkaaB/P8z6nlFZ
        4XnHMvl4nAgJfHMp38VnofcwitBW33AH8S9nkUD/myx+7aufIWLxGvt8/O2a4oQM
        Aw5q/yIb9XZlk9ERKoXfP4d61Oi+85pm+YSBX2FfZDywB2NJT/0BQ==
X-ME-Sender: <xms:zxwxYmOuWPrrNuiV8QHiAGFyRNAYYQvQBd4UkNpO8FfijhcRirWy_g>
    <xme:zxwxYk9OqSlAQs_vMeRB-hrka4VmTKeVSw9f8Vj1SdRZAEoSQmIJlDu1dJMA415x6
    Lgo56aHr3S4rBebog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepjefgveethfejlefgfedvtdfhffefuedtffegiefhkeet
    feehffegiedtieefhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:0BwxYtSppYNR4g_8PKGitE7oKBeFJAmwtVmxBi7U3WUBlj8CGg2tfw>
    <xmx:0BwxYmszcZA1h1IbQhQvarFHTzfIbOz4nrmZI6rP8HEvCnlU1wu5Eg>
    <xmx:0BwxYufKTKFJb1PMAE4HKi3YNt5rCXKVDNScLXMNYh4M7Z9hLBuw1g>
    <xmx:0BwxYu64tOhGQtgrjDC04enJsSUbJdWa6EIqAsIAcY8r1q53DWH9ZQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E13882180085; Tue, 15 Mar 2022 19:10:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4907-g25ce6f34a9-fm-20220311.001-g25ce6f34
Mime-Version: 1.0
Message-Id: <53a71699-3ffb-4a49-9d15-7fe4a0f51612@www.fastmail.com>
In-Reply-To: <CAADnVQJUvfKmN6=j5hzhgE25XSa2uqR3MJyq+c=AGCKkTKD05g@mail.gmail.com>
References: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
 <CAADnVQJUvfKmN6=j5hzhgE25XSa2uqR3MJyq+c=AGCKkTKD05g@mail.gmail.com>
Date:   Tue, 15 Mar 2022 16:10:46 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpftool: Add SPDX identifier to btf-dump-file output
Content-Type: text/plain
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On Tue, Mar 15, 2022, at 2:38 PM, Alexei Starovoitov wrote:
> On Sun, Mar 13, 2022 at 4:01 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>
>> A concern about potential GPL violations came up at the new $DAYJOB when
>> I tried to vendor the vmlinux.h output. The central point was that the
>> generated vmlinux.h does not embed a license string -- making the
>> licensing of the file non-obvious.
>>
>> This commit adds a LGPL-2.1 OR BSD-2-Clause SPDX license identifier to
>> the generated vmlinux.h output. This is line with what bpftool generates
>> in object file skeletons.
>>
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>>  tools/bpf/bpftool/btf.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index a2c665beda87..fca810a27768 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -425,6 +425,7 @@ static int dump_btf_c(const struct btf *btf,
>>         if (err)
>>                 return err;
>>
>> +       printf("/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */\n\n");
>
> I don't think we can add any kind of license identifier
> to the auto generated output.
> vmlinux.h is a pretty printed dwarfdump.

Just so I understand better, when you say "I don't think we can",
do you mean:

1) There may be legal issues w/ adding the license identifier
2) It doesn't make sense to add the license header
3) Something else?

Thanks,
Daniel
