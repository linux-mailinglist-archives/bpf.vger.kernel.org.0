Return-Path: <bpf+bounces-65806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB0B28A9E
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 06:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF921C211C6
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 04:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389B1DF261;
	Sat, 16 Aug 2025 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="E0uJVd3K"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA05139D0A
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755320336; cv=none; b=miH9/A3CSP7qkmq0iSDhPaK7lxlSLzZlrU5HN2avoPkr9JiMDUT6uskZGqrsBbGcfVJNwxcFRJ3Bu19F+5m7J5h1x8LtyD9NiV1ZQg2xPYWY6aUUEu44MJXAuYJvkA3m2OPQyGvfRL8QzIA7TI7/6nzYLtxA5b8jb2fd3OIYVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755320336; c=relaxed/simple;
	bh=7mwK8uX6ayLHiVE6+tuTegff/KfZPl5cPiOtvs9yVPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wez1meSL06yzRautZdSTNa2et5A0AvsxNhtmqXjgK26eWIRd6cFUUtg0BJt8YdVXMc1FVQxxXC18Z6T2XvNXx1Iz02ciWpSmoM7IvMuezBoYJ1Dj8xRGV4vykUtLeAIgH7pFAa9tyBs/H77QNbQ/+3h7kFSCC159ax8hMXY2M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=E0uJVd3K; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.100.6] (unknown [120.61.162.151])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id BF47843DCF;
	Sat, 16 Aug 2025 04:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755320329;
	bh=7mwK8uX6ayLHiVE6+tuTegff/KfZPl5cPiOtvs9yVPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0uJVd3K7w9MBmvEmlPbS02wcBWYjd2jbayaMLlPYVowrLPIIGF1JNYoktGKswBTS
	 AB2a3iAO+r7CnKasxfh9EWhaREktwm9xm/a41J+nTFpUBIHXgAOp7roNHq0GCMOgIe
	 YU3mZHSZCbQ2gbry4DvSpGkBZz97+wI+nbSmOYVizMpGgWW62zAcmJ9EW9X7D7V8kA
	 IHIhtXmsd5+nldpJ7QD2i+LqqZYtsp8x+j+Be0MZSuGfc9xV2Lt7e4SrM1UF6o8md1
	 LetWlq9gYezjzohSto0Q/+1fKmJhJp8wmXciWGLRqHtYALUwUTOtBcHQwRm4EyDco/
	 afiz9PTIi8SNQ==
Message-ID: <e9549198-f0d6-466d-a104-99b228d35dde@nandakumar.co.in>
Date: Sat, 16 Aug 2025 10:28:47 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
 <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/08/25 00:40, Eduard Zingerman wrote:

 > Could you please provide a selftest demonstrating a difference in 
behavior?
 > What technique did you employ to estimate the number of cases when
 > precision is improved vs worsened? If this is some kind of a program
 > doing randomized testing, could you please share a link to it?

Hi Eduard,

Thanks for the quick response! I've made the test program available here:
https://github.com/nandedamana/improved-tnum-mul

The repo contains the code for the test program, and a README file with some
explanation and a sample output. The program basically does a brute-force
comparison involving all combinations possible with N bits (which of course
doesn't scale very well).

I've done some random checks at 64 bits (which I'd like to incorporate 
to the
program in future), and manual checks at lower bits. Still, I could've 
made some
stupid mistakes, and I'm really thankful that you are interested in
verifying it.

For the record, let me paste the sample output here:

$ ./experi --bits 6
...
mine vs kernel (bits = 6):
   better = 285059
   same   = 229058
   worse  = 17324
   myprod optimal cases  = 432406 / 531441
   linprod optimal cases = 202444 / 531441
----------------------------------------------------------
is optimal? (bits = 6): 0

The above output shows the new algorithm was an improvement over the 
current one
in 285k cases, and worse in 17k, while preserving the precision in 229k
cases. It achieved optimality in in 81% cases compared to the 38% 
obtained by
the current algorithm. I had benchmarked an early version of the new 
algorithm
at 8 bits as well, with similar (slightly better, actually) results.

Regarding adding selftests, I'll look into that as well. It'd be great 
if you
have any specific strategy in mind, wrt to this particular change. BTW, any
set of BPF programs that are known to fail due to the imprecision in the 
current
algorithm?

Thank you,

-- 
Nandakumar Edamana


