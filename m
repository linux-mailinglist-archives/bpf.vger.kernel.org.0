Return-Path: <bpf+bounces-18360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28D819726
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9771C2555C
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00208C06;
	Wed, 20 Dec 2023 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gidj2hWw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E8BEB
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so5000536f8f.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703042902; x=1703647702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9POoxbdNum3UVcHqKRpm9QHWYivjj/110SpNeUmOkA=;
        b=gidj2hWw31oVF9BAbAj984zdLfyl05JluRIxzZkOcWM9AsyPW6U55AHLUhHzNdORsX
         r35wGW96tn66kvJQNoVtjRCxUezJQpA3oNK/eEFWO8wRVLEZrh1Vtm/hMoaxH4oy0el+
         FOEcpgurD7DG5R2w5QoHvlwQ5cAwB+7yeYJh3WZEIUwyTwOeUK6bXk1h17xykrcMjcpE
         m2/SO+oPJPzsXa9bdMujbXQFTLOOQPtiBXyzOBe/m2PrR1D8B6WyUZwBtFrxZiTbAiUO
         yxsRPhJhV409W2JL19/kOMbmCMFi2bfMzyrP3tlUfgsEUgdA5d+r4siVBjcvOnvlirro
         sd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042902; x=1703647702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9POoxbdNum3UVcHqKRpm9QHWYivjj/110SpNeUmOkA=;
        b=xG4vOXtV8GWnOODiJBLtzT38tfE291mhYZlKWSLmWiQgXvtF8lgHD6JxLbr0O+gtmZ
         b21tGvJI+1LNUFrlkmXkEbQXDI+S0DpZnTbZnQgEtaQVEjheNgmyl+oZSgyIRFDxXMm0
         nyxhNIuvviQikoi05wgLMktFRGk1gCJ3uf4q98QA1UMhzwLhKwq4hma/zjfpzPY4RMJD
         Ft323PHT1oWJkfs5DIg0tBmGuB2Ec66dFGN0FpzBvsvDkDoOTbxrzplk1fya4hW+QGDe
         RwtO0hk3x3zAyg7PD7AeYGspfFqSXKkXMmu25ePa3x608ru+ItkVCBeXDjwaL4l/CMJW
         04Yw==
X-Gm-Message-State: AOJu0YxSVTJUZdr4ZC4Fh7k9k2CQeMY8+LYiBtjRLTUBmxcvq4Nh1vBT
	mpTFr7i6r1BZNf9NIn/c7+jGak9UBxDkJNIZxms=
X-Google-Smtp-Source: AGHT+IEePuYmZLehmROlU5HnWN74KQqvOsRUHfYU7b7m+KYIHIwiAoxXQeQqIpcVQVMc0XTFAKATuyiGPoVnQdmKqAk=
X-Received: by 2002:a5d:50c7:0:b0:336:7050:a4d1 with SMTP id
 f7-20020a5d50c7000000b003367050a4d1mr965616wrt.194.1703042901602; Tue, 19 Dec
 2023 19:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge> <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge> <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com> <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
