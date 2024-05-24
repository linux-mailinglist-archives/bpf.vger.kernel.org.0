Return-Path: <bpf+bounces-30506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B638CE890
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BF11C210B7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED612EBCC;
	Fri, 24 May 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p7HZ2I0p"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5286585C58;
	Fri, 24 May 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567506; cv=none; b=gy8OxDWL0tuBjNp2TDx9n0WSdItQiXUuk5Nk93n3zdbc2wrfrjA6m7VhO9ZtivOKpoLy7ljQVnQ9RMdi8BG9e0+fA612KOWm1tBMbx2IZHSB6pD/Bh1enGaPX3eUzLXXKYJez/pX2pTH1DIe/JJySqU5MF8z23IlU+YrnHsRgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567506; c=relaxed/simple;
	bh=atrh4jT8yxljxkucvQaL+LIjSGlEtTNYFmG+sIYG11k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BLkBW8fe2xJhBWJ2Vh7ChskFacOMK7WpI8mgyjisuTsmY6jBdz5g1W+4RmRlEdDwsETraZAisU4OoMzMv9PtUdmJCtrJNoSXKOH5KNLDoVK/o5u/vLEA6/Jv4Dy0n+OGZdYC5bS0aO65hbLmwq+RrhJI8JX4JLDOS4pk0SMZKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p7HZ2I0p; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Esh6yYJqsvKDs348Xsi61GdJRhitM+zztFjbTSIFp8M=; b=p7HZ2I0puYJR/abyEXcvDMvdy4
	zSCp9Ecn7O0h3u60ogztDhyGugfYoXo4i4sByzTcu7lH7OQhvXW7GC2yiSPQNZsUfiAFPBpM3fpam
	azYvxyzeZ/GnVEgOTv/PDq2hEQ/mvRALvMB9wJKlVl9zdeDeWE0M6J9tuWPERMzIDtpC7y6JJCt6j
	y6VRFHGmE9oLTVZiw8RoHIXK/GUuoyxNwS6KA6vW4xkPkD8M1BRqoPubFwIxbXn2/+mGCE7EJ5ZC4
	QWyog1WCHeYQcNyeXpExjg6PMeNjjn4VDOq3wsuosQC4D2MSeJTNhRKRdQ/Bt6+Oru6CFeaaHSmx7
	7JqNUzbQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXcS-000GoM-Se; Fri, 24 May 2024 18:18:12 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXcS-000IN3-2a;
	Fri, 24 May 2024 18:18:12 +0200
Subject: Re: [PATCH bpf-next v2 2/2] selftests: bpf: validate
 CHECKSUM_COMPLETE option
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524110659.3612077-1-vadfed@meta.com>
 <20240524110659.3612077-2-vadfed@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08fda54a-f45e-7140-e5e8-fe2c3542547f@iogearbox.net>
Date: Fri, 24 May 2024 18:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240524110659.3612077-2-vadfed@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

On 5/24/24 1:06 PM, Vadim Fedorenko wrote:
> Adjust skb program test to run with checksum validation.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

BPF CI complains :

   [...]
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c:14:12: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      14 |                 .flags = BPF_F_TEST_SKB_CHECKSUM_COMPLETE,
         |                          ^
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:1429:42: note: expanded from macro 'BPF_F_TEST_SKB_CHECKSUM_COMPLETE'
    1429 | #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE        BIT(2)
         |                                                 ^
   1 error generated.
   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_skb_pkt_end.test.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

