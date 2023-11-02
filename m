Return-Path: <bpf+bounces-13956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955577DF570
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59D41C20F2C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5531B274;
	Thu,  2 Nov 2023 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWjDR6Gw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B9171B5
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:58:33 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB111B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 07:58:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so14116621fa.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937110; x=1699541910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1SKgxP6Ij4JROYlCCFWrQsXyV2jVk9xy8kB02k8RVo=;
        b=FWjDR6GwMI2chsr/oBf1SqejgmrL+d9gTLSAoW/FKHelf04S1wXmKc4k+/dQv37mBN
         HEXmKScFtZJp1j1DziYeQM0uhCk/4HbYYUlVNnPuORKLWdRa+8CwBT3Abn/hbtHfDwQP
         v0z3q7eIxosZGUV9G6eP1tE8B1mzaAMzV+tR+xTG0eooubrbnKhxF8cNkJyHhh/wjVRj
         GBJaHixdAGBPtqLQE8qQVZpkkaC2qbWOPVNGqiX1eUG5Y4Exas92cGrj+6bOblLAfOSK
         HER/NP0sPuXR8Y+5SujO+N6tHxCWV7zTrI70SRsybnMh+p5UnXobEwUgBTsYsgjkQeaB
         tm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937110; x=1699541910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1SKgxP6Ij4JROYlCCFWrQsXyV2jVk9xy8kB02k8RVo=;
        b=gk5C/2UJQWkWdtq0m/oG7o7KkhMBQhzWA7IoE2tEFGcUFq+2Ht99lgg4zOXWscjOn9
         vNGCFDX0376DYSsw6yOXXIS2XOpKW8q0Wu7wIoxuScWpZ3jY4d6CnADFN7xvGRPz7Ngv
         a47eu7cDFWbmdFHQe4mDBIMJl7F+wCUAuSJ4wrHW/MGSypBcrQ/YAVGbcVCUh8RDs73J
         prdPS1K1aclUprY2oqvhM63OJmpUL3hHsOSxZgxN4Kypx+HkgxrhmNPkza5/VoQUTHc/
         rB0N5TbFrEWM6Cw0MqaWia7z5pm9w8Qyuf0uD1NvCULinoylhWhNNiC8zuKkzgt4B54o
         NxDA==
X-Gm-Message-State: AOJu0YwcLmxjospXT0+JiIq/0xCjxzeChdpFc8ATYUS5+FuAJEaWJLpv
	ZW2LdWH7dHTFo9psAN9kIpFEl8Al9x5sZA==
X-Google-Smtp-Source: AGHT+IFOUEgOU1kqT28pGSVac0qaqauz1SDgskVEDjJPIyu+9wHssDsZOdWlq7ATRkIS6MkWZ7CSkQ==
X-Received: by 2002:a05:651c:1305:b0:2c5:2132:24f6 with SMTP id u5-20020a05651c130500b002c5213224f6mr14461393lja.12.1698937110104;
        Thu, 02 Nov 2023 07:58:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id er10-20020a05600c84ca00b004094c5d929asm3035013wmb.10.2023.11.02.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:58:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 15:58:17 +0100
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZUO5CRlYDB8N0dNk@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>
 <ZTvJY2n1bZ8KtS/X@krava>
 <CAEf4BzZETCTyAqbBkfL2KvPo8T3ATXsRyj37f9kfVB2d7kj=sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZETCTyAqbBkfL2KvPo8T3ATXsRyj37f9kfVB2d7kj=sg@mail.gmail.com>

On Wed, Nov 01, 2023 at 03:21:42PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 27, 2023 at 7:30 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 10:55:35AM -0700, Song Liu wrote:
> > > On Wed, Oct 25, 2023 at 1:24 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > [...]
> 
> [...]
> 
> > >
> > > > +               if (upath_max > PATH_MAX)
> > > > +                       return -E2BIG;
> > >
> > > I don't think we need to fail here. How about we simply do
> > >
> > >    upath_max = min_ut(u32, upath_max, PATH_MAX);
> >
> > ok
> 
> +1, was going to say the same
> 
> >
> > >
> > > > +               buf = kmalloc(upath_max, GFP_KERNEL);
> > > > +               if (!buf)
> > > > +                       return -ENOMEM;
> > > > +               p = d_path(&umulti_link->path, buf, upath_max);
> > > > +               if (IS_ERR(p)) {
> > > > +                       kfree(buf);
> > > > +                       return -ENOSPC;
> > > > +               }
> > > > +               left = copy_to_user(upath, p, buf + upath_max - p);
> > > > +               kfree(buf);
> > > > +               if (left)
> > > > +                       return -EFAULT;
> > > > +       }
> > > > +
> > > > +       if (!uoffsets)
> > > > +               return 0;
> > > > +
> > > > +       if (ucount < umulti_link->cnt)
> > > > +               err = -ENOSPC;
> > > > +       else
> > > > +               ucount = umulti_link->cnt;
> > > > +
> > > > +       for (i = 0; i < ucount; i++) {
> > > > +               if (put_user(umulti_link->uprobes[i].offset, uoffsets + i))
> > > > +                       return -EFAULT;
> > > > +               if (uref_ctr_offsets &&
> > > > +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
> > > > +                       return -EFAULT;
> > > > +               if (ucookies &&
> > > > +                   put_user(umulti_link->uprobes[i].cookie, ucookies + i))
> > > > +                       return -EFAULT;
> > >
> > > It feels expensive to put_user() 3x in a loop. Maybe we need a new struct
> > > with offset, ref_ctr_offset, and cookie?
> >
> > good idea, I think we could store offsets/uref_ctr_offsets/cookies
> > together both in kernel and user sapce and use just single put_user
> > call... will check
> >
> 
> hm... only offset is mandatory, and then we can have either cookie or
> ref_ctr_offset or both, so co-locating them in the same struct seems
> inconvenient and unnecessary

yes, using struct seems too complicated because of this

but during attach we could store offsets/ref_ctr_offsets/cookies
in separated arrays (instead of in bpf_uprobe) and just use single
copy_to_user call for each array in here

jirka

