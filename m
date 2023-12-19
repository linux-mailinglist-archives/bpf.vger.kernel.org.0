Return-Path: <bpf+bounces-18313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10D818CCA
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1151F25C0E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7154358BA;
	Tue, 19 Dec 2023 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEuMeH37"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2A374F2;
	Tue, 19 Dec 2023 16:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2CEC433C7;
	Tue, 19 Dec 2023 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004327;
	bh=nypmG4eQWxWTu2jgpEEtKA39tKF27oe3kdI/qgJjzSA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IEuMeH37WNUbs6Pc5uITDOybTrTuZHndDPTvKZOptrSwpZVAMgffEC98oO8F0rJzC
	 wgvq7NlfiATKuUPLN1uUjtI7/nwqme7+ocfoKW2FOhxUAVrH/araTMAKExsdwzzlOS
	 rX+OK3oIAyIcfDgzSoyb7v6ywNg0MPYDgErPcjLI7btGaB8ui4KrAXnE0/dsXvjpc0
	 StuOqXkB9AdxYjcwiUryh4f1AUs//o0sFQbnR3iRDySvyupdw56PFn3kf4WM1zKW7p
	 HNuTbuZNbNMHcLvkbz2eSPge4Q0DoEw8AvSo9egvyDikFm1f2szGwq3blq7qRzjBcJ
	 4E2DrtlKwulKw==
Date: Tue, 19 Dec 2023 08:45:26 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
cc: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    edumazet@google.com, andrii@kernel.org, ast@kernel.org, 
    bpf@vger.kernel.org, daniel@iogearbox.net, kuni1840@gmail.com, 
    martin.lau@linux.dev, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in
 skb_steal_sock().
In-Reply-To: <20231215023707.41864-1-kuniyu@amazon.com>
Message-ID: <7d00ad25-abaa-191d-8e80-32674377b053@kernel.org>
References: <CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com> <20231215023707.41864-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1783165707-1703004327=:23967"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1783165707-1703004327=:23967
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, Kuniyuki Iwashima wrote:

> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 14 Dec 2023 17:31:15 +0100
>> On Thu, Dec 14, 2023 at 4:56 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>>
>>> We will support arbitrary SYN Cookie with BPF.
>>>
>>> If BPF prog validates ACK and kfunc allocates a reqsk, it will
>>> be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
>>> the reqsk has its listener as req->rsk_listener with no refcnt
>>> taken.
>>>
>>> When the TCP stack looks up a socket from the skb, we steal
>>> inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
>>> the skb will be processed in cookie_v[46]_check() with the
>>> listener.
>>>
>>> Note that we do not clear skb->sk and skb->destructor so that we
>>> can carry the reqsk to cookie_v[46]_check().
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>> ---
>>>  include/net/request_sock.h | 15 +++++++++++++--
>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>>> index 26c630c40abb..8839133d6f6b 100644
>>> --- a/include/net/request_sock.h
>>> +++ b/include/net/request_sock.h
>>> @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
>>>         }
>>>
>>>         *prefetched = skb_sk_is_prefetched(skb);
>>> -       if (*prefetched)
>>> +       if (*prefetched) {
>>> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
>>> +               if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
>>> +                       struct request_sock *req = inet_reqsk(sk);
>>> +
>>> +                       *refcounted = false;
>>> +                       sk = req->rsk_listener;
>>> +                       req->rsk_listener = NULL;
>>
>> I am not sure about interactions with MPTCP.
>>
>> I would be nice to have their feedback.
>
> Matthieu, Mat, Paolo, could you double check if the change
> above is sane ?
> https://lore.kernel.org/bpf/20231214155424.67136-4-kuniyu@amazon.com/

Hi Kuniyuki -

Yes, we will take a look. Haven't had time to look in detail yet but I 
wanted to let you know we saw your message and will follow up.

- Mat


>
>
> Short sumamry:
>
> With this series, tc could allocate reqsk to skb->sk and set a
> listener to reqsk->rsk_listener, then __inet_lookup_skb() returns
> a listener in the same reuseport group, and skb is processed in the
> listener function flow, especially cookie_v[46]_check().
>
> The only difference here is that skb->sk has reqsk, which does not
> have rsk_listener.
>
>
>>
>>> +                       return sk;
>>> +               }
>>> +#endif
>>>                 *refcounted = sk_is_refcounted(sk);
>>> -       else
>>> +       } else {
>>>                 *refcounted = true;
>>> +       }
>>>
>>>         skb->destructor = NULL;
>>>         skb->sk = NULL;
>>> --
>>> 2.30.2
>
>
--0-1783165707-1703004327=:23967--

