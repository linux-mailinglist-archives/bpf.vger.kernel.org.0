Return-Path: <bpf+bounces-14566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C17E65D2
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B4EB20DCA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D010956;
	Thu,  9 Nov 2023 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVvzgAwi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048C10948
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:56:48 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC8182
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:56:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d10f94f70bso96404066b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 00:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699520206; x=1700125006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7i1VmPPgKRGBF89kEEONBFcH8i5l1FYiVTOL9ebzm4E=;
        b=PVvzgAwikNOBLHoSKPxvPsbam6rNH0ZneOYr2QXVS7bHX8eJZIZzoJM1HftvhSqVFz
         nfTIEO+XIsS3vIt+y3zmO5rbDt1YftBNvnRNtKbLMkjM9JMUckgnslBqqgiDruS6F/4m
         e33Hof1uIbx+f1dn6EGyP84YawqYgcMpmPq1WjBpWHv9t6bx5MOj+UBiCDrfsodlZcUj
         LbWR4mpXSoJu+E9jy8uM3nblESuTlkvHZZy9KHomaObDymWzc1RIJdrfkrPlb3NJXBG/
         gKYDTyQk1W2miEgZs1ZDAMWg+/dXQvLyu5oVBoT59LJQYC4TzSPFXu3ZK8IUM2HZCgpJ
         8+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520206; x=1700125006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i1VmPPgKRGBF89kEEONBFcH8i5l1FYiVTOL9ebzm4E=;
        b=HP1En8TXWWz+yHVtBRYHOqHg1adiWKIoivKyEoMyLcxV8cljSUzMQUQVemOTm7Xgv5
         xneqcSYO/aejkqz8ylNOX8geRIWkSRp7yVBJbMCNtDGUkDl2sT101EEdLpCYeSqLo0is
         n2hkDM5zSwzMMS0dI+v9WaX2mKrjoABcsoedfsLt1JfJxGum9VkHq5dQ7bbVtL99gaTd
         oD7t2uk9WjOp58QRII5n2ZBvjCn8/0h2rOTNNLs2LribGnhJdeAU/DVMYxUcFAt5Txav
         BvEfbtNdI8RX38fqXs9rrBxVpn2Tt5agk1LdchGoauhp27plFfYq5Y7u2ZpAEtvXqicd
         +5og==
X-Gm-Message-State: AOJu0Yw1Q5oREb1cHDOolhewFw5M/+W+LptaaQWkNUPuqif+XG0ZB4S3
	0nX0STPRjqXQk+AF4YX38A8=
X-Google-Smtp-Source: AGHT+IFpe069CEsB7r9aKpdjghIgaZuSVF2K9IStk3/jpK2+ofp+SYps/CuvVpgOmCWYMHsLKgSwaw==
X-Received: by 2002:a17:907:a603:b0:9e0:dcf:17f6 with SMTP id vt3-20020a170907a60300b009e00dcf17f6mr2132961ejc.58.1699520205661;
        Thu, 09 Nov 2023 00:56:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lc25-20020a170906dff900b009dd7bc622fbsm2274852ejc.113.2023.11.09.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:56:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 Nov 2023 09:56:42 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZUyeyg7eP8zK3m0M@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com>
 <ZTvCRYi6OMlZYfAz@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTvCRYi6OMlZYfAz@krava>

On Fri, Oct 27, 2023 at 03:59:33PM +0200, Jiri Olsa wrote:
> On Thu, Oct 26, 2023 at 07:57:27PM +0800, Yafang Shao wrote:
> > On Thu, Oct 26, 2023 at 4:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding support to get uprobe_link details through bpf_link_info
> > > interface.
> > >
> > > Adding new struct uprobe_multi to struct bpf_link_info to carry
> > > the uprobe_multi link details.
> > >
> > > The uprobe_multi.count is passed from user space to denote size
> > > of array fields (offsets/ref_ctr_offsets/cookies). The actual
> > > array size is stored back to uprobe_multi.count (allowing user
> > > to find out the actual array size) and array fields are populated
> > > up to the user passed size.
> > >
> > > All the non-array fields (path/count/flags/pid) are always set.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/uapi/linux/bpf.h       | 10 +++++
> > >  kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h | 10 +++++
> > >  3 files changed, 88 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 0f6cdf52b1da..960cf2914d63 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6556,6 +6556,16 @@ struct bpf_link_info {
> > >                         __u32 flags;
> > >                         __u64 missed;
> > >                 } kprobe_multi;
> > > +               struct {
> > > +                       __aligned_u64 path;
> > > +                       __aligned_u64 offsets;
> > > +                       __aligned_u64 ref_ctr_offsets;
> > > +                       __aligned_u64 cookies;
> > 
> > The bpf cookie for the perf_event link is exposed through
> > 'pid_iter.bpf.c,' while the cookies for the tracing link and
> > kprobe_multi link are not exposed at all. This inconsistency can be
> > confusing. I believe it would be better to include all of them in the
> > link_info. The reason is that 'pid_iter' depends on the task holding
> > the links, which may not exist. However, I think we handle this in a
> > separate patchset. What do you think?
> 
> right, I think we should add cookies for both kprobe_multi
> and tracing link, I'll add that in new version

actually.. ;-) it's 5 extra patches already even without bpftool
changes, so I'll send it separately after this one gets merged

jirka

