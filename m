Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FF6BDBCF
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCPWhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCPWhT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 18:37:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECADCF40
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 15:37:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h14so1645321pgj.7
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679006234;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMsZs7vaY1dtQwWiuc4rO1C9d6gVJ6aT1A7riq+UoUo=;
        b=gp/w5AkIOYoqbzMmXD2sg40YoEY4FYEGbNGdp9hdueh2QotdreQLnSMzj6Wx8RdVF0
         zYb151FM6yJTta6NkLRHNAG4kreSU1C8CzagtwNVA0WZoorRq6sfRZFN4wHC2W7etaOA
         M9sm+EVq3gJ2aV4/ina6rYz79jpCbQQppSnsOGHfKoZy4VbKIBUYWRxwGi+p2j4LpML/
         YBbdlKKUJDjByfXFygFYdNnvdjHRqPqeOdmTqHdZGeb5wjHOdErrETpVeRWma8C5tUtK
         BIODu4QJvrU0/lNl9S0Ha1qeQZOW12xLIdLszw3WCjDpg0MA8InQZXD6zx5bMtJWZpoL
         lFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006234;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMsZs7vaY1dtQwWiuc4rO1C9d6gVJ6aT1A7riq+UoUo=;
        b=T+5N3uQ1Vm3CGKuvwf/ECEUIHl7DUhTcNA033eZmbu0y96K9kPJniLGmw9tbZ9QT+G
         VvhTK2o+kwfnDiJivpOFi+l6Q8VsSXJFtQNfytrhUIbp7eBmo9XPUTpik02nXgBA3Ie3
         0JPvwz4/t1UE/MyINc2SzV/O+Wv/3MDqxOCCk0zO/239yEMlU3yCymbNWSirKZKcxVaY
         msTmxuVPvR7xcXdW1cB17qypLUuLUPcRww119JPeH5SGnmPAXofHKSnUVhraGkYT2LcG
         rFnBbmz46R9xW7mUWdLZSZeCy2KNnepxQY2VAlq8OOJxd9jjf/ZJyNyKZrnRnvwGESlz
         z7cQ==
X-Gm-Message-State: AO0yUKXfrJ9FCL+bA/wWPR4IZhfdn99kXKAtffGLp+nFb2BrMptw1dKY
        WFbxg7ZsnXfy2EaXtJV39QuoPg==
X-Google-Smtp-Source: AK7set+r9ykO27ngLD4FsAfg8yOkCYCSszKJLPibpXnxGB6rjDWSozY6pMOCW+mQih+yzdMAvsDo1A==
X-Received: by 2002:a62:640b:0:b0:5a8:beb3:d55f with SMTP id y11-20020a62640b000000b005a8beb3d55fmr3764123pfb.32.1679006234478;
        Thu, 16 Mar 2023 15:37:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:bd:5414:9cc1:4350:d262? ([2601:647:4900:bd:5414:9cc1:4350:d262])
        by smtp.gmail.com with ESMTPSA id t19-20020a62ea13000000b005a8de0f4c64sm203533pfh.82.2023.03.16.15.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2023 15:37:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <b28af125-f6dc-d5af-8c07-10aaababb465@linux.dev>
Date:   Thu, 16 Mar 2023 15:37:12 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB695169-4640-4E50-901D-84CF145765F2@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com>
 <b28af125-f6dc-d5af-8c07-10aaababb465@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>, edumazet@google.com
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 28, 2023, at 2:55 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 2/23/23 1:53 PM, Aditi Ghag wrote:
>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>> + *
>> + * The helper expects a non-NULL pointer to a full socket. It =
invokes
>> + * the protocol specific socket destroy handlers.
>> + *
>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>> + * locks.
>> + *
>> + * Parameters:
>> + * @sock: Pointer to socket to be destroyed
>> + *
>> + * Return:
>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>> + * 0 otherwise
>> + */
>> +int bpf_sock_destroy(struct sock_common *sock)
>> +{
>> +	/* Validates the socket can be type casted to a full socket. */
>> +	struct sock *sk =3D sk_to_full_sk((struct sock *)sock);
>=20
> If sk !=3D sock, sk is not locked.
>=20
> Does it have to do sk_to_full_sk()? =46rom looking at tcp_abort(), it =
can handle TCP_NEW_SYN_RECV and TCP_TIME_WAIT. The bpf-tcp-iter is =
iterating the hashtables that may have sk in different states. Ideally, =
bpf-tcp-iter should be able to use bpf_sock_destroy() to abort the sk in =
different states also.

I initially added the check for request sockets as tcp_abort references =
some of the fields outside of `sock_common`, but tcp_abort does have a =
special handling for both req and time_wait sockets, as you pointed out. =
So I'll remove the  `sk_to_full_sk()` call.


Eric/Martin:

>Ideally, bpf-tcp-iter should be able to use bpf_sock_destroy() to abort =
the sk in different states also.

On somewhat of a related note, I ran into an interesting problem while =
adding more tests to exercise changes in the first commit ("Implement =
batching for UDP sockets iterator") more. As it turns out, UDP =
*listening* sockets weren't getting destroyed as client sockets.=20

So here is what the test does at a high level -=20
1) Start SO_REUSEPORT servers. (I hit same issue for regular UDP =
listening sockets as well.)
2) Run BPF iterators that destroys sockets (there are only server =
sockets).
3) Start a regular server that binds on the same port as the ones from =
(1) with the expectation that it succeeds after (1) sockets were =
destroyed. The server fails to bind!=20

When I debugged the issue, I found that the listening UDP sockets were =
still lurking around in the hash table even after they were supposed to =
be destroyed. With the help of kprobes and print statements in the BPF =
test iterator program, I confirmed that tcp_abort and the internal =
function calls (specifically, `__udp_disconnect`) were getting invoked =
as expected, and the `sk_state` was also being set to `TCP_CLOSE`. Upon =
further investigation, I found that the socket unhash and source port =
reset wasn't happening. This is the relevant code - =
https://github.com/torvalds/linux/blob/master/net/ipv4/udp.c#L1988 [1]. =
When I commented out the `SOCK_BINDPORT_LOCK` check, the new test passed =
as sockets were getting destroyed correctly.

I didn't observe similar behavior with TCP, and TCP listening sockets =
were correctly getting destroyed. `tcp_set_state` unhashes sockets =
unconditionally for `TCP_CLOSE` state.

Can you share insights into why the socket unhashing and source port =
reset doesn't happen for bind'ed sockets? If that's expected, I suppose =
we'll need to unhash and reset source ports for sockets getting =
destroyed, right?
(I wonder if this was an oversight when `__udp_disconnect` was =
introduced in commit 286c72deabaa240b7eebbd99496ed3324d69f3c0.)


If it's easier, I can push the next version of patches where I've =
addresses review comments, and added new tests. We can then continue =
this discussion there. In the latest version, I've modified [1] with a =
`TCP_CLOSE` state check.

[1] if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
		sk->sk_prot->unhash(sk);
		inet->inet_sport =3D 0;
     }

>=20
> Otherwise, the bpf_sock_destroy kfunc is aborting the listener while =
the bpf prog expects to abort a req_sk.
>=20
>> +
>> +	if (!sk)
>> +		return -EINVAL;
>> +
>> +	/* The locking semantics that allow for synchronous execution of =
the
>> +	 * destroy handlers are only supported for TCP and UDP.
>> +	 */
>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>> +		return -EOPNOTSUPP;
>> +
>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>> +}
>> +
>> +__diag_pop()
>=20

