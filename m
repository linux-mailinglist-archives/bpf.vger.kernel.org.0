Return-Path: <bpf+bounces-53573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FBA568AC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42433AA944
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0E218E82;
	Fri,  7 Mar 2025 13:18:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41774192B8A;
	Fri,  7 Mar 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353504; cv=none; b=kGTIJJ0fwnYMDz+b8FW7XzQtd/iyT8aATgcnFPdrKCtl8ZgIQqLXbXYW+OMConA4AsYyX/4iuqiXnYNRnb/72YCnn2zPS1zltSa7k5aCrH+G6UUziYARu9aB76kKRt9cUTjhRTYhufPvVZsSccSfnDcG7ddqctgavpgLWPairW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353504; c=relaxed/simple;
	bh=nbmnJjqmREdC30/0AOVRvsXLS0/ODv+e9hPG5cpwl0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jkag3AdEXAqGMkKVFLFO672bnt5sHGo9zb/+vyP8qpf5vSiUf40jukOhzXq60RFM856CRN14pnndvSEpMsH6rsS8PNhbCUgMN1qXJ6yAj6Huc660s1GWcU3tg0pwNbDcf8m+MjPNErRdil2KmjKaBO1YrjI/Jmia/ePs4U9ms1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8RZL1JStz1f01F;
	Fri,  7 Mar 2025 21:14:02 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D7AF1402CE;
	Fri,  7 Mar 2025 21:18:18 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 21:18:15 +0800
Message-ID: <2ee3486d-3813-4eb1-99e1-edbd4c9dac6a@huawei.com>
Date: Fri, 7 Mar 2025 21:18:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf, sockmap: Restore sk_prot ops when psock is
 removed from sockmap
To: Jiayuan Chen <mrpre@163.com>, Cong Wang <xiyou.wangcong@gmail.com>
CC: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
References: <20250305140234.2082644-1-dongchenchen2@huawei.com>
 <Z8iUG8aTF9Kww09z@pop-os.localdomain>
 <3jmiqsl2betwyceyrwwuc5hb4amh2olbdgwfhijkmyk3avp42g@f3jdm7wz7pno>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <3jmiqsl2betwyceyrwwuc5hb4amh2olbdgwfhijkmyk3avp42g@f3jdm7wz7pno>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100023.china.huawei.com (7.221.188.33)


On 2025/3/6 13:06, Jiayuan Chen wrote:
> On Wed, Mar 05, 2025 at 10:12:43AM +0800, Cong Wang wrote:
>> On Wed, Mar 05, 2025 at 10:02:34PM +0800, Dong Chenchen wrote:
>>> WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
>>> Modules linked in:
>>> CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
>>> RIP: 0010:sock_map_close+0x3c4/0x480
>>> Call Trace:
>>>   <TASK>
>>>   inet_release+0x144/0x280
>>>   __sock_release+0xb8/0x270
>>>   sock_close+0x1e/0x30
>>>   __fput+0x3c6/0xb30
>>>   __fput_sync+0x7b/0x90
>>>   __x64_sys_close+0x90/0x120
>>>   do_syscall_64+0x5d/0x170
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> The root cause is:
>>> sock_hash_update_common
>>>    sock_map_unref
>>>      sock_map_del_link
>>>        psock->psock_update_sk_prot(sk, psock, false);
>>> 	//false won't restore proto
>>>      sk_psock_put
>>>         rcu_assign_sk_user_data(sk, NULL);
>>> inet_release
>>>    sk->sk_prot->close
>>>      sock_map_close
>>>        WARN(sk->sk_prot->close == sock_map_close)
>>>
>>> When psock is removed from sockmap, sock_map_del_link() still set
>>> sk->sk_prot to bpf proto instead of restore it (for incorrect restore
>>> value). sock release will triger warning of sock_map_close() for
>>> recurse after psock drop.
>> But sk_psock_drop() restores it with sk_psock_restore_proto() after the
>> psock reference count goes to zero. So how could the above happen?
>>
>> By the way, it would be perfect if you could add a test case for it
>> together with this patch (a followup patch is fine too).
>>
>> Thanks!
> I also have the same question as Cong, and I'll describe it in more detail
> here:
>
> 'psock->saved_close' is always tcp_close (if your socket is TCP) and will
> not change regardless of whether restore is executed or not. So when
> entering the function sock_map_close() and encountering
> WARN_ON_ONCE(saved_close == sock_map_close), 'saved_close' can only come
> from 'saved_close = READ_ONCE(sk->sk_prot)->close'. This means we obtain
> sock through psock = sk_psock(sk) and then enter the branch code after
> judging it to be null.
> '''
> sock_map_close()
> {
> 	psock = sk_psock(sk);
> 	if (likely(psock)) {
> 		saved_close = psock->saved_close;
> 	} else {
> 		saved_close = READ_ONCE(sk->sk_prot)->close;
> 	}
> 	WARN_ON_ONCE(saved_close == sock_map_close);
> }
> '''
> However, before psock becomes null, we have actually successfully executed
> the restore:
> '''
> void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
> {
>      write_lock_bh(&sk->sk_callback_lock);
>      sk_psock_restore_proto(sk, psock); // restore correctly
>      rcu_assign_sk_user_data(sk, NULL); // set psock null
>     ...
> }
> '''
>
> Passing false to psock_update_sk_prot may be problematic, but it shouldn't
> cause the issue described in the commit message.
> It may be necessary to provide more information on how sockmap is used to
> determine the issue. :)
>
> Thanks.
Thanks for your review!
sk_psock_restore_protofail to restore sk_prot for tcp_ulp set concurrently.

sock_hash_update_common
   sock_map_unref
     sock_map_del_link
                               setsockopt(TCP_ULP)
                                 tcp_set_ulp
                                   icsk->icsk_ulp_ops = ulp_ops; //set ulp
     sk_psock_put
       sk_psock_restore_proto
         tcp_bpf_update_proto
           if (inet_csk_has_ulp(sk))
              tls_update
                ctx->sk_proto = p; //not update sk->sk_prot for ulp set
inet_release
   sk->sk_prot->close
     sock_map_close
       WARN(sk->sk_prot->close == sock_map_close)

Maybe we can fix it as:
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 99ca4465f702..791cc32dccfd 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1025,15 +1025,22 @@ static int tls_init(struct sock *sk)
  static void tls_update(struct sock *sk, struct proto *p,
                        void (*write_space)(struct sock *sk))
  {
+       struct sk_psock *psock = sk_psock(sk);
         struct tls_context *ctx;
+       bool restore = true;

         WARN_ON_ONCE(sk->sk_prot == p);

+       if (psock)
+               restore = !!refcount_read(&psock->refcnt);
+
         ctx = tls_get_ctx(sk);
         if (likely(ctx)) {
                 ctx->sk_write_space = write_space;
                 ctx->sk_proto = p;
-       } else {
+       }
+
+       if (ctx == NULL || !restore) {
                 /* Pairs with lockless read in sk_clone_lock(). */
                 WRITE_ONCE(sk->sk_prot, p);
                 sk->sk_write_space = write_space;


