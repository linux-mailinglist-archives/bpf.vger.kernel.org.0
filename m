Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B76F3A92
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 00:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEAWjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAWjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 18:39:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BB1726
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 15:39:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so2013509a12.1
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682980744; x=1685572744;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDcqkpeJ9FpMbQTWstGL4y3ofdnJwgu6ymAgZ8epW6o=;
        b=JKKsc7tjyWnb1hS3805Xi3nT/f1hgN8ofxsO7aHuSV5NPRkfjr/3hFBpiksPwZOm/E
         UyzFHgFqqK7ebidXXjuCLYQvt0B+49jtWhGX8lfIxfJ2K3gWh2sPx9okR8lZA8QmHkDw
         Ew2goibwZxYC/jaURdY6W7tjxLFLyK9cbu+i7h9d9C2ySri5T587OXHav/oj7KHOh7NH
         kZQfVxHkZMIe/n4cvf28aw+nHQaHdyv7SDvf2rhNP0rzQ2a6onph+UNu13oy8NV12KjJ
         jCJ5T2WVUSVaUblqhY06pQ1A5dlx+FnLFKhVEeCjkVGdqTi0NR8FZQgCezRSPmdqIR+9
         fO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980744; x=1685572744;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDcqkpeJ9FpMbQTWstGL4y3ofdnJwgu6ymAgZ8epW6o=;
        b=D3vrNYA+5N9bXxMU8U8C07lUuZUQtd3y84jYzrpXKzNApf9izo3guyihO6BdppU8YO
         A8hZGnsDxeLcgFd2Uf2DwzR7TiHQ9+ZwnTpVMjQ6y4W9R8RjaFHE9opYc6cVeB0aOnIp
         Da+PuyRXOHJQlEzZPkAtbT6PRhbJuh+Ix9aRn0RNPUNZjj4WwwfQEV/NgjH2Ybkn4NCh
         mEMPva4O9XcyR7YyJwmaZUTu/9iaZL1r8326+wXWGL02aOZDyq+w01foqgNVNrk0Oa+/
         7HARtPLscD+TuzSIbALEpdaSCG8YrJ9d/JoiVo5+CM3uruuDYd5ZKnLzYzh2UnT6lv42
         lYBQ==
X-Gm-Message-State: AC+VfDxrXw86ifi1VASc/nW6H+fO/xpC1LTKyWzjsWLklqkxUqYBvtfB
        6ADZxNrG/fGm42P7tcFAR7g0hg==
X-Google-Smtp-Source: ACHHUZ4uzpVYGn1QuMBUFloz15JnhhnmPdDLfnK1iDkKpZhF3dUFxkXHjZjLYAPO3NytY8xwZcUH5g==
X-Received: by 2002:a05:6a20:8e0b:b0:f3:756e:e116 with SMTP id y11-20020a056a208e0b00b000f3756ee116mr20052389pzj.38.1682980744168;
        Mon, 01 May 2023 15:39:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:ec67:e52b:8070:1b56? ([2601:647:4900:1fbb:ec67:e52b:8070:1b56])
        by smtp.gmail.com with ESMTPSA id t3-20020a056a00138300b006338e0a9728sm20413152pfg.109.2023.05.01.15.39.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 15:39:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 2/7] udp: seq_file: Remove bpf_seq_afinfo from
 udp_iter_state
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <86732f12-a53d-7d3b-9b8f-a717fd3237e2@linux.dev>
Date:   Mon, 1 May 2023 15:39:01 -0700
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A50CFC57-91E9-41E6-8237-5F07E1BE8BC4@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-3-aditi.ghag@isovalent.com>
 <86732f12-a53d-7d3b-9b8f-a717fd3237e2@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 23, 2023, at 5:18 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>> This is a preparatory commit to remove the field. The field was
