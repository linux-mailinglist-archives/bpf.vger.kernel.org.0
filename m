Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9066C3F65
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 01:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVA72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 20:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCVA71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 20:59:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DB58488
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:59:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw3so17865909plb.6
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679446765;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK4YwNnVS575vdqsSgBupflwRK58DcTmxGK53JfDNbQ=;
        b=a7nkJo46BmYC6mJhhdVRtlR1F+4dDjXplZR121snSHp3sLhPOfvRJEzgMcQbxTIFVz
         jisBeWSLulDUbkkjHlKSKzFGThbdAegl106+3nAlfIrHFmamZGJWrglUz7mgfE/upC+S
         84VdQXuGkjIHbUqtkOUDuZrrSiG7qHhCXi4Y67Sze0j1Uq5+lDNs8R/WidPWyR3VMw8f
         qKTEAyyk/zPoHvNVs7hdC+nab702IbMcxUSoJ0LSYyldjvEHcVkzayr0BM2s/Pgt/ZPA
         6ALA3E7iWOtBEaZpcVOW8/bdolGmfPbDS/osU+WctPcUttRnMQ7nGf288teANBbsBF7W
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679446765;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK4YwNnVS575vdqsSgBupflwRK58DcTmxGK53JfDNbQ=;
        b=18wheLhHIaLpZHNpFzXhW+Ycq+sf0TO7HfqFBY0LiQd8anGkiOlCDzKFEBYCCNGlyD
         qsxbyAlTMeN3Aft7+o7y4rdqvldM+mbXGnMUeYZ5Jp7DQdXOUo9VpkKdVdI0NHFVuEM+
         ZceImRqf0xuui69TGD8Hm8+fbx19oebt6/0oyojSuGJh0CzZ5t61QsyJFvCDNG3TQDCD
         t6o5f5lPxFKOns8GZfdlf+NkIB5xNiQoXWYeeR5o0E69/kZUr4nqwM7kpHTyV+hKxusc
         ljWVi7dRXEij/Aq5ixZyyuei+gllwA2LgqluXj8lvAzA6TpoP+hXB2kP0jlnoAn5qnPj
         pTFw==
X-Gm-Message-State: AO0yUKXVcY2wme0XF4Lb29E7PT8JPNsQ08Ysjt0T85JcIXO0+mTF5ur1
        J0GYvwzSfwPzGGgeluPrgU0ybg==
X-Google-Smtp-Source: AK7set+DUeuBgZif8l4y+W1cSnFAMwOurgzQiYTiZgZGeR6Mp9/1AFK3Rwc0I8IVuJ+/IEP933lFew==
X-Received: by 2002:a17:90b:17d0:b0:23d:1a32:56d5 with SMTP id me16-20020a17090b17d000b0023d1a3256d5mr1527942pjb.27.1679446764865;
        Tue, 21 Mar 2023 17:59:24 -0700 (PDT)
Received: from [192.168.86.241] (c-98-234-248-110.hsd1.ca.comcast.net. [98.234.248.110])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b002340d317f3esm8647230pjb.52.2023.03.21.17.59.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 17:59:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 4/5] [RFC] udp: Fix destroying UDP listening
 sockets
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <8d8f605d-f722-8a91-4dcf-2017cad40f7b@linux.dev>
Date:   Tue, 21 Mar 2023 17:59:22 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4041255F-AA30-490D-801A-55F53D308550@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-5-aditi.ghag@isovalent.com>
 <8d8f605d-f722-8a91-4dcf-2017cad40f7b@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 21, 2023, at 5:29 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/21/23 11:45 AM, Aditi Ghag wrote:
>> Previously, UDP listening sockets that bind'ed to a port
>> weren't getting properly destroyed via udp_abort.
>> Specifically, the sockets were left in the UDP hash table with
>> unset source port.
>> Fix the issue by unconditionally unhashing and resetting source
>> port for sockets that are getting destroyed. This would mean
>> that in case of sockets listening on wildcarded address and
>> on a specific address with a common port, users would have to
>> explicitly select the socket(s) they intend to destroy.
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  net/ipv4/udp.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 02d357713838..a495ac88fcee 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -1965,6 +1965,25 @@ int udp_pre_connect(struct sock *sk, struct =
sockaddr *uaddr, int addr_len)
>>  }
>>  EXPORT_SYMBOL(udp_pre_connect);
>>  +int __udp_disconnect_with_abort(struct sock *sk)
>> +{
>> +	struct inet_sock *inet =3D inet_sk(sk);
>> +
>> +	sk->sk_state =3D TCP_CLOSE;
>> +	inet->inet_daddr =3D 0;
>> +	inet->inet_dport =3D 0;
>> +	sock_rps_reset_rxhash(sk);
>> +	sk->sk_bound_dev_if =3D 0;
>> +	inet_reset_saddr(sk);
>> +	inet->inet_sport =3D 0;
>> +	sk_dst_reset(sk);
>> +	/* (TBD) In case of sockets listening on wildcard and specific =
address
>> +	 * with a common port, socket will be removed from {hash, hash2} =
table.
>> +	 */
>> +	sk->sk_prot->unhash(sk);
>=20
> hmm... not sure if I understand the use case. The idea is to enforce =
the user space to bind() again when it gets error from read(fd) because =
the source ip/port needs to change when sending to another dst IP/port?


> Does it have a usage example in the selftests?

Yes, there is a new selftest case where I intend to exercise the UDP =
sockets batching changes (check the udp_server test case). Well, the =
Cilium use case is to destroy client sockets (the selftests from v1/v2 =
patch mirror the use case), but we would want to be able destroy =
listening sockets too since we don't have any code preventing that?  =20

I expected when UDP listening server sockets are destroyed, they are =
removed from the hash table, and a subsequent bind on the overlapping =
port would succeed? At least, I observed similar behavior for TCP =
sockets (minus the bind part, of course) in the test, and the connected =
client sockets were reset when the server sockets were destroyed. That's =
not what I observed for UDP listening sockets though (shared the =
debugging notes in the v2 patch [1]).=20

[1] =
https://lore.kernel.org/bpf/FB695169-4640-4E50-901D-84CF145765F2@isovalent=
.com/T/#u

>=20
>> +	return 0;
>> +}
>> +
>>  int __udp_disconnect(struct sock *sk, int flags)
>>  {
>>  	struct inet_sock *inet =3D inet_sk(sk);
>> @@ -2937,7 +2956,7 @@ int udp_abort(struct sock *sk, int err)
>>    	sk->sk_err =3D err;
>>  	sk_error_report(sk);
>> -	__udp_disconnect(sk, 0);
>> +	__udp_disconnect_with_abort(sk);
>>    out:
>>  	if (!has_current_bpf_ctx())

