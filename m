Return-Path: <bpf+bounces-8956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF978D22E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7981C20A88
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC031106;
	Wed, 30 Aug 2023 02:42:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2DEDD
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 02:42:03 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD50CF4
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 19:41:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76da819edc7so19742685a.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693363318; x=1693968118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUWyjTxXtFTpLVU9wbsrGyrdqZFWNkCspwuEhZf4Dmo=;
        b=ZjduJF50AbLG6wQ1LShdSj3zPdVgKm4phvi7l6ZqroHj09M7aOgp9r6tveiJidFcY3
         6ueEoyD6KnBGIYJWTpjevPnW6x1XAON5pOfeb8hkI594MfygCOrj5Rhk//s1wYWKbQWz
         IWJy81WPztCVtE0f1Va1El1ePCTbAv71XZ9Lzms3xhkRw1Ebh8vfNBcRTgyWDwl2miau
         KsrfM++gA98kkLPaZqEyJ4WbH135TdlFaKEWIgnudnHZfkVUgGNe8IQwqx8nEyepgDYi
         +t+TrgWtw0YhPj8+hu2A7E6vkpwmQC0CXuSNapwE/LUi6B/J+otuCw2Rms7S9m/8xAzp
         qdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693363318; x=1693968118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUWyjTxXtFTpLVU9wbsrGyrdqZFWNkCspwuEhZf4Dmo=;
        b=bSi11KjTsLvt+Lf2RWebOa7HARq8NFSdLYldHkpj4Mm/p6qTewShKis9P7eJMdxpW4
         3BWjPHKW6urzPtmmSHBnWzlMH2fIQWf93QLzQlIKtuoqwiNAHYWL+q5ESXxtyncZ6w2i
         5TN14eJZeG/Ajjv2frZx0dWVY6vgNlhGQ+iLRHNLqYu3v1yufzI3pMULa0MGNWkcGWG9
         9ma4+1nEvYuslN+5JV7KYTmBjZ6G56RA+CQEk64dT8EwLfOddRhu5ODdd2rcgz2GcQpB
         wQGpgce0Qpmf7MzTW+hSwCgJIc4s0nSBKLuo3JRDnilnTXJFkSrw+rWgSEf05REk5OUm
         v4dA==
X-Gm-Message-State: AOJu0YxtL8UkfdYET5DrzU09sGVpVBd25d1ht6yUBKQuokAnZ1kJQtyW
	xYXYtYBFlGSfF48Sy8pqjAm5nfHnh7M+MeZpHgY=
X-Google-Smtp-Source: AGHT+IFNtd+N7S5Uk7wWLjUuMGEeNgiEHJ97gQVTV1I25UniruEuiuSmMqcMid+2KVbdtv1pK//trpjICFWYhbYJjpM=
X-Received: by 2002:a05:620a:2584:b0:765:42cd:c192 with SMTP id
 x4-20020a05620a258400b0076542cdc192mr4944794qko.37.1693363318556; Tue, 29 Aug
 2023 19:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829154248.3762-1-laoar.shao@gmail.com> <af79f4da-232b-4990-b7c0-74b4708953ba@isovalent.com>
In-Reply-To: <af79f4da-232b-4990-b7c0-74b4708953ba@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Aug 2023 10:41:22 +0800
Message-ID: <CALOAHbA52vixuwO6jPD5G9zPfGZijK7zwzsb007EmaCK5f749g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Fix build error with -Werror=type-limits
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 11:51=E2=80=AFPM Quentin Monnet <quentin@isovalent.=
com> wrote:
>
> On 29/08/2023 16:42, Yafang Shao wrote:
> > Quentin reported a build error as follows,
>
> Just a warning :)

Will reword it in the next version.

>
> >
> >     link.c: In function =E2=80=98perf_config_hw_cache_str=E2=80=99:
> >     link.c:86:18: warning: comparison of unsigned expression in =E2=80=
=98>=3D 0=E2=80=99 is always true [-Wtype-limits]
> >        86 |         if ((id) >=3D 0 && (id) < ARRAY_SIZE(array))      \
> >           |                  ^~
> >     link.c:320:20: note: in expansion of macro =E2=80=98perf_event_name=
=E2=80=99
> >       320 |         hw_cache =3D perf_event_name(evsel__hw_cache, confi=
g & 0xff);
> >           |                    ^~~~~~~~~~~~~~~
> >     [... more of the same for the other calls to perf_event_name ...]
> >
> > He also pointed out the reason and the solution:
> >
> >   We're always passing unsigned, so it should be safe to drop the check=
 on
> >   (id) >=3D 0.
> >
> > Fixes: 62b57e3ddd64 ("bpftool: Add perf event names")
> > Reported-by: Quentin Monnet <quentin@isovalent.com>
> > Closes: https://lore.kernel.org/bpf/a35d9a2d-54a0-49ec-9ed1-8fcf1369d3c=
c@isovalent.com
> > Suggested-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Thank you!
>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
>

Thanks for your review.

--=20
Regards
Yafang

