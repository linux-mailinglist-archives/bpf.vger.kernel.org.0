Return-Path: <bpf+bounces-2462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5172D4FA
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 01:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7787B280FEB
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0770101E7;
	Mon, 12 Jun 2023 23:32:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC730EEB9
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 23:32:13 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43744131
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 16:32:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98220bb31c6so207916466b.3
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686612728; x=1689204728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ2Zh9vr5Y3DgOJzeAyVxeFU7wE5SByHIwo1uppc+/Q=;
        b=nA/4gNLxcnnBh2fZ35Ati3rh0tM62NU+Qwhi84IrHi5lcTfzJy1J6Dt2o+bA2AEM0R
         M92mXswvwQq9bxSJZFevXuIKqGNdkMBbcDaiVWBDjcCD3uJm6sSKqWCKAkoTM30brIZW
         jfYDoElLK0laePzKDv4Otlnzf9IPuJo+hSeBtrsmvDorCeSXl8FAfUkVQe5YpV0xzjc+
         V+YY+9oGOvcTkWXOmKTDBt5CiDfc/B+jSKvN0d+lFAs4tUX5fsmpMtgjjeUyTtRBKBTL
         B8ixuHBR7Xie9aPDoZYRXP1vse+MSoXGeItuGoN0mCiK7wLNBQkcIsrQIrEF+tPox11Y
         q4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612728; x=1689204728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ2Zh9vr5Y3DgOJzeAyVxeFU7wE5SByHIwo1uppc+/Q=;
        b=VfbwBsn5YLgUl2g3Cd2oDhrrlPa+Almt0TtTYXtnfgIGswNz0picIWwwXaWdo/O0bS
         SuDypWaKSzwjUPdWK/N5RPYdu/2CrxnJyn/uuc5aWqPkQ29qSLYV00FtO4vEdQLiC40t
         hgGqcSCwppB8ScIbAeitm4w55MoYKRPS0s55q2vnfmW4Dfx3auH63sHY7UQQe4pZEbjr
         q5zgW1dccZQKkWdYeYSH08fVvaDhUojIOx3LlpVi3V4ShKGgNyawOzfTXTfOMmpPTIZ0
         g8gk8b1GanP1G3oInEYLEtNnhY+GZbu59VJhJiB5i+syQYbDoa0Qzr7oSB2cs154nsPL
         5qxA==
X-Gm-Message-State: AC+VfDzbjPp8G7ivd1cTCiocKzVheQ0lavgAFZFlI1AErBGQW38YhUPo
	AzN1hviPN9mqBOCoiESg+W+iQWtLTGeq5fDz+5g=
X-Google-Smtp-Source: ACHHUZ73PIjxDOF+Ar6EQpvUC1coGZm4Nlhdkm3QGvvzvDMK8wD5ATlYRarH/gOsu3P34DrOAjggdyxnahpLpCyqfzM=
X-Received: by 2002:a17:907:3d93:b0:974:5ece:19a6 with SMTP id
 he19-20020a1709073d9300b009745ece19a6mr13694887ejc.54.1686612727628; Mon, 12
 Jun 2023 16:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612191641.441774-1-kuifeng@meta.com> <20230612191641.441774-3-kuifeng@meta.com>
 <CAADnVQ+Fbz9pQ6BbKX_z9Sx=pwNaODD7vvBsaz_89Zy6Zs0=jg@mail.gmail.com> <0c67d4b3-fe9f-507c-5856-78c2ea4f6573@gmail.com>
In-Reply-To: <0c67d4b3-fe9f-507c-5856-78c2ea4f6573@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 16:31:55 -0700
Message-ID: <CAEf4BzZtj4mRExjh9kAt0Mwi+4pr17HMWpXzqCCTDDXBF5FeNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify that the cgroup_skb
 filters receive expected packets.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 2:56=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 6/12/23 13:31, Alexei Starovoitov wrote:
> > On Mon, Jun 12, 2023 at 12:16=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail=
.com> wrote:
> >> +static int close_connection(int *closing_fd, int *peer_fd, int *liste=
n_fd)
> >> +{
> >> +       int err;
> >> +
> >> +       /* Half shutdown to make sure the closing socket having a chan=
ce to
> >> +        * receive a FIN from the client.
> >> +        */
> >> +       err =3D shutdown(*closing_fd, SHUT_WR);
> >> +       if (CHECK(err, "shutdown closing_fd", "failed: %d\n", err))
> >> +               return -1;
> >> +       usleep(100000);
> >> +       err =3D close(*peer_fd);
> >> +       if (CHECK(err, "close peer_fd", "failed: %d\n", err))
> >> +               return -1;
> >> +       *peer_fd =3D -1;
> >> +       usleep(100000);
> >> +       err =3D close(*closing_fd);
> >
> > usleep() won't guarantee it. The test will be flaky.
> > Can you make it reliable?
> What if it checks a counter of packets going through the filter?
> Will try a couple times until it is too long, one second
> for example.
>
> >
> >> +
> >> +/* Run accept() on a socket in the cgroup to receive a new connection=
. */
> >> +#define EGRESS_ACCEPT                                                =
  \
> >> +       case SYN_RECV_SENDING_SYN_ACK:                                =
  \
> >> +               if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)   =
  \
> >> +                       g_unexpected++;                               =
  \
> >> +               else                                                  =
  \
> >> +                       g_sock_state =3D SYN_RECV;                    =
    \
> >> +               break
> >> +
> >> +#define INGRESS_ACCEPT                                               =
  \
> >> +       case INIT:                                                    =
  \
> >> +               if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)    =
  \
> >> +                       g_unexpected++;                               =
  \
> >> +               else                                                  =
  \
> >> +                       g_sock_state =3D SYN_RECV_SENDING_SYN_ACK;    =
    \
> >> +               break;                                                =
  \
> >> +       case SYN_RECV:                                                =
  \
> >> +               if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)    =
  \
> >> +                       g_unexpected++;                               =
  \
> >> +               else                                                  =
  \
> >> +                       g_sock_state =3D ESTABLISHED;                 =
    \
> >> +               break
> >> +
> >
> > The macros make the code difficult to follow.
> > Could you do it with normal functions?
> >
> Sure!
>

please don't use CHECK() macros for new code, use ASSERT_xxx() family

