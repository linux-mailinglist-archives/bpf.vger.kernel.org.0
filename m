Return-Path: <bpf+bounces-49766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEEA1C1F8
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 07:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7551654F1
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 06:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD7207A3D;
	Sat, 25 Jan 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i6lQiaO7"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBE207A32;
	Sat, 25 Jan 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737787997; cv=none; b=a+65cck+4ayUXZc38dJEAMv/G2WhN+qYUkWhts62X+UtJ6rvAhBVxBNTEiokRs0mIvWIGcfuoUsysX202fA9mJeIAAcmBOSyLI2JumWwiWQB5LQnMqqt57s707HK567+kiFyYcaD6obiUqku1Y0y87NmBcI68oq26HYT4wyXhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737787997; c=relaxed/simple;
	bh=oj8SGqRq+oKUdpcA0PDcHm5fhcqMnVgpPP/oa5I9kqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7UeoVV2UTN4tHUFmly07J5tevpdkLNjIthTCJuamx49bfgQAwndRYWNGAB1CanxXOudKeXVz7akC90qI7rUBYLxpC+vjohHA8pdbZV/kwt6NPHoVZ6egNsQgCSpKJ8qyOmDahntO9OYP/E0Ec9O/sjgMOwIgMdB0+ZKMa0hvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i6lQiaO7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hDbCwusUEvHpWYX/2mH63j2HRxQtYnpTDXZK60c8mdk=;
	b=i6lQiaO7ERTJJ0uM8j+TO3djTQLwFmHNuPPLlqKnt04D+jP3ZqjQFX6hqdGmdC
	bMitxGI/5OWkWdtQmPfh3qKTqoDLKqQLbdEVduzEtlFqQ7hpVnJL6VFazmal36YB
	aPA/eZIbPSC8rDtcUUmtEna6W1rnn3tbDAdYT0MMRAP1s=
Received: from iZ0xi1olgj2q723wq4k6skZ (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXd1AFipRn3_aGIQ--.34842S2;
	Sat, 25 Jan 2025 14:51:58 +0800 (CST)
Date: Sat, 25 Jan 2025 14:51:49 +0800
From: Jiayuan Chen <mrpre@163.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: fix ktls panic
Message-ID: <g7y5kd2lkzkcklixeuyhq5rf6ijruicizcilakjl5uueb7ye2b@xu2kkhwbgv5w>
References: <20250123171552.57345-1-mrpre@163.com>
 <20250123171552.57345-2-mrpre@163.com>
 <gkx7axo3mau4jb7ojsdl4lwrtkuxsbnozplupscl3vvl3zfqg5@qnc5qfwzcwlj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gkx7axo3mau4jb7ojsdl4lwrtkuxsbnozplupscl3vvl3zfqg5@qnc5qfwzcwlj>
X-CM-TRANSID:_____wDXd1AFipRn3_aGIQ--.34842S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4fJF13AF43tryxZw17Awb_yoW5AFy7pr
	WfX3Wayr4DtFyIkrn7Za18XryxZrySqF4UGr4Yq34rCrsxGr10ga4rKrWFga90krWv9F1S
	vw4Duan8CFZ8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxbfp2eUfa2cpQAAs7

On Fri, Jan 24, 2025 at 09:24:48PM -0800, John Fastabend wrote:
> On 2025-01-24 01:15:51, Jiayuan Chen wrote:
> > [ 2172.936997] ------------[ cut here ]------------
> > [ 2172.936999] kernel BUG at lib/iov_iter.c:629!
> > ......
> > pointless and can directly go to zero-copy logic.
> > 
> > 2. Suppose sg.size is initially 5, and we push it to 100, setting
> > apply_bytes to 7. Then, 98 bytes of data are sent out, leaving 2 bytes to
> > be processed. The rollback logic cannot determine which data has been
> > processed and which hasn't.
> 
> This is the error path we are talking about correct?
> 
>         if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
>             !enospc && !full_record) {
>                 err = -ENOSPC;
>                 goto out_err;
>         }
> 
yes, it its.
> > 
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 7bcc9b4408a2..b3cae4dd4f49 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
> >  					num_async++;
> >  				else if (ret == -ENOMEM)
> >  					goto wait_for_memory;
> > -				else if (ctx->open_rec && ret == -ENOSPC)
> > +				else if (ctx->open_rec && ret == -ENOSPC) {
> > +					if (msg_pl->cork_bytes) {
> > +						ret = 0;
> > +						goto send_end;
> > +					}
> 
> The app will lose bytes here I suspect if we return copied == try_to_copy then
> no error makes it to the user?

I looked into the corking logic for non-TLS sockets in tcp_bpf_sendmsg,
and I found that when a "cork" situation occurs, the user-space send
doesn't return an error, and the returned length is the same as the input
length parameter, even if some data is cached. I think TLS should also
behave similarly.

Additionally, I saw that the current non-zero-copy logic for handling
corking is written as:
'''
line 1177

else if (ret != -EAGAIN) {
	if (ret == -ENOSPC)
		ret = 0;
	goto send_end;
}
'''

Meanwhile, I set cork_bytes to 1 and tested the following behavior logic:
'''
send(msg, 1);
send(msg+1, 1);
send(msg+2, remain_length);
'''
Both the sender and receiver seem to be working normally both for TLS and
non-TLS sockets.
 
> Could we return delta from bpf_exec_tx_verdict and then we can calculate
> the correct number of bytes to revert? I'll need to check but its not
> clear to me if BPF program pushes data that the right thing is done with
> delta there now.
> 
> Thanks for looking into this.

Let's assume the original data is "abcdefgh" (8 bytes), and after 3 pushes
by the BPF program, it becomes 11-byte data: "abc?de?fgh?".

Then, we set cork_bytes to 6, which means the first 6 bytes have been
processed, and the remaining 5 bytes "?fgh?" will be cached until the
length meets the cork_bytes requirement.

However, some data in "?fgh?" is not within 'sg->msg_iter'
(but in msg_pl instead), especially the data "?" we pushed.

So it doesn't seem as simple as just reverting through an offset of msg_iter.
It appears that 'msg_iter' and 'msg_pl' are two separate objects,
and the BPF program modifies the scatterlist within the msg_pl.

--
Thanks.


