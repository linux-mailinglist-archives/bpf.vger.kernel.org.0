Return-Path: <bpf+bounces-48486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBEA082D9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749C37A37E7
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05908205E0C;
	Thu,  9 Jan 2025 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK1MoFE9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906D1FBC94;
	Thu,  9 Jan 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462368; cv=none; b=rk+OjrexwCv1SS2oHMK3WcIi3sOBv1rovK1OgyUizZEEp32Qwa/bXZ4GSfIVrK7iT0jbVQhpnVzAXIEl1+iSea3ugWYY5o+Ko1P/4WDmEL8jkBcuqQ3WCEmkY80eU+poduw1K6OWE7IPSTHZfsHPgDUPgkgPhfcxmX2xElwUSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462368; c=relaxed/simple;
	bh=KgR7gFLRskON8FZvx4SMG0MjcWbEh8wMoMZ0Le3K/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2Zh60rfSu/Ov/sgT/NgiL//vyFLCMl4K2pNHf2TOb5o49i2Z2KCZAOwJ42Atv7C7/bENoMjNAZ7+yhcpupEAhk5NCYPO4bZXU85TFfnCJkqaooIDCLU5EsuHHgFohvU8U2crrAchW6bLhgKNGpzOucsYI+iHZtm6eh2erCU+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK1MoFE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57648C4CED2;
	Thu,  9 Jan 2025 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736462366;
	bh=KgR7gFLRskON8FZvx4SMG0MjcWbEh8wMoMZ0Le3K/WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kK1MoFE9Rjp59/2st91oLgcqM6Pmf6oq2afDWy1Av1IGXXGsjv8Yds9WY0nlUcYVw
	 4K8xHzkY1CvPv3gJRjRBASVEBM/ot5DK8/hBSTxqXBJ45aPzkcZ6IhGnpUbB7qz0m9
	 v7Vj/5m/ioimHo9zkIBpKy4Xh10kPoL8AHku9kU/GCF+ylfwZnrPXU225bnB+4A5Nf
	 2cys/S/VmkuzkyT+6OsMlptXhj5U9VXfMbdDFMrqjz99iKnd0sp8r50IWpwuXhffSt
	 S7o6magInnqTqgq2ghx2/f+LHoeJr8PP0g4ePN61JWXV3whCI3+YWzSgh3drGT1O24
	 i3JpsZebQWjPA==
Date: Thu, 9 Jan 2025 19:39:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Matthias Maennich <maennich@google.com>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Curtin <ecurtin@redhat.com>,
	Martin Reboredo <yakoyoku@gmail.com>,
	Alessandro Decina <alessandro.d@gmail.com>,
	Michal Rostecki <vadorovsky@protonmail.com>,
	Dave Tucker <dave@dtucker.co.uk>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
Message-ID: <Z4BQG3rmYNDS5W0Z@x1>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1>
 <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
 <Z3_5eGD_F1_ZxfqE@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3_5eGD_F1_ZxfqE@x1>

On Thu, Jan 09, 2025 at 01:29:47PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 10:49:49AM -0500, Tamir Duberstein wrote:
> > On Thu, Jan 9, 2025 at 10:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > I was thinking about it after reading this thread yesterday, i.e. we
> > > could encode constructs from Rust that can be represented in BTF and
> > > skip the ones that can't, pruning types that depend on non BTF
> > > representable types, etc.
>  
> > Yep, this is what bpf-linker does, along with some other things[0]. I
> > highly recommend reading the code I linked to avoid re-discovering
> > these things.
> 
> Sure, thanks for pointing it out and suggest I read it while
> experimenting with having the same concept in pahole, I'll try a quick
> hack and then look at it to see how close I got to what you guys came up
> with :-)

So I didn't manage to work on this today, just this quick hack:

⬢ [acme@toolbox pahole]$ git diff
diff --git a/btf_encoder.c b/btf_encoder.c
index 78efd705333e2e52..5610e0902f2cd347 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1559,7 +1559,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
        default:
                fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
                        dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
-               return -1;
+               return 0;
        }
 }
 
⬢ [acme@toolbox pahole]$

Which essentially encodes any DWARF tag that the BTF encoder doesn't
know about into 'void'.

