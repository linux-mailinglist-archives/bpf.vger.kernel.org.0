Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015946790B0
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 07:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjAXGOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 01:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjAXGOE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 01:14:04 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2583B3D1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 22:14:03 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E66AC5C009A;
        Tue, 24 Jan 2023 01:13:59 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Tue, 24 Jan 2023 01:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674540839; x=1674627239; bh=OHeakAvdrJ
        ozaor8twIeGSvdVOvlpO6weQ4WKC9e3Bo=; b=j38JFLXz/r58wRYuDm8AMwuCIA
        uYcIOSueAwnNbnt3iw4IkGeJ2pf5dYoULIDFkCget9Z4YhudI7WoX/kBNSNbn8Iz
        TDjUJZNprE8wnYOEgbaz7e0ce5McgWo4ap6Bn3ZcLrn7oftGRKPh/PaGsLHnNjcY
        0WPo1NITef/PbF82G0rT5jvogtXguQeQQ9nfFt/X+jfIKglL4yWaVIjIYQTL1M7z
        /H11q55JhvduvwG8LMKN/GZ5yGSXBEM02xoQeF8b4NF0wtaXm4IfuE4uGSNRctmc
        oBfOLjpiHTiyTC0MDgBEtPQj+8VZ5WZ4UPmp3tiIZhKS+aNG913lAqMYkyQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674540839; x=1674627239; bh=OHeakAvdrJozaor8twIeGSvdVOvl
        pO6weQ4WKC9e3Bo=; b=CenBU2Ayi+Q7p/ETTLfDpZAMcP/aVqw7zBFT0EFEdGTV
        vj7X4CipFZITDoXOF5DTHJLM4vDrVgz4vMddVGK1ddy1VRnUYF61R0J5L3Hd0e6Q
        C9/q0JOY8gtJK0vDeREs/PRXtRDNFGDBbyVOz+TpcKyl5kgMrl85cWZ4Ook06kCE
        6bfAHrRsIIxr4uKZmbqRXaI6i2LiiieZ8pWBRfZ2TJvIgVuPiXDt4ZwjKILVenIt
        Oo3NVnMQRR3rsEqxima8tsKzVO5iKIl2XuHnXva3ZT5lMlwcvrK+C4V5Qg97cZSy
        5cFHsogd6IhoC7zuV0gUz/MGmmpjO3OyIqIEQfVDzA==
X-ME-Sender: <xms:J3fPY7JbkXSIU8KwDFCy3cVSiUVprg6aKQBMJ34WiXXsNIqqfDeyvw>
    <xme:J3fPY_ISVGbF9OUwDMfCfgLi3DyVn-QxzT93-wECpOGd57kc5WqMdKbc_gGCO1jL4
    16JnnXiHg_XnIj2EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeelteehueduheetheduvdekiefgtefhfffguedvveej
    geeuleelieegteelhfetueenucffohhmrghinhepkhgrlhhlshihmhhsuddrshgrshdpkh
    grlhhlshihmhhsvddrshgrshdpkhgrlhhlshihmhhsfedrshgrshdpvhhmthgvshhtrdhs
    hhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugi
    husegugihuuhhurdighiii
X-ME-Proxy: <xmx:J3fPYzvVSWUtN7MTjq63bu2sc6aqMtotjGGTfjMIcBr0KuOSG-kFLg>
    <xmx:J3fPY0Y4SneT5QRDyCJi4xd9sIhMQ9FEQueNELcXs7Cns6CV4l40dQ>
    <xmx:J3fPYyae9El9uEwVFfqeNxAuNNYUF4sO5xV-QrTWxAQpT7rUVtJc7w>
    <xmx:J3fPY7A-yIgABfciwswaHgYmrcvBcM_SMZa9fHh8x4zi-mLQrRnoVA>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A8515BC0078; Tue, 24 Jan 2023 01:13:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
In-Reply-To: <Y85AHdWw/l8d1Gsp@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
Date:   Mon, 23 Jan 2023 23:13:38 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Jiri Olsa" <olsajiri@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>> Hi,
>> 
>> I'm getting the following error during build:
>> 
>>         $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>         [...]
>>           BTF     .btf.vmlinux.bin.o
>>         btf_encoder__encode: btf__dedup failed!
>>         Failed to encode BTF
>>           LD      .tmp_vmlinux.kallsyms1
>>           NM      .tmp_vmlinux.kallsyms1.syms
>>           KSYMS   .tmp_vmlinux.kallsyms1.S
>>           AS      .tmp_vmlinux.kallsyms1.S
>>           LD      .tmp_vmlinux.kallsyms2
>>           NM      .tmp_vmlinux.kallsyms2.syms
>>           KSYMS   .tmp_vmlinux.kallsyms2.S
>>           AS      .tmp_vmlinux.kallsyms2.S
>>           LD      .tmp_vmlinux.kallsyms3
>>           NM      .tmp_vmlinux.kallsyms3.syms
>>           KSYMS   .tmp_vmlinux.kallsyms3.S
>>           AS      .tmp_vmlinux.kallsyms3.S
>>           LD      vmlinux
>>           BTFIDS  vmlinux
>>         FAILED: load BTF from vmlinux: No such file or directory
>>         make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>         make[1]: *** Deleting file 'vmlinux'
>>         make: *** [Makefile:1264: vmlinux] Error 2
>> 
>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>> (2241ab53cb).
>> 
>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>> upstream pahole on master (02d67c5176) and upstream pahole on
>> next (2ca56f4c6f659).
>> 
>> Of the above 6 combinations, I think I've tried all of them (maybe
>> missing 1 or 2).
>> 
>> Looks like GCC got updated recently on my machine, so perhaps
>> it's related?
>> 
>>         CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>> 
>> I'll try some debugging, but just wanted to report it first.
>
> hi,
> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>
> there will be lot of output with patch below, but could contain
> some more error output

Thanks for the hints. Doing a regular build outside of vmtest.sh
seems to work ok. So maybe it's a difference in the build config.

I'll put a little more time into debugging to see if it goes anywhere.
But I'll have to get back to the regularly scheduled programming
soon.

[...]

Thanks,
Daniel
