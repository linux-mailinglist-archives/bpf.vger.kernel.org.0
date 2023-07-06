Return-Path: <bpf+bounces-4193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D78749723
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648602811EB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41151C39;
	Thu,  6 Jul 2023 08:11:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C91865
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:11:29 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD51982
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:11:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98df3dea907so47771166b.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688631085; x=1691223085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR6/NdGhfGVRMDtpOrjbuplZoyHhi/ChIQZtoi6zZTM=;
        b=STeCHpX3+OlrnWY3WHP0ldhz/3Dei+0SvJf+VJ/vKyNlNYR5mxb/jzlfqnh3YOI8l2
         lvS4yjOBUsAiv4JLee7tYzvnDKwPF7y4daVoRvzsV25v1QHwnBBYrCyLRQHTYCdNUVv8
         ahUTnrUITZOQBmkvHNfOl8N44YhyARcyNJebNEOux9U7ELzZcfNaTBNAqUHGn7laHYwX
         BV1yqj2GH/9kkU7yqj874NhbwmMHza3f2n3RZyXrLpMO8eeOGqnFbfDV1DOTAQ91T5Io
         6eQ/Hcubz+xwtI9dIMWlhGyfbd5u4qsP5vFL6pjSCZYexwnl+f4VOYG78uqcFH3spGCA
         v+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631085; x=1691223085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR6/NdGhfGVRMDtpOrjbuplZoyHhi/ChIQZtoi6zZTM=;
        b=Sw5WCorjGxgeFkuc+I5PVkgP4tIBAxt2DFW4kgYDY7kYYZArDZu2kEournje49JeRE
         zG2KkLc8ib+T8bIA+cJY4hLvxi8UH2DmdXGKCc5Jg0oOb2zKwM9sBJRAlrk46ksA9MKs
         DilWISeK0nPOT6l+pzdLv4Wdn5Eqg8oN1WxIiVi5l5I3iH2oQXlc8hRHgMLnUaoj6Fyl
         IwQKIyloJ4Fl9SSDyiK1uxVy2P7srEbR66fBYC0j9m2WsLMJC9TPaxZuaDNnpELFkgmU
         5MZvPoPurUwmWb4UvofCPPjOgsVan5WYgtNwfnfWYyQjHSnveubLJ5JkVvreRpoELR28
         9+EQ==
X-Gm-Message-State: ABy/qLbaUt9XoOSsUcXnWNO71tYRKjXl+tv5tRB9EvT7amSnjOgzEjbV
	zRZF/tta2T6IMNl3M+Ydr+V3gEx9b44Nd3RUEde2pMw8QsVxjwLrsKqiEQ==
X-Google-Smtp-Source: APBJJlE7PccGGrOEgGPylmn7X0xxlAVv/W3p/wr9Xc8JG/2oayfRgYAidUKjr1Mm+9mxFiTLT3YLDAVus5yzbeLzFqM=
X-Received: by 2002:a17:906:9e13:b0:992:b928:adb3 with SMTP id
 fp19-20020a1709069e1300b00992b928adb3mr756365ejc.54.1688631085659; Thu, 06
 Jul 2023 01:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8hLXYZuNFG+=J-FWLXWhbwT5TrHjMg5VzjQhv2NBo5VaA@mail.gmail.com>
 <20230706004044.79850-1-kuniyu@amazon.com>
In-Reply-To: <20230706004044.79850-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 6 Jul 2023 09:11:15 +0100
Message-ID: <CAN+4W8iRH6kpDmmY8i5r1nKbckaYghmOCqRXe+4bDHE7vzVMMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, joe@cilium.io, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 1:41=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Sorry for late reply.
>
> What we know about sk before inet6?_lookup_reuseport() are
>
>   (1) sk was full socket in bpf_sk_assign()
>   (2) sk had SOCK_RCU_FREE in bpf_sk_assign()
>   (3) sk was TCP_LISTEN here if TCP

Are we looking at the same bpf_sk_assign? Confusingly there are two
very similarly named functions. The one we care about is:

BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, fl=
ags)
{
    if (!sk || flags !=3D 0)
        return -EINVAL;
    if (!skb_at_tc_ingress(skb))
        return -EOPNOTSUPP;
    if (unlikely(dev_net(skb->dev) !=3D sock_net(sk)))
        return -ENETUNREACH;
    if (sk_is_refcounted(sk) &&
        unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
        return -ENOENT;

    skb_orphan(skb);
    skb->sk =3D sk;
    skb->destructor =3D sock_pfree;

    return 0;
}

From this we can't tell what state the socket is in or whether it is
RCU freed or not.

Thanks
Lorenz

