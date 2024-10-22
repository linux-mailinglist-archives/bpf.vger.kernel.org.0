Return-Path: <bpf+bounces-42747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39C9A9984
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D3D1C25298
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4D148FEB;
	Tue, 22 Oct 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CNVcnR2k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C691474B2
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577649; cv=none; b=gse080909kxbMtvDiCydD0BBPw0Fo50F9VN01M9c2Q4nhVzE/7fCuygJ9UAI9ONgn2zRpTCoUBXrOj8WH5cMiGRXd1rNNxLBvCurPvhA22eSGQ3WSod7rVm1xMY+DpqyJ3wnZlAD6Dz5BQCcPGpwrSHn1kx1xAtHwyxlYCoBu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577649; c=relaxed/simple;
	bh=SZMZwmVYJzh3zqGC5xVw2YjOE4DJ8IwDkrDThfPBUtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4D1HekSu4DfR+rIsXZql5QwntrDfGAMTGSjSmBJ7hTDg+9MEHeycq3PlNVXcT5wq86L57nSVvAln5OxpNC34NPSa6qiWKXYFEOPaDDwVqsR9wEmgMPd+atlfkZYLUau1AsY10bEm21ZyRs9aYbW5wgltAyo5sqifs7axXW8A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CNVcnR2k; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37d808ae924so3600195f8f.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729577645; x=1730182445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTaVTpzUoDUglrZx3pUJg8hl22i1M/fPgLeXItlB6ro=;
        b=CNVcnR2kJkKDRKdxaOh+Nzb9MwPRORVlQ4RQukJXC6QvDzuRFn8BXK7A+MN+ADuQgA
         6fvlb6mVNOHInL2DconkV6+dNGk/1qrMhTuD51WUqTmLlUW00ZPCQzt7FHNYBS6JYfYo
         +H/UPR8ViuuAjbahuwlKGZ+s9wAsxvaQp6SePwWfRlCaHyC2tA4SwO4f+lSSIWnekIk3
         jwvCISctpaHNUU9ZtDAap6KxbCZB6Lz2GZrzsMywlnlYXa+4hgP3hAvBtSsSbPQB0heJ
         lmpDzkINwIpt7OctFwn1FWjWswslTxh3Y/bntLsDs7C5qUJbW1zVC0gvTwXyQWoJDL5F
         w4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729577645; x=1730182445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTaVTpzUoDUglrZx3pUJg8hl22i1M/fPgLeXItlB6ro=;
        b=ILaLOJHEmahpMknp9yBrcjFxXY15KotC4MmwGYd6TQj9ObIlTNXrnWRf+r8997Dg41
         bLEMKpe3cHDjDEIvel8s+YDzHfzDQf9MMG2V+DggwCBej1z9rpV0Wy9OPJHjsQCQF+ZI
         8zTFbJb590qte/SzRvUXBju+S7S6Vd7OS2CG2nJ9QRH9s7rmdj83+EOs5Ih6+RJ2o2zB
         VndTxDVSx8rLfdRt5Mq/aAUIJjIbfaCtOi+bE90vkp2NeUdt857VTOIuD6RuvLAjpYQa
         Nk+UuaENgz011WVMBsUteyfImmqG5oP9RZGW+4N0JdIJNL91gMN8c8eeDnBuliLZ3Xv6
         cd4Q==
X-Gm-Message-State: AOJu0YxF92OpJQcU9j+kQ5K1AgnrN44Qmf7kkn9NIZeAREMYPqsY/1Ts
	OdG6fkGaPjDSUERKO2ZdKt/qSR9x3DTeZKjQusRorZtFpPpHA5eBqV8WrGGYbA8=
X-Google-Smtp-Source: AGHT+IEhon35Ej4sW7ZDKZYQb8IaMZNw0HD57QAhDoOsaL862P/yLPKMKx0TNTCNLg3o38zUb22j/A==
X-Received: by 2002:a5d:53c5:0:b0:367:9881:7d66 with SMTP id ffacd0b85a97d-37eb4885a83mr8685758f8f.41.1729577645487;
        Mon, 21 Oct 2024 23:14:05 -0700 (PDT)
