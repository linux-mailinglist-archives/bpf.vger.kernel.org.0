Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6864DA974
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 05:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiCPE7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 00:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiCPE7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 00:59:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC017AB5;
        Tue, 15 Mar 2022 21:58:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C84D25C01C8;
        Wed, 16 Mar 2022 00:58:17 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Wed, 16 Mar 2022 00:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=czcBjoVsqPPg39vO8apkGg+bmRVVIBuPLCt1OZ
        YyodU=; b=DWViUI6mvGCcx57kSprQy1T4IuOkxOXGPdemR2vBoR9tVOd6kvjtu7
        MtQbZ8hnY92KABpFpMhKlN5HWCM4yMzen7837WiSyJqHAPgD3Ijbw12/5QGGm36i
        W+SOAQu1VOYvz+xJTklVOkDKNQutb/U/IZ2WCPasDZv3wexfxDj1KcUHyOI9iBeU
        Ic03KxItahTtON2LbrLGqIp4RiNJ1iZREPvqMXBRPi6yTYjUnroQ2O6pk/bQ+go0
        COyZOkDmL4YPUVGL5Z0YI1dVLboLPrmD/tm8FM9HvhQeDo3YDzuOhPMt+Q5dKBOg
        /vK/X3Jy7t9x+JBtQV+N0G5j11NImmaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=czcBjoVsqPPg39vO8
        apkGg+bmRVVIBuPLCt1OZYyodU=; b=iFcVYd0PwPp9KtUZurPx35+RZSeB7TDl2
        8JJr0DuSuDSHe9AaaNEJKjfqGuj1EEr9QOype84mvKsmH0j1i/kQ/Irm5LuExtbc
        ya1pXtpcEbV9zt7R0FfXA1HVvfcMo2/UkeTe451ThNIj7MWPHdqSPLDE7NKCd8gK
        BCchnRwXjAc33GwBcnW2QURr5sJ6lWWRTAIrMJ9oa5g4mOMuJhX5hMPSNf8Xn6hB
        9pvzTbXo6n0gU2l8AWd9sjG/Sy6rlwnvZ2caqIi/ftmhvYtsvDCswbIt3wQwroEZ
        8UgEazRC94yQbJ2SgXUVWER6SHZPmxNJBB2vGpuQot6inKGMrkn8Q==
X-ME-Sender: <xms:aW4xYpzDdo5ZFw7f_67cq1K0dxKDVSHIpGPvGExCFSCVPFdu8q3tiA>
    <xme:aW4xYpSNFUDXMPOKzcTv1d2fVI7Ys96qaCfwJz-aut7O3Pssz0hcJQFHWkkXENQ63
    Jm79TD_aFci_hlqGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepjefgveethfejlefgfedvtdfhffefuedtffegiefhkeet
    feehffegiedtieefhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:aW4xYjWYMHpuQNnqZh_wvIOws5kcLrA4QltQrUKMp-lRcxW2tG66Fw>
    <xmx:aW4xYrjYLztHbJUQjVFNnEN1B4qaddfq7bdxCCHhKGFC_Lu0cLW5pw>
    <xmx:aW4xYrBa-MURkSyYHXbkHJcokKfSGJ7MXRcT7dCM9ljxrzpCJlJ_Qw>
    <xmx:aW4xYiPl7BXQJFKmS4MyVfWGBSeawgTdkD62EvlP82xdQ6_g9H5MzQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2511C2180085; Wed, 16 Mar 2022 00:58:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4907-g25ce6f34a9-fm-20220311.001-g25ce6f34
Mime-Version: 1.0
Message-Id: <35ee9669-6ae1-4647-8028-eb7c82f10dac@www.fastmail.com>
In-Reply-To: <CAADnVQ+bkyPPA9r_n+A7VeYQch-fOiPDHGO-2EZ1dhgva8GF8Q@mail.gmail.com>
References: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
 <CAADnVQJUvfKmN6=j5hzhgE25XSa2uqR3MJyq+c=AGCKkTKD05g@mail.gmail.com>
 <53a71699-3ffb-4a49-9d15-7fe4a0f51612@www.fastmail.com>
 <CAADnVQ+bkyPPA9r_n+A7VeYQch-fOiPDHGO-2EZ1dhgva8GF8Q@mail.gmail.com>
Date:   Tue, 15 Mar 2022 21:57:56 -0700
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

On Tue, Mar 15, 2022, at 4:39 PM, Alexei Starovoitov wrote:
> On Tue, Mar 15, 2022 at 4:10 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>
>> Hi Alexei,
>>
>> On Tue, Mar 15, 2022, at 2:38 PM, Alexei Starovoitov wrote:
>> > On Sun, Mar 13, 2022 at 4:01 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>> >>
>> >> A concern about potential GPL violations came up at the new $DAYJOB when
>> >> I tried to vendor the vmlinux.h output. The central point was that the
>> >> generated vmlinux.h does not embed a license string -- making the
>> >> licensing of the file non-obvious.
>> >>
>> >> This commit adds a LGPL-2.1 OR BSD-2-Clause SPDX license identifier to
>> >> the generated vmlinux.h output. This is line with what bpftool generates
>> >> in object file skeletons.
>> >>
>> >> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> >> ---
>> >>  tools/bpf/bpftool/btf.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> >> index a2c665beda87..fca810a27768 100644
>> >> --- a/tools/bpf/bpftool/btf.c
>> >> +++ b/tools/bpf/bpftool/btf.c
>> >> @@ -425,6 +425,7 @@ static int dump_btf_c(const struct btf *btf,
>> >>         if (err)
>> >>                 return err;
>> >>
>> >> +       printf("/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */\n\n");
>> >
>> > I don't think we can add any kind of license identifier
>> > to the auto generated output.
>> > vmlinux.h is a pretty printed dwarfdump.
>>
>> Just so I understand better, when you say "I don't think we can",
>> do you mean:
>>
>> 1) There may be legal issues w/ adding the license identifier
>> 2) It doesn't make sense to add the license header
>> 3) Something else?
>
> 2

Got it, thanks.
