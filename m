Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014296C398C
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjCUSuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCUSuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:50:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74C19695
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:49:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so17030179plb.5
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424583;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooH67UKBJ+Zq7/UwgLxQmbECkL+uA16UMmUqPow91Rc=;
        b=ZMiYSzeaiQW7Ld0BnhWN7vkEpOrMGi0UifjsT4RpSay2k/WPCISG/ASRZ1sIfOQHph
         keWSY9vv0w/vTeJLmu/3BKBZRSASMKUG7uOvGJJW262aOQyLc+k1/taj0Z3wuFGYPdiV
         83cZ5/LBmBJXwsICAngXCK72zTy02+qAEyfsXLFMDhA4f71hC0V9x1yinI/MLQHNprGy
         ThECycTWTjZyMXe06pbtAg26ORH6+VS7TuJwVcvIPWQGul/5Ow+/IoTNuqvGv7gODdap
         60aU1I7ENCJeHPs3cDwHjEf1ZA4TBR61zgizjeKBHx75+ZpmND2kFfSuSDDmZsl3rbyt
         rHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424583;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooH67UKBJ+Zq7/UwgLxQmbECkL+uA16UMmUqPow91Rc=;
        b=lGV7rx/s8WyfUnfLp3WcdMcKDXm4i9FluKxxahOeam2bS9Gjl+ziB/sJ4tnJdlgLHq
         RoTi9Qibiw4LCGlsZSYdmtD7kwOvChpooPDIISSdxdHEWVoYcbpMsTuit+fRFYzVdmGW
         j0txdSJYydDYvxlBzIunlcRDoDx9qiKvWZbahpf9Mi2TR8tsedRHofda0n3+S6bEmp4h
         xrFehoWKYBmHC3n78gPDMhFQdpUk73gtWZJxC+HhUJvs3sxyCthvuhTxgi+5v81BauXu
         lV8m1kKLJJ4dyiZ/v3zy7uWBIWErseMckQPiVLlAn9VoulOIjDBxjXixxhBD1iBwh8Cw
         Q5Wg==
X-Gm-Message-State: AO0yUKWDbSR0PNRzwD6di37hmpJlYZFFq9ZVtce/OBw+utoIUT2K1LHa
        IwgCsIonErQqPSN/wrHayx9KAA==
X-Google-Smtp-Source: AK7set/K1adRDuVC8eKrabRKmAE5snxKsKCaPDy/2yx0itGQ9t3r14CcyD5CaCCfuFMwlWGElp3LMA==
X-Received: by 2002:a05:6a20:2925:b0:d6:95c3:87b0 with SMTP id t37-20020a056a20292500b000d695c387b0mr2785474pzf.43.1679424583107;
        Tue, 21 Mar 2023 11:49:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:bd:3c2d:23b3:12df:a2a1? ([2601:647:4900:bd:3c2d:23b3:12df:a2a1])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b005a90f2cce30sm8521646pfo.49.2023.03.21.11.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:49:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <FB695169-4640-4E50-901D-84CF145765F2@isovalent.com>
Date:   Tue, 21 Mar 2023 11:49:40 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B58B6FCE-A364-48AB-B114-D50D1FB71132@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com>
 <b28af125-f6dc-d5af-8c07-10aaababb465@linux.dev>
 <FB695169-4640-4E50-901D-84CF145765F2@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>, edumazet@google.com
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 16, 2023, at 3:37 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Feb 28, 2023, at 2:55 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>=20
>> On 2/23/23 1:53 PM, Aditi Ghag wrote:
>>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>>> + *
>>> + * The helper expects a non-NULL pointer to a full socket. It =
invokes
>>> + * the protocol specific socket destroy handlers.
>>> + *
>>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>>> + * locks.
>>> + *
>>> + * Parameters:
>>> + * @sock: Pointer to socket to be destroyed
>>> + *
>>> + * Return:
>>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>>> + * 0 otherwise
>>> + */
>>> +int bpf_sock_destroy(struct sock_common *sock)
>>> +{
>>> +	/* Validates the socket can be type casted to a full socket. */
>>> +	struct sock *sk =3D sk_to_full_sk((struct sock *)sock);
>>=20
>> If sk !=3D sock, sk is not locked.
>>=20
>> Does it have to do sk_to_full_sk()? =46rom looking at tcp_abort(), it =
can handle TCP_NEW_SYN_RECV and TCP_TIME_WAIT. The bpf-tcp-iter is =
iterating the hashtables that may have sk in different states. Ideally, =
bpf-tcp-iter should be able to use bpf_sock_destroy() to abort the sk in =
different states also.
>=20
> I initially added the check for request sockets as tcp_abort =
references some of the fields outside of `sock_common`, but tcp_abort =
does have a special handling for both req and time_wait sockets, as you =
pointed out. So I'll remove the `sk_to_full_sk()` call.
>=20
>=20
> Eric/Martin:
>=20
>> Ideally, bpf-tcp-iter should be able to use bpf_sock_destroy() to =
abort the sk in different states also.
>=20
> On somewhat of a related note, I ran into an interesting problem while =
adding more tests to exercise changes in the first commit ("Implement =
batching for UDP sockets iterator") more. As it turns out, UDP =
*listening* sockets weren't getting destroyed as client sockets.=20
>=20
> So here is what the test does at a high level -=20
> 1) Start SO_REUSEPORT servers. (I hit same issue for regular UDP =
listening sockets as well.)
> 2) Run BPF iterators that destroys sockets (there are only server =
sockets).
> 3) Start a regular server that binds on the same port as the ones from =
(1) with the expectation that it succeeds after (1) sockets were =
destroyed. The server fails to bind!=20
>=20
> When I debugged the issue, I found that the listening UDP sockets were =
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
>=20
> I didn't observe similar behavior with TCP, and TCP listening sockets =
were correctly getting destroyed. `tcp_set_state` unhashes sockets =
unconditionally for `TCP_CLOSE` state.
>=20
> Can you share insights into why the socket unhashing and source port =
reset doesn't happen for bind'ed sockets? If that's expected, I suppose =
we'll need to unhash and reset source ports for sockets getting =
destroyed, right?
> (I wonder if this was an oversight when `__udp_disconnect` was =
introduced in commit 286c72deabaa240b7eebbd99496ed3324d69f3c0.)
>=20
>=20
> If it's easier, I can push the next version of patches where I've =
addresses review comments, and added new tests. We can then continue =
this discussion there. In the latest version, I've modified [1] with a =
`TCP_CLOSE` state check.
>=20
> [1] if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
> 		sk->sk_prot->unhash(sk);
> 		inet->inet_sport =3D 0;
>     }


Scratch my comment about adding the state check. We can discuss the fix =
in v3 patch series - =
https://lore.kernel.org/bpf/20230321184541.1857363-5-aditi.ghag@isovalent.=
com/T/#u.=20


>=20
>>=20
>> Otherwise, the bpf_sock_destroy kfunc is aborting the listener while =
the bpf prog expects to abort a req_sk.
>>=20
>>> +
>>> +	if (!sk)
>>> +		return -EINVAL;
>>> +
>>> +	/* The locking semantics that allow for synchronous execution of =
the
>>> +	 * destroy handlers are only supported for TCP and UDP.
>>> +	 */
>>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>>> +}
>>> +
>>> +__diag_pop()

