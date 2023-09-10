Return-Path: <bpf+bounces-9614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE3799F5E
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B581A28107A
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5C881F;
	Sun, 10 Sep 2023 18:54:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816248469
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:54:33 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C9119
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b393df02so43504955e9.1
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694372070; x=1694976870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKbPcKsZUvKSLjDYgSR8jPHSmii/dMt9jcd71D1gmtk=;
        b=b63ZRU3axTfGE37Qi3MM/BLPP1jal1LV+XZ/QVKK8d0g8Y4Rt/SMd7XlGAfmJbBZGu
         POBp0jTJQVkeMSdrlxJZFl1YpF3UkztdguF5LqLfRnvDZ8QDBJvB0TZrrqPVyMwz8pqL
         BC8CPo7d/LBXaMvDvAjKZ2DhrkD8qcVAUmhTpN2NlmnZkGrCyuA4XRhc4kaDYaiKmiFa
         tPWsTnWbyWklwujCEjhgkGT4dVyhc8Gp8MueAAwo/ZRhzwFsP4QgEC9LqS9JlfiWy4Z1
         PlzoxeaJ0InZgpFD8q3F6sf9Qz1I1zvIRprWk5q6X+/+wQwenlorbhUdWqvbm156NtG6
         7Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372070; x=1694976870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKbPcKsZUvKSLjDYgSR8jPHSmii/dMt9jcd71D1gmtk=;
        b=hAltO7P0mKgzAYGt/Wv/pXIqqbgO+acv7nkdgWub0DLKh+QNEf4uphnVM5gyS78uZt
         wArVBMkkSM16Wb8gIRDob01QYgwaIYbZsebJtn2P+pf47ooqJHa8/9sOHVvC3IN5OKsd
         4U/o16LLaQFqoQbSd9cTy+XPo2MRcFwrOdp8ZYgrxhbOZhC0NjhXuRx/xM+ii161QqWW
         OK5tcSx7tJCdNODr+3dpMCPWVWLmdiLQnHPcvfjH1boUoG8vTJk8tuSQ7ir20YlA2uxi
         cV8WYUXpRTGa8eKbDUysekfuAsQToPRx8R7X5XUyQMMmRWwBe7/5uWas8GMspspJRsc8
         +fvw==
X-Gm-Message-State: AOJu0Yw4HKjzVbFJK1sOMwcnrdnxF+TeMerDC+nWs3g5CAPI+dlWbu8W
	yuaAL5MrftrqaLuy+WbFf68=
X-Google-Smtp-Source: AGHT+IHOzRfcyWgi8ikhSKUmujJ9u2D4ZhbfezfCpikee7fX1WrNTBVExuMhHa3IM9CyTUXUo6KERw==
X-Received: by 2002:a05:600c:3b92:b0:403:7b2:6d8f with SMTP id n18-20020a05600c3b9200b0040307b26d8fmr2398869wms.2.1694372069781;
        Sun, 10 Sep 2023 11:54:29 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c378700b003fe4548188bsm11020438wmr.48.2023.09.10.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:54:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 20:54:26 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link
 info
Message-ID: <ZP4Q4g6xOv8w/Fvr@krava>
References: <20230907071311.254313-1-jolsa@kernel.org>
 <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
 <ZPsI/4nX7IUpJ6Gr@krava>
 <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 04:22:05PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 8, 2023 at 4:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Sep 07, 2023 at 11:40:46AM -0700, Song Liu wrote:
> > > On Thu, Sep 7, 2023 at 12:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Add missed value to kprobe attached through perf link info to
> > > > hold the stats of missed kprobe handler execution.
> > > >
> > > > The kprobe's missed counter gets incremented when kprobe handler
> > > > is not executed due to another kprobe running on the same cpu.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > [...]
> > >
> > > The code looks good to me. But I have two thoughts on this (and 2/9).
> > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index e5216420ec73..e824b0c50425 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6546,6 +6546,7 @@ struct bpf_link_info {
> > > >                                         __u32 name_len;
> > > >                                         __u32 offset; /* offset from func_name */
> > > >                                         __u64 addr;
> > > > +                                       __u64 missed;
> > > >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> > > >                                 struct {
> > > >                                         __aligned_u64 tp_name;   /* in/out */
> > >
> > > 1) Shall we add missed for all bpf_link_info? Something like:
> > >
> > > diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
> > > index 5a39c7a13499..cf0b8b2a8b39 100644
> > > --- i/include/uapi/linux/bpf.h
> > > +++ w/include/uapi/linux/bpf.h
> > > @@ -6465,6 +6465,7 @@ struct bpf_link_info {
> > >         __u32 type;
> > >         __u32 id;
> > >         __u32 prog_id;
> > > +       __u64 missed;
> > >         union {
> > >                 struct {
> > >                         __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
> >
> > hm, there's lot of links under bpf_link_info, can't really tell if
> > all could gather 'missed' data.. like I don't think we have any for
> > standard perf event or perf tracepoint
> 
> even if missed for all link types would make sense, we can't add any
> field before union, this would be a breaking change
> 
> >
> > >
> > > 2) "missed" doesn't seem to fit well with other information in
> > > struct bpf_link_info. Other information there are more like stable-ish
> > > information; while missed is a stat that changes over time. Given we
> > > have prog_id in bpf_link_info, do we really need "missed" here?
> >
> > right, OTOH there's recursion_misses/run_time_ns/run_cnt in bpf_prog_info
> >
> > the bpf link has access to its attach layer, like perf event for kprobe
> > in perf_link or fprobe for kprobe_multi link... so it's convenient to
> > reach out from link for these stats and make them available through
> > bpf_link_info
> 
> but what's confusing to me is that missed counter is per-program (at
> least in your patch #1), but you report it on  a link. But the same
> BPF program can be attached multiple times through independent links.
> So each link will report a shared misses count, which is quite
> confusing.
> 
> Have you thought about counting misses per link instead of per
> program? Is it possible?

I think recursion_misses makes sense for both program and link

currently we have recursion_misses per program which I think is
still useful even if the program is attached to multiple links

if the program is attached to multiple links it'd be useful to
have perf link stat as well

it is definitely possible for kprobe_multi link, which IIUC might
not be the main user here, because you can already attach program
to multiple functions

I guess perf_link would benefit more from this stats, but it
looks bit harder to add.. we'd need to add link pointer to
bpf_prog_array_item and add some extra logic, will check

jirka

