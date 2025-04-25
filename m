Return-Path: <bpf+bounces-56717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CCA9D09E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1231BC40B0
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087A21885D;
	Fri, 25 Apr 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BIs8VeWX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaS4mMNU"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02E1A256E;
	Fri, 25 Apr 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606461; cv=none; b=H5BvjLeAcTyOE49vJUZdlh8r2lFwkMMCwVu88d6dTYiyqRasihKytbRIFrA5D9JdOgckKhmuZmBB2PF+lzfmc5qfJ5UzhGSlinhfdPYRkyt9lwQgOxwtNJeFapSfuIEKA6+v9fcT2uJrJ3H5bLuR4BUqJxMipYjBDfX6GREjBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606461; c=relaxed/simple;
	bh=KP8roe5x3OaKvl7hyNpU3wzG5QEOfl0Luu7GnQu6BxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIkd5xxMMgqFcEd2CdnRPnBwkkd/IMmNvdT5I6zf5UaXSQtR/G3iBsg/p0Hrc7gM7bqhtqDwF9P72bHBCFYTbXVA/1n88WzVGtPlxt3vRWdjgfovpWlj2KY64ypsWy+jJURDtRNr3t6G2V7fo8w58yH1hxHqn5UOvmmiPTugyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BIs8VeWX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaS4mMNU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 39C891140232;
	Fri, 25 Apr 2025 14:40:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 14:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745606457; x=1745692857; bh=bz4wF9TTlh
	ZEFwrPNnb9FAdgOG9sz7R91MKV/Owj6r8=; b=BIs8VeWXWp3sVIXzNjFV5OG6a3
	qJMglnz0yEhtOErweKv9mpoivK4QoEbRdPgPBfJHhTAFPBedqDLvM99b+IPCjtH+
	+RCs6Zzz1/p9aVR/DpGEuqyyBdCtvUcgM/qqElGM4WON2yQkpqpT957xGQTZP9jW
	4mhkPf5/rNMmUsmHuuYLeNX7lmD0ZtYxTBzOWTRSDtmDOHOmb4QUscIVoHBv7RTM
	feVvQIdUYg/igu0YDQ9ivOmNZ7SHpgKgY/anUrY03yirm0KmbinM/FiTeQ7tud3K
	2RneplF4rPAUGaNzdQ7k7EUONQKnQZDCb5dP4ADREopj8j3kXHnerKehE3EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745606457; x=1745692857; bh=bz4wF9TTlhZEFwrPNnb9FAdgOG9sz7R91MK
	V/Owj6r8=; b=DaS4mMNUJl0URu1kn0cToSkZyFVr12Y9DCaV75AOEEYrlxHYLKW
	Ffpo/im51iTonp4UZ2BmLQQKBYtjqf8WHRLG56LJkXjhlfK3mCy8OqIvdZhCnpzi
	ByWz6tk1LcAOg3e87mp32+uZ2Fm1/KKR8eAhUaxlqXHQAYAB92w2cO6Ru+Eayk0h
	AR9XeEZOYVTzsUpKEmblzfRz9Cid0p/yV9U0bwSJwFD30kKVVXmwDKxJNO8JpNON
	MFbwR3hVfcAwwwXhRAcibrN36wgMWCm/ySF5F3cKJ5/tY3YS3G/pBTwiVFaQCoSk
	sSdvxWcIxP3Mlrcxkmzn8yta02xjincDiPw==
X-ME-Sender: <xms:ONcLaISeWyH24Bro9-FN5N3PCaJ_0xJgHJ0a4TiKC2eJh_ZjUyj6eg>
    <xme:ONcLaFwyE2aDo1TIRiFvQEbSMgBU1EeOQXsvEebuU3B7UhyQGDsF7HTA6k9lvCUnj
    wv7gZdizK4aQD4l9g>
