Return-Path: <bpf+bounces-2293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7015C72A856
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 04:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B6B281ABE
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02C23CA;
	Sat, 10 Jun 2023 02:22:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF415A1
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 02:22:56 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC3CE
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 19:22:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9e33a3d3fso3927481cf.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686363774; x=1688955774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+0zU9azFAMx75FiMgMbhzR97d+EqIFUD8v7XTIqhyE=;
        b=k7jXqJOo6BwEJNGWByfgjIXBE4jP+/7LEmwpgDtWzXNx09iNg5L4A3DdW0Kgl9t1a9
         Fcwpw4PlrbZkWNHmTOzdw30G/ppnGGaVy7CEKup1dyUOq1Mmou5UWQoCCx/qgoEawlUN
         WfrGxOF3sqp43HvR88mDALMthWkY2wZhjZ/GG9CyRq6qG72+LAI4C+Jx0f6zK1LF6m2Z
         DdtyIOvUnYE0+EtSxf4p5I9w9DrIJiwkqjIOzG1UNzjlF+jD2dd4Bntselzb69N8Q7yP
         yzQoHXsnvI4jUOftJk59yJTtc5HTP61iEqucUQItFUvPpMOwY/K44sysvxS+xQINToVH
         VEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686363774; x=1688955774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+0zU9azFAMx75FiMgMbhzR97d+EqIFUD8v7XTIqhyE=;
        b=LoAfBVeKly+VTPgiy87Qfgxk5DebSoMLTlrEBYOJS9whgWxm9v6HAahuAU+E0vaOeR
         ae/LauasYD/v+YSiX/E4qk4vPSJqK6wNdH1FnCyLY5ssCV6JZYPzbaRUELvh/WCVXLcp
         VSRMhSFkxWCQPY+JeUreLaXMrSfjoxvthNP5Vr4TBbMaXM/zz7k+Y1QsC7E/5BI3l7E0
         6a6acFwzXInvybudnQiHbfDs+GwKB3QwFRzQ8xB56xQx/Pq6RlSZHZ8JYBSdAbgwOTIT
         eqvzCNq3lOmcFYxu25DYDTlI9gF20qNdLD/2G3m2FfdnP5U6A2rYsqvPjL+3Enz1GwKX
         pecA==
X-Gm-Message-State: AC+VfDylSNXCJpsX6UAu+btSPWwYUskRLaWaOie96jnG8vGbgivU0eyK
	McnPkwHrJi2OJzAMCEmA8mSd8uLAQEV8eCbAFcA=
X-Google-Smtp-Source: ACHHUZ5uBD+sj+TsRBL1TqxAwCzuyX/iSm5eoTvgyupFqJmgXIGpCxKpDos1a1HSZz57ETpbN52pohUzaWW57ynQVUY=
X-Received: by 2002:a05:622a:1746:b0:3f3:93cd:ff39 with SMTP id
 l6-20020a05622a174600b003f393cdff39mr3400737qtk.31.1686363774660; Fri, 09 Jun
 2023 19:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
 <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com> <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
In-Reply-To: <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 10 Jun 2023 10:22:18 +0800
Message-ID: <CALOAHbCeP3bf=Y1NuJh9MYXoinbi0+fRDANaTdBmOXi1DXz0vw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com, 
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

On Fri, Jun 9, 2023 at 12:36=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Jun 8, 2023 at 4:14=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > Add libbpf API to get generic perf event name.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> >
> > I don't think this belongs in libbpf and shouldn't be exposed as
> > public API. Please move it into bpftool and make it internal (if
> > Quentin is fine with this in the first place).
>
> Or maybe it belongs to libperf?

I prefer to move it into libperf.  Then it may be reused by other tools.

--=20
Regards
Yafang

