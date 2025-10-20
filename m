Return-Path: <bpf+bounces-71372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5CBF0119
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564603B0D01
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE522D0637;
	Mon, 20 Oct 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUkqiCBL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A142ECEA8
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950817; cv=none; b=nvhRMlKH10ET+TwWyyVg77zVtmqfa+GaHPQ3WkPqFGFB5daeSiUgIcF5U7vjRk0ACO8B/fJdk7hQjOhMBACdapn2XwS4+kQMYsgnB+2z5d+2BzJJD9Wt/a+IjM7g3K0RVNnBnbWwdPyJz3ybuZdvdbfXfD5CtEFXzmQL3Dd0JA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950817; c=relaxed/simple;
	bh=zvaY8lf7qWqGy0iOB/oaVzQo+PIYm5LFANizKettLc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RivS2HzNPJcw9yPwfSeWItS9eLPRGQ1/64NvTmgmj5Knpke7aPfU+r519NtUgowL1hcyDPPIq39opr2jtushAs80EAYuwRT6M6jgsRkY4igvJ4A2y68lGuJWkkofPbaNC1HReUYrTnU+7Oi3pWGeru9UO1gbyhj2bxTY+mAgCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUkqiCBL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16397335e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760950813; x=1761555613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nR9vTvm7ILndkvrr9eMtht4nb0L6F+CVXBeLHtxdVM8=;
        b=OUkqiCBL7w99OG2SMqmSnOLPeJ8DsUsS04H59f9ivKwAPjvGUW+4K6TX8TX9oflqa2
         rsx2P1qKuJshMempdpZWnGdXtz4HhwrdH/uNyj0LS7INqvYjVQ1Nkr+mDeMkBiIAg9Fd
         qIBPmMZ5XUiyh1incStnYDRAiF64peSBihJk8zwNNo/2+tSkTLlQT750QDIg9wrq3DrP
         WAvXoJOW3o20sp04cnn85qQcnZiYJSwoh63eeqKaxVvYfD1wfJhr0R1kTGq0VVpYIbHs
         lVLxQ9RnGizaduNRZRCaCiX8AKJPa7+DPmSixO5qF6gtKWL9muMbU9x2bvhGnXeiDy+V
         XEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760950813; x=1761555613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nR9vTvm7ILndkvrr9eMtht4nb0L6F+CVXBeLHtxdVM8=;
        b=Pm/SwVrLDC74ZQpv+LC+mjuuqSk4SDzJ1J5oOW0eoUskp0ZK2Y72vqAuqcLXTkBxJP
         elnZkdvY0UwymW8fiURDbqvz+CG0itz+whABg8+/O1cyyuexznsuvmHjM5cFti10Hxzt
         1BC/UFnorhWWvKohhS7EgzmSIJy2VtEEQrG1+h/NAeHHnJahvkvlCDjWNGlGQFsY2ggY
         t4ow3G/NVA4BhfYy2ujZM0SeSLsfQbCT4oM0zqagKcinM5xn01geLSkWmZqXeZ5mMj4g
         KFZ4h5ZA0Qahh/GpaBgwGHkl6ODKp33LeFVCyoITlM3ZsqdB9X48l80BQiCAc8+77Qxp
         fk1w==
X-Gm-Message-State: AOJu0YzN1TeVUFzTPKbmVATs42/DHJG3eNkrAApLXcVBij0UqOwfQNDg
	HfDf0K7bDXxR2RyWMFkf7E9gfbFWA0OvMj8mznouGQfe9ytxS+LEf6+5
X-Gm-Gg: ASbGncs3znEPBNBY865DSVtLqoHBvKQqPoIhSNdyvce2cpy9XlYRnPYIs8lR5GRqONF
	rIibDPZzHaOchw/w1VYVXWBEDdXsZRtN3pqkWKRFzzd3EbPfNL916yx3kZDIfMt9yRyrupU2YRl
	oWGZIEbN6xNGHW0oZFadzEDU5aT87Fd8PUkBPG89jqCQGowXfpya0lyhNRHAdY02ImAHqmaA13P
	wQXyz0GprIb5sWhQHrsRkTC8OlvBGYzsyTfBFqrWDS9+Sk23JU14lhKyTGj/W4zftvWt4YFtr+y
	2wdhbIBRz6YDOiDG206u2Xw1embhtPQ9p1SkJkqpUz+KvNK0PBTOZ/iTo13LSh34U3tFkmk1djv
	IJdQh1zdGIE9JJTwtR+CTPEhp4Kg/6TLtUQCvNBVjgr3V0YJaXF7dpcHW2CM33WmlI+gHO+33JT
	3vC3vvqTRKLq45xw0T2VNBg/iRSFmQsaI=
X-Google-Smtp-Source: AGHT+IEv32CHHsaMz29Mey6R5r03clG9N54tobJc2ra9qYSg6/JIiCF+jpuXcA0/8HjP7dpq7ngnDw==
X-Received: by 2002:a05:600c:8b0d:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-4711787442amr89749505e9.5.1760950812794;
        Mon, 20 Oct 2025 02:00:12 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cd833ebsm107387605e9.3.2025.10.20.02.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:00:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:06:37 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
Message-ID: <aPX7nYh09CPlFgra@mail.gmail.com>
References: <20250918093606.454541-1-a.s.protopopov@gmail.com>
 <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com>
 <aMwy+pt+Rg1eNr0z@mail.gmail.com>
 <CAADnVQ+2ic2gWyvqp4qFCwZpKqV+7BDnovL08Jp0tFSaC4pm9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+2ic2gWyvqp4qFCwZpKqV+7BDnovL08Jp0tFSaC4pm9g@mail.gmail.com>

On 25/09/18 09:26AM, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 9:21 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/09/18 08:02AM, Alexei Starovoitov wrote:
> > > On Thu, Sep 18, 2025 at 2:30 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > The progs/stream.c BPF program now uses arena helpers, so it includes
> > > > bpf_arena_common.h, which conflicts with the declarations generated
> > > > in vmlinux.h. This leads to the following build errors with the recent
> > > > LLVM:
> > > >
> > > >     In file included from progs/stream.c:8:
> > > >     .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
> > > >        47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
> > > >           |               ^
> > > >     .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:14: note: previous declaration is here
> > > >      229284 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> > > >             |              ^
> > > >
> > > >     ... etc
> > >
> > > I suspect you're using old pahole.
> > > New one can transfer __arena tags into vmlinux.h
> >
> > Ok, TIL about CONFIG_PAHOLE_VERSION (before I've sent the patch,
> > I've updated the pahole, re-built the kernel, but didn't do `make
> > oldconfig` after updating pahole.)
> 
> Yeah. It's a footgun that few people are aware of :(
> I was bitten by it too.
> We have a small section about pahole in bpf_devel_QA.rst.
> We should probably expand it and list the common issues and how to fix them.
> Every week somebody sends a patch due to old pahole :(

And today I also learned about the "next" branch of the pahole repo.
The "master" branch was too old to generate kfunc header for a kfunc
compiled with a .cold part (namely, bpf_dynptr_slice).

As the "old pahole" thing happens to so many people, maybe there is
a way to in-source it into kernel?..

