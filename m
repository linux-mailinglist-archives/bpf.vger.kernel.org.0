Return-Path: <bpf+bounces-48569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D8A0972F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D27A29A0
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2C2135B0;
	Fri, 10 Jan 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="gJrI30fU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAljT4HJ"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCE212FA5;
	Fri, 10 Jan 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526163; cv=none; b=hIHIHMp9tTsUNQqLQdt9Rj0RdfWIlbAK7GknJtqkwwnW2NjQyVphVBMfpPT15L5hdg9sFBtNTUSyk42uqmUkAnuVld4h+xSUl14VnJkMSW/XkQ8WQa72ai3BUJQiatjJVUs/pRI9tWacETTdqLb8F619tBssLuzsNdRG8N0L7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526163; c=relaxed/simple;
	bh=bsifMxDJqR4ee5/6V8ETrZCIYVC4KF1Ll2gzhECaFPs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IA0iKtpZdEyJ8it9d20qJCGYMgeMigXvl7FIKYDCz8exrEgs52yn1hTxDg9fMjkOoKSXYTEu5kUjiK8HlL4M+9Ldc37sAt83Ib4lXen7GhmPWWMLNHSnlJTM3uOLDX4dpt5xy/ZNGlz/AZ/4L7EzedjYb8K9aTtfU+B3Til67Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk; spf=pass smtp.mailfrom=dtucker.co.uk; dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b=gJrI30fU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAljT4HJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2702D2540135;
	Fri, 10 Jan 2025 11:22:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 11:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1736526158; x=1736612558; bh=Q/+iP/SLddD7WWsZdXDol3uxmnEeXv+/
	QCJsslQ5ECM=; b=gJrI30fUk9Y7o661RcQ2NcNRdMcsd9iJ+RxiqHdrdv8J3t79
	xdpYtQdnJXU9beLEkx7Nrazi7OSwGkopgBbY+2KR5Typlrya+yRqB+RJFuoeXbjf
	WoLwbqQDRwJ9DSG5XO9lD+vGZpuKXr6nP5mpbHVMmWoDHeOdvLTlzd64M00vyGKq
	e0VyZcAQy4/n3ZPlzU7lGtgjQ6N1N1ROnh39ZS1CIoa+D3WiYALGwsJLANI1KiWh
	TUzJZQJfPJKRx3vAvEJM160pk6Ye4N8xXFZSkcf6rMW4ZM5CvEnicfTKHUbTBKEr
	fc8L9qholGxvJGQlZq0lg6nP4Y1t9Yh6D0Dmqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736526158; x=
	1736612558; bh=Q/+iP/SLddD7WWsZdXDol3uxmnEeXv+/QCJsslQ5ECM=; b=U
	AljT4HJCzy3x6wqKQgx7a6WEm/G4Bpg3Y+MK7cP2bkK5VF2ewSmEUsX8yf+/8r4m
	IveHqEnR+GbVdppE5EkFwWhquWw4DFMW3ft2gb0b/jJ02sDBwyzfwHj2HvXacWPL
	sY//RW1/pWlWiDlIJ4yroeHWGEfY5+mtPhkQeglRYmGfnRZ+xeqmPOfoYtlhtGKA
	Xi3tl3p1zFwrkhvms0Bf8GiMKVljIjgTRyjhuXEHwKyVnDAywElBmm8OrODObVzZ
	2hJGogLU7yRxFuJuRTzEQ9GPRszzOEU9364CM/mpYqVvOaOUVt+1mqpvmD8zpJ1z
	ZWmRzLYgqb4Rc9xiz0D6w==
X-ME-Sender: <xms:TkmBZwPHyiIbnfQjFZvFvCeovRUwcDwx9HIxVG5sphwSXb9VBmOWmA>
    <xme:TkmBZ2-K3VcG-UOfOmjt_7wAYvRwI4tJ8sAyZAuLCVQH6mXkCpSlWtUB9_duj5LnW
    1P3MUUnNOA8qB9qRg>
