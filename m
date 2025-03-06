Return-Path: <bpf+bounces-53453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA31A541EA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51787A7310
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E319CC0C;
	Thu,  6 Mar 2025 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PnZqaQi3"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7E7E9;
	Thu,  6 Mar 2025 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237632; cv=none; b=EWE8AZZ5NrnX074Evqe/HM44UMVjn6JJ/cyugd5c6qOEIv/O36Nh/dmTTe4qmv0noE77jikIeB49dWTbl+rA8X8pVGTHUlauj4g1pk8QelHLLUkhKZV4IRzbKvu2htah749SjWU6tUp3OpRKJWSu8sZitJ2iQc3p7YR8Gzk/JaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237632; c=relaxed/simple;
	bh=/PPhRFzrpmFZp2JOVjBtoaRYAfck4wy1OA0abEzrkPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLp8pvq/4/NwMrXX/TzN7FcZe0PHRXFa3TebdBQnGDYkZIspcnSkqxagXTjZRAiycN/E5gJ9z5VGM4iJCvII+cSxOKJ9E8eCYYHIdyhxOBqsCer3JVDl8J8aYxY9PN1n8LgNfVah+5lt+hU4hid+Inrox4fJ5a2Qf3sOSPjoawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PnZqaQi3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/p/yIsR0VNJP/SLkOWHis+551OQIlaMtljBwiPLa3rc=;
	b=PnZqaQi3qQzw/vDpzioNDuo4P+rfjiJdZfzZSsSwax/k+cup0oaomQzGcmBLIT
	D6sRen8XTYPDJCp8Ovy7EaJLibvBWrAeSekJ0cb/ZrSg5RJPLR4sZp8zojiGiIA3
	YrWvnGPux8Cpv9ZCegRYU3lCycgv1BbEICa9slzjzTMEc=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAnIKM8LclnR8xMQw--.53729S2;
	Thu, 06 Mar 2025 13:06:05 +0800 (CST)
Date: Thu, 6 Mar 2025 13:06:04 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, dongchenchen2@huawei.com
Cc: Dong Chenchen <dongchenchen2@huawei.com>, edumazet@google.com, 
	kuniyu@amazon.com, pabeni@redhat.com, willemb@google.com, john.fastabend@gmail.com, 
	jakub@cloudflare.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH net] bpf, sockmap: Restore sk_prot ops when psock is
 removed from sockmap
Message-ID: <3jmiqsl2betwyceyrwwuc5hb4amh2olbdgwfhijkmyk3avp42g@f3jdm7wz7pno>
References: <20250305140234.2082644-1-dongchenchen2@huawei.com>
 <Z8iUG8aTF9Kww09z@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iUG8aTF9Kww09z@pop-os.localdomain>
X-CM-TRANSID:_____wAnIKM8LclnR8xMQw--.53729S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW7Cry5AF15AFyxuryxAFb_yoW5WF4rpa
	95Ka15A3WDJrW2vws3Jw4kXw18Kan3JF1YkF97Xry7Jw4xur1fWr47JayIvF1vyr93C348
	X39rW3ykXay3ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ6pQUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwwIp2fJIobgPwAAs5

On Wed, Mar 05, 2025 at 10:12:43AM +0800, Cong Wang wrote:
> On Wed, Mar 05, 2025 at 10:02:34PM +0800, Dong Chenchen wrote:
> > WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
> > RIP: 0010:sock_map_close+0x3c4/0x480
> > Call Trace:
> >  <TASK>
> >  inet_release+0x144/0x280
> >  __sock_release+0xb8/0x270
> >  sock_close+0x1e/0x30
> >  __fput+0x3c6/0xb30
> >  __fput_sync+0x7b/0x90
> >  __x64_sys_close+0x90/0x120
> >  do_syscall_64+0x5d/0x170
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > The root cause is:
> > sock_hash_update_common
> >   sock_map_unref
> >     sock_map_del_link
> >       psock->psock_update_sk_prot(sk, psock, false);
> > 	//false won't restore proto
> >     sk_psock_put
> >        rcu_assign_sk_user_data(sk, NULL);
> > inet_release
> >   sk->sk_prot->close
> >     sock_map_close
> >       WARN(sk->sk_prot->close == sock_map_close)
> > 
> > When psock is removed from sockmap, sock_map_del_link() still set
> > sk->sk_prot to bpf proto instead of restore it (for incorrect restore
> > value). sock release will triger warning of sock_map_close() for
> > recurse after psock drop.
> 
> But sk_psock_drop() restores it with sk_psock_restore_proto() after the
> psock reference count goes to zero. So how could the above happen?
> 
> By the way, it would be perfect if you could add a test case for it 
> together with this patch (a followup patch is fine too).
> 
> Thanks!
I also have the same question as Cong, and I'll describe it in more detail
here:

'psock->saved_close' is always tcp_close (if your socket is TCP) and will
not change regardless of whether restore is executed or not. So when
entering the function sock_map_close() and encountering
WARN_ON_ONCE(saved_close == sock_map_close), 'saved_close' can only come
from 'saved_close = READ_ONCE(sk->sk_prot)->close'. This means we obtain 
sock through psock = sk_psock(sk) and then enter the branch code after
judging it to be null.
'''
sock_map_close()
{
	psock = sk_psock(sk);
	if (likely(psock)) {
		saved_close = psock->saved_close;
	} else {
		saved_close = READ_ONCE(sk->sk_prot)->close;
	}
	WARN_ON_ONCE(saved_close == sock_map_close);
}
'''
However, before psock becomes null, we have actually successfully executed
the restore:
'''
void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
{
    write_lock_bh(&sk->sk_callback_lock);
    sk_psock_restore_proto(sk, psock); // restore correctly
    rcu_assign_sk_user_data(sk, NULL); // set psock null
   ...
}
'''

Passing false to psock_update_sk_prot may be problematic, but it shouldn't
cause the issue described in the commit message.
It may be necessary to provide more information on how sockmap is used to
determine the issue. :)

Thanks.


