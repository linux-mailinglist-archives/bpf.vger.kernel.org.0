Return-Path: <bpf+bounces-44452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD29C30EA
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 06:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7EE1C20B1E
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 05:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FA146A83;
	Sun, 10 Nov 2024 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZXhsrvzG"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CA323D
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731215072; cv=none; b=Rza1R0MtoovqqZLKCJ2YTCQLruTCuyZhqGyFG9YgKp92siJ9cmnSUCVB3EQ6Pvz+7T1EKS02RQmxHZuiVrLcIUdffKhMAb7bjWuAh6vKdrciHtOaTH0siUMvYghtl6BVybzHIWdiHvWZcZ4hp0WPbX04Eh1bGLxnr/ToSyiadoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731215072; c=relaxed/simple;
	bh=3E01w9Yw9onnXUe4jdDMoCJZxmwnSsETNmHpUfaN/CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzIVS8qa9LVDwB73hG4Run1f1vb4owkgwTWHd+Q6hGc8FSknv23zWYm3TEgDnY8rteo6UQOb4mck8Eca2owUeoM8bQvFK/58Ubz7BsE2GG7xGPNOGwtTjKlRwHrW7R859mqqFJtGmh+Rr5Arpwf87WGO1uZ9CWzJreTILjXw3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZXhsrvzG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+wuv7QUTpYl61metoIY9k+zF/fSX9mQxkxJe1HOpJ4M=;
	b=ZXhsrvzGCgLAQQhHNPVsWx0UFCDsXtxCwRr32eUlhJuvaG08bfGbQYcELpA+73
	B+V9hAcYitMiqQUwWx+nGteiYCKPl5050SkPrJ0UT8rBCF53pDKhv2xk2Xl0wSvd
	/z2KD7v6u0gxCQFnZfw/ly8MdIHnAbSPgWTPqNx/1iyNg=
Received: from osx (unknown [139.227.12.77])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD33+jBPjBn8ZXvCw--.46150S3;
	Sun, 10 Nov 2024 13:04:02 +0800 (CST)
Date: Sun, 10 Nov 2024 13:04:01 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix recursive lock when verdict program return
 SK_PASS
Message-ID: <2ntm3rpsecqyqu2drcuffgtftvzxojrsgbs3mjqfeyxubintad@rgvwu2rj3vce>
References: <20241106124431.5583-1-mrpre@163.com>
 <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
 <55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev>
X-CM-TRANSID:PCgvCgD33+jBPjBn8ZXvCw--.46150S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWxWrW8Ar4rZF4DAF17trb_yoW8Kw17pF
	Z3Zan0k3WDXry0q3s3tas7XF1I9ws5Kay3XryrW3s7u3Z8ur13KryxKrWjvF109rs3CFyY
	yr4UWwsIq34UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8HUDUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxaTp2cwNI55hwABs-

On Fri, Nov 08, 2024 at 01:07:57PM +0800, Martin KaFai Lau wrote:
> On 11/8/24 1:03 PM, Martin KaFai Lau wrote:
> > On 11/6/24 4:44 AM, mrpre wrote:
> > > When the stream_verdict program returns SK_PASS, it places the received skb
> > > into its own receive queue, but a recursive lock eventually occurs, leading
> > > to an operating system deadlock. This issue has been present since v6.9.
> > > 
> > > '''
> > > sk_psock_strp_data_ready
> > >      write_lock_bh(&sk->sk_callback_lock)
> > >      strp_data_ready
> > >        strp_read_sock
> > >          read_sock -> tcp_read_sock
> > >            strp_recv
> > >              cb.rcv_msg -> sk_psock_strp_read
> > >                # now stream_verdict return SK_PASS without peer sock assign
> > >                __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
> > >                sk_psock_verdict_apply
> > >                  sk_psock_skb_ingress_self
> > >                    sk_psock_skb_ingress_enqueue
> > >                      sk_psock_data_ready
> > >                        read_lock_bh(&sk->sk_callback_lock) <= dead lock
> > > 
> > > '''
> > > 
> > > This topic has been discussed before, but it has not been fixed.
> > > Previous discussion:
> > > https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch
> > 
> > Is the selftest included in this link still useful to reproduce this bug?
> > If yes, please include that also.
> > 
> > > 
> > > Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in
> > > sk_psock_skb_ingress_enqueue")
> > > Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> > > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> > 
> > Please also use the real name in the author (i.e. the email sender). The
> > patch needs a real author name also. I had manually fixed one of your
> > earlier lock_sock fix before applying.
> 
> and the bpf mailing list address has a typo in the original patch email... I
> fixed that in this reply.
> 
> > 
> > pw-bot: cr
> > 
> > > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > 
> > The patch and the earlier discussion make sense to me.
> > John and JakubS, please help to take another look in the next respin.
> > 
> > 
Hi Martin,

Thank you for the reminder. I’ve added test case in the new patch,and
I found that the deadlock issue can be reproduced 100% of the time
whenever the test cases are run. This is indeed a very dangerous defect.

New patch: https://lore.kernel.org/bpf/20241109150305.141759-1-mrpre@163.com/T/#t
(Additionally, I followed your guidance and used the correct names in the
new patch. Thanks again.)