X-ME-Received: <xmr:TkmBZ3QDaEvrpAMa6RdwxxoLuGNV5beq2PB2Fx0V5HyVWZJQ4vigSW2v_tN0RwlK73s2jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdej
    necuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgtoh
    druhhkqeenucggtffrrghtthgvrhhnpeekgfffffehlefghedvueetfefgteevfeegffet
    udejkedtudfgueevjeegkedtgeenucffohhmrghinheplhhisgdrrhhspdhgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegurghvvgesughtuhgtkhgvrhdrtghordhukhdpnhgspghrtghpthhtohepvdejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdgu
    vghvpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmmhgruhhrvghrsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TkmBZ4scN5p3eJV9s0H8nBKx9Yf7N6_xLo0NnURa4IfG95TsRbU1xQ>
    <xmx:TkmBZ4fNg0Ng2yVvyuEkwowh8cbyXBTjpLIojwI5VyugRYtYUkIYjQ>
    <xmx:TkmBZ81oIDXb3NSxrNYFPlK3ftGlO7bryxk1omrP1eSkhylaAc5uug>
    <xmx:TkmBZ89ejpK5lm4s60br9huzdkuUOTTzsPf86tNrv2tfUNUHXOZLDA>
    <xmx:TkmBZxMAEOjelriF5e2laSJxa4a89M439j-ns_XyihwleNPKpmhAYq-f>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 11:22:35 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
From: Dave Tucker <dave@dtucker.co.uk>
In-Reply-To: <Z4BQG3rmYNDS5W0Z@x1>
Date: Fri, 10 Jan 2025 16:22:24 +0000
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Neal Gompa <neal@gompa.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>,
 Alessandro Decina <alessandro.d@gmail.com>,
 Michal Rostecki <vadorovsky@protonmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <49AF84D3-3D47-4B35-B1A7-497045FD241F@dtucker.co.uk>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1>
 <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
 <Z3_5eGD_F1_ZxfqE@x1> <Z4BQG3rmYNDS5W0Z@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On 9 Jan 2025, at 22:39, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> On Thu, Jan 09, 2025 at 01:29:47PM -0300, Arnaldo Carvalho de Melo =
