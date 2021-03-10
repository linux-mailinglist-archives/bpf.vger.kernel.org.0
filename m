Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CA334BE4
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCJWpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:45:43 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:42015 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233150AbhCJWph (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 17:45:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B84DA3168;
        Wed, 10 Mar 2021 17:45:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Mar 2021 17:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=XveHPK+lNpgt+gaTnttS3zJQMNZUrnYKl+5I98XOu
        Yw=; b=H3fNDWkraC7nz7Gc06TPvNHJ5m78TRcti4Av5BAHS15A3isRP8pstbG8E
        +3qKacEDDT88tsKv8fFPZlBL5qedd97txyWRVlNtWl5RgtkwSbCUZ1+7QKlbgWAJ
        EPr2G1jnIU7MSS/cBC95YZQsEfe/+Z8JSiGFxTLsozSSJ5WOsu4cSvsBvT8LlZRl
        1jLU6yf3RY/PIkywVqbrk9MFBMBIty1AxzFsohYajrGhOlT1potPFFEwon/bUF9l
        5LraqXJUXtB3R2SLBppvVVFSE+LxaQp168lloSJT5fR7HP/JeBGONOKG4MgwT2cT
        plzri01QopB7g8VfLnXd0JVnnZGBg==
X-ME-Sender: <xms:D0xJYBMQaTY8hQ42CIsfaf-_8NxjdMnOjtcJFXct4Bq7XsNa8a2caw>
    <xme:D0xJYD8GpyLdwAVTZ05On2DBqnOdBakxZUjr5Hnlfr7pj9QfFfdbPulu5GP6CP5a3
    qBmtQEHEp9VdnOMcFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthekmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepudelheejgeffjeejhedvvdfgveeggefh
    ieejudejgfduteelgeeugefhleejffelnecuffhomhgrihhnpehusghunhhtuhdrtghomh
    dpghhithhhuhgsrdgtohhmnecukfhppedujeejrddvvddtrddujedvrddvgeegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgrvghlug
    htihhnohgtohesuhgsuhhnthhurdgtohhm
X-ME-Proxy: <xmx:D0xJYASbLiwaP15i2d608tI5yZFRrJF-feTzpee2QHXVvm1S3eueJg>
    <xmx:D0xJYNsEsVPUlEOPONdYmqPTSlIOSGjC6onSVJ2Pl7Kzkz3Lh4AugQ>
    <xmx:D0xJYJeX40xZg2fjP9S2_L0KnUp_5Vw4Bxc9W6RckXVrx33-HvshtA>
    <xmx:EExJYJmUKrDKqq5TSo5xQtGZa535E7P8RP_EK54uIEj6mUC95PwqBg>
Received: from [192.168.100.154] (unknown [177.220.172.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6883108005C;
        Wed, 10 Mar 2021 17:45:34 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
Date:   Wed, 10 Mar 2021 19:45:32 -0300
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com>
 <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> From what I see all the CO-RE relocations applied successfully (even
> though all the offsets stayed the same, so presumably you compiled
> your BPF program with vmlinux.h from the exact same kernel you are
> running it on?). Are you sure that vmlinux image you are providing
> corresponds to the actual kernel you are running on?

Yep, I have created the following:

https://pastebin.ubuntu.com/p/h58YyNr4HR/

to make this easier.

It is a 4.15.0-1080 kernel and a 4.15.18+. They are pretty close
despite the versioning (second was generated with make deb-dpkg).

I’m using same .config file for both, only difference is that the
4.15.18+ was compiled with the changed link-vmlinux.sh file.

The /usr/lib/debug/boot/vmlinux files are generated by the same
build and I have tried 2 or 3 of the existing packaged kernels. The
only thing I did was “pahole -J” to /usr/lib/debug/boot/vmlinux-XXX
files (adding the BTF section to them).

Running same binary in a 5.8.0-43 kernel works out-of-the-box:

https://pastebin.ubuntu.com/p/VKTjMcp6Xs/

>
> I'd start by comparing libbpf logs for vmlinux you get with modified
> link-vmlinux.sh script and with just explicit pahole -J. If all the
> CO-RE parts are identical, the problem is somewhere else most
> probably.

The difference between (1) and (2) from the paste (error and success):

libbpf: CO-RE relocating [0] struct task_struct: found target
candidate [17361] struct task_struct in [vmlinux]
libbpf: CO-RE relocating [0] struct task_struct: found target
candidate [17360] struct task_struct in [vmlinux]

libbpf: prog 'tcp_connect': relo #0: matching candidate #1 [17361]
struct task_struct.comm (0:90 @ offset 2640)
libbpf: prog 'tcp_connect': relo #0: matching candidate #1 [17360]
struct task_struct.comm (0:90 @ offset 2640)

Code is at:

https://github.com/rafaeldtinoco/portablebpf

and it is not much different than any other libbpf example.

thanks again for verifying this!

-rafaeldtinoco



