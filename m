Return-Path: <bpf+bounces-57704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70BAAECA3
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543A39C68C9
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776C1F4CAF;
	Wed,  7 May 2025 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="At7cl8Pt"
X-Original-To: bpf@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEA2F43;
	Wed,  7 May 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648178; cv=none; b=V9j36WzS+cIM4kNghYXf2Cm4pas5uJ0TqjXrMJ3KHX2B1aeAUVV/qaD/dE7inUTq6HeGgMiwuvyODECFF0xHr8bWafY5rSOmzdY5ftZ3xByqmVkIm6Wad7PNqf0ECWbt+kBz8yOfMsL2w+aLmGKyhhQi2gcWwnLCvPkAYyESXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648178; c=relaxed/simple;
	bh=E9gpD6JpLc7tLB2g+2COMuay82yYHklGtQHt2pGDML0=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Mime-Version; b=XvdLJEt6sq0nrxODg10t3achJLHw19f30LBU3X3Zsr91gSdw+lb7HAYId2yyjL7pm5q+NyYehMmNS+lXt/LDtpoKjIukbcp3XgtgfKz6xGN2RE59cApy2QwwDqL8rNpPake77gnwOT+cAc39jQzw+Mo9m3cz0qlP1LSFdzskJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=At7cl8Pt; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4AAA443A3;
	Wed,  7 May 2025 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746648173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2HgFD6a8LnlRfTyZyu9RdZE/OczS2Z80nyuH0snbVM=;
	b=At7cl8PtLxc1TEelZDHDWhBYenWj6A7kQXpUHBV+6N0In6tz9sq+KwGRiCrAGqsXIWmyOj
	TIfjGfmyspOeXm0WGMeaekR1W6tuIs0cCwXFSX7f3ddvZ99CP1Mhvfoqe+ox9aP17c7GX8
	lZShqPnIZ7cl/rGu2KvCYJWS29pXoI9rgkjW/XOoC59wVYZKmm0CEbPRZ9hFxs09XFewyt
	j9mxLWFP+fC4wk8/+8KV3B77rD5RpFz9NZVj0Ddn/rLcvfZk3LMon8WkzFI1mWHfFk3dwW
	srOko7k+k1AQO1vT0ZIigNmEIxVVhv6AqIeNpwY1QQbS1usEK25K058MRGmeMg==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 May 2025 22:02:51 +0200
Message-Id: <D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alan Maguire"
 <alan.maguire@oracle.com>, <bpf@vger.kernel.org>, <dwarves@vger.kernel.org>
Subject: Pahole/BTF issue with __int128
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkhffvufgggffosehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueduhfegkeekvdeutdeigeeihedujeevueelueelheehveeltdeutefftdehkedunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmeguieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemugeihedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhor
 hhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

I am working on some ebpf feature for ARM64 (improving trampolines to
attach tracing programs to functions with more arguments than the current
limit), and I am facing an issue with the generated BTF information when
playing with large int types like __int128 (I need to use those large types
to properly test some architecture-specific alignment expectations). I
suspect the issue to be in pahole, but I would like to get some opinions on
my observations, and maybe some guidance on where to look at to go further.

I would like to attach some fentry/fexit programs to the following kind of
function, which is currently defined in a kernel module (bpf_testmod.ko in
bpf selftests):

  struct bpf_testmod_struct_arg_7 {
  	_int128 a;
  };
 =20
  noinline int bpf_testmod_test_struct_arg_11(
  	struct bpf_testmod_struct_arg_7 a,
  	struct bpf_testmod_struct_arg_7 b,
  	struct bpf_testmod_struct_arg_7 c,
  	struct bpf_testmod_struct_arg_7 d,
  	short e,
  	struct bpf_testmod_struct_arg_7 f)
  {
  	[...]
  }

