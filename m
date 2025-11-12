Return-Path: <bpf+bounces-74272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D1C5104D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6680E4EC7C6
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB32F12B0;
	Wed, 12 Nov 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JGwKsVaH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F42F0676
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933935; cv=none; b=EsnRYSolmKNNJvTpVgHhhF2MxLIotO77UyQP+9y7+w0OMDAZbMv1LLeNnOhC91iaf3otelikFK+09y3WWaYaclXp6uwfbhsx+RikLcAUQp7LAXbXS10LJI0iszMZqD0jg8pP4hUx6kMfUo8dYKFCBRSupDCfaOWoaMA1HRVTbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933935; c=relaxed/simple;
	bh=PI6ZGWyo084vtAmcwr3XK4acwTrj1OVP/mypm1sK568=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmH+Hzz857TuTTOzpwxM8A6gnYctd/Kg4y6YmwCthhb4LKfil7/jufmrul+BmkM+6teKtAz6qQVS8RxeskbDe6X1qdypWnD1qeLPAeXKnEQc3maWal8PgInXTEPr+UReEpZ3mwEfxRaswzeNRdpdcVnRWs/Gk74HOtoUnilfPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JGwKsVaH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so691542a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762933930; x=1763538730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baF77Nd6PddrT+NcaQcnWaJHYcsWM5/03L4b2UgZmEs=;
        b=JGwKsVaHr8J3u8f5yM34xz/z8I/lHfkBPaYAZw0pV1K7/gIreV8H31BSZwAZfUpuLt
         82gmiOm4YXWwNV9/GzKQZxn4JtsNt3da7H5Ea6H/2BLCDXEXDG6UnCXwSUpSVZiMSy/f
         tFY4hfutCH4ZCU/dvvHNXxJdhgk1Ti1yvb8WVPlurWwApCeJqvNWy4apz3WwtGa+buWC
         hKKFAFAuiDNASaA4QwTeSm02zC5LhHtL0d3WPW126LkZTyLldCFGvNzKER8PjTY5K8OI
         xTEouHlEqwXXtFhNrM80CoFN9ZHGu0U7+HnlCA/GjXU2VDKqfx28yzq9q/VGhc2tbxFe
         o1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933930; x=1763538730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baF77Nd6PddrT+NcaQcnWaJHYcsWM5/03L4b2UgZmEs=;
        b=LMCo8Slt79yHpR0LEaSf6J49rhzqQDNyNpWACV7F9Ok92oVa3enIBXGsethaCLb19u
         +HIf0+mIaMPpVfoUx+WZ4iaEZCHyrQVPZa7WXsw1HBh6aMJnereXoULgkOwbd/tDwAHL
         BFZjR1Lp6cSawT/x5zzq2RFo8cgbeioAG2HCYcZl6IXFASOJ8Q5tArfUY3/Ug4ifiRYV
         N92Sj+Gy2jDx8+M6vmHz48FL9u50ik3oKHKgkQo6gsWm00+W27xSf1QfKb6+3aiZpDMx
         J4iPZMxhIIqwfTGCpPMWSsHBLsp8kNr1EsMnNNUTpGXvaPmCVSP3NCb97v5H5vIq1MZw
         PGug==
X-Forwarded-Encrypted: i=1; AJvYcCUGL6ZP+CxMiwJi1GjdTDsVhXtmXL31eglwoht00/BdTB9XjQDAkxRzrlKhF5R8sUosZ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Pl6PCgWQuH09slaTzWwVkH9wptvaLq8PfSX5nVi03Ak06jyy
	WWLip/VmO9OttwRaACjeBb1wN1/If157WVWJMo2eZp2YGxoW2GOqyPy80AvjI2+10VMUuw5UH3P
	JsrKk
X-Gm-Gg: ASbGncukdEDiSSkLo1F5l8kHETlDkyYi3GdrJw6dlRjWBsKRxa+FdZh5syx5Yitn77W
	aNNB+o8onDCciqUEuLbOaodL1CZ+1Q1ajVsmM7hreStiUg7RO0uRL2t57sNR5uoWW10DE79ueP0
	9TLwDcC29MFC/zs8f74FD3vBlaq7T3KV3/sVEAg0T0fQDX1OV2YnJhmGyWazRJ+fZi2nVllypPi
	WcePv+Fl3nx2ar0+ircAAmHl5M2Izf5NjDawHR7bayrl5czMqAp6a/qL3sCzDmZZvUP5/dH2pkt
	5lekTsSb2uS3UIlaOGBpfkeDEJKOZdcvav0GtzN+/Il1jGCOQqs8IVTfHzB0Q5ryS8XRrKwPsYO
	Uw/hSHGHGFFmk0V9sM/A5JsEF3CjY2DRWU0wrF/cGnx485olBKucgWY5lHGpNBhSClQqxU/cSHM
	7MY6s0NbqHdqRfGA==
X-Google-Smtp-Source: AGHT+IHrUFgBXB0mlhlDx5ulVZ/CWC4rg/lpc+ghJAkmKWSBb8GGXulAMnQrIW2KVp+058faH6NYGw==
X-Received: by 2002:a05:6402:218c:20b0:640:93b2:fd07 with SMTP id 4fb4d7f45d1cf-6431a579409mr1286553a12.33.1762933930379;
        Tue, 11 Nov 2025 23:52:10 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm10653900a12.22.2025.11.11.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:52:10 -0800 (PST)
Date: Wed, 12 Nov 2025 08:52:06 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
Message-ID: <aRQ8pu_57IeA_Jn_@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-4-roman.gushchin@linux.dev>
 <aRGw6sSyoJiyXb8i@tiehlicka>
 <871pm4peeb.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pm4peeb.fsf@linux.dev>

On Tue 11-11-25 11:17:48, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
> >> Currently there is a hard-coded list of possible oom constraints:
> >> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> >> Also, add an ability to specify a custom constraint name
> >> when calling bpf_out_of_memory(). If an empty string is passed
> >> as an argument, CONSTRAINT_BPF is displayed.
> >
> > Constrain is meant to define the scope of the oom handler but to me it
> > seems like you want to specify the oom handler and (ab)using scope for
> > that. In other words it still makes sense to distinguesh memcg, global,
> > mempolicy wide OOMs with global vs. bpf handler, right?
> 
> I use the word "constraint" as the "reason" why an OOM was declared (in
> other words which constraint was violated). And memcg vs global define
> the scope. Right now the only way to trigger a memcg oom is to exceed
> the memory.max limit. But with bpf oom there will others, e.g. exceed a
> certain PSI threshold. So you can have different constraints violated
> within the same scope.

Please use a different placeholder for that. Current constrains have a
well defined semantic. They are not claiming why the OOM happened but
what is the scope of the oom action (domain if you will). The specific
handler has a sufficient knowledge to explain why the OOM killing is
happening and on which domain/scope/constrain.

-- 
Michal Hocko
SUSE Labs

