Return-Path: <bpf+bounces-3417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A273D6ED
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 06:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE921C2074E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B672ECF;
	Mon, 26 Jun 2023 04:42:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82B811;
	Mon, 26 Jun 2023 04:42:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A2AF;
	Sun, 25 Jun 2023 21:42:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso470819e87.0;
        Sun, 25 Jun 2023 21:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687754551; x=1690346551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3h7L5KK2YTMwrKDArFiGd9EeO5FA7pCPSSnMqtLF+E=;
        b=YrsOdiLkZDFUMNmZZFFNpblQAl6koFjTjunJ73jBnQrXyUXgURZvg+dkcplY2H8g+x
         PSzrqwZQdToKXX00YdGJ9CYLtmJl8zez8X78qtdK+Kuu5GxgjQEF3EkmhrG+Gr2v7/JO
         3kNKY/obvmvV9Iuq9GsOgLuoRVBfZVnQQtXQwDFKM/EEfW7/gdXIm57+ePId+MgrRsUy
         zspEM2IEXeh26Dfx19PoFGTcyJPG+d1mqf6xkrzaIN9tJ07jcpwPIcoy3ckFTX2OByja
         V/rBZ9Oc9Vi870BzljFHGIu7eEOFiFeTmym27v5RVLWx4YCdt19pg2j7v6HRLRpCHTVR
         E7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687754551; x=1690346551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3h7L5KK2YTMwrKDArFiGd9EeO5FA7pCPSSnMqtLF+E=;
        b=aJNlCShlyzCWvybhoBSxki8MzpNnPc33ZyoCzCRSTsiwpfhYzqaVbg4ZtX2B/JI5Pc
         bcBsaYf0Lai3RWN6D/9ntg6w4D39XJPEXZaD+4cJ0jQycvSG5N7LP6Hn/2iws0+qDhBH
         UYTRvmNNUUT58RhIoYHJkJfkMALT9WFpmUfwflD1FEgxbW1GW8b6B9wIvvwnoa/IlVd/
         ozvTYE+7/H5luGKWXpeyEQXL3Oz+tDy/XLASo8tAYSWlUTvc2Y5S3mShb8NVL1AZZ1us
         jjXi1505sSxmg2gCBq0daTXSls3gsiYVBm9dn7sjtUDszFYD43nLtPGuCmFz+pnW9vaz
         k32A==
X-Gm-Message-State: AC+VfDxYD98rn7j2fMagUck63WHiFmZnNVRm0bn767VanafOS4gCXOxq
	HkqZ1HY05uH6FS3QtK3egpc3VYJk/E49uO/tb2s=
X-Google-Smtp-Source: ACHHUZ4untQ4l938xlI1Bn4p87dXnSG8eM2H3RIECK04ZeEHVTMp1izXxxpPkBQDv8DCZDJD8CNetYUdSplfLWQSaU0=
X-Received: by 2002:ac2:5bca:0:b0:4f8:67e7:8a1c with SMTP id
 u10-20020ac25bca000000b004f867e78a1cmr6932337lfn.45.1687754550787; Sun, 25
 Jun 2023 21:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com> <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
In-Reply-To: <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 Jun 2023 21:42:19 -0700
Message-ID: <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
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

On Sun, Jun 25, 2023 at 8:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> > Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary km=
alloc().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/memalloc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 692a9a30c1dc..666917c16e87 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, in=
t cnt, int node)
> >       if (i >=3D cnt)
> >               return;
> >
> > +     for (; i < cnt; i++) {
> > +             obj =3D llist_del_first(&c->waiting_for_gp_ttrace);
> After allowing to reuse elements from waiting_for_gp_ttrace, there may
> be concurrent llist_del_first() and llist_del_all() as shown below and
> llist_del_first() is not safe because the elements freed from free_rcu()
> could be reused immediately and head->first may be added back to
> c0->waiting_for_gp_ttrace by other process.
>
> // c0
> alloc_bulk()
>     llist_del_first(&c->waiting_for_gp_ttrace)
>
> // c1->tgt =3D c0
> free_rcu()
>     llist_del_all(&c->waiting_for_gp_ttrace)

I'm still thinking about how to fix the other issues you've reported,
but this one, I believe, is fine.
Are you basing 'not safe' on a comment?
Why xchg(&head->first, NULL); on one cpu and
try_cmpxchg(&head->first, &entry, next);
is unsafe?

