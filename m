Return-Path: <bpf+bounces-17176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560880A1FC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DCE1C20CA3
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1A1A723;
	Fri,  8 Dec 2023 11:18:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA0E5E0;
	Fri,  8 Dec 2023 03:17:56 -0800 (PST)
Received: from XMCDN1207038 (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADXmIpe+3JlTDYUAA--.5946S2;
	Fri, 08 Dec 2023 19:17:52 +0800 (CST)
From: "Pengcheng Yang" <yangpc@wangsu.com>
To: "'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Sitnicki'" <jakub@cloudflare.com>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com> <1700565725-2706-2-git-send-email-yangpc@wangsu.com> <656e6d8a5e592_1ee50208e1@john.notmuch>
In-Reply-To: <656e6d8a5e592_1ee50208e1@john.notmuch>
Subject: Re: [PATCH bpf-next v2 1/3] skmsg: Support to get the data length in ingress_msg
Date: Fri, 8 Dec 2023 19:17:50 +0800
Message-ID: <000201da29c8$2eeccd80$8cc66880$@wangsu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpjviH4qTFjCB89Pc8Rjk1Q8y5HAIT0RemAmLLF1av3LZ6QA==
Content-Language: zh-cn
X-CM-TRANSID:SyJltADXmIpe+3JlTDYUAA--.5946S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1fZF1xtFW8JFW5Kw4xtFb_yoWxtrW8pF
	yDAa15Aa1vyrW8Zws3tF45Ar1S9348WFy2kr17A3WSyr9Ykr1rXr98Gr1avFn5tr1kC3W2
	qr4jgFZ0kF13XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v2
	6r1j6r4UMcIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xS
	Y4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUDpV1UUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/

John Fastabend <john.fastabend@gmail.com> wrote:
> 
> Pengcheng Yang wrote:
> > Currently msg is queued in ingress_msg of the target psock
> > on ingress redirect, without increment rcv_nxt. The size
> > that user can read includes the data in receive_queue and
> > ingress_msg. So we introduce sk_msg_queue_len() helper to
> > get the data length in ingress_msg.
> >
> > Note that the msg_len does not include the data length of
> > msg from recevive_queue via SK_PASS, as they increment rcv_nxt
> > when received.
> >
> > Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> > ---
> >  include/linux/skmsg.h | 26 ++++++++++++++++++++++++--
> >  net/core/skmsg.c      | 10 +++++++++-
> >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> 
> This has two writers under different locks this looks insufficient
> to ensure correctness of the counter. Likely the consume can be
> moved into where the dequeue_msg happens? But, then its not always
> accurate which might break some applications doing buffer sizing.
> An example of this would be nginx.
> 
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index c1637515a8a4..423a5c28c606 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -47,6 +47,7 @@ struct sk_msg {
> >  	u32				apply_bytes;
> >  	u32				cork_bytes;
> >  	u32				flags;
> > +	bool				ingress_self;
> >  	struct sk_buff			*skb;
> >  	struct sock			*sk_redir;
> >  	struct sock			*sk;
> > @@ -82,6 +83,7 @@ struct sk_psock {
> >  	u32				apply_bytes;
> >  	u32				cork_bytes;
> >  	u32				eval;
> > +	u32				msg_len;
> >  	bool				redir_ingress; /* undefined if sk_redir is null */
> >  	struct sk_msg			*cork;
> >  	struct sk_psock_progs		progs;
> > @@ -311,9 +313,11 @@ static inline void sk_psock_queue_msg(struct sk_psock *psock,
> >  				      struct sk_msg *msg)
> >  {
> >  	spin_lock_bh(&psock->ingress_lock);
> > -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> > +	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
> >  		list_add_tail(&msg->list, &psock->ingress_msg);
> > -	else {
> > +		if (!msg->ingress_self)
> > +			WRITE_ONCE(psock->msg_len, psock->msg_len + msg->sg.size);
> 
> First writer here can be from
> 
>   sk_psock_backlog()
>     mutex_lock(psock->work_mutex)
>     ...
>     sk_psock_handle_skb()
>       sk_psock_skb_ingress()
>         sk_psock_skb_ingress_enqueue()
>           sk_psock_queue_msg()
>              spin_lock_bh(psock->ingress_lock)
>                WRITE_ONCE(...)
>              spin_unlock_bh()
> 
> > +	} else {
> >  		sk_msg_free(psock->sk, msg);
> >  		kfree(msg);
> >  	}
> > @@ -368,6 +372,24 @@ static inline void kfree_sk_msg(struct sk_msg *msg)
> >  	kfree(msg);
> >  }
> >
> > +static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len)
> > +{
> > +	WRITE_ONCE(psock->msg_len, psock->msg_len - len);
> > +}
> > +
> > +static inline u32 sk_msg_queue_len(const struct sock *sk)
> > +{
> > +	struct sk_psock *psock;
> > +	u32 len = 0;
> > +
> > +	rcu_read_lock();
> > +	psock = sk_psock(sk);
> > +	if (psock)
> > +		len = READ_ONCE(psock->msg_len);
> > +	rcu_read_unlock();
> > +	return len;
> > +}
> > +
> >  static inline void sk_psock_report_error(struct sk_psock *psock, int err)
> >  {
> >  	struct sock *sk = psock->sk;
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 6c31eefbd777..f46732a8ddc2 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -415,7 +415,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  	struct iov_iter *iter = &msg->msg_iter;
> >  	int peek = flags & MSG_PEEK;
> >  	struct sk_msg *msg_rx;
> > -	int i, copied = 0;
> > +	int i, copied = 0, msg_copied = 0;
> >
> >  	msg_rx = sk_psock_peek_msg(psock);
> >  	while (copied != len) {
> > @@ -441,6 +441,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  			}
> >
> >  			copied += copy;
> > +			if (!msg_rx->ingress_self)
> > +				msg_copied += copy;
> >  			if (likely(!peek)) {
> >  				sge->offset += copy;
> >  				sge->length -= copy;
> > @@ -481,6 +483,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  		msg_rx = sk_psock_peek_msg(psock);
> >  	}
> >  out:
> > +	if (likely(!peek) && msg_copied)
> > +		sk_msg_queue_consumed(psock, msg_copied);
> 
> Second writer,
> 
>    tcp_bpf_recvmsg_parser()
>      lock_sock(sk)
>      sk_msg_recvmsg()
>        sk_psock_peek_msg()
>          spin_lock_bh(ingress_lock); <- lock held from first writer.
>          msg = list...
>          spin_unlock_bh()
>        sk_psock_Dequeue_msg(psock)
>          spin_lock_bh(ingress_lock)
>          msg = ....                     <- should call queue_consumed here
>          spin_unlock_bh()
> 
>     out:
>       if (likely(!peek) && msg_copied)
>         sk_msg_queue_consumed(psock, msg_copied); <- here no lock?
> 
> 
> It looks like you could move the queue_consumed up into the dequeue_msg,
> but then you have some issue on partial reads I think? Basically the
> IOCTL might return more bytes than are actually in the ingress queue.
> Also it will look strange if the ioctl is called twice once before a read
> and again after a read and the byte count doesn't change.
> 

Thanks john for pointing this out.
Yes, I tried to move queue_consumed into dequeue_msg without
making major changes to sk_msg_recvmsg, but failed.

> Maybe needs ingress queue lock wrapped around this queue consuned and
> leave it where it is? Couple ideas anyways, but I don't think its
> correct as is.

And, is it acceptable to just put the ingress_lock around the queue_consuned in
Sk_msg_recvmsg? Like the following:

  static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len)
  {
+         spin_lock_bh(&psock->ingress_lock);
          WRITE_ONCE(psock->msg_len, psock->msg_len - len);
+         spin_unlock_bh(&psock->ingress_lock);
  }

  static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
  {
          struct sk_msg *msg, *tmp;
  
          list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
                  list_del(&msg->list);
                  if (!msg->ingress_self)
~                         WRITE_ONCE(psock->msg_len, psock->msg_len - msg->sg.size);
                  sk_msg_free(psock->sk, msg);
                  kfree(msg);
          }  
          WARN_ON_ONCE(READ_ONCE(psock->msg_len) != 0);
  }


> 
> >  	return copied;
> >  }
> >  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
> > @@ -602,6 +606,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
> >
> >  	if (unlikely(!msg))
> >  		return -EAGAIN;
> > +	msg->ingress_self = true;
> >  	skb_set_owner_r(skb, sk);
> >  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
> >  	if (err < 0)
> > @@ -771,9 +776,12 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
> >
> 
> purge doesn't use the ingress_lock because its cancelled and syncd the
> backlog and proto handlers have been swapped back to original handlers
> so there is no longer any way to get at the ingress queue from the socket
> side either.
> 
> >  	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
> >  		list_del(&msg->list);
> > +		if (!msg->ingress_self)
> > +			sk_msg_queue_consumed(psock, msg->sg.size);
> >  		sk_msg_free(psock->sk, msg);
> >  		kfree(msg);
> >  	}
> > +	WARN_ON_ONCE(READ_ONCE(psock->msg_len) != 0);
> >  }
> >
> >  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> > --
> > 2.38.1
> >


