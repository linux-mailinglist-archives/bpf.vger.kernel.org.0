Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C821599A3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgBKTXO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 14:23:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38399 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgBKTXO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 14:23:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so8869623qtp.5;
        Tue, 11 Feb 2020 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTVErdOhPMqjmKH4Vt71WjG/xvlQSdoZyLcqJPs8NyI=;
        b=P3ooChq6kvZIhr7XcOEtiiRxc1687DPEqbEg4/4yMkZhT8qGD5aqKeMyl05jMud3pW
         v0DFaIgytKCSt3qmM3qLAnSUJT9aFYUbLxNv059lWm365fFijRLnkEBUNPzfiABQUrjm
         BLlJ/Sl1g61AOhoMV2/+1ROKHVq1NFlYwW0JVa+V2ZZJWMoc2CDVy2YzF06f083YM6tz
         5eJhHBV/PcKr3VsTIbNbwWrxFEY1AXZLwgglvsOf3zzfeHQCYGZ3b7+X5b/qLFj5u7uG
         Sx1MduyIhxbuIBLBwpxLRqy2iN8z75+Y+5o9k5wFbX+mXo5tlvTewGLyB7S49NQAg8MM
         basA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTVErdOhPMqjmKH4Vt71WjG/xvlQSdoZyLcqJPs8NyI=;
        b=ONFH2xzWINEcgbPdb9IC14WFvj0NIz6YuLondUXV+U92NlXzT5TW6ozmqm15ELm46m
         4Wi2m2Yds1Gbs1ESvvU1stXRHMsD6hUqasIwBJ0OGR83olaG3txURy3m0sJY/KKzg4SU
         Yp0Cj35OuwOc/7uonxzcqx+8uWy3685li9vCdka0QuKBJrc26XWSt932owdDk3fZBbw+
         50S4O82hK428AoEP2hydTqGf1kyrbiJMd8Jl8obchFQOfnuPxtfCWGy9e3RHtCNhs4au
         m4Enw1V9WhjOJFHIFk+A8pByWOx2li/q9WMyHaiydBuvX1b2AoKIraA/Txf6RS9ytL2m
         oRwA==
X-Gm-Message-State: APjAAAWlfO2IF7VII/hqfn5UkjL9TSGwYJAZmrioiil8K/+sU8v1NzK9
        vBPDq+RbomrN/Qn30R8p5IGv3+0qe2ozVRHW4ZYCyA==
X-Google-Smtp-Source: APXvYqy7K2lHlyu4N49KYs7vxWcAZ4y1Gxr0ggx+na2NVWHrszh8DaCu9lR76bxZywcKDUpajBeMMauL5EJn+mHXZZc=
X-Received: by 2002:ac8:1385:: with SMTP id h5mr3799172qtj.59.1581448993092;
 Tue, 11 Feb 2020 11:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20200210200737.13866-1-dxu@dxuuu.xyz> <20200210200737.13866-2-dxu@dxuuu.xyz>
In-Reply-To: <20200210200737.13866-2-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Feb 2020 11:23:02 -0800
Message-ID: <CAEf4Bzam8ikJO7atrSS8s-rLJ0jHKNjahcuVEWFh7AAbGTaoGw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next RESEND 1/2] bpf: Add bpf_read_branch_records() helper
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 10, 2020 at 12:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Branch records are a CPU feature that can be configured to record
> certain branches that are taken during code execution. This data is
> particularly interesting for profile guided optimizations. perf has had
> branch record support for a while but the data collection can be a bit
> coarse grained.
>
> We (Facebook) have seen in experiments that associating metadata with
> branch records can improve results (after postprocessing). We generally
> use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
> support for branch records is useful.
>
> Aside from this particular use case, having branch data available to bpf
> progs can be useful to get stack traces out of userspace applications
> that omit frame pointers.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

LGTM, one typo in description of the helper. bpf-next is still closed,
btw, but should hopefully open soon.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/uapi/linux/bpf.h | 25 +++++++++++++++++++++++-
>  kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f1d74a2bd234..3004470b7269 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2892,6 +2892,25 @@ union bpf_attr {
>   *             Obtain the 64bit jiffies
>   *     Return
>   *             The 64 bit jiffies
> + *
> + * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> + *     Description
> + *             For an eBPF program attached to a perf event, retrieve the
> + *             branch records (struct perf_branch_entry) associated to *ctx*
> + *             and store it in the buffer pointed by *buf* up to size
> + *             *buf_size* bytes.
> + *     Return
> + *             On success, number of bytes written to *buf*. On error, a
> + *             negative value.
> + *
> + *             The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
> + *             instead return the number of bytes required to store all the
> + *             branch entries. If this flag is set, *buf* may be NULL.
> + *
> + *             **-EINVAL** if arguments invalid or **buf_size** not a multiple

buf_size -> size

> + *             of sizeof(struct perf_branch_entry).
> + *
> + *             **-ENOENT** if architecture does not support branch records.
>   */

[...]
