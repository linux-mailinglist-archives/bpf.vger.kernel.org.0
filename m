Return-Path: <bpf+bounces-17044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E88809336
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081AFB20DCC
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD856395;
	Thu,  7 Dec 2023 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoPSG3d3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11271738;
	Thu,  7 Dec 2023 13:21:23 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-46480378d3dso286649137.3;
        Thu, 07 Dec 2023 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701984083; x=1702588883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agnhrmqSR7tb+iq61mPw7X3g8ZtAUzTPmU+U4K1bhIk=;
        b=GoPSG3d3NG3aGllRgxl6uQccXjJoj8PRRokPjPJgPg4fxK3ownZ6L5QWcTUN/upQPE
         b5b28ljejjThUYVtmuO3YD3vp1NN0ddttNmsjnWLK0vvhCgEmA4jVtcBAm188WmX5R0G
         I7cWL8K3rflLBNX2pQ1cIW7FB3g+UjzAyMfaSbXlowZwCEd8B6yGgT/vbkcpmn3RhCwC
         j5lgDrM77qp/Ph8ja7EICr8mn4/G2Jq5YiGe7D2vSZXTvF4sJBUxTMNigp4oCPWjMQSa
         AVX47rtmhj3+uqVauddEIOWPxSDWaONd+5kAHd+vxEwS9VknYaIjGDKndpMhPTVJpsab
         ZlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984083; x=1702588883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agnhrmqSR7tb+iq61mPw7X3g8ZtAUzTPmU+U4K1bhIk=;
        b=RovHFKvE314ucBsN1UKI5DkV5HjBWClOw8UrMa+mDJbJKInGtN6H2C4h4tH/1RWDwR
         eOXEdAfqVMqWPbX7weVk3oKhiEsZZ4NNXTjQ4uHv+4y3wcWZwtehRCvxqqMcIH196Zir
         MlX6EKhBwIrm/yeZjx/vJ8JZJ5vMyLzkLh0J5AQ3x1MTp5yRQosfIbhn3AIZKPMVa+tV
         Gv8q6c76mYL9cHYNDyDxvmK7ESQXgVqjAujBQacEABPvENvF6HbUA9Ln2AwIjGvGr3f1
         OoGk9XRaprLuehRsnigRwodKSCgmIz3Ftg0iHhI2K0zXVwkrz/sOn+kiU3PRtChPVohZ
         yThA==
X-Gm-Message-State: AOJu0Yy15x9ZwFn8ppJZgh9K2x3L25kuM0N6wqz1I2B1EKVIAC2kZ6g7
	PN0YGIXKv2EBPjq2SPkXgih7vDJEhnGTDDxSJN6QQz4eyXwksg==
X-Google-Smtp-Source: AGHT+IGRskXcZML/yJS0bDD/sW0Pt8jLIUd/ELooW+Kd0ODnx7ev/qCRFgQI9LyUQshang1PM7bzggm4evxzqiHs53E=
X-Received: by 2002:a05:6102:e08:b0:464:7c8d:d139 with SMTP id
 o8-20020a0561020e0800b004647c8dd139mr2614217vst.16.1701984082925; Thu, 07 Dec
 2023 13:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
In-Reply-To: <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 7 Dec 2023 13:21:11 -0800
Message-ID: <CAHsH6GvRtFRRhjLoVL6HqmthGVY4KEb8EOzT61ofWyXgocD4NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/10] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	Herbert Xu <herbert@gondor.apana.org.au>, steffen.klassert@secunet.com, 
	pabeni@redhat.com, hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	edumazet@google.com, antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, eddyz87@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:57=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds an unstable kfunc helper to access internal xfrm_state
