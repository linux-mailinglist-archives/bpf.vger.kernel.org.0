Return-Path: <bpf+bounces-4870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0325A7510E7
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91A7281A5B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78720FBB;
	Wed, 12 Jul 2023 19:03:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED11F95D;
	Wed, 12 Jul 2023 19:03:51 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA949198A;
	Wed, 12 Jul 2023 12:03:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26307d808a4so5311572a91.1;
        Wed, 12 Jul 2023 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689188629; x=1691780629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izeHKtX5KvfzdXp2x0mv/9s6EzKajmhq0WuDaVc77Ws=;
        b=rbqiooZ8BuxBdXte17xvcaEa54ZbPJdR47ZWwcIFqZB1ihIZ8CDvUKr+jZkRrozorA
         UxlTqWF/y8jY0KBwTbvOk8jOQKhFMoeYFZRfC5y6nILiWn4JUd4WvtJHENCA7zSMynzM
         8YhSS/wE2lHZ7PFuKZfaYQ4QBPtZZ0+kL/0J7tt/BYMJ4Pcwka5U31gqMGRwGaNtRs6G
         pmCLJqVOx5zhxIq2FSN4uhkf8ILbcO7aDXHzKPEfAki/gV+VnyBEwV7XpYX45wESZZ1j
         HhH4r8BF5RtGXh6Le+Je0sE3kqJj7je2nyeAE/5rv6LRPz7IghLVpjppiRpLqidqv8X7
         pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188629; x=1691780629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izeHKtX5KvfzdXp2x0mv/9s6EzKajmhq0WuDaVc77Ws=;
        b=FDRmwmdBQA7gKwOZ6FqbkAit7I1hhe19Y5vx4Co+EwZPsJZFAPouMi2u/TlWtHq2jT
         EttrnAlVe1AaBQofdSoE/45WkiGoymtQBCngfhwtjFmPcqW3nutcQM+gypasWAjfMRo4
         SJRQbT/iB7mJja+S9TVgZM1oDyiRwuuuOB5vMKGkI/1VSjyGqsTCV6DSdMG2m/N4+EBA
         5yuizAMvvxI3pEoA6XQHDHCEXACiuX56qC0hl/yB4Gq51wgI5WDr9RbTd0bXJtb0ucWL
         +AqgeCjXDBstW9BPZObrP1HxRYR92TGL/FTgvGz6eLzZZ9dGEFQhrF4T+n74n5RJZJGo
         PVCg==
X-Gm-Message-State: ABy/qLY4e4oWECTiVhXjMQr40kUrgWUoXK46uaYoGlPo2TCvdbDFiPu4
	YQnoTWoWQqxcrvih5fWOcF8=
X-Google-Smtp-Source: APBJJlGUBftcq3sW6xYIChJ31Z0RgigBn+2B/wRB23HXPgMj+G9NRmU9kKEYs1czAEaVjnvsxQD0KA==
X-Received: by 2002:a17:90b:188a:b0:25b:d292:d9a3 with SMTP id mn10-20020a17090b188a00b0025bd292d9a3mr19424965pjb.37.1689188629157;
        Wed, 12 Jul 2023 12:03:49 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::5:182f])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a035500b00265d023c233sm3567687pjf.6.2023.07.12.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:03:48 -0700 (PDT)
Date: Wed, 12 Jul 2023 12:03:42 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	xdp-hints@xdp-project.net
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
Message-ID: <20230712190342.dlgwh6uka5bcjfkl@macbook-pro-8.dhcp.thefacebook.com>
References: <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
 <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
 <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
 <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
 <ZK4eFox0DwbpyIJv@google.com>
 <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
 <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
 <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:16:04AM -0400, Willem de Bruijn wrote:
