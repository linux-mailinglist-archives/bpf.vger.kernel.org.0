Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3456C5C2B
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 02:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWBft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 21:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCWBfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 21:35:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B10318B25
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 18:35:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ix20so20940382plb.3
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679535345;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI96zbh9Stcr9iKyjOcr1kHhyLAUUqnt999ea1+jPWs=;
        b=aN30p/3oN/sRA81NKIZeb7xQFgDYI3RNiAqpOaQJqjF9QWatBgQfHitxRtVJPtqVAJ
         0m3gz2WdH9OAQpXFaTu/ohDuJCkZiB60vbo9s5yGBJoGzPM2/Xm7/2gX4UR5T9eMXd1S
         s4BovxCGKlzYgK/TxLMmGizVI9iTiwyaGi2GZVmDPQpE9FtPLVxiaKowhIh+w9yScfGc
         97kuc8Z5UgbTXCHQMBcQWcnYKwkVj1mLE6LA1GTewu5iNhjs+FpCIg9WBmSNaqIbWjk0
         BPP4LpzbHRhJzX+K9A1witvyvMvU//zFC9qkBYz0VctDe3k0hkwVVgCjPQQo7uAefjeF
         fflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535345;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI96zbh9Stcr9iKyjOcr1kHhyLAUUqnt999ea1+jPWs=;
        b=QdsYx82ZQrJYKReRDMHiZO8/U9d87liIuOG3F8X9m9+c+1HmSTktDHvAcxmCYJHidp
         KFhHIB0nowuPut8USo9VPf8V4RBPAESj0f4Oad9vYWcOPURdoO+h6QAjJSlQkWLCzcdC
         n8waFVpdnjwIqze2WJhR7SuDDOd1ILSQxPnU71TDoLocM5b17xM/KU2FJ76G7M1UceSi
         +zmMrx1HECJ5zhbmew0YACZe6AYZL2oCbBEtz92cWSZ+9ww0NVePxJdn4Ec+bVOk3EeH
         rfSsaA9g/dKzu6Fh0+KLLQQ46wI6W+/eMtoZaB6UoOjkKj7k+OBUaFfcpNtsjfhKO8ns
         sIpQ==
X-Gm-Message-State: AO0yUKXdTnPXHYI9Eq6n19IaLArKDdeXk7TQVJgA/KwRmv2Kn/e0vBRI
        KT2WjvINK1guDG+j7MklZTBfng==
X-Google-Smtp-Source: AK7set9WJIjBuVf17y1vSFIxJyY2SRCsxMsjg8C1I4V2OFtepav3UJbDXC+yfeTiUQR56RPL15vKMA==
X-Received: by 2002:a17:902:c7d2:b0:19d:abd:bb7e with SMTP id r18-20020a170902c7d200b0019d0abdbb7emr3320815pla.34.1679535345364;
        Wed, 22 Mar 2023 18:35:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:2893:7c18:2a69:fc69? ([2601:647:4900:1fbb:2893:7c18:2a69:fc69])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902868100b0019a593e45f1sm11136618plo.261.2023.03.22.18.35.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 18:35:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 4/5] [RFC] udp: Fix destroying UDP listening
 sockets
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <0472be9f-dcee-2ab1-b185-0c0f6124ec0f@linux.dev>
Date:   Wed, 22 Mar 2023 18:35:42 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65DC90DE-0CD3-45E0-A2EA-031A2A2A8D9D@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-5-aditi.ghag@isovalent.com>
 <8d8f605d-f722-8a91-4dcf-2017cad40f7b@linux.dev>
 <4041255F-AA30-490D-801A-55F53D308550@isovalent.com>
 <12727201-7e30-da54-ff68-6c515731aa00@linux.dev>
 <6C0AF100-880E-4311-9C27-82A22A3D3C4C@isovalent.com>
 <0472be9f-dcee-2ab1-b185-0c0f6124ec0f@linux.dev>
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



