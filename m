Return-Path: <bpf+bounces-4864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E3750E92
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB85D1C20D6F
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70214F8E;
	Wed, 12 Jul 2023 16:29:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06C14F74;
	Wed, 12 Jul 2023 16:29:14 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55F1FE1;
	Wed, 12 Jul 2023 09:29:12 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4814299c981so224164e0c.0;
        Wed, 12 Jul 2023 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689179352; x=1691771352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCWIxbKtlOhtInuz1uYnTQB5l4QrkHYBBkblWGqAp6I=;
        b=T/YdCKa4t5s7idf/xPmv18zSSnVBmjtwNHB+1JA7+UquLP6PW8eEWJSd4ikNoONqCZ
         6dq7FS0CzMwochyeA+sbyVOL1mLzRQcGm+hzFLuBHTPa4cYgrX45Sj9hiieojd+XMKDp
         7seK0b3TGrrKRfYxHj3504ERITOHwsvBq3SUwIt27RfNRxJ1X8TasplxcXOMMfZG4MSF
         sPOZpHf0uqWmw/UEdtSyb73HMRjPmrxcZeN/C8Ax3tYiMfMiaNc1f0kZeLMEyMbphy3A
         rZBXL5TY7pDYxnzPwJFYmvzIpve/Fny7cQJeabQyEj9Klar9Y3otRhjUO1ZeNoi17s2H
         dNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179352; x=1691771352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCWIxbKtlOhtInuz1uYnTQB5l4QrkHYBBkblWGqAp6I=;
        b=ZxWt7tGsRYS7fuxKdUOIe3GgFT+4YR7nYWyEPxJN2Y4Hv9CX2eI8leGlzuqJgGBLor
         iBze71Ev3w9VeTYvaNDrRSciv9/3/8NPF5SQpyPiMT0GDJOnBc7RIsmBXUflAiocf2pK
         LT2k+H8gYQxQULFn7d7Q9chZZS58bhbwxqh4QkChrHAHQ4O/FqdyEKY8U5lFAutgdzYd
         ITIqQfNVKNdnd+QdfzwXlXUUPaWuNBXPeVfov6AqXz/jgG1j2ZLNWV0LaaZL1b7GlTPx
         Mg5zMLrhcLT62gARpB54kBkQgVi5MFcEK/3Uu1eQtP8gGGml6W7dXxFlCpPwKW+mDexL
         KIzQ==
X-Gm-Message-State: ABy/qLbIOvXdfF4zPrrzFkuGZXcuSz0AQuVXa9tvCujpa/Xqs7klj7+9
	AY9SxQF9dvgqBy3UWBG4ZYrjn0N/wBmVNvsAxTM=
X-Google-Smtp-Source: APBJJlHh9tgQIUo78AXSalDVsI5ZWlEnnfddyQTtkdcY0CyVJeUVF6NjDJXp9x40yiafPedt3keoZT1EJJw8q8Khfm8=
X-Received: by 2002:a1f:5842:0:b0:476:3544:773 with SMTP id
 m63-20020a1f5842000000b0047635440773mr9870855vkb.11.1689179351780; Wed, 12
 Jul 2023 09:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
 <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
 <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
 <ZK4eFox0DwbpyIJv@google.com> <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
 <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com> <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
In-Reply-To: <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 12 Jul 2023 12:28:34 -0400
Message-ID: <CAF=yD-JMq=6MJGbpyf0knR+k9zfs4b1k7NqutM49WYqHmeH2nQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, Jul 12, 2023 at 1:36=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Tue, Jul 11, 2023 at 9:59=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 8:29=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > >
> > > > This will slow things down, but not to the point where it's on par
> > > > with doing sw checksum. At least in theory.
> > > > We can't stay at skb when using AF_XDP. AF_XDP would benefit from h=
aving
> > > > the offloads.
> > >
> > > To clarify: yes, AF_XDP needs generalized HW offloads.
> >
> > Great! To reiterate, I'm mostly interested in af_xdp wrt tx
> > timestamps. So if the consensus is not to mix xdp-tx and af_xdp-tx,
> > I'm fine with switching to adding some fixed af_xdp descriptor format
> > to enable offloads on tx.
> >
> > > I just don't see how xdp tx offloads are moving a needle in that dire=
ction.
> >
> > Let me try to explain how both might be similar, maybe I wasn't clear
> > enough on that.
> > For af_xdp tx packet, the userspace puts something in the af_xdp frame
> > metadata area (headrom) which then gets executed/interpreted by the
> > bpf program at devtx (which calls kfuncs to enable particular
> > offloads).
> > IOW, instead of defining some fixed layout for the tx offloads, the
> > userspace and bpf program have some agreement on the layout (and bpf
> > program "applies" the offloads by calling the kfuncs).
> > Also (in theory) the same hooks can be used for xdp-tx.
> > Does it make sense? But, again, happy to scratch that whole idea if
> > we're fine with a fixed layout for af_xdp.
>
> Checksum offload is an important demonstrator too.
>
> It is admittedly a non-trivial one. Checksum offload has often been
> discussed as a pain point ("protocol ossification").
>
> In general, drivers can accept every CHECKSUM_COMPLETE skb that

Erm.. CHECKSUM_PARTIAL

