Return-Path: <bpf+bounces-21913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2549853FEE
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A2D1F21B72
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC262A1B;
	Tue, 13 Feb 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiBmXNkW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8F62A01
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866253; cv=none; b=iHOurh2yC5onvmAPDCOG14C3UrKjG3gRb+NqGY1nD6DnwYJiCBUAW0DKhZbuGPIgeApRnXhy34WCT3+GW3CGmih3+tcBowU2jAYBPI4dUxXzNkc76wG94bnNcJd3G1VZ1cWmrkY1WWVyhuSV8FOjB271I+Gq7ZrdVz6wiEslwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866253; c=relaxed/simple;
	bh=AXNoXahJgKT3A9li3QVZA0LVVCdDAN77s3vwawloBlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaIfB8ZnNj/GYenJ6nw43Dh+CJVcExjGCTcaGYhzaFgIMpCPHDZLQYbJT9Zxkl95aaYFxYeAVlKQ6TRML076TmeSyFveRAIeld4zJQoC97qXncK5hp689v1tSLnpzErcXZz1MsRipqrYbSqvFge7yHRuEfs6arQHfzcgSvvjiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiBmXNkW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290fb65531eso1069268a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866250; x=1708471050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXNoXahJgKT3A9li3QVZA0LVVCdDAN77s3vwawloBlI=;
        b=hiBmXNkWXsW/8JVgMQEHqniwxfYnn1GwJtk8KzK8k2xR3zVtMW57yw41LLebhPryJU
         vmyh6UUc3auyv/IAQWDj6rFeqgs+cmppGqxu7A9++M6c5JHJJ5gbBA054m/V/vAiEjt9
         ekXpG/6tM7rzViI35Z/zRIeVY819by9UwpRav8UaTEmI5T4S0dZATar8unmC4uPBR0g9
         Jhx1AlizOFw2NSDttLM8pFroSyZ/4wYTipTBDgOjfAc9htki1Yal8JnIu29WfLupLNpQ
         Mcik7AmWjiYX9J5BJvUgiH26tG30DAtqidS7x1+TaBC5gb9mR++92OCEtlrEiOadeZ9E
         SAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866250; x=1708471050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXNoXahJgKT3A9li3QVZA0LVVCdDAN77s3vwawloBlI=;
        b=qgJWL/pMCJAipZpCeK8BpPDiSVDVZbNILYHa1LvUlVvaX5+6ZFG/FnVMCOggtL2c1Y
         SqYlwJEdSpoElFK/fB2audbZ19gGVm5xmLa7jMJaCkSmJO7LMlo8M6uZ6hTfP3xefJLd
         JyqsZFr9XZaOvOzTEQio99u35DZBLkdcq0EPX1NqGYnxl4qOq45aIVjwm06XcHaWZLp/
         pHvsutO5Giu6j0LxTXWPQwDs37STPYWZTsPSmk/9PYuzHmdUWnFtpwxboYYDEWzrpJ5s
         su5Xn9xtYPoJL/WTUj2iYo801I0FaBob2iIMxoLoOBiDlEnWlmYdZhgi+FHciM8I4H6H
         8BYg==
X-Forwarded-Encrypted: i=1; AJvYcCVgpMln1+dHkwiTK89h5TB107z4Ij1e+sGjsKyHJDEQlq/HCxxoMRWvSfilwWlE70KFrm1zajJFrHiIwpnQe4o6xtNT
X-Gm-Message-State: AOJu0Yz19sVqm2stgXFb/+w5fvd+Bqs5+WJWt9kHmiXIeooMuHTjpwaQ
	2jTjQcRXiRpyRdk7LaYmKTd2c6+e7BBcl9rGEivVzH4wu6w7ejx+b8m0Hf91mpoYofq/Yofh5im
	pzyxZIgHlvqak+dWM1SsfYbGrBJo=
X-Google-Smtp-Source: AGHT+IEjLkPcDBgJzniEjGPo/UJ0TkVCEgtlS++HdbCsP+Uop+HDjAQFrkEagfmJL1NP7IUiGfv4PM+1FKpaq/uP3I4=
X-Received: by 2002:a17:90a:c4:b0:298:cbf3:3016 with SMTP id
 v4-20020a17090a00c400b00298cbf33016mr968245pjd.18.1707866250335; Tue, 13 Feb
 2024 15:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
In-Reply-To: <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:17:18 -0800
Message-ID: <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, memxor@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > LLVM automatically places __arena variables into ".arena.1" ELF section=
.
> > When libbpf sees such section it creates internal 'struct bpf_map' LIBB=
PF_MAP_ARENA
> > that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> > They share the same kernel's side bpf map and single map_fd.
> > Both are emitted into skeleton. Real arena with the name given by bpf p=
rogram
> > in SEC(".maps") and another with "__arena_internal" name.
> > All global variables from ".arena.1" section are accessible from user s=
pace
> > via skel->arena->name_of_var.
> >
> > For bss/data/rodata the skeleton/libbpf perform the following sequence:
> > 1. addr =3D mmap(MAP_ANONYMOUS)
> > 2. user space optionally modifies global vars
> > 3. map_fd =3D bpf_create_map()
> > 4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
> > 5. mmap(addr, MAP_FIXED, map_fd)
> > after step 5 user spaces see the values it wrote at step 2 at the same =
addresses
> >
> > arena doesn't support update_map_elem. Hence skeleton/libbpf do:
> > 1. addr =3D mmap(MAP_ANONYMOUS)
> > 2. user space optionally modifies global vars
> > 3. map_fd =3D bpf_create_map(MAP_TYPE_ARENA)
> > 4. real_addr =3D mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
> > 5. memcpy(real_addr, addr) // this will fault-in and allocate pages
> > 6. munmap(addr)
> >
> > At the end look and feel of global data vs __arena global data is the s=
ame from bpf prog pov.
>
> [...]
>
> So, at first I thought that having two maps is a bit of a hack.

yep, that was my instinct as well

> However, after trying to make it work with only one map I don't really
> like that either :)

Can you elaborate? see my reply to Alexei, I wonder how did you think
about doing this?

>
> The patch looks good to me, have not spotted any logical issues.
>
> I have two questions if you don't mind:
>
> First is regarding initialization data.
> In bpf_object__init_internal_map() the amount of bpf_map_mmap_sz(map)
> bytes is mmaped and only data_sz bytes are copied,
> then bpf_map_mmap_sz(map) bytes are copied in bpf_object__create_maps().
> Is Linux/libc smart enough to skip action on pages which were mmaped but
> never touched?
>
> Second is regarding naming.
> Currently only one arena is supported, and generated skel has a single '-=
>arena' field.
> Is there a plan to support multiple arenas at some point?
> If so, should '->arena' field use the same name as arena map declared in =
program?
>