> On Wed, Jul 12, 2023 at 1:36 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Jul 11, 2023 at 9:59 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 8:29 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > >
> > > > This will slow things down, but not to the point where it's on par
> > > > with doing sw checksum. At least in theory.
> > > > We can't stay at skb when using AF_XDP. AF_XDP would benefit from having
> > > > the offloads.
> > >
> > > To clarify: yes, AF_XDP needs generalized HW offloads.
> >
> > Great! To reiterate, I'm mostly interested in af_xdp wrt tx
> > timestamps. So if the consensus is not to mix xdp-tx and af_xdp-tx,
> > I'm fine with switching to adding some fixed af_xdp descriptor format
> > to enable offloads on tx.

since af_xdp is a primary user let's figure out what is the best api for that.
If any code can be salvaged for xdp tx, great, but let's not start with xdp tx
as prerequisite.

> >
> > > I just don't see how xdp tx offloads are moving a needle in that direction.
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

So instead of defining csum offload format in xsk metadata we'll
defining it as a set of arguments to a kfunc and tx-side xsk prog
will just copy the args from metadata into kfunc args ?
Seems like an unnecesary step. Such xsk prog won't be doing
anything useful. Just copying from one place to another.
It seems the only purpose of such bpf prog is to side step uapi exposure.
bpf is not used to program anything. There won't be any control flow.
Just odd intermediate copy step.
Instead we can define a metadata struct for csum nic offload
outside of uapi/linux/if_xdp.h with big 'this is not an uapi' warning.
User space can request it via setsockopt.
And probably feature query the nic via getsockopt.

Error handling is critical here. With xsk tx prog the errors
are messy. What to do when kfunc returns error? Store it back into
packet metadata ? and then user space needs to check every single
packet for errors? Not practical imo.

Feature query via getsockopt would be done once instead and
user space will fill in "csum offload struct" in packet metadata
and won't check per-packet error. If driver said the csum feature
is available it's better work for every packet.
Notice mlx5e_txwqe_build_eseg_csum() returns void.

> 
> Checksum offload is an important demonstrator too.
> 
> It is admittedly a non-trivial one. Checksum offload has often been
> discussed as a pain point ("protocol ossification").
> 
> In general, drivers can accept every CHECKSUM_COMPLETE skb that
> matches their advertised feature NETIF_F_[HW|IP|IPV6]_CSUM. I don't
> see why this would be different for kfuncs for packets coming from
> userspace.
> 
> The problematic drivers are the ones that do not implement
> CHECKSUM_COMPLETE as intended, but ignore this simple
> protocol-independent hint in favor of parsing from scratch, possibly
> zeroing the field, computing multiple layers, etc.
> 
> All of which is unnecessary with LCO. An AF_XDP user can be expected
> to apply LCO and only request checksum insertion for the innermost
> checksum.
> 
> The biggest problem is with these devices that parse in hardware (and
> possibly also in the driver to identify and fix up hardware
> limitations) is that they will fail if encountering an unknown
> protocol. Which brings us to advertising limited typed support:
> NETIF_F_HW_CSUM vs NETIF_F_IP_CSUM.
> 
> The fact that some devices that deviate from industry best practices
> cannot support more advanced packet formats is unfortunate, but not a
> reason to hold others back. No different from current kernel path. The
> BPF program can fallback onto software checksumming on these devices,
> like the kernel path. Perhaps we do need to pass along with csum_start
> and csum_off a csum_type that matches the existing
> NETIF_F_[HW|IP|IPV6]_CSUM, to let drivers return with -EOPNOTSUPP
> quickly if for the generic case.
> 
> For implementation in essence it is just reordering driver code that
> already exists for the skb case. I think the ice patch series to
> support rx timestamping is a good indication of what it takes to
> support XDP kfuncs: not so much new code, but reordering the driver
> logic.
> 
> Which also indicates to me that the driver *is* the right place to
> implement this logic, rather than reimplement it in a BPF library. It
> avoids both code duplication and dependency hell, if the library ships
> independent from the driver.

Agree with all of the above.
I think defining CHECKSUM_PARTIAL struct request for af_xdp is doable and
won't require much changes in the drivers.
If we do it for more than one driver from the start there is a chance it
will work for other drivers too. imo ice+gve+mlx5 would be enough.

