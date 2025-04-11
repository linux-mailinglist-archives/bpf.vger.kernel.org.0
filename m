Return-Path: <bpf+bounces-55706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19932A85202
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 05:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303508A765F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5627C15C;
	Fri, 11 Apr 2025 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hx2/31vk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4D1E5711
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341953; cv=none; b=TfmDwteH3D3uNFUGdSAJGjCUe9dZD2CWVP1xH5cgyyDSyfXEHDb9oHnSdxttZwkUz6OYImAsHWXR/jALza/+DtWbPuwctaZ/pfVq4r6FC4H2PVawwKa4B9OU9jVEPT2MAXxwepg3jPNo8hbS/ATNA2iOsihbZ/JaEDLlAciipzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341953; c=relaxed/simple;
	bh=nWCF+G9egqk3x/IkmsRezdgSlPReN/0WM8cH1y+gx2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7tYlgeNFy/n+pdpsEcIkAGLx+9eqwBL0N2RaRWB5n3A6f4Efh9+RtO62u4Op25mF2fzcDCptR0dRiiPNcZyfh89J0FkV+IkAiy3OxuHid376gV2/EqkEK3avn1++FUlIkj51ToHfDYhdtd3sDnQD6gnhCvyu2vU7j+/dcC9txQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hx2/31vk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39149bccb69so1294547f8f.2
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744341949; x=1744946749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wTS9pFJdtIkrhWFgFL5duOTMejYoCKEzZYZO8pJIp4=;
        b=Hx2/31vkMUkl5J8cLiRuDTr0aP34f8fvoLCdYfQ294wsth7dWLGeLct8GlGbtBx4OW
         ssS+uLRl6QteABlR+ll6dRUda5JLEG4RHZEgQXVpzotGgAfX9KjYjhbuL4+Jwbht+hw0
         cW3s5yfMdUv6F7FdXpC4d00PkI001FyK+bs/NflUl2FZdKyVc0DlUODSKOSPeK87KnTE
         hxGLO0YvprgUwGJPGzmXtirVrjWbud9H2tGFddcIBQ1L+4AiugV+eq8ePUUs7n8GAeXy
         R+etWHMEc9oTDg09YTOyLt0ZLLfCpbQyZKivOgKwtRIGlTCvsjZmAyZM4/g79pGZqYVs
         b+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744341949; x=1744946749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wTS9pFJdtIkrhWFgFL5duOTMejYoCKEzZYZO8pJIp4=;
        b=EyvS2xlnFyArDtrk6UUshBwNJd8Hn64AGzihDY/vWCnYhWl5AEW32JK+gg2kzisou9
         wvZDYe+6wiZKakr4dkU1NW1YIiwD7+rPF4Q29qR6MZLhenLvFyd5QwWWBq8OtZM8Fu2a
         6xpvoZVEE27WBFGEotkjKosBbjJIGo9Zkl64WNrkmq5pHaj9hsXSB/6xey0SbTZA5bLy
         06hlpUgJtNB5CcqXw8pKmGhZwG/8w4WkmS1Vv8k3fRG1BWdrVU/ktUG/vccL/MbkCdVN
         ZXiPLswumw9fkt/k676C4p0djMIzgBEwU0PDAcY9Mht2M9tUNkr2+8Nygj/OgvBM4qTG
         WRdw==
X-Gm-Message-State: AOJu0YwlwHVxGqqWdATXtZsyXSJyBfCgi9unCHXkkAN7xoLmRjUQZz7y
	cghjtQFy/mOWDMex0qT6Q0TSe+b7FQHKi5S0g3jl36+NkJHAjHUjxb/OdA8ceYs=
X-Gm-Gg: ASbGncvZO14/u7hPmslJ/2NJToQl6IEp25I81MzTNsenkI6f75IwX+MKpmhsITCbvkt
	pPMZnmARAnQgDM49onRq3mtT74hkE3Imo9arfKyn1cMIDlbsCCeq9K8MwWnZHNwn19Hi1VrVPfy
	YCtIGbEFdVwCEbv0BQ9sFMmiNbFw8NTDFlxg6DeAn8aISwSSUx9p51K3QTirv153rRvKkwuS8kH
	5IL4oNPItxiZj/gEwHqCG8HjR6iMOtyY6MYar6MNMDyxRdfKmc49RHkGZkL6Ol+LV9czSvw/oDj
	XevJRbiVqIHgqgr4eXN0hWuTlbYGY/rkaOk=
X-Google-Smtp-Source: AGHT+IGW4a+HCdiNzzd11WH4ALctO0N8pZxBnLCWI4StGYjVdo11r40LFJDxI6ZiLVvE25Quu/BNpA==
X-Received: by 2002:a05:6000:40cb:b0:391:4052:a232 with SMTP id ffacd0b85a97d-39eaaec7a4cmr660734f8f.55.1744341949036;
        Thu, 10 Apr 2025 20:25:49 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:e3f:bfef:a780:41c2:7780])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c97212sm38559045ad.119.2025.04.10.20.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 20:25:48 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:25:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix buffer overflow in bpf_object__init_prog
