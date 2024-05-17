Return-Path: <bpf+bounces-29947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E28C877B
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E751F21034
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D25577E;
	Fri, 17 May 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=path.net header.i=@path.net header.b="F6gDSZW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E264F896
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953975; cv=none; b=KteB3MSbSKvPM+1PmJEXoyQ18cfCMH48j1rJlYU/1K6Er7dIfBlQ6C0uxAJuAHC7hvV2DwyUVCL33zAPkMZk31flbV/63mIikEx0uVmZXhYU8xgF6Ncag5u2BxkvmLWw1FKXKgh3JFA37A/IWlYKWx3X4gl8jRBQyjRVtrzw2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953975; c=relaxed/simple;
	bh=dXFjTn9N5P54UXe6Z3QHOIDZYirVJSqCBBfIrPK7JJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8zOvgnuTqaLqUd1K/FKpsOVq3yz1ZR3Nkb47EOK1xq2fimES3i195/Qgb01oY+60CJpuwWWPyaXffXEKEvhL0uyWvtk7DuOoy6urgqknl8aHyU/uCgBsaKgmKoo+kJBh4ujLcjwGcT00lvLlNvPssRf6suBryWjgnLDGqj1gPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=path.net; spf=pass smtp.mailfrom=path.net; dkim=pass (2048-bit key) header.d=path.net header.i=@path.net header.b=F6gDSZW6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=path.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=path.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43d67e7bfe1so757171cf.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=path.net; s=google; t=1715953972; x=1716558772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKPrC+bmlFtKOlBuqikgYkqqhqrkEcY9Yg+7rDnqkEw=;
        b=F6gDSZW6nOO6PCOdXpdUm/EIpDPnhQLE+/MAduCXhNy+ppIEZRwye+yWskp/iZZlG/
         4io2Tp4nic/YVJ8NlTAW/D6S1aLv5QaU4LBnijndHgtRuF7z175kgprQXOzRSYKlu6T3
         Ejx2bJ53FMzUQH/5kEmcVgVW2NDP/6rcqfrIPTGiFFdh3/CuKt5q5jPnfSNTD9s1Z0Vd
         OO7Oy0ZGKBjgadc2Ym6yG8jePUvvf4ICg+v9ZvYhd5WVutVHI8phkt7oyd4T970g/JpJ
         qiI1Co4165FUJXlEtK4lW4Uxg5y/HSq1XRLwUi4N4pDAQxqnFB6ji3ChKS75TmskwHQQ
         FRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953972; x=1716558772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKPrC+bmlFtKOlBuqikgYkqqhqrkEcY9Yg+7rDnqkEw=;
        b=kvl0h8x6UBJ4ncmLT97H35azKr3e70oYZjiK47/++5qEIM4SHpof6rCFwUZ/Hn38AA
         mPOWvsGqyCVFwA4Q9cItNkKbUNQVcFHWKbieDQCtOu2fsf88okBg1r4chs5laxwB1BG2
         5V9s6OeNRMZhaBj2zOcw8F1+YDMCsYoelKG4aafGrspjJXBjaTYq+XR6WQRZp7SH6pil
         FFkUuozjV+UsnZqt+Q8XHSaAy+U/dbejMB6mtiGsq8jd9E5NEO11g2sAPqhjACqkzyjL
         SPqSQirR5XKN96DM1DpmzLPF5Rh7K75FQvlkagn0+j1Egxf0NqGnHmI0NnxLOPOtKWOb
         14MA==
X-Forwarded-Encrypted: i=1; AJvYcCVzVXPiK5TIjdGQWfIwCQEsv4JH6kvmPfgTF4KksmpJraAyax9YPXLAC9lzxjGSbVzbG1Tm7RKe6dGqBBVaLjmYk13T
X-Gm-Message-State: AOJu0YxesVx8G+nzXfwoiMQKE3ywpbSsAjKOoCQCD8R/vQFXu3Ot30yO
	kJQT+aV4CeLUQvVTB/+ANL9McOZkxfjpYFR7gKqCGipq515pYOF70WXYgqVik7f0u8cplx7tlOS
	8V0kBR1PZO0mUPXhiaMkpQc5h25b4i8FZHI4HvA==
X-Google-Smtp-Source: AGHT+IEJlC3E40czsJd4vFja82oOwAUV17ARBeHi0rCNMlZKJqW4r5BWzEi7h1TzsLC/GXpIDvqUdei0P65GYLm3bDM=
X-Received: by 2002:ad4:4e88:0:b0:6a0:b3ec:8ff2 with SMTP id
 6a1803df08f44-6a16838ad4emr215245026d6.5.1715953972503; Fri, 17 May 2024
 06:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAiysedBwajcFQwuPrtn5bbdk_5zrNq=oY91j5mWyKdc+06uw@mail.gmail.com>
 <e697a0b2-7197-9a33-2efe-e11278b8835d@huaweicloud.com>
