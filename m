Return-Path: <bpf+bounces-78697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D46D18A29
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1D830115CB
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785238E5E9;
	Tue, 13 Jan 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv0a/Qtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FB2BE7D6
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306105; cv=none; b=mutkPc/3Eg/WsBsCh88gFNXVn8/wlOSvMAtMxN5bOF6xf8vQ/04j+Mk0HQTz9ISetxDxiPwbvcPAMIlaClb5h3JQjxKfTHGuamN8u6FLu+k3GT+lLNzSsJJgqaOZ6eVG0qL/aSZkjLfx8lHJng6uhsr53nZ1Aygj+xO/LhysR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306105; c=relaxed/simple;
	bh=gYpv1TmAj01mtK45BmSmSMaz0s06ZLJS2JRQwI5w9d0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9mYW2L4Na1//kqeRT0lkdyxfd4aFfUZ/hAAXj/WSsc81/ucTzri1yteqV7qLkLszu4AG2gYACBNRZFL4PN6jB9LnT/PiZ02YXsG7R+/rHSDUDDkey5zPPdPtK2KvhO6PiQhCjSnRpYY91SVb40nOVhQSfq1EnO+DkgTgmLD68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv0a/Qtw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso43349615e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306101; x=1768910901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSQvCi29akm08N5Mw9WY17zV/EyUsoGyptBD5STXYks=;
        b=cv0a/QtwiaQDMn93BcBcBtlaw6Y+eu6WRPP9p7liBAB8IBnzIqs646/pPEzxvqy2rO
         KH4KBpitat/izYbpSqBKlDNj+C4KqK+UGcfM4/a/s5VUbye4KZW33k9MpAm2EIpI8P4P
         TF7AX+7p/mxlmURBBwTr5KP4aXHLgQZbRYo9DNs2erO9TkF0V2O+HEooOUFSC4V4pIRt
         EGaR/29IPEBnPpRWDmM81dtk+JFUFhTLZQ2a2vUPYKk7XBIcg+BH/gZbXBm+4AslwK9l
         ppm48p2RR6yRvvYYfVz9ItiX1tCUKHOYuBjSItKLP0XiOuGR+9BtTqR2bupjJKMN12Oh
         XDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306101; x=1768910901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSQvCi29akm08N5Mw9WY17zV/EyUsoGyptBD5STXYks=;
        b=hqhDyRCwJgyyMuQSx71wfJFya1Wt8DMJwXyqUwOXPY81Ux9cAO9WUroJLsh3P2BDzE
         WVwN3qT2v2QTd1LJog7JGcEnWCEuwE/BRe3N2nWH05Di9KRJTVP2NAjRzmSs81fGmzAa
         7AuYJQhCgX3wnvy+66/DuoVjb+de26ZDUsh7jMp/RYK7aUzzfJxNUqOaBmQvtyyZ7vLY
         367enjkdRP7jOVFkxs6oc8CNtU4Y3dDZgnL9yEw24lcLXQnr/ka+3M9s3+nVtJDXDg3K
         /Iuvccxcl/RZquMIH27kkkv6NZp2DhROmCKaJiVP835rd8DF1wPNZzr40hkwYCbuV329
         9k6w==
X-Forwarded-Encrypted: i=1; AJvYcCWlHfSbMWkHOdtrPBDNZEtAWubmHH1yOHqLaTtjR0urIcCKO1RxT4PGQwUYJzPs5ERnZdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrIYb5Mi5fRax6ClIweSSux1rCSzipZfe1nTHnPyu6tqTT/b9
	8KECLrq45FVyFPO77nWvgbDtKiF3ymrqox8iUopUl2hepiCZnHALLhY+c4bZYA==
X-Gm-Gg: AY/fxX5dJbLE9pqdfNJlffefXIVWnkQUnz8f8LZ/qJFdQLPfkmAM8LWGGtuun+/EEGE
	dTfgY5/1tRPREoth+yRLT9soT5kQuDR/rvRDOBprusYz2xCFfEoLyeeARvBcNEm6KjtPXG2kafR
	iCzRC6fpF45T4NBp2ymJpxErGr5dExFVSrF1nqTF+2ONDHJpHndd+u4/nDuyDPGJBoZvsP6qb8B
	T5z1TBCov0sKDUTwzbZ3HZPhp4leJaP0sxG76e2wjlCrktgzpuUaiOBKsDmHdZBy4CHJ3k1rCgP
	UD9Xigv537oWsgA0R9C8iYqUJ/+HNzbyMoEvjYWWwkwJfp8onoQ25LlJREgJgQGA+00aZ1OcOEr
	/4nVO2V7u6anlRlGVv0jxxfkb3L+jmg4yre1Nw7aDWkdatniwDysTGBLK/eit
