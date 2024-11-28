Return-Path: <bpf+bounces-45842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC159DBCDF
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77145164851
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91731C2457;
	Thu, 28 Nov 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1m6ELUE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FD17BA5;
	Thu, 28 Nov 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825617; cv=none; b=S8J0HVfHD9aeO9aSSB4smzhumghYMQF4+O6fHBpKvMcEOGIdtyFkW1dChXmDts9QG2byxOPjKN/D13mcUnTI1M5J6hc7NxR2Gpm9wg2TfdqA+jDckhflqvycZK2Urkz7XH1zX72orcaBIMZ9xl7lzCEQ71gt1CglXP5mXdGAs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825617; c=relaxed/simple;
	bh=Dt+YsyY1yzfruVWytExi6aIavrRflzJNA83d0Hd5GYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb93zjNjJF35giwMr9OBG80+7deV7z8wAVptapFp1jeriMThRcYYWa0+jOwCCGy2Dl73RwawufuJWngi12IlAINLA8DrbL7fVJYTSq9S7ljekfCw1AHkWaS5kLrvMbD1QGOUUNopi1TWol+0rNtDiRWmJDRDyCOW8cJ84VeOZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1m6ELUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC4C4CECE;
	Thu, 28 Nov 2024 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732825616;
	bh=Dt+YsyY1yzfruVWytExi6aIavrRflzJNA83d0Hd5GYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1m6ELUEUsvTbdYRPYZy/zM0zK8wntAXw0OFgjjvkuCbOvNJlfKyXoZ6G9QrOoVXf
	 85hWp1ebt5FrSAkZ6DQtiVMxnKpTEYECO0cAFgC6T8W21BsmJ7pMEEnXpliCOnDmLx
	 Im/OSTPj+B46ygjIUDuQ/QMvmN/wza3ZkLWAQcGXqV2qudL4AHZ3HFxUnnBFEHh0dC
	 TD+FwbfHpmYNlk/FVotPWUS4E6aSJghKv2G3u0EQGJTAcioHZdv+rktzDa6XRafhH7
	 8TDRVlCivSYUrIIcZasmBxjhJKH/w/U1dQe7FhjHjf4tvnL4YTSDh5wGhcB/p7GGYg
	 px83NsjGjgSrw==
Date: Thu, 28 Nov 2024 17:26:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0jSDShhOneLuPxc@x1>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
 <20241127015006.2013050-2-eddyz87@gmail.com>
 <35f1dcb0-f577-4861-a82d-c3083dafabd4@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f1dcb0-f577-4861-a82d-c3083dafabd4@linux.dev>

On Wed, Nov 27, 2024 at 01:59:55PM +0000, Vadim Fedorenko wrote:
> On 27/11/2024 01:50, Eduard Zingerman wrote:
> > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > kfuncs present in the ELF file being processed.
> > This section consists of:
> > - arrays of uint32_t elements;
> > - arrays of records with the following structure:
> >    struct btf_id_and_flag {
> >        uint32_t id;
> >        uint32_t flags;
> >    };
> > 
> > When endianness of a binary operated by pahole differs from the host
> > system's endianness, these fields require byte-swapping before use.
> > Currently, this byte-swapping does not occur, resulting in kfuncs not
> > being marked with declaration tags.
> > 
> > This commit resolves the issue by using elf_getdata_rawchunk()
> > function to read .BTF_ids section data. When called with ELF_T_WORD as
> > 'type' parameter it does necessary byte order conversion
> > (only if host and elf endianness do not match).
> > 
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Daniel Xu <dxu@dxuuu.xyz>
> > Cc: Jiri Olsa <olsajiri@gmail.com>
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Cc: Vadim Fedorenko <vadfed@meta.com>
> > Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Tested:

acme@number:~/git/pahole$ tests/tests
  1: Validation of BTF encoding of functions; this may take some time: Ok
  2: Default BTF on a system without BTF: Ok
  3: Flexible arrays accounting: Ok
  4: Pretty printing of files using DWARF type information: Ok
  5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
/home/acme/git/pahole
acme@number:~/git/pahole$

And applied.

- Arnaldo

