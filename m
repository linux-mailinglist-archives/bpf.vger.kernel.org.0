Return-Path: <bpf+bounces-7977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E377F604
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5B1281F0D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56B13FE2;
	Thu, 17 Aug 2023 12:06:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55713AD4;
	Thu, 17 Aug 2023 12:06:12 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1848358A;
	Thu, 17 Aug 2023 05:05:39 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31768ce2e81so6710384f8f.1;
        Thu, 17 Aug 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273923; x=1692878723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BATh9BCUXTXjOTlp5BMzJMO8Pk8Q21V+nPrBdrCFaD8=;
        b=YDPEOr4eZ9a50preH0/GLikwRIB1cyPxeBbhFC+4LFwq8c9//LcyJonHXyzy2YVeiz
         NVh7/AwY9C4GJyU5wH8lsTbJ4/AlIwr095XmIYWxUVGw4LiUBqqcUjJk/X8rGecbprTd
         uGjP7u4xOAZ1BHM2sKEJy9kIKTjDdWetMh5RJlBl3edUg90vdIEAgxxL/KMXJ9P+3im/
         onNuQcQMQaKiuNnLwNTm6sUfNW8fFTg/+Thcu6IJiihRGN5VCMXR6e9GxwEA13dLA7pL
         Neel4TMpZGvwys9RfI+A2VENrlemqC2fzYx2Fd9tEutdHMgrLbtJ/H3fI7BXHO4iNcA3
         ZjEw==
X-Gm-Message-State: AOJu0YxjnR/IozJfEb2MuGjf2ee0WcHYUA7lMVDBsZOrfq2YaxN9lMaF
	ggMM9uXAvLMuQWFL1Eq/GqY=
X-Google-Smtp-Source: AGHT+IEMs5MMOgBXlgxVaReffAguiab6DhQm06d/QfsHhcKgObAMCCHM4WY/Mq/2mWt0TbihI8YUvg==
X-Received: by 2002:a5d:6e5d:0:b0:314:15a8:7879 with SMTP id j29-20020a5d6e5d000000b0031415a87879mr3585687wrz.34.1692273922527;
        Thu, 17 Aug 2023 05:05:22 -0700 (PDT)
Received: from [10.148.84.122] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id f14-20020adffcce000000b00317a04131c5sm24510974wrs.57.2023.08.17.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:05:21 -0700 (PDT)
Message-ID: <c1ba1a3235464b8306a22c050225332fa3929a10.camel@inf.elte.hu>
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY
 flag for skmsg redirect
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Liu Jian <liujian56@huawei.com>, john.fastabend@gmail.com, 
 jakub@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 17 Aug 2023 14:05:20 +0200
In-Reply-To: <20230811093237.3024459-2-liujian56@huawei.com>
References: <20230811093237.3024459-1-liujian56@huawei.com>
	 <20230811093237.3024459-2-liujian56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Liu!

On Fri, 2023-08-11 at 17:32 +0800, Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward
> packets
> and no other operation, the execution result of the
> BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only
> needs to
> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.

Did you considered other names for this flag e.g. BPF_F_SPLICED or
BPF_F_PIPED?

BTW good addition, makes sense for the skb case too.

