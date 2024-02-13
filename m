Return-Path: <bpf+bounces-21906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AC853FC1
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872B21C27001
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33962A10;
	Tue, 13 Feb 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpZmPCev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39862A01
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865881; cv=none; b=pQ1TjxD7ZbmT7omOFy5Tf2Agx0+bHr6kWKnOBeVnGbsK1xM2IDeBxFshwZLjmjN8ZBslCoJPgsQ/PQAkrH4lSgj24e9e4lrYtK31mUhEu4LFdelbPv0VxftK+a2SLaJUZTiqCkzR1DS/xrUjF9+fSUy2vuqa3KxX61Hts0NeaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865881; c=relaxed/simple;
	bh=zwZNV60Bg7J4ukK9pApuB5uU5L+uWW9Uc7N8fGemWv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYTupMLATqphkCQHviWOOK+AspqKalwO7Y18ReC58XzfT4dVN1p67Udp4kqRsv3d964jwYXXR54WjnaVox+tlhq6XabqZh2fSrMDjNA/4RvKTQmmWWwUPqK9JMcs1R3/uREUu3KtNM5Er9Ln4ZFNm9PW/NjiMQM/lcKlxuMR6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpZmPCev; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3be744df3fso519274166b.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707865877; x=1708470677; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwZNV60Bg7J4ukK9pApuB5uU5L+uWW9Uc7N8fGemWv4=;
        b=HpZmPCevSuvlg/aiBuU1dEV24MfxSYGqUiSbFQTN/7mhvVtqVsNJSlLiscbVVHLA3d
         osRja5jMVpiJc3Qn0L3FgzxLmp6CLa1Ww+Tv1xQ+ucrmwu10q+J5U/WFp3FKLWWlKDmd
         yCho/W6vlZY8IJ+XjGwkzdOjgARqn90xmaun6ceNjoBrBlc8rquimFhBvaxxVh+WdLqJ
         onafwxOOrXC0PDiyKvTIYdgvzgWBTwdxRwJA1Y4kWz87CU998kv9vohGcvGyCq/P+KS/
         0of1pANTjl1xG8XdmMU9C3OOr4J3CI+AhOql1AzF1aJj1juPJiq+/r5pddoKbPIbWHAT
         6Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865877; x=1708470677;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwZNV60Bg7J4ukK9pApuB5uU5L+uWW9Uc7N8fGemWv4=;
        b=xGNRWh/dzYYIYsBpRU7jZjwJ3/Zmv1/oY0NpAlMjevxkD8k5J47sHh/Mk988nL0U3v
         TB/SPgLYwWXqM9jS7Juqx+tYzD9Gts6rdbh98W/pU4qG0lJ/v9/kAlp1L/5Oz0xmQbP2
         i8SvKjxXrZ7VndU5KazI8mxxxRRZfZF7CNG1lCzD2JFIe7vzOK5lVg8gA7woJLoOitCf
         iZ/pKx/s685VdpDbop5cBb5W5qfgsr403qSnE9UvoCiYd1kgwrzVD1ryfntVxUo1Qq7U
         jY1wxVpY7wWZqzvQns+3E9UDeqtMoOc+mkkAMmHrllm+cyNFhr7PoikFjCaLRD7j3P3a
         bHDw==
X-Forwarded-Encrypted: i=1; AJvYcCVTH5x5oopGv1CFN/IcJuHMMvgJauBDCcQ1O5cuLhX1S1Yo23zWRkqfxOIrVCTqg6H7z558X3z5HH+QJ7JGCSq9GYWx
X-Gm-Message-State: AOJu0YxxP1aA+5u8Pym+zkTiLPR5NuEipLDcc1l4Sy4Uf+7GfMPlKIQ1
	Xjb895Z3SeVmOdMAGl+VmjP4czQUCyrF6nQijNcAdBEEiZ2pjMqP
X-Google-Smtp-Source: AGHT+IGGfSC7ij2uT/hYCRSkDBRZNu2Ah+JvzAM4soG7/6d8Sfr040orNq/t4ujSKod/SmD2iUb2jg==
X-Received: by 2002:a17:906:513:b0:a3d:3aee:85f5 with SMTP id j19-20020a170906051300b00a3d3aee85f5mr235964eja.75.1707865877333;
        Tue, 13 Feb 2024 15:11:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4iq2ArCjNttVyd2AdTBHD4mbnT1iU40adRJtIV1kx20/k2Kv1uE2Vb4bEdypxNhJjuvOcylqDhN4s4cwJZjfyTNyXx5hhrY4Yg+XJE23LSVEKReP9C/CQtuwea0dJPX0ZsZcPzJvP7L23OFeVvDEp6wxXhQoWuZa+oAqSbA0xHiblJBkwNy1l0PYoclS9VcBFmeNlbzApDWqRWGKbvtpF/CvA8+hJiB1jgDMv7uTlzm9X+mLfyEPEagWmMX9dtLYvxGzQ3gnc1s9xGDugsVQ9Q3h2mWVLgPCF9KkV1dpHGySenZsKUP7JkDOJz6Kwq5KTKEPlhNtP2UjWri80u+YNIAJg+FDGhkpOMGZvHHcXPxmscBHgdwur
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906040c00b00a3c24e20d56sm1712181eja.102.2024.02.13.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:11:16 -0800 (PST)
Message-ID: <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Wed, 14 Feb 2024 01:11:15 +0200
In-Reply-To: <20240209040608.98927-15-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> LLVM automatically places __arena variables into ".arena.1" ELF section.
> When libbpf sees such section it creates internal 'struct bpf_map' LIBBPF=
_MAP_ARENA
> that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> They share the same kernel's side bpf map and single map_fd.
> Both are emitted into skeleton. Real arena with the name given by bpf pro=
gram
> in SEC(".maps") and another with "__arena_internal" name.
> All global variables from ".arena.1" section are accessible from user spa=
ce
> via skel->arena->name_of_var.
>=20
> For bss/data/rodata the skeleton/libbpf perform the following sequence:
> 1. addr =3D mmap(MAP_ANONYMOUS)
> 2. user space optionally modifies global vars
> 3. map_fd =3D bpf_create_map()
> 4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
> 5. mmap(addr, MAP_FIXED, map_fd)
> after step 5 user spaces see the values it wrote at step 2 at the same ad=
dresses
>=20
> arena doesn't support update_map_elem. Hence skeleton/libbpf do:
> 1. addr =3D mmap(MAP_ANONYMOUS)
> 2. user space optionally modifies global vars
> 3. map_fd =3D bpf_create_map(MAP_TYPE_ARENA)
> 4. real_addr =3D mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
> 5. memcpy(real_addr, addr) // this will fault-in and allocate pages
> 6. munmap(addr)
>=20
> At the end look and feel of global data vs __arena global data is the sam=
e from bpf prog pov.

[...]

So, at first I thought that having two maps is a bit of a hack.
However, after trying to make it work with only one map I don't really
like that either :)

The patch looks good to me, have not spotted any logical issues.

I have two questions if you don't mind:

First is regarding initialization data.
In bpf_object__init_internal_map() the amount of bpf_map_mmap_sz(map)
bytes is mmaped and only data_sz bytes are copied,
then bpf_map_mmap_sz(map) bytes are copied in bpf_object__create_maps().
Is Linux/libc smart enough to skip action on pages which were mmaped but
never touched?

Second is regarding naming.
Currently only one arena is supported, and generated skel has a single '->a=
rena' field.
Is there a plan to support multiple arenas at some point?
If so, should '->arena' field use the same name as arena map declared in pr=
ogram?


