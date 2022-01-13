Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30DE48D106
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 04:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiAMDn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 22:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiAMDnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 22:43:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6976C03327F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 19:43:08 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g21so5451244qtk.4
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 19:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6k6NJsxXj5YfhQSmiemviYiME/l/siGhhpC0AN2qMg=;
        b=MjM9r2SGQO/E9XkRHWYWtj1FpRQbfWLVs8AUSwlUKCFNd+KPyTjSpqwicESaORCnOC
         bZB5JBLgiR9JZYCN7ZbSMPpIUixOg9QLH6TtFE9xqJN8cAMOnAd4MEgIMDKXg5SdmlFf
         qEJWYLjyaFbCd1sXgeRZZodbLVO86aPQkkXsWQN63gQ2sGBS7180C9KzYcevyKniZfNJ
         GQBgkEf9KkMSr4FjkcbcDB1mvleDEW6rAZPcQU1Q++sdyde1z50C8bw9SRirytBuMn6g
         47HheRCvd+cttlK9r5+Xe+2DJ7q68xLe7HbLFpWNCt52R0v9qC44XBJDU0TdMXENT/XE
         M1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6k6NJsxXj5YfhQSmiemviYiME/l/siGhhpC0AN2qMg=;
        b=nqZYp4/7yobqPwZ++dzYYNx0zcPt9J0A0hMtTGITvSoY2mP5QE/IS95KZ93EJYBjlf
         g4y/a5w6ou0PeCY0xfYUv9jXeVUSd0nXnzWWW4qk737YcNa4030qHtbgjPkIQP2C97sx
         gN+22hEVfXdWmvBPv5P3zCQ9nPD8MiYpQFu3HXEf/U6WPZg/cvuzy2u90n9VUQ5ide7m
         d8qK5mIDIolwc06ycT2w8IPZN+248lKjWA8lPnAqcEicTkxUavdPmHlr3bSfK7cRVhDV
         VIwDDcb2HkNF4Yp2BOOAa3nRHXS8gzwiywW0JxWWihMTlfiY0pFlXq7QBGPY33L0y2aG
         qN/A==
X-Gm-Message-State: AOAM531x7DCHV/QKc9C5/yBeNuoHxqE4cbQjuphQ9vJV/Wjj2mlJeQDN
        wCLe77VxMv4iLSyTKtP9IvHOYz5yF/r5C5wcdDuqBQ==
X-Google-Smtp-Source: ABdhPJzXJ1Rsc4WDrza846RBC13leRzHrVEcG0qhclBCFDiDZetiMXoW2OOpN2mkNUQSV/w90p0+FA2X8p0ZzuSJ+oI=
X-Received: by 2002:ac8:5796:: with SMTP id v22mr2134467qta.299.1642045387850;
 Wed, 12 Jan 2022 19:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com> <Yd9YFM5kqU9yKXf5@slm.duckdns.org>
In-Reply-To: <Yd9YFM5kqU9yKXf5@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 12 Jan 2022 19:42:56 -0800
Message-ID: <CA+khW7gDyT9x6hAZhYfsVe_R_UQCE0ZsTdPt8SAPuyP_F-uwVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 2:37 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Hao.
>

Thanks Tejun for your insights.

> On Wed, Jan 12, 2022 at 11:31:44AM -0800, Hao Luo wrote:
> > As a concrete usecase of this feature, this patchset introduces a
> > simple new program type called 'bpf_view', which can be used to format
> > a seq file by a kernel object's state. By pinning a bpf_view program
> > into a cgroup directory, userspace is able to read the cgroup's state
> > from file in a format defined by the bpf program.
>
> Both kernfs users - sysfs and cgroups - are hard APIs just as procfs, so
> allowing bpf programs to add arbitrarily formatted files anywhere likely
> isn't a good idea. Even ignoring the hard-defined interface problem,
> allowing arbitrary files can cause surprising failures through namespace
> collisions (which may be worked around by restricting where these files
> reside or how they're named).
>
> While the attraction is understandable, I think this is a misguided
> direction. Text file interfaces are okay, or sometimes even good, for
> certain things - communicating well established small piece of information.
> They're easy to access and as long as the format stays really stable, the
> million parsers that they end up spawning are mostly manageable although you
> inevitably end up with "I was reading 3rd field of 4th line and you added a
> new line above!".
>
> The above also illustrates the problems with using these text file
> interfaces. They're good for really static stuff or something really
> provisional like for debugging where there's only one or very few consumers.
> Outside of those extremes, they become pretty terrible. They are very
> inefficient when the data volume isn't trivial. There's no good way to
> synchronize accesses to multiple files. There are million ways to parse
> them, many of them ever so subtly wrong. There's no good way to version the
> interface (not that you can't). And if you throw these flexible files in the
> midst of other hard-API files, it'll severely exacerbate confusion.
>

I understand the importance of a set of hard APIs and appreciate the
effort maintainers put on maintaining them. I acknowledge the problems
of text file interfaces mentioned above. But there are situations
where the text file interface also provides great value, in a sense, I
think, outweighs its limitations. Bpf iter has many great
applications. Bpf iter could be made more efficient, providing greater
value.

I agree that mixing flexible files with hard-API files is a problem.
And my understanding is that, it's the key concern here. It would be
great if there is a way to separate the bpf files from the stable
APIs. I'm now thinking along this direction.

> Also, for something which isn't stable, I think it's better to have some of
> the access logic on the reader side. For example, let's say you've been
> using data from a cgroup file on the system. One day, the system boots and
> the file isn't there. How would you debug that? If it were a, say, py-bcc
> script which fetched data through bpf, it wouldn't be difficult to track.
> This isn't just happenstance - if you're reaching into a black box to get
> data, you better keep that mechanism close to you as it's a fragile
> temporary thing prone to breaking.
>

From the view of userspace, allowing bpf to define kernel interface is
giving the userspace full control. With everything controlled in
userspace, debugging is easier rather than harder in my understanding.
Access logic on the reader side is always needed of course. I've seen
bugs where even stable files in cgroupfs are seemingly missing, which
is harder to debug than bpf loading failure.

> Yet another argument against it is that the kernel is a really bad place to
> process and format data. We can't do real percentiles, or any kind of
> non-trivial numeric analysis, or even handle and format real numbers. Given
> that bpf already has an a lot more efficient way to transfer data between
> kernel and user, it doesn't make sense to push data formatting into the
> kernel. Export data to userspace, process and format there.
>

There is a plus side of processing and formatting data in the kernel.
Not every type of handling needs to process real percentiles or format
real numbers. A big saving in cpu cycles can be achieved by the power
of customizing data encoding inside the kernel.

Currently many data are exported in text, userspace parses them and
encodes them in a format suitable for network transmission (for
example, Protobuf). If the kernel can encode the data directly in its
final format, that would save the cpu cycles spent on encoding to and
decoding from text. Multiplying this saving by the frequency of data
collections and scale of the data center, the number can be
significant. Bpf can transfer data in binary, but there is currently
no good way to control data encoding and organize data in cgroups, as
far as I know.

> If there are reasons why this isn't very convenient using bpf. I think the
> right thing to do is improving those. One issue that Song raised was that
> there's no easy to allow non-root users to run specific bpf programs and
> even if we do that with SUID binaries, each execution would be pretty
> expensive involving full verification run and so on. But those problems are
> solvable - maybe known BPF programs can be cached and made available to
> other users - and I think concentrating on such direction would be way more
> fruitful for wider purposes than trying to make BPF show text files in
> existing fixed interfaces.
>
> Thanks.
>
> --
> tejun

Thanks,

Hao
