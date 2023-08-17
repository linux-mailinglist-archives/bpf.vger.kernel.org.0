Return-Path: <bpf+bounces-8007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297177FD34
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B328211C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D00171D3;
	Thu, 17 Aug 2023 17:48:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49E14AA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:48:56 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ACFFD
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:48:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso990341fa.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692294534; x=1692899334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ob6QyyyAmMtJ5X972ibvBKWm8Db/jO2heQVFQ3z1JY=;
        b=EzUEUm62GWd1uxK6TbEFD0yS7ywVFToItR2kOaOly3OJCI/3Wt3hEdDpxUNT5heR5S
         G/yxllZudn4WKxV2vuwBtWe52FhfGpyqTED9jsYY+jOcsQygx0knoA9duI168vKSwENw
         V1zD+CDhbWu9nhyozo97PVHR+1gehz/ba/QtG9fNA0wUNHv9g65RDRsD7Muvqat+i2Cj
         r+XYPiRjT5wDXdYASyyuXaPASVTop6J4kFG+cxo2H1ZbMgqHJjJd6xPMVJirNYeDEoHm
         DVnrvkcjy8WIV0NN0BQRpnOL7ydKn3dTSUoflaAEW+SfJr/cKGVuXEYZmjCcV3AranqP
         sUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294534; x=1692899334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ob6QyyyAmMtJ5X972ibvBKWm8Db/jO2heQVFQ3z1JY=;
        b=MN7QigzblILOOJQYwLf+pZGFHj6BdcGQNDRJ7BfgQkM6qy4tgEnBOPuiBXxhXnV50u
         oBS4Y2SEqojESOCAtBr55R9reCV1kDa/SJXVDA2dl/vmD7u5oDDA73GIoU5+BSvk0cmM
         TnreYwRAf9iWB4JxlE+YHt8jeVZpv08fyoEkQPl2fErTR98lGYFKkqh0X8PVeBfBnR8j
         LGQ5tHSmbtrCcvhDvzQ79FnM4lzf+TmvYyGwDi8xahAVGZ8Uy4cKJMiJy3r2CjQG9h2p
         qEoPFasT5u6AGChF3ZPpn5G0gYoQk54uGWzMidXz8P3aIKR6fkaXHMRjpylIAEzxEy7p
         uNcw==
X-Gm-Message-State: AOJu0YyqNHu/vpBpwZ2S2gBCXrbywrJX2egQREfaWuvirCkDNG2KkLw7
	JsgFu4uAaT6goeNUv8SWmzWKzaRK5R6I5v210NZCvKbYLJM=
X-Google-Smtp-Source: AGHT+IEydtADr4TPBY0aw3WBzw4iQlpZV86ryTWxoYIVImeE6TI2f1qScKEX0oSPuq3FR39XbZo5JJV70mlYawv2PH0=
X-Received: by 2002:a2e:a288:0:b0:2bb:a697:31d with SMTP id
 k8-20020a2ea288000000b002bba697031dmr31957lja.48.1692294533658; Thu, 17 Aug
 2023 10:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
 <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
 <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com> <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com>
In-Reply-To: <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 10:48:42 -0700
Message-ID: <CAADnVQL6_ApdDqw_epduKEGuXHKiAVZFFLqq4FkMwtdnv-YS9Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 12:10=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Yonghong already pointed out upthread that
> > comparison of two packet pointers is not a pointer leak.
> > See this code:
> >         } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->s=
rc_reg],
> >                                            this_branch, other_branch) &=
&
> >                    is_pointer_value(env, insn->dst_reg)) {
> >                 verbose(env, "R%d pointer comparison prohibited\n",
> >                         insn->dst_reg);
> >                 return -EACCES;
> >         }
> >
> > It's not clear why it doesn't address your case.
>
> It can address the issue.
> It seems we should do the code change below.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0b9da95..c66dc61 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13819,6 +13819,18 @@ static int check_cond_jmp_op(struct
> bpf_verifier_env *env,
>                 return -EINVAL;
>         }
>
> +       other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn=
_idx,
> +                                 false);

Yeah. something like that.
except we must do push_stack() only after is_branch_taken() didn't succeed.