>> previously shared between proc fs and BPF UDP socket iterators. As =
the
>> follow-up commits will decouple the implementation for the iterators,
>> remove the field. As for BPF socket iterator, filtering of sockets is
>> exepected to be done in BPF programs.
>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  include/net/udp.h |  1 -
>>  net/ipv4/udp.c    | 34 ++++------------------------------
>>  2 files changed, 4 insertions(+), 31 deletions(-)
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index de4b528522bb..5cad44318d71 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -437,7 +437,6 @@ struct udp_seq_afinfo {
>>  struct udp_iter_state {
>>  	struct seq_net_private  p;
>>  	int			bucket;
>> -	struct udp_seq_afinfo	*bpf_seq_afinfo;
>>  };
>>    void *udp_seq_start(struct seq_file *seq, loff_t *pos);
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index c605d171eb2d..3c9eeee28678 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2997,10 +2997,7 @@ static struct sock *udp_get_first(struct =
seq_file *seq, int start)
>>  	struct udp_table *udptable;
>>  	struct sock *sk;
>>  -	if (state->bpf_seq_afinfo)
>> -		afinfo =3D state->bpf_seq_afinfo;
>> -	else
>> -		afinfo =3D pde_data(file_inode(seq->file));
>> +	afinfo =3D pde_data(file_inode(seq->file));
>=20
> I can see how this change will work after patch 4. However, this patch =
alone cannot work independently as is. The udp bpf iter still uses the =
udp_get_{first,next} and udp_seq_stop() up-to this patch.
>=20
> First, patch 3 refactoring should be done before patch 2 here. The =
removal of 'struct udp_seq_afinfo *bpf_seq_afinfo' in patch 2 should be =
done when all the necessary refactoring is in-place first.
>=20
> Also, this afinfo is passed to udp_get_table_afinfo(). How about =
renaming udp_get_table_afinfo() to udp_get_table_seq() and having it =
take the "seq" as the arg instead. This probably will deserve another =
refactoring patch before finally removing bpf_seq_afinfo. Something like =
this (un-compiled code):
>=20
> static struct udp_table *udp_get_table_seq(struct seq_file *seq,
>                                           struct net *net)
> {
> 	const struct udp_seq_afinfo *afinfo;
>=20
>        if (st->bpf_seq_afinfo)
>                return net->ipv4.udp_table;
>=20
> 	afinfo =3D pde_data(file_inode(seq->file));
>        return afinfo->udp_table ? : net->ipv4.udp_table;
> }
>=20
> Of course, when the later patch finally removes the bpf_seq_afinfo, =
the 'if (st->bpf_seq_afinfo)' test should be replaced with the 'if =
(seq->op =3D=3D &bpf_iter_udp_seq_ops)' test.
>=20
> That will also make the afinfo dance in bpf_iter_udp_batch() in patch =
4 goes away.

Sweet! I suppose it was worth resolving a few conflicts while creating =
the new preparatory patch, especially since the refactoring simplified =
unnecessary setting of afinfo in bpf_iter_udp_batch(). The additional =
minor change that was needed was to forward declare =
bpf_iter_udp_seq_ops. And of course, the if (seq->op =3D=3D =
&bpf_iter_udp_seq_ops) check needed to be wrapped in the =
CONFIG_BPF_SYSCALL ifdef.


>=20
>>    	udptable =3D udp_get_table_afinfo(afinfo, net);
>>  @@ -3033,10 +3030,7 @@ static struct sock *udp_get_next(struct =
seq_file *seq, struct sock *sk)
>>  	struct udp_seq_afinfo *afinfo;
>>  	struct udp_table *udptable;
>>  -	if (state->bpf_seq_afinfo)
>> -		afinfo =3D state->bpf_seq_afinfo;
>> -	else
>> -		afinfo =3D pde_data(file_inode(seq->file));
>> +	afinfo =3D pde_data(file_inode(seq->file));
>>    	do {
>>  		sk =3D sk_next(sk);
>> @@ -3094,10 +3088,7 @@ void udp_seq_stop(struct seq_file *seq, void =
*v)
>>  	struct udp_seq_afinfo *afinfo;
>>  	struct udp_table *udptable;
>>  -	if (state->bpf_seq_afinfo)
>> -		afinfo =3D state->bpf_seq_afinfo;
>> -	else
>> -		afinfo =3D pde_data(file_inode(seq->file));
>> +	afinfo =3D pde_data(file_inode(seq->file));
>>    	udptable =3D udp_get_table_afinfo(afinfo, seq_file_net(seq));
>>  @@ -3415,28 +3406,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct =
bpf_iter_meta *meta,
>>    static int bpf_iter_init_udp(void *priv_data, struct =
bpf_iter_aux_info *aux)
>>  {
>> -	struct udp_iter_state *st =3D priv_data;
>> -	struct udp_seq_afinfo *afinfo;
>> -	int ret;
>> -
>> -	afinfo =3D kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
>> -	if (!afinfo)
>> -		return -ENOMEM;
>> -
>> -	afinfo->family =3D AF_UNSPEC;
>> -	afinfo->udp_table =3D NULL;
>> -	st->bpf_seq_afinfo =3D afinfo;
>> -	ret =3D bpf_iter_init_seq_net(priv_data, aux);
>> -	if (ret)
>> -		kfree(afinfo);
>> -	return ret;
>> +	return bpf_iter_init_seq_net(priv_data, aux);
>=20
> Nice simplification with the bpf_seq_afinfo cleanup.
>=20
>>  }
>>    static void bpf_iter_fini_udp(void *priv_data)
>>  {
>> -	struct udp_iter_state *st =3D priv_data;
>> -
>> -	kfree(st->bpf_seq_afinfo);
>>  	bpf_iter_fini_seq_net(priv_data);
>>  }