> associated with an SA. This is intended to be used for the upcoming
> IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> words: for custom software RSS.
>
> That being said, the function that this kfunc wraps is fairly generic
> and used for a lot of xfrm tasks. I'm sure people will find uses
> elsewhere over time.
>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/net/xfrm.h     |   9 ++++
>  net/xfrm/xfrm_bpf.c    | 102 +++++++++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_policy.c |   2 +
>  3 files changed, 113 insertions(+)
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index c9bb0f892f55..1d107241b901 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void=
)
>
>  #endif
>
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> +int register_xfrm_state_bpf(void);
> +#else
> +static inline int register_xfrm_state_bpf(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _NET_XFRM_H */
> diff --git a/net/xfrm/xfrm_bpf.c b/net/xfrm/xfrm_bpf.c
> index 3d3018b87f96..3d6cac7345ca 100644
> --- a/net/xfrm/xfrm_bpf.c
> +++ b/net/xfrm/xfrm_bpf.c
> @@ -6,9 +6,11 @@
>   */
>
>  #include <linux/bpf.h>
> +#include <linux/btf.h>
>  #include <linux/btf_ids.h>
>
>  #include <net/dst_metadata.h>
> +#include <net/xdp.h>
>  #include <net/xfrm.h>
>
>  #if IS_BUILTIN(CONFIG_XFRM_INTERFACE) || \
> @@ -112,3 +114,103 @@ int __init register_xfrm_interface_bpf(void)
>  }
>
>  #endif /* xfrm interface */
> +
> +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> + *
> + * Members:
> + * @error      - Out parameter, set for any errors encountered
> + *              Values:
> + *                -EINVAL - netns_id is less than -1
> + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> + *                -ENONET - No network namespace found for netns_id
> + * @netns_id   - Specify the network namespace for lookup
> + *              Values:
> + *                BPF_F_CURRENT_NETNS (-1)
> + *                  Use namespace associated with ctx
> + *                [0, S32_MAX]
> + *                  Network Namespace ID
> + * @mark       - XFRM mark to match on
> + * @daddr      - Destination address to match on
> + * @spi                - Security parameter index to match on
> + * @proto      - L3 protocol to match on
> + * @family     - L3 protocol family to match on
> + */
> +struct bpf_xfrm_state_opts {
> +       s32 error;
> +       s32 netns_id;
> +       u32 mark;
> +       xfrm_address_t daddr;
> +       __be32 spi;
> +       u8 proto;
> +       u16 family;
> +};
> +
> +enum {
> +       BPF_XFRM_STATE_OPTS_SZ =3D sizeof(struct bpf_xfrm_state_opts),
> +};
> +
> +__bpf_kfunc_start_defs();
> +
> +/* bpf_xdp_get_xfrm_state - Get XFRM state
> + *
> + * Parameters:
> + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> + *                 Cannot be NULL
> + * @opts       - Options for lookup (documented above)
> + *                 Cannot be NULL
> + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> + */
> +__bpf_kfunc struct xfrm_state *
> +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *o=
pts, u32 opts__sz)
> +{
> +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +       struct net *net =3D dev_net(xdp->rxq->dev);
> +       struct xfrm_state *x;
> +
> +       if (!opts || opts__sz < sizeof(opts->error))
> +               return NULL;
> +
> +       if (opts__sz !=3D BPF_XFRM_STATE_OPTS_SZ) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (opts->netns_id >=3D 0) {
> +               net =3D get_net_ns_by_id(net, opts->netns_id);
> +               if (unlikely(!net)) {
> +                       opts->error =3D -ENONET;
> +                       return NULL;
> +               }
> +       }
> +
> +       x =3D xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> +                             opts->proto, opts->family);
> +
> +       if (opts->netns_id >=3D 0)
> +               put_net(net);

Maybe opts->error should be set to something like -ENOENT if x =3D=3D NULL?

> +
> +       return x;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_SET8_START(xfrm_state_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
> +BTF_SET8_END(xfrm_state_kfunc_set)
> +
> +static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &xfrm_state_kfunc_set,
> +};
> +
> +int __init register_xfrm_state_bpf(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +                                        &xfrm_state_xdp_kfunc_set);
> +}
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index c13dc3ef7910..1b7e75159727 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
>  #ifdef CONFIG_XFRM_ESPINTCP
>         espintcp_init();
>  #endif
> +
> +       register_xfrm_state_bpf();
>  }
>
>  #ifdef CONFIG_AUDITSYSCALL
> --
> 2.42.1
>
>

