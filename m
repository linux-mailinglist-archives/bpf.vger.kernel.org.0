Return-Path: <bpf+bounces-2215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81231729499
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379F72808F2
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B3125DD;
	Fri,  9 Jun 2023 09:18:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CAC8FA
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:18:08 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67B46AB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 02:17:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6261d4ea5f0so10660616d6.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686302197; x=1688894197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQpA01jqc3IBuEgnVsI0JoxetekzbG/1jNeCr8p4usM=;
        b=Vvc3vxGl5itL5moPLMfz0wARhGJGDdSsMBekrkAeBQtNRS7siCiSO16MJO2tXSKvMo
         WU27TW4kSrle7cYx4vhCxSk3ywIitQ3YPx/8iV9RAkFgYjhyawkeNa1/wliHrxC4n9RJ
         xuagj9EqECKOlBw70FkOvml2DxLj/h7MInl9h78WGcgAf76O2bBYF5j8csxA6d4GCkMI
         Lt4DfeaWoofb5Jkd7hSzkxfZAJq95boNu8hU1gZg8Y3T6OIW6eQo9S1bKLzRiV7JRBf2
         XBykuM9dUJyaBVm94iZpb0YlfYhK5Ruqt6vU0+pjWgr8gw94TVRruGfa8GPZAzJ9Fx9h
         aVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686302197; x=1688894197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQpA01jqc3IBuEgnVsI0JoxetekzbG/1jNeCr8p4usM=;
        b=dfRf0zoBX9tVyUTIWJCiljLav9FYIJ+PmI4+ONgksagga9YnJxdTSpwfk7oTFir3OB
         MZgGZ5l/IvPvAiubzIgf2UbbjctnfDlD1dECBDDTycftvgqAu9PWpcVTQc7882dejTXa
         8IPVDnczQU6lHU5BfhTnGrJ5+fpCN+ISaNQbbrkdVn/gVDNpQxfOdBQuANnk/HKRicZG
         AwjHYF37pxLxqCkAvSpiYoH+TjrILc0qvK0/M0pOlyX9ReoTYTKaBASq3OT+tU0ODraV
         FLtyhyxoPfq17t/Tqa8Jt6tPm5XBJQSlwf/vehrOqg9QwMCirzsGKgX6IGewRxcC6Bqh
         eUrg==
X-Gm-Message-State: AC+VfDwwMlcrHtErvRQD2mvb2AB3Flwu4QV53goGo7okrsqnlBXV1obY
	eGeGdK8OZ/vEtL4T2rFDssGZwoaaWMw2zaxZ8yk=
X-Google-Smtp-Source: ACHHUZ5kgPGZTkOE3FLrAffqF558oeYuGAhjknSSDvpFijmVTwp1MtxtW+E4O/AZJ3k9MHg11DU2iKQ4hpsdY9ukVrM=
X-Received: by 2002:a05:6214:d62:b0:625:b3a2:f64a with SMTP id
 2-20020a0562140d6200b00625b3a2f64amr914190qvs.46.1686302196745; Fri, 09 Jun
 2023 02:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-5-laoar.shao@gmail.com>
 <CAEf4BzYMnhqguqYCXBfKLzh8S+nAKScqBiG6pFxC8ay2KzfLLw@mail.gmail.com>
In-Reply-To: <CAEf4BzYMnhqguqYCXBfKLzh8S+nAKScqBiG6pFxC8ay2KzfLLw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Jun 2023 17:16:00 +0800
Message-ID: <CALOAHbBqk94CMCiavJGL-nM_saL=Xa7cFv8C4r31q9Lm23uQ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/11] bpf: Protect probed address based on
 kptr_restrict setting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 7:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > The probed address can be accessed by userspace through querying the ta=
sk
> > file descriptor (fd). However, it is crucial to adhere to the kptr_rest=
rict
> > setting and refrain from exposing the address if it is not permitted.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/trace/trace_kprobe.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 59cda19..6564541 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event =
*event, u32 *fd_type,
> >         } else {
> >                 *symbol =3D NULL;
> >                 *probe_offset =3D 0;
> > -               *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> > +               if (kptr_restrict !=3D 2)
> > +                       *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> > +               else
> > +                       *probe_addr =3D 0;
>
> kallsyms_show_value ?

Will change it.

--=20
Regards
Yafang

