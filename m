Return-Path: <bpf+bounces-63917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE6B0C647
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FE0189ECC5
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F12DA74A;
	Mon, 21 Jul 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCkZClvB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D22DAFA3;
	Mon, 21 Jul 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108065; cv=none; b=d1gIDx18qm47ikMV4R21rCWv9v9adQOoxL2shwostyR5ije2NLJdniFW37ySRPAMFKLsTQYFmL5RvFoltHVE/S9p/1Pf2IWgE1zLQQXr4e5fJuUI7qqd0WFOjmOziKGh3Bnt0wQt9cnL1DUGhLw94luXVqyFp2J2aLVFrgZUvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108065; c=relaxed/simple;
	bh=3NzrBRDPEfORekdC3+U8iAsb14f3XlhfAmpNX7uTPu8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygc9c2ZsIon42XJIQce8FK9SfZbVnj5PsqvYAMuNz6+N5vGda8AMVyxaFudjARUVETZQixDyY5Jzeht2w2CI9n4LWOjl5Tyl9Nq7nSxIK9hH+Rp/PuIJtUYv3av/BXaYMwSASikxjqsgZKvP2/J4jHxPUTxDFLUl7HsTmblVZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCkZClvB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so9017051a12.2;
        Mon, 21 Jul 2025 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753108062; x=1753712862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVIa9EegPwP8lzRFlaQKJ0B4NqxiP1iMYFQdBTjFeB4=;
        b=kCkZClvBDIZ8H9YwMYIdY7Tj7wID/ckT5wAHtFTN0spOaxEThYio4nhyigNptqLczh
         1TmEE89rjz7bcs5LEhSgMH977u7deyPgfygs323OVfS0CCVF5kN6LpGTMtCdHWf8oCim
         OPeRSmkh5oMOSpiYSY/A6SMR2jkEfwcIpHHMPAx0moPCaY/NEdwdVapKM1k8dSucdZ21
         3aE5EeQpAx8kMrdZdz8GwqzpH16f22IqSfturqUqhN8efByYGDiZUXPqpv0XPrAA03A4
         r+Nyd2sIN2gWgnui7gPAeZLCg1YpBg2B3v+oMYKwv/+1OCFMfAP8czAsJS68xnQzmtnH
         HP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108062; x=1753712862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVIa9EegPwP8lzRFlaQKJ0B4NqxiP1iMYFQdBTjFeB4=;
        b=D8J1fylZE1cDvQ7q7VragqvLifvZSMZTZQn3dk9b1aujYJM8sJzNvTz5aIN7Fc+Yzm
         11c5F6bcJ02LMwV5SdS/+8rLyGS7BYe2xjeTWwDWjfRETBlkDHmSqhjJ59WANhOMXlyh
         +DL2bpAn1pCnVeQgO5VHFqNWQyQpZBbpgZFuPFot9xkQeZYwhdVHjrOlv6A4beU4yXoU
         JVeUqQbZVoQju6HmJrEss7r2SUpRKCny1waVxvcjWNsM6xok8QhyHqiSEBY9gPN2XyCq
         iJ1ibuW0/HeZlvzRlTW06nznJ/G9/lbFFVSaAOrMhOnEO6wkB/KFpNbvul0LAw90rXxW
         c3FA==
X-Forwarded-Encrypted: i=1; AJvYcCUo/8cdzzNjbdEPp5ptlHl6kND8fBFe0OVEVWqLw6oXgMm9Rl+h3UDxLzZJZeEegko9org=@vger.kernel.org, AJvYcCVllGz5iPiXp8BwMWGCS/KaXX1JBdJtrBzsb26TTQfGaEvWjcjZOuhV4ULGE9MnPefysm42erANiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9uHpjzJg2ey0EuoZA6sG3qvnttOOOuTnkAi+W9vrGhwmJkB6
	dx3XB2kcDjdiwHDgDA5oDlPfa6VgaX+Lzz/X5PFRkJGcN0/rDrzBlKho
X-Gm-Gg: ASbGncsdPILmtC5qwAnzLUY9e+MbT0p0wwEqYJmKthnvojn7mwyaOkyWrAAHzByrEPd
	CyYrm3lFZPaMcbBQzas0HmXK6yC9GsvFb9EXwZE/s/QMDwkuoJxUM3uJV1548tKCPhKN95Ft6jv
	u0NGifVWrknfAE8hbSGhVVBCqGpmNCTzvG8lHdp1XZAmbDfZhXed3mu50Y0uBbPk2JC52RiyXvC
	2PFwFrbl0yYtdsMQ88gVAnMj8E810y0hfPfM9Hc3TMg/9BOAwOyhXSxMG1FMu0uKmRWMTqvEU7+
	u7rM2/eili+8cG8XT0YYQGaogzc6My8PI8ED/+i7j71t9fmQfJv9FqMt4einVsmBQRq44AfnzN7
	gmXCTFz6e
