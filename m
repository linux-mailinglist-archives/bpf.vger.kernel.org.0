Return-Path: <bpf+bounces-17734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B824B8122E6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755822828F8
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF377B49;
	Wed, 13 Dec 2023 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLXR0tYu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33733DB
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:35:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1e83adfe72so694305866b.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510531; x=1703115331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjpafgKrWS1pmwYdy5r/gEaHJcxW+XJFuRUaW0em8nA=;
        b=fLXR0tYuiVJUSXOwhQ1osDkpQSF9eHUipK6a/kYNVDQvb0x1WhRhousu9U1yC+DG5x
         pQ27/5itjLbMGCOZKecdciW+n0MJJZxz8scuPrXLYzxDQIOKQQC3YnyPcFF4Vheusrwr
         2wbpymQZMpzoLjasIp0ZtGkUzBMD7Azt0qfkRy0AKkHyseVoWFZhjIHpozzkUB9s2Ho4
         BgmN7U/eEhTBjJZpkEeots5Xc3bdeng6lALW0yiNRaL41k5UXChr+yPS0ozuvK8Uxlqq
         c3dCbD/FHB3IaT2ABgMwE+urRE/s7Jj6XLtsRYo2vzNGYhEcByst4C2b74v4ikPdnZuB
         ADIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510531; x=1703115331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjpafgKrWS1pmwYdy5r/gEaHJcxW+XJFuRUaW0em8nA=;
        b=nE62t8Ot2B8kl2pt4NzRMh68J+xFZYY4+L13MNy64l3QiGKcLSkH+Lpo9ASnOovVSX
         ijXUmVHbXE6dQND6N7uyeObBwdOKmFIg1zMtbMF/yPod2Gz7XpDTySBg+y8ymnTvA+MW
         5Hd1K1AWvleKWlem7MBqK12r0poJ5jD0dzVdfAIL+DhPCnrnBqNhyF8pu1HyQj24UqpF
         dXeARGfv25Ks6f2kHqu4rh64ejIm2TSEs+cffOby2TKRfQuAfwpmkj+SZHqMletYI6BP
         3ZuCGoWeVw3fZRzKDDRhw7ZAuiB1I+GKF4qFhehQjXcnBctfrM86xh897QUh4n/ilV2A
         +3fA==
X-Gm-Message-State: AOJu0YwP38cnpxtZj69NDNFzZiUwnsYq0rf+fqq2sSrZ3ijR4Zw1ONPK
	Lmgcj0BT8KWdvPye4Jgo8G4S7EZEyh5pd0PYNAN/5VmZ
X-Google-Smtp-Source: AGHT+IGgzCOY/l+sHiS89Pm/wHGYSkDK1nBqCKKjHwHPy8niwSJc0LOSgNJY7+e+bZCHrXxyGeB7Nspo2UZpgnGghXg=
X-Received: by 2002:a17:906:4552:b0:a09:e781:97ef with SMTP id
 s18-20020a170906455200b00a09e78197efmr4556276ejq.73.1702510531577; Wed, 13
 Dec 2023 15:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com> <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
In-Reply-To: <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:35:19 -0800
Message-ID: <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, song@kernel.org, andrii@kernel.org, ast@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, xuanzhuo@linux.alibaba.com, 
	dust.li@linux.alibaba.com, guwen@linux.alibaba.com, alibuda@linux.alibaba.com, 
	hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>, 
	"rihams@meta.com" <rihams@meta.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:39=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
>
>
> On 2023/12/9 06:32, Andrii Nakryiko wrote:
> > On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> On 07/12/2023 13:15, Philo Lu wrote:
> >>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
> >>> appreciate it if you give me any advice.
> >>>
> >>> Imagine a simple case: the bpf program output a log (some tcp
> >>> statistics) to user every time a packet is received, and the user
> >>> actively read the logs if he wants. I do not want to keep a user proc=
ess
> >>> alive, waiting for outputs of the buffer. User can read the buffer as
> >>> need. BTW, the order does not matter.
> >>>
> >>> To conclude, I hope the buffer performs like relayfs: (1) no need for
> >>> user process to receive logs, and the user may read at any time (and =
no
> >>> wakeup would be better); (2) old data can be overwritten by new ones.
> >>>
> >>> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
> >>> ringbuf: only satisfies (1). However, if data arrive when the buffer =
is
> >>> full, the new data will be lost, until the buffer is consumed. (ii)
> >>> perfbuf: only satisfies (2). But user cannot access the buffer after =
the
> >>> process who creates it (including perf_event.rb via mmap) exits.
> >>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> >>> perf_events, but I do not know how to get the buffer again in a new
> >>> process.
> >>>
> >>> In my opinion, this can be solved by either of the following: (a) add
> >>> overwrite support in ringbuf (maybe a new flag for reserve), but we h=
ave
> >>> to address synchronization between kernel and user, especially under
> >>> variable data size, because when overwriting occurs, kernel has to
> >>> update the consumer posi too; (b) implement map_fd_sys_lookup_elem fo=
r
> >>> perfbuf to expose fds to user via map_lookup_elem syscall, and a
> >>> mechanism is need to preserve perf_event->rb when process exits
> >>> (otherwise the buffer will be freed by perf_mmap_close). I am not sur=
e
> >>> if they are feasible, and which is better. If not, perhaps we can
> >>> develop another mechanism to achieve this?
> >>>
> >>
> >> There was an RFC a while back focused on supporting BPF ringbuf
> >> over-writing [1]; at the time, Andrii noted some potential issues that
> >> might be exposed by doing multiple ringbuf reserves to overfill the
> >> buffer within the same program.
> >>
> >
> > Correct. I don't think it's possible to correctly and safely support
> > overwriting with BPF ringbuf that has variable-sized elements.
> >
> > We'll need to implement MPMC ringbuf (probably with fixed sized
> > element size) to be able to support this.
> >
>
> Thank you very much!
>
> If it is indeed difficult with ringbuf, maybe I can implement a new type
> of bpf map based on relay interface [1]? e.g., init relay during map
> creating, write into it with bpf helper, and then user can access to it
> in filesystem. I think it will be a simple but useful map for
> overwritable data transfer.

I don't know much about relay, tbh. Give it a try, I guess.
Alternatively, we need better and faster implementation of
BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
support overwriting and generally be a fixed elementa size
alternative/complement to BPF ringbuf.

>
> [1]
> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/r=
elay.rst
>
> >> Alan
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.micr=
osoft.com/

