Return-Path: <bpf+bounces-4856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50BE750C2B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C061C20E45
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF824175;
	Wed, 12 Jul 2023 15:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B424163;
	Wed, 12 Jul 2023 15:16:57 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4F1BD5;
	Wed, 12 Jul 2023 08:16:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-78f554d4949so2417023241.3;
        Wed, 12 Jul 2023 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689175002; x=1691767002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u5wdruCv5qZAwZmf+4YbzqhZRiNuPLcSBIHcakSfVI=;
        b=F1klgqTxSXT+aoGrKzSpxAdDRnjg2ixwNDiAsSpHOMvk7JvNFELzX3/dPc1LkSaBzS
         4Mw2rkFrPlpf1qKdPQZ7gw7XRGlYwUre0fhHqzyLCJHksk5ijbG1YLHs3X7hdFkA5MsH
         xFc5XrGn6GOd2PsnI6DNS86T/51uu+JYEVXuocd7ZveLxGk0RY3PsT229/TC7rW7Lwqp
         Rg4TOFp5CeyEYJFDzXOPBsyDVChgyxRUR+tM94MI0YKeYqYVPxEadaOwoGS7dbzIz8L8
         o1AT+BxK1/WluXxjs6Qq4NS2wvwyGeRDoTMcjlQGyyVW6Z1ZefSEskdJDEr+cjRjNAcL
         fJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175002; x=1691767002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u5wdruCv5qZAwZmf+4YbzqhZRiNuPLcSBIHcakSfVI=;
        b=MpwBaF4A6GWe8TDuydrJd4Lo2YcEHCois1WlWhZYs7l1scbE6mSkYvp1t1/GwtVq11
         rTi7PU61ZQuavxj4ppbiVNF+y5GWfOE4Votqcc2hyMERYsSuSEtjgPkrd10JQE8nNAJO
         M5D6JiHuZUGD/Kn1sLPEWBjq+4cV+jp73EtNbW9WdLmZUynawgGkIBdW7aKz9LWUNB5y
         qhtJL4YTkGRg5uusF5b0pfaStE1MxTCUczh5xv+n2oJAS7W9K/Wpzr5XgjDZ6ZJXrb74
         K7Rgx174vnM0GfSAwxWhu1J+cjasFCa0URJqJ/kqyHBe8Gkc22lohJFgyGcqb3Yb6Umi
         bszw==
X-Gm-Message-State: ABy/qLbkh/ymifp5KFJh0IJLimLWqyvTPPFJAHIYVRANBeGKnIxUSpjH
	pvGrtNmqOjhsAe8yWqGU4Oz/gMxxEjjC+iuGmXkZz5gsNmI=
X-Google-Smtp-Source: APBJJlFwjbK9mcwkmPB4EO0CdhSct4jhru67FvfPKws3fYCV8cGbUAjcXb9F6/cc+EYcqGw+Az6OMJA1Q9PJU3SYg+c=
X-Received: by 2002:a67:f653:0:b0:443:4e7d:c8db with SMTP id
 u19-20020a67f653000000b004434e7dc8dbmr9279109vso.2.1689175002669; Wed, 12 Jul
 2023 08:16:42 -0700 (PDT)
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
 <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
In-Reply-To: <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 12 Jul 2023 11:16:04 -0400
Message-ID: <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 1:36=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Jul 11, 2023 at 9:59=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 11, 2023 at 8:29=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > >
> > > This will slow things down, but not to the point where it's on par
> > > with doing sw checksum. At least in theory.
> > > We can't stay at skb when using AF_XDP. AF_XDP would benefit from hav=
ing
> > > the offloads.
> >
> > To clarify: yes, AF_XDP needs generalized HW offloads.
>
> Great! To reiterate, I'm mostly interested in af_xdp wrt tx
> timestamps. So if the consensus is not to mix xdp-tx and af_xdp-tx,
> I'm fine with switching to adding some fixed af_xdp descriptor format
> to enable offloads on tx.
>
> > I just don't see how xdp tx offloads are moving a needle in that direct=
ion.
>
> Let me try to explain how both might be similar, maybe I wasn't clear
> enough on that.
> For af_xdp tx packet, the userspace puts something in the af_xdp frame
> metadata area (headrom) which then gets executed/interpreted by the
> bpf program at devtx (which calls kfuncs to enable particular
> offloads).
> IOW, instead of defining some fixed layout for the tx offloads, the
> userspace and bpf program have some agreement on the layout (and bpf
> program "applies" the offloads by calling the kfuncs).
> Also (in theory) the same hooks can be used for xdp-tx.
> Does it make sense? But, again, happy to scratch that whole idea if
> we're fine with a fixed layout for af_xdp.

Checksum offload is an important demonstrator too.

It is admittedly a non-trivial one. Checksum offload has often been
discussed as a pain point ("protocol ossification").

In general, drivers can accept every CHECKSUM_COMPLETE skb that
matches their advertised feature NETIF_F_[HW|IP|IPV6]_CSUM. I don't
see why this would be different for kfuncs for packets coming from
userspace.

The problematic drivers are the ones that do not implement
CHECKSUM_COMPLETE as intended, but ignore this simple
protocol-independent hint in favor of parsing from scratch, possibly
zeroing the field, computing multiple layers, etc.

All of which is unnecessary with LCO. An AF_XDP user can be expected
to apply LCO and only request checksum insertion for the innermost
checksum.

The biggest problem is with these devices that parse in hardware (and
possibly also in the driver to identify and fix up hardware
limitations) is that they will fail if encountering an unknown
protocol. Which brings us to advertising limited typed support:
NETIF_F_HW_CSUM vs NETIF_F_IP_CSUM.

The fact that some devices that deviate from industry best practices
cannot support more advanced packet formats is unfortunate, but not a
reason to hold others back. No different from current kernel path. The
BPF program can fallback onto software checksumming on these devices,
like the kernel path. Perhaps we do need to pass along with csum_start
and csum_off a csum_type that matches the existing
NETIF_F_[HW|IP|IPV6]_CSUM, to let drivers return with -EOPNOTSUPP
quickly if for the generic case.

For implementation in essence it is just reordering driver code that
already exists for the skb case. I think the ice patch series to
support rx timestamping is a good indication of what it takes to
support XDP kfuncs: not so much new code, but reordering the driver
logic.

Which also indicates to me that the driver *is* the right place to
implement this logic, rather than reimplement it in a BPF library. It
avoids both code duplication and dependency hell, if the library ships
independent from the driver.

