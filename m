Return-Path: <bpf+bounces-17810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAE812B89
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70401C214CD
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD32E64B;
	Thu, 14 Dec 2023 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3wnkiLQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16233A6
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:22:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so63947165e9.3
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702545759; x=1703150559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wnfnavKzHcTsQsBJuo267RFZSXRG6FYDokZXR2YiBxc=;
        b=D3wnkiLQEsI5nM8BPiUsKxGGG6SSsjYW1KOISncOGWnNFz864GDS4MuiF7o4ZGbkeE
         N4XLt/XALVf6BWd+UsqLt8ui4D8KN2jn4b9n0KcC1e4pqAXO6NkvKXKo+WPnZhrzcTFP
         6iS3JcgaQqHxYRcGAtYYLllFy/aAaZ3qxDKbnd5R5DoIDJgN2t5Pvshw85I5PDGWUN+1
         qxDcaFTW6mm9Yes7zv70rZj8o3fHeBC/C146kz1VX6OnwnPNww2VCiXxYQ2Wq4oRrmNO
         eDP4RaPJirE4QXBqGtVN1GiRV7YvUlT0ky7AggAzXxQmZFTQR2V1OClcKInewOZ5lYqa
         B6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545759; x=1703150559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnfnavKzHcTsQsBJuo267RFZSXRG6FYDokZXR2YiBxc=;
        b=qbdYAaS9mkyCeAJxOgQH6XrjEsZQMgJMU7NSdChAlSSNbju0hJYKkJKg74pSrM4O1r
         BFow3tMQwCvmrGTeoE4qZ0CwzAf+H4eCvupykrk37gaAZDqTcayn0NN0ut6QqdZ29u9Z
         B/P+EGiu3Y/ZCnfOT4sIPy23Ym6O/800AlaeEvAVAGdQ4/vxVU1/96psr82dQj5zh1db
         N/FpKYPq9Mn225iVXiz3cnjTR5SmfjatwKsNrboZ3j7jRvDO9VwjCV1dGNd3Jv94U0Su
         WzfBx2GVOZwFiWaq1f+LYPxEU8zi+tvO/m8MWTNx76AfdTDkni5QMyNcTmMbWMDHaYcI
         gQlQ==
X-Gm-Message-State: AOJu0YxJJqXtzF/lGhMiqoJ0+zc6/k0i+3Z16EBHLErIJnUKUepBiEPV
	PsAuQW5Ahz0RTjpD6Jz3Maw=
X-Google-Smtp-Source: AGHT+IGV90jBePY9yJY2Bgs5n5XjdpTgmNUxGq+f8ymD32aXNJGF/gqAlrjOmR6nbHOnYThT4YtBJw==
X-Received: by 2002:a05:600c:3c8e:b0:40c:5f0b:d643 with SMTP id bg14-20020a05600c3c8e00b0040c5f0bd643mr833003wmb.140.1702545759426;
        Thu, 14 Dec 2023 01:22:39 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm24258316wmq.43.2023.12.14.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:22:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Dec 2023 10:22:37 +0100
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative
 offset
Message-ID: <ZXrJXUE2TjrjQuvj@krava>
References: <20231213141234.1210389-1-jolsa@kernel.org>
 <CAPhsuW7zwLi-=TAjNYXBG6EPSNdgsoDqeQyoB-3oubUt0GMmSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7zwLi-=TAjNYXBG6EPSNdgsoDqeQyoB-3oubUt0GMmSQ@mail.gmail.com>

On Wed, Dec 13, 2023 at 03:35:07PM -0800, Song Liu wrote:
> On Wed, Dec 13, 2023 at 6:12 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently the __uprobe_register will return 0 (success) when called with
> > negative offset. The reason is that the call to register_for_each_vma and
> > then build_map_info won't return error for negative offset. They just won't
> > do anything - no matching vma is found so there's no registered breakpoint
> > for the uprobe.
> >
> > I don't think we can change the behaviour of __uprobe_register and fail
> > for negative uprobe offset, because apps might depend on that already.
> >
> > But I think we can still make the change and check for it on bpf multi
> > link syscall level.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 774cf476a892..0dbf8d9b3ace 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                         goto error_free;
> >                 }
> >
> > +               if (uprobes[i].offset < 0) {
> > +                       err = -EINVAL;
> > +                       goto error_free;
> > +               }
> > +
> 
> nit: We have 3 __get_user() here. How about we move __get_user(offset)
> to the first
> and check offset immediately after it? This will save us a few
> __get_user() in the
> error path.

right, we can move it up

thanks,
jirka

> 
> Thanks,
> Song
> 
> >                 uprobes[i].link = link;
> >
> >                 if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > --
> > 2.43.0
> >
> >

