Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D5586E69
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiHAQRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiHAQRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 12:17:15 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A73C150;
        Mon,  1 Aug 2022 09:17:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CF75E32003AC;
        Mon,  1 Aug 2022 12:17:07 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 01 Aug 2022 12:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659370627; x=1659457027; bh=jSlZW82kJO
        trbsQe+JWb98zS2xjRzoI5vbOs5++NnLQ=; b=j+GWpCvsQyFaFkCglcB0vStu9k
        LNvemfQuROlI50kri4OODR1wwspPqN0P9b/KZ6Mi4pA3nb9vTv/a2XpeCnPz8s1Q
        ZyrOOMAj1vCo3mv7VHRvIm3+ndYLyuqUi6P6Hoeh749xVq0VCMfqQRMB03Y7Q2mp
        5Jk7DVRA2I8TGr11UbdyujuBpZ67/R9dtg3NVwQFAcadZlVFAiMi+o1T/TOkukJf
        60TrbGvISdZiTg+nvlq+ipJfVYOT86qZ5hs4KbneZ/YlFRqDQp57lB+PJFFtlXAJ
        vsfTkDBeRy3Vpi7UUifih3F/Kin4YzkHt/HLZ4FGJvfLgRBKM1DT5azrt90w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659370627; x=1659457027; bh=jSlZW82kJOtrbsQe+JWb98zS2xjR
        zoI5vbOs5++NnLQ=; b=UFLGOg8bmfKGjg6eBmzPiEALlv2ne6zwLHkf6CAKKPTe
        q+WBVhjtEeFcP+knkt4R1KvIhFMF887xyT/yv3L0FHCEM959bUQZJbhwBnh8hA8c
        vGyD20iqFFbli43+jXAngETlBE1fan3wBzYcPJ9TL5mgpCn8TUYtiu1pInOAJaF1
        DXaMg0F8ahp0KFnHzCkGxLEBtyldkcMT81Bm00Z9cfJWsyzQURK9OfcQRSI+1fxi
        NyaxhdYZA9kN4XrAgRW30DmQHbzAreSCUoVWEHe6LTG8QUBx6pfQLfeh5jagFNAp
        /LrCuCh8MPQRpRRiE+JuSYdzbFEapvcma+go5D1UlA==
X-ME-Sender: <xms:gvznYkqjDpOKirvF_YfHCLNGsdf6JyxGZ7xKM0hT5KIT-rwLotCMpA>
    <xme:gvznYqoeHsCzDexZniUgW_xxHQy_rodn9VNwWyP4VrWDRpEY1sLuUvuLDUfDXOSe-
    jZ_Uv5Ny5JaLfT4Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpedtudehudfhveduieeikeejudeljeffuddtieffieel
    jedtudehhfekheehuedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:g_znYpMieIStRIn2GW82fu5o1RUabVAJRoznglkT1kFd_j4lAcFoGQ>
    <xmx:g_znYr42nvQcT5Omno-WOsekr5KvRASGi0_a6ctcE1Xkz74NrrceHw>
    <xmx:g_znYj7H98NjvGqIfdqPzSO3wRyiVQXH0ohybUdDjF01ZwndKYzJ8Q>
    <xmx:g_znYlmKQhqep1_Zew9lQ338OcaWvWBh_DYbnWAHGTygEODgWKPsYA>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EBBA2BC0075; Mon,  1 Aug 2022 12:17:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <6ce70dc2-7c4a-4048-aa45-9954082c0f29@www.fastmail.com>
In-Reply-To: <CAP01T75LMwpz3ZPSUgtX2_RDUhB33djJmJs8W--Qh4H8J9iNsQ@mail.gmail.com>
References: <cover.1659209738.git.dxu@dxuuu.xyz>
 <abd424ee71675e3008acd4a2c1fd136cb7dbf8be.1659209738.git.dxu@dxuuu.xyz>
 <CAP01T75LMwpz3ZPSUgtX2_RDUhB33djJmJs8W--Qh4H8J9iNsQ@mail.gmail.com>
Date:   Mon, 01 Aug 2022 10:16:46 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add connmark read/write test
Content-Type: text/plain
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

On Mon, Aug 1, 2022, at 8:51 AM, Kumar Kartikeya Dwivedi wrote:
> On Sat, 30 Jul 2022 at 21:40, Daniel Xu <dxu@dxuuu.xyz> wrote:
>>
>> Test that the prog can read/write to/from the connection mark. This
>> test is nice because it ensures progs can interact with netfilter
>> subsystem correctly.
>>
>
> Commit message is a bit misleading, where are you writing to ct->mark? :)
> The cover letter also mentions "reading and writing from nf_conn". Do
> you have patches whitelisting nf_conn::mark for writes?
> If not, drop the writing related bits from the commit log. The rest
> looks ok to me.

Ah good catch, thanks. I've neglected to actually test writing to the mark.
I'll follow up with another patch to enable writing to mark and testing it.

And in meantime let's just change the commit msg on this patchset.

I'm in the middle of a move right now so I probably can't respin the patch
for a few more days. Feel free to edit the commit msgs. Or I'll send it again
when I set my computer up.

[...]

Thanks,
Daniel
