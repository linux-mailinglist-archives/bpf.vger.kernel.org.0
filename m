Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B46289D3
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiKNTvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiKNTvS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:51:18 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747FC16
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:51:17 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y192so11359085yby.1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sg5Dni5DCJDAujeJpZa5ibaRe02AOPeH0OrypvPSAoI=;
        b=Ork/fUHHdkEvo2YB+SIDMZwJz2ASj9yWEDxW7mr/VdEvpY6mFLorTdnppVwdXW9nph
         IK1qlv8UcJ3wv21FPdmAdsx9Ah9cDcSCkwbNIL3TozpdUFLtgezPokiPHBFr2OxlB0w9
         o1++OIdq+9aVXkiLwjjFdz0PoniEyG1Y0oJGYzS4Gkihbhy3/yfIPIE0/azI/ODqdSpT
         r5h+ir4/qjr0OyU4/b400SeCxWShcWE5UQCjhMYdtEcyBIF9Mx3O+vgQfzUzChUIzz0J
         o6ZRW9ia3SPmgJua48EYanksieiw0tDTe7ZslkttRzW5A6vtrvgMVEwHtVyA0YJtB5HK
         EDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg5Dni5DCJDAujeJpZa5ibaRe02AOPeH0OrypvPSAoI=;
        b=TcDxKysoU3qBFFdKgpWR4Llz4ljG2uw9H7fM2824zbQ1DcB25VRXb0qrOaNb/RxHX+
         zvftaZFq9FqWi8KnNy8l8nge2A2WC/ImMl87+gkJDDY7MrFxWeJE/c+R41ByHPZwKMc7
         joMhoEwhWf8FRAnXocgV5aCS2PYxEQ5MCZ3TxA3Pn4Lh+89xV12IZAE+IzUKkSzR4xrm
         43qaCBF7iiw8fyS9EnRaPwF1N3r1lXM/gFTGWBOMU8UBiVKYKiKbXsg9Fye3ngZAb48f
         6s1uGf1J+3QLtdL6iAfxU8/K+pu+ksFCn3Nq9wex+N/ibcjL+smY5a5M4zfTUgshqMXx
         y44g==
X-Gm-Message-State: ANoB5pnktqK6DhaNT/1D+LTLq/opBYuHUQ/ruRdSKm7vTj+vxuBJyasn
        mSebhei8a6vsGpx1g8gNJZvHtKGv7+3n6Ic5ph+B413h
X-Google-Smtp-Source: AA0mqf4ljG5n0960v7XidYO2BcKJy/K1U5HwEhyPs9XK0Z8I7Ih1Qd6VJRQTFd2uZPmC6RJjVwQoGowk1nJf8pSOwuU=
X-Received: by 2002:a5b:405:0:b0:6d3:bab1:8e68 with SMTP id
 m5-20020a5b0405000000b006d3bab18e68mr12924093ybp.609.1668455476209; Mon, 14
 Nov 2022 11:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
 <20221111092642.2333724-3-houtao@huaweicloud.com> <Y26MTygDw2PUQlFz@google.com>
 <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com> <251d0ed2-7767-ecfa-1ac9-d6e940ad6c54@huaweicloud.com>
In-Reply-To: <251d0ed2-7767-ecfa-1ac9-d6e940ad6c54@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Nov 2022 11:51:02 -0800
Message-ID: <CAEf4Bzb7EwugkWY7Ma3hmsWA-8sHuh7MwzMRTEZh445q5XvqOw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] libbpf: Handle size overflow for ringbuf mmap
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     sdf@google.com, bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 7:34 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 11/12/2022 4:56 AM, Andrii Nakryiko wrote:
> > On Fri, Nov 11, 2022 at 9:54 AM <sdf@google.com> wrote:
> >> On 11/11, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>> The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
> >>> will overflow u32 when mapping producer page and data pages. Only
> >>> casting max_entries to size_t is not enough, because for 32-bits
> >>> application on 64-bits kernel the size of read-only mmap region
> >>> also could overflow size_t.
> >>> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>> ---
> >>>   tools/lib/bpf/ringbuf.c | 11 +++++++++--
> >>>   1 file changed, 9 insertions(+), 2 deletions(-)
> >>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> >>> index d285171d4b69..c4bdc88af672 100644
> >>> --- a/tools/lib/bpf/ringbuf.c
> >>> +++ b/tools/lib/bpf/ringbuf.c
> >>> @@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >>>       __u32 len = sizeof(info);
> >>>       struct epoll_event *e;
> >>>       struct ring *r;
> >>> +     __u64 ro_size;
> > I found ro_size quite a confusing name, let's call it mmap_sz?
> OK.
> >
> >>>       void *tmp;
> >>>       int err;
> >>> @@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int
> >>> map_fd,
> >>>        * data size to allow simple reading of samples that wrap around the
> >>>        * end of a ring buffer. See kernel implementation for details.
> >>>        * */
> >>> -     tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
> >>> -                MAP_SHARED, map_fd, rb->page_size);
> >>> +     ro_size = rb->page_size + 2 * (__u64)info.max_entries;
> >> [..]
> >>
> >>> +     if (ro_size != (__u64)(size_t)ro_size) {
> >>> +             pr_warn("ringbuf: ring buffer size (%u) is too big\n",
> >>> +                     info.max_entries);
> >>> +             return libbpf_err(-E2BIG);
> >>> +     }
> >> Why do we need this check at all? IIUC, the problem is that the expression
> >> "rb->page_size + 2 * info.max_entries" is evaluated as u32 and can
> >> overflow. So why doing this part only isn't enough?
> >>
> >> size_t mmap_size = rb->page_size + 2 * (size_t)info.max_entries;
> >> mmap(NULL, mmap_size, PROT_READ, MAP_SHARED, map_fd, ...);
> >>
> >> sizeof(size_t) should be 8, so no overflow is possible?
> > not on 32-bit arches, presumably?
> Yes. For 32-bits kernel, the total size of virtual address space for user space
> and kernel space is 4GB, so when map_entries is 2GB, the needed virtual address
> space will be 2GB + 4GB, so the mapping of ring buffer will fail either in
> kernel or in userspace. A extreme case is 32-bits userspace under 64-bits
> kernel. The mapping of 2GB ring buffer in kernel is OK, but 4GB will overflow
> size_t on 32-bits userspace.
> >
>
>
> >
> >
> >>
> >>> +     tmp = mmap(NULL, (size_t)ro_size, PROT_READ, MAP_SHARED, map_fd,
> >>> +                rb->page_size);
> > should we split this mmap into two mmaps -- one for producer_pos page,
> > another for data area. That will presumably allow to mmap ringbuf with
> > max_entries = 1GB?
> I don't understand the reason for the splitting. Even without the splitting, in
> theory ring buffer with max_entries = 1GB will be OK for 32-bits kernel, despite
> in practice the mapping of 1GB ring buffer on 32-bits kernel will fail because
> the most common size of kernel virtual address space is 1GB (although ARM could
> use VMSPLIT_1G to increase the size of kernel virtual address to 3GB).

Yep, never mind. size_t is positive, so it can express up to 4GB, so
2GB + 4KB is fine as is already (even though it most probably will
fail).

> >
> >>>       if (tmp == MAP_FAILED) {
> >>>               err = -errno;
> >>>               ringbuf_unmap_ring(rb, r);
> >>> --
> >>> 2.29.2
>
