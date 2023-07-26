Return-Path: <bpf+bounces-5967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4459276390B
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FC2281D96
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327F253BB;
	Wed, 26 Jul 2023 14:25:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3A253A3
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 14:25:48 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B95188
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:25:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40550136e54so377731cf.0
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690381546; x=1690986346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js5vSAWaFZ4VidzN0BY/hvjERu9+lVPgqYjIT57+gZ0=;
        b=TLQ43fRW9WLhXdLiCoIYtwVp54lOb+4b7qPtfABK6e6g+GoddpVgz1RwtFZL3+G/K6
         q9n1UxelFBPzVC80L/Y5aKNSli59euzei+hSUseguK2sxs6Ms0n09+KB6ybob78mfF3f
         7vTRHz0wOGq1zkNTsYpDwAvIgBQBm3ZXcNAYJFhRT0xnslX62gebDlqJ+4aVrcigLojp
         6UL+OtGPEuSmytj/UO9muN2SVyRHrKU9a6vpBOPVw4SlbnMRsG9Z9LDzPgNjxGFkzfK+
         47plBrI2mfkpBTNphFH3eR43gd3HGR/kgqXQNGZ8iSyttLGwZI3sfnTpYoRZSkZrmT2N
         Xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381546; x=1690986346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js5vSAWaFZ4VidzN0BY/hvjERu9+lVPgqYjIT57+gZ0=;
        b=WdNsAKgQ09ooRE9jcnWa367kW7Bqj4S4xZCVj997KoaMXHo3DnnMsNctDHnv6h28Ul
         KLKn1f30Ye/seuwllfJ6UYDEi6SN0MmolG8tJ6g9NJgLNw5plec7TYzCqbwAeCUCxTUP
         Gs2hUa/bGY8PRb7ImboQltYDxHCBwTFXirn7YNiFGMR6CW799D60knyg3rik5nhUGJHo
         39r9+MkaYAL24aqAX1Lg75Orh5juE6/384mW7aAIstI04EHQBL2Jyu+38mDsa6v+FGd0
         Q39T20AUlMDzTAkLAUbc3uTgJE1rEyeB9OWHmr0fz1ShWWb2U5T/jzz4FirA8tTp3vHF
         yUEQ==
X-Gm-Message-State: ABy/qLZjcy2b3FqRmSVaIs2NN2BMuN7fq3bUeraXMiKx2c16FEDmDJDv
	XE7Fg5n0cVByysiey91fKhsY8gdTR92dTW2DM3UivDrIjP/zK/UR1J4=
X-Google-Smtp-Source: APBJJlEDQ/+u7UDGiiJ2B4FzwviPxrtW7qeOOAOcwGlijvwfDiSir62tMQrMC+sDr90j/5YHDH32t3M77dRi4zC2dnE=
X-Received: by 2002:ac8:7d90:0:b0:403:ac9c:ac2f with SMTP id
 c16-20020ac87d90000000b00403ac9cac2fmr437111qtd.17.1690381546062; Wed, 26 Jul
 2023 07:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726142029.2867663-1-liujian56@huawei.com> <20230726142029.2867663-2-liujian56@huawei.com>
In-Reply-To: <20230726142029.2867663-2-liujian56@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 16:25:34 +0200
Message-ID: <CANn89i+DuhGRXj9U-iXcEA__j6jvV5FC+tLNkGBCSqMCPpuFaA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] net: introduce __sk_rmem_schedule() helper
To: Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:15=E2=80=AFPM Liu Jian <liujian56@huawei.com> wro=
te:
>
> Compared with sk_wmem_schedule(), sk_rmem_schedule() not only performs
> rmem accounting, but also checks skb_pfmemalloc. The __sk_rmem_schedule()
> helper function is introduced here to perform only rmem accounting relate=
d
> activities.
>

Why not care about pfmemalloc ? Why is it safe ?

You need to give more details, or simply reuse the existing helper.

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  include/net/sock.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2eb916d1ff64..58bf26c5c041 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1617,16 +1617,20 @@ static inline bool sk_wmem_schedule(struct sock *=
sk, int size)
>         return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_SEND);
>  }
>
> -static inline bool
> -sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> +static inline bool __sk_rmem_schedule(struct sock *sk, int size)
>  {
>         int delta;
>
>         if (!sk_has_account(sk))
>                 return true;
>         delta =3D size - sk->sk_forward_alloc;
> -       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) =
||
> -               skb_pfmemalloc(skb);
> +       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV);
> +}
> +
> +static inline bool
> +sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> +{
> +       return __sk_rmem_schedule(sk, size) || skb_pfmemalloc(skb);
>  }
>
>  static inline int sk_unused_reserved_mem(const struct sock *sk)
> --
> 2.34.1
>

