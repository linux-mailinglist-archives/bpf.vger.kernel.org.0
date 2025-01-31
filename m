Return-Path: <bpf+bounces-50187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C014A23980
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 07:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C817A195B
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268A14F115;
	Fri, 31 Jan 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nWphTHD2"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7118AFC;
	Fri, 31 Jan 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304492; cv=none; b=OHAVGJbU3qHtZHs+90XME3f0ZPxS1hONQqy4O0NqDCoXmRLGd75p4axsctyJ21LXK9VflMJK12lfiGlv5rSoIpSG1hKwFEXxhzf/k0A0O6cEinN+eCYF1BWP4cDLcM8fDYlC5GRnCQ6pZ1841JV5spgs8slvZlwkV7qP1A4UQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304492; c=relaxed/simple;
	bh=Xp1cTvufI1MWZ+uBRjginA/3vr7DeWm0hMhiwsUsnfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMyiiLtxKsfDzZO0S8lagAOl+b+R6WGEmNbH0GWH2bzGlUJdNU/hS3UFb7jj8K8LxBn6YROtbZ4xZBuuKRKsSJuZHeUZmTnNaghAGVO51/nacwcLgpTLSLps3aYSfN06kh6czHvNsPamRlPjlXyWnLiPlClrz/ni/127MIlQHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nWphTHD2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UeMu/+TE/rr0e+8vl/GVGVx7p54RGFPPguck4b4jwFE=;
	b=nWphTHD2Vy8mhL1rZNeB04V8P5NiHHMo2qwgSaefZc0n3J5TTfCegpmnUTj4YT
	uaH6n+WWM6/ct7fKd54lBrW4+BvdE98bkvOz2Oqfvnj8n3BzGn3puyVUKlYB8Eb9
	YnfZXgxfzIFf09e+BInRj5mM1OymBjMrLVcT9rjevAvGc=
Received: from iZ0xi1olgj2q723wq4k6skZ (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXP06aa5xnfAApJQ--.25293S2;
	Fri, 31 Jan 2025 14:20:18 +0800 (CST)
Date: Fri, 31 Jan 2025 14:20:09 +0800
From: Jiayuan Chen <mrpre@163.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: fix ktls panic
Message-ID: <y4ubu3oa3het5ofmyki52hhxy4uf6abasgfzjmyr4hawfvotjo@mbcb77maqppm>
References: <20250123171552.57345-1-mrpre@163.com>
 <20250123171552.57345-2-mrpre@163.com>
 <gkx7axo3mau4jb7ojsdl4lwrtkuxsbnozplupscl3vvl3zfqg5@qnc5qfwzcwlj>
 <g7y5kd2lkzkcklixeuyhq5rf6ijruicizcilakjl5uueb7ye2b@xu2kkhwbgv5w>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g7y5kd2lkzkcklixeuyhq5rf6ijruicizcilakjl5uueb7ye2b@xu2kkhwbgv5w>
X-CM-TRANSID:_____wDXP06aa5xnfAApJQ--.25293S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWfCr13JryUurWxtr4DXFb_yoW5ur4fpF
	WSqF4ayF4DtFy0krn2va10qr97ArWFqw4UGr1Yqw1FvrsIgF1xKa4rKF1F9ayvkr4v9F1I
	vw4Dua93CFs8GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwPlp2ecUJTlsQAAsl

On Sat, Jan 25, 2025 at 02:51:49PM +0800, Jiayuan Chen wrote:
> On Fri, Jan 24, 2025 at 09:24:48PM -0800, John Fastabend wrote:
> > On 2025-01-24 01:15:51, Jiayuan Chen wrote:
> > > [ 2172.936997] ------------[ cut here ]------------
> > > [ 2172.936999] kernel BUG at lib/iov_iter.c:629!
> > > ......
> > > pointless and can directly go to zero-copy logic.
> > > 
> > > 2. Suppose sg.size is initially 5, and we push it to 100, setting
> > > apply_bytes to 7. Then, 98 bytes of data are sent out, leaving 2 bytes to
> > > be processed. The rollback logic cannot determine which data has been
> > > processed and which hasn't.
> > 
> > This is the error path we are talking about correct?
> > 
> >         if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
> >             !enospc && !full_record) {
> >                 err = -ENOSPC;
> >                 goto out_err;
> >         }
> > 
> yes, it its.
> > > 
> > > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > > index 7bcc9b4408a2..b3cae4dd4f49 100644
> > > --- a/net/tls/tls_sw.c
> > > +++ b/net/tls/tls_sw.c
> > > @@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
> > >  					num_async++;
> > >  				else if (ret == -ENOMEM)
> > >  					goto wait_for_memory;
> > > -				else if (ctx->open_rec && ret == -ENOSPC)
> > > +				else if (ctx->open_rec && ret == -ENOSPC) {
> > > +					if (msg_pl->cork_bytes) {
> > > +						ret = 0;
> > > +						goto send_end;
> > > +					}
> > 
> > The app will lose bytes here I suspect if we return copied == try_to_copy then
> > no error makes it to the user?
> 
> I looked into the corking logic for non-TLS sockets in tcp_bpf_sendmsg,
> and I found that when a "cork" situation occurs, the user-space send
> doesn't return an error, and the returned length is the same as the input
> length parameter, even if some data is cached. I think TLS should also
> behave similarly.
> 
> Additionally, I saw that the current non-zero-copy logic for handling
> corking is written as:
> '''
> line 1177
> 
> else if (ret != -EAGAIN) {
> 	if (ret == -ENOSPC)
> 		ret = 0;
> 	goto send_end;
> }
> '''
> 
> Meanwhile, I set cork_bytes to 1 and tested the following behavior logic:
> '''
> send(msg, 1);
> send(msg+1, 1);
> send(msg+2, remain_length);
> '''
> Both the sender and receiver seem to be working normally both for TLS and
> non-TLS sockets.
>  
> > Could we return delta from bpf_exec_tx_verdict and then we can calculate
> > the correct number of bytes to revert? I'll need to check but its not
> > clear to me if BPF program pushes data that the right thing is done with
> > delta there now.
> > 
> > Thanks for looking into this.
> 
> Let's assume the original data is "abcdefgh" (8 bytes), and after 3 pushes
> by the BPF program, it becomes 11-byte data: "abc?de?fgh?".
> 
> Then, we set cork_bytes to 6, which means the first 6 bytes have been
> processed, and the remaining 5 bytes "?fgh?" will be cached until the
> length meets the cork_bytes requirement.
> 
> However, some data in "?fgh?" is not within 'sg->msg_iter'
> (but in msg_pl instead), especially the data "?" we pushed.
> 
> So it doesn't seem as simple as just reverting through an offset of msg_iter.
> It appears that 'msg_iter' and 'msg_pl' are two separate objects,
> and the BPF program modifies the scatterlist within the msg_pl.
> 
> --
> Thanks.
> 

Hi John

Just checking in on the status of my patch. If there's any new feedback,
I'm happy to move forward with the next steps.

Regards.


