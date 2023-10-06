Return-Path: <bpf+bounces-11510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211607BB039
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 04:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FC81C208F8
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A81846;
	Fri,  6 Oct 2023 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQgINzXe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616F139B
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 02:17:54 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940FFD8
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 19:17:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77574c6cab0so112577385a.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696558672; x=1697163472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grhpQ/PbY72rnpOUw+kFfykae59gXOwwLnvks8i61qQ=;
        b=WQgINzXeFtNq+1WVEMdtYokcSXAboo1tnK3GZOiey0gPbAWLpDGnjwyPzrMmiLUic0
         dgRin/asuQV6JC9yNccaHtCxI5y2Et1WOey9WShD140Qowu48NqPFX23CTuaQQysJUTN
         h4AH0xN13TKYk6OWQuuzgpR4zxZvMBVspy6yRBu+s2ibvD4Jt5TkJ8STNlzu4baQ6caG
         5RE3PtHIb69u4I4c9HAJIfI/TJOB3+nZ85Qs2HSJJDHXSKZ/B4dICc86GfyGrVolJe9m
         OlwVXFCXa1HruDmYq7BsfxOy47MKIhkVGpveUoST3iUuE0AhOvSNhRQ+zSQ8cWTe5mGw
         8Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696558672; x=1697163472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grhpQ/PbY72rnpOUw+kFfykae59gXOwwLnvks8i61qQ=;
        b=tzuCwlKBQgHVJ+I9+l51zUaIDRZ8SQrDU2QMg75tHILA2RzgsMpSUyltrGztSZw6im
         EQm6/ykjrH3jjp3QOANDnz+/Djc0ZCmrfYfbBlzxWnvx50DPccMZzjdxsjLkrVYUWxhr
         uXPSTzpni68kKNFNzbVPQOt8oDUy+xh0sv9TakUnw7R0DhzgbhMug0Zka//QvGAb3Ac7
         WvDq4p28YmuR3sjPcg6pK3moBVicJEFrOaQAW8DAu3hCbcVIlVH1cNuEjT+cuW6irjwb
         2qvf3UpMbfQ5h+XxPtqnMNBxqm+66vNK8rVqDrMboMPR0q/iJcZ784fwADEl6GsNH34f
         OEtQ==
X-Gm-Message-State: AOJu0YyQqhlvOz/7yv0c/F+cNr+ugTGbM2iGtpNg0MX3Fe4uE3symO97
	sGcnbUVPYXGPiQRwgfv/NvdDsTyF4R9LF02cN25lb9tSevmi7Q==
X-Google-Smtp-Source: AGHT+IHgAC7yVXu54YslDQMhcf1P8wPKo4Lk/o5d69Yv7abpTLHpnUv9D/lj+Baex9d83+7pmw1bdwavy8LaGPICkXY=
X-Received: by 2002:a0c:e78b:0:b0:659:5839:f811 with SMTP id
 x11-20020a0ce78b000000b006595839f811mr6908134qvn.57.1696558672676; Thu, 05
 Oct 2023 19:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005083953.1281-1-laoar.shao@gmail.com> <20231005083953.1281-2-laoar.shao@gmail.com>
 <ZR7uxCMaWlfEBkBJ@google.com>
In-Reply-To: <ZR7uxCMaWlfEBkBJ@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Oct 2023 10:17:16 +0800
Message-ID: <CALOAHbAMR=BNEa+CU8XiSTaqQB6SckDYhhiEq-iuMWUBE4kKzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for sleepable bpf_task_under_cgroup()
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 1:13=E2=80=AFAM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 10/05, Yafang Shao wrote:
> > The result as follows,
> >
> >   $ tools/testing/selftests/bpf/test_progs --name=3Dtask_under_cgroup
> >   #237     task_under_cgroup:OK
> >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > And no error messages in dmesg.
> >
> > Without the prev patch, there will be RCU warnings in dmesg.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/task_under_cgroup.c   |  8 +++++--
> >  .../selftests/bpf/progs/test_task_under_cgroup.c   | 28 ++++++++++++++=
+++++++-
> >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c=
 b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> > index 4224727..d1a5a5c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> > @@ -30,8 +30,12 @@ void test_task_under_cgroup(void)
> >       if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
> >               goto cleanup;
> >
> > -     ret =3D test_task_under_cgroup__attach(skel);
> > -     if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
> > +     skel->links.lsm_run =3D bpf_program__attach_lsm(skel->progs.lsm_r=
un);
> > +     if (!ASSERT_OK_PTR(skel->links.lsm_run, "attach_lsm"))
> > +             goto cleanup;
> > +
>
> So we rely on the second attach here to trigger the program above?

Right.

> Maybe add a comment? Otherwise we might risk loosing this dependency
> after some refactoring...

Sure. will add a comment.

>
> Other than that, both patches look good to me, feel free to use for both
> if/when you resend:
>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Thanks for your review.

--=20
Regards
Yafang

