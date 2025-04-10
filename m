Return-Path: <bpf+bounces-55646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DDA84035
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6302F7AF173
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC826F47E;
	Thu, 10 Apr 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TBDWx1MQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5C21D58F
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279795; cv=none; b=WL8ZPScJ/9hezkyeLdqHYWfUgpHE+uZhpHIGn1kiSMfn+GrenUDbYyDcF3K+nf+Yr9HKlTg9o6VfWlCgAJFk2bCgfH2RPHoIo8rpp1Ur6HgiXpp2vLIzHTcLvRMt8weH1Q1oSx3bOuZVK0YYhqQ61VwT9V9+Uew03+yJnOawnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279795; c=relaxed/simple;
	bh=9r1/abEBJ+Cw69dBrzvBysRlgAJX83vfn3iBxPljDUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzgUE2W/7ahgIN6kXu+OqPYRbXKfg+JLO3/+Kb7MMYDDLrv3kjx+UN3rRqaxysKcZZd2pKqh6NiqaSWEMrp1u+AKsoDUaTFzs2u1IvMR4UPZCo+4H1JiY/G1y318rcTNnZUzMh14Zp6m0r1DD/ChmQsvO7MqMsW/nAxHdcpK1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TBDWx1MQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso449712f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744279791; x=1744884591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyTm1lakUVlaZhiAjm020rw+6ozENRX6atxOni6SbCk=;
        b=TBDWx1MQVeVNaEfUMRd8QWj0L0S6Np4GYSn4b3ZV/X8BxFaiZXmrE7Ew77VK6Y6C6m
         Tw8qjSv4ldOEggieDlQuzZqEOuo1MRzB0epu+r/PBvJRfBtTEmfke2f5a0o2eo0SA1dG
         uI5clW7YdWL4M+rYnWbcjKRZNIq+2ZVRU7B1crbRnSNP4T/RK9H9d/O7niZkC/aXwQ2N
         ZVc+OPTNbSGWDynyA6szp1kasTPXVYYV3cEp64ru8bWAlu2sc9lLLub0FsYuiKohLopW
         9qrNU0ddIA6IjU4maG55mMYzZe7AB4Lz/CQrkj2hVSfvFYqu4VXTk+Vh9N9PhciHW9Fu
         AOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279792; x=1744884592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyTm1lakUVlaZhiAjm020rw+6ozENRX6atxOni6SbCk=;
        b=YHirr1ACivCDXGiROIYdkLpkCV6c6vp9iiHHRoezyB4XxTavkVPmRRsg9dTeEcQ6RL
         /541xMwQChPc8tt5H+5cYPnXrfvIuSQU+sbJxNXlvem34xiFe44ZbJW2yUj+w9j5B+C0
         Dog+dOGCr4ZTjSvfdYzCHVlnETwj2Qby8MxvfmlYtm/j1TBbYHDmS+AvEP8flvUdU6fS
         FNEjAz8fNmyM8B8Be/VL5g+n0CzqCSgo4/RhxWIjdcv5ajeczQWDcV2EJfFaHm8vdnNg
         RmSLYqHWnCFlve7eXAZwmTiY/mpqrYKI4QYPSRJuZIA6lVfh4uIlYLh8DJ/e222qIigY
         JV3Q==
X-Gm-Message-State: AOJu0YwBY4Edz6VWOJ/zR4CQcZRse2APYAJeGYjBLAoKJkJpLTqO44CR
	0/awlNkGRkAt3VhrJ5EICyNlnuCy1YNkiesEciIFARCYwohbrTppvHPds7WIhhc=
