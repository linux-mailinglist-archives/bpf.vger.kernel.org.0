Return-Path: <bpf+bounces-7871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207377D8CD
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 05:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37751C20EFE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC7443E;
	Wed, 16 Aug 2023 03:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC84436
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 03:05:27 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2418213A
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 20:05:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso3635005a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692155122; x=1692759922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/OujIT0jxf+5BDX0+E36B0F/F+GOKL3nvQV3CsdKI4=;
        b=CrQZFn1ywrQDkiBUuLXulYkEgJ+unOlslsSZJ4usIYL5Vg2x8x3jWS0pURE4b11nL9
         C9vRCAQO2Fp2mv8pAxrQJ2Uj8QWWuvu2EG1ReBLPeVa+vzZcIaFtDo0WzGx0gsBNXp0e
         7RFkjg9L4FWq01/XMlNFblKroxaj/7e/u+Yes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692155122; x=1692759922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/OujIT0jxf+5BDX0+E36B0F/F+GOKL3nvQV3CsdKI4=;
        b=iHqc7lrP8Gx3YKlD8B+5Q0aW58bu/ayDAnflOtXmfc8bdj+6iP+/btB7Wldv3p7r2f
         6a/oxJu61nTsxqu1v93BifRv6pO+hzkOD1c3USmUagdeEB7v0Ufi2g1eJq2rZxjI1/g7
         bUBl3qtGhe4e3qLAtETSCvQABWiWPgBggNZJOhmn7N0Vx/I3HjkKzd83iVkxUjvJAmn6
         EvUQzj6cI7ucvsfJJ4iuBseCromN4ikmPCek1aN695OibEV80KK5ykEDkyUWAMB1XEmH
         H5L3sYgQNoZk92iJSx+ezTwHMplz7eTqdoWW06mtwazpBNHPNEEdY8TUBwwtWCJesYwR
         lgZA==
X-Gm-Message-State: AOJu0YzjfXiQHeozYd2W2aRlQeFgNniuxh7VJ93NNcmUCHGcIWSJNChj
	jhVsuhZjSafO3Uh7kIIJyjwVair7AFvz6+QnWVEtwaGX55XSijGp8ec=
X-Google-Smtp-Source: AGHT+IGKd4RWtdx0Juy2+DvViRPNu4UtDndxFhhFK9zwn2YdOyer2b+dqPt4/w+m/A1LWUkcRVruB838yxBBqZa4Mv8=
X-Received: by 2002:aa7:df0a:0:b0:522:1e2f:fa36 with SMTP id
 c10-20020aa7df0a000000b005221e2ffa36mr495323edy.28.1692155122126; Tue, 15 Aug
 2023 20:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692153515.git.yan@cloudflare.com> <28cb906436e87eada712f55e63ae5c420bea0ecb.1692153515.git.yan@cloudflare.com>
In-Reply-To: <28cb906436e87eada712f55e63ae5c420bea0ecb.1692153515.git.yan@cloudflare.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 15 Aug 2023 22:05:11 -0500
Message-ID: <CAO3-Pbo9rx_8GS2V8f4hwAzrJ00UC=g1NjCNx2ymnHWSXmUmvA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 1/4] lwt: fix return values of BPF ops
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Jordan Griege <jgriege@cloudflare.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 9:54=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> BPF encap ops can return different types of positive values, such like
> NET_RX_DROP, NET_XMIT_CN, NETDEV_TX_BUSY, and so on, from function
> skb_do_redirect and bpf_lwt_xmit_reroute. At the xmit hook, such return
> values would be treated implicitly as LWTUNNEL_XMIT_CONTINUE in
> ip(6)_finish_output2. When this happens, skbs that have been freed would
> continue to the neighbor subsystem, causing use-after-free bug and
> kernel crashes.
>
> To fix the incorrect behavior, skb_do_redirect return values can be
> simply discarded, the same as tc-egress behavior. On the other hand,
> bpf_lwt_xmit_reroute returns useful errors to local senders, e.g. PMTU
> information. Thus convert its return values to avoid the conflict with
> LWTUNNEL_XMIT_CONTINUE.
>
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Reported-by: Jordan Griege <jgriege@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> * v5: discards skb_do_redirect return instead; convert
>       bpf_lwt_xmit_reroute return;
> * v4: minor commit message changes
> * v3: converts skb_do_redirect statuses from both ingress and egress
> * v2: code style amend
> ---
>  net/core/lwt_bpf.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index 8b6b5e72b217..4a0797f0a154 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -60,9 +60,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_=
lwt_prog *lwt,
>                         ret =3D BPF_OK;
>                 } else {
>                         skb_reset_mac_header(skb);
> -                       ret =3D skb_do_redirect(skb);
> -                       if (ret =3D=3D 0)
> -                               ret =3D BPF_REDIRECT;
> +                       skb_do_redirect(skb);
> +                       ret =3D BPF_REDIRECT;
>                 }
>                 break;
>
> @@ -255,7 +254,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
>
>         err =3D dst_output(dev_net(skb_dst(skb)->dev), skb->sk, skb);
>         if (unlikely(err))
> -               return err;
> +               return net_xmit_errno(err);
>
>         /* ip[6]_finish_output2 understand LWTUNNEL_XMIT_DONE */
>         return LWTUNNEL_XMIT_DONE;
> --
> 2.30.2
>

no idea why this one would appear nested and without subject on the
lore link. Let me double check what goes wrong with my mutt setting :(

--
Yan

