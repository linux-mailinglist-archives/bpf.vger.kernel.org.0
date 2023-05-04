Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D56F629F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 03:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEDBZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 21:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEDBZ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 21:25:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605DE8
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 18:25:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so6554243b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 18:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683163527; x=1685755527;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw/s0eP91GDKpGCVxkHT9uuUiHifLxmRjxFAYYXvaY8=;
        b=E5Pc80v7YQPxbm39RbS7T57OKc4rolXwRteIKdSLxPc2XfDDMTyItZ6Tlauy1MXZOQ
         QxqKmlVCNsnYA4czkrLNDuqOH6qXJM0A0mCFoFWxzBZgxdY0n5sveYPgzaOiHcqbp5UU
         yIcbqIHSs/W8bMuFpnUIbUueIqzC0ZeoDcAfdTxUYVIGd3dZlUXcsSJ2fxsYm/txlZMP
         OHdxAexm7q03m6x4xOSlyh0pYRqFXJ7risDotVeP2R8Bzumg6CBlqIYUIOfZUWY87Tzb
         S/jEBCxdFptRUXsO/kWX7c0LZWB5gP7gzSm2EvvBp2KzgbVPkkgFCBGg9jJAUpHyuzLY
         xr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683163527; x=1685755527;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw/s0eP91GDKpGCVxkHT9uuUiHifLxmRjxFAYYXvaY8=;
        b=DD4Fk+ny1MYi4gFqIxpA4tri81fKx6gZwkY7oEQthdzJcckgFWTaTjA8vLKe6/QIi/
         CxzWdfW5k7ZtA4kDfv/whXXaPU10JEAiWI5C2KkxP/s0642yN89dLPlzljFGJbVZY5rb
         96dRzH8iyir+UjN3R5pCfyqu4y2f1OcKeuVNZkepINbNON+8E9QTqam86oNZ65z+qntz
         p4QGikb82xk6P2+BbsFA0MJZmeqfYL8Y4JmdBC7gLGiN2dKwki46lnq+wQvlXBer7Tp2
         fuiDnvgduH14cNRjHyJ5/5YKLZs4WXP2mRJwofB+dXwlQw2NKjNLCPlUW1J54qzo10FT
         p/PA==
X-Gm-Message-State: AC+VfDx2GsDxuct6AO21kBZJSV3OwnZixFTTXMjPFMdHoaldQ70OTGGS
        8yVIt8eu/AgO6P+1xOrtxvFY2Q==
X-Google-Smtp-Source: ACHHUZ5n+JFW5YlifvmyHmYVshc71SzlF/DBb5E4Hfxver7PSva5jOiau4o/e2umubr2iAyWIrTM0A==
X-Received: by 2002:a05:6a20:9384:b0:f2:e4c1:af7a with SMTP id x4-20020a056a20938400b000f2e4c1af7amr689706pzh.7.1683163526678;
        Wed, 03 May 2023 18:25:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:7453:356e:9803:f62d? ([2601:647:4900:1fbb:7453:356e:9803:f62d])
        by smtp.gmail.com with ESMTPSA id om8-20020a17090b3a8800b002471deb13fcsm2041494pjb.6.2023.05.03.18.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 18:25:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v7 bpf-next 04/10] udp: seq_file: Remove bpf_seq_afinfo
 from udp_iter_state
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <20230503225351.3700208-5-aditi.ghag@isovalent.com>
Date:   Wed, 3 May 2023 18:25:25 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73779BBC-48BB-4FE9-A673-36EA3DD79068@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-5-aditi.ghag@isovalent.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 3, 2023, at 3:53 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
> This is a preparatory commit to remove the field. The field was
> previously shared between proc fs and BPF UDP socket iterators. As the
> follow-up commits will decouple the implementation for the iterators,
> remove the field. As for BPF socket iterator, filtering of sockets is
> exepected to be done in BPF programs.
>=20
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
> include/net/udp.h |  1 -
> net/ipv4/udp.c    | 25 +++++--------------------
> 2 files changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..5cad44318d71 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,7 +437,6 @@ struct udp_seq_afinfo {
> struct udp_iter_state {
> 	struct seq_net_private  p;
> 	int			bucket;
> -	struct udp_seq_afinfo	*bpf_seq_afinfo;
> };
>=20
> void *udp_seq_start(struct seq_file *seq, loff_t *pos);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c426ebafeb13..9f8c1554a9e4 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2993,14 +2993,16 @@ static bool seq_sk_match(struct seq_file *seq, =
const struct sock *sk)
> 		net_eq(sock_net(sk), seq_file_net(seq)));
> }
>=20
> +static const struct seq_operations bpf_iter_udp_seq_ops;

>> net/ipv4/udp.c:3001:36: warning: 'bpf_iter_udp_seq_ops' defined but =
not used [-Wunused-const-variable=3D]
   3001 | static const struct seq_operations bpf_iter_udp_seq_ops;
        |                                    ^~~~~~~~~~~~~~~~~~~~

This would have to be wrapped with ifdef too.=20

> static struct udp_table *udp_get_table_seq(struct seq_file *seq,
> 					   struct net *net)
> {
> -	const struct udp_iter_state *state =3D seq->private;
> 	const struct udp_seq_afinfo *afinfo;
>=20
> -	if (state->bpf_seq_afinfo)
> +#ifdef CONFIG_BPF_SYSCALL
> +	if (seq->op =3D=3D &bpf_iter_udp_seq_ops)
> 		return net->ipv4.udp_table;
> +#endif
>=20
> 	afinfo =3D pde_data(file_inode(seq->file));
> 	return afinfo->udp_table ? : net->ipv4.udp_table;
> @@ -3424,28 +3426,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta =
*meta,
>=20
> static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info =
*aux)
> {
> -	struct udp_iter_state *st =3D priv_data;
> -	struct udp_seq_afinfo *afinfo;
> -	int ret;
> -
> -	afinfo =3D kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
> -	if (!afinfo)
> -		return -ENOMEM;
> -
> -	afinfo->family =3D AF_UNSPEC;
> -	afinfo->udp_table =3D NULL;
> -	st->bpf_seq_afinfo =3D afinfo;
> -	ret =3D bpf_iter_init_seq_net(priv_data, aux);
> -	if (ret)
> -		kfree(afinfo);
> -	return ret;
> +	return bpf_iter_init_seq_net(priv_data, aux);
> }
>=20
> static void bpf_iter_fini_udp(void *priv_data)
> {
> -	struct udp_iter_state *st =3D priv_data;
> -
> -	kfree(st->bpf_seq_afinfo);
> 	bpf_iter_fini_seq_net(priv_data);
> }
>=20
> --=20
> 2.34.1
>=20

