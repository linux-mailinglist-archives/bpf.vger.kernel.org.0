Return-Path: <bpf+bounces-48052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0A7A038F8
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45F6164A67
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C30A1DD873;
	Tue,  7 Jan 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SXFDGPLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286818A6B8
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235866; cv=none; b=ph8GfYg75uybWt7otNEHubMXYEtG7nauZ5vumIoaK+9snwc0xi968rjJE9giBHEXeOKCb9o685CFCfuci4DJPLrJNizRgomNWX+39r8aX4vWaC+fui56kyJ+CZorzjipd+J4nGW6Pcr5NnDTvqSk70GIAvwcAHLtRFZbjShSQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235866; c=relaxed/simple;
	bh=NfH6PC69PVPWrYbUK8QXJckdVlaQr9R20B3O9zL6MEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEMyA+ArszjL8bB91CqTkRJbtXppgTDGBzL0epYS3hzdYXm95sPS3v2xDWWJ2177KHibxCTZyV1Q3EdAZeb0rZGYIy0Ty+iEbLgugSekPB9wiVH028l2Syc6oTr2A7AGLkHbG0p0OyDG2coY0sRE/YlgRP7aAnKAxK0uDNJkA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=SXFDGPLw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso28702129a12.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 23:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1736235863; x=1736840663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POjD5Zj3Tdumh+ycDPdMEANzD5J+X+oOGf4tPTZQSlI=;
        b=SXFDGPLwAj9ZkHVhRAAiem8pkwkoBtyMOPzby4pBo0BwGvT5oYCs8R9yyXCfZaEYa8
         DMFjQPbrscRcWxmV/RQmODq4zYXmdetmoPVUOyvqOUQrnUjqyFS1Q7G2WQUsAbLkHhEA
         k/LGtv5ZrbzphTvza1HTvNm7KJjJLBOMDdqdiNMwWXO8NbGpbOg6vWd06qq+5y4am6aQ
         g1JcCiv+uISr25dzslktnOmerkC7lD6EeTbFwApwI+lG3QX6KYz/fFs59aH6ydMAtF+v
         +2KjmVMWDW4L6V+Tf3P9kZoKnAsTqM9Agiwe2duVkFrm+U4lwvAB+jyoNEVku2d1h6a1
         ut0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235863; x=1736840663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POjD5Zj3Tdumh+ycDPdMEANzD5J+X+oOGf4tPTZQSlI=;
        b=n9n4YldToPxONnCUlje0ugKkDwNfh6fC5myFDln4BE32YCm8r27tXIEsJOi1zQ+1sK
         ae1/UvxEXju5p2378JVQIsIV8XgB2/kXZ9a+i1EgRrCXKWK4buYiCcBjWZ00Na4xilMx
         qlbyptBDSCaveCKBhpn08N2hzfXprp2Snit3TAOMAUNM2ZAGn8y7uah5zGO0+87stb+F
         0LaNBcb1vf3auVhrexE4mnRKbcDx/01nDawOmzg1Sn+p1mEisesrUujeR0EUEQNqJxpG
         FjqutxgyrzPE4DeHJ2FpgYIk6EytZV/WIanlmh6fm6sbzokV3xRRkYANG/iLxpgu8YLd
         b48g==
X-Forwarded-Encrypted: i=1; AJvYcCVGCkL1fE4A0VzEcWy7kXQELCrf8DB6smmB70/VDEc9Kpw0S9sk+P328x9PDib27Km8EfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNHOd6ETdcvALfaOqUEtKpPjj3vfmDuS01feAlqIy25V7gCih
	uy8c9ZZN+hNtBDoKfJW5TMV2uoNpriyi6SMIIo2RCneUNP3VAVbJBPwsZyK4jYY=
