Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF523B3BE3
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFYFD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 01:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFYFD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Jun 2021 01:03:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C830C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 22:01:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y76so460351iof.6
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cMvnu7je0Sj5MidjD7zrx2UfDukOxP6oyglBWssgom8=;
        b=dk27BBSfRthGQpdi1a+nlam2Biw5pjMPbewkDcXyNBs2cX//8uDAZiuTofiNdPjRcj
         iKA8RktVm1l3wIDWVnKbU83oB2OcdxvlZfHHsEQwZ/6motQjiBSTUcWo0oac10BFi2Ll
         Fk+cQIr+2a6QRQoJLt/VdwOWZEpesiJbWsIEb4vOTrMvLJwaWr59nZJw9DatXp/mE/Cx
         Ql5YZQ6W8cgc9cQafVm1sxOegR3P9uhs0UXJL6I/OdEsDLiqfctDDe8fN9SLSQ1+Hv+W
         0PMRmTvuEPvZhMNITGpgkTt5FFnj8BIXk6RC08kwtqf+mAWCyr4DRNIdNc0br2CY2ITL
         Nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cMvnu7je0Sj5MidjD7zrx2UfDukOxP6oyglBWssgom8=;
        b=gyWREPb5bEy/Vx4ZDkjfHBamMyZPMyaiCGO4KYZ8nUuo5jneVgezTQDLm+j8diBc5t
         3SyxeRRmFbrYgzDP7Jw0yXwK0bGdaKQ6VUHh/VtfUTb7druEmxvjZqSNWxDK7DP58UDB
         8FXrfe4bS7TGm6tbIm5UGLXYA4Xn0NqOG0+/z0P8FOAt00CeG2eKp0dZ1x8Bkr24zz3h
         HxvVhfC6KZmPzPBehU5kKV4zLR138+TPnj6XbENaurz5h+WxN72qHW2jUk4zk+KeYveX
         vJW3Xh6K40hE2/ar3YyL8/s2SHgMrn9hQVXv7t8FNldGw6IpKHf1MJw7KL6qGtMlOYVo
         Kcxw==
X-Gm-Message-State: AOAM530JIMMmdDRlHKeVhiPw/sHbmCkwzZFPyrWi7tai1s4PlCERvxLs
        zn6iYPK6tbJezzfb4j5U/Q==
X-Google-Smtp-Source: ABdhPJwWHp0a1W94F/laqZYIpBVP+WinNxIIJwsqdJGI8vKPFzm9tzCN3s3cizUtYB3fk4vJ5t3LIw==
X-Received: by 2002:a05:6638:110e:: with SMTP id n14mr7879762jal.4.1624597297478;
        Thu, 24 Jun 2021 22:01:37 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j18sm2551272ila.9.2021.06.24.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:01:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54E0727C0054;
        Fri, 25 Jun 2021 01:01:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 25 Jun 2021 01:01:36 -0400
X-ME-Sender: <xms:L2PVYKwUq4Ea4cP4NyUeMPm9wiRlz2nHFupIku3V5LoEbyfi0jx6sw>
    <xme:L2PVYGRx8Ghn0C2HbP9QuikE7O43KLY0CYkRgxt16PFBce-nQ7CcLrSVLXqnkkcfN
    gvcYpJybgQJ61SuMxs>
X-ME-Received: <xmr:L2PVYMV30Ou0oAU6p0922a-xKsdEADbzVhKwu_k4EBJ7rh_VqMwmHXJ8epo_GwmJfJFe_08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegiedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeefheekffeigedvhedtteefheffgeffuedu
    geefveeghfdtiedvkeelhfdvvedutdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgr
    vghlughtihhnohgtohdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduvd
    ehieehledtgedqvdehheekjeelfeeiqdhrrghfrggvlhguthhinhhotghopeepghhmrghi
    lhdrtghomhesuddvfehmrghilhdrohhrgh
X-ME-Proxy: <xmx:L2PVYAhp3TfG68k6-qJC0ZPaX-GiuZyaMkKe7AkeVhTpiEJycaQbcA>
    <xmx:L2PVYMCsRrW9WGE7sLU9RQ9tcXrP3mxk3bz_anNFElO7JXRfYTkVpg>
    <xmx:L2PVYBKqMvAmu2c7Bx2qa7d-8-bldpDoFucFCBBLweFb8ukUc-fiqQ>
    <xmx:MGPVYF6NRfnOrL2d1VEPfbzgKYJY08goRu2SwR85kEbXMPGwGLJYqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jun 2021 01:01:35 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH bpf-next v3] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
In-Reply-To: <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
Date:   Fri, 25 Jun 2021 02:01:33 -0300
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
X-Mao-Original-Outgoing-Id: 646290093.730171-4fff6a0012bbf6bfe09beaaeb0b3f8aa
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3E3D5CF-95BC-4D48-8F68-93DF4922FF00@gmail.com>
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
To:     LKML BPF <bpf@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Allow kprobe tracepoint events creation through legacy interface, as =
the
> kprobe dynamic PMUs support, used by default, was only created in =
v4.17.
>=20
> This enables CO.RE support for older kernels.
>=20
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>

Related to:
https://github.com/libbpf/libbpf/issues/317

> ---
> tools/lib/bpf/libbpf.c | 125 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 123 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e04ce724240..72a22c4d8295 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[snip]

> static int bpf_link__detach_perf_event(struct bpf_link *link)
> {
> 	int err;
> @@ -10152,6 +10197,12 @@ static int bpf_link__detach_perf_event(struct =
bpf_link *link)
> 		err =3D -errno;
>=20
> 	close(link->fd);

It needed the perf event fd closure for the =E2=80=98kprobe_events=E2=80=99=
 to allow releasing.

> +
> +	if (link->legacy.name) {
> +		remove_kprobe_event_legacy(link->legacy.name, =
link->legacy.retprobe);
> +		free(link->legacy.name);
> +	}
> +
> 	return libbpf_err(err);
> }

[snip]

Tested with: https://github.com/rafaeldtinoco/portablebpf (w/ CO.RE) in =
kernels 5.8 and 4.15.



