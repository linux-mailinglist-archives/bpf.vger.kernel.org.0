Return-Path: <bpf+bounces-13422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD87D9A8A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC511C2108C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC2358A8;
	Fri, 27 Oct 2023 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ1nzzXW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3B358A1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:56:27 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DD7C0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:56:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so3528827a12.2
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698414985; x=1699019785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBMHXQ6WEBylQvnw+Q6SfWGnVWhUYb3HqlDIX85Nepg=;
        b=HJ1nzzXWC5s9EBwMxQ/ytwKKagIp95dzPJ/ROzeMMwCWMdiMu6hb8Sznh11w3NMzSe
         1L1pKvhH2JmEWo1hvgjnZtkKP1ZJ8qy1C1aNBGtW9j15qRVktluFk++DsjIzBNhcLGAq
         KKDKV3oh5cWHsNpWo4HgKEmDRG+FDFE8ae/bfpJ2gdHr/hM+a/5BuT8wNydVb6soddzV
         oqy40wkFvM94BeX8/eqmXhnG6w/CpZt75aZ2WFafJht6h97uRnUr3FeFmDGWpdR0OxHD
         IYrI6v+6flUupGVnPdYUMF7wRQXe56LW/hHz7MCaizGGHPwKYCTCev4vEZ7PruH25oyc
         TvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414985; x=1699019785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBMHXQ6WEBylQvnw+Q6SfWGnVWhUYb3HqlDIX85Nepg=;
        b=IYNp42FF3lrKzvj/h0rwkDpcq7RwYoo65GU0iU6Tra2soekPcGbVOULhkOkeZb3Uxm
         BIkY4t/rZibtADq3sIiFn5yt3r5HIo1ZwC15Fns+dx3wMZRfTujc82NGtONWGEvdNxKQ
         LG1vKZws5wTazaghYsVuR25/vDK1G5vkgS6MI7f+YjRGpAowaNqZhN/ZTpML74B5lJd2
         RcFxASw2dWzX7Aejokow3CvsA0570kDOEFscQmWHt/VRlc9b3Q6QzX0oH4Yyh0vo13i8
         VnmWOTrKvLN5aglqUnpAvT2cm6TyG6OXfuD06iKn8wH518+w6c+NYPLUIUiY533wrkxA
         iFEQ==
X-Gm-Message-State: AOJu0YwY5oMyXwYRGwxEwclGHZzkYxWpQwGBSYr8LowPxsAHt56l0UT8
	1agEDmuAjS8GxL+xxVgBUvo=
X-Google-Smtp-Source: AGHT+IH7BkkH1imqq3ACCMiMeN8lHB9apnfcbug/62wiRImh5qw5qEwtbhtkMtEOKXVgbrGLPDZkgA==
X-Received: by 2002:a05:6402:12c4:b0:540:b95b:6ecf with SMTP id k4-20020a05640212c400b00540b95b6ecfmr2296665edx.7.1698414984569;
        Fri, 27 Oct 2023 06:56:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d594000000b005402b190108sm1264575edq.39.2023.10.27.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:56:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Oct 2023 15:56:21 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
Message-ID: <ZTvBhUP2uGqXAIRy@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-3-jolsa@kernel.org>
 <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>

On Thu, Oct 26, 2023 at 09:31:00AM -0700, Song Liu wrote:
> On Wed, Oct 25, 2023 at 1:24 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We will need to return ref_ctr_offsets values through link_info
> > interface in following change, so we need to keep them around.
> >
> > Storing ref_ctr_offsets values directly into bpf_uprobe array.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> with one nitpick below.
> 
> > ---
> >  kernel/trace/bpf_trace.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index df697c74d519..843b3846d3f8 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3031,6 +3031,7 @@ struct bpf_uprobe_multi_link;
> >  struct bpf_uprobe {
> >         struct bpf_uprobe_multi_link *link;
> >         loff_t offset;
> > +       unsigned long ref_ctr_offset;
> 
> nit: s/unsigned long/loff_t/ ?

hum, the single uprobe interface also keeps it as 'unsigned long'
in 'struct trace_uprobe' .. while uprobe code keeps both offset and
ref_ctr_offset values as loff_t

is there any benefit by changing that to loff_t?

jirka

> 
> >         u64 cookie;
> >         struct uprobe_consumer consumer;
> >  };

