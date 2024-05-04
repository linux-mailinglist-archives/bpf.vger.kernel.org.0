Return-Path: <bpf+bounces-28568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53088BB9CE
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 09:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF591C211DC
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E41C6B4;
	Sat,  4 May 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NukuycHa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817691AACB;
	Sat,  4 May 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807855; cv=none; b=F2pYNX34NBOHAFkInxBiJfXmDC/0/P9cNBJqo79IBZLFbMgTX/N0zkCKd+OgibQNdNvcpdSZhLNsO8OaYCXVzMCaE4+ei7LHIw6/BDajSjXxGmbmY2sYXWV6qncC7/+4keYflDPSlAYhn1ZomDGL6rVOZT34DbhJ23dv0FiElls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807855; c=relaxed/simple;
	bh=MA9PQMcmoDQhgdI1pznvCMKM7+hJZYM5Q4/0TCm9gQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf6y790JWcaEVo60v+mXgQk/yQdmiX0bNLl7BostGL+eVf/fLnsLgcsK/Rv7Vol/wH+u84Hp+A3q/mEnrdDfxkQ+3ptH0bWrE2uTcJAm7btJW3utgZeBBe1w3wQUbg3E/N5ykfpEFQIJg19rD0H6rsR5mc4TKMbeG5WFI7/VnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NukuycHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B53C4AF1B;
	Sat,  4 May 2024 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714807855;
	bh=MA9PQMcmoDQhgdI1pznvCMKM7+hJZYM5Q4/0TCm9gQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NukuycHa3iJ9USxvfH2CrbZq1dNDYuYi23BRfdnUC2TH/KaoBYm7ablE1uhnQd7JY
	 nZbdZln/xrYDUH1phhLDPlGlYVhgzZOU3SMRht+LYxwnTtabJfu+re9Hqn+FFfeX+J
	 MSMJ9OXZkeO9cUGkg3MwdfjZsaGuD6bwQcFnW2j8=
Date: Sat, 4 May 2024 09:30:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	dhowells@redhat.com
Subject: Re: [PATCH stable, 6.1] net: sockmap, fix missing MSG_MORE causing
 TCP disruptions
Message-ID: <2024050458-deduce-ascend-f524@gregkh>
References: <20240503164805.59970-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503164805.59970-1-john.fastabend@gmail.com>

On Fri, May 03, 2024 at 09:48:05AM -0700, John Fastabend wrote:
> [ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee]
> [ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6]

Why are you mushing 2 patches together?  Why can't we just take the two
as-is instead?  That makes tracking everything much simpler and
possible.

> In the first patch,
> 
> ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")
> 
> This block of code is added to tcp_bpf_push(). The
> tcp_bpf_push is the code used by BPF to submit messages into the TCP
> stack.
> 
>  if (flags & MSG_SENDPAGE_NOTLAST)
>      msghdr.msg_flags | MSG_MORE;
> 
> In the second patch,
> 
> f8dd95b29d7e ("tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage")
> 
> this logic was further changed to,
> 
>   if (flags & MSG_SENDPAGE_NOTLAST)
>      msghdr.msg_flags |= MSG_MORE
> 
> This was done as part of an improvement to use the sendmsg() callbacks
> and remove the sendpage usage inside the various sub systems.
> 
> However, these two patches together fixed a bug. The issue is without
> MSG_MORE set we will break a msg up into many smaller sends. In some
> case a lot because the operation loops over the scatter gather list.
> Without the MSG_MORE set (the current 6.1 case) we see stalls in data
> send/recv and sometimes applications failing to receive data. This
> generally is the result of an application that gives up after calling
> recv() or similar too many times. We introduce this because of how
> we incorrectly change the TCP send pattern.
> 
> Now that we have both 6.5 and 6.1 stable kernels deployed we've
> observed a series of issues related to this in real deployments. In 6.5
> kernels all the HTTP and other compliance tests pass and we are not
> observing any other issues. On 6.1 various compliance tests fail
> (nginx for example), but more importantly in these clusters without
> the flag set we observe stalled applications and increased retries in
> other applications. Openssl users where we have annotations to monitor
> retries and failures observed a significant increase in retries for
> example.
> 
> For the backport we isolated the fix to the two lines in the above
> patches that fixed the code. With this patch we deployed the workloads
> again and error rates and stalls went away and 6.1 stable kernels
> perform similar to 6.5 stable kernels. Similarly the compliance tests
> also passed.

Can we just take the two original patches instead?

thanks,

greg k-h