In-Reply-To: <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 19:28:10 -0800
Message-ID: <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Vernet <void@manifault.com>, bpf@ietf.org, 
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:10=E2=80=AFAM <dthaler1968@googlemail.com> wrote=
:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Monday, December 18, 2023 5:15 PM
> > To: Christoph Hellwig <hch@infradead.org>
> > Cc: David Vernet <void@manifault.com>; Dave Thaler
> > <dthaler1968@googlemail.com>; bpf@ietf.org; bpf <bpf@vger.kernel.org>;
> > Jakub Kicinski <kuba@kernel.org>
> > Subject: Re: [Bpf] BPF ISA conformance groups
> >
> > On Thu, Dec 14, 2023 at 9:29=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org>
> > wrote:
> > >
> > > We need the concept in the spec just to allow future extensability.
> >
> > Completely agree that the concept of the groups is necessary.
> >
> > I'm arguing that what was proposed:
> > 1. "basic": all instructions not covered by another group below.
> > 2. "atomic": all Atomic operations.
> > 3. "divide": all division and modulo operations.
> > 4. "legacy": all legacy packet access instructions (deprecated).
> > 5. "map": 64-bit immediate instructions that deal with map fds or map
> > indices.
> > 6. "code": 64-bit immediate instruction that has a "code pointer" type.
> > 7. "func": program-local functions.
> >
> > logically makes sense, but might not work for HW (based on the history =
of nfp
> > offload).
> > imo "basic" and "legacy" won't work either.
> > So it's a lesser evil.
> >
> > Anyway, let's look at:
> >
> >    | BPF_CALL | 0x8   | 0x0 | call helper         | see Helper        |
> >    |          |       |     | function by address | functions         |
> >    |          |       |     |                     | (Section 3.3.1)   |
> >    +----------+-------+-----+---------------------+-------------------+
> >    | BPF_CALL | 0x8   | 0x1 | call PC +=3D imm      | see Program-local=
 |
> >    |          |       |     |                     | functions         |
> >    |          |       |     |                     | (Section 3.3.2)   |
> >    +----------+-------+-----+---------------------+-------------------+
> >    | BPF_CALL | 0x8   | 0x2 | call helper         | see Helper        |
> >    |          |       |     | function by BTF ID  | functions         |
> >    |          |       |     |                     | (Section 3.3.
> >
> > Having separate category 7 for single insn BPF_CALL 0x8 0x1 while keepi=
ng 0x8
> > 0x0 and 0x8 0x2 in "basic" seems just as logical as having atomic_add i=
nsn in
> > "basic" instead of "atomic".
>
> If a platform exposes no helper functions, then 0x8 0x0 and 0x8 0x2 have =
no
> meaning and in my view don't need a separate conformance group since a
> program using them would fail the verifier anyway.

Right, but bringing the verifier into the "compliance picture"
makes the ISA standard incomplete.
Same can be said about nfp compliance. It's compliant with an ISA,
but the verifier will reject things it doesn't support.
The instruction groups need to be binary from compliance pov
without external input.

I think if we move one call 8 1 into a separate group we
better move all call flavors into the same group or have 3 groups
for 3 different flavors of calls.

> 0x8 0x1 on the other hand wouldn't be invalid just due to the imm value,
> and so tools (compiler, verifier, whatever) need some other way to know w=
hether
> it's supported, hence the conformance group.
>
> > Then we have several kinds of ld_imm64. Sounds like the idea is to spli=
t 0x18
> > 0x4 into "code" and the rest into "map" group?
> > Is it logical or not?
>
> I don't know of another easy way for a tool like a compiler (LLVM, gcc, r=
ust compiler,
> etc.) to know whether map instructions are legal or not.
>
> That said, I think map_val() is problematic for a cross-platform compiler=
...
> https://elixir.bootlin.com/linux/latest/source/Documentation/bpf/linux-no=
tes.rst says
> "Linux only supports the 'map_val(map)' operation on array maps with a si=
ngle element."
> Now if one platform supports it on one type of map and another platform d=
oesn't, then
> the compiler has to magically know whether to allow this optimization (co=
mpared to
> requiring using a helper function to access the map value) or not.

Compiler has no idea.
All ld_imm64 and call insns look the same. The compiler emits
them the same way.
The src_reg encoding is what libbpf does based on compiler relocations.

Then the verifier checks them differently and later JIT sees
_all_ ld_imm64 as one type of instruction.
Same with call insn. To x86/arm64/riscv JITs there is only one BPF CALL ins=
n.

>
> > Maybe we should do risc-v like group instead?
> > Just these 4:
> > - Base Integer Instruction Set, 32-bit
> > - Base Integer Instruction Set, 64-bit
>
> If there's platforms that would support one of the above and not the othe=
r
> (are there?) then I agree splitting them would make sense.

nfp is an example. It kinda sorta supports 64-bit, but very much
prefers 32.
All 32-bit architectures is another example.
They JIT nicely all 32-bit ops and struggle with 64.

