Return-Path: <bpf+bounces-27009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54A8A75E5
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A30282BAE
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75E4206F;
	Tue, 16 Apr 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4CeQ50E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7017736;
	Tue, 16 Apr 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300302; cv=none; b=DS7LBr1IpEGa0odqJk2Mc7QW/sS3s6IqLPZ11fHkzmxvhEP83GskiFTReA5ytWLrkYPeYyO4Beq4UO1ick7H+KJCmLvNw5iX4JxoHvXcsC+46EXwb/IAFZ/Txbga7stpDL4l+RFL6646IKUQnyF/xX1NtgvpxNqfhWLXcusylac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300302; c=relaxed/simple;
	bh=7Y822fAc48m5TRXMXNXMKn4FUS3xnrmEgg+6/xdkpa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqk/b0uXoYxa3EML7KMN5S8NeB/UP9xbwWS9PangUqr0gJI10IBD/Vu16NmTQwidJrPnFZo82jOzfdjTVm7BJDnZGA1JoaMauxnkdmeEi6ht1t7euXOSbfeMZin7oBeqWiT5u+NSnDWTeP3NaFLsY3qcM9xSTi194nCW6r/nzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4CeQ50E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AA1C113CE;
	Tue, 16 Apr 2024 20:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713300301;
	bh=7Y822fAc48m5TRXMXNXMKn4FUS3xnrmEgg+6/xdkpa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4CeQ50E5jsLyYtyLqT97VRWPNECEgP+UyR8oDZQq2WekCDNu/n/pfghMCQOiGECd
	 n9lV6p376Z+XMSV2K3Knpnad0JHJ/7A4wPCHMlEsriAQi/94o+qh1JPy3JbrKQ+4fd
	 p7pft0xNH6rYHZLYB/+jJsOlWkWq4MChtwFQKVUl9fc4M7P1Q16P8YBelDADhzbE2G
	 Fz3qv6TaScC4N6yVcUJyuOF8PVW2pRjBWLAwv787s4umz7BpBN4C762hPwFAewfEwv
	 wDH7kUUMVV1G/ynTm9nf1bZ72WQGKZEuQCCkKqpXNaBs7lVkCOotGN0+yrc0CwoetG
	 IJI5vgTLKY54w==
Date: Tue, 16 Apr 2024 17:44:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, kuifeng@fb.com, linux@weissschuh.net
Subject: Re: [PATCH dwarves 2/3] pahole: add reproducible_build to
 --btf_features
Message-ID: <Zh7jSqXRsQ5iOKSg@x1>
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
 <20240416143718.2857981-3-alan.maguire@oracle.com>
 <Zh6YNhBRbhVchv5S@x1>
 <a820dddb-54a0-47e0-9a6e-e12c6341babb@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a820dddb-54a0-47e0-9a6e-e12c6341babb@oracle.com>

On Tue, Apr 16, 2024 at 04:41:20PM +0100, Alan Maguire wrote:
> On 16/04/2024 16:24, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 16, 2024 at 03:37:17PM +0100, Alan Maguire wrote:
> >> ...as a non-standard feature, so it will not be enabled for
> >> "--btf_features=all"
> > 
> > How did you test this?
> > 
> > ⬢[acme@toolbox pahole]$ pahole --btf_features_strict=bgasd
> > Feature 'bgasd' in 'bgasd' is not supported.  Supported BTF features are:
> > encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,reproducible_build
> > ⬢[acme@toolbox pahole]$ pahole -j --btf_features=all,reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build-via-btf_features vmlinux
> > ⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel.reproducible_build-via-btf_features > output.vmlinux.btf.parallel.reproducible_build-via-btf_features
> > ⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel.reproducible
> > ⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.parallel.reproducible_build output.vmlinux.btf.parallel.reproducible_build-via-btf_features | head
> > --- output.vmlinux.btf.parallel.reproducible_build	2024-04-16 12:20:28.513462223 -0300
> > +++ output.vmlinux.btf.parallel.reproducible_build-via-btf_features	2024-04-16 12:23:37.792962930 -0300
> > @@ -265,7 +265,7 @@
> >  	'target' type_id=33 bits_offset=32
> >  	'key' type_id=43 bits_offset=64
> >  [164] PTR '(anon)' type_id=163
> > -[165] PTR '(anon)' type_id=35751
> > +[165] PTR '(anon)' type_id=14983
> >  [166] STRUCT 'static_key' size=16 vlen=2
> >  	'enabled' type_id=88 bits_offset=0
> > ⬢[acme@toolbox pahole]$
> > 
> > I'm double checking things now...
 
