Return-Path: <bpf+bounces-297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CCD6FE18F
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1271A1C20D8E
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424C31642D;
	Wed, 10 May 2023 15:31:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EA125B8
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:31:16 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFF30D4
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:31:15 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-61a4e03ccbcso67906826d6.2
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732675; x=1686324675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdwzi1J+B5EFcpDsxodnqnKAPkVedX2Qve5Tc9l6ANo=;
        b=ZaKpldo4VDg9hkrTIPJ21r4YZUAcCauLiWeVcIeMSJ3MJxcFqjcAyVtECHurNzrdbQ
         fDNU3B9nDIL5dGdQmwujH1M2BTF+UkjwsZBKZXFrwAZdWJz3J9R2KF6O6nri0W5UXzn7
         EHpPic7MogSX7vIOfkxCAgFnzVa7bAFmArl2OKlMU/2IJPNkc5oOMaPoizB7lAFc0yp5
         DsUXEO+lM2hsTgKO8dZaQyAyp/8Q8zn0Djfp8AZHCNh5QUoxp6aDjB9D4hKi6ux4thD0
         6K06q49B9yi3jskiwkOFqQnZd4BaYVDBP/d90+R9p8W+8HBvSBB8CN0m66LFv8PII2iB
         Mg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732675; x=1686324675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdwzi1J+B5EFcpDsxodnqnKAPkVedX2Qve5Tc9l6ANo=;
        b=k7FLo8JhqqvhMfxxIVDVy3sGE7Fmbuk4EU4g4lw8puzDAkFXK68Abka5ffe1uNv3OT
         spt4a9fxQjQnz7pWWTH+qEAfmQ/N3C1n2xX4mmSP6KTp5c8kzuRQjdEu95P4oEPZ15LO
         4a0oPvq8ut5xcH+uBABG/31vAQPdiTE5CXFQsWRW05gYfCWPH/2nS/QWgLcznJ1Qn6Xh
         5uXnD5E5O/UUqWpoiYENWNBA3CU29hrh0B3QbcO/YQhAGHBhg0G85gACB4D/HGRjtIDl
         uT+Y9BskmheZzftBliJyQrV3oSM9YEl0KhEXjxvywiIDCbU9zTodZGf12EimA5L4+Xa8
         UNMg==
X-Gm-Message-State: AC+VfDxrheijFUHZM5ru5ahfz6jzd1U5IAO7DFOEvajSHSGQGH3YRvfc
	7gUiZ1oyH86VUJlJVRuWbrlaq1SGgU4DyS2Cp84=
X-Google-Smtp-Source: ACHHUZ5e0LaPNfdOnm0OgPn7SSfgikBwyqDfuGEYoKTxWNZX7FFKLMPK4dFPKuUvfRuXUfrtAnF/lq9gqa9KJaHm9d4=
X-Received: by 2002:ad4:5e88:0:b0:5ef:4565:a441 with SMTP id
 jl8-20020ad45e88000000b005ef4565a441mr27715222qvb.13.1683732674840; Wed, 10
 May 2023 08:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-2-laoar.shao@gmail.com>
 <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com>
 <CALOAHbCkBCdApV+itpoNJGnbhZM=3QqZoND5i3ur4CimKf+JTA@mail.gmail.com> <CAPhsuW5CbV_jcQv4FOB429oOY+3=KansOkOVqrfXhqeb_hMpnw@mail.gmail.com>
In-Reply-To: <CAPhsuW5CbV_jcQv4FOB429oOY+3=KansOkOVqrfXhqeb_hMpnw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 May 2023 23:30:38 +0800
Message-ID: <CALOAHbBhT=8Q5uSyiV-q8JdR0qUgL+K6tJ=g+=TNsW5nWH2vvA@mail.gmail.com>
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

On Wed, May 10, 2023 at 2:24=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 9, 2023 at 7:39=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Wed, May 10, 2023 at 1:41=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> [...]
> > > > +static void bpf_tramp_image_free(struct bpf_tramp_image *im)
> > > > +{
> > > > +       bpf_image_ksym_del(&im->ksym);
> > > > +       bpf_jit_free_exec(im->image);
> > > > +       bpf_jit_uncharge_modmem(PAGE_SIZE);
> > > > +       percpu_ref_exit(&im->pcref);
> > > > +       kfree(im);
> > > > +}
> > >
> > > Can we share some of this function with __bpf_tramp_image_put_deferre=
d?
> > >
> >
> > It seems we can introduce a generic helper as follows,
> >   static void __bpf_tramp_image_free(struct bpf_tramp_image *im)
> >   {
> >       bpf_image_ksym_del(&im->ksym);
> >       bpf_jit_free_exec(im->image);
> >       bpf_jit_uncharge_modmem(PAGE_SIZE);
> >       percpu_ref_exit(&im->pcref);
> >   }
> >
> > And then use it in both bpf_tramp_image_free() and
> > __bpf_tramp_image_put_deferred().
> > WDYT?
>
> How about we also use kfree_rcu() in bpf_tramp_image_free()?
>

Looks good. I will change it.

--=20
Regards
Yafang

