Return-Path: <bpf+bounces-32378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4190C461
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F131F22C81
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D901292CE;
	Tue, 18 Jun 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0EGZZ6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742018E1D
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694745; cv=none; b=iEik+y5eUcg8O09oid5zh6yZQ1Hpv9SfGOc81183MT67NUjbpDWM942clHu4IlfmvYBAHWsRGM2faKWIH2zFZRqyYfH2nGK+GaaycEH4S+ayL9Ez7Hg2ms/mdqK7ogdn/1qcshJix7RpJkoMTtqv6m/x1zUFmtwbcjEwqDHlScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694745; c=relaxed/simple;
	bh=rXSpm5Mh76t4HVizFsI5iJ4EqtUhnCZk+eMkd9lfI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk3JFcHPjp5RgCCwEnSeJZ0i7zjLOsUFBPf2PtV6J+vHWn0Vb1gkA9MW+xcCABkad5f8lMkP1Mc/QgngF0/3ZY3Qp3cVCeUifkm95octInzl1UexBdmM1rlBr+CrpqcsCYmZAVIjpaHv92485v8kTPwcMLHaG3ZadHtuv/TS3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0EGZZ6e; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so239985566b.3
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718694742; x=1719299542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znYsNneSY19OgShjIXFj7ODOWXwqvOwsQ3XL6yurjgI=;
        b=Z0EGZZ6e3ljV/nXP9wEfq/1hTSKAuwWjT0FgI2r6PutJpe1Xk4TJKT5etgIDFBBDZ5
         4xRM4xoqwc/IbziaYiuj3PEh66cAeeqhjTJ8AacliPoqavypDHzPe5kBnm8YNyjqd1wH
         Z/LQQX4zia/lt6Dx4fvPSacrdTI8rlbStXxEicnCvXG8OexXdPIDLGmXaas4IGrsYq3I
         TgYqk6TznXHGphvEQIa0JRa/OGSgSL3Tqw9jlMPshIQo+B6jq2pqTVwhHI7kpUMSKhCh
         irgsgwBxQ5wnGA5KdlDWLNV9XD8uP4a8dnEs+1cW+MrDHRmWSVH9C7ubKzDBWJyrYofP
         VHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694742; x=1719299542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znYsNneSY19OgShjIXFj7ODOWXwqvOwsQ3XL6yurjgI=;
        b=U2z/mwUc37FJb4UbBikGgCmrfn/B4ybxWTvmv7qcCYaOfA19eKQtyou90JD2Wm7ezr
         ABr2nOd6qLd7upxXgrOGOl8+v4e8o0rwXZJF8k3aRPqRL6GKkBj2qFocs7npUpEOSw6X
         MQZEovFOGWHFRFcTfMmf7tstD+3KmKtTwGrtTjGn8iN0nWADCINgd29bnNOaubAYghS7
         G5FcCqOSAUZJ3FtUQrimQt1TWSPV3OM6vJMkJ37SpwWwA22hd4iLwh6Aay2bui1TojwW
         c8CD8BWKwqZB5ErMxFWxWRhwlJtDm/rYa1skvgY0nsuFBKNJzhV7vYHa6XykFSl7ciq7
         BUxg==
X-Gm-Message-State: AOJu0YwjK2fzYLcEomkuSpTlth481xYIU3i1Q3oM0cy3iWB/zP/JGl7l
	9glgt1PfSovBzQpoTZA3J8iBAYcUuYGKTnLW1BQy2d0odJ/amfRxSvAmfvbQWw==
X-Google-Smtp-Source: AGHT+IFmIcv8BZ7vNxsI2kA8L4rX6b5Hv1BY6gyDD6fWNFnHzXbzcF7h8ltwb+BG7+bf8uGB/7wenA==
X-Received: by 2002:a17:907:9689:b0:a68:fcc9:6c1c with SMTP id a640c23a62f3a-a6f60bdc4d3mr1137579466b.0.1718694741597;
        Tue, 18 Jun 2024 00:12:21 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f988c2sm588966266b.199.2024.06.18.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:12:21 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:12:16 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, memxor@gmail.com,
	void@manifault.com, jolsa@kernel.org
Subject: Re: [PATCH 1/2] bpf: relax zero fixed offset constraint on trusted
 pointer arguments
Message-ID: <ZnEzULLoRfjYqOin@google.com>
References: <ZnA9ndnXKtHOuYMe@google.com>
 <28250a9a52c8a10dc7c37e15df9a9d446976e4eb.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28250a9a52c8a10dc7c37e15df9a9d446976e4eb.camel@gmail.com>

Hey Eduard,

Thank you for taking a look at this patch series, much appreciated.

On Mon, Jun 17, 2024 at 10:38:56PM -0700, Eduard Zingerman wrote:
> On Mon, 2024-06-17 at 13:43 +0000, Matt Bobrowski wrote:
> 
> [...]
> 
> > * For OBJ_RELEASE and KF_RELEASE BPF helpers and kfuncs:
> > 
> >  * If the expected argument type is of an untyped pointer i.e. void *,
> >    then we continue to enforce a zero fixed offset as we need to
> >    ensure that the correct referenced pointer is handed off correctly
> >    to the relevant deallocation routine
> > 
> >  * If the expected argument is backed by BTF, then we relax the strict
> >    zero fixed offset and allow it only if we successfully type matched
> >    between the register and argument. A failed type match between
> >    register and argument will result in the legacy strict zero offset
> >    semantics
> > 
> > * For KF_TRUSTED_ARGS BPF kfuncs:
> > 
> >  * The fixed zero offset constraint has been lifted, such that
> >    KF_TRUSTED_ARGS BPF kfuncs can now accept a trusted pointer
> >    argument with a non-zero fixed offset providing that register and
> >    argument BTF has type matched successfully
> 
> [...]
> 
> Hi Matt,
> 
> I've read this and the next patch once, but need more time to provide
> feedback. Two quick notes:
> - It seems something is wrong with the way this patch set was sent:
>   for some reason it is not organized as a single thread (e.g. on vger).

Yeah, I don't know what happened there, I must've screwed something up
whilst sending out the patches. The process I use to send these
patches out is rather manual ATM, so I should probably look to revamp
it so I can avoid such hiccups. Apologies about this, but the V2
edition of this patch series will come through structured as intended,
I promise.

> - I see how OBJ_RELEASE arguments trigger btf_struct_ids_match() in
>   check_release_arg_reg_off(), but I don't see how KF_TRUSTED_ARGS
>   trigger similar logic.

Right, the btf_struct_ids_match() is done at a slightly later point
from within process_kf_arg_ptr_to_btf_id().

>   Do you have some positive tests that verify newly added functionality?

The only positive test which demonstrates this new usability
improvement can be seen in the BPF program test_nested_offset, which
I've also included within this patch in:

* tools/testing/selftests/bpf/progs/nested_trust_success.c

The test_nested_offset BPF program is effectively a positively
converted version of the test_invalid_nested_offset BPF program which
resided in:

* tools/testing/selftests/bpf/progs/nested_trust_failure.c

Maybe I could look at some other positive tests too, but the above was
an immediate and obvious candidate. I also intend to post out another
patch series which adds a bunch of new BPF kfuncs. These new BPF
kfuncs will basically piggyback and rely on this new relaxed register
fixed offset checking, so we'll get some implicit positive test
coverage there too I guess.

/M

