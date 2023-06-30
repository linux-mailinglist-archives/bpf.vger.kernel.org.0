Return-Path: <bpf+bounces-3822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21957441C0
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49701C20C34
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C631174E1;
	Fri, 30 Jun 2023 18:05:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920F168DA
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 18:05:24 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225335AA
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40345bf4875so34561cf.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688148319; x=1690740319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=1ZE7hgtiEgjlDoeW6HUZsmb8pHNnQlGFw7TZ1i0uPrPvgU9CC1wDgKKbDS2Q4mBjmX
         mDA2d+tyiItMB8jvUIQjHeRMG9ApI/+tVpQdZd9+ZdKYrhiqZ0uj3hV4IDI4t//mbRlo
         3d7LEyyVA70BhOvSPCQW/APnieCBn2kVxrsCaCKkkVlz242DmyTvIsl8XxEcctinddXd
         2wzNC7SGg7u7R3ADYlqP169TKzmReuce6+k08BDk2shySD8VeWjrjx7a8VvrKe+/6YNO
         S8b+bJ6qnKaoDPauiC9o38V7La0F0SP9Yez1pbIr3opxZj0ySqFBU8Nhl0tGl/R1LHmu
         wwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688148319; x=1690740319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=LRXYNe61teq41Qg4cPKU/FN4aLPTBvUq/n6wNceixfqxlsE9fO31UG8ZfURIbsNlkq
         TdxqCPjtPH4nl05HEvyjRsFBPGv1BsbrLy6GuHf+l0XVaJS14uTH1ULZustoxqc69KQb
         ds9cNMjnHCzPIfBTdeRO3YiZt9AWvrvNr7KwS+9qDa63apW7WUeZeylJ9jsR+7IyEqi9
         XdJmF00R//TeSWb+Btgqw5IOLa6xuDLN6XNcfo5KnCmj4dmmvUG4PCKLSFOKRGIbg77x
         9sY/H3hEjSrv8jZFE8hLF9hXaW0bQfcCqVL3o2mJMPlVLxpXjroOmJGXujbS7Y0oX8Zu
         k/9g==
X-Gm-Message-State: ABy/qLYRopn5xxj5HKmaPEAM9N9zDvUAZSVuoqvJh73qIPD0+nhezj7Z
	po+inqPVzAgv+Ia5Gfy6NUAsrFXZLpJ//THXOT6iqA==
X-Google-Smtp-Source: APBJJlFBVz1kI+p5pJzmHdNMLO9ZN9vVI/wrZ03xA0F44tFU7ilVI9KouRjr3eyIVvMMvg7cuPExG7fJ2bUHGksBdQo=
X-Received: by 2002:ac8:580c:0:b0:3f4:f841:df89 with SMTP id
 g12-20020ac8580c000000b003f4f841df89mr988qtg.1.1688148318671; Fri, 30 Jun
 2023 11:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-14-irogers@google.com> <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
 <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com> <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
In-Reply-To: <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 11:05:07 -0700
Message-ID: <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
Subject: Re: [v2 13/13] perf parse-events: Remove ABORT_ON
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 10:40=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>> Prefer informative messages rather than none with ABORT_ON. Document
> >>> one failure mode and add an error message for another.
> >>
> >> Does such a wording really fit to the known requirement =E2=80=9CSolve=
 only one problem per patch.=E2=80=9D?
> >>
> >> See also:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4#n81
> >
> > Sorry your explanation isn't clear.
>
> Do you really find the application of the linked development documentatio=
n unclear
> in this case?
>
>
> > Sorry your explanation isn't clear. Please can you elaborate.
>
> Will it become helpful to split the proposed patch into smaller update st=
eps?

This is kind of why the series is 13 patches long, I'm not seeing why
you think the following stats qualify as "long":
14 insertions(+), 8 deletions(-)

Thanks,
Ian

> Regards,
> Markus

