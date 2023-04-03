Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F36D4BD4
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDCP2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDCP2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 11:28:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330B2724
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 08:27:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso30946355pjb.2
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680535675;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9IHvRYv9qIpUGmkHiaAnO9UDfpOKVjp+LoLzMdPKx4=;
        b=DOOHkCMRS2A4nmgjELXBywbPsCVQ+T0Ne4Y2zQ3/DlfhN+GLDgGvXoIQciK74tkHtj
         sJEIjJTi9I0EQfN++PKpYW52Z51AT6d8HucQNDiJ3DP1PwUoCJwkfckl1nmcs6qXBR3P
         Xqx2Pco7kMSU7YPxna9ry3Wcx3AXCXYp58wmxy+6hHwqqB+kwyp6y/ncLP6XOmPOg/H1
         +jySags2U+ouiQmonPxaHwbv8n5MTwhf3ehWtWubJLIHkdsld9RWOwhKzfiWnkFxigUr
         sdUitfP1fpwIOY18PRuKReH0bjaXtAuEDgaIXCrQZ+1AYJBQ56ISua/wiaoUeIa/f1qe
         8TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535675;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9IHvRYv9qIpUGmkHiaAnO9UDfpOKVjp+LoLzMdPKx4=;
        b=rCMVJLI3/dX8BIOFtQVvPZA3c9XteBRxRsgB8LvZ+djdhNv3i6Tjzw8BD3nESiQs5w
         RceIi69dBpWISbXK9MJmazudKL2Dj/8GObAopHAYvvkmqadbRcVT+pycwGz4f+vpul3x
         MrH1y7vDqd06lxUrbsOOfRy4lM/DwrLBH+fFGOlgBZpS9VXkA+H1QO3GOAoamZKjShnP
         b/c2KDd2NIFNPKH/AUOlgsCdPOwskMkYDBMpKNW73JLQTPtN3Njj9DbSgfk7z9rFodoY
         vZjonxjvtIuxgtXEPetpuwPGS13gbO6uyDsl4X7r/c8NRBFHTSY1jkdcsvodvXBcyWt7
         cMfQ==
X-Gm-Message-State: AAQBX9dCPX1auBuISwmCkUsaMMxB/UiiP53L08OP1Duq+vRBa6k8dFUx
        gkDgT7JNbQZFB1sLnA+2og/3dxhoiigJMk4AaSs=
X-Google-Smtp-Source: AKy350a6C0YTeWMuaOTm/yVpk5UXxEMdjN6pSfG0hgqf2neSXP16oc+gOZQuAmKjDeYzaWNcrxhcSQ==
X-Received: by 2002:a17:90b:38cc:b0:23f:5ea8:3ccd with SMTP id nn12-20020a17090b38cc00b0023f5ea83ccdmr41736272pjb.30.1680535675394;
        Mon, 03 Apr 2023 08:27:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id rj3-20020a17090b3e8300b0023f685f7914sm9869332pjb.49.2023.04.03.08.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:27:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match
 socket attributes
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <42a8dceb-2551-715b-b871-db55eb43bd0a@linux.dev>
Date:   Mon, 3 Apr 2023 08:27:52 -0700
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <292B7FAB-8DB1-489D-9CB8-61418DFF983E@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-4-aditi.ghag@isovalent.com>
 <42a8dceb-2551-715b-b871-db55eb43bd0a@linux.dev>
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