In-Reply-To: <e697a0b2-7197-9a33-2efe-e11278b8835d@huaweicloud.com>
From: Chase Hiltz <chase@path.net>
Date: Fri, 17 May 2024 09:52:39 -0400
Message-ID: <CAOAiysdcRkjNeJFKMss2nLYwAFd8QM87rLH6xjqBfmvWW5paZQ@mail.gmail.com>
Subject: Re: bpf_map_update_elem returns -ENOMEM
To: Hou Tao <houtao@huaweicloud.com>
Cc: xdp-newbies@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the replies.

> Joe also gave a talk about LRU maps LPC a couple of years ago which
> might give some insight:
Thanks, this was very helpful in understanding how LRU eviction works!
I definitely think it's related to high levels of contention on
individual machines causing LRU eviction to fail, given that I'm only
seeing it occur for those which consistently process the most packets.

> There have been several updates to the LRU map code since 5.15 so it is
> definitely possible that it will behave differently on a 6.x kernel.
I've compared the implementation between 5.15 and 6.5 (what I would
consider as a potential upgrade) and observed no more than a few
refactoring changes, but of course it's possible that I missed
something.

> In order to reduce of possibility of ENOMEM error, the right
> way is to increase the value of max_entries instead of decreasing it.
Yes, I now see the error of my ways in thinking that reducing it would
help at all when it actually hurts. For the time being, I'm going to
do this as a temporary remediation.

> Does the specific CPU always fail afterwards, or does it fail
> periodically ? Is the machine running the bpf program an arm64 host or
> an x86-64 host (namely uname -a) ? I suspect that the problem may be due
> to htab_lock_bucket() which may fail under arm64 host in v5.15
It always fails afterwards, I'm doing RSS and we notice this problem
occurring back-to-back for specific source-destination pairs (because
they always land on the same queue). This is a 64-bit system:
```
$ uname -a
5.15.0-76-generic #83-Ubuntu SMP Thu Jun 15 19:16:32 UTC 2023 x86_64
x86_64 x86_64 GNU/Linux
```

> Could you please check and account the ratio of times when
> htab_lru_map_delete_node() returns 0 ? If the ratio high, it probably
> means that there may be too many overwrites of entries between different
> CPUs (e.g., CPU 0 updates key=X, then CPU 1 updates the same key again).
I'm not aware of any way to get that information, if you have any
pointers I'd be happy to check this.


On Thu, 16 May 2024 at 07:29, Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> +cc bpf list
>
> On 5/6/2024 11:19 PM, Chase Hiltz wrote:
> > Hi,
> >
> > I'm writing regarding a rather bizarre scenario that I'm hoping
> > someone could provide insight on. I have a map defined as follows:
> > ```
> > struct {
> >     __uint(type, BPF_MAP_TYPE_LRU_HASH);
> >     __uint(max_entries, 1000000);
> >     __type(key, struct my_map_key);
> >     __type(value, struct my_map_val);
> >     __uint(map_flags, BPF_F_NO_COMMON_LRU);
> >     __uint(pinning, LIBBPF_PIN_BY_NAME);
> > } my_map SEC(".maps");
> > ```
> > I have several fentry/fexit programs that need to perform updates in
> > this map. After a certain number of map entries has been reached,
> > calls to bpf_map_update_elem start returning `-ENOMEM`. As one
> > example, I'm observing a program deployment where we have 816032
> > entries on a 64 CPU machine, and a certain portion of updates are
> > failing. I'm puzzled as to why this is occurring given that:
> > - The 1M entries should be preallocated upon map creation (since I'm
> > not using `BPF_F_NO_PREALLOC`)
> > - The host machine has over 120G of unused memory available at any given time
> >
> > I've previously reduced max_entries by 25% under the assumption that
> > this would prevent the problem from occurring, but this only caused
>
> For LRU map with BPF_F_NO_PREALLOC, the number of entries is distributed
> evenly between all CPUs. For your case, each CPU will have 1M/64 = 15625
> entries. In order to reduce of possibility of ENOMEM error, the right
> way is to increase the value of max_entries instead of decreasing it.
> > map updates to start failing at a lower threshold. I believe that this
> > is a problem with maps using the `BPF_F_NO_COMMON_LRU` flag, my
> > reasoning being that when map updates fail, it occurs consistently for
> > specific CPUs.
>
> Does the specific CPU always fail afterwards, or does it fail
> periodically ? Is the machine running the bpf program an arm64 host or
> an x86-64 host (namely uname -a) ? I suspect that the problem may be due
> to htab_lock_bucket() which may fail under arm64 host in v5.15.
>
> Could you please check and account the ratio of times when
> htab_lru_map_delete_node() returns 0 ? If the ratio high, it probably
> means that there may be too many overwrites of entries between different
> CPUs (e.g., CPU 0 updates key=X, then CPU 1 updates the same key again).
> > At this time, all machines experiencing the problem are running kernel
> > version 5.15, however I'm not currently able to try out any newer
> > kernels to confirm whether or not the same problem occurs there. Any
> > ideas on what could be responsible for this would be greatly
> > appreciated!
> >
> > Thanks,
> > Chase Hiltz
> >
> > .
>


-- 


Chase Hiltz



XDP Developer, Path Network

A 6991 E Camelback Rd., Suite D-300, Scottsdale AZ, 85251

W www.path.net  M +1 819 816 4353

