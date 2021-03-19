Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8374C341445
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 05:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCSEjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 00:39:13 -0400
Received: from wforward3-smtp.messagingengine.com ([64.147.123.22]:48081 "EHLO
        wforward3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhCSEiy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Mar 2021 00:38:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id 49127133F;
        Fri, 19 Mar 2021 00:38:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Mar 2021 00:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Bw7GIkmgJL5LBvMhnt5dnyArj3EpjXyzUvdDGvB8T
        xo=; b=KX2tVpv0ZVWy7IN4vUeW39xiF9Vl6J1YvHKEfOL6XDZGxnq97twH4DRiD
        2jsKAkWfTjFfAXOL41GQ5zrBTz+9dNJFaA8Zw5tgDak31YpJKQKGFRiMX/XTxoS3
        rQirHpiEoyd5blXVVASLvLmXR5RAiXUXz6EFd+4ljTGI3OhNHlqnHvLJCXIkf+Q+
        wzS0hlcZA+k04wzL5GmZcfoltzelEwb7qFjj8Y70u48bEDSW0LZwffaIR/Q9suWg
        Iw0pYGCh7LqKckqYM0jPSuDNwND5Xk6L6Kp6VCjAGCIUuz+WEAqVPYZPx/8MxM08
        TgDACpJfJ8h/DA/X3obUVRzmQ5v0A==
X-ME-Sender: <xms:3CpUYCKxP5X8-i48jGiY4r7EZASesWFY2RnRsTEBqYWotMEq0c8Msg>
    <xme:3CpUYKITkdQE2YjVuaW9yC-43xSGK0c_H6GMfAemJsOg-wkOIlbM5jrqSFW8xClB8
    O4MqOq-jyWx4QwsrfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthekmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepiefhtedugeetueevveekffejffffhedt
    keekfeejteefgfefudelkeetfffgleeunecukfhppedufeekrddvtdegrddviedrudeine
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgr
    vghlughtihhnohgtohesuhgsuhhnthhurdgtohhm
X-ME-Proxy: <xmx:3CpUYCtAIWauPo1Q2b3dXQuiOZKm3X9DEYAHsWeFg0osRr7QGoDb2Q>
    <xmx:3CpUYHZgVhJZ_c-YSu7ZQK3h1rmxgNsat8x8DXSZbWLrBVtg2PxYlg>
    <xmx:3CpUYJbafOYu4MSJ4DeI8oO19jjtSUJdHzo3XX-dC4Q_VOHBcIE0FQ>
    <xmx:3CpUYL1YE2bE2nrRl-LDc2DgLGjXAifKDd66vc6blcnTDRhH5ckDvAHvYDg>
Received: from [192.168.100.154] (unknown [138.204.26.16])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A39A24005A;
        Fri, 19 Mar 2021 00:38:51 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] libbpf: allow bpf object kern_version to be overridden
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <318f936b-2f7c-7d4a-cb40-baf673bd6c9e@iogearbox.net>
Date:   Fri, 19 Mar 2021 01:38:47 -0300
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 637821467.068481-b1f87102f1c9a764db0c5f66306edf96
Content-Transfer-Encoding: 8bit
Message-Id: <BBAD5B1E-7FD1-46BC-A626-EA6ADD737ED6@ubuntu.com>
References: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
 <20210318193121.370561-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZBy+H_ZHTf+fErB2-aMpJr+JSAgCYwvtWbG7dT3=97Cw@mail.gmail.com>
 <318f936b-2f7c-7d4a-cb40-baf673bd6c9e@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>>
>>> This will also help portable binaries within similar older kernels, as
>>> long as they have their BTF data converted from DWARVES (for example).
>>>
>>> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
>>> ---
>> Libbpf currently provides a way to specify custom kernel version using
>> a special "version" ELF section:
>> int _version SEC("version") = 123;
>> But it seems like you would want to set it at runtime, so this
>> compile-time approach might be problematic. But instead of hijacking
>> get_kernel_version(), it's better to add a simple setter counterpart
>> to bpf_object__kversion() that would just override obj->kern_version.
>
> +1, agree, setter makes sense for old kernels, so the loader app can set/
> retrieve from wherever it's needed. In addition, couldn't you also backport
> the old commit that ignores the kern_version from kernel side (won't help
> existing users, but at least might simplify things once they start  
> upgrade)?

Yep :\ that was my initial approach and I went for something simpler.
Will propose something else. Once I finish this, I’ll propose the
back-ports removing the version check to the kernel team. Not having
the attr version check will definitely help this, for now needed,
mitigation to fade away.

Thanks for the reviews, would appreciate comments on:

[RFC][PATCH] libbpf: support kprobe/kretprobe events in legacy environments

if possible, as both walk together supporting legacy kernels.

tks
-rafaeldtinoco