X-Gm-Gg: ASbGnctI+2mhn+iNlm+NyDhtBRGBBrfoDv8ZSrczmQhIaYxHmm4rp1pdrbTFZADGgRw
	X5jysDcrIWDKpuuufv8ocODzD1553hFFCY0PTtamE3pFuoJFLTFijqH/yrnnrTjZbQlYVb2Bo6k
	B5/H7KLsPN+WA4n0PrxMeoWnpoBePjKxYnIVb4NtvTzUjz1wL4gu5Z6vmkWrtrAmf3WMKVL9v+C
	g5lec+HUhtCy3SxqM5kKsQ9hdvU+3fFUVAjLeGazLvdK7uVMuy2/Tcvhu+o3ZwcOK3wNgtI4AhH
	Li5me1hVZ/R1ms2/vCbNJy7c8q4hguFa35LE89Qb+0OVu0wUpjmPNZE/2+KJoT3u+OZBZ6bwV1Y
	ewv6b5Ewf33hVsukuxzFnQZZ4U/QkWSX7lw==
X-Google-Smtp-Source: AGHT+IFwnFpU5BW59IlZB1OrNe0VPD1ii0nbUaE5u7Xl16IDLMljJtwU80YFhfQ+56w2gfMG7OwRWg==
X-Received: by 2002:a5d:5848:0:b0:39c:140c:308 with SMTP id ffacd0b85a97d-39d8f2677d6mr1758601f8f.3.1744279791568;
        Thu, 10 Apr 2025 03:09:51 -0700 (PDT)
Received: from u94a (2001-b011-fa04-9f63-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:9f63:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6288asm26499905ad.9.2025.04.10.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:09:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 18:09:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix buffer overflow in bpf_object__init_prog
Message-ID: <ttbuf2polzcve56wdthptduyloy72ysy5ld4ar2ihuziuiuuma@3uzo6emqjvlx>
References: <20250410073407.131211-1-vmalik@redhat.com>
 <b5yyvqbzff6pf4lyducvu7m3aw4wskoakz2l75aedte5lubtvd@327tjmlssvbk>
 <09662c0c-8643-4188-849b-adff38e32c23@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09662c0c-8643-4188-849b-adff38e32c23@redhat.com>

On Thu, Apr 10, 2025 at 10:56:19AM +0200, Viktor Malik wrote:
> On 4/10/25 10:16, Shung-Hsi Yu wrote:
> > I was about to sent my fix, just to realize I got beaten by half and
> > hour+ even with my 6 hour timezone advantage :)
> 
> :)
> 
> > On Thu, Apr 10, 2025 at 09:34:07AM +0200, Viktor Malik wrote:
> >> As reported by CVE-2025-29481 (link below), it is possible to corrupt a
> >> BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
> >> This can be done by setting a symbol (BPF program) section offset to a
> >> sufficiently large (unsigned) number such <section_start+symbol_offset>
> >> overflows and points before the section.
> >>
> >> Consider the situation below where:
> >> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
> >> - prog_end   = prog_start + prog_size
> >>
> >>     prog_start        sec_start        prog_end        sec_end
> >>         |                |                 |              |
> >>         v                v                 v              v
> >>     .....................|################################|............
> >>
> >> Currently, libbpf only checks that prog_end is within the section
> >> bounds. Add a check that prog_start is also within the bounds to avoid
> >> the potential buffer overflow.

Looking this again, I realize the above does not exactly describe the
code change. The 'sec_off >= sec_sz' check was instead  a check for the
following situation:

    sec_start                        sec_end  prog_start      
       |                                |         |           
       v                                v         v           
  .....|################################|...............

And it was symbol_offset/sec_off + prog_size/prog_sz that overflowed
when running the reproducer, not sec_start/data + symbol_offset/sec_off,
though maybe that could still happen further down in the call to
bpf_object__init_prog(), I'm not sure.

The change does indeed address the issue surface by the reproducer
though. Just different from what the above describes.


Shung-Hsi

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..d0ece3c9618e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>  			return -LIBBPF_ERRNO__FORMAT;
>  		}
>  
> -		if (sec_off + prog_sz > sec_sz) {
> +		if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
>  			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
>  				sec_name, sec_off);
>  			return -LIBBPF_ERRNO__FORMAT;

...

