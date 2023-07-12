Return-Path: <bpf+bounces-4830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC9F74FEBD
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 07:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F4F1C20D6E
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDE211F;
	Wed, 12 Jul 2023 05:36:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E837FD
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 05:36:21 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F751712
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:36:20 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b05d63080cso5991964fac.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689140180; x=1691732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnidGm4u+nJnZIlJckPEwTKF95jsTNlFO/U0vG4SnH4=;
        b=xY+6hGjCcCcyOfBX5GtuaDdGYczloCXcdZ/qw6ngGMl4SlD1U1KljeaA6WSxFe/tkw
         e79CyoBBrHq0Dk1imnjFjqQjdKj9pXHHRfg3laa1+9kAHuXsF15Cd6PQcVGoz4hxAXgf
         Wt0AIel3aOb1Y5HFFR6SvLo+CCkPlaByGlTvc+liAipflw4tsKP6s1z+fVeXjVhgiI2w
         dXKPQWIl1KSYhbf49b1PTvewHs/trbIwiDbI7Rskrho8Wi+WP0jMXxxWBOK6KEwWiZ6P
         Xlga2btiZW5Z7Y7KvwbJsRD32aMVQ6a2fkIDGjQU6Bepc1BGg/LR1ED6GiqWZDir5scx
         3vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140180; x=1691732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnidGm4u+nJnZIlJckPEwTKF95jsTNlFO/U0vG4SnH4=;
        b=Uhjh0j4YUqy/rnti3cj0tPLAvIyUAg/HqyH3Zs6MJDbghCxuik2U91BPRZb12U/Ig5
         jN/PbUwKiaEtbB6yiTfqY+bYxT9SUrSBIeLGfs7a9H0diN01U6cInM1apo7LagaIUDfJ
         UaW9OzrbqclMk3miGiv4M9dvsNwPrn+4MGGPPYKG3kyRH2L4nM0qhNMVlM3C3GY1qQhL
         YvWzqmZ8WTWiGtBwlePDwB1yNmz+K8HG/rUQ7CLRYxGNEgNgpYIpWVTGVvFmVanYfmz1
         +Vuem+x967ceez87wYB6evWFkv8Rf1hog1KBgUgSqYPrDNbkcA5O/KI+wRInsWgFQNVE
         SFEw==
X-Gm-Message-State: ABy/qLYSeBrLasO9jGCFeupW6RgIVAbcvwfEv5INDd4YXhw3R42FEhKJ
	q7GAlPzn7eISu4VIT8qDCSkOKbu+mXmWVwmJRU1yTwFuSHufjufclbL1fgB1
X-Google-Smtp-Source: APBJJlGAGBzXt27mT9kxQcqGuRRrF5r9n/oPwjmju5K2TDj52bB2UdXsZbXYwWDeCZUKXtCgJ5ykqMtqnT2pEHUkzIw=
X-Received: by 2002:a05:6870:638d:b0:1b0:291c:9272 with SMTP id
 t13-20020a056870638d00b001b0291c9272mr22177928oap.28.1689140179849; Tue, 11
 Jul 2023 22:36:19 -0700 (PDT)
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
In-Reply-To: <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 11 Jul 2023 22:36:08 -0700
Message-ID: <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 9:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 11, 2023 at 8:29=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> >
> > This will slow things down, but not to the point where it's on par
> > with doing sw checksum. At least in theory.
> > We can't stay at skb when using AF_XDP. AF_XDP would benefit from havin=
g
> > the offloads.
>
> To clarify: yes, AF_XDP needs generalized HW offloads.

Great! To reiterate, I'm mostly interested in af_xdp wrt tx
timestamps. So if the consensus is not to mix xdp-tx and af_xdp-tx,
I'm fine with switching to adding some fixed af_xdp descriptor format
to enable offloads on tx.

> I just don't see how xdp tx offloads are moving a needle in that directio=
n.

Let me try to explain how both might be similar, maybe I wasn't clear
enough on that.
For af_xdp tx packet, the userspace puts something in the af_xdp frame
metadata area (headrom) which then gets executed/interpreted by the
bpf program at devtx (which calls kfuncs to enable particular
offloads).
IOW, instead of defining some fixed layout for the tx offloads, the
userspace and bpf program have some agreement on the layout (and bpf
program "applies" the offloads by calling the kfuncs).
Also (in theory) the same hooks can be used for xdp-tx.
Does it make sense? But, again, happy to scratch that whole idea if
we're fine with a fixed layout for af_xdp.