Received: from u94a ([2401:e180:8861:9f2d:96e7:b5:5bb5:fd59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad512a98sm5067973a91.52.2024.10.21.23.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 23:14:04 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:13:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alasdair McWilliam <alasdair.mcwilliam@outlook.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: Verifier - wild instructions count fluctiations between versions?
Message-ID: <k7tcnpo3us5iwfuewie6lhnetq7dwi7kapahbzkbwwbqbo5nax@57jhqsfgmusu>
References: <AS8P194MB2042168EE5CAC311644BA284866F2@AS8P194MB2042.EURP194.PROD.OUTLOOK.COM>
 <15ace64a53203acb2b26a7abcb035c4eb9364552.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ace64a53203acb2b26a7abcb035c4eb9364552.camel@gmail.com>

Hi,

Sorry for coming to this late. Replies are in-line/interleaved, so some
of my comments might be hidden by email client.

On Mon, Sep 23, 2024 at 07:26:25PM GMT, Eduard Zingerman wrote:
> On Mon, 2024-09-23 at 19:35 +0100, Alasdair McWilliam wrote:
> > Hello,
> > 
> > First post so please be gentle :-)
> > 
> > I've got an eBPF workload running on kernel 6.1 LTS and we're running great.
> > 
> > Use case actually is using eBPF in combination with XDP and AF_XDP for
> > volumetric DDoS mitigation.
> > 
> > Makeup of the eBPF program is mostly packet parsing, LPM and map
> > lookups, and 2x calls to the bpf_loop() helper. Currently no iterators,
> > dynptrs, etc, but lots of switch-case blocks.
> > 
> > I've started to test newer kernel versions in preparation to upgrade our
> > stack from 6.1 LTS to 6.6 LTS to gain access to newer functionality and
> > just for future proofing. However, when loading the BPF object code on a
> > 6.6 kernel, the BPF verifier refuses to load the program that 6.1
> > accepts and runs well.
> > 
> > This caught me by surprise, because I have witnessed our stack boot
> > successfully on a 6.7 kernel. So, I've run veristat [0] on the exact
> > same eBPF object file, compiled by clang17, but each time running on a
> > different kernel version. Results fluctuate wildly!
> > 
> > Results on 6.1.106: success: 53687 insns and 5114 states [1]
> > Results on 6.6.52:  failure: 1000001 insns and 39501 states [2]
> > Results on 6.7.9:   success: 131418 insns and 8839 states [3]
> 
> Hi Alasdair,
> 
> It might be the case that your issues with bpf_loop() are triggered by
> the following commit:
> - "bpf: verify callbacks as if they are called unknown number of times":
>   - ab5cfac139ab for 6.7.y
>   - b43550d7d58e for 6.6.y
>   - not backported to 6.1.y
> 
> This commit is a correctness fix, w/o it bodies of the loop callbacks
> were not checked exhaustively. But side effect of this fix is
> significant verification time regression for some programs.
> 
> Comparing BPF related commits in both branches (starting from merge
> base, using script from the attachment) gives somewhat sporadic
> results:
> 
>   Commits stats:
>     only in stable/linux-6.6.y    : 50
>     only in stable/linux-6.7.y    : 96
>     common                        : 74
> 
>   Only in stable/linux-6.6.y:
>     ...
> 
>   Only in stable/linux-6.7.y:
>     ...
> Of these only "bpf: Improve JEQ/JNE branch taken logic" from 6.7
> looks like an optimization, however it did not show any changes in
> veristat data for selftests.

I've also tried to look at this using a different script based on
in-house tool and come to roughly the same conclusion on the 6.7 side.
Nothing specifically strikes out to me in 6.7 that would explain the
difference.

OTOH 6.7.9 is _missing_ a fix that was backported to 6.6.52 --
e9a8e5a587ca "bpf: check bpf_func_state->callback_depth when pruning
states". It was backported to 6.7.10, bu 6.7.9 doesn't have it yet.

Since it prevents (improper) pruning, it could explain what we're seeing
here.

@Alasdair could you give 6.7.12 a quick try (I suppose that would be
easier since you already tested 6.7.9) and see how it goes there?

Additionally, here's v6.1.y branch, containing the "bpf: verify
callbacks as if they are called unknown number of times" fix Eduard
mentioned,

  https://github.com/shunghsiyu/linux/tree/stable/linux-6.1.y-callback-fixes-w-subprog-precision-v1

that I plan to submit (though long overdue). If @Alasdair could also
test it out it is highly appreciated.

Let me know if there's anything that would make things easier.

Thanks,
Shung-Hsi

> => it's hard to say what's missing from 6.6 for your use-case.
> 
> Maybe let's discuss options for your program optimization
> with regards to verifier performance?
> 
> Thanks,
> Eduard
> 
> P.S. hope I did not mess up the script.

