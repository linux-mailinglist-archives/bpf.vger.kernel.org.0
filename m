Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5566C3CF2
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUVn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCUVn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:43:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016FE274BF
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:43:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z11so9933185pfh.4
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679435025;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkqKxCIT8XSpIV1aPbJLhOlYIQwEOZ33cUJOE82gt7A=;
        b=hQgG2ULgtH2dhMLeW03uXsPTVJU2KT5FvEZhYg0OAQJTuRscXlfGXIkXiNMqQiZtmq
         AHIpUWBqtBmpVsj0y0ZJ/CdTFweNG9wj9MkFyrgi1BSa14LImJZETVKrjYz4LyLrn0i/
         yqtdYK71BX2N+nroHrIIv4/ze0J0eBihX9b5abWNiCPhjtbWalGXQrKXaMDysmA2riJF
         OesQH45w/eNPVFmYLK3wYMoZBCwsm2P26bg6XLLjUi3eBirxhfkWRP5bkPG4YWvx9lnb
         LtgWYLt/yzfp/tUqE56/kNVvY1VTGwOT7WXV7vx1CnnfzzJITcLJGHH8puDLpIAb27vS
         JdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679435025;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkqKxCIT8XSpIV1aPbJLhOlYIQwEOZ33cUJOE82gt7A=;
        b=g8qSbp2ykVtgb04zGPjRdR3roh/UrAW7uS5hDhtPvCgazTOD5dMRCuhYwY62jmHY/2
         eXEwNOvLIH/xzeAdjatckGEWB161y0Sv0wrIFucl4x5jQjBtBrXQKhV+23S0t9XiuJ/n
         j+HDavAsIL/j6VFaIY/phjS20t9gtVwNNeb7jP4rkvIubZQvZciFC5gNBN5bgdRA71tr
         Dst/bA7uGYpT2vcYvfYWb8GGbuYa+GR2hYz44MQJ2Fh17sTP8zEMtkuqA4aQqOnOr2HD
         zBtf7qy/dZNUD3c6K4iPN+bO0a7TCfbIPp0stTlWGakF6g5OhvScwoBJEm0HdBDmz9Qv
         Mehg==
X-Gm-Message-State: AO0yUKXWEPIQyjA0iYw6XTwK75WkbGQmYhdzREZwTBIcM61vFsHy8ue4
        hyiPC6qvAtSurCOB1lslCWlM4x7lROeRO0XFh3o=
X-Google-Smtp-Source: AK7set/ATnkXvwSPfF/pMkeZHs024AQcV7lUVnj1XBti4Ua0f4WZmlMhXsBM5b6xHLSXmfTN13xv6Q==
X-Received: by 2002:aa7:958f:0:b0:626:7e73:2f44 with SMTP id z15-20020aa7958f000000b006267e732f44mr944751pfj.9.1679435025288;
        Tue, 21 Mar 2023 14:43:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:bd:3c2d:23b3:12df:a2a1? ([2601:647:4900:bd:3c2d:23b3:12df:a2a1])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78515000000b006259beddb63sm8285261pfn.44.2023.03.21.14.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:43:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF
 context
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <FB5E0B90-2A54-4B35-9393-1E4F018FFBFC@isovalent.com>
Date:   Tue, 21 Mar 2023 14:43:43 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7545E13C-029A-4964-89EF-A1F13E76D82D@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-4-aditi.ghag@isovalent.com>
 <ZBoiShkzD5KY2uIt@google.com>
 <FB5E0B90-2A54-4B35-9393-1E4F018FFBFC@isovalent.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 21, 2023, at 2:37 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Mar 21, 2023, at 2:31 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>>=20
>> On 03/21, Aditi Ghag wrote:
>>> When sockets are destroyed in the BPF iterator context, sock
>>> lock is already acquired, so skip taking the lock. This allows
>>> TCP listening sockets to be destroyed from BPF programs.
>>=20
>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>> ---
>>> net/ipv4/inet_hashtables.c | 9 ++++++---
>>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>=20
>>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>>> index e41fdc38ce19..5543a3e0d1b4 100644
>>> --- a/net/ipv4/inet_hashtables.c
>>> +++ b/net/ipv4/inet_hashtables.c
>>> @@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
>>> 		/* Don't disable bottom halves while acquiring the lock =
to
>>> 		 * avoid circular locking dependency on PREEMPT_RT.
>>> 		 */
>>> -		spin_lock(&ilb2->lock);
>>> +		if (!has_current_bpf_ctx())
>>> +			spin_lock(&ilb2->lock);
>>> 		if (sk_unhashed(sk)) {
>>> -			spin_unlock(&ilb2->lock);
>>> +			if (!has_current_bpf_ctx())
>>> +				spin_unlock(&ilb2->lock);
>>=20
>> That's bucket lock, why do we have to skip it?
>=20
> Because we take the bucket lock while iterating UDP sockets. See the =
first commit in this series around batching. But not all BPF contexts =
that could invoke this function may not acquire the lock, so we can't =
always skip it.=20

Sorry, my buttery fingers hit the sent button too soon. You are right, =
it's the bucket and not *sock* lock. The commit that adds batching =
releases the bucket lock. I'll take a look at the stack trace again.=20


>=20
>>=20
>>> 			return;
>>> 		}
>>=20
>>> @@ -788,7 +790,8 @@ void inet_unhash(struct sock *sk)
>>=20
>>> 		__sk_nulls_del_node_init_rcu(sk);
>>> 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>> -		spin_unlock(&ilb2->lock);
>>> +		if (!has_current_bpf_ctx())
>>> +			spin_unlock(&ilb2->lock);
>>> 	} else {
>>> 		spinlock_t *lock =3D inet_ehash_lockp(hashinfo, =
sk->sk_hash);
>>=20
>>> --
>>> 2.34.1

