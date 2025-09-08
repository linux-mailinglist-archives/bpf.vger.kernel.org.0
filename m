Return-Path: <bpf+bounces-67779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0ADB499A0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482922067E3
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C6243969;
	Mon,  8 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBqerjbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB517242D6A
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359011; cv=none; b=NqWv7EeBN7ZIHPE4eaQy8dDSN6cGpeqUjWzM2Ip94wBHg+OiPq7qM6701PDdx/Dbdi3X6dkqUv3bJoQvH7f0SMMnEbH8X1vfabKvUUos+4BQuEIYKiUweAO8JapYUKTH3HG9NRedM5EOGDiF+g59nkIXcKjlKJGl0+voqex/lrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359011; c=relaxed/simple;
	bh=4l7jFvC2aa8Khm1LNdkyC5j/NTQajzwmXeeTK5M+62E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSpGdJql+ZNuEGgIk3eXmqtGkrz+O+C3Z12C9iVBcqdfITwZ37AF/3aamm6RIH4AQipGIJuUBB23GMeF0MsJsiZoXHHRvd8ngaSTF7BfTORuA7be+ZFnIWX1cH8VhVVMfhMB9pQbAiD9qJS5zN6ZyTy18kNT80jfvZNKpUs5yfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBqerjbg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so29212855e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359008; x=1757963808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/36n9vYWkU5k+QCxkDE/IUypQCWxIUKNcTVtfJtvlM=;
        b=YBqerjbgOu+v/fcpiA70/TXxfvuDkhoF2hkAmKgzQKd056Zqyi+z/D5n22woLRnzXA
         4nillqLeCe8n2qJh9ybfb+QPCz+xotFWfozTuDBCkbPro0+7zgedgAAOXf5dTNKfsS+C
         2jRWgHsBlzdFUHMxGCXiqqlbwm32YsffJ2/bXBsfbg/SVa6mh8fv6cWTH1CXp4C5METs
         lwNZflOrD6cxc/nQZ2cILU3rsJnqJtFd+LcBRStrz51LCjm/2ZiuBVPh9W+kPQzG1VGC
         35R48qIgC5ec5NUF1DYxeyC3SMrlPm7IYRkuTXP0kSDS+YrADxB5mS3asXhLovJNYt8l
         +rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359008; x=1757963808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/36n9vYWkU5k+QCxkDE/IUypQCWxIUKNcTVtfJtvlM=;
        b=VfWP/zhpECMzIxuZnlz1F8Mb8UNZOhArUVnM1Sx0ogV8FQMVKPXn28/mgFK4Sfr5RE
         +BpKJgSpn0lpaR3RN+/2AknH/pbHTf7CARVUZiurFYyOhhZ/OqI4BTypUTX4Q+1pHesd
         EsAPwDCCqpD/FsMwnfqeNmdv9fhxztZSP1hD9N5CpCwM+Hn/0ufdXiPL+FUYktx7iIlR
         vmb7GYvlXaqBka+gj4GqBPovLp0obryXJGqpqf5HJscS1rhn8ROYqQ3yParciBcaBr18
         MpJRk2ZlTaM6+qFzbkgfHv5sDokUPdPLxTCUv0DeTzzcmREq6HeLvZEc/fBzhHxNFyfP
         rnvA==
X-Forwarded-Encrypted: i=1; AJvYcCXyAHD8fnfGADN8C6Kbyr4k8C7KzYfqTxRCN9XMEoY7wbhYKBTYILmTCnpC1LlWKLuaN50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZUMsWNvOxylOdcKb5uDBV7TQid7gmAO7bd++mueqyUuQWLps
	v6zWSEns1xPLPhAdopTHn7nRqy+FRh+BkO1MRXQouPoMz0j+XnRSFR9H
