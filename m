Return-Path: <bpf+bounces-3821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487047441B9
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EA28114D
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E0174DE;
	Fri, 30 Jun 2023 18:02:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EF168DA
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 18:02:07 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D410FF
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:02:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401f4408955so28281cf.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688148124; x=1690740124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg3LqEdLU3wZEunyax8ElGaV027EQp1GLKpP0FoAtZ4=;
        b=nUtk3UHqQQUVq/3fAMJN8zld0gA+IYs5zYdT7Uo+1PoprdBu4MRtnsgBqmZY7TI6MQ
         tF+X0kYmjcEQh+NLQuxHYi5w+WkoU8bV9BBveB9LXFmW2MbKYNQEmS/DlNZilCC9dkO2
         eXjXEXYWe+97MJD14YN0gih7SwS53IBd0qr21WILpoLONQ5E2vS7B2NwXYBH0Vic9nqo
         PqArhZicfpl3NhBLgwWCIeIs8WYB7Fw5YmLqsS/+BpjNQNsJiHwEEVRvel5M3CTg/Iyt
         NvlOtAq6UcKM4UnQTXsP+5B4Fx71MrZzTzRRuIpn1QQGAbgyBTjMdxta1nuj0NWDMjhK
         Tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688148124; x=1690740124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg3LqEdLU3wZEunyax8ElGaV027EQp1GLKpP0FoAtZ4=;
        b=fnyDeS2OfJY7os9oLDj2d8feITcPVRCpt3V7/uwrGaahSwIFJDBnL9mb4ysUihCr02
         5KSgmpZBA9OyLCE/RFtZj5qH3qvLcKkHOCFw2hLdbOe5Dikdao2+naIKxG5X96B6k3Sw
         +Zq7S3LVdnfWACUGZrK2FPgIy8DvvM5sIBDt+CuLgMdVv0UygT1VkYUM/5R1pgfTFJ6v
         AIHfV2E3/vk9jCPXQByc3SUJq9NavlziwGldGwME32cuJywwqPiGX7VCWNzsIo23OHwm
         Ar9y60cfCat5M+RzIaYG4Zreb/NDKLCNCmXDzD3zqgasKYjEFM9dIUq7834wQrzXHfls
         gdrQ==
X-Gm-Message-State: ABy/qLYDz2yt1LabHOLEvZdrTetE8FcRiyok3JUmGSSzEFP7qQVp9KMO
	JpLJKjIrwdjsED/KIjJahtGIVHsKIAxTccCINiSAhQ==
X-Google-Smtp-Source: APBJJlHT2B/Kk6L2SpQUQcP6e9OV8JTKhSdmmFsb/AO5updG8vO6F+jx9bKgQAdCEXIYQy2VJpQxAAi77H3Vm/HQL5Y=
X-Received: by 2002:a05:622a:10d:b0:3f2:2c89:f1ef with SMTP id
 u13-20020a05622a010d00b003f22c89f1efmr25916qtw.5.1688148124390; Fri, 30 Jun
 2023 11:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
 <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de> <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
 <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de> <CAP-5=fXjXBSFVDYXw6fXUf35hLDMqS-C4DRC4LWXUcsMNP6gdw@mail.gmail.com>
 <dbf08741-0b3d-f61f-bb06-05ca3f445202@web.de>
In-Reply-To: <dbf08741-0b3d-f61f-bb06-05ca3f445202@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 11:01:53 -0700
Message-ID: <CAP-5=fXK9dcyycfOfD+a8_qHw+g3vmkd52ZLgwBNfhBFXELLhA@mail.gmail.com>
Subject: Re: [v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 10:52=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >> Can the mentioned patch review concern be adjusted with wording altern=
atives
> >> for improved commit messages?
> >
> > Sorry, checked with a colleague and kernel contributor,
>
> Interesting =E2=80=A6
>
>
> > we don't know what is being requested here,
>
> Another bit of attention for a known information source:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n94
>
>
> > "imperative mood" makes no sense,
>
> How does such an opinion fit to the Linux development documentation?
>
>
> > as such I don't have a fix for what you're requesting.
>
> I got the impression that further possibilities can be taken better into =
account
> also for improved change descriptions.

Thanks Markus, I appreciate you feel you have a real point here, I'm
just not getting it. Perhaps you can write a commit message that
fulfils requirements like being in the correct "imperative mood" and I
will learn and improve.

Thanks,
Ian

> Regards,
> Markus

