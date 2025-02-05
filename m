Return-Path: <bpf+bounces-50493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06FA28539
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A79168424
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75232229B02;
	Wed,  5 Feb 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A5M+Vvr4"
X-Original-To: bpf@vger.kernel.org
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8320F09B;
	Wed,  5 Feb 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742576; cv=none; b=nAkfMoX1rIBY8oWS1WlFQlQ4u7PpkffPzTWMJV5EfIrxG5NvdcTfBzQRp6h0gFMpKeZemPIIg8tEd7L8PAge3p/tvn0v7YXloZNc/daQ2+dhyAPMnqliMCS4d79DHcEiLxr1GVkokybYP/3jMrjF5KLbcZI0FI/K84MUks1vMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742576; c=relaxed/simple;
	bh=u08HtmoR3gjyR8lSKU9dYPRmR+YL7GM5wtJ6j/Ioiac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAFGruo0GQ9mTP3mMoVkL1y4rjtKasCwiRGueMkVBC+Dmfg+LL3SbG2uqEgUzwo9dNtsS/IWqz4z3GuFdRgNlmRcjWrzj9YmTWfqDIupkRo4gy8twGpLTYpnFb9i+ZxWg7qC1HfV70Rl2wa04DwGB/F4iTR2FeLdDinWtfb6qQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A5M+Vvr4; arc=none smtp.client-ip=47.90.199.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738742551; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=7GaEyfI7UicQBv1sg4JfW3DT68PYKPedGIl8mINzZOI=;
	b=A5M+Vvr4LhZzusgoy/CzI657NkVXqlFPRS0/8N87W4jY4FvUopy/MqDOSp8jRUhJ62Y7fVG7h721LxbLjrCeGygLWHXdkT/eix259S4g9p+2gLSkAwgJOE4yoDrOqEXRlwfdgskKmffAba8XXmc0O5jjh9ftgqwIjoR1XxOkXHI=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WOoxC9D_1738742548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Feb 2025 16:02:29 +0800
Date: Wed, 5 Feb 2025 16:02:28 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
	kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/6] net/smc: Introduce generic hook smc_ops
Message-ID: <20250205080228.GA57822@j66a10360.sqa.eu95>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
 <20250123015942.94810-4-alibuda@linux.alibaba.com>
 <20250123073034.GQ89233@linux.alibaba.com>
 <6685f9266702dcf0a3123f9be7c1c0200a5f4032.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6685f9266702dcf0a3123f9be7c1c0200a5f4032.camel@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jan 23, 2025 at 11:15:21AM +0100, Gerd Bayer wrote:
> On Thu, 2025-01-23 at 15:30 +0800, Dust Li wrote:
> > On 2025-01-23 09:59:39, D. Wythe wrote:
> > > The introduction of IPPROTO_SMC enables eBPF programs to determine
> > > whether to use SMC based on the context of socket creation, such as
> > > network namespaces, PID and comm name, etc.
> > > 
> > 
> > I'm still not completely satisfied with the name smc_ops. Since this
> > will be the API for our users, we need to be carefull on the name.
> 
> If I may jump in with a suggestion here:
> On my first glance, I'd expect SMC_OPS to offer OPS as a general API.
> The description however suggest that this adds "contol points" or hooks
> in the SMC code, that eBPF programs can use to tweak the protocol's
> behavior. Exclusively eBPF programs, it seems.
> 
> So how about naming this SMC_EBPF_HOOKS or SMC_EBPF_SUPPORT?
> 
> Just my 2ct,
> Gerd

Hi all,

Thanks for all the suggestion.It seems that the naming of this ops has indeed
sparked some controversy. However, I still oppose explicitly linking the name
to BPF. As I mentioned earlier, this ops is not strongly tied to BPF
implementations, kernel modules can also implement them.

I used ChatGPT to generate some potential names, including:
smc_ops / smc_hook / smc_aug / smc_ext / smc_alert / smc_support

Perhaps these can be used as references.

However, in any case, these changes need to be acked by the SMC
maintainer, but for what I can tell, the maintainer of SMC is currently on
leave, so this discussion may still take some time.

Best wishes,
D. Wythe

> 
> > 
> > It seems like you're aiming to define a common set of operations, but
> > the implementation appears to be intertwined with BPF. If this is
> > intended to be a common interface, and if we are using another operation,
> > there shouldn’t be a need to hold a BPF reference.
> > 
> > As your 'help' sugguest, What about smc_hook ?
> > 
> > Best regards,
> > Dust
> > 
> > 

