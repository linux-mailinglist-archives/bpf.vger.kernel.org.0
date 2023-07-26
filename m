Return-Path: <bpf+bounces-5993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390B763EC2
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E3C1C21026
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB424CE6A;
	Wed, 26 Jul 2023 18:44:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDC17EE
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 18:44:31 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52B2135
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:44:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso400485e9.3
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690397068; x=1691001868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ7OZ1wZW/07V4ABlHK6kZ3sEYSCJX6Ow0jjMBywwZM=;
        b=DrKALyEJEJCjYt1L47slzumv2us34D+SkhJ7IDCcD/mfT8hOkbemSp4Y7Oy0riqAdr
         oplu0KoOoAsdQUJCl/Mei/c3OSahCHRxGZ1WHi4ZvvTfDCyXIVYMyMaGfODFnSAcNmu6
         47QJNohrt5GFGgm+wVbR44ar8ucvvGSoSDGA3rZh80LNUBWPXLucP9eNR/Fe29GHMhp/
         Sx9BgbcBWtM/uIwS56KxZq1YQ/ZkVl5ij4DxywPbjUX+0vE7LRrIdG35Lfr52G1ERfUp
         TYUcXrMvb4Up86LCZFmVt6hRPJS1p1kTGQPQL/sEV4CMbgXnD/jTrrCSbOsJ8G2NFYyP
         tEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397068; x=1691001868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ7OZ1wZW/07V4ABlHK6kZ3sEYSCJX6Ow0jjMBywwZM=;
        b=Re7HcszFBhClS0fVQFw3bYgrXI8bUkPqy4pzO4XC8EVH7pKacjn+L1++hmMNiR8lgX
         Dl24Qtj76korx/Iq7mfx0IT8zB4k8u2rDxWFKaR0X1lFl7qTV4/ov9ZsyjAGdF21zMMh
         yVZxUTaWkyZNIgne26O91yOh/d9POaQYwvj5aDciNl0qedds82HfGHhHfebe8R0dSPKH
         2as3TCjpZ0dyN0KYKp/4Nf83tqUVIrizIbCb8Dm5LdaZhLxOLd2v3x9Ml4jCdTxRCrrE
         ymU+YSoPzHZVE+UVg/fvEeqHjVoe6m80eeS2tg7lkNTy74wN9hkLqwN6EBcvjJUSfwim
         cGHg==
X-Gm-Message-State: ABy/qLbXEOukqXsU7Mid566WxKK200nBT92rqpBbTAQD6mhW6tuDoOdH
	UVEd0cCfr3eFWom8lRtkQ36LrjxPIJKcyEeQwP3oFw==
X-Google-Smtp-Source: APBJJlFbaLjYgaAp3ZiF1dpBW3M5vPnPaRN2ibSMPLJDDgnvd7+KqYr7kUJba2oyRapEIbcLI/Di8IpWdfMygEjdd/M=
X-Received: by 2002:a05:600c:3788:b0:3fd:2d42:9392 with SMTP id
 o8-20020a05600c378800b003fd2d429392mr2037098wmr.4.1690397068574; Wed, 26 Jul
 2023 11:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689885610.git.zhuyifei@google.com> <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
 <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com> <CAA-VZPmhm3SoD+tX-xPSj6wuOvFg=uZoar0b=sgAyLRz=5n+2A@mail.gmail.com>
 <0d242e21-3f53-87ca-7aa8-bb55b5223552@huaweicloud.com>
In-Reply-To: <0d242e21-3f53-87ca-7aa8-bb55b5223552@huaweicloud.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Wed, 26 Jul 2023 11:44:17 -0700
Message-ID: <CAA-VZPmretQpaGan_w=VMpvL_gKsAb_fT-x8Q4Eci8dE4EPvHQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist
 during prefill
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:38=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 7/21/2023 10:31 AM, YiFei Zhu wrote:
> > On Thu, Jul 20, 2023 at 6:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> On 7/21/2023 4:44 AM, YiFei Zhu wrote:
> >>> Sometimes during prefill all precpu chunks are full and atomic
> >>> __alloc_percpu_gfp would not allocate new chunks. This will cause
> >>> -ENOMEM immediately upon next unit_alloc.
> >>>
> >>> Prefill phase does not actually run in atomic context, so we can
> >>> use this fact to allocate non-atomically with GFP_KERNEL instead
> >>> of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
> >>> unit_alloc runs in atomic context, even from map item allocation in
> >>> syscalls, due to rcu_read_lock, so we can't do non-atomic
> >>> workarounds in unit_alloc.
> >>>
> >>> Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_a=
lloc.")
> >>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> >> Make sense to me, so
> >>
> >> Acked-by: Hou Tao <houtao1@huawei.com>
> >>
> >> But I don't know whether or not it is suitable for bpf tree.
> > I don't mind either way :) If changing to bpf-next requires a resend I
> > can do that too.
>
> Please resend and rebase the patch again bpf-next tree.
>

Will do. Should I drop the Fixes tag then?

YiFei Zhu