X-ME-Received: <xmr:ONcLaF1xm-Fv5uSU-Y9-H9ndwOvkEhv6jMAN3TjzC4c-h9YdpxbxMtl-aVW7LcoCJ1z2HXr60G2RKxmsn-k3W5IrPmxKS-juPokBobIzyMClSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffggeeitdetgfdvhfdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtthhrvgihvghrsehmvghtrgdrtghomhdprhgtphhtthhopegufi
    grrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihhshes
    mhgvthgrrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthht
    ohepshhonhhglhhiuhgsrhgrvhhinhhgsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:ONcLaMA-qCMyvy8tWzlBqR5_TdYW21l5v-FEnb4OH2AveBJ3DBxHyQ>
    <xmx:ONcLaBj8Ruz8GHeU_HktMumKM8bRTdHXYZKksQXcxJ8HQ9bNdr-9IA>
    <xmx:ONcLaIqCvRcrU81Ct6lhBDAq9rcqCPsdZd56zcCulj3dDGwGsrvCBg>
    <xmx:ONcLaEgiztQgBLOuSJWyV_SzEL0-dC19kG6vOweh94khf9UoKvtiyg>
    <xmx:OdcLaD9VdbmXG_uil7a_Wob14TZgnlOu7LjY-b4cBPfRwuuiSKvJQinS>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 14:40:55 -0400 (EDT)
Date: Fri, 25 Apr 2025 12:40:53 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: ttreyer@meta.com
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org, 
	ast@kernel.org, yhs@meta.com, andrii@kernel.org, ihor.solodrai@linux.dev, 
	songliubraving@meta.com, alan.maguire@oracle.com, mykolal@meta.com
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Message-ID: <fcjioco2rdnrupme4gixd4vynh52paudcc7br7smqhmdhdr4js@5uolobs4ycsi>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>

Hi Thierry,

Great progress!

Some high level notes below.

On Wed, Apr 16, 2025 at 07:20:34PM +0000, Thierry Treyer via B4 Relay wrote:
> This proposal extends BTF to list the locations of inlined functions and
> their arguments in a new '.BTF.inline` section.
> 
> == Background ==
> 
> Inline functions are often a blind spot for profiling and tracing tools:
> * They cannot probe fully inlined functions.
>   The BTF contains no data about them.
> * They miss calls to partially inlined functions,
>   where a function has a symbol, but is also inlined in some callers.
> * They cannot account for time spent in inlined calls.
>   Instead, they report the time to the caller.
> * They don't provide a way to access the arguments of an inlined call.
> 
> The issue is exacerbated by Link-Time Optimization, which enables more
> inlining across Object files. One workaround is to disable inlining for
> the profiled functions, but that requires a whole kernel compilation and
> doesn't allow for iterative exploration.
> 
> The information required to solve the above problems is not easily
> accessible. It requires parsing most of the DWARF's '.debug_info` section,
> which is time consuming and not trivial.
> Instead, this proposal leverages and extends the existing information
> contained in '.BTF` (for typing) and '.BTF.ext` (for caller location),
> with information from a new section called '.BTF.inline`,
> listing inlined instances.
> 
> == .BTF.inline Section ==
> 
> The new '.BTF.inline` section has a layout similar to '.BTF`.
> 
>  off |0-bit      |16-bits  |24-bits  |32-bits                           |
> -----+-----------+---------+---------+----------------------------------+
> 0x00 |   magic   | version |  flags  |          header length           |
> 0x08 |      inline info offset       |        inline info length        |
> 0x10 |        location offset        |          location length         |
> -----+------------------------------------------------------------------+
>      ~                        inline info section                       ~
> -----+------------------------------------------------------------------+
>      ~                          location section                        ~
> -----+------------------------------------------------------------------+
> 
> It starts with a header (see 'struct btf_inline_header`),
> followed by two subsections:
> 1. The 'Inline Info' section contains an entry for each inlined function.
>    Each entry describes the instance's location in its caller and is
>    followed by the offsets in the 'Location' section of the parameters
>    location expressions. See 'struct btf_inline_instance`.
> 2. The 'Location' section contains location expressions describing how
>    to retrieve the value of a parameter. The expressions are NULL-
>    terminated and are adressed similarly to '.BTF`'s string table.
> 
> struct btf_inline_header {
>   uint16_t magic;
>   uint8_t version, flags;
>   uint32_t header_length;
>   uint32_t inline_info_offset, inline_info_length;
>   uint32_t location_offset, location_length;
> };
> 
> struct btf_inline_instance {
>   type_id_t callee_id;     // BTF id of the inlined function
>   type_id_t caller_id;     // BTF id of the caller
>   uint32_t caller_offset;  // offset of the callee within the caller
>   uint16_t nr_parms;       // number of parameters
> //uint32_t parm_location[nr_parms];  // offset of the location expression
> };                                   // in 'Location' for each parameter
> 
> == Location Expressions ==
> 
> We looked at the DWARF location expressions for the arguments of inlined
> instances having <= 100 instances, on a production kernel v6.9.0. This
> yielded 176,800 instances with 269,327 arguments. We learned that most
> expressions are simple register access, perhaps with an offset. We would
> get access to 87% of the arguments by implementing literal and register.
> 
> Op. Category      Expr. Count    Expr. %
> ----------------------------------------
> literal                 10714      3.98%
> register+above         234698     87.14%
> arithmetic+above       239444     88.90%
> composite+above        240394     89.26%
> stack+above            242075     89.88%
> empty                   27252     10.12%
> 
> We propose to re-encode DWARF location expressions into a custom BTF
> location expression format. It operates on a stack of values, similar to
> DWARF's location expressions, but is stripped of unused operators,
> while allowing future expansions.