X-Gm-Gg: ASbGncvMnNs0LkhLTlQYXCqJz3trWcsSXgx504lSjFz/ig6HcBHZ7TpxmDm7BzeCW6B
	YnTUxjhaCWpIwP45R2ufW0e6yDlTYujWJ2vvn3IaUmg3tvZ9hCKsHul7pi0DEzrnNRkNrJBEyIt
	IIXPXgH9BnJbhWZNpSc7+hjx8d3rBBeehWj9xisauF3lgPK9lPO4ZHQu88Tr6nKHZlfu2z3TIMQ
	n8HYunlBRDLsa6fjHk5yyBtFQL051N32bIpTEmIzjZBTPHpL1QKL55kHLQ9FEEcdrr+L7x48k/7
	SyCZWwGLaHbuS6ZC+r5kx+WLsZoHgtslU+0AwCUuWvfXwuR5fZUNGsLmGH914GNuNsNgDUlAy1s
	abGaVlEIwkPPmVuqIAkLU
X-Google-Smtp-Source: AGHT+IE59F571Seiur+uafHrTMGu8CkajKNEGlObgxONQZLKeM/MvJID6SlGTr52rwnv9faUIYE9ow==
X-Received: by 2002:a05:600c:3b25:b0:45b:9a41:5d58 with SMTP id 5b1f17b1804b1-45dddea60cbmr77514125e9.4.1757359008014;
        Mon, 08 Sep 2025 12:16:48 -0700 (PDT)
Received: from Tunnel ([195.245.132.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e74b28a108sm3557095f8f.16.2025.09.08.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:16:47 -0700 (PDT)
Date: Mon, 8 Sep 2025 21:16:44 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aL8rnFy_QLeEoVgx@Tunnel>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
 <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
 <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
 <aLrkb-6ZFMLfMd-o@mail.gmail.com>
 <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>
 <aL8VXGQASeRo92xz@Tunnel>
 <CAMB2axO1kXA2JXDgF-mfmAAJL-M4JGE99w8gRKhYe6n62xEgkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axO1kXA2JXDgF-mfmAAJL-M4JGE99w8gRKhYe6n62xEgkA@mail.gmail.com>

On Mon, Sep 08, 2025 at 12:10:42PM -0700, Amery Hung wrote:
> On Mon, Sep 8, 2025 at 10:41 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > On Fri, Sep 05, 2025 at 09:34:54AM -0700, Amery Hung wrote:
> > > On Fri, Sep 5, 2025 at 6:24 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 04, 2025 at 09:27:58AM -0700, Amery Hung wrote:
> >
> > [...]
> >
> > > > > How about letting users specify the linear size through ctx->data_end? I am
> > > > > working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part of is
> > > > > to support non-linear xdp_buff in test_run_xdp, and I am doing it through
> > > > > ctx->data_end. Is it something reasonable for test_run_skb?
> > > >
> > > > Oh, nice! That was next on my list :)
> > > >
> > > > Why use data_end though? I guess it'd work for skb, but can't we just
> > > > add a new field to the anonymous struct for BPF_PROG_TEST_RUN?
> > > >
> > >
> > > I choose to use ctx_in because it doesn't change the interface and
> > > feels natural. kattr->test.ctx_in is already copied from users and
> > > shows users' expectation about the input ctx. I think we should honor
> > > that (as long as the value makes sense). WDYT?
> >
> > Ok, I think I see your point of view. To me, test.ctx_in *is* the
> > context and not metadata about it. I'm worried it would be weird to
> > users if we overload that field. I'm not against using that though if
> > it's the consensus.
> 
> Just about to say the same thing Martin mentioned.
> 
> bpf_prog_test_run_xdp() is already using test.ctx_in since
> 47316f4a3053 ("bpf: Support input xdp_md context in
> BPF_PROG_TEST_RUN"). It allows users to supply metadata via
> test.data_in. ctx_in->data_meta must be zero and the first
> ctx_in->data - ctx_in->data_meta bytes in data_in will be copied into
> metadata. So continuing using ctx_in for specifying the linear data
> size is a logical next step.

I didn't know about that. Okay, makes sense. I'll send the v2 using
data_end.

> 
> >
> > >
> > > Thanks for working on this. It would be great if there is some
> > > consistency between test_run_skb and test_run_xdp.
> >
> > Definitely agree! Do you have a prototype anywhere I could check? If
> > not, you can always flag any inconsistency when I send the v2.
> >
> 
> Here is the set I am working on
> https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
> 
> Patch 5 allows using ctx_in->data_end to specify the linear xdp_buff
> size (i.e., ctx_in->data_end - ctx_in->data). Patch 6 uses it to test
> a new kfunc, bpf_xdp_pull_data().
> 
> > [...]
> >

