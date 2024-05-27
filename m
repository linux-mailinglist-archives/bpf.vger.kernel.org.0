Return-Path: <bpf+bounces-30636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B168CFD10
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7826B1C220D6
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BE13C679;
	Mon, 27 May 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsVf6wIr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF713A40C;
	Mon, 27 May 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802496; cv=none; b=Z4kNCfFSHKapQ065k+LwFsQzK2Jr+nkOK3PCKPJ68q+xuC3oWw2n/a8+s0VB8uCJ84YDoqIiQ79+Sh3m3MlaHMXCECLIpuI/GZnhYTwGMJDckH2LkcoUbFfjVmM2yC8VUvZg4EXXk/wSb9NKVAySx7oUSZ5/b5HdgJtMDP41/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802496; c=relaxed/simple;
	bh=GZmGEocmWzBeg3ElgilT4NF4U3VsdfiPEyNkcWMuauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxN9ObIBD8SmTXCDPNXvgxq6Oe8gcCU5PjgTVO8S/Ec2JFrqsW4ZCGTzV4h1tIAqZVbUSVGacmZhYKKwYUyvmQIMuxJo//6tpta9eSroqqgDOr/j/uNfkpEdNSpOB+LPQcmFMREete+qVS5m7VeX5Jy3Zv4X56bAVlNG6mDlNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsVf6wIr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6266ffdba8so218189966b.1;
        Mon, 27 May 2024 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716802493; x=1717407293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5cBODzR4p/d1EwJmZY+G8DbaP2yePNKcsEM/yAst/A=;
        b=VsVf6wIrhvQfX4OwzETDZGjpE7iVfOxvx7cnGtGsDG9qbjmCWa2jtewRLa8KBM7V0I
         m1VLLTZbMRJhkKBxG65LQzS8nPKgmdSavEeI9pHFKk8hNYjbhfJ5gaYjHHsLubNvMjis
         q+tLtuwOZXiA50u3/Wk48mvScTR47qV0eWZh6AjSISyP639FcC2yg+X3sbr04vK0jA9t
         Ci8wbOJ30mf8EoAtGs6tP6J/umk5zxmaGfVqXGWteLH8iBbnyZc4pM7JIx1qjuUX7tLE
         Wf0BT3UBExO5Uq3w8BXkq8OKympnn91p/+MLMsMxZgaNnnr5LQKtiH+osaqMuQ0l5Fv3
         D9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802493; x=1717407293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5cBODzR4p/d1EwJmZY+G8DbaP2yePNKcsEM/yAst/A=;
        b=TfyEt06USZP+uu1L0NerNebfLXkee5a0MJeH/7JZdGwMqeJBColxryT1X7GSI5+zlE
         fEB/cHXcu2DJL9faeA+V+QHXoPwi5+o3f678jtP0N9U0A8l5/8DmlW07msNPXP1HZwbz
         l1Cpy0WN4JwNzmHKeBEmMDFt/NAzicHU40MzXRMO7gbmBzP5MaLxQC232vJPsytIHJVx
         79Dh7K36SzaaKXhSHfLH77TFDavPbWQLRJ4+x+gJQ+aocbtEAISIzHj03+cu/eWYyQ5k
         b/F4nRRs7O9MZA4Z95Mut9Q3lpmV7SI9hY+hwK9J1oeZbyfkAyzzqBLE6X/QbzKKcqNK
         eP+g==
X-Forwarded-Encrypted: i=1; AJvYcCWA9ezkekuoTLGru8fu20DINqPxgp6dwaTprV7dkTyA1jDoVq4CJQY1/slONxd7oaM04tM+vxewrBQl5ayLD916ENo0FGKTASmG0dI4Qi68wLOKrQyOVl82CGyYw8CcHmni
X-Gm-Message-State: AOJu0YziBbZwaInknJ/PVOPMlldOVdEoFawHUr4HbHN/rG+J/knUa8Bb
	qN1QV567U72saRfwAxaQ5ohCuShY+usCBW3Vzi7ahsHNkDI8r/Cm
X-Google-Smtp-Source: AGHT+IFjYaXZRXFnIlLX5I0tdJRm3cO32xFRJZGBWA4rLg7R5JB0Spcaz69YutEH+tX+ZrdKFwP7YA==
X-Received: by 2002:a17:907:36ca:b0:a59:a83b:d435 with SMTP id a640c23a62f3a-a62641cb750mr676443566b.18.1716802493112;
        Mon, 27 May 2024 02:34:53 -0700 (PDT)
Received: from f (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8b87fsm469221766b.158.2024.05.27.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:34:52 -0700 (PDT)
Date: Mon, 27 May 2024 11:34:36 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Howard McLauchlan <hmclauchlan@fb.com>, bpf@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
Message-ID: <3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye>
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
 <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>

+cc Linus

On Thu, Oct 07, 2021 at 05:32:52PM +0200, Vlastimil Babka wrote:
> On 10/5/21 17:31, Jens Axboe wrote:
> > Allocations can be a very hot path, and this out-of-line function
> > call is noticeable.
> > 
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> It used to be inline b4 (hi, Konstantin!) and then was converted to be like
> this intentionally :/
> 
> See 4f6923fbb352 ("mm: make should_failslab always available for fault
> injection")
> 
> And now also kernel/bpf/verifier.c contains:
> BTF_ID(func, should_failslab)
> 
> I think either your or Andrew's version will break this BTF_ID thing, at the
> very least.
> 
> But I do strongly agree that putting unconditionally a non-inline call into
> slab allocator fastpath sucks. Can we make it so that bpf can only do these
> overrides when CONFIG_FAILSLAB is enabled?
> I don't know, perhaps putting this BTF_ID() in #ifdef as well, or providing
> a dummy that is always available (so that nothing breaks), but doesn't
> actually affect slab_pre_alloc_hook() unless CONFIG_FAILSLAB has been enabled?
> 

I just ran into it while looking at kmalloc + kfree pair.

A toy test which calls this in a loop like so:
static long noinline custom_bench(void)
{
        void *buf;

        while (!signal_pending(current)) {
                buf = kmalloc(16, GFP_KERNEL);
                kfree(buf);
                cond_resched();
        }

        return -EINTR;
}

... shows this with perf top:
   57.88%  [kernel]           [k] kfree
   31.38%  [kernel]           [k] kmalloc_trace_noprof
    3.20%  [kernel]           [k] should_failslab.constprop.0

A side note is that I verified majority of the time in kfree and
kmalloc_trace_noprof is cmpxchg16b, which is both good and bad news.

As for should_failslab, it compiles to an empty func on production
kernels and is present even when there are no supported means of
instrumenting it. As in everyone pays for its existence, even if there
is no way to use it.

Also note there are 3 unrelated mechanisms to alter the return code,
which imo is 2 too many. But more importantly they are not even
coordinated.

A hard requirement for a long term solution is to not alter the fast
path beyond nops for hot patching.

So far I think implementing this in a clean manner would require
agreeing on some namespace for bpf ("failprobes"?) and coordinating
hotpatching between different mechanisms. Maybe there is a better, I
don't know.

Here is the crux of my e-mail though:
1. turning should_failslab into a mandatory func call is an ok local
   hack for the test farm, not a viable approach for production
2. as such it is up to the original submitter (or whoever else
   who wants to pick up the slack) to implement something which
   hotpatches the callsite as opposed to inducing a function call for
   everyone

In the meantime the routine should disappear unless explicitly included
in kernel config. The patch submitted here would be one way to do it.

