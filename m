Return-Path: <bpf+bounces-48487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE9A082E0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4547A36AC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F7205E07;
	Thu,  9 Jan 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg+ti6jN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC82054FD
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462525; cv=none; b=lSH31LrAGPw3w1iGj0SBX4B2QKrvj/Dai/KQhtAeeygWb/oONbeblfOurRveGvdrA280L9hu0sOMcTHC3asq6IVYlUBmmy9KvXW8bZoLIn+E3/8Wc9RkPULmnc1a0EVf6ugREoP9LB+NjLHVT9IV2iKWvee6xrt8EeZWoTI1cLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462525; c=relaxed/simple;
	bh=Y9NkrLGmylM8UnKtAi46e5yWvaF7xye7V0AEdJoQZW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjA97FXhZDN4UaCD0KMHd4kiNKyYdkLsxk3gdmWP4aGehY/kwbYkMGYyMyxWKIqQK8hWCZQbSLMpMRjSWzWEp6K//F5+FVRwd6bSwpn1nKxeTJxrVXaYAOW10fa8FiO3w4djP+mXtEH74GtipwGEvL0xc9pEgDXQBt/t+7gfYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qg+ti6jN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso3219a12.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736462522; x=1737067322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weql44/TCZcCo59od+M8ApuTZhXWeNY1dhogmGHwFNE=;
        b=Qg+ti6jNpBzW1J0HRfg1bG0bUVrtbDPkJ1wDjVbovC23WStsjoJ30QEDSmMWzDLtxl
         YAnuawHT1dxQWF5qWi7F0og369e92exIPxpeVsCjg4ircnso1e4k0MmvAqPInT55JXGK
         D7MaqgFDFWiuGJv9KFgchebCjLAz54bZrtWlIfqArAY+2fnWa3VcSyLk9SM4EgiaC5eM
         3PUmtwlNgSK24qytjYK+jSQn20wbtUhs5O58IPsqzvOClDIEaxuGjEDbNLoG1jivoHGL
         1/14PcS37gcWtZWI4rf/+kRq0OujFq9soPaUMXhSkpkq9XbWMeBMYW+ol91ZxiHUAdr2
         njSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736462522; x=1737067322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weql44/TCZcCo59od+M8ApuTZhXWeNY1dhogmGHwFNE=;
        b=YrBrvRFLL/37wi4AZkzyZ2BDaUE2X6OVslbmz3Jc54LYE3DS4GEHdNEABHCiyxqyZo
         VCAFuyOWMyKG8I9gRsqFhJJvl7fC8+/6+cBdyyWlU3mT1fK1URm4q/ejvn7ZYF6uUsDg
         hy+BUAJ1w3Uj7UQo1bw1YlDY3SMKR1epdTHQZg21hgd6GfeXEGG3GV3EuGHOKE06SAd+
         6IidPzDxR+Pszk0/6De/uYtJBsGrwQoq1AJn4cPp1PsRtffIzE8XgH/JfkQDQMzn+pHJ
         fxPp7p8V+5mq+OOHd6dLWmY/LBAtpxhUqStHzlk3+YEnzss4IT3YHDcE8jwQ79sQTosG
         GZBw==
X-Forwarded-Encrypted: i=1; AJvYcCX39M/Adkw3ul6Ehpa+r5u61dv+qAoCida3vaMzi4kyy5dVQbRMqkJkpp/uVENd45AIUjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnu7z8Gsjfv5XXlfkBLwotl9yC5zllMHyni7WYUd7xdD6Iuy5f
	jBb1lnK4xX6VkMM4lbVFxl2u1pKe9YHVKDN8U0NHqlOT4kXLHDF+RMVJrE7/xGIk0qZlOS6RuOx
	RfdQFO/TWVz920Vd4G266pUvfRDpLHNJHzltr
