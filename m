Return-Path: <bpf+bounces-5838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C369761E01
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D504428184D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021424171;
	Tue, 25 Jul 2023 16:05:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FA23BF1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:05:23 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFC2126
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:05:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so8178529a12.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690301120; x=1690905920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH0UOML51M3rzwv+c9agQ57fZhEB1eqJ8k22Sw4zh88=;
        b=fvwGsJ4deZaSdRS0WEEc/DU17C9RupWojGXZqRKAIegkk3FEDs/vKLpa1le3heKqJg
         D0SdBtn155BDQcrjvLU1hniWPy0xji9H7b3z1e3YeKjxSrPN2B1MNE1prqJ6NuWjWhNj
         YbKgKEFnwxKwnlkdd+4HiQ9r2jbWFM94vNVvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301120; x=1690905920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH0UOML51M3rzwv+c9agQ57fZhEB1eqJ8k22Sw4zh88=;
        b=E0MPzo5pcbH7qgTS3FjIphAhdGXc5H7UlNCCd9raclPnM4fsZQFWjpPfvc6CNB8MAg
         soBN2AzYuSWS2N6tKyG84FfC3SlWBzhZl/cENcudwNRJezkQjyFm9hznCklES6dUpA3d
         KeiPh7dT5KLjDetIxoozX2P9Um6c6i4OT2Lbf81pWImZ4hnhqT1Wd5w9erltvwu/7zUv
         A37WbUaTuZtqT6Q0nQZzckzL7x6FCxicoC9P2vrFiL1JoZyf1BnhzTB1cfTyKkQOU3NT
         JEeZmHP9E/YQ+ZwZQ5o4Ld2S1I9+4vKanM69a6LSoYruXRuFgH1tpKqMWvCN5Wtx+pHa
         NRhA==
X-Gm-Message-State: ABy/qLbGVRqxoByz51yfuoGtCExujH1IlVBAE6osL7Ze5NpO95SXh4uC
	XleNPI9bBOt7J1A/LfasYLFcMd/rZgUthtoUGnHAzw==
X-Google-Smtp-Source: APBJJlEWZ7FthedJ/K8TlghQ+twETLA0S14CEzVsK8NOJaM+n2EP98O8bZPM+8WHddigaspFbbCuGd95A37WDSbWNNk=
X-Received: by 2002:a17:906:105d:b0:991:eb77:74e with SMTP id
 j29-20020a170906105d00b00991eb77074emr11339234ejj.76.1690301120091; Tue, 25
 Jul 2023 09:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690255889.git.yan@cloudflare.com> <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
 <87v8e8xsih.fsf@cloudflare.com>
In-Reply-To: <87v8e8xsih.fsf@cloudflare.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 25 Jul 2023 11:05:09 -0500
Message-ID: <CAO3-Pbp=VsQVZxvX3MZGhjLsG93r7CPyhe8jBJ-Bt1bJOEtqTQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jordan Griege <jgriege@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 4:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Mon, Jul 24, 2023 at 09:13 PM -07, Yan Zhai wrote:
> > skb_do_redirect returns various of values: error code (negative), 0
> > (success), and some positive status code, e.g. NET_XMIT_CN, NET_RX_DROP=
.
> > Such code are not handled at lwt xmit hook in function ip_finish_output=
2
> > and ip6_finish_output, which can cause unexpected problems. This change
> > converts the positive status code to proper error code.
> >
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >
> > ---
> > v3: converts also RX side return value in addition to TX values
> > v2: code style change suggested by Stanislav Fomichev
> > ---
> >  net/core/filter.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 06ba0e56e369..3e232ce11ca0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2095,7 +2095,12 @@ static const struct bpf_func_proto bpf_csum_leve=
l_proto =3D {
> >
> >  static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff =
*skb)
> >  {
> > -     return dev_forward_skb_nomtu(dev, skb);
> > +     int ret =3D dev_forward_skb_nomtu(dev, skb);
> > +
> > +     if (unlikely(ret > 0))
> > +             return -ENETDOWN;
> > +
> > +     return 0;
> >  }
> >
> >  static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
> > @@ -2106,6 +2111,8 @@ static inline int __bpf_rx_skb_no_mac(struct net_=
device *dev,
> >       if (likely(!ret)) {
> >               skb->dev =3D dev;
> >               ret =3D netif_rx(skb);
> > +     } else if (ret > 0) {
> > +             return -ENETDOWN;
> >       }
> >
> >       return ret;
> > @@ -2129,6 +2136,9 @@ static inline int __bpf_tx_skb(struct net_device =
*dev, struct sk_buff *skb)
> >       ret =3D dev_queue_xmit(skb);
> >       dev_xmit_recursion_dec();
> >
> > +     if (unlikely(ret > 0))
> > +             ret =3D net_xmit_errno(ret);
> > +
> >       return ret;
> >  }
>
> net_xmit_errno maps NET_XMIT_DROP to -ENOBUFS. It would make sense to me
> to map NET_RX_DROP to -ENOBUFS as well, instead of -ENETDOWN, to be
> consistent.
>
In fact I looked at all those errno, but found none actually covers
this situation completely. For the redirect ingress case, there are
three reasons to fail: backlog full, dev down, and MTU issue. This
won't be a problem for typical RX paths, since the error code is
usually discarded by call sites of deliver_skb. But redirect ingress
opens a call chain that would propagate this error to local sendmsg,
which may be very confusing to troubleshoot in a complex environment
(especially when backlog fills).

That said I agree ENOBUF covers the most likely reason to fail
(backlog). Let me change to that one in the next version if there are
no new suggestions.

> It looks like the Fixes tag for this should point to the change that
> introduced BPF for LWT:
>
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
>
Thanks for finding the tag. I was debating if it should be LWT commit
or bpf_redirect commit: the error is not handled at LWT, but it seems
actually innocent. The actual fix is the return value from the bpf
redirect code. Let me incorporate both in the next one to justify
better.

--
Yan

