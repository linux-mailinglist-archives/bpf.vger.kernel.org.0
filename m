Return-Path: <bpf+bounces-13428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFF7D9B6C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB721C2108C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703ED37163;
	Fri, 27 Oct 2023 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc/XLmqU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96237167
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:30:02 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BF1B4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:29:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6761087a12.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416998; x=1699021798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KyzUBbMQOpgiGI0hsah36/6hIjNR9EYnaJTVBDMdHU4=;
        b=Fc/XLmqUNUOS57arShbGvtUHZfI7obCMDVHouDxB0kUvqas9tRkLDHgdT74xU5MZqz
         wMvCx6Bip4xIp0jvAM0f7ner7QKZJal3+NHwY3iGAvSZTWE9B6BwmR4PNj/0hYVlGr/q
         rqO1BD0W6ZHQA9qJFwQSGhp67aajVe2i6vSb2CHVGVTuHpjjUuTSR1gD+Y+CiXj2aGc6
         Bj+QiHk5jtJZ5IvibgNlTLoMSvs6XErZA9YCq1hu/FKiqyKLboEPF/yiwA4Xhwi4J0xP
         f5LeI5bvY3+uPxd5NeFkbNV7WNDPoEmZsM9qRYe4FXperr1oJ0/WlYpim+Sd2tKyV9t0
         T1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416998; x=1699021798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyzUBbMQOpgiGI0hsah36/6hIjNR9EYnaJTVBDMdHU4=;
        b=KMNGac0Om/SUcWi3nGx2K/1gpOpQYXpZbUsIAATOYn6m8tdHq+1pGheMlruwhcrmi8
         f7RfhvTiOwmL6FSd4K5+uHW9DXlrBnYAvO0ELs3P5P1BCMdQWk+L9C1fYaIBJ9ICqv5I
         GJ2qqeH52TXQFRXH92XaqdRiPDcv/cGPk8D5RIQNxzbWUhsBE3FP0AjFRHiAiKSUs3k4
         XWXYbmXFwt2V19NxDsRzC4GrymPIJMTyxjgBZ7Ct0OOdVDxn5NCim8iWtyeFvR+C3A67
         aJyoxN5Tf0rKvP2ABj0l/E06tRC1LeV4MePFaKJlwg51I92GCUTssK/Mzs9+SOmUmL3w
         mE7A==
X-Gm-Message-State: AOJu0Yx3tpqEl/TXR+3CCnCjuXXlny+jK9I1c41syc8eDtRNOs83Ioeh
	WLdx28tbGeCjRf515qA2Mwc=
X-Google-Smtp-Source: AGHT+IGslF4rbM6kk5brSCNQWkzzbaKNl+JJ/SvArahNS6fe6Lz3mPe3hYB8UCrkhdBMrvU8SDQQYA==
X-Received: by 2002:a17:907:96a3:b0:9a5:dc2b:6a5 with SMTP id hd35-20020a17090796a300b009a5dc2b06a5mr5068745ejc.35.1698416997751;
        Fri, 27 Oct 2023 07:29:57 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090666cd00b009b913aa7cdasm1293973ejp.92.2023.10.27.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:29:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Oct 2023 16:29:55 +0200
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
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZTvJY2n1bZ8KtS/X@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>

On Thu, Oct 26, 2023 at 10:55:35AM -0700, Song Liu wrote:
> On Wed, Oct 25, 2023 at 1:24 PM Jiri Olsa <jolsa@kernel.org> wrote:
> [...]
> >                         __u64 missed;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __aligned_u64 path;
> > +                       __aligned_u64 offsets;
> > +                       __aligned_u64 ref_ctr_offsets;
> > +                       __aligned_u64 cookies;
> > +                       __u32 path_max; /* in/out: uprobe_multi path size */
> 
> I don't think we use path_max for output. Did I miss something?

it's used by user to specify the size of the buffer
for storing the path, so you're right just 'in' 

> 
> > +                       __u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> > +                       __u32 flags;
> > +                       __u32 pid;
> > +               } uprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> >                         __u32 :32;
> 
> [...]
> 
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       info->uprobe_multi.count = umulti_link->cnt;
> > +       info->uprobe_multi.flags = umulti_link->flags;
> > +       info->uprobe_multi.pid = umulti_link->task ?
> > +                                task_pid_nr(umulti_link->task) : (u32) -1;
> 
> I think we can just use 0 here (instead of (u32)-1)?

ok

> 
> > +
> > +       if (upath) {
> 
> nit: we are only using buf and p in this {}. It is cleaner to define them here.

ok

> 
> > +               if (upath_max > PATH_MAX)
> > +                       return -E2BIG;
> 
> I don't think we need to fail here. How about we simply do
> 
>    upath_max = min_ut(u32, upath_max, PATH_MAX);

ok

> 
> > +               buf = kmalloc(upath_max, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +               p = d_path(&umulti_link->path, buf, upath_max);
> > +               if (IS_ERR(p)) {
> > +                       kfree(buf);
> > +                       return -ENOSPC;
> > +               }
> > +               left = copy_to_user(upath, p, buf + upath_max - p);
> > +               kfree(buf);
> > +               if (left)
> > +                       return -EFAULT;
> > +       }
> > +
> > +       if (!uoffsets)
> > +               return 0;
> > +
> > +       if (ucount < umulti_link->cnt)
> > +               err = -ENOSPC;
> > +       else
> > +               ucount = umulti_link->cnt;
> > +
> > +       for (i = 0; i < ucount; i++) {
> > +               if (put_user(umulti_link->uprobes[i].offset, uoffsets + i))
> > +                       return -EFAULT;
> > +               if (uref_ctr_offsets &&
> > +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
> > +                       return -EFAULT;
> > +               if (ucookies &&
> > +                   put_user(umulti_link->uprobes[i].cookie, ucookies + i))
> > +                       return -EFAULT;
> 
> It feels expensive to put_user() 3x in a loop. Maybe we need a new struct
> with offset, ref_ctr_offset, and cookie?

good idea, I think we could store offsets/uref_ctr_offsets/cookies
together both in kernel and user sapce and use just single put_user
call... will check

thanks,
jirka

> 
> Thanks,
> Song
> 
> > +       }
> > +
> > +       return err;
> > +}
> > +

