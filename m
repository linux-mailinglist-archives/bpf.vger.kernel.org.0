Return-Path: <bpf+bounces-3477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E70A73E71D
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4141C209C3
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4A134B8;
	Mon, 26 Jun 2023 17:59:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21C12B9C;
	Mon, 26 Jun 2023 17:59:55 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E09134;
	Mon, 26 Jun 2023 10:59:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b466744368so54158991fa.0;
        Mon, 26 Jun 2023 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687802392; x=1690394392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W2Vu6H3RZPcR125CB3aaW89Om4/7DJA4ZWdtcc1FEM=;
        b=dV8emcZZAUyiyZNzHDvOIzlNdhMA6E6J924vtGJ4dLdMFOdPHZzSMYIbw2WG3Oc07s
         pAlFOY+OsRVyyxWKOjHCdfkZnIR3jrCRYgaePv1UQPry10QjKCisdLeFKWjxov5io6ix
         rvs1EeUWi2mszD277Yv18dC2SjOItnT2LOOY42qzCEhD02oXfJ45T3vRXb909VsDEB6v
         yZ2o1+O1VGYDIwJ47u99uzWXqx6rPGKxLODTpUfZsBIbxUR6FcBn8s+XaMnzLKEYNe3w
         IYVebSmKpVSfiWokHyZTw7InFcY5MFgo807x+yl4ABQCPz8LBurwiRNaNUCG00FvkHid
         cLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802392; x=1690394392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W2Vu6H3RZPcR125CB3aaW89Om4/7DJA4ZWdtcc1FEM=;
        b=NOdC8nXvRM9/SG1YPBTlSwhs3NXq0JmuaUx78EqgSyC6GKbXbzA1zYvdLiWxgUOl2I
         G3JGpCPBgAEUw7mDZoYmVybDcHJOyg/AoaS0ITItbX76KmVQLgFy/fG83r03bZiG4+Go
         YqSAvahvofrfW9xCtM5z8HfwaYQnFcoIwzESmixnGKmZvGWcy6bxiMsCKxk4mZs/c5+A
         QYpjhhW3Ou3BPsVZNDefrKE2/aB5dNWU8UJRzNxYuOANJZhCxCOU5/vYezW0Y5/lW1ad
         Ew437uGkmQpXNbJ5rdq5NxJ3cZ0a6P36scpe8EoNKjpgrn5x8yg2yFyRSUnCCCh9Ci0W
         7QKA==
X-Gm-Message-State: AC+VfDy3SdClmU2f/lmyFc60pLSl9wLP3qLVwZDmwbBaF9n9ZSuJdZ7y
	BnY5zNJTxKnlC9jz/Q4leT0AmG+Yz9CBw+DxIpo=
X-Google-Smtp-Source: ACHHUZ5UI/NF9B52J0wA6As3GXR8+axwHNPhmShfQDrziWpavyo7MHNzGTtQp0uf1ipvBNz1cpL1oYMdPlscdJZsfcc=
X-Received: by 2002:a2e:9c4d:0:b0:2b6:a841:e66d with SMTP id
 t13-20020a2e9c4d000000b002b6a841e66dmr485980ljj.37.1687802392087; Mon, 26 Jun
 2023 10:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-14-alexei.starovoitov@gmail.com> <20230626154228.GA6798@maniforge>
 <CAADnVQK7rgcSevdyrG8t-rPqg-n8=Eic8K63q-q3SPtOR0VP2Q@mail.gmail.com> <20230626175538.GA6750@maniforge>
In-Reply-To: <20230626175538.GA6750@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jun 2023 10:59:40 -0700
Message-ID: <CAADnVQ+vBRZ3ySX-YOVQnfL-J4UV1pJymXxee-AqjGGAHtv2Jg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
To: David Vernet <void@manifault.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
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

On Mon, Jun 26, 2023 at 10:55=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> > > > +
> > > > +     migrate_disable();
> > > > +     bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
> > > > +     migrate_enable();
> > >
> > > The fact that callers have to disable migration like this in order to
> > > safely free the memory feels a bit leaky. Is there any reason we can'=
t
> > > move this into bpf_mem_{cache_}free_rcu()?
> >
> > migrate_disable/enable() are actually not necessary here.
> > We can call bpf_mem_cache_free_rcu() directly from any kfunc.
>
> Could you please clarify why? Can't we migrate if the kfunc is called
> from a sleepable struct_ops callback?

migration is disabled for all bpf progs including sleepable.

> If migration is always disabled
> for any kfunc then I agree these migrate_{en,dis}able() calls can be
> removed. Otherwise from my reading of the code we'd race between calling
> this_cpu_ptr() and the local_irq_save() in unit_free().
>
> Thanks,
> David
>
> > Explicit migrate_disable() is only necessary from syscall.
> >
> > I believe rcu callbacks also cannot migrate, so the existing
> > code probably doesn't need them either.

