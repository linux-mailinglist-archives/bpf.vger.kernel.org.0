Return-Path: <bpf+bounces-56866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9BA9F9E9
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 21:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8421A85D9B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227502951C9;
	Mon, 28 Apr 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqa0dH4S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BB7083A;
	Mon, 28 Apr 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869815; cv=none; b=KekFiIhrAYQFeI62GbEp4fg+3aha6n4Ub+urVkAqXTk7tEp50h9iRI/6SFHSgVqbXCY76O1vdTja79kl38SFlqmppbK0NGnAhfIQaWrNV/MWN6D5tbdaVnBSAHBCV330sngw3BrDuha8zYiBM9RtXhOV3BdguKHe2174Z1vTGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869815; c=relaxed/simple;
	bh=lkbYq4REnJDZhuH28k4k8yOR9U90vI9oy52xIRVpdNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/bNu4pGSwyMeXI+DclN7IYP1Y+LTwiXkQVKgmBHIgR2IIwa4RPlXeCLkhQmgkwL6IX6ik/a/ZJeNdTMUd7A8r/HX25z8h2/aqPidgt4jtEbyNkNCjL6/c4UJaBxexNHLwA9Og5se2YawoR40jjuegu2QGx3gD1AGVgRWu13xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqa0dH4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065BDC4CEE4;
	Mon, 28 Apr 2025 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869815;
	bh=lkbYq4REnJDZhuH28k4k8yOR9U90vI9oy52xIRVpdNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqa0dH4SacEVWkVDwzZtL1+jb7iPn8MFXBg/C+Xxwa1o8G8JtvS+YFWswJTUZA6Db
	 NBP3yDv1XJw2f5rgDj3NaHXwA5ZbY9oMy7NrY/hD6dkOIhvhB0ZrPd1GAVlbf9SNlt
	 hbBYITArFmTUm+O8ohO5OfUZ8OvCH2w0D70NZWzebHvWeLz3M8Jx2evraNZ+xjyndr
	 mzUbNXysbdLIsUNRBRvrsQYfvjcwYTjoOnSAEycTyFlOvm9Qd6Vnf/fnosF71gXy9q
	 uloCr55VTp2zqLY89r7U0kMj4iWD6BRCGYirxtsqt8LY03sOR5GIzkRnefGRBwgXal
	 c8QvAmuHQwoFQ==
Date: Mon, 28 Apr 2025 16:50:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
	dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
Message-ID: <aA_b9N89lHeVSm1b@x1>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
 <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
 <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <aA_Yo6v7qicMy9xk@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aA_Yo6v7qicMy9xk@x1>

On Mon, Apr 28, 2025 at 04:36:07PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 28, 2025 at 04:21:14PM +0100, Alan Maguire wrote:
> > In the bad case, the bpf_prog active member:
>  
> > <2><3d594>: Abbrev Number: 4 (DW_TAG_member)
> >     <3d595>   DW_AT_name        : (indirect string, offset: 0x3b976): active
> >     <3d599>   DW_AT_decl_file   : 125
> >     <3d59a>   DW_AT_decl_line   : 1654
> >     <3d59c>   DW_AT_decl_column : 17
> >     <3d59d>   DW_AT_type        : <0x4bd05>
>  
> > ...is a pointer:
> > 
> >  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
> >     <4bd06>   DW_AT_byte_size   : 8
> >     <4bd07>   DW_AT_address_class: 2
> >     <4bd08>   DW_AT_type        : <0x301cd>
>  
> > ...which points at an int
>  
> >  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
> >     <301cf>   DW_AT_byte_size   : 4
> >     <301d0>   DW_AT_encoding    : 5     (signed)
> >     <301d1>   DW_AT_name        : int
> >     <301d5>   DW_AT_name        : int
>  
> > ...but note the the DW_AT_address_class attribute in the latter case and
> > the two DW_AT_name values. We don't use that address attribute in pahole
> > as far as I can see, but it might be enough to cause problems.

