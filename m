Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF281968ED
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgC1TeY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 15:34:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43215 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgC1TeY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Mar 2020 15:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585424062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xavtOB9q+6tVlOy8IGm8o35ph13MKK+BP0SPVCpA4UE=;
        b=hX0t05E6YVVStwZnckG3iyav5BNofMwLX/d7VHmfrpUqjNp2EJtQphWADoOAqVvDZHXywK
        G5nbCGSVhLUST9Y/6yEnS+RVomOnT9VMwgH5YnQLXazMudvHx8vaZlZIXzaoV0TH5E16Z0
        /q2gy7YvuWLLLfc/TNEoHp3SHXsc9SA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-24_g24yiM0eBFxJFhiZDxQ-1; Sat, 28 Mar 2020 15:34:19 -0400
X-MC-Unique: 24_g24yiM0eBFxJFhiZDxQ-1
Received: by mail-lf1-f69.google.com with SMTP id k15so3728533lfc.11
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 12:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xavtOB9q+6tVlOy8IGm8o35ph13MKK+BP0SPVCpA4UE=;
        b=sQa9UBGtjmCJ4t6cukcdSf4OSyJ8eDvAXtmuCndREDrd132k37PVN2DlEscE5Cq8ZZ
         ZxTAOsWqOSUBKRUvZhK6DnZ1qHaVj6lLYd3ml6GsV+GxJehpC73SQbhRRFlbt3stD7kF
         ovti+oIP2nzNUxN1jfBDKZdXlXzKJ3MDptFnVOVApdkApIWfNbkvy38oT7YvcBkYipx+
         kMxdDjXbnX7p1DXH3rCt89XslAito4QJ9jV5sVxH6v0fJ1RXqJRKN8ORGo5BdMQVHxXu
         JVBNEuf+y55eF5X1CUt2GDgWgjUehJ7E03Sxn8x383Kb8OlBMkhHHqKFOrYI68VYrMBi
         WY6g==
X-Gm-Message-State: AGi0PubSmbM7Nz678tu51OjSBgsSFF05qArZLB6sa5Azo6ZHoI1ijSY7
        9cwFtvj7MUvzfDGMlG79iuMCQx6/WcuGNMQaM+iwpGI0lvG/5aaE6NqaqQ5zI/kxFXDBkDt+/Mw
        KSTbWDTZxQ6Kg
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2869937ljp.116.1585424058070;
        Sat, 28 Mar 2020 12:34:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFypNpFK3wZMKtVBj4E45xuQIH0Q7exsWfvmIsj4wNOALhNTlCqKkgnQKadXd1r8NniyF+5g==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2869918ljp.116.1585424057762;
        Sat, 28 Mar 2020 12:34:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h3sm5021490lfk.30.2020.03.28.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 12:34:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 98EBD18158B; Sat, 28 Mar 2020 20:34:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200328022609.zfupojim7see5cqx@ast-mbp>
References: <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <87pncznvjy.fsf@toke.dk> <20200326195859.u6inotgrm3ubw5bx@ast-mbp> <87imiqm27d.fsf@toke.dk> <20200327230047.ois5esl35s63qorj@ast-mbp> <87lfnll0eh.fsf@toke.dk> <20200328022609.zfupojim7see5cqx@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 28 Mar 2020 20:34:12 +0100
Message-ID: <87eetcl1e3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Mar 28, 2020 at 02:43:18AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>=20
>> No, I was certainly not planning to use that to teach libxdp to just
>> nuke any bpf_link it finds attached to an interface. Quite the contrary,
>> the point of this series is to allow libxdp to *avoid* replacing
>> something on the interface that it didn't put there itself.
>
> Exactly! "that it didn't put there itself".
> How are you going to do that?
> I really hope you thought it through and came up with magic.
> Because I tried and couldn't figure out how to do that with IFLA_XDP*
> Please walk me step by step how do you think it's possible.

