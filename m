Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7AF48CE74
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 23:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiALWhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 17:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiALWhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 17:37:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CBC06173F;
        Wed, 12 Jan 2022 14:37:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i6so6742823pla.0;
        Wed, 12 Jan 2022 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U+sc6KtgRoS+9LrpSrj6S7S/CDF+dJR0qN3JYVPxs+A=;
        b=VDLKjim0gZntzDGmYgXAkXJQjOKsoxaH1K3KijzCT6mxdrFgMFkRetSzFyibplhWrv
         beWP9qE8mZOdMSgUGbwOHFyzaiqZPv/rcVFRe+S3hnq9qB9r6+D26X6uJMf+FnhgZILD
         QoJSDAvT1KyAwL4daqZYF4dXJAl6FvMuoNRX9K0C0fCqfvRAyI1E0I6/TFOiz93vF8hv
         ATNS+n1NUny3DPPlTNqsx1DT1R9EWIQ5RcKWQGYFI8OHmMadbOPIZNvj0T/gXL4OzUeG
         IAZeOfAO2Q+q8PZh42BO+tj9HEOnMYa70qaoYNr3GWzH9kxNUP3+EhCbS1+HT0/9TCAj
         Z+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U+sc6KtgRoS+9LrpSrj6S7S/CDF+dJR0qN3JYVPxs+A=;
        b=6vRo4G88r36C7UK8JIiyQwxdcSVO9uZtSH7rK+qo8lFUPcVJvPdEP1vkFucNkxz4OJ
         cEXSnOFx63TM86+CVEI24mI7qM1JziVKN0NuiIfdPIc3+0h99Jlz+xdJmdxa7nHuEp4o
         b5Zl3vDeTCcIwSO/lMlXWZ2J1XcIzC6t0UA5fhtMtPI2tJHPaqv7q1IwImyuHA/ftk3X
         3z6X4h06J6YuinhO7YuBwRjWuEY0YnKkveKHB2v3mfPnKI2qNhREV/sheXKtRUt/f3r2
         b1C0DBXU9ErEjHwWL6oefT0/cij9teg+BPXJZQj/TtWo0Bx/iq6OSMXHRdoym9BV9CtA
         BvHQ==
X-Gm-Message-State: AOAM531RAHeNV9JHtaDWtFKZSVjDvet/zeIY4xyqi9S9x2LcnPY1/kbV
        5IQjrHutANWdmqClsa1veco=
X-Google-Smtp-Source: ABdhPJzF9jqUMwcoq1X/AL/xhIDeq3L0uChXiWf6QuHcSv6mGbyciRg0ukPnM/bJfuill8HpNgYWYQ==
X-Received: by 2002:a17:90a:24d:: with SMTP id t13mr11280815pje.68.1642027030449;
        Wed, 12 Jan 2022 14:37:10 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l13sm579204pgq.34.2022.01.12.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:37:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 12:37:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND RFC bpf-next v1 0/8] Pinning bpf objects outside
 bpffs
Message-ID: <Yd9YFM5kqU9yKXf5@slm.duckdns.org>
References: <20220112193152.3058718-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Hao.

On Wed, Jan 12, 2022 at 11:31:44AM -0800, Hao Luo wrote:
> As a concrete usecase of this feature, this patchset introduces a
> simple new program type called 'bpf_view', which can be used to format
> a seq file by a kernel object's state. By pinning a bpf_view program
> into a cgroup directory, userspace is able to read the cgroup's state
> from file in a format defined by the bpf program.

Both kernfs users - sysfs and cgroups - are hard APIs just as procfs, so
allowing bpf programs to add arbitrarily formatted files anywhere likely
isn't a good idea. Even ignoring the hard-defined interface problem,
allowing arbitrary files can cause surprising failures through namespace
collisions (which may be worked around by restricting where these files
reside or how they're named).

While the attraction is understandable, I think this is a misguided
direction. Text file interfaces are okay, or sometimes even good, for
certain things - communicating well established small piece of information.
They're easy to access and as long as the format stays really stable, the
million parsers that they end up spawning are mostly manageable although you
inevitably end up with "I was reading 3rd field of 4th line and you added a
new line above!".

The above also illustrates the problems with using these text file
interfaces. They're good for really static stuff or something really
provisional like for debugging where there's only one or very few consumers.
Outside of those extremes, they become pretty terrible. They are very
inefficient when the data volume isn't trivial. There's no good way to
synchronize accesses to multiple files. There are million ways to parse
them, many of them ever so subtly wrong. There's no good way to version the
interface (not that you can't). And if you throw these flexible files in the
midst of other hard-API files, it'll severely exacerbate confusion.

Also, for something which isn't stable, I think it's better to have some of
the access logic on the reader side. For example, let's say you've been
using data from a cgroup file on the system. One day, the system boots and
the file isn't there. How would you debug that? If it were a, say, py-bcc
script which fetched data through bpf, it wouldn't be difficult to track.
This isn't just happenstance - if you're reaching into a black box to get
data, you better keep that mechanism close to you as it's a fragile
temporary thing prone to breaking.

Yet another argument against it is that the kernel is a really bad place to
process and format data. We can't do real percentiles, or any kind of
non-trivial numeric analysis, or even handle and format real numbers. Given
that bpf already has an a lot more efficient way to transfer data between
kernel and user, it doesn't make sense to push data formatting into the
kernel. Export data to userspace, process and format there.

If there are reasons why this isn't very convenient using bpf. I think the
right thing to do is improving those. One issue that Song raised was that
there's no easy to allow non-root users to run specific bpf programs and
even if we do that with SUID binaries, each execution would be pretty
expensive involving full verification run and so on. But those problems are
solvable - maybe known BPF programs can be cached and made available to
other users - and I think concentrating on such direction would be way more
fruitful for wider purposes than trying to make BPF show text files in
existing fixed interfaces.

Thanks.

-- 
tejun