X-Google-Smtp-Source: AGHT+IHGuvhoKkwzr/va9Nh5fGFkPk6p5XDTkIqseGQgyUruSy39ROGOMHozGqg8nj9rf1k7j9C2Dw==
X-Received: by 2002:a05:6402:34cd:b0:612:e09d:cd06 with SMTP id 4fb4d7f45d1cf-612e09dced6mr9480115a12.23.1753108061776;
        Mon, 21 Jul 2025 07:27:41 -0700 (PDT)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90a8937sm5524166a12.64.2025.07.21.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:27:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Jul 2025 16:27:39 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
Message-ID: <aH5OW0rtSuMn1st1@krava>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>

On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
> On 17/07/2025 16:25, Jiri Olsa wrote:
> > Menglong reported issue where we can have function in BTF which has
> > multiple addresses in kallsysm [1].
> > 
> > Rather than filtering this in runtime, let's teach pahole to remove
> > such functions.
> > 
> > Removing duplicate records from functions entries that have more
> > at least one different address. This way btf_encoder__find_function
> > won't find such functions and they won't be added in BTF.
> > 
> > In my setup it removed 428 functions out of 77141.
> >
> 
> Is such removal necessary? If the presence of an mcount annotation is
> the requirement, couldn't we just utilize
> 
> /sys/kernel/tracing/available_filter_functions_addrs
> 
> to map name to address safely? It identifies mcount-containing functions
> and some of these appear to be duplicates, for example there I see
> 
> ffffffff8376e8b4 acpi_attr_is_visible
> ffffffff8379b7d4 acpi_attr_is_visible

for that we'd need new interface for loading fentry/fexit.. programs, right?

the current interface to get fentry/fexit.. attach address is:
  - user specifies function name, that translates to btf_id
  - in kernel that btf id translates back to function name
  - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
    to get the address

so we don't really know which address user wanted in the first place

I think we discussed this issue some time ago, but I'm not sure what
the proposal was at the end (function address stored in BTF?)

this change is to make sure there are no duplicate functions in BTF
that could cause this confusion.. rather than bad result, let's deny
the attach for such function

jirka


> 
> ?
> 
> > [1] https://lore.kernel.org/bpf/20250710070835.260831-1-dongml2@chinatelecom.cn/
> > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > 
> > Alan, 
> > I'd like to test this in the pahole CI, is there a way to manualy trigger it?
> > 
> 
> Easiest way is to base from pahole's next branch and push to a github
> repo; the tests will run as actions there. I've just merged the function
> comparison work so that will be available if you base/sync a branch on
> next from git.kernel.org/pub/scm/devel/pahole/pahole.git/ . Thanks!
> 
> Alan
> 
> 
> > thanks,
> > jirka
> > 
> > 
> > ---
> >  btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 16739066caae..a25fe2f8bfb1 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -99,6 +99,7 @@ struct elf_function {
> >  	size_t		prefixlen;
> >  	bool		kfunc;
> >  	uint32_t	kfunc_flags;
> > +	unsigned long	addr;
> >  };
> >  
> >  struct elf_secinfo {
> > @@ -1469,6 +1470,7 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
> >  
> >  	func = &functions->entries[functions->cnt];
> >  	func->name = name;
> > +	func->addr = sym->st_value;
> >  	if (strchr(name, '.')) {
> >  		const char *suffix = strchr(name, '.');
> >  
> > @@ -2143,6 +2145,40 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
> >  	return err;
> >  }
> >  
> > +/*
> > + * Remove name duplicates from functions->entries that have
> > + * at least 2 different addresses.
> > + */
> > +static void functions_remove_dups(struct elf_functions *functions)
> > +{
> > +	struct elf_function *n = &functions->entries[0];
> > +	bool matched = false, diff = false;
> > +	int i, j;
> > +
> > +	for (i = 0, j = 1; i < functions->cnt && j < functions->cnt; i++, j++) {
> > +		struct elf_function *a = &functions->entries[i];
> > +		struct elf_function *b = &functions->entries[j];
> > +
> > +		if (!strcmp(a->name, b->name)) {
> > +			matched = true;
> > +			diff |= a->addr != b->addr;
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * Keep only not-matched entries and last one of the matched/duplicates
> > +		 * ones if all of the matched entries had the same address.
> > +		 **/
> > +		if (!matched || !diff)
> > +			*n++ = *a;
> > +		matched = diff = false;
> > +	}
> > +
> > +	if (!matched || !diff)
> > +		*n++ = functions->entries[functions->cnt - 1];
> > +	functions->cnt = n - &functions->entries[0];
> > +}
> > +
> >  static int elf_functions__collect(struct elf_functions *functions)
> >  {
> >  	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> > @@ -2168,6 +2204,7 @@ static int elf_functions__collect(struct elf_functions *functions)
> >  
> >  	if (functions->cnt) {
> >  		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
> > +		functions_remove_dups(functions);
> >  	} else {
> >  		err = 0;
> >  		goto out_free;
> 