A stack machine seems overkill. I'm certainly not an expert on DWARF
location expressions, but I think we need to get away from arbitrarily
complex expressions, even if they are simpler than DWARF ones. I don't
think we want consumers implementing any kind of interpreter or VM.

I'd vote for something extremely prescriptive, even if it means adding a
lot of enum variants. At least this way, consumers can be sure they've
fully implemented the spec and detect when more complex support is
added.

> 
> A location expression is composed of a series of operations, terminated
> by a NULL-byte/LOC_END_OF_EXPR operator. The very first expression in the
> 'Location' subsection must be an empty expression constisting only of
> LOC_END_OF_EXPR.
> 
> An operator is a tagged union: the tag describes the operation to carry
> out and the union contains the operands.
>  
>  ID | Operator Name        | Operands[...]
> ----+----------------------+-------------------------------------------
>   0 | LOC_END_OF_EXPR      | _none_
>   1 | LOC_SIGNED_CONST_1   |  s8: constant's value
>   2 | LOC_SIGNED_CONST_2   | s16: constant's value
>   3 | LOC_SIGNED_CONST_4   | s32: constant's value
>   4 | LOC_SIGNED_CONST_8   | s64: constant's value
>   5 | LOC_UNSIGNED_CONST_1 |  u8: constant's value
>   6 | LOC_UNSIGNED_CONST_2 | u16: constant's value
>   7 | LOC_UNSIGNED_CONST_4 | u32: constant's value
>   8 | LOC_UNSIGNED_CONST_8 | u64: constant's value
>   9 | LOC_REGISTER         |  u8: DWARF register number from the ABI
>  10 | LOC_REGISTER_OFFSET  |  u8: DWARF register number from the ABI
>                            | s64: offset added to the register's value
>  11 | LOC_DEREF            |  u8: size of the deref'd type
> 
> This list should be further expanded to include arithmetic operations.
> 
> Example: accessing a field at offset 12B from a struct whose adresse is
>          in the '%rdi` register, on amd64, has the following encoding:
> 
> [0x0a 0x05 0x000000000000000c] [0x0b 0x04] [0x00]
>  |    |    ` Offset Added       |    |      ` LOC_END_OF_EXPR
>  |    ` Register Number         |    ` Size of Deref.
>  ` LOC_REGISTER_OFFSET          ` LOC_DEREF
> 
> == Summary ==
> 
> Combining the new information from '.BTF.inline` with the existing data
> from '.BTF` and '.BTF.ext`, tools will be able to locate inline functions
> and their arguments. Symbolizer can also use the data to display the
> functions inlined at a given address.
> 
> Fully inlined functions are not part of the BTF and thus are not covered
> by this proposal. Adding them to the BTF would enable their coverage and
> should be considered.

I think supporting fully inlined functions as part of this work would
add a lot of value to users. It doesn't necessarily have to happen in
the first patchset, but we probably want to plan on doing it.

Regarding BTF, another option is to just leave `callee_id` unset, right?
Consumers should be able to recognize BTF for the inlined function isn't
available and then act accordingly. For bpftrace, that probably means
not allowing function argument access.

[...]

Thanks,
Daniel