X-Gm-Gg: ASbGncs015mOD3r3TsBpMTaNEljhSBQD3UgrJ8+d6m/AqJCEIsUnf7wFe5ZOqRD2YHA
	T1i5q9r5Qg3gsjTJk7i5IezuGSXL4mjVpLex8YlqDGJT59C1L5Xl0tlcQBozZvOJO9u7fKICSha
	UT2vJCSjCFdgE4axLIGVELeeLdoChTcnYP2pNGHbTCbtRiDC2G5x1sSMlUCvrTzol24OG0i756b
	pXM/GAQ0+wGeq/7rXvlOXOAPMwDvcvaFb7mE59m+DudcQ==
X-Google-Smtp-Source: AGHT+IHO2I4Fce5Kne3vm3dcHr4MzXNnl37K+nW36XUsaR8NMSa2KvUOObOcuWI7BHx+pZ1QdH75cw==
X-Received: by 2002:a05:6402:34c1:b0:5d3:ba97:527e with SMTP id 4fb4d7f45d1cf-5d81de20416mr55177639a12.25.1736235863197;
        Mon, 06 Jan 2025 23:44:23 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f900sm23998399a12.53.2025.01.06.23.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:44:22 -0800 (PST)
Date: Tue, 7 Jan 2025 07:48:28 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Nick Zavaritsky <mejedi@gmail.com>, aspsk2@gmail.com
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
Message-ID: <Z3zcTB+SjPK5QOt9@eis>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>

On 25/01/06 05:19PM, Daniel Borkmann wrote:
> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> > This patch series provides an easy way for userspace applications to
> > query the number of entries currently present in a map.
> > 
> > Currently, the number of entries in a map is accessible only from kernel space
> > and eBPF programs. A userspace program that wants to track map utilization has to
> > create and attach an eBPF program solely for that purpose.
> > 
> > This series makes the number of entries in a map easily accessible, by extending the
> > main bpf syscall with a new command. The command supports only maps that already
> > track utilization, namely hash maps, LPM maps and queue/stack maps.
> 
> An earlier attempt to directly expose it to user space can be found here [0], which
> eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
> extending UAPI.
> 
> Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
> bpf_map__max_entries) which does all the work to extract that info via [1] underneath?

One small thingy here is that bpf_map_sum_elem_count() is only
available from the map iterator. Which means that to get the
bpf_map_sum_elem_count() for one map only, one have to iterate
through the whole set of maps (and filter out all but one).

I wanted to follow up my series by either adding the result of
calling bpf_map_sum_elem_count() to map_info as u32 or to add
possibility to provide a map_fd/map_id when creating an iterator
(so that it is only called for one map). But so far I haven't
a real use case for getting the number of elements for one map only.

> Thanks,
> Daniel
> 
>   [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
>   [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
>       https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
> 
> > Charalampos Stylianopoulos (4):
> >    bpf: Add map_num_entries map op
> >    bpf: Add bpf command to get number of map entries
> >    libbpf: Add support for MAP_GET_NUM_ENTRIES command
> >    selftests/bpf: Add tests for bpf_map_get_num_entries
> > 
> >   include/linux/bpf.h                           |  3 ++
> >   include/linux/bpf_local_storage.h             |  1 +
> >   include/uapi/linux/bpf.h                      | 17 +++++++++
> >   kernel/bpf/devmap.c                           | 14 ++++++++
> >   kernel/bpf/hashtab.c                          | 10 ++++++
> >   kernel/bpf/lpm_trie.c                         |  8 +++++
> >   kernel/bpf/queue_stack_maps.c                 | 11 +++++-
> >   kernel/bpf/syscall.c                          | 32 +++++++++++++++++
> >   tools/include/uapi/linux/bpf.h                | 17 +++++++++
> >   tools/lib/bpf/bpf.c                           | 16 +++++++++
> >   tools/lib/bpf/bpf.h                           |  2 ++
> >   tools/lib/bpf/libbpf.map                      |  1 +
> >   .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
> >   tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
> >   14 files changed, 171 insertions(+), 1 deletion(-)
> > 
> 

