Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66366C3CD2
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCUVhR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUVhR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:37:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DBD36FD2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:37:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so21740043pjt.2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679434636;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EN85YGGyVmLXybh8EneRELiBJA8VR+Ppt7gd1CLcFs=;
        b=Z5+V15tLENQ/EglBfX/39tP5RJR9pgpAyNIELBcWWie+aD27nC3UDzo/5ZzfvZ+aIE
         OjMV3AZnin455wybXAQ7cHGlNtCnYQysY1ifNyBnxnUvYM1KWtw1yvqpq1fehLYSj7/+
         FC+uqKpEvdzEyR03pkDaoj3kxzD/NmUZofN4sBVlkF1dQX1zfHpVYSaLUpNeY0jeCFGa
         XEBqH2k0sKLg2GYrMAFNDJN8zpPKAObniGrXKj2wNAZPG44B1VWbXd7D0T5YRZhiN/4M
         MII00oRl14FjJJeShax7iVbVioYXyqdBGRz56PCwMKAU5PS3UleF0r02iaVZljil5BVe
         iA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434636;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EN85YGGyVmLXybh8EneRELiBJA8VR+Ppt7gd1CLcFs=;
        b=a/xQ5QArKLGaKDanCt0X0fkMa635WAz73H/+226DXyjW7O43BewK0mfbLAIWMv8f3Y
         KOrnAm2/VGRTQBZCJrwKdU39BT8JFNahEpYfsNVwOnrqv01pfJjoulIlunf7ycQ09qyO
         TW3VR7BVedImUe1DkBZQLAFO6zuNVdeaM8dLvpu6Kqz1VWu8p90LiBtxwUmDQ1wCmRCS
         9ngFdaaOoNPvB2+OjKk7tltAsJLnGT+wyODQy1ONzIFrbgOyw/SGMC6XwuA6zj7fcOdI
         v62Out00oRGrX2zl8xu1o1x8Zm1uCNFgMxW7lPZ/oHRUlj7CoQ3zELNIf8swo+6WD48E
         nFOg==
X-Gm-Message-State: AO0yUKVAE1GMAYxOmtUkvVLskZ1JZpGDIQreQbsAtJr+IidkvA8IaZae
        wlJGGSNMkLn367f5Kgv67SMUFw==
X-Google-Smtp-Source: AK7set+IZSDXlxsnhUSgoS1Hie00cDNXEsIdYspy3kRpsyEIy8YnSGVgWZvMRbe7N0GLdzHcwro/3w==
X-Received: by 2002:a17:903:210b:b0:1a1:d096:7152 with SMTP id o11-20020a170903210b00b001a1d0967152mr382505ple.39.1679434635658;
        Tue, 21 Mar 2023 14:37:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:bd:3c2d:23b3:12df:a2a1? ([2601:647:4900:bd:3c2d:23b3:12df:a2a1])
        by smtp.gmail.com with ESMTPSA id jh4-20020a170903328400b0019f398ed834sm9153338plb.212.2023.03.21.14.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:37:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF
 context
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZBoiShkzD5KY2uIt@google.com>
Date:   Tue, 21 Mar 2023 14:37:13 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB5E0B90-2A54-4B35-9393-1E4F018FFBFC@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-4-aditi.ghag@isovalent.com>
 <ZBoiShkzD5KY2uIt@google.com>
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



> On Mar 21, 2023, at 2:31 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/21, Aditi Ghag wrote:
>> When sockets are destroyed in the BPF iterator context, sock
>> lock is already acquired, so skip taking the lock. This allows
>> TCP listening sockets to be destroyed from BPF programs.
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  net/ipv4/inet_hashtables.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index e41fdc38ce19..5543a3e0d1b4 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
>>  		/* Don't disable bottom halves while acquiring the lock =
to
>>  		 * avoid circular locking dependency on PREEMPT_RT.
>>  		 */
>> -		spin_lock(&ilb2->lock);
>> +		if (!has_current_bpf_ctx())
>> +			spin_lock(&ilb2->lock);
>>  		if (sk_unhashed(sk)) {
>> -			spin_unlock(&ilb2->lock);
>> +			if (!has_current_bpf_ctx())
>> +				spin_unlock(&ilb2->lock);
>=20
> That's bucket lock, why do we have to skip it?

Because we take the bucket lock while iterating UDP sockets. See the =
first commit in this series around batching. But not all BPF contexts =
that could invoke this function may not acquire the lock, so we can't =
always skip it.=20

>=20
>>  			return;
>>  		}
>=20
>> @@ -788,7 +790,8 @@ void inet_unhash(struct sock *sk)
>=20
>>  		__sk_nulls_del_node_init_rcu(sk);
>>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> -		spin_unlock(&ilb2->lock);
>> +		if (!has_current_bpf_ctx())
>> +			spin_unlock(&ilb2->lock);
>>  	} else {
>>  		spinlock_t *lock =3D inet_ehash_lockp(hashinfo, =
sk->sk_hash);
>=20
>> --
>> 2.34.1