I just looked at a vmlinux built with gcc 15 and we have those:

 <1><7812a39>: Abbrev Number: 7 (DW_TAG_structure_type)
    <7812a3a>   DW_AT_name        : (indirect string, offset: 0xc0e4): alloc_tag_counters
    <7812a3e>   DW_AT_byte_size   : 16
    <7812a3f>   DW_AT_decl_file   : 76
    <7812a40>   DW_AT_decl_line   : 18
    <7812a41>   DW_AT_decl_column : 8
    <7812a42>   DW_AT_sibling     : <0x7812a61>
 <2><7812a46>: Abbrev Number: 1 (DW_TAG_member)
    <7812a47>   DW_AT_name        : (indirect string, offset: 0x3c288f): bytes
    <7812a4b>   DW_AT_decl_file   : 76
    <7812a4c>   DW_AT_decl_line   : 19
    <7812a4d>   DW_AT_decl_column : 6
    <7812a4e>   DW_AT_type        : <0x780f217>
    <7812a52>   DW_AT_data_member_location: 0
 <2><7812a53>: Abbrev Number: 1 (DW_TAG_member)
    <7812a54>   DW_AT_name        : (indirect string, offset: 0x255770): calls
    <7812a58>   DW_AT_decl_file   : 76
    <7812a59>   DW_AT_decl_line   : 20
    <7812a5a>   DW_AT_decl_column : 6
    <7812a5b>   DW_AT_type        : <0x780f217>
    <7812a5f>   DW_AT_data_member_location: 8

 <1><7812a88>: Abbrev Number: 80 (DW_TAG_pointer_type)
    <7812a89>   DW_AT_byte_size   : 8
    <7812a89>   DW_AT_address_class: 2
    <7812a89>   DW_AT_type        : <0x7812a39>

 <1><7812a61>: Abbrev Number: 25 (DW_TAG_structure_type)
    <7812a62>   DW_AT_name        : (indirect string, offset: 0x585bd1): alloc_tag
    <7812a66>   DW_AT_byte_size   : 40
    <7812a67>   DW_AT_alignment   : 8
    <7812a68>   DW_AT_decl_file   : 76
    <7812a69>   DW_AT_decl_line   : 28
    <7812a6a>   DW_AT_decl_column : 8
    <7812a6a>   DW_AT_sibling     : <0x7812a88>
 <2><7812a6e>: Abbrev Number: 54 (DW_TAG_member)
    <7812a6f>   DW_AT_name        : ct
    <7812a72>   DW_AT_decl_file   : 76
    <7812a73>   DW_AT_decl_line   : 29
    <7812a74>   DW_AT_decl_column : 19
    <7812a75>   DW_AT_type        : <0x78129ea>
    <7812a79>   DW_AT_alignment   : 8
    <7812a79>   DW_AT_data_member_location: 0
 <2><7812a7a>: Abbrev Number: 1 (DW_TAG_member)
    <7812a7b>   DW_AT_name        : (indirect string, offset: 0x565566): counters
    <7812a7f>   DW_AT_decl_file   : 76
    <7812a80>   DW_AT_decl_line   : 30
    <7812a81>   DW_AT_decl_column : 38
    <7812a82>   DW_AT_type        : <0x7812a88>
    <7812a86>   DW_AT_data_member_location: 32

struct alloc_tag {
        struct codetag                  ct;
        struct alloc_tag_counters __percpu      *counters;
} __aligned(8);

Its the __percpu, something else to catch in the DWARF loader and then
to use when pretty printing.

⬢ [acme@toolbx linux]$ pahole -F dwarf -C alloc_tag ../build/v6.15.0-rc2+/vmlinux
struct alloc_tag {
	struct codetag             ct __attribute__((__aligned__(8))); /*     0    32 */
	struct alloc_tag_counters * counters;            /*    32     8 */

	/* size: 40, cachelines: 1, members: 2 */
	/* forced alignments: 1 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
⬢ [acme@toolbx linux]$

- Arnaldo
 
> Looks like broken DWARF, there should be just one DW_AT_name per
> DW_TAG_base_type, what is the language for the CU where the bad cases
> appear? Is some sort of LTO being used?

