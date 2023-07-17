Return-Path: <bpf+bounces-5074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C02755917
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 03:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623DE1C2094C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6641360;
	Mon, 17 Jul 2023 01:40:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B2A49
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 01:40:11 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A376E4B
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:40:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so35747925e9.1
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689558009; x=1692150009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OOO9ivwjr+o6ItsH++M0eDLGFb7aa2/apKMjiV7zBGY=;
        b=NDfzIwMcsG3tLnqZ8fpC53atNuQMlfu93cWh7WkOuEfGYVAywbXIRqIVfSruEfKgYM
         tNooFywXzAe1UK1LZBYQfQVTqUkEwSagV5+AfLhugSjNGQyhKRxyQIET94bMZLbBiHTX
         DOOrK3RKkMVwZGuH3VUwnl/FpSXmkyvTHtgJUc2rLRPa5NwYuwii4FQTcz96Hqk6VKgx
         qH9JezPTTI622EQVv2KFw7mpLN3VzKPmfzOVTsW1GK3XABzmz6FU6TyfTvaFTX6zd0JK
         ga3CSz+9qxXvgFw4CE5Iva/77DTXSrVisONo6DRHg5fprQfFcdSb49gqZTbcJggjae+i
         RpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689558009; x=1692150009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOO9ivwjr+o6ItsH++M0eDLGFb7aa2/apKMjiV7zBGY=;
        b=eyT+cmcIwkF0qvXv4UsyLOWBepox9c97qnVXNnkiE6g/8GTByjuRoRWOaSG/9geF+O
         uNUjxKH/BtXKeh8e7dwZ6Ddj225KcS5cHYjV+08GcCk+sP1DgG0mUGx2t4VIxEFFut+n
         4Mk5o5GGYZ8lWVO9JCh8hIw+27py+tdCA8ROUpit0DTdNVUwJVs6DP86XuLaeCoPXUm3
         Z4qDg3CgXe0cV6iMJnRq/pXQqmx9Rwi5aDXGpLqq0U9FLF5JM5n54/bLIZTuBRosWKp0
         enFlbsPqbeeL21iunRyKxtMFK4bTaDN4Fnw70YeEpi7qQj7UtLFwAr2nJXTuc1OfMCFR
         OFtQ==
X-Gm-Message-State: ABy/qLax3aHAA+w1bM6ck052G1KaO6beHfRc5tj05xBICdw0+3redr0R
	4tymd7ZJK5YhPK5LUSMRFjk=
X-Google-Smtp-Source: APBJJlEUCUeG8RgJUQw1/3S+6PHJQJ0LrZHtgpcH1lNOIY6Fyl/Ffw98rhNpYyR7oGfsOYL8Gc8H+g==
X-Received: by 2002:a7b:ca4a:0:b0:3fc:240:cecc with SMTP id m10-20020a7bca4a000000b003fc0240ceccmr9266701wml.11.1689558008543;
        Sun, 16 Jul 2023 18:40:08 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4641000000b0031434936f0dsm17611394wrs.68.2023.07.16.18.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 18:40:08 -0700 (PDT)
Message-ID: <a3fe0382a39a5ac462d071b5c6ca3415ade16939.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Fix sign-extension ctx member
 accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Mon, 17 Jul 2023 04:40:07 +0300
In-Reply-To: <20230713060729.390027-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060729.390027-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
> > In uapi bpf.h, there are two ctx structures which contain
> > signed members. Without cpu v4, such signed members will
> > be loaded with unsigned load and the compiler will generate
> > proper left and right shifts to get the proper final value.
> >=20
> > With sign-extension load, however, left/right shifts are gone,
> > we need to ensure these signed members are properly handled,
> > with signed loads or other means. The following are list of
> > signed ctx members and how they are handled.

This is not a generic approach, in theory any field could
be cast as a signed integer. Do we want to support this?
If so, then it should be handled in convert_ctx_access()
by generating additional sign extension instructions.

> >=20
> > (1).
> >   struct bpf_sock {
> >      ...
> >      __s32 rx_queue_mapping;
> >   }
> >=20
> > The corresponding kernel fields are
> >   struct sock_common {
> >      ...
> >      unsigned short          skc_rx_queue_mapping;
> >      ...
> >   }
> >=20
> > Current ctx rewriter uses unsigned load for the kernel field
> > which is correct and does not need further handling.
> >=20
> > (2).
> >   struct bpf_sockopt {
> >      ...
> >      __s32   level;
> >      __s32   optname;
> >      __s32   optlen;
> >      __s32   retval;
> >   }
> > The level/optname/optlen are from struct bpf_sockopt_kern
> >   struct bpf_sockopt_kern {
> >      ...
> >      s32             level;
> >      s32             optname;
> >      s32             optlen;
> >      ...
> >   }
> > and the 'retval' is from struct bpf_cg_run_ctx
> >   struct bpf_cg_run_ctx {
> >      ...
> >      int retval;
> >   }
> > Current the above four fields are loaded with unsigned load.
> > Let us modify the read macro for bpf_sockopt which use
> > the same signedness for the original insn.
> >=20
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/cgroup.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 5b2741aa0d9b..29e3606ff6f4 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -2397,9 +2397,10 @@ static bool cg_sockopt_is_valid_access(int off, =
int size,
> >  }
> > =20
> >  #define CG_SOCKOPT_READ_FIELD(F)					\
> > -	BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F),	\
> > +	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
> > +		      BPF_MODE(si->code) | BPF_CLASS(si->code)),	\
> >  		    si->dst_reg, si->src_reg,				\
> > -		    offsetof(struct bpf_sockopt_kern, F))
> > +		    offsetof(struct bpf_sockopt_kern, F), si->imm)
> > =20
> >  #define CG_SOCKOPT_WRITE_FIELD(F)					\
> >  	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
> > @@ -2456,7 +2457,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf=
_access_type type,
> >  			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ct=
x),
> >  					      treg, treg,
> >  					      offsetof(struct task_struct, bpf_ctx));
> > -			*insn++ =3D BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MEM |
> > +			*insn++ =3D BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MODE(si->code) |
> >  					       BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
> >  					       treg, si->src_reg,
> >  					       offsetof(struct bpf_cg_run_ctx, retval),
> > @@ -2470,9 +2471,10 @@ static u32 cg_sockopt_convert_ctx_access(enum bp=
f_access_type type,
> >  			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ct=
x),
> >  					      si->dst_reg, si->dst_reg,
> >  					      offsetof(struct task_struct, bpf_ctx));
> > -			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, ret=
val),
> > -					      si->dst_reg, si->dst_reg,
> > -					      offsetof(struct bpf_cg_run_ctx, retval));
> > +			*insn++ =3D BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, r=
etval) |
> > +						BPF_MODE(si->code) | BPF_CLASS(si->code)),
> > +					       si->dst_reg, si->dst_reg,
> > +					       offsetof(struct bpf_cg_run_ctx, retval), si->imm);
> >  		}
> >  		break;
> >  	case offsetof(struct bpf_sockopt, optval):


