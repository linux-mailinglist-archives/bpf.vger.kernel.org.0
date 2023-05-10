Return-Path: <bpf+bounces-268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F379D6FD3E0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239C01C20CBA
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801762F;
	Wed, 10 May 2023 02:39:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA9361
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 02:39:25 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9358171A
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 19:39:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7576e0b14ceso213348685a.1
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683686363; x=1686278363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skPmxxHvH/Hd8IEIxd/eYF4sKuwf9IJiJmWldmr/07o=;
        b=orzvMAZnlCB1kuVNFObebuMua1DSRA8CJT2DmN1EYzE2UQNSr1+HpYZSM3MDCT9kTL
         jTj7/YRfd576kD1qixo6xG/zU3nG5AhYIEuk+zu6S0JGphFEfuxbSdIpWNX2ko8NaJIm
         er1pzlYuLAGBaDfbqaxMWkgbOoVrFxtdFKPneY+rMp2tDsbMq3dUTGkxy03lW82dZJrf
         0RFbSMxhd9WNjSTmMqkJQjT6V6NufGg73lneVOWb/FpSbAlQD4iYnRScVtjgoXQ2dKIz
         /AVrUzhIED1SE5RB84jTn6Ff0S1xvDsNF5h9/1XfM+1jGaPrlPTeiYI2NQEhp3y8kr/i
         UMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683686363; x=1686278363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skPmxxHvH/Hd8IEIxd/eYF4sKuwf9IJiJmWldmr/07o=;
        b=NV3K1b+dknSGSaqkhJ0zJDRY6nPXkQ/PjuPTB7u/SKbjvfmFZseRaDfMxNFPZp1P/n
         HnYQPcAg4UhSP2fugMTM5J5JyAWsIvtGdqLRIZzCPbMy6X5exi5ucDe3s9aE5ueO+2NX
         xRowdnKBR6h8mBchiGFSiZgoJ/2KvZhpnwMFz+SYFr8YapUZ/wlDrkpwXktxRd/jNoxK
         11O/OBfx4zzWYsqwxJybWRkv/UFGD1nc5BFJGiWrScXllsu0G4EM2RY9MOtCvC3uJpHr
         8nSACMZ6imbMn1rAvPw/fqQ4j65BTnwZkQCKsG20h+893QOaTp6WLsrjGwuKlAbQO7TM
         6xYg==
X-Gm-Message-State: AC+VfDyx/XwJFZYK5z6ZdbgLeqM242NwUT3PKVmfx4qRr+xHQMQjNqNp
	Z2Zrb4GYSClVy63ZijW12chKl4JFr41d6j1RAnk=
X-Google-Smtp-Source: ACHHUZ703QTwksufCq3h9RyoGTUmPc2NsOJsLvuDx3CVkVpQMs5c0p+bASks/bLlZp5x7gvCROp0N3fcT0vGauSVRag=
X-Received: by 2002:a05:6214:29e4:b0:621:3979:9be7 with SMTP id
 jv4-20020a05621429e400b0062139799be7mr5717014qvb.23.1683686363032; Tue, 09
 May 2023 19:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-2-laoar.shao@gmail.com>
 <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com>
In-Reply-To: <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 May 2023 10:38:44 +0800
Message-ID: <CALOAHbCkBCdApV+itpoNJGnbhZM=3QqZoND5i3ur4CimKf+JTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix memleak due to fentry attach failure
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 1:41=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 9, 2023 at 8:15=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > If it fails to attach fentry, the allocated bpf trampoline image will b=
e
> > left in the system. That can be verified by checking /proc/kallsyms.
> >
> > This meamleak can be verified by a simple bpf program as follows,
> >
> >   SEC("fentry/trap_init")
> >   int fentry_run()
> >   {
> >       return 0;
> >   }
>
> Nice trick! We can build some interesting tests with trap_init.
>

Good suggestion. I will think about it.

> >
> > It will fail to attach trap_init because this function is freed after
> > kernel init, and then we can find the trampoline image is left in the
> > system by checking /proc/kallsyms.
> >   $ tail /proc/kallsyms
> >   ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
> >   ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
> >
> >   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_in=
it'"
> >   [2522] FUNC 'trap_init' type_id=3D119 linkage=3Dstatic
> >
> >   $ echo $((6442453466 & 0x7fffffff))
> >   2522
> >
> > Note that there are two left bpf trampoline images, that is because the
> > libbpf will fallback to raw tracepoint if -EINVAL is returned.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> I guess we need:
>
>  Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>

Thanks for pointing it out. I will add it.

> > ---
> >  kernel/bpf/trampoline.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index ac021bc..7067cdf 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -251,6 +251,15 @@ static int register_fentry(struct bpf_trampoline *=
tr, void *new_addr)
> >         return tlinks;
> >  }
> >
> > +static void bpf_tramp_image_free(struct bpf_tramp_image *im)
> > +{
> > +       bpf_image_ksym_del(&im->ksym);
> > +       bpf_jit_free_exec(im->image);
> > +       bpf_jit_uncharge_modmem(PAGE_SIZE);
> > +       percpu_ref_exit(&im->pcref);
> > +       kfree(im);
> > +}
>
> Can we share some of this function with __bpf_tramp_image_put_deferred?
>

It seems we can introduce a generic helper as follows,
  static void __bpf_tramp_image_free(struct bpf_tramp_image *im)
  {
      bpf_image_ksym_del(&im->ksym);
      bpf_jit_free_exec(im->image);
      bpf_jit_uncharge_modmem(PAGE_SIZE);
      percpu_ref_exit(&im->pcref);
  }

And then use it in both bpf_tramp_image_free() and
__bpf_tramp_image_put_deferred().
WDYT?

--=20
Regards
Yafang