Message-ID: <67lc5rork5fl4243r2enu6cvjnerpgop7qcua7vnkppngbejt4@ykeanqnfoa6j>
References: <20250410073407.131211-1-vmalik@redhat.com>
 <b5yyvqbzff6pf4lyducvu7m3aw4wskoakz2l75aedte5lubtvd@327tjmlssvbk>
 <09662c0c-8643-4188-849b-adff38e32c23@redhat.com>
 <ttbuf2polzcve56wdthptduyloy72ysy5ld4ar2ihuziuiuuma@3uzo6emqjvlx>
 <9657d4a8-b49d-420d-a618-1cf782eb423a@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9657d4a8-b49d-420d-a618-1cf782eb423a@redhat.com>

On Thu, Apr 10, 2025 at 01:04:49PM +0200, Viktor Malik wrote:
> On 4/10/25 12:09, Shung-Hsi Yu wrote:
> > On Thu, Apr 10, 2025 at 10:56:19AM +0200, Viktor Malik wrote:
> >> On 4/10/25 10:16, Shung-Hsi Yu wrote:
> >>> I was about to sent my fix, just to realize I got beaten by half and
> >>> hour+ even with my 6 hour timezone advantage :)
> >>
> >> :)
> >>
> >>> On Thu, Apr 10, 2025 at 09:34:07AM +0200, Viktor Malik wrote:
> >>>> As reported by CVE-2025-29481 (link below), it is possible to corrupt a
> >>>> BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
> >>>> This can be done by setting a symbol (BPF program) section offset to a
> >>>> sufficiently large (unsigned) number such <section_start+symbol_offset>
> >>>> overflows and points before the section.
> >>>>
> >>>> Consider the situation below where:
> >>>> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
> >>>> - prog_end   = prog_start + prog_size
> >>>>
> >>>>     prog_start        sec_start        prog_end        sec_end
> >>>>         |                |                 |              |
> >>>>         v                v                 v              v
> >>>>     .....................|################################|............
> >>>>
> >>>> Currently, libbpf only checks that prog_end is within the section
> >>>> bounds. Add a check that prog_start is also within the bounds to avoid
> >>>> the potential buffer overflow.
> > 
> > Looking this again, I realize the above does not exactly describe the
> > code change. The 'sec_off >= sec_sz' check was instead  a check for the
> > following situation:
> > 
> >     sec_start                        sec_end  prog_start      
> >        |                                |         |           
> >        v                                v         v           
> >   .....|################################|...............
> > 
> > And it was symbol_offset/sec_off + prog_size/prog_sz that overflowed
> > when running the reproducer, not sec_start/data + symbol_offset/sec_off,
> 
> Here are the relevant parts of the bpf_object__add_programs function:
> 
>     static int
>     bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>                              const char *sec_name, int sec_idx)
>     {
>         ...
>         void *data = sec_data->d_buf;
>         ...
>         for (i = 0; i < nr_syms; i++) {
>             ...
>             prog_sz = sym->st_size;
>             sec_off = sym->st_value;
>             ...
>             if (sec_off + prog_sz > sec_sz) {
>                 pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
> 				        sec_name, sec_off);
>                 return -LIBBPF_ERRNO__FORMAT;
>             }
>             ...
>             err = bpf_object__init_prog(obj, prog, name, sec_idx, sec_name,
>                                         sec_off, data + sec_off, prog_sz);
>             ...
>         }
>     }
> 
> You are correct that `sec_off + prog_sz` overflows and therefore
> bypasses the existing check.
> 
> However, the actual problem is IMO elsewhere. Above, sec_data->d_buf
> points to a memory buffer allocated by libelf which holds the section
> data. Therefore, `data + sec_off` passed to bpf_object__init_prog will
> overflow (as sec_off is 0xffffffffffffffb8) and point before the buffer
> itself. This is also what AddressSanitizer reports by:
> 
>     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
> 
> Next, bpf_object__init_prog does:
> 
>     static int
>     bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>                           const char *name, size_t sec_idx, const char *sec_name,
>                           size_t sec_off, void *insn_data, size_t insn_data_sz)
>     {
>         [...]
>         memcpy(prog->insns, insn_data, insn_data_sz);
>         [...]
>     }
> 
> which is where the buffer overflow happens as insn_data points before
> the memory buffer holding the section.
> 
> So, I believe that the actual problem stems from the overflow of
> `data + sec_off` (i.e. prog_start) and therefore my description is
> accurate.

Okay, I see that now, `data + sec_off` overflow is the root cause
indeed. And in the bigger picture when *data/sec_data->d_buf is
considered, the diagram is correct.

I think I just have a hard time getting over the fact that the
'sec_off >= sec_sz' check, when taken literally and out of context, is
checking whether the program's start offset goes _beyond_ the section
size. No suggestion comes to mind though, and not a blocker.

> Viktor
> 
> > though maybe that could still happen further down in the call to
> > bpf_object__init_prog(), I'm not sure.
> > 
> > The change does indeed address the issue surface by the reproducer
> > though. Just different from what the above describes.
> > 
> > Shung-Hsi
> > 
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 6b85060f07b3..d0ece3c9618e 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
> >>  			return -LIBBPF_ERRNO__FORMAT;
> >>  		}
> >>  
> >> -		if (sec_off + prog_sz > sec_sz) {
> >> +		if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
> >>  			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
> >>  				sec_name, sec_off);
> >>  			return -LIBBPF_ERRNO__FORMAT;
> > 
> > ...

