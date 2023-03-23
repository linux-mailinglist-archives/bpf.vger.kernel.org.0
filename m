Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBF6C5B60
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 01:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCWAcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCWAcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 20:32:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254271632D
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 17:32:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id iw3so20833044plb.6
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 17:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679531532;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IBOsOhy/SchaHT/84ms6HteB6CqTI9UdijkR2ETH4U=;
        b=Bu7NnHCx8tQFKmqWLYtAtWLAmGKQ5okBqibA3x5dYRUbFW2KtDp0p+HjpHBzlgBhkJ
         1R7267TICa6xVDkfBN+NDozFv3SZm/9RM7BB9aPncnaA2OgGNO+kmq6zegAPugBKaOyv
         tq7ra/JepNzD2U8am883JqtZfRwZ3+F0qCNZITirc4VNUb4HJZmRzq79Icfe6E6AiNce
         Mzso600a3dZ0IRStz81sad1rVr9xFtZf6MoAHACqHCB1LErYlwxNakpyyaRxTDRRkaj8
         5+ymTw3iF8J2VNwmlgulp6oIutMupdSAwpeuuB+nGw9DRf8JUCDAdw2WHRkdFYjnurLn
         fttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679531532;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IBOsOhy/SchaHT/84ms6HteB6CqTI9UdijkR2ETH4U=;
        b=P6vSxwnuDYu2OOHQX2TXX/9kps4XjOIdxiCvhVbSlIOQqm9nMIP3+bXjj1F90a70we
         ajqR+EiJ3DOHoFRKXlzP1PYpJQ+1xh8msHkvh9/FS0q04zW/OPbVFtmbTixR8+UuyQVd
         FNsB0cjRo+keU2TvuCj7ZxTvRlNJMCMnk7/n+MkWCmLnWLPckhdvKEh4oOahRQgRWmug
         ScI9qz+A7qTLcxY9QB6ASB724tRk0QdAXQW2bTUF40FViZrQbA8GvvMAo/0Oot0rfPT2
         uzz27UcMNSUeCdX5MlSiQ1e64x4j8v9J5op76FaoL/8OJxOmRg+hvNiYN4SJ8AKPTOJZ
         XsMg==
X-Gm-Message-State: AAQBX9fJaKEQc5LDfGMN9+gT/1TcDEaQ4/8Z5j0JXPGVeg95EWpPddqw
        JOX/SJH14FLbsuN+qs531drRUw==
X-Google-Smtp-Source: AKy350ap8OjPuvVXkK1wfxaiIsWAQmDyPejCRdU4nmOlsnRlZ2dSxs5LVKvJI5Z0kn3WQTaNuMrrRA==
X-Received: by 2002:a17:902:f392:b0:199:1160:956c with SMTP id f18-20020a170902f39200b001991160956cmr2693331ple.31.1679531532339;
        Wed, 22 Mar 2023 17:32:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:2893:7c18:2a69:fc69? ([2601:647:4900:1fbb:2893:7c18:2a69:fc69])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902b68a00b0019edf07eb06sm11118577pls.122.2023.03.22.17.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 17:32:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 4/5] [RFC] udp: Fix destroying UDP listening
 sockets
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <12727201-7e30-da54-ff68-6c515731aa00@linux.dev>
Date:   Wed, 22 Mar 2023 17:32:10 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C0AF100-880E-4311-9C27-82A22A3D3C4C@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-5-aditi.ghag@isovalent.com>
 <8d8f605d-f722-8a91-4dcf-2017cad40f7b@linux.dev>
 <4041255F-AA30-490D-801A-55F53D308550@isovalent.com>
 <12727201-7e30-da54-ff68-6c515731aa00@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 22, 2023, at 3:55 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/21/23 5:59 PM, Aditi Ghag wrote:
