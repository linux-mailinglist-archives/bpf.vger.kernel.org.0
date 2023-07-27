Return-Path: <bpf+bounces-6101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C45765BF4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 21:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1146B282310
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15B1AA8D;
	Thu, 27 Jul 2023 19:16:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926501989F;
	Thu, 27 Jul 2023 19:16:06 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A52735;
	Thu, 27 Jul 2023 12:16:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-267f8f36a3cso836203a91.2;
        Thu, 27 Jul 2023 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690485364; x=1691090164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dID8NeabSHsX05XePj2pj/qvoOM/hy2hl2C7bgvnd6Q=;
        b=OlJmul22CWmxmKQyZwAmojqt7OH591SEnUtxWzeOTbRFOOt2l3pQlJEasuyGHj9RD3
         8X7/Fg65Jix7XBWBMIU/ee2ogSi1dnfHmUazeqwAvJ6IWicNVXjQsPIlri5axUr57y5O
         6D8+ajJV2u+cKyObOyIyX7f+xAXFxQVnlRpFlw335dqa3acZVmJGSUD6ArsmdDTodlTU
         52h0cSxfRSpu943/W8pR4DaC/npOB0wS7I0uwEwNPswJNVzo5La3AK8vSaQzGjxWpF3T
         2ND/m27pvDEuHS0Cbu9RjIptmwLJ9Xxw1sjE10AwukwVTix+thPYn2Hwxs45cYk7FV8A
         4E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485364; x=1691090164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dID8NeabSHsX05XePj2pj/qvoOM/hy2hl2C7bgvnd6Q=;
        b=IlJK1QGfzw8DDx6j/cEHNt7AKMBv7BrtHsObSunixwj/ZwXIYkUtcA7xnidyfNWwfP
         x/plCCZ5T3Lrh4hAPvqKg9fJvHFbuWewMQo7p3RT4NvzsO9eWEI1Q8wbejT8RQiH91Nl
         pa7ciFmLWSW3GrtGK6UfIQk1NKce7ulySTnZ0EOQePb4ELE7Lj5yW4zxAhqlHJ4Xu4Ph
         0balBh5Yyn8rGz9F/6uPPE0gUbfkruj+X45HC2TRHzZ56a2Jnbshg/tJbRNszhY2M/aU
         rxE+aDBlHUUEFI3a2Cz0TFb70mWBqnGJ7BlCEJa9XUrcBQPE0ji+K1be92IC1T5bu8l6
         xNYw==
X-Gm-Message-State: ABy/qLYuwQ61gjBWhqfnvmiWsnqwLGuvkzbzVCC//OCadrjseTeAk8ig
	hx+4uX5poESSQXNP40FFe3Y=
X-Google-Smtp-Source: APBJJlGRJ6kgWY3B0JuC7JNvsEnptYN4e9RQNs80fEcAIYq4rGRyxlw3GIlPdl7RUNW1q/WFV9QlOg==
X-Received: by 2002:a17:90a:948a:b0:268:1c7f:c041 with SMTP id s10-20020a17090a948a00b002681c7fc041mr191328pjo.29.1690485363769;
        Thu, 27 Jul 2023 12:16:03 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:705d:54ca:a48d:47da])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ade8c00b00263ba6a248bsm3112835pjv.1.2023.07.27.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:16:03 -0700 (PDT)
Date: Thu, 27 Jul 2023 12:16:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <64c2c272c111_831d20880@john.notmuch>
In-Reply-To: <CANn89i+DuhGRXj9U-iXcEA__j6jvV5FC+tLNkGBCSqMCPpuFaA@mail.gmail.com>
References: <20230726142029.2867663-1-liujian56@huawei.com>
 <20230726142029.2867663-2-liujian56@huawei.com>
 <CANn89i+DuhGRXj9U-iXcEA__j6jvV5FC+tLNkGBCSqMCPpuFaA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] net: introduce __sk_rmem_schedule() helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> On Wed, Jul 26, 2023 at 4:15=E2=80=AFPM Liu Jian <liujian56@huawei.com>=
 wrote:
> >
> > Compared with sk_wmem_schedule(), sk_rmem_schedule() not only perform=
s
> > rmem accounting, but also checks skb_pfmemalloc. The __sk_rmem_schedu=
le()
> > helper function is introduced here to perform only rmem accounting re=
lated
> > activities.
> >
> =

> Why not care about pfmemalloc ? Why is it safe ?
> =

> You need to give more details, or simply reuse the existing helper.

I would just use the existing helper. Seems it should be fine.

> =

> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> >  include/net/sock.h | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 2eb916d1ff64..58bf26c5c041 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1617,16 +1617,20 @@ static inline bool sk_wmem_schedule(struct so=
ck *sk, int size)
> >         return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_SE=
ND);
> >  }
> >
> > -static inline bool
> > -sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> > +static inline bool __sk_rmem_schedule(struct sock *sk, int size)
> >  {
> >         int delta;
> >
> >         if (!sk_has_account(sk))
> >                 return true;
> >         delta =3D size - sk->sk_forward_alloc;
> > -       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RE=
CV) ||
> > -               skb_pfmemalloc(skb);
> > +       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RE=
CV);
> > +}
> > +
> > +static inline bool
> > +sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> > +{
> > +       return __sk_rmem_schedule(sk, size) || skb_pfmemalloc(skb);
> >  }
> >
> >  static inline int sk_unused_reserved_mem(const struct sock *sk)
> > --
> > 2.34.1
> >