This one works well (let's call it case 1), I am able to attach
fentry/fexit programs to such function through libbpf.

However, if, in a case 2, I change the bpf_testmod_test_struct_arg_11
prototype to use __in128 arguments instead of struct arguments, like the
following one:

  noinline int bpf_testmod_test_struct_arg_11(
  	__int128 a,
  	__int128 b,
  	__int128 c,
  	__int128 d,
  	short e,
  	__int128 f)
  {
  	[...]
  }

and rebuild the module/run my test, this does not work anymore, and libbpf
complains with the following error:
  libbpf: prog 'test_struct_many_args_9': failed to find kernel BTF type ID
  of 'bpf_testmod_test_struct_arg_11': -ESRCH

Inspecting the generated BTF information in bpf_testmod.ko file with bpftoo=
l, I
indeed find some BTF info related to my target func in case 1 but not in
case 2:

  [...]
  [118] STRUCT 'bpf_testmod_struct_arg_7' size=3D16 vlen=3D1
          'a' type_id=3D10 bits_offset=3D0
  [...]
  [371] FUNC_PROTO '(anon)' ret_type_id=3D6 vlen=3D6
          'a' type_id=3D118
          'b' type_id=3D118
          'c' type_id=3D118
          'd' type_id=3D118
          'e' type_id=3D5
          'f' type_id=3D118
  [372] FUNC 'bpf_testmod_test_struct_arg_11' type_id=3D371 linkage=3Dstati=
c
  [...]

I checked the command executed by the kernel build system to generate BTF
info for the module, and got the following one:
  pahole -J -j\
  --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimize=
d_func,consistent_func,decl_tag_kfuncs\
  --btf_features=3Dattributes --lang_exclude=3Drust\
  --btf_features=3Ddistilled_base --btf_base vmlinux\
  tools/testing/selftests/bpf/bpf_testmod.ko

I ran the same command before/after switching the struct arguments to
__int128, and made the same observation (I am running pahole 1.30). I then
took a look at available DWARF info available in bpf_testmod.ko for pahole
to generate BTF info, and AFAICT, it looks ok (to be confirmed ?) in both
cases (I am using an aarch64-linux-gcc toolchain, v13.2.0 from
https://toolchains.bootlin.com/)

Case 1:

  [...]
  <1><262>: Abbrev Number: 106 (DW_TAG_base_type)
     <263>   DW_AT_byte_size   : 16
     <264>   DW_AT_encoding    : 5       (signed)
     <265>   DW_AT_name        : (indirect string, offset: 0x193bc): __int1=
28
  [...]
  <1><23429>: Abbrev Number: 11 (DW_TAG_structure_type)
     <2342a>   DW_AT_name        : (indirect string, offset: 0xe98d): bpf_t=
estmod_struct_arg_7
     <2342e>   DW_AT_byte_size   : 16
     <2342f>   DW_AT_decl_file   : 1
     <23430>   DW_AT_decl_line   : 70
     <23431>   DW_AT_decl_column : 8
     <23432>   DW_AT_sibling     : <0x23442>
  <2><23436>: Abbrev Number: 12 (DW_TAG_member)
     <23437>   DW_AT_name        : a
     <23439>   DW_AT_decl_file   : 1
     <2343a>   DW_AT_decl_line   : 71
     <2343b>   DW_AT_decl_column : 11
     <2343c>   DW_AT_type        : <0x262>
     <23440>   DW_AT_data_member_location: 0
  [...]
  <1><295c1>: Abbrev Number: 99 (DW_TAG_subprogram)
     <295c2>   DW_AT_external    : 1
     <295c2>   DW_AT_name        : (indirect string, offset: 0x5e20): bpf_t=
estmod_test_struct_arg_11
     <295c6>   DW_AT_decl_file   : 1
     <295c7>   DW_AT_decl_line   : 152
     <295c8>   DW_AT_decl_column : 14
     <295c9>   DW_AT_prototyped  : 1
     <295c9>   DW_AT_type        : <0xdd>
     <295cd>   DW_AT_low_pc      : 0x1380
     <295d5>   DW_AT_high_pc     : 0x34
     <295dd>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_=
cfa)
     <295df>   DW_AT_GNU_all_call_sites: 1
     <295df>   DW_AT_sibling     : <0x2964a>
  <2><295e3>: Abbrev Number: 45 (DW_TAG_formal_parameter)
     <295e4>   DW_AT_name        : a
     <295e6>   DW_AT_decl_file   : 1
     <295e7>   DW_AT_decl_line   : 152
     <295e8>   DW_AT_decl_column : 77
     <295e9>   DW_AT_type        : <0x23429>
     <295ed>   DW_AT_location    : 0x6196 (location list)
     <295f1>   DW_AT_GNU_locviews: 0x6194
  [...]

Case 2:

  [...]
  <1><262>: Abbrev Number: 106 (DW_TAG_base_type)
     <263>   DW_AT_byte_size   : 16
     <264>   DW_AT_encoding    : 5       (signed)
     <265>   DW_AT_name        : (indirect string, offset: 0x1935d): __int1=
28
  [...]
   <1><29552>: Abbrev Number: 98 (DW_TAG_subprogram)
      <29553>   DW_AT_external    : 1
      <29553>   DW_AT_name        : (indirect string, offset: 0x5e20): bpf_=
testmod_test_struct_arg_11
      <29557>   DW_AT_decl_file   : 1
      <29558>   DW_AT_decl_line   : 148
      <29559>   DW_AT_decl_column : 14
      <2955a>   DW_AT_prototyped  : 1
      <2955a>   DW_AT_type        : <0xdd>
      <2955e>   DW_AT_low_pc      : 0x1380
      <29566>   DW_AT_high_pc     : 0x34
      <2956e>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame=
_cfa)
      <29570>   DW_AT_GNU_all_call_sites: 1
      <29570>   DW_AT_sibling     : <0x295d6>
   <2><29574>: Abbrev Number: 46 (DW_TAG_formal_parameter)
      <29575>   DW_AT_name        : a
      <29577>   DW_AT_decl_file   : 1
      <29578>   DW_AT_decl_line   : 148
      <29579>   DW_AT_decl_column : 54
      <2957a>   DW_AT_type        : <0x262>
      <2957e>   DW_AT_location    : 0x6158 (location list)
      <29582>   DW_AT_GNU_locviews: 0x6154
  [...]

Am I missing some constraint or limitation that would prevent the case 2
function from being described with BTF info ? If not, any advice about how
to debug this further ?

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