> On Mar 31, 2023, at 1:09 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/30/23 8:17 AM, Aditi Ghag wrote:
>> This is a preparatory commit to refactor code that matches socket
>> attributes in iterators to a helper function, and use it in the
>> proc fs iterator.
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  net/ipv4/udp.c | 35 ++++++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index c574c8c17ec9..cead4acb64c6 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2983,6 +2983,8 @@ EXPORT_SYMBOL(udp_prot);
>>  /* =
------------------------------------------------------------------------ =
*/
>>  #ifdef CONFIG_PROC_FS
>>  +static inline bool seq_sk_match(struct seq_file *seq, const struct =
sock *sk);
>> +
>>  static struct udp_table *udp_get_table_afinfo(struct udp_seq_afinfo =
*afinfo,
>>  					      struct net *net)
>>  {
>> @@ -3010,10 +3012,7 @@ static struct sock *udp_get_first(struct =
seq_file *seq, int start)
>>    		spin_lock_bh(&hslot->lock);
>>  		sk_for_each(sk, &hslot->head) {
>> -			if (!net_eq(sock_net(sk), net))
>> -				continue;
>> -			if (afinfo->family =3D=3D AF_UNSPEC ||
>> -			    sk->sk_family =3D=3D afinfo->family)
>> +			if (seq_sk_match(seq, sk))
>>  				goto found;
>>  		}
>>  		spin_unlock_bh(&hslot->lock);
>> @@ -3034,9 +3033,7 @@ static struct sock *udp_get_next(struct =
seq_file *seq, struct sock *sk)
>>    	do {
>>  		sk =3D sk_next(sk);
>> -	} while (sk && (!net_eq(sock_net(sk), net) ||
>> -			(afinfo->family !=3D AF_UNSPEC &&
>> -			 sk->sk_family !=3D afinfo->family)));
>> +	} while (sk && !seq_sk_match(seq, sk));
>>    	if (!sk) {
>>  		udptable =3D udp_get_table_afinfo(afinfo, net);
>> @@ -3143,6 +3140,17 @@ struct bpf_iter__udp {
>>  	int bucket __aligned(8);
>>  };
>>  +static unsigned short seq_file_family(const struct seq_file *seq);
>> +
>> +static inline bool seq_sk_match(struct seq_file *seq, const struct =
sock *sk)
>=20
> This won't work under CONFIG_BPF_SYSCALL. The bot also complained.
> It has to be under CONFIG_PROG_FS.
>=20
> No need to use inline and leave it to compiler.
>=20
> The earlier forward declaration is unnecessary. Define the function =
earlier instead.


Yes, I got notifications from the kernel test bot, so I've already made =
the necessary changes.

>=20
>> +{
>> +	unsigned short family =3D seq_file_family(seq);
>> +
>> +	/* AF_UNSPEC is used as a match all */
>> +	return ((family =3D=3D AF_UNSPEC || family =3D=3D sk->sk_family) =
&&
>> +		net_eq(sock_net(sk), seq_file_net(seq)));
>> +}
>> +
>>  static int udp_prog_seq_show(struct bpf_prog *prog, struct =
bpf_iter_meta *meta,
>>  			     struct udp_sock *udp_sk, uid_t uid, int =
bucket)
>>  {
>> @@ -3194,6 +3202,19 @@ static const struct seq_operations =
bpf_iter_udp_seq_ops =3D {
>>  	.stop		=3D bpf_iter_udp_seq_stop,
>>  	.show		=3D bpf_iter_udp_seq_show,
>>  };
>> +
>> +static unsigned short seq_file_family(const struct seq_file *seq)
>=20
> The same here because seq_sk_match() uses seq_file_family().
>=20
>> +{
>> +	const struct udp_seq_afinfo *afinfo;
>> +
>> +	/* BPF iterator: bpf programs to filter sockets. */
>> +	if (seq->op =3D=3D &bpf_iter_udp_seq_ops)
>=20
> Note that bpf_iter_udp_seq_ops is only defined under =
CONFIG_BPF_SYSCALL though.
> See how the seq_file_family() is handling it in tcp_ipv4.c.

Same as above.=20

>=20
>> +		return AF_UNSPEC;
>> +
>> +	/* Proc fs iterator */
>> +	afinfo =3D pde_data(file_inode(seq->file));
>> +	return afinfo->family;
>> +}
>>  #endif
>>    const struct seq_operations udp_seq_ops =3D {