>>> On Mar 21, 2023, at 5:29 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 3/21/23 11:45 AM, Aditi Ghag wrote:
>>>> Previously, UDP listening sockets that bind'ed to a port
>>>> weren't getting properly destroyed via udp_abort.
>>>> Specifically, the sockets were left in the UDP hash table with
>>>> unset source port.
>>>> Fix the issue by unconditionally unhashing and resetting source
>>>> port for sockets that are getting destroyed. This would mean
>>>> that in case of sockets listening on wildcarded address and
>>>> on a specific address with a common port, users would have to
>>>> explicitly select the socket(s) they intend to destroy.
>>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>>> ---
>>>>  net/ipv4/udp.c | 21 ++++++++++++++++++++-
>>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>> index 02d357713838..a495ac88fcee 100644
>>>> --- a/net/ipv4/udp.c
>>>> +++ b/net/ipv4/udp.c
>>>> @@ -1965,6 +1965,25 @@ int udp_pre_connect(struct sock *sk, struct =
sockaddr *uaddr, int addr_len)
>>>>  }
>>>>  EXPORT_SYMBOL(udp_pre_connect);
>>>>  +int __udp_disconnect_with_abort(struct sock *sk)
>>>> +{
>>>> +	struct inet_sock *inet =3D inet_sk(sk);
>>>> +
>>>> +	sk->sk_state =3D TCP_CLOSE;
>>>> +	inet->inet_daddr =3D 0;
>>>> +	inet->inet_dport =3D 0;
>>>> +	sock_rps_reset_rxhash(sk);
>>>> +	sk->sk_bound_dev_if =3D 0;
>>>> +	inet_reset_saddr(sk);
>>>> +	inet->inet_sport =3D 0;
>>>> +	sk_dst_reset(sk);
>>>> +	/* (TBD) In case of sockets listening on wildcard and specific =
address
>>>> +	 * with a common port, socket will be removed from {hash, hash2} =
table.
>>>> +	 */
>>>> +	sk->sk_prot->unhash(sk);
>>>=20
>>> hmm... not sure if I understand the use case. The idea is to enforce =
the user space to bind() again when it gets error from read(fd) because =
the source ip/port needs to change when sending to another dst IP/port?
>>> Does it have a usage example in the selftests?
>> Yes, there is a new selftest case where I intend to exercise the UDP =
sockets batching changes (check the udp_server test case). Well, the =
Cilium use case is to destroy client sockets (the selftests from v1/v2 =
patch mirror the use case), but we would want to be able destroy =
listening sockets too since we don't have any code preventing that?
>> I expected when UDP listening server sockets are destroyed, they are =
removed from the hash table, and a subsequent bind on the overlapping =
port would succeed? At least, I observed similar behavior for TCP =
sockets (minus the bind part, of course) in the test, and the connected =
client sockets were reset when the server sockets were destroyed. That's =
not what I observed for UDP listening sockets though (shared the =
debugging notes in the v2 patch [1]).
>=20
> The tcp 'clien', from 'connect_to_fd()', was not bind() to a =
particular local ip and port. afaik, the tcp server which binds to a =
particular ip and port will observe similar behavior as the udp server.
>=20
> When the user space notices a read() error from a UDP server socket =
(because of udp_abort), should the user space close() this udp server =
socket first before opening a new one and then bind to a different src =
ip and src port?
> or I am still missing some pieces in the use case where there is other =
cgroup bpf programs doing bind?

I'm not sure if we are talking about the same selftests. It's possible =
that the new server related selftests are not validating the behavior in =
the right way.

Let's take an example of the test_udp_server test. It does the following =
-=20

1) Start SO_REUSEPORT servers. (I hit same issue for regular UDP =
listening sockets as well.)
2) Run BPF iterators that destroys the server sockets.
3) Start a regular server that binds on the same port as the ones from =
(1) with the expectation that it succeeds after (1) sockets were =
destroyed. The server fails to bind. Moreover, the UDP sockets were =
lingering in the kernel hash table without the fix in one of the =
commits.=20

Are you suggesting that (3) is expected?  The destroyed sockets are =
expected to be also present in the hash table? Are you saying that =
userspace needs to first close the sockets that were destroyed in the =
kernel when they encounter read() error?=20

>=20
>=20
>> [1] =
https://lore.kernel.org/bpf/FB695169-4640-4E50-901D-84CF145765F2@isovalent=
.com/T/#u