X-Gm-Gg: ASbGncshsvfYsBokT7PbEgtIq/HQN0FHH9pFpxaXAA7WZfqh9HUZePmmklPueHyXPH4
	I5dGkid/f4qIjsQqMtLpcenTp6JH/16LU48LrN3m2zTfTo0PV+w2g1RNdLAd/Z0U1pOiu
X-Google-Smtp-Source: AGHT+IEtDhm9+fJt/cE12QK4cG5kPbrLwb3PwE2xwl0do7/zTqTEt4WlDVecRQlmr2gsn6+k2nE7xEVso7IvoZ+UH5s=
X-Received: by 2002:a05:6402:519:b0:5d4:428e:e99f with SMTP id
 4fb4d7f45d1cf-5d9a0cc9cdamr6871a12.3.1736462521450; Thu, 09 Jan 2025 14:42:01
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1> <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
 <Z3_5eGD_F1_ZxfqE@x1> <Z4BQG3rmYNDS5W0Z@x1>
In-Reply-To: <Z4BQG3rmYNDS5W0Z@x1>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 9 Jan 2025 14:41:50 -0800
X-Gm-Features: AbW1kvbfN1aH3c8C-m-WU9JZYQbIPEAFaYG9GHZDJixLlWZWd_4W7Ov9UeTaZwA
Message-ID: <CAGSQo039Kgxk4FfDn_wfD=Ha=UR2xxhSM0MrjzXNR9YeiuCTZg@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>, 
	Alessandro Decina <alessandro.d@gmail.com>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Dave Tucker <dave@dtucker.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:39=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Jan 09, 2025 at 01:29:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jan 09, 2025 at 10:49:49AM -0500, Tamir Duberstein wrote:
> > > On Thu, Jan 9, 2025 at 10:47=E2=80=AFAM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > > I was thinking about it after reading this thread yesterday, i.e. w=
e
> > > > could encode constructs from Rust that can be represented in BTF an=
d
> > > > skip the ones that can't, pruning types that depend on non BTF
> > > > representable types, etc.
> >
> > > Yep, this is what bpf-linker does, along with some other things[0]. I
> > > highly recommend reading the code I linked to avoid re-discovering
> > > these things.
> >
> > Sure, thanks for pointing it out and suggest I read it while
> > experimenting with having the same concept in pahole, I'll try a quick
> > hack and then look at it to see how close I got to what you guys came u=
p
> > with :-)
>
> So I didn't manage to work on this today, just this quick hack:
>
> =E2=AC=A2 [acme@toolbox pahole]$ git diff
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 78efd705333e2e52..5610e0902f2cd347 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1559,7 +1559,7 @@ static int btf_encoder__encode_tag(struct btf_encod=
er *encoder, struct tag *tag,
>         default:
>                 fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\=
n",
>                         dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
> -               return -1;
> +               return 0;
>         }
>  }
>
> =E2=AC=A2 [acme@toolbox pahole]$
>
> Which essentially encodes any DWARF tag that the BTF encoder doesn't
> know about into 'void'.
>
> Super quick hack, I still have to look at the implications, but some
> results:
>
> =E2=AC=A2 [acme@toolbox pahole]$ cp ../build/rust-kernel/vmlinux vmlinux.=
rust
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --btf_encode vmlinux.rust
> die__process_class: tag not supported 0x33 (variant_part) at <4c9c589>!
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not h=
andled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstra=
ct_origin=3D0, specification=3D0x4cb784b
> =E2=AC=A2 [acme@toolbox pahole]$
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
> =E2=AC=A2 [acme@toolbox pahole]$
> =E2=AC=A2 [acme@toolbox pahole]$
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
> =E2=AC=A2 [acme@toolbox pahole]$
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | les=
s
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | hea=
d
> [1] INT 'DW_ATE_signed_32' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=
=3DSIGNED
> [2] INT 'DW_ATE_signed_64' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=
=3DSIGNED
> [3] INT 'DW_ATE_unsigned_1' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=
=3D(none)
> [4] INT 'DW_ATE_unsigned_8' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=
=3D(none)
> [5] INT 'DW_ATE_unsigned_64' size=3D8 bits_offset=3D0 nr_bits=3D64 encodi=
ng=3D(none)
> [6] INT 'DW_ATE_unsigned_32' size=3D4 bits_offset=3D0 nr_bits=3D32 encodi=
ng=3D(none)
> [7] STRUCT 'tracepoint' size=3D80 vlen=3D9
>         'name' type_id=3D8 bits_offset=3D0
>         'key' type_id=3D12 bits_offset=3D64
>         'static_call_key' type_id=3D23 bits_offset=3D192
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | tai=
l
>         type_id=3D12300 offset=3D226816 size=3D24 (VAR 'cfd_data')
>         type_id=3D12301 offset=3D226880 size=3D8 (VAR 'call_single_queue'=
)
>         type_id=3D12302 offset=3D226944 size=3D32 (VAR 'csd_data')
>         type_id=3D51838 offset=3D227008 size=3D832 (VAR 'softnet_data')
>         type_id=3D54492 offset=3D227840 size=3D24 (VAR 'rt_uncached_list'=
)
>         type_id=3D55984 offset=3D227904 size=3D24 (VAR 'rt6_uncached_list=
')
>         type_id=3D8094 offset=3D229376 size=3D64 (VAR 'vmw_steal_time')
>         type_id=3D8810 offset=3D229440 size=3D64 (VAR 'apf_reason')
>         type_id=3D8811 offset=3D229504 size=3D64 (VAR 'steal_time')
>         type_id=3D8813 offset=3D229568 size=3D8 (VAR 'kvm_apic_eoi')
> =E2=AC=A2 [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep DW_AT_pr=
oducer | head
>     <d>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (=
Fedora 18.1.6-3.fc40)
>     <1be5a>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <1ec5b>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <3bfd5>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <3d11c>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <4fcf0>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <503d5>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <5c067>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <5c42e>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
>     <5efd9>   DW_AT_producer    : (indexed string: 0): clang version 18.1=
.6 (Fedora 18.1.6-3.fc40)
> =E2=AC=A2 [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep DW_AT_la=
ng | grep -i rust
>     <4c91de1>   DW_AT_language    : 28  (Rust)
>     <4ce66ea>   DW_AT_language    : 28  (Rust)
>     <4cf2cfa>   DW_AT_language    : 28  (Rust)
>     <4cf71a8>   DW_AT_language    : 28  (Rust)
>     <4d2797d>   DW_AT_language    : 28  (Rust)
>     <4d50f34>   DW_AT_language    : 28  (Rust)
> =E2=AC=A2 [acme@toolbox pahole]$
>
>   Compilation Unit @ offset 0x4c91dd1:
>    Length:        0x54905 (32-bit)
>    Version:       4
>    Abbrev Offset: 0x244258
>    Pointer Size:  8
>  <0><4c91ddc>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <4c91ddd>   DW_AT_producer    : (indirect string, offset: 0x282d41): =
clang LLVM (rustc version 1.80.0 (051478957 2024-07-21) (Fedora 1.80.0-1.fc=
40))
>     <4c91de1>   DW_AT_language    : 28  (Rust)
>     <4c91de3>   DW_AT_name        : (indirect string, offset: 0x282d91): =
/usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32dfd9e3bca37e-c=
gu.0
>     <4c91de7>   DW_AT_stmt_list   : 0xa1d85f
>     <4c91deb>   DW_AT_comp_dir    : (indirect string, offset: 0x2ebc6): /=
home/acme/git/build/rust-kernel
>     <4c91def>   DW_AT_low_pc      : 0
>     <4c91df7>   DW_AT_ranges      : 0x1e5f0
>  <1><4c91dfb>: Abbrev Number: 2 (DW_TAG_variable)
>     <4c91dfc>   DW_AT_name        : (indirect string, offset: 0x555b60): =
<usize as core::fmt::Debug>::{vtable}
>     <4c91e00>   DW_AT_type        : <0x4c91e0e>
>     <4c91e04>   DW_AT_location    : 9 byte block: 3 78 34 50 82 ff ff ff =
ff     (DW_OP_addr: ffffffff82503478)
>  <1><4c91e0e>: Abbrev Number: 3 (DW_TAG_structure_type)
>     <4c91e0f>   DW_AT_containing_type: <0x4c91e5a>
>     <4c91e13>   DW_AT_name        : (indirect string, offset: 0x2b3380): =
<usize as core::fmt::Debug>::{vtable_type}
>     <4c91e17>   DW_AT_byte_size   : 32
>     <4c91e18>   DW_AT_alignment   : 8
>  <2><4c91e19>: Abbrev Number: 4 (DW_TAG_member)
>     <4c91e1a>   DW_AT_name        : (indirect string, offset: 0x313232): =
drop_in_place
>     <4c91e1e>   DW_AT_type        : <0x4c91e46>
>     <4c91e22>   DW_AT_alignment   : 8
>     <4c91e23>   DW_AT_data_member_location: 0
>  <2><4c91e24>: Abbrev Number: 4 (DW_TAG_member)
>     <4c91e25>   DW_AT_name        : (indirect string, offset: 0x570b7e): =
size
>     <4c91e29>   DW_AT_type        : <0x4c91e5a>
>
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf -C "<usize as core::fmt::D=
ebug>::{vtable_type}" vmlinux.rust
> struct <usize as core::fmt::Debug>::{vtable_type} {
>         __SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 *=
/
>         usize                      size;                 /*     8     8 *=
/
>         usize                      align;                /*    16     8 *=
/
>         __SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 *=
/
>
>         /* size: 32, cachelines: 1, members: 4 */
>         /* last cacheline: 32 bytes */
> };
>
> =E2=AC=A2 [acme@toolbox pahole]$
>
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf -C '<core::fmt::Error as c=
ore::fmt::Debug>::{vtable_type}' vmlinux.rust
> struct <core::fmt::Error as core::fmt::Debug>::{vtable_type} {
>         __SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 *=
/
>         usize                      size;                 /*     8     8 *=
/
>         usize                      align;                /*    16     8 *=
/
>         __SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 *=
/
>
>         /* size: 32, cachelines: 1, members: 4 */
>         /* last cacheline: 32 bytes */
> };
>
> =E2=AC=A2 [acme@toolbox pahole]$
>
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --show_decl_info -F dwarf -C Alig=
nment vmlinux.rust
> die__process_class: tag not supported 0x33 (variant_part) at <4c9c589>!
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not h=
andled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstra=
ct_origin=3D0, specification=3D0x4cb784b
> /* Used at: /usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32=
dfd9e3bca37e-cgu.0 */
> /* <4c9c50c> (null):32530 */
> enum Alignment {
>         Left    =3D 0,
>         Right   =3D 1,
>         Center  =3D 2,
>         Unknown =3D 3,
> } __attribute__((__packed__));
>
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --show_decl_info -F btf -C Alignm=
ent vmlinux.rust
> /* Used at: vmlinux.rust */
> /* <0> (null):0 */
> enum Alignment {
>         Left    =3D 0,
>         Right   =3D 1,
>         Center  =3D 2,
>         Unknown =3D 3,
> } __attribute__((__packed__));
>
> =E2=AC=A2 [acme@toolbox pahole]$
>
> I'll fixup those two:
>
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not h=
andled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstra=
ct_origin=3D0, specification=3D0x4cb784
>
> I.e. support functions inside enumerations.
>
> And sure this will be refused by the kernel, lots of stuff that have
> invalid names, probably need to turn those into void as well as a
> continuation of this hack, then prune, maybe that is it, we'll see.
>
> Going AFK now.
>
> - Arnaldo

Doing a little more digging, I've also found that the latest version
of `pahole` doesn't seem to conflict with LTO in my test builds - it
seems to successfully filter out the Rust types. Version 1.25 was
causing the errors that got reported to me and I was able to
reproduce.

