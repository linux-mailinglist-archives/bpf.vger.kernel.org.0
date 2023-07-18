Return-Path: <bpf+bounces-5179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616A758356
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A196281515
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB714A97;
	Tue, 18 Jul 2023 17:18:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E713AD1
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB6C433C8;
	Tue, 18 Jul 2023 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689700722;
	bh=3J1XrJtUddxZZBCBXSTeSVmF8QEEQ49tXFRBxGTlRR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iU8JJyTlpM/+p0xzK01RYiNUU19e1Bg3rOY9W6pVC/mycN3DKgUu07dJBo3NYPvYa
	 QSxb8ebchHJZdMDYyrpUeZTNOGcrXVV/peVY+z0OYBG4dwL7RSJPFH9+byIvsHsGft
	 R4RC2R01EFE0icUtUL+fqq4VmxWb1v0i2KhjZULU7i2vddi5VyghBmjICHXmsmDJyo
	 vLe6X+M396x9moA2E54uk7I7wXZ0ofIR55gMT5QZF6AK5TOp20w91ijM8PZ6I4J8U/
	 U4ZnhEwVaYBnlTFl2NJNlwCtFwbOsPcf/1aJH1O+wGAboPLHOZ8ZTQHVMazCCSR+O8
	 ek/5yWQtDzRzg==
Date: Tue, 18 Jul 2023 10:18:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718101841.146efae0@kernel.org>
In-Reply-To: <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
	<20230718082615.08448806@kernel.org>
	<CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
	<20230718090632.4590bae3@kernel.org>
	<CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jul 2023 09:52:24 -0700 Alexei Starovoitov wrote:
> On Tue, Jul 18, 2023 at 9:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > This is NOT for safety. You misread the code. =20
> >
> > Doesn't matter, safety or optionality. skb_header_pointer() is used
> > on the fast paths of the networking stack, adding heavy handed input
> > validation to it is not okay. No sane code should be passing NULL
> > buffer to skb_header_pointer(). Please move the NULL check to the BPF
> > code so the rest of the networking stack does not have to pay the cost.
> >
> > This should be common sense. If one caller is doing something..
> > "special" the extra code should live in the caller, not the callee.
> > That's basic code hygiene. =20
>=20
> you're still missing the point. Pls read the whole patch series.

Could you just tell me what the point is then? The "series" is one
patch plus some tiny selftests. I don't see any documentation for
how dynptrs are supposed to work either.

As far as I can grasp this makes the "copy buffer" optional from
the kfunc-API perspective (of bpf_dynptr_slice()).

> It is _not_ input validation.
> skb_copy_bits is a slow path. One extra check doesn't affect
> performance at all. So 'fast paths' isn't a valid argument here.
> The code is reusing
>         if (likely(hlen - offset >=3D len))
>                 return (void *)data + offset;
> which _is_ the fast path.
>=20
> What you're requesting is to copy paste
> the whole __skb_header_pointer into __skb_header_pointer2.
> Makes no sense.

No, Alexei, the whole point of skb_header_pointer() is to pass=20
the secondary buffer, to make header parsing dependable.

Passing NULL buffer to skb_header_pointer() is absolutely nonsensical.
It should *not* be supported. We had enough prod problems with people
thinking that the entire header will be in the linear portion.
Then either the NIC can't parse the header, someone enables jumbo,
disables GRO, adds new HW, adds encap, etc etc and things implode.

If you want to support it in BPF that's up to you, but I think it's
entirely reasonable for me to request that you don't do such things
in general networking code. The function is 5 LoC, so a local BPF
copy seems fine. Although I'd suggest skb_header_pointer_misguided()
rather than __skb_header_pointer2() as the name :)

