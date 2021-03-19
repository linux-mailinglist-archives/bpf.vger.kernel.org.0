Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B384C341451
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 05:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhCSEnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 00:43:35 -0400
Received: from wforward3-smtp.messagingengine.com ([64.147.123.22]:40773 "EHLO
        wforward3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233489AbhCSEnE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Mar 2021 00:43:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id 5E315438;
        Fri, 19 Mar 2021 00:43:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Mar 2021 00:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nL3hpNbf377wRsiyYH6gx7Vh290cbGwtiCgAF8Veq
        yw=; b=AQ+i35EHhZUhX29N8/hh3kGbkakrzO9FSLv7tXlI1Fw2NVMIWxATr5ruO
        dvwb++/zurMqW8uGJrC6pU4Iyl6FSu6yUgxPDvZg1vPZiGUmw0Q2nycJ/8JSYOo/
        +VxNjlB7HVTs+SnXJy1ucHiPJG48YQeMvxiikMyToMluANnO9W24Y5n6YCurBZOC
        UwzLe7Zw1DPciTlTekJbvGSds5nvB1wn6LWtq72RfQYc3LtaSgLvNtYSbSDJCP8y
        jJybDq11gMr1niFa8OqyK/gJfQl1EthFHePnkqEA3MXSQxr4FG9B19YAsksPgNuR
        HRLoUBcgaZbNMoHHReyEyNdbgFUow==
X-ME-Sender: <xms:1itUYLuVoh0crCGmtxOH13W64Bweos2yAMoYw_P_BY77qNZAI8a5jA>
    <xme:1itUYF74ZJDxgTs5cf8gh7_LqZGye_yfAYf2_2RzSdlqNnw5SW0g256BmSydhrA8Z
    gHCB9gGRohgxspzAM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepuefgffduffekgeegfeefgeekgfekgfdu
    uddujeelkeefhedvieekteehjeejieejnecukfhppedufeekrddvtdegrddviedrudeine
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgr
    vghlughtihhnohgtohesuhgsuhhnthhurdgtohhm
X-ME-Proxy: <xmx:1itUYOWBYPsStDUKNQmxzLMxLiJHTfHE9HUCB7fPFQLY0WGIj-sHGw>
    <xmx:1itUYP8f0pmsc5eooRZ61G6zPuv3aLCacAOZGeZBXYBRY98uGoqVhw>
    <xmx:1itUYCmgdwPvCjtW0cVZmUj6nF-z5GmpIyPQ2jTq5ZFnfxDWB_CAVw>
    <xmx:1ytUYLBB0Eat9TqWsL5-Qq1XvI-W3d-wbHRDjT9end-y9Bb6CxezJJkbZiQ>
Received: from [192.168.100.154] (unknown [138.204.26.16])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BE2C24005B;
        Fri, 19 Mar 2021 00:43:01 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4Bza0g--Pdt8rYEY+HrzB7_YBuzudyVSR3em-7JQDzcSY3w@mail.gmail.com>
Date:   Fri, 19 Mar 2021 01:42:58 -0300
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 637821672.1910861-a1ccfa9a29922f6dee664fe38525f7f3
Content-Transfer-Encoding: 7bit
Message-Id: <D801EF01-195E-4047-A416-BA5F9715BE5E@ubuntu.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com>
 <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
 <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
 <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
 <CFD47A17-D20D-49FB-A357-5476C8EE02AF@ubuntu.com>
 <B4B873B5-464D-46D7-A0DC-841B08FA34AD@ubuntu.com>
 <CAEf4Bza0g--Pdt8rYEY+HrzB7_YBuzudyVSR3em-7JQDzcSY3w@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Any clue on why this happens ?
>
> So seems like you figured out kernel_version check, right? And it
> seems like log_buf is not really a problem as well? Or it still
> causing issues?
>

All good here Andrii. Working on the legacy kprobe and kern_version
patches and will address anything else there.

tks, cheers