X-Google-Smtp-Source: AGHT+IHxhS2Y6mE+jXejm6/rZedYm8xSZBdvuUC4IiCKJpoKzunpsBcgKv2n5QJpjm7Sy8S+xmw1TA==
X-Received: by 2002:a05:600c:3b27:b0:477:429b:3b93 with SMTP id 5b1f17b1804b1-47d8fc55375mr157315875e9.18.1768306101164;
        Tue, 13 Jan 2026 04:08:21 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed9b2a92bsm15307675e9.0.2026.01.13.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:08:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Jan 2026 13:08:19 +0100
To: David <david@davidv.dev>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Usage of kfuncs in tracepoints
Message-ID: <aWY1s2S2zw3UHyTP@krava>
References: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
 <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
 <bb6a3ada-ddcf-417d-82c7-f86cde6ed4f7@davidv.dev>
 <793831f1-a8ea-4e0b-a0e8-c86c30b1ab2f@redhat.com>
 <b07a7008-a093-4a31-8096-1d5c33890c9d@davidv.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07a7008-a093-4a31-8096-1d5c33890c9d@davidv.dev>

On Tue, Jan 13, 2026 at 12:53:18PM +0100, David wrote:
> On 13/01/2026 09:05, Viktor Malik wrote:
> > On 1/12/26 20:08, David wrote:
> > > On 12/01/2026 19:03, Alan Maguire wrote:
> > > 
> > > > I think you need to add "__ksym __weak";" here i.e.
> > > This change let me load the program, however, libbpf cannot find a
> > > kernel image at
> > > /sys/kernel/btf/vmlinux, because /sys/kernel/btf is not populated on my
> > > system.
> > > 
> > > My kernel _is_ built with CONFIG_DEBUG_INFO_BTF=y, is there something
> > > else I need to do
> > >    to get this path populated?
> > Did you try rebuilding from scratch (with `make clean`) after enabling
> > CONFIG_DEBUG_INFO_BTF? If the sources were already built without debug
> > info, they will not be automatically rebuilt just by adding the config
> > option.
> > 
> I thought the change took place because `make vmlinux` took a while,
> but after a clean build, it does work.
> 
> > > Because this path is missing, libbpf reports:
> > > 
> > > ```
> > > kernel BTF is missing at '/sys/kernel/btf/vmlinux', was
> > > CONFIG_DEBUG_INFO_BTF enabled?
> > > ```
> > > 
> > > But I see from strace that it tries a few fallback paths.
> > > In the meantime, I copied my kernel into /boot/vmlinux-6.18.2 so libbpf
> > > can find it, but
> > > now the loader says
> > > 
> > > ```
> > > calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF
> > > ```
> > While libbpf may try other fallback paths to find BTF, using kfuncs
> > requires the kernel to find that kfunc in BTF and kernel will only use
> > the system BTF (the one from /sys/kernel/vmlinux/btf).
> > 
> This is good to know, thanks. I've removed the /boot/ file from my system.
> > > Can I not use `bpf_strstr` on a tracepoint? To validate, I tried a
> > > `raw_tp` but
> > > had the same result.
> > There shouldn't be any issue using bpf_strstr from tracepoints (or any
> > other program type).
> > 
> > Viktor
> > 
> Do you happen to know how to generate the kfunc headers with bpftool?
> Even a new bpftool build from the newest commit,
> ad5d76e5c6b622e5ed05fecfa68029bae949d408, does not generate headers:
> 
> ```
> $ ./bpftool btf dump file ~/git/linux-6.18.2/vmlinux | grep strstr
> [28376] FUNC 'bpf_strstr' type_id=28354 linkage=static
> [60023] FUNC 'strstr' type_id=60022 linkage=static
> $ ./bpftool btf dump file ~/git/linux-6.18.2/vmlinux format c  | grep -c
> strstr
> 0
> ```
> 
> Could this be related to my host's kernel being older than 6.18?
> 
> For now, I'll generate my files from `kernel/bpf/helpers.c`, but it'd be
> great if I could use bpftool.

hi,
do you use the latest pahole ?

jirka