> The test worked for me on x86_64/aarch64. Did you test with patch 3
> applied? Because the test in its original state prior to patch 3 sets

With all patches applied:

⬢[acme@toolbox pahole]$ git log --oneline -5
ecd3b0852ab1f1ff (HEAD -> master) tests/reproducible_build: use --btf_features=all,reproducible_build
f9c8f5856b2aafea pahole: Add reproducible_build to --btf_features
0412978e8e6f8f76 pahole: Allow --btf_features to not participate in "all"
a9738ddc828d5ea0 tests/reproducible_build: Use --btf_features=all when encoding
d7edf9ae0388fb97 tests/reproducible_build: Validate the vmlinux file
⬢[acme@toolbox pahole]$ 

I made some mistake:

⬢[acme@toolbox pahole]$ pahole --btf_encode_detached=vmlinux.btf.serial --btf_features=all vmlinux
⬢[acme@toolbox pahole]$ pahole --btf_encode_detached=vmlinux.btf.parallel --btf_features=all -j vmlinux
⬢[acme@toolbox pahole]$ pahole --btf_encode_detached=vmlinux.btf.parallel--reproducible_build --btf_features=all --reproducible_build -j vmlinux
⬢[acme@toolbox pahole]$ pahole --btf_encode_detached=vmlinux.btf.parallel--btf_features=all,reproducible_build --btf_features=all,reproducible_build -j vmlinux
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.serial > output.vmlinux.btf.serial
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel > output.vmlinux.btf.parallel
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel--reproducible_build > output.vmlinux.btf.parallel--reproducible_build
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel--btf_features=all,reproducible_build > output.vmlinux.btf.parallel--btf_features=all,reproducible_build
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel | wc -l
629165
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel--reproducible_build | wc -l
0
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel--btf_features=all,reproducible_build | wc -l
0
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.parallel--reproducible_build output.vmlinux.btf.parallel--btf_features=all,reproducible_build | wc -l
0
⬢[acme@toolbox pahole]$

And of course:

⬢[acme@toolbox pahole]$ time tests/reproducible_build.sh  vmlinux
Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

real	1m25.241s
user	3m10.144s
sys	0m48.104s
⬢[acme@toolbox pahole]$

> --reproducible_build before setting --btf_features=all, you won't get a
> reproducible build since the command line is saying "enable reproducible
> builds but also enable standard features only"; the second action undoes

Makes sense.

> the first. switching to using --btf_features=all,reproducible_build
> fixes things for me.

Ok, all tested now, will push to the 'next' branch, waiting for Eduard's
review.

- Arnaldo

> > - Arnaldo
> >  
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  man-pages/pahole.1 | 8 ++++++++
> >>  pahole.c           | 1 +
> >>  2 files changed, 9 insertions(+)
> >>
> >> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> >> index 2c08e97..64de343 100644
> >> --- a/man-pages/pahole.1
> >> +++ b/man-pages/pahole.1
> >> @@ -310,6 +310,14 @@ Encode BTF using the specified feature list, or specify 'all' for all standard f
> >>  	                   in different CUs.
> >>  .fi
> >>  
> >> +Supported non-standard features (not enabled for 'all')
> >> +
> >> +.nf
> >> +	reproducible_build Ensure generated BTF is consistent every time;
> >> +	                   without this parallel BTF encoding can result in
> >> +	                   inconsistent BTF ids.
> >> +.fi
> >> +
> >>  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
> >>  
> >>  .TP
> >> diff --git a/pahole.c b/pahole.c
> >> index 890ef81..38cc636 100644
> >> --- a/pahole.c
> >> +++ b/pahole.c
> >> @@ -1286,6 +1286,7 @@ struct btf_feature {
> >>  	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
> >>  	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
> >>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
> >> +	BTF_FEATURE(reproducible_build, reproducible_build, false, false),
> >>  };
> >>  
> >>  #define BTF_MAX_FEATURE_STR	1024
> > 
> > 
> > 

