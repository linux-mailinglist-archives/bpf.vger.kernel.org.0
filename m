Return-Path: <bpf+bounces-8920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6D78C7AE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442DD28128C
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668F156CC;
	Tue, 29 Aug 2023 14:36:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307F28E7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 14:36:02 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A5107;
	Tue, 29 Aug 2023 07:36:00 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so28293426d6.3;
        Tue, 29 Aug 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693319760; x=1693924560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drwaNkuS46JRkYecGIeoOOmraJmB+y74WB80chz13hk=;
        b=oGVkZ2byUxygVUDeQVCnsRw8Gq205GmD5c62CljPUCrDJkcvvOM+xLuhOBnaK4aOME
         CewTyJbEGlAi8Y18UL6wAF8mB/ZASd/ewle1iB3C5Qd/rsr0sfPynFPhkPBUSUHxBOq7
         x2iLdoOM2SFoeK3gh8OjCsef7WhsuHelhm58ffX0IzOS4dWN3KpXPcgSYUNlEgbsWpfI
         QiJfpUqrM2k38nxSatsPXE3Rd9e8NTBrCynPRunItMDhaJJiA9e0CPbPv9XiUSXhmkk7
         LGZgO/pwwMBhKqT8WvDbfTb05JfuELFiHU/7amR4NnnYbpSq6V7PiLDikzHKpzMYUYpO
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319760; x=1693924560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drwaNkuS46JRkYecGIeoOOmraJmB+y74WB80chz13hk=;
        b=lNROuYoUUjU1a5MBXDnHnE6VdQMOk99hyieLiHXfTlpVszVzXQmjWFWb46ZJ0p4T2W
         yfKRN/ZyEuLF/o2s5Z17jkii7+BJYLiQ587jDPQkNgLKMi2WzYTbMjWN24RsylNowABb
         vYBXdz9su8vI0USFliRYNftSpozZCMDkdMpMED9dZfhgSydcx19xn1K+teyedZTrYNuu
         qD/LXYHrzFQLq5zgKD2QbMnkSGPrViAPpTEufz9E0PJzSOVb36JMe0lsWhvys8ts8MyU
         YLiU4EYa2ZUgj7jskGajvz5hMii/JGSWtWGzJQjzd6gYZjwJPVZmHT1Ch+zsk1jHxQid
         6Jeg==
X-Gm-Message-State: AOJu0YzqUjfmsfPzr6d4Pd2Jj5cauWhfIM9ue4dofbes7PibyHhttMI9
	LgtMlpsO2ge2PR3mlKD8r7nkvTllTJ2j5rfhU/w=
X-Google-Smtp-Source: AGHT+IF/BTiuQAwrAS4e05Q3RHiP0jBygyR+rVAqBUWROoZ3QrFLW5h2/dQYI/pCpEOy+QlbP9tWnWUiISFGiJ1Nwxg=
X-Received: by 2002:a0c:aa19:0:b0:651:5d2f:991a with SMTP id
 d25-20020a0caa19000000b006515d2f991amr6517923qvb.46.1693319760048; Tue, 29
 Aug 2023 07:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025630.3735-1-laoar.shao@gmail.com> <20230709025630.3735-10-laoar.shao@gmail.com>
 <a35d9a2d-54a0-49ec-9ed1-8fcf1369d3cc@isovalent.com>
In-Reply-To: <a35d9a2d-54a0-49ec-9ed1-8fcf1369d3cc@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 Aug 2023 22:35:23 +0800
Message-ID: <CALOAHbDAMrD6iR_V4ZFx-HukFEBiEqjLC4uagFWH0ydDr_gpEA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpftool: Add perf event names
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 5:20=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> On 09/07/2023 03:56, Yafang Shao wrote:
> > Add new functions and macros to get perf event names. These names excep=
t
> > the perf_type_name are all copied from
> > tool/perf/util/{parse-events,evsel}.c, so that in the future we will
> > have a good chance to use the same code.
> >
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index a4f5a436777f..8e4d9176a6e8 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
>
> [...]
>
> > +#define perf_event_name(array, id) ({                        \
> > +     const char *event_str =3D NULL;                   \
> > +                                                     \
> > +     if ((id) >=3D 0 && (id) < ARRAY_SIZE(array))      \
>
> Hi Yafang,
>
> I'm observing build warnings when building bpftool after you series:
>
>     link.c: In function =E2=80=98perf_config_hw_cache_str=E2=80=99:
>     link.c:86:18: warning: comparison of unsigned expression in =E2=80=98=
>=3D 0=E2=80=99 is always true [-Wtype-limits]
>        86 |         if ((id) >=3D 0 && (id) < ARRAY_SIZE(array))      \
>           |                  ^~
>     link.c:320:20: note: in expansion of macro =E2=80=98perf_event_name=
=E2=80=99
>       320 |         hw_cache =3D perf_event_name(evsel__hw_cache, config =
& 0xff);
>           |                    ^~~~~~~~~~~~~~~
>     [... more of the same for the other calls to perf_event_name ...]
>
> (using GCC 11.4.0)
>
> Could you please send a follow-up to suppress them? We're always passing
> unsigned, so it should be safe to drop the check on (id) >=3D 0.
>

Thanks for your report.
will send a fix soon.

--=20
Regards
Yafang

