Return-Path: <bpf+bounces-10684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE57ABED1
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 93B421F238D8
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A30CA6E;
	Sat, 23 Sep 2023 08:21:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B63B9
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 08:21:45 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF37198
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 01:21:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f7638be6eso3201970f8f.3
        for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695457302; x=1696062102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYlw6sbQ6o+up2kqcsobRya9pzMag7jmYFLxB/+1vwo=;
        b=f8SUqs2skR+3l9hAOK2G1Y+6CJz6vqYr0I1jrjfAc9h1o2NL4+TeL8bQDq+6Ab1N8B
         cd/vjXCtf8u4NBDzs3m7PwRW+JOgmn51gZTlU+4nZCS1ejnWcATOSUh0Fo1obEXQMhZt
         rcgE7qk9nXZ1BYQlIuHC75pVRkFzPiaPI3ObOJ5kSW3/HdF/LtVAHijfEwzq9tz66lE7
         QuMt2q41mO8P6W8PCoIhnJpo8oaFkXIHmwgDj+cXrynXy6eqTyqdYD/wvAd9OhWE4Lp6
         OsXqhq3Msdc6GCCMU28s14z8yuDjxndBOt20Ga2g9CvQ6NTKQqt13wWe8ZHux0z6TtzB
         dHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695457302; x=1696062102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYlw6sbQ6o+up2kqcsobRya9pzMag7jmYFLxB/+1vwo=;
        b=qgZahANL0tHRpekI8qsw3rqPak27OqIT5nBH+D0LveH5JUdYHSWTOVsKpRPKeygpUP
         /yy09wqHgBvR2Hh+z87ujFYYeQIAUzcjctiOcDPIe8iX+J6u5RJchGGfKE8Uou2Mq+95
         6QYsl2sz9KzqGrBNBVC5TVuK2MipwcRJxC+3hAJhR58a4K02qMv3/F6P9PXKfjhtwzfE
         8DieHO2t+iTkj/Yi3S6um+SaelODafX+41loeDDkQcuuuzi1wP4jb96lGc2cKRUT0PqB
         g4K9rXbir43crUCc7JW5gLBbS64z8POovm3sqp/yd9X3qj6Mxl1lTGt4yhNwGBwBrwCL
         arqA==
X-Gm-Message-State: AOJu0YxlNw4exo1HN7bLKLGytL0BLBY4hhHrPTG5Ac2PLekr5C96bQ2a
	y90CLdAZ1rCiAvwiiZfIk38=
X-Google-Smtp-Source: AGHT+IFM0QttIcfyAFwLutZGxUW/cuTvF7qqIFZFaYSkBgSqwLV5gIqzkMlLCLIH5Di+LpgdM0vaag==
X-Received: by 2002:a5d:49c1:0:b0:31f:ea18:6f6b with SMTP id t1-20020a5d49c1000000b0031fea186f6bmr1350101wrs.19.1695457301945;
        Sat, 23 Sep 2023 01:21:41 -0700 (PDT)
Received: from krava (37-188-170-118.red.o2.cz. [37.188.170.118])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d6189000000b003142ea7a661sm6296643wru.21.2023.09.23.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 01:21:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 23 Sep 2023 10:21:36 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv3 bpf-next 2/9] bpf: Add missed value to kprobe_multi
 link info
Message-ID: <ZQ6gEHioaIwBYgwV@krava>
References: <20230920213145.1941596-1-jolsa@kernel.org>
 <20230920213145.1941596-3-jolsa@kernel.org>
 <CAPhsuW5fn=zaayBL2R1D+rKkO5AWuPmwp1WydGkKcCD7QO6U2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5fn=zaayBL2R1D+rKkO5AWuPmwp1WydGkKcCD7QO6U2w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 11:52:16AM -0700, Song Liu wrote:
> On Wed, Sep 20, 2023 at 2:32 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add missed value to kprobe_multi link info to hold the stats of missed
> > kprobe_multi probe.
> >
> > The missed counter gets incremented when fprobe fails the recursion
> > check or there's no rethook available for return probe. In either
> > case the attached bpf program is not executed.
> >
> > Acked-by: Hou Tao <houtao1@huawei.com>
> > Reviewed-and-tested-by: Song Liu <song@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 1 +
> >  kernel/trace/bpf_trace.c       | 1 +
> >  tools/include/uapi/linux/bpf.h | 1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 73b155e52204..e5216420ec73 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6530,6 +6530,7 @@ struct bpf_link_info {
> >                         __aligned_u64 addrs;
> >                         __u32 count; /* in/out: kprobe_multi function count */
> >                         __u32 flags;
> > +                       __u64 missed;
> 
> This does not make bpf_link_info bigger. So if we use newer user space
> on older kernel, the user space cannot tell whether missed == 0 or the
> kernel doesn't support "missed". Right?

hum, I think that's right.. but I think that would be the case
even if it did make bpf_link_info bigger, because we'd need to
pass zeroed value in 'missed' field and it'd not be changed by
older kernel

user space could maybe check if there's 'missed field in
bpf_link_info.perf_event.kprobe.missed ?

jirka

> 
> Thanks,
> Song
> 
> >                 } kprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 279a3d370812..aec52938c703 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2614,6 +2614,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
> >         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> >         info->kprobe_multi.count = kmulti_link->cnt;
> >         info->kprobe_multi.flags = kmulti_link->flags;
> > +       info->kprobe_multi.missed = kmulti_link->fp.nmissed;
> >
> >         if (!uaddrs)
> >                 return 0;
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 73b155e52204..e5216420ec73 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6530,6 +6530,7 @@ struct bpf_link_info {
> >                         __aligned_u64 addrs;
> >                         __u32 count; /* in/out: kprobe_multi function count */
> >                         __u32 flags;
> > +                       __u64 missed;
> >                 } kprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> > --
> > 2.41.0
> >
> >

