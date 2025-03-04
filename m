Return-Path: <bpf+bounces-53198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491EA4E4B2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F517AB48B
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CD28F95F;
	Tue,  4 Mar 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM6ty0yc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBE28F94A;
	Tue,  4 Mar 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102962; cv=none; b=UqwagCLRSCjC0joRrzztU8wNt2O9fGPvayHFaKthqVj2ZNMm0Tph2n8u7rj/LObjGLlb9soYjhDlOyLJpO2ceUlZ90UikTMg9Edx+byUmSx94zdQ2qQJbipkKPbRuKHIsAncHee8eqrVP4Z8961XopoRmnr1QR2Elj9W5Bw9g88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102962; c=relaxed/simple;
	bh=54cw3ZsEsDqGaWMwifys1UxImGLZAucBvesS78YvsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkRz9SrFBjXbekxrWjXsUJS3v20Lo1Puy+aoMkIOHvv87XRaHG9PYsD+oCFgovqtfQWzlR7vm53FPxpW6+RzEuYKocGGz7HmWhY/L6R7/z27JYguLAKstVJdJN0IIWYl9B5OQSI0tufMSj//J4AR2evU49y3xm0hQKJIv4dQhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM6ty0yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876A3C4CEE5;
	Tue,  4 Mar 2025 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741102961;
	bh=54cw3ZsEsDqGaWMwifys1UxImGLZAucBvesS78YvsZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM6ty0ycLjzDp5PBT5OUCIgMNa0sVGhucEz2xIftlfLjEbpsrB9SusnLojl6Mf3C8
	 3mljRiSznlb9s6f9Dviq5oXD+21DG21o/uq0EsZIvFDmbAKb/PMCFdRlDIatBGJLkj
	 kz91wnm0ybBJ10uYVD+Hi6iJ7w8wGNP8HqCrwyi0/d+B2vE+zjDvbdJk24I5JQ8gyh
	 sC8xFqudDB35xlJA7leYqQMTOyVSgIPdr4wx1Ex48DN3ZW/mOFF36EHPlkcBU6AeEK
	 LDj/UFxguLHGfrfUwNJHU6j9MlawV5d+PRjmRSg/oD/19F/91tBWd6wqJvCnJiyhOu
	 qGEaKFu0g61Kg==
Date: Tue, 4 Mar 2025 15:42:36 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, ricardo@marliere.net, viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru, aleksander.lobakin@intel.com,
	linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
	mrpre@163.com, Paul Mackerras <paulus@samba.org>,
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v5] ppp: Fix KMSAN uninit-value warning with bpf
Message-ID: <20250304154236.GE3666230@kernel.org>
References: <20250228141408.393864-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228141408.393864-1-jiayuan.chen@linux.dev>

On Fri, Feb 28, 2025 at 10:14:08PM +0800, Jiayuan Chen wrote:
> Syzbot caught an "KMSAN: uninit-value" warning [1], which is caused by the
> ppp driver not initializing a 2-byte header when using socket filter.
> 
> The following code can generate a PPP filter BPF program:
> '''
> struct bpf_program fp;
> pcap_t *handle;
> handle = pcap_open_dead(DLT_PPP_PPPD, 65535);
> pcap_compile(handle, &fp, "ip and outbound", 0, 0);
> bpf_dump(&fp, 1);
> '''
> Its output is:
> '''
> (000) ldh [2]
> (001) jeq #0x21 jt 2 jf 5
> (002) ldb [0]
> (003) jeq #0x1 jt 4 jf 5
> (004) ret #65535
> (005) ret #0
> '''
> Wen can find similar code at the following link:
> https://github.com/ppp-project/ppp/blob/master/pppd/options.c#L1680
> The maintainer of this code repository is also the original maintainer
> of the ppp driver.
> 
> As you can see the BPF program skips 2 bytes of data and then reads the
> 'Protocol' field to determine if it's an IP packet. Then it read the first
> byte of the first 2 bytes to determine the direction.
> 
> The issue is that only the first byte indicating direction is initialized
> in current ppp driver code while the second byte is not initialized.
> 
> For normal BPF programs generated by libpcap, uninitialized data won't be
> used, so it's not a problem. However, for carefully crafted BPF programs,
> such as those generated by syzkaller [2], which start reading from offset
> 0, the uninitialized data will be used and caught by KMSAN.
> 
> [1] https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
> [2] https://syzkaller.appspot.com/text?tag=ReproC&x=11994913980000
> 
> Cc: Paul Mackerras <paulus@samba.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