> On Mar 22, 2023, at 6:08 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/22/23 5:32 PM, Aditi Ghag wrote:
>>> On Mar 22, 2023, at 3:55 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 3/21/23 5:59 PM, Aditi Ghag wrote:
>>>>> On Mar 21, 2023, at 5:29 PM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>>>>>=20
>>>>> On 3/21/23 11:45 AM, Aditi Ghag wrote:
>>>>>> Previously, UDP listening sockets that bind'ed to a port
>>>>>> weren't getting properly destroyed via udp_abort.
>>>>>> Specifically, the sockets were left in the UDP hash table with
>>>>>> unset source port.
>>>>>> Fix the issue by unconditionally unhashing and resetting source
>>>>>> port for sockets that are getting destroyed. This would mean
>>>>>> that in case of sockets listening on wildcarded address and
>>>>>> on a specific address with a common port, users would have to
>>>>>> explicitly select the socket(s) they intend to destroy.
>>>>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>>>>> ---
>>>>>>  net/ipv4/udp.c | 21 ++++++++++++++++++++-
>>>>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>>>> index 02d357713838..a495ac88fcee 100644
>>>>>> --- a/net/ipv4/udp.c
>>>>>> +++ b/net/ipv4/udp.c
>>>>>> @@ -1965,6 +1965,25 @@ int udp_pre_connect(struct sock *sk, =
struct sockaddr *uaddr, int addr_len)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL(udp_pre_connect);
>>>>>>  +int __udp_disconnect_with_abort(struct sock *sk)
>>>>>> +{
>>>>>> +	struct inet_sock *inet =3D inet_sk(sk);
>>>>>> +
>>>>>> +	sk->sk_state =3D TCP_CLOSE;
>>>>>> +	inet->inet_daddr =3D 0;
>>>>>> +	inet->inet_dport =3D 0;
>>>>>> +	sock_rps_reset_rxhash(sk);
>>>>>> +	sk->sk_bound_dev_if =3D 0;
>>>>>> +	inet_reset_saddr(sk);
>>>>>> +	inet->inet_sport =3D 0;
>>>>>> +	sk_dst_reset(sk);
>>>>>> +	/* (TBD) In case of sockets listening on wildcard and =
specific address
>>>>>> +	 * with a common port, socket will be removed from =
{hash, hash2} table.
>>>>>> +	 */
>>>>>> +	sk->sk_prot->unhash(sk);
>>>>>=20
>>>>> hmm... not sure if I understand the use case. The idea is to =
enforce the user space to bind() again when it gets error from read(fd) =
because the source ip/port needs to change when sending to another dst =
IP/port?
>>>>> Does it have a usage example in the selftests?
>>>> Yes, there is a new selftest case where I intend to exercise the =
UDP sockets batching changes (check the udp_server test case). Well, the =
Cilium use case is to destroy client sockets (the selftests from v1/v2 =
patch mirror the use case), but we would want to be able destroy =
listening sockets too since we don't have any code preventing that?
>>>> I expected when UDP listening server sockets are destroyed, they =
are removed from the hash table, and a subsequent bind on the =
overlapping port would succeed? At least, I observed similar behavior =
for TCP sockets (minus the bind part, of course) in the test, and the =
connected client sockets were reset when the server sockets were =
destroyed. That's not what I observed for UDP listening sockets though =
(shared the debugging notes in the v2 patch [1]).
>>>=20
>>> The tcp 'clien', from 'connect_to_fd()', was not bind() to a =
particular local ip and port. afaik, the tcp server which binds to a =
particular ip and port will observe similar behavior as the udp server.
>>>=20
>>> When the user space notices a read() error from a UDP server socket =
(because of udp_abort), should the user space close() this udp server =
socket first before opening a new one and then bind to a different src =
ip and src port?
>>> or I am still missing some pieces in the use case where there is =
other cgroup bpf programs doing bind?
>> I'm not sure if we are talking about the same selftests. It's =
possible that the new server related selftests are not validating the =
behavior in the right way.
>> Let's take an example of the test_udp_server test. It does the =
following -
>=20
> Yep, I was looking at the test_udp_server test.
>=20
>> 1) Start SO_REUSEPORT servers. (I hit same issue for regular UDP =
listening sockets as well.)
>=20
> Note that UDP has no listen(). It is just a bind().
>=20
>> 2) Run BPF iterators that destroys the server sockets.
>=20
> destroy does not mean it is gone from the kernel space or user space. =
User space still has a fd.
>=20
>> 3) Start a regular server that binds on the same port as the ones =
from (1) with the expectation that it succeeds after (1) sockets were =
destroyed. The server fails to bind. Moreover, the UDP sockets were =
lingering in the kernel hash table without the fix in one of the =
commits.
>> Are you suggesting that (3) is expected?  The destroyed sockets are =
expected to be also present in the hash table? Are you saying that =
userspace needs to first close the sockets that were destroyed in the =
kernel when they encounter read() error?
>=20
> Yes, (3) is expected (at least the current abort behavior). The user =
space still holds the fd of (1). The user space did bind(fd1) to request =
for a specific local addr/port and the user space has not closed it yet. =
The current udp_abort does not undo this ip/port binding which is a =
sensible thing, imo.

Got it.=20

>=20
> I have been answering a lot of questions. May be time to go back to my =
earlier question,
> why the user space server cannot do a close on the fd after the =
previous read() return ECONNABORTED? It seems to be the most sensible =
server retry logic when getting ECONNABORTED and then open another =
socket to do bind() again. test_udp_server() is also creating a new =
socket to do the bind() after the earlier the kfunc destroy is done, so =
the old fd1 is supposed to be useless anyway.


Thanks for the clarifications. The client selftests are doing the same =
validations: check if read() fails, and check for ECONNABORTED error =
code. So yes, we can do the same for servers as well.
I've been on the same page with userspace checking for error codes, or =
failures in the socket read call. It's just the bind case that tripped =
me: I expected the kernel to free up source ports that the destroyed =
sockets had previously called bind on.

I'll update the server tests.=20


