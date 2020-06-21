Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE51202B74
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgFUPod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgFUPoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Jun 2020 11:44:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F1C061794
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2020 08:44:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x18so13822170ilp.1
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2020 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJyqT+t8Aa1UDG/aGDqZuIc8FNIWYRbNDRl8QOrz/uM=;
        b=r11vQIM9hLGLkocWrOgIiNICtDTSWtf1U7yz0pID6N6meRZkVgHRr57RMAgpbbui0E
         lspo0yiUJpDM30hKON1G470hg1pUnybU3CM6tV7zk2vlzx9epH6VFsTiDEWjQ9ax5Pk1
         yu44ZftvpQ6r/+FZ3uMfVMqB0brFaWjUSIs89UBJL5tu5WGH42NHfxS4cLwyZDDEJxV0
         R1YJeJfY0mIVRGsgA4RfhTOgVLAfMJIfrvCp1v7VO5+tQcLqo4oGVRgzdbRINFrVmxF/
         K57Lq0mKiZOR8sTaSilJH2yv6yRpPVry19S+yL8aQc6Fy78Bs4uojZC1vVgwZyhFH1Il
         RqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJyqT+t8Aa1UDG/aGDqZuIc8FNIWYRbNDRl8QOrz/uM=;
        b=g2m07WvQtWQx35Hlo7v9qD/b0q+gQnIbGWfWMaSrylUxgd/lh0ZOVtqFQg1CushQCd
         LtUDGD6KiaeXKTL8zM37IA4hnrz1dC99hfeEjbKNuorwiNpwzlJyIJONwpQXb3lH35Fg
         5j80WCc/dLo/0u6ndEQh/xbIzO5YZ5M2dScz5Tj3bmzXXwDsxaAapGMpYOSgYkoyV+Ha
         WTlig36VBQAg55BbSxfNMwheOI5ildqf/Ncjn577TazPe//nyC9C9cG5dKJjDshKEDYT
         dwwtfGQ0YgthY7SdTimCdRierdSo+kMssNc9D75MY7rutN1T7zMgAAgxZrfqLCtulJUx
         6hpw==
X-Gm-Message-State: AOAM531spMQBa45W2FPyPi/4mgN8UMNCYm/Vcbbw2CUOsy5j/6YJ5I3J
        aR0YM0ANdIer2caB57tCK5wIzg==
X-Google-Smtp-Source: ABdhPJywKn14Wu87V6WJej7sBidie33Mp+mzYwqd0t7BnZjULply7/ipgiAhY9e11eAmq9cKvdWw7g==
X-Received: by 2002:a92:9914:: with SMTP id p20mr13355384ili.273.1592754272060;
        Sun, 21 Jun 2020 08:44:32 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id p11sm6993560ioo.26.2020.06.21.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 08:44:31 -0700 (PDT)
Date:   Sun, 21 Jun 2020 08:44:28 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
 <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> >
> >
> >
> >
> > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > >
> > >
> > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > New to bpf here.
> > > >
> > > > I'm trying to read values out of of mm_struct.  I have code like this;
> > > >
> > > > unsigned long i[10] = {};
> > > > struct task_struct *t;
> > > > struct mm_rss_stat *rss;
> > > >
> > > > t = (struct task_struct *)bpf_get_current_task();
> > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > BPF_CORE_READ_INTO(i, rss, count);
> > > >
> > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > >
> > > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > to major fault.
> >
> > Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> >
>
> I wrote exactly such piece of code a while ago. Here's part of it for
> reference, I think it will be helpful:
>
>   struct task_struct *task = (struct task_struct *)bpf_get_current_task();
>   const struct mm_struct *mm = BPF_CORE_READ(task, mm);
>
>   if (mm) {
>       u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
>       u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
>       u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
>       u64 shmem_pages = BPF_CORE_READ(mm,
> rss_stat.count[MM_SHMEMPAGES].counter);
>       u64 active_rss = file_pages + anon_pages + shmem_pages;
>       /* ... */

Thank you,

After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.

I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.

Matt Pallissard
