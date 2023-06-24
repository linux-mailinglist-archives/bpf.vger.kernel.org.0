Return-Path: <bpf+bounces-3356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F773C69B
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A31C213E6
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5DA644;
	Sat, 24 Jun 2023 03:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE07F;
	Sat, 24 Jun 2023 03:42:26 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566226B7;
	Fri, 23 Jun 2023 20:42:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so762340a12.0;
        Fri, 23 Jun 2023 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687578141; x=1690170141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meTbXNLUfu5ezPLqmPwKO33Sw/O+3NcRv/erua60ZmA=;
        b=nMLNdvVXM0KODEEg5/PMYYNC0qFGvzl8BKrFy6pmqsCcRhnJW2Vg9Xjd+Yoi9NLdbK
         zcm9zQWiG/ufz7+TO7cJ6EFPkf0xjz8CQNceEKeVe/SMeyDen/F6yCRb90DXIHsgSl2s
         BgpGmc5yW8qUZh2vk2BtucFS4USZ5Tff9BBCu7Vh9lg99K83tXdMdE5a7N+ilmtGko+D
         Sx/EwqXUVmhBX9k3C+kO/N91IZco4QyIJ63VB06nPcm88s0ZXCIjA3Utdz1JIRO73bPK
         EAFeNuZP3vxQjA1iVnS+nUWPFKXOP4/otHK8mtKLtkMjPFdQSUqN0YU+QiooJxsvJkms
         ApVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687578141; x=1690170141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meTbXNLUfu5ezPLqmPwKO33Sw/O+3NcRv/erua60ZmA=;
        b=T2xJd0tEr3JGKV+nLVqGiGaEsGGc/FFDLFLr2Rmak1Chh71SOTE3Q9gqrrEUYknQYt
         nAiCUWxC+EOhl4BvVmXzwueda9HSF6y8/bpbMOJ1P4sYHZqhuShqCPVqOVbaNYJ+A4pO
         Eu6h6vh157PyQfa72LpPB0pKmf/LQw1u2pueoDYSGv2hFD25Ygpc3KDzqMVgFwRS14kK
         SiX1ROUN9Fix8Ay6CuDBNeu/sMZwdxTsVn82v38yJPONkUxBLVmfvsv+tPCfl91Coi+t
         Ds4cpEiY5ReNGrEyMtwGYAMfDiMYxwJCzwjful8oUF5vu0brkc+Rue0OESWNziXUZGSL
         t46g==
X-Gm-Message-State: AC+VfDxEw5PIwe97bwFSRYu2h1bh4VGd1IeRud2JnCNX+z2y+pmdtFvT
	9GkIHDwmRxvWpzLV3jJJOx4R039JsMrTuXWvQk4=
X-Google-Smtp-Source: ACHHUZ6sJBL5GNdhsEYV3+MeHIYFnnbnmPGSUgcA2tVChMBA7flcbyzG0ehzSjSFgXUO74TJ3BUZ/WQ5rMjTT0TByU8=
X-Received: by 2002:a05:6402:190a:b0:51a:493e:3212 with SMTP id
 e10-20020a056402190a00b0051a493e3212mr19871287edz.17.1687578141048; Fri, 23
 Jun 2023 20:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-8-alexei.starovoitov@gmail.com> <280a8fd5-6bc6-7924-30e3-412d5bc3c3e0@huaweicloud.com>
In-Reply-To: <280a8fd5-6bc6-7924-30e3-412d5bc3c3e0@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 20:42:09 -0700
Message-ID: <CAADnVQ+ROd__AXmHcUTy3j8zYL7zr6brA3swS9P6OmN_2BwcrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf: Add a hint to allocated objects.
To: Hou Tao <houtao@huaweicloud.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 8:28=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> >                */
> > -             obj =3D __llist_del_first(&c->free_by_rcu_ttrace);
> > +             obj =3D llist_del_first(&c->free_by_rcu_ttrace);
> According to the comments in llist.h, when there are concurrent
> llist_del_first() and llist_del_all() operations, locking is needed.

Good question.
1. When only one cpu is doing llist_del_first() locking is not needed.
 This is the case here. Only this cpu is doing llist_del_first() from this =
'c'.
2. The comments doesn't mention it, but llist_del_first() is ok on
multiple cpus if ABA problem is addressed by other means.

PS
please trim your replies.

