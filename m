Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE933F2AE
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhCQOcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 10:32:07 -0400
Received: from wforward1-smtp.messagingengine.com ([64.147.123.30]:34095 "EHLO
        wforward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231877AbhCQObp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 10:31:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailforward.west.internal (Postfix) with ESMTP id 8F5B8243F;
        Wed, 17 Mar 2021 10:31:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Mar 2021 10:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=h8YsvWm8QT/uQ/zWAAzHRUTIUcphQ2EzHqQ3tsheD
        zQ=; b=LXzgE8CxsZIn6a2D1qjQU5Ub8OGDNbrJqpgZaIKfvJFqaSURUiURR1cbu
        qMy/PiTZAjOn3XeCYCCoqQie5nQrferxBARy7Ik0UqOlcU16Ja1uit0BMx8PnF+d
        6qym/G/wusSbL7musK/0biVV20dOaytS1ge9BgvNHnoB15rcdX2ZlPKLnkEgv8Wl
        +y9g3WLlDUjx7t/GMzQ/L0g3S9NwxR706OIPEDayjY3OlONC2LOibo+ny+PHFNZv
        M2AJJUiGEdYsRyPQNOaYumXWZpTpKCgBD13/1nwbLgogbPLtlWBPQLZHkTw5w+1U
        jeQ4kNgWXz2HSsjuBBzUIEkvYsSWg==
X-ME-Sender: <xms:zhJSYALItS0wt1Zq5mXR52No2J6uWySYKFZWGGXka5OjR9V5J9Aa4w>
    <xme:zhJSYITG7hBWoT_SKiaA9xOllUenCEnmmhP6OFkki8kOlWcztsdEIKHk-2ss1JONe
    mwkQTWHJuJ4ej82dGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthekmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepiefhtedugeetueevveekffejffffhedt
    keekfeejteefgfefudelkeetfffgleeunecukfhppeduledurdeliedrjeefrddvvdelne
    cuufhprghmkfhppfgvthifohhrkhepudeluddrleeirdejfedrvddvleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhinh
    hotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:zhJSYAMsTv9JG29yHRfnN7xsY3b9zVMCFGSUy-HKN-YKH6OGzchoHA>
    <xmx:zhJSYNXtAW8lEsLCII4IoydE88plM7ZfdkiZB-UQ93lH2sxq7G9zwA>
    <xmx:zhJSYDjDy3JxGBa-PUTBrSqPXT2IVO98r5CTs4fGixnvGBnH3joxAg>
    <xmx:zxJSYLN3n8Ya_BntOfwDRGGVrOmvL-TJEkPnC71u0iUYJbGRSEX2nZWc7zY>
Received: from [10.6.3.96] (unknown [191.96.73.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9006924005D;
        Wed, 17 Mar 2021 10:31:41 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CFD47A17-D20D-49FB-A357-5476C8EE02AF@ubuntu.com>
Date:   Wed, 17 Mar 2021 11:31:38 -0300
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 637684238.052054-6b45b567c1d5b3360dfa095b133282b9
Content-Transfer-Encoding: 8bit
Message-Id: <B4B873B5-464D-46D7-A0DC-841B08FA34AD@ubuntu.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com>
 <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
 <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
 <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
 <CFD47A17-D20D-49FB-A357-5476C8EE02AF@ubuntu.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>>
>>>> From what I see all the CO-RE relocations applied successfully (even
>>>> though all the offsets stayed the same, so presumably you compiled
>>>> your BPF program with vmlinux.h from the exact same kernel you are
>>>> running it on?). Are you sure that vmlinux image you are providing
>>>> corresponds to the actual kernel you are running on?
>
> FOUND the cause of the issue…
>

...

>
> bpf_check():
>
> if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 || !log->level  
> || !log->ubuf)
>
> and a simple change in libbpf (mitigation of course):
>
>   attr.log_buf = 0;
>   attr.log_level = 0;
>   attr.log_size = 0;
>
> before
>
> fd = sys_bpf_prog_load(&attr, sizeof(attr));

With instrumented kernel… no changes to libbpf or code:

attr.log_buf = (nil)
attr.log_level = 0
attr.log_size = 0
load_attr.log_buf = 0x7fd1c0a92010
load_attr.log_level = 0
load_attr.log_size = 16777215
libbpf: load bpf program failed: Invalid argument
libbpf: failed to load program 'ip_set_create'
libbpf: failed to load object 'mine_bpf'
libbpf: failed to load BPF skeleton 'mine_bpf': -22
failed to load BPF object: -22

[   27.857858] MINE: BPF_PROG_TYPE_KPROBE KERNEL VERSION ISSUE
[   27.857993] MINE: LINUX_VERSION_CODE: 266002
[   27.858131] MINE: YOUR VERSION: 265984

2 problems here:

0) attr.kern_version

- looks like for some reason attr.kern_version is different from
the one running

- bypassing kernel BPF_KPROBE version check, I get:

1) load_attr has log_buf and log_size but not log_level for some reason.

- this triggers an issue in bpf_check() within kernel IF I bypass
the BPF_KPROBE version check (kerne 4.15).

NOW, If I hard-code attr.kern_version in bpf.c to:

attr.kern_version = 266002;
fd = sys_bpf_prog_load(&attr, sizeof(attr));

then

attr.log_buf = (nil)
attr.log_level = 0
attr.log_size = 0
load_attr.log_buf = (nil)
load_attr.log_level = 0
load_attr.log_size = 0
Tracing... Hit Ctrl-C to end.

I don’t have the 2 problems, as log_level is zeroed, together with
log_buf and log_size.

Any clue on why this happens ?

Thank you!

-rafaeldtinoco

