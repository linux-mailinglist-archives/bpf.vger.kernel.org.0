Return-Path: <bpf+bounces-58797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D123AC198D
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EF41648DD
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC521B9C5;
	Fri, 23 May 2025 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCGSbkHF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB721B9C2
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962760; cv=none; b=Xc0q/b3q1q855Ms1xPS7eUWBtrB0cASDG2DxKLPbjlr+RX05EdSVyJgAEZApjcqmUHNwP3cis693O7uSsaI1PXPTEQtLDdMpyom6ZOD2KUM+aBKtvvGQpuX58WDEnnWiDcrfPSBmYmfNB6xaRp2T7SCWMIVXAiqL7/WkR/6NGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962760; c=relaxed/simple;
	bh=UShqzNCz201Czk0sQEQ1QBEug+XK2KMiwoF7N3Xe6X8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4uPx/1ZITh4uGTZ5vtTxR0T1EKZk3Piw9frl8KZuhZs9U2gUjfZdBUZNHW7lh3xsgdGTUdvKN6b8ZrOqU7m4q7de0+Ok1JDaf5luIEmKRgHRKLT4dIRizC5XJA4gjUWV3G8p7q/lohQOkMBfmxAtYQjCR9Cvmr1StZYeOVwPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCGSbkHF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2321c38a948so63149215ad.2
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747962758; x=1748567558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpXANfhf2Ct5qfaU6DfTxP1onXasslWBJgjezcxCNm0=;
        b=LCGSbkHFNGLBQINLNNN054nF4s7tcKBszj2o0cJSOPscmUhHu3liu5VBPwj/8xP3Qw
         ZyWjBLg/lkD9gfqWFrxMYg7dPmEQdnVPQawL/eRyv1jvpx/IiiKkRZdIFRtVjydE0E5Y
         cLk5eTg7mzHMqBtsR+XXcY/2nYgwvrT3E7VE75iD/IcXkUtVGONz3x4ApDGrstMGGUsm
         DInabBEfkxnXCGH6x1KwEM7tNfjZlm0UIe3YOvwyBlmaNgtiDjvHKqMflVEG3t5K7Wvi
         4DeHT3OO9jXM+9ZFndvLkxEfFFHMRz1i8/k+Ss1V6t4cGNTSFBQXZBdoRy032M+A4qij
         a+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962758; x=1748567558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpXANfhf2Ct5qfaU6DfTxP1onXasslWBJgjezcxCNm0=;
        b=GZW7Q5taTuHkNNqY0CkCZQEKk9hnacGszvrXefg1h496FKFfFf+vsswXyH+5KJUnWR
         /leT5GIgvdB2JpYcPvpB4jIJFrv86pZHm80wbHKOcnUaAeU3ys82mW9a7x+f25Tn7uTr
         3+uyN9auNdc2nFMY4Gy2QM1i+/TKyOO5VveiT8xvIOKQu1J1SpLouL62QzudTGh1tQAL
         zgiYoJ9iiDtmemymXg4d9IiR8vcaibpGE0wxIro2i5HbL2O+rikpzjNHIf6AjG6e+XIM
         wwgEWJ1b0PMJJdBpzxls+dG/ris1eBSdfDkDgb8X2kRKokNskYfmK93sCplC07ptseYz
         BChQ==
X-Gm-Message-State: AOJu0YzwRcZxTjNrsXEXAaVjXco4GcrLJUUtGnf45hZyiFuoUEhxKGiQ
	2QdLUIEmyaUhjNYQOrfQmCq5MdXzl7xUezv9h4eHXn7AMaFFxrQ+RCp1Q1rC7A==
X-Gm-Gg: ASbGncuf4pVcOGOVmF6ERyUtVoINfigsiBcKhBjKeebJq0xwDlBA21F7wTi78Fov62R
	l1cq/S/MPC8Yatjd9I5kfDA/JQ9yiC+3wuxUAOwXGntykRW9apO4cqiihsGKnm11QUyH+T3u1ik
	rOtQ4GEE+ltdUkIR8AYadZIt+V9ujtSeXZH9YsAa+9Nrk2WXbf86CzikJdZF/22dfM+jnwaxQFZ
	KkrhLZV840TRmsGx/zRYTDZeA8DV0/bnGz3AH5C0NAswXQFtuoFzhMejtUFlnYd+SPVl9+hFg2E
	pswb1M5MSEsz8OEb+fpKm9OKkT7yjihA+pKgDj1GwTqU9XOGG4aSy19DhMK4ukXoJ1LpCIPiuPw
	2Fn4XtupUWVJIII+i557TpKcvj0oc
X-Google-Smtp-Source: AGHT+IG4lbyy/yitsHbJP14sckD4kOu4XYQSyZkEDub2xpqKUrjnE3mqiForYTJpGD7WQGSWuHdbKg==
X-Received: by 2002:a17:902:f78c:b0:21f:85ee:f2df with SMTP id d9443c01a7336-231de35f324mr404838505ad.15.1747962757958;
        Thu, 22 May 2025 18:12:37 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e971cdsm114336375ad.134.2025.05.22.18.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:12:37 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 22 May 2025 18:12:35 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
Message-ID: <aC/Lg58N87NA1/Mb@kodidev-ubuntu>
References: <20250522062116.1885601-1-tony.ambardar@gmail.com>
 <2160a4ad-b09c-4dfb-98c8-5d3b78a6788a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2160a4ad-b09c-4dfb-98c8-5d3b78a6788a@oracle.com>

On Thu, May 22, 2025 at 09:48:30AM +0100, Alan Maguire wrote:
> On 22/05/2025 07:21, Tony Ambardar wrote:
> > Update btf_new_empty() to copy the pointer size from a provided base BTF.
> > This ensures split BTF works properly and fixes test failures seen on
> > 32-bit targets:
> > 
> >   root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_split
> >   __test_btf_split:PASS:empty_main_btf 0 nsec
> >   __test_btf_split:PASS:main_ptr_sz 0 nsec
> >   __test_btf_split:PASS:empty_split_btf 0 nsec
> >   __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: actual 4 != expected 8
> >   [...]
> >   #41/1    btf_split/single_split:FAIL
> > 
> > Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> Great catch! Nit: should we use the btf_ptr_sz(base_btf) helper here?
> That would cover the edge case where base BTF does not have ptr_sz set,
> as in the absence of a base pointer size this will then determine the
> pointer size from the BTF itself. The reason I ask is it seems like the
> BTF raw parsing codepath may not set the pointer size, and we will use
> that raw parsing to parse vmlinux BTF from /sys/kernel/btf/vmlinux (ELF
> parsing uses the ELF class to set pointer size so we are good there I think)
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 

I tried to keep simple copy semantics consistent with inheritance &
heuristics working as expected, so that edge case should have been OK.
However, looking more closely after Andrii's prompting, I don't think the
original code really works... (see next email).

Regarding raw parsing, let me circle back since it's been a while I was
deep in that source.

Thanks,
Tony

> > ---
> >  tools/lib/bpf/btf.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8d0d0b645a75..b1977888b35e 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
> >  
> >  	if (base_btf) {
> >  		btf->base_btf = base_btf;
> > +		btf->ptr_sz = base_btf->ptr_sz;
> >  		btf->start_id = btf__type_cnt(base_btf);
> >  		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
> >  		btf->swapped_endian = base_btf->swapped_endian;
> 