I'm inspecting the BPF program itself to make sure it's compatible.
Specifically, I'm embedding a piece of metadata into the program BTF,
using Andrii's encoding trick that we also use for defining maps. So
xdp-dispatcher.c contains this[0]:

__uint(dispatcher_version, XDP_DISPATCHER_VERSION) SEC(XDP_METADATA_SECTION=
);

and libxdp will refuse to touch any program that it finds loaded on an
iface which doesn't have this, or which has a version number that is
higher than what the library understands. The code implementing the
check itself is this[1]:

static int check_dispatcher_version(struct btf *btf)
{
	const char *name =3D "dispatcher_version";
	const struct btf_type *sec, *def;
	__u32 version;

	sec =3D btf_get_datasec(btf, XDP_METADATA_SECTION);
	if (!sec)
		return -ENOENT;

	def =3D btf_get_section_var(btf, sec, name, BTF_KIND_PTR);
	if (IS_ERR(def))
		return PTR_ERR(def);

	if (!get_field_int(btf, name, def, &version))
		return -ENOENT;

	if (version > XDP_DISPATCHER_VERSION) {
		pr_warn("XDP dispatcher version %d higher than supported %d\n",
			version, XDP_DISPATCHER_VERSION);
		return -EOPNOTSUPP;
	}
	pr_debug("Verified XDP dispatcher version %d <=3D %d\n",
		 version, XDP_DISPATCHER_VERSION);
	return 0;
}

and is called both when loading the BPF object code from disk, and
before operating on a program already loaded into the kernel.

> I'm saying that without bpf_link for xdp libxdp has no ability to
> identify an attachment that is theirs.

Ah, so *that* was what you meant with "unique attachment". It never
occurred to me that answering this question ("is it my program?") was to
be a feature of bpf_link; I always assumed that would be a property of
the bpf_prog itself.

Any reason what I'm describing above wouldn't work for you?

> I suspect what is happening that you found first missing kernel feature
> while implementing libxdp and trying to fix it by extending kernel api.
> Well the reason libxdp is not part of libbpf is for it to be flexible
> in design and have unstable api.
> But you're using this unstable project as the reason to add stable apis
> both to kernel and libbpf. I don't think that's workable because...

That's certainly not my intention. I have done my best to think through
which is the minimum amount of kernel support I need to implement the
libxdp multi-prog feature set. When the initial freplace support landed
there was three things missing:

1. Ability to make freplace attachments permanent
2. Atomic replace of XDP programs
3. Multi-attach for freplace

Andrii already solved 1. with pinning, this is my attempt to solve 2.,
and 3. is TBD.

>> I could understand why you wouldn't want to do
>> that if it was a huge and invasive change; but it really isn't...
>
> Yes. It's a small api extension to both kernel and libbpf.
> But it means that by accepting this small change I sign up on maintaining=
 it
> forever. And I see how second and third such small experimental change wi=
ll be
> coming in the future. All such design revisions of libxdp will end up on =
my
> plate to support forever in the kernel and in libbpf. I'm not excited to
> support all of these experimental code.

I understand that, but as I said it's really not my intention to just
dump experimental code on you. And I also do consider this an obvious
API bugfix that is useful in its own right.

> I see two ways out of this stalemate:
> 1. assume that replace_fd extension landed and develop libxdp further
>    into fully fledged library. May be not a complete library, but at least
>    for few more weeks. If then you still think replace_fd is enough
>    I'll land it.
> 2. I can land replace_fd now, but please don't be surprised that
>    I will revert it several weeks from now when it's clear that
>    it's not enough.
>=20=20
> Which one do you prefer?

I prefer 2. Reverting if it does turn out that I'm wrong is fine. Heck,
in that case I'll even send the revert myself :)

-Toke

[0] https://github.com/xdp-project/xdp-tools/blob/xdp-multi-prog/lib/libxdp=
/xdp-dispatcher.c.in#L61
[1] https://github.com/xdp-project/xdp-tools/blob/xdp-multi-prog/lib/libxdp=
/libxdp.c#L824