wrote:
>> On Thu, Jan 09, 2025 at 10:49:49AM -0500, Tamir Duberstein wrote:
>>> On Thu, Jan 9, 2025 at 10:47=E2=80=AFAM Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>>>> I was thinking about it after reading this thread yesterday, i.e. =
we
>>>> could encode constructs from Rust that can be represented in BTF =
and
>>>> skip the ones that can't, pruning types that depend on non BTF
>>>> representable types, etc.
>>=20
>>> Yep, this is what bpf-linker does, along with some other things[0]. =
I
>>> highly recommend reading the code I linked to avoid re-discovering
>>> these things.
>>=20
>> Sure, thanks for pointing it out and suggest I read it while
>> experimenting with having the same concept in pahole, I'll try a =
quick
>> hack and then look at it to see how close I got to what you guys came =
up
>> with :-)
>=20
> So I didn't manage to work on this today, just this quick hack:
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ git diff
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 78efd705333e2e52..5610e0902f2cd347 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1559,7 +1559,7 @@ static int btf_encoder__encode_tag(struct =
btf_encoder *encoder, struct tag *tag,
>        default:
>                fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: =
0x%x\n",
>                        dwarf_tag_name(tag->tag), tag->tag, =
ref_type_id);
> -               return -1;
> +               return 0;
>        }
> }
>=20
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
> Which essentially encodes any DWARF tag that the BTF encoder doesn't
> know about into 'void'.
>=20
> Super quick hack, I still have to look at the implications, but some
> results:
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ cp ../build/rust-kernel/vmlinux =
vmlinux.rust
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --btf_encode vmlinux.rust=20
> die__process_class: tag not supported 0x33 (variant_part) at =
<4c9c589>!
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> =
not handled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, =
abstract_origin=3D0, specification=3D0x4cb784b
> =E2=AC=A2 [acme@toolbox pahole]$=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
> =E2=AC=A2 [acme@toolbox pahole]$=20
> =E2=AC=A2 [acme@toolbox pahole]$=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
> =E2=AC=A2 [acme@toolbox pahole]$=20
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | =
less
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | =
head
> [1] INT 'DW_ATE_signed_32' size=3D4 bits_offset=3D0 nr_bits=3D32 =
encoding=3DSIGNED
> [2] INT 'DW_ATE_signed_64' size=3D8 bits_offset=3D0 nr_bits=3D64 =
encoding=3DSIGNED
> [3] INT 'DW_ATE_unsigned_1' size=3D1 bits_offset=3D0 nr_bits=3D8 =
encoding=3D(none)
> [4] INT 'DW_ATE_unsigned_8' size=3D1 bits_offset=3D0 nr_bits=3D8 =
encoding=3D(none)
> [5] INT 'DW_ATE_unsigned_64' size=3D8 bits_offset=3D0 nr_bits=3D64 =
encoding=3D(none)
> [6] INT 'DW_ATE_unsigned_32' size=3D4 bits_offset=3D0 nr_bits=3D32 =
encoding=3D(none)
> [7] STRUCT 'tracepoint' size=3D80 vlen=3D9
> 'name' type_id=3D8 bits_offset=3D0
> 'key' type_id=3D12 bits_offset=3D64
> 'static_call_key' type_id=3D23 bits_offset=3D192
> =E2=AC=A2 [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | =
tail
> type_id=3D12300 offset=3D226816 size=3D24 (VAR 'cfd_data')
> type_id=3D12301 offset=3D226880 size=3D8 (VAR 'call_single_queue')
> type_id=3D12302 offset=3D226944 size=3D32 (VAR 'csd_data')
> type_id=3D51838 offset=3D227008 size=3D832 (VAR 'softnet_data')
> type_id=3D54492 offset=3D227840 size=3D24 (VAR 'rt_uncached_list')
> type_id=3D55984 offset=3D227904 size=3D24 (VAR 'rt6_uncached_list')
> type_id=3D8094 offset=3D229376 size=3D64 (VAR 'vmw_steal_time')
> type_id=3D8810 offset=3D229440 size=3D64 (VAR 'apf_reason')
> type_id=3D8811 offset=3D229504 size=3D64 (VAR 'steal_time')
> type_id=3D8813 offset=3D229568 size=3D8 (VAR 'kvm_apic_eoi')
> =E2=AC=A2 [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep =
DW_AT_producer | head
>    <d>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 =
(Fedora 18.1.6-3.fc40)
>    <1be5a>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <1ec5b>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <3bfd5>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <3d11c>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <4fcf0>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <503d5>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <5c067>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <5c42e>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
>    <5efd9>   DW_AT_producer    : (indexed string: 0): clang version =
18.1.6 (Fedora 18.1.6-3.fc40)
> =E2=AC=A2 [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep =
DW_AT_lang | grep -i rust
>    <4c91de1>   DW_AT_language    : 28 (Rust)
>    <4ce66ea>   DW_AT_language    : 28 (Rust)
>    <4cf2cfa>   DW_AT_language    : 28 (Rust)
>    <4cf71a8>   DW_AT_language    : 28 (Rust)
>    <4d2797d>   DW_AT_language    : 28 (Rust)
>    <4d50f34>   DW_AT_language    : 28 (Rust)
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
>  Compilation Unit @ offset 0x4c91dd1:
>   Length:        0x54905 (32-bit)
>   Version:       4
>   Abbrev Offset: 0x244258
>   Pointer Size:  8
> <0><4c91ddc>: Abbrev Number: 1 (DW_TAG_compile_unit)
>    <4c91ddd>   DW_AT_producer    : (indirect string, offset: =
0x282d41): clang LLVM (rustc version 1.80.0 (051478957 2024-07-21) =
(Fedora 1.80.0-1.fc40))
>    <4c91de1>   DW_AT_language    : 28  (Rust)
>    <4c91de3>   DW_AT_name        : (indirect string, offset: =
0x282d91): =
/usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32dfd9e3bca37e-=
cgu.0
>    <4c91de7>   DW_AT_stmt_list   : 0xa1d85f
>    <4c91deb>   DW_AT_comp_dir    : (indirect string, offset: 0x2ebc6): =
/home/acme/git/build/rust-kernel
>    <4c91def>   DW_AT_low_pc      : 0
>    <4c91df7>   DW_AT_ranges      : 0x1e5f0
> <1><4c91dfb>: Abbrev Number: 2 (DW_TAG_variable)
>    <4c91dfc>   DW_AT_name        : (indirect string, offset: =
0x555b60): <usize as core::fmt::Debug>::{vtable}
>    <4c91e00>   DW_AT_type        : <0x4c91e0e>
>    <4c91e04>   DW_AT_location    : 9 byte block: 3 78 34 50 82 ff ff =
ff ff     (DW_OP_addr: ffffffff82503478)
> <1><4c91e0e>: Abbrev Number: 3 (DW_TAG_structure_type)
>    <4c91e0f>   DW_AT_containing_type: <0x4c91e5a>
>    <4c91e13>   DW_AT_name        : (indirect string, offset: =
0x2b3380): <usize as core::fmt::Debug>::{vtable_type}
>    <4c91e17>   DW_AT_byte_size   : 32
>    <4c91e18>   DW_AT_alignment   : 8
> <2><4c91e19>: Abbrev Number: 4 (DW_TAG_member)
>    <4c91e1a>   DW_AT_name        : (indirect string, offset: =
0x313232): drop_in_place
>    <4c91e1e>   DW_AT_type        : <0x4c91e46>
>    <4c91e22>   DW_AT_alignment   : 8
>    <4c91e23>   DW_AT_data_member_location: 0
> <2><4c91e24>: Abbrev Number: 4 (DW_TAG_member)
>    <4c91e25>   DW_AT_name        : (indirect string, offset: =
0x570b7e): size
>    <4c91e29>   DW_AT_type        : <0x4c91e5a>
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf -C "<usize as =
core::fmt::Debug>::{vtable_type}" vmlinux.rust=20
> struct <usize as core::fmt::Debug>::{vtable_type} {
> __SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 */
> usize                      size;                 /*     8     8 */
> usize                      align;                /*    16     8 */
> __SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 */
>=20
> /* size: 32, cachelines: 1, members: 4 */
> /* last cacheline: 32 bytes */
> };
>=20
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole -F btf -C '<core::fmt::Error =
as core::fmt::Debug>::{vtable_type}' vmlinux.rust=20
> struct <core::fmt::Error as core::fmt::Debug>::{vtable_type} {
> __SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 */
> usize                      size;                 /*     8     8 */
> usize                      align;                /*    16     8 */
> __SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 */
>=20
> /* size: 32, cachelines: 1, members: 4 */
> /* last cacheline: 32 bytes */
> };
>=20
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --show_decl_info -F dwarf -C =
Alignment vmlinux.rust=20
> die__process_class: tag not supported 0x33 (variant_part) at =
<4c9c589>!
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> =
not handled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, =
abstract_origin=3D0, specification=3D0x4cb784b
> /* Used at: =
/usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32dfd9e3bca37e-=
cgu.0 */
> /* <4c9c50c> (null):32530 */
> enum Alignment {
> Left    =3D 0,
> Right   =3D 1,
> Center  =3D 2,
> Unknown =3D 3,
> } __attribute__((__packed__));
>=20
> =E2=AC=A2 [acme@toolbox pahole]$ pahole --show_decl_info -F btf -C =
Alignment vmlinux.rust=20
> /* Used at: vmlinux.rust */
> /* <0> (null):0 */
> enum Alignment {
> Left    =3D 0,
> Right   =3D 1,
> Center  =3D 2,
> Unknown =3D 3,
> } __attribute__((__packed__));
>=20
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
> I'll fixup those two:
>=20
> die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> =
not handled in a rust CU!
> tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, =
abstract_origin=3D0, specification=3D0x4cb784
>=20
> I.e. support functions inside enumerations.
>=20
> And sure this will be refused by the kernel, lots of stuff that have
> invalid names, probably need to turn those into void as well as a
> continuation of this hack, then prune, maybe that is it, we'll see.

Rather than voiding the names you can do something like this [0] to
coerce them into a format that the kernel is happy with. We initally
voided names but the resulting BTF was unusable since you couldn=E2=80=99t=

lookup types by name.
=20
A longer term fix is to relax the constraints in `__btf_name_char_ok`
which currently only allows characters that are valid in C
identifiers or part of a well-known section name like =E2=80=9C.rodata=E2=80=
=9D.

Even with relaxed constraints the kernel may still reject the BTF.
One example is the BTF PTR type since the kernel enforces that
name_offset =3D 0. When generating BTF for Rust code from LLVM IR
(and I assume from DWARF too) the name of PTR types is something
like `*const` or `*mut`.

- Dave

0: =
https://github.com/aya-rs/bpf-linker/blob/e4a9267b0fee69ecb2550058d3c8e523=
3f946ebe/src/llvm/di.rs#L34-L59


> Going AFK now.
>=20
> - Arnaldo