Super quick hack, I still have to look at the implications, but some
results:

⬢ [acme@toolbox pahole]$ cp ../build/rust-kernel/vmlinux vmlinux.rust
⬢ [acme@toolbox pahole]$ pahole --btf_encode vmlinux.rust 
die__process_class: tag not supported 0x33 (variant_part) at <4c9c589>!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not handled in a rust CU!
tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstract_origin=0, specification=0x4cb784b
⬢ [acme@toolbox pahole]$ 
⬢ [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
⬢ [acme@toolbox pahole]$ 
⬢ [acme@toolbox pahole]$ 
⬢ [acme@toolbox pahole]$ pahole -F btf vmlinux.rust | less
⬢ [acme@toolbox pahole]$ 
⬢ [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | less
⬢ [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | head
[1] INT 'DW_ATE_signed_32' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] INT 'DW_ATE_signed_64' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[3] INT 'DW_ATE_unsigned_1' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[4] INT 'DW_ATE_unsigned_8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[5] INT 'DW_ATE_unsigned_64' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[6] INT 'DW_ATE_unsigned_32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] STRUCT 'tracepoint' size=80 vlen=9
	'name' type_id=8 bits_offset=0
	'key' type_id=12 bits_offset=64
	'static_call_key' type_id=23 bits_offset=192
⬢ [acme@toolbox pahole]$ bpftool btf dump file vmlinux.rust | tail
	type_id=12300 offset=226816 size=24 (VAR 'cfd_data')
	type_id=12301 offset=226880 size=8 (VAR 'call_single_queue')
	type_id=12302 offset=226944 size=32 (VAR 'csd_data')
	type_id=51838 offset=227008 size=832 (VAR 'softnet_data')
	type_id=54492 offset=227840 size=24 (VAR 'rt_uncached_list')
	type_id=55984 offset=227904 size=24 (VAR 'rt6_uncached_list')
	type_id=8094 offset=229376 size=64 (VAR 'vmw_steal_time')
	type_id=8810 offset=229440 size=64 (VAR 'apf_reason')
	type_id=8811 offset=229504 size=64 (VAR 'steal_time')
	type_id=8813 offset=229568 size=8 (VAR 'kvm_apic_eoi')
⬢ [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep DW_AT_producer | head
    <d>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <1be5a>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <1ec5b>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <3bfd5>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <3d11c>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <4fcf0>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <503d5>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <5c067>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <5c42e>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
    <5efd9>   DW_AT_producer    : (indexed string: 0): clang version 18.1.6 (Fedora 18.1.6-3.fc40)
⬢ [acme@toolbox pahole]$ readelf -wi vmlinux.rust | grep DW_AT_lang | grep -i rust
    <4c91de1>   DW_AT_language    : 28	(Rust)
    <4ce66ea>   DW_AT_language    : 28	(Rust)
    <4cf2cfa>   DW_AT_language    : 28	(Rust)
    <4cf71a8>   DW_AT_language    : 28	(Rust)
    <4d2797d>   DW_AT_language    : 28	(Rust)
    <4d50f34>   DW_AT_language    : 28	(Rust)
⬢ [acme@toolbox pahole]$

  Compilation Unit @ offset 0x4c91dd1:
   Length:        0x54905 (32-bit)
   Version:       4
   Abbrev Offset: 0x244258
   Pointer Size:  8
 <0><4c91ddc>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <4c91ddd>   DW_AT_producer    : (indirect string, offset: 0x282d41): clang LLVM (rustc version 1.80.0 (051478957 2024-07-21) (Fedora 1.80.0-1.fc40))
    <4c91de1>   DW_AT_language    : 28  (Rust)
    <4c91de3>   DW_AT_name        : (indirect string, offset: 0x282d91): /usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32dfd9e3bca37e-cgu.0
    <4c91de7>   DW_AT_stmt_list   : 0xa1d85f
    <4c91deb>   DW_AT_comp_dir    : (indirect string, offset: 0x2ebc6): /home/acme/git/build/rust-kernel
    <4c91def>   DW_AT_low_pc      : 0
    <4c91df7>   DW_AT_ranges      : 0x1e5f0
 <1><4c91dfb>: Abbrev Number: 2 (DW_TAG_variable)
    <4c91dfc>   DW_AT_name        : (indirect string, offset: 0x555b60): <usize as core::fmt::Debug>::{vtable}
    <4c91e00>   DW_AT_type        : <0x4c91e0e>
    <4c91e04>   DW_AT_location    : 9 byte block: 3 78 34 50 82 ff ff ff ff     (DW_OP_addr: ffffffff82503478)
 <1><4c91e0e>: Abbrev Number: 3 (DW_TAG_structure_type)
    <4c91e0f>   DW_AT_containing_type: <0x4c91e5a>
    <4c91e13>   DW_AT_name        : (indirect string, offset: 0x2b3380): <usize as core::fmt::Debug>::{vtable_type}
    <4c91e17>   DW_AT_byte_size   : 32
    <4c91e18>   DW_AT_alignment   : 8
 <2><4c91e19>: Abbrev Number: 4 (DW_TAG_member)
    <4c91e1a>   DW_AT_name        : (indirect string, offset: 0x313232): drop_in_place
    <4c91e1e>   DW_AT_type        : <0x4c91e46>
    <4c91e22>   DW_AT_alignment   : 8
    <4c91e23>   DW_AT_data_member_location: 0
 <2><4c91e24>: Abbrev Number: 4 (DW_TAG_member)
    <4c91e25>   DW_AT_name        : (indirect string, offset: 0x570b7e): size
    <4c91e29>   DW_AT_type        : <0x4c91e5a>

⬢ [acme@toolbox pahole]$ pahole -F btf -C "<usize as core::fmt::Debug>::{vtable_type}" vmlinux.rust 
struct <usize as core::fmt::Debug>::{vtable_type} {
	__SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 */
	usize                      size;                 /*     8     8 */
	usize                      align;                /*    16     8 */
	__SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 */

	/* size: 32, cachelines: 1, members: 4 */
	/* last cacheline: 32 bytes */
};

⬢ [acme@toolbox pahole]$

⬢ [acme@toolbox pahole]$ pahole -F btf -C '<core::fmt::Error as core::fmt::Debug>::{vtable_type}' vmlinux.rust 
struct <core::fmt::Error as core::fmt::Debug>::{vtable_type} {
	__SANITIZED_FAKE_INT__ *   drop_in_place;        /*     0     8 */
	usize                      size;                 /*     8     8 */
	usize                      align;                /*    16     8 */
	__SANITIZED_FAKE_INT__ *   __method3;            /*    24     8 */

	/* size: 32, cachelines: 1, members: 4 */
	/* last cacheline: 32 bytes */
};

⬢ [acme@toolbox pahole]$

⬢ [acme@toolbox pahole]$ pahole --show_decl_info -F dwarf -C Alignment vmlinux.rust 
die__process_class: tag not supported 0x33 (variant_part) at <4c9c589>!
die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not handled in a rust CU!
tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstract_origin=0, specification=0x4cb784b
/* Used at: /usr/lib/rustlib/src/rust/library/core/src/lib.rs/@/core.3f32dfd9e3bca37e-cgu.0 */
/* <4c9c50c> (null):32530 */
enum Alignment {
	Left    = 0,
	Right   = 1,
	Center  = 2,
	Unknown = 3,
} __attribute__((__packed__));

⬢ [acme@toolbox pahole]$ pahole --show_decl_info -F btf -C Alignment vmlinux.rust 
/* Used at: vmlinux.rust */
/* <0> (null):0 */
enum Alignment {
	Left    = 0,
	Right   = 1,
	Center  = 2,
	Unknown = 3,
} __attribute__((__packed__));

⬢ [acme@toolbox pahole]$

I'll fixup those two:

die__create_new_enumeration: DW_TAG_subprogram (0x2e) @ <0x4cb784b> not handled in a rust CU!
tag__recode_dwarf_type: couldn't find name for function 0x4cd72bf, abstract_origin=0, specification=0x4cb784

I.e. support functions inside enumerations.

And sure this will be refused by the kernel, lots of stuff that have
invalid names, probably need to turn those into void as well as a
continuation of this hack, then prune, maybe that is it, we'll see.

Going AFK now.

- Arnaldo