>=20
> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
>=20
> Test results using netperf=C2=A0 TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m
> -S 100m,100m
> done
>=20
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34
> 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56
> 55211.00 54566.85
>=20
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> =C2=A0include/linux/skmsg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 +++++--
> =C2=A0net/core/skmsg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0net/core/sock_map.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0net/ipv4/tcp_bpf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++------
> =C2=A0tools/include/uapi/linux/bpf.h |=C2=A0 7 +++++--
> =C2=A06 files changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 054d7911bfc9..b2da9c432f52 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -82,6 +82,7 @@ struct sk_psock {
> =C2=A0	u32				cork_bytes;
> =C2=A0	u32				eval;
> =C2=A0	bool				redir_ingress; /* undefined
> if sk_redir is null */
> +	bool				eval_permanently;
> =C2=A0	struct sk_msg			*cork;
> =C2=A0	struct sk_psock_progs		progs;
> =C2=A0#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..cf622ea4f018 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3004,7 +3004,8 @@ union bpf_attr {
> =C2=A0 *=C2=A0		egress interfaces can be used for redirection. The
> =C2=A0 *=C2=A0		**BPF_F_INGRESS** value in *flags* is used to make
> the
> =C2=A0 *=C2=A0		distinction (ingress path is selected if the flag is
> present,
> - *=C2=A0		egress path otherwise). This is the only flag
> supported for now.
> + *=C2=A0		egress path otherwise). The **BPF_F_PERMANENTLY**
> value in
> + *		*flags* is used to indicates whether the eBPF result
> is permanent.
> =C2=A0 *=C2=A0	Return
> =C2=A0 *=C2=A0		**SK_PASS** on success, or **SK_DROP** on error.
> =C2=A0 *
> @@ -3276,7 +3277,8 @@ union bpf_attr {
> =C2=A0 *		egress interfaces can be used for redirection. The
> =C2=A0 *		**BPF_F_INGRESS** value in *flags* is used to make
> the
> =C2=A0 *		distinction (ingress path is selected if the flag is
> present,
> - *		egress path otherwise). This is the only flag
> supported for now.
> + *		egress path otherwise). The **BPF_F_PERMANENTLY**
> value in
> + *		*flags* is used to indicates whether the eBPF result
> is permanent.
> =C2=A0 *	Return
> =C2=A0 *		**SK_PASS** on success, or **SK_DROP** on error.
> =C2=A0 *
> @@ -5872,6 +5874,7 @@ enum {
> =C2=A0/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
> =C2=A0enum {
> =C2=A0	BPF_F_INGRESS			=3D (1ULL << 0),
> +	BPF_F_PERMANENTLY		=3D (1ULL << 1),
> =C2=A0};
> =C2=A0
> =C2=A0/* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key
> flags. */
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index a29508e1ff35..b2bf9b5c4252 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -875,6 +875,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct
> sk_psock *psock,
> =C2=A0	ret =3D bpf_prog_run_pin_on_cpu(prog, msg);
> =C2=A0	ret =3D sk_psock_map_verd(ret, msg->sk_redir);
> =C2=A0	psock->apply_bytes =3D msg->apply_bytes;
> +	psock->eval_permanently =3D msg->flags & BPF_F_PERMANENTLY;
> =C2=A0	if (ret =3D=3D __SK_REDIRECT) {
> =C2=A0		if (psock->sk_redir) {
> =C2=A0			sock_put(psock->sk_redir);
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 08ab108206bf..6a0c90be7f4f 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -662,7 +662,7 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *,
> msg,
> =C2=A0{
> =C2=A0	struct sock *sk;
> =C2=A0
> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
> =C2=A0		return SK_DROP;
> =C2=A0
> =C2=A0	sk =3D __sock_map_lookup_elem(map, key);
> @@ -1261,7 +1261,7 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg
> *, msg,
> =C2=A0{
> =C2=A0	struct sock *sk;
> =C2=A0
> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
> =C2=A0		return SK_DROP;
> =C2=A0
> =C2=A0	sk =3D __sock_hash_lookup_elem(map, key);
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 81f0dff69e0b..36cf2b0fa6f8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -419,8 +419,10 @@ static int tcp_bpf_send_verdict(struct sock *sk,
> struct sk_psock *psock,
> =C2=A0		if (!psock->apply_bytes) {
> =C2=A0			/* Clean up before releasing the sock lock.
> */
> =C2=A0			eval =3D psock->eval;
> -			psock->eval =3D __SK_NONE;
> -			psock->sk_redir =3D NULL;
> +			if (!psock->eval_permanently) {
> +				psock->eval =3D __SK_NONE;
> +				psock->sk_redir =3D NULL;
> +			}
> =C2=A0		}
> =C2=A0		if (psock->cork) {
> =C2=A0			cork =3D true;
> @@ -433,9 +435,15 @@ static int tcp_bpf_send_verdict(struct sock *sk,
> struct sk_psock *psock,
> =C2=A0		ret =3D tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> =C2=A0					=C2=A0=C2=A0=C2=A0 msg, tosend, flags);
> =C2=A0		sent =3D origsize - msg->sg.size;
> +		/* disable the ability when something wrong */
> +		if (unlikely(ret < 0))
> +			psock->eval_permanently =3D 0;
> =C2=A0
> -		if (eval =3D=3D __SK_REDIRECT)
> +		if (!psock->eval_permanently && eval =3D=3D
> __SK_REDIRECT) {
> =C2=A0			sock_put(sk_redir);
> +			psock->sk_redir =3D NULL;
> +			psock->eval =3D __SK_NONE;
> +		}
> =C2=A0
> =C2=A0		lock_sock(sk);
> =C2=A0		if (unlikely(ret < 0)) {
> @@ -460,8 +468,8 @@ static int tcp_bpf_send_verdict(struct sock *sk,
> struct sk_psock *psock,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (likely(!ret)) {
> -		if (!psock->apply_bytes) {
> -			psock->eval =3D=C2=A0 __SK_NONE;
> +		if (!psock->apply_bytes && !psock->eval_permanently)
> {
> +			psock->eval =3D __SK_NONE;
> =C2=A0			if (psock->sk_redir) {
> =C2=A0				sock_put(psock->sk_redir);
> =C2=A0				psock->sk_redir =3D NULL;
> @@ -540,7 +548,8 @@ static int tcp_bpf_sendmsg(struct sock *sk,
> struct msghdr *msg, size_t size)
> =C2=A0			if (psock->cork_bytes && !enospc)
> =C2=A0				goto out_err;
> =C2=A0			/* All cork bytes are accounted, rerun the
> prog. */
> -			psock->eval =3D __SK_NONE;
> +			if (!psock->eval_permanently)
> +				psock->eval =3D __SK_NONE;
> =C2=A0			psock->cork_bytes =3D 0;
> =C2=A0		}
> =C2=A0
> diff --git a/tools/include/uapi/linux/bpf.h
> b/tools/include/uapi/linux/bpf.h
> index 70da85200695..cf622ea4f018 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3004,7 +3004,8 @@ union bpf_attr {
> =C2=A0 *=C2=A0		egress interfaces can be used for redirection. The
> =C2=A0 *=C2=A0		**BPF_F_INGRESS** value in *flags* is used to make
> the
> =C2=A0 *=C2=A0		distinction (ingress path is selected if the flag is
> present,
> - *=C2=A0		egress path otherwise). This is the only flag
> supported for now.
> + *=C2=A0		egress path otherwise). The **BPF_F_PERMANENTLY**
> value in
> + *		*flags* is used to indicates whether the eBPF result
> is permanent.
> =C2=A0 *=C2=A0	Return
> =C2=A0 *=C2=A0		**SK_PASS** on success, or **SK_DROP** on error.
> =C2=A0 *
> @@ -3276,7 +3277,8 @@ union bpf_attr {
> =C2=A0 *		egress interfaces can be used for redirection. The
> =C2=A0 *		**BPF_F_INGRESS** value in *flags* is used to make
> the
> =C2=A0 *		distinction (ingress path is selected if the flag is
> present,
> - *		egress path otherwise). This is the only flag
> supported for now.
> + *		egress path otherwise). The **BPF_F_PERMANENTLY**
> value in
> + *		*flags* is used to indicates whether the eBPF result
> is permanent.
> =C2=A0 *	Return
> =C2=A0 *		**SK_PASS** on success, or **SK_DROP** on error.
> =C2=A0 *
> @@ -5872,6 +5874,7 @@ enum {
> =C2=A0/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
> =C2=A0enum {
> =C2=A0	BPF_F_INGRESS			=3D (1ULL << 0),
> +	BPF_F_PERMANENTLY		=3D (1ULL << 1),
> =C2=A0};
> =C2=A0
> =C2=A0/* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key
> flags. */

Ferenc

