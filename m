Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86B33E881
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 05:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCQEji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 00:39:38 -0400
Received: from wforward4-smtp.messagingengine.com ([64.147.123.34]:38653 "EHLO
        wforward4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhCQEj1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 00:39:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id AD706FDC;
        Wed, 17 Mar 2021 00:39:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 17 Mar 2021 00:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=I7aJARQVs8IpudOhbs2Lan8lyFeRLAvjjCDYeu0Gf
        fo=; b=KYCkdsW58fsKwigd/O9O+RoOViRSukWpYoLiwJJCU2+k5/Vtp7JB6h32C
        rPApDaXVtP55sKcL4T+xd/9B8LTLtTA9glp4CxmSGUZ+gRG3o1p+vFFnOZgOlqyK
        lVT4F8tMy74ddgeb8yZxu/vD39U/F188ejQvx8GUoDEXYjzta3JCsqBKNaTIRDkk
        ybwQLPGGH9ybkrALDzeX4fz3rIDdyVOkRpD1VCfw63iDdoQJqOmPMNKp/KqAfFkk
        HbXOE0WzuKx45styPi2TYPtSreXIYuLXGB0xjGkIJ9GWR7FZAqhe/IbdXcPVba4/
        0lqkwjG0bJ+y8h4RdlY/NokZNAGbw==
X-ME-Sender: <xms:_IdRYGAFSANvx_D-gtrN6-1tF0eelHOykiQfeN9e5oBCOm9tc-eenA>
    <xme:_IdRYAim9JaJhFjr-RmAi2JO5IN5z5H3K2LqnGbG0-zkz5mNvW7FobiiCBAQ5jnEZ
    ceoMDClRS5NYypdFIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeffedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepffefudehfeejtdeivdeukefgveetheek
    hfduveeiudeuvefghfefffeihfejkedvnecuffhomhgrihhnpehusghunhhtuhdrtghomh
    enucfkphepudeluddrleeirdejfedrvddvleenucfuphgrmhfkphfpvghtfihorhhkpedu
    ledurdeliedrjeefrddvvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohesuhgsuhhnthhurdgtohhm
X-ME-Proxy: <xmx:_IdRYJk5Fgrr6ibrT3gQpVhPN_Z8pdIkxP5Bnz2isMDkPkKAoNanKw>
    <xmx:_IdRYExoJU9QNuDpR2r6okb5uT6PNGMCzjNEMSrdz9xD74oi6fNwRw>
    <xmx:_IdRYLR09ZgyebmgDIFPdrgAoQ32Rbz2R88hYKhXMUVoHarvU4uAmw>
    <xmx:_IdRYM6QDZ0Gnbh01PjqBG0fSbN23d75QewAInPXXmw49l05tUiKd9O8Ozg>
Received: from [10.6.3.96] (unknown [191.96.73.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42880240057;
        Wed, 17 Mar 2021 00:39:23 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
Date:   Wed, 17 Mar 2021 01:39:19 -0300
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 637648639.324927-82119904e8d2a7c480920f06d920fa62
Content-Transfer-Encoding: 7bit
Message-Id: <CFD47A17-D20D-49FB-A357-5476C8EE02AF@ubuntu.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com>
 <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
 <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
 <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Mar 10, 2021 at 2:45 PM Rafael David Tinoco
> <rafaeldtinoco@ubuntu.com> wrote:
>>> From what I see all the CO-RE relocations applied successfully (even
>>> though all the offsets stayed the same, so presumably you compiled
>>> your BPF program with vmlinux.h from the exact same kernel you are
>>> running it on?). Are you sure that vmlinux image you are providing
>>> corresponds to the actual kernel you are running on?
>>
>> Yep, I have created the following:
>>
>> https://pastebin.ubuntu.com/p/h58YyNr4HR/
>
> Ok, I have no idea, tbh. Maybe `pahole -j` is subtly modifying vmlinux
> is some way (but then why would kernel start and only fail to
> load/verify your BPF program?). It's also clear that CO-RE is doing
> exactly the same instruction patching, so shouldn't be some invalid
> CO-RE relocation applied, I think. So no idea and not sure how to
> investigate this.
>
> But I think I'd never do `pahole -J` on actual vmlinux image you are
> going to run. It's much safer and more convenient to make a copy,
> generate .BTF and then extract just .BTF section into a small binary,
> which can be provided separately.
>

FOUND the cause of the issue...

Compiling the EXACT same kernel with different building scripts
(deb-pkg vs debian/rules in my case) resulted in a very similar
kernel (same .config, same autoconf.h, no visible changes).

Unfortunately one of the kernels worked fined (reading the BTF
extracted section OR same section within a vmlinux entire
file).. but the other did not.

Instrumenting this bad 4.15 kernel (out of debian/rules build)
I found that the following sanity checks took place in kernel:

bpf_check():

if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 || !log->level  
|| !log->ubuf)

and a simple change in libbpf (mitigation of course):

   attr.log_buf = 0;
   attr.log_level = 0;
   attr.log_size = 0;

before

fd = sys_bpf_prog_load(&attr, sizeof(attr));

made the code to also run in this second kernel (built with the
debian/rules building scripts):

https://pastebin.ubuntu.com/p/scJDM3D9Zr/

Now I still have to discover why log_buf is miss-behaving in this
kernel being built with debian/rules* scripts and not with the
vanilla building scripts (despite config file being the same).

(FYIO, documenting it here for others also)...



