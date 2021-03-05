Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B615D32E257
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 07:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCEGiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 01:38:20 -0500
Received: from wforward4-smtp.messagingengine.com ([64.147.123.34]:48911 "EHLO
        wforward4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhCEGiU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 01:38:20 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 01:38:20 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id 93AFA28F3;
        Fri,  5 Mar 2021 01:32:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Mar 2021 01:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1H1n54At/ybKImClNVngcxduz9Oca6fvCiZiNqiqn
        so=; b=nnG36CdadsxELvG/pknq27MdWZQvEYsKpq/XV9oCC1sclcDusPyIPuggn
        0OcCo2Ejc65kNj8r0pwr5fuNoq3FjFG41NVBOuZbavy9GvSPpy+jv3ZOkCZnzwPC
        4q4eUKeMkryPu6hv9bp4VnRYlulehTvkQijRtYKkRAMTaUH/gonArLexO9byVFX4
        eEflY92BMhu7KrM6JuOuaNo84TRXPXMhz2gYFbgtST2pB2/p7GG4eT+2BIdrq3VN
        KfLbB4ngJ1NC8B/3UqW9bPntWo65F0aMSvx9rDXwi+Il7/a+O4/5k5KKYgHVuBWu
        mwQx+/PLyNGt3xETI1A/XYiWy8eqQ==
X-ME-Sender: <xms:htBBYDAJHKItGF5S6CAYWttfH7hiJNJA_uBfDNBjFwUG5FT_Nd5eYw>
    <xme:htBBYJglZ5bSMd2vPDmlmRokwpejyO-NMw-8sFGA_ABBL6PC8bSWP9urCC05PvL-7
    QKELRgQhjsLWkFcWBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddthedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepfefgfeevvdejgeekfeejudeiieehteev
    kedvueeludfgudeuvdehvedtffeifffhnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucfkphepudefkedrvddtgedrvdeirdegtdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhinhhotghosehusghunhhtuh
    drtghomh
X-ME-Proxy: <xmx:htBBYOnpMSVB7VyMSkB19J5BceUa8ndlW-9XGBEWNK2zX51v7XvxNA>
    <xmx:htBBYFxaF6Qe_fu29wk6yNC_TAu8CTs8tAtYJmrBLaKg8Hap0s7MJA>
    <xmx:htBBYITlMyrxOy4VCmUci48Byxhtp-KBQ7BZBYZUj5JoYaCfqQ_ilg>
    <xmx:h9BBYB77sHkcRB3x6C50_rcvBDRlhDD1tGdrwVhtNTFpBjlvxEgPWXNA-c4>
Received: from [192.168.100.154] (unknown [138.204.26.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2999E24005A;
        Fri,  5 Mar 2021 01:32:37 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
Date:   Fri, 5 Mar 2021 03:32:37 -0300
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Specially the attach_kprobe_legacy() function:
>> 
>> https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31
>> 
>> I wanted to reply here in case others also face this.
> 
> Great, glad it worked out. It would be great if you could contribute
> legacy kprobe support for libbpf as a proper patch, since it probably
> would be useful for a bunch of other people stuck with old kernels.

Definitely! Will suggest a patch for this soon.

Thanks for the feedback.

-rafaeldtinoco
