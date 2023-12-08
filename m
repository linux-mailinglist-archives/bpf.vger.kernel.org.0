Return-Path: <bpf+bounces-17260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BA80AFAE
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C21C20CA1
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170ED3065D;
	Fri,  8 Dec 2023 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB/oQJJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E57171D
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:32:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1cdeab6b53so543664566b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074775; x=1702679575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ooIAcbyuL6t7oH9zSugMJZt1sBiD4NbkOaqOMtOf2w=;
        b=OB/oQJJcnEMr0yreNysZAO9YfrePeX/qhQtOavHr90I9yxQTuu93GY3Hr6Zm+8paUZ
         yHCjkKFjXJeJQtxBwPo7tbv0w6lSfQbCH+OVivj1hwEJd0HXtRkMXHe8HiY4EMNs/rnD
         s5EHBrl2ecAt7o0UatQ23NPJzohRebj+up61TDniMezwzE+CecHKy4Uul9EOVdyJZuy1
         VRZ2rjQrW3l2gH2VWNpQ8pJqOFqEffjQ9sX3yi3CbH3jxyipWDYMM67tyDj2mVk76KJ1
         ZxXO75HtR/3kJW2QNUmFHDSbVmSVnpZ91aibtjJfxZVDoBaH+kQXSUDDPvVxunZX8a/L
         oHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074775; x=1702679575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ooIAcbyuL6t7oH9zSugMJZt1sBiD4NbkOaqOMtOf2w=;
        b=nhdBcYygYRTEXohzCi/Vj6vzjVfLI25NPHK+woug/ZhD+Tv1TnLnkVvDZKqzC6Xc8j
         pvDy4QlW4xjcxk6FDIXM9byX74e3qltGJvtCOUq0OLvflNNlNOkRQ93GLJE7EVdiRIDj
         Vw6YagJqqBpafwFvbSVarhtQPH6/NfLk6fyQcNBolEcIQNbyJmiSGuZfU4S1FSGsPMtd
         dn3PbiUh0FYvl7AFNCFjIIynMXrxF1yi/Ex6bmexGnyn0jt5t2DiVd49aern2S7jpn7Q
         ADpuuNtE3X5CyragxwwNi9/yNJf6IJvUz3TpHE4FEL4M8/yiYQP7IxhM/m5xmKX+MhqZ
         gIUQ==
X-Gm-Message-State: AOJu0Yyx/djQfuUH1W7jHlPKDmZ/Xcri8vkTY4SEADUwJ5cfG8hlllRg
	cJlQIlkOfuWAgZsv1VLGO0hhe0b51jfuuN4v8g6K9rCD
X-Google-Smtp-Source: AGHT+IGe8CzvchAMQ6ia7BFji6Cxum8GPS05AXwQt8Z+CgrcWENTEuJtg5QC3MNaUNKcljV5G8Lzx55vKmYKM9UWlF0=
X-Received: by 2002:a17:907:7787:b0:a1e:9d2c:f10c with SMTP id
 ky7-20020a170907778700b00a1e9d2cf10cmr766325ejc.64.1702074775178; Fri, 08 Dec
 2023 14:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com> <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
In-Reply-To: <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:32:43 -0800
Message-ID: <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	guwen@linux.alibaba.com, alibuda@linux.alibaba.com, hengqi@linux.alibaba.com, 
	Nathan Slingerland <slinger@meta.com>, "rihams@meta.com" <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 07/12/2023 13:15, Philo Lu wrote:
> > Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
> > appreciate it if you give me any advice.
> >
> > Imagine a simple case: the bpf program output a log (some tcp
> > statistics) to user every time a packet is received, and the user
> > actively read the logs if he wants. I do not want to keep a user proces=
s
> > alive, waiting for outputs of the buffer. User can read the buffer as
> > need. BTW, the order does not matter.
> >
> > To conclude, I hope the buffer performs like relayfs: (1) no need for
> > user process to receive logs, and the user may read at any time (and no
> > wakeup would be better); (2) old data can be overwritten by new ones.
> >
> > Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
> > ringbuf: only satisfies (1). However, if data arrive when the buffer is
> > full, the new data will be lost, until the buffer is consumed. (ii)
> > perfbuf: only satisfies (2). But user cannot access the buffer after th=
e
> > process who creates it (including perf_event.rb via mmap) exits.
> > Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> > perf_events, but I do not know how to get the buffer again in a new
> > process.
> >
> > In my opinion, this can be solved by either of the following: (a) add
> > overwrite support in ringbuf (maybe a new flag for reserve), but we hav=
e
> > to address synchronization between kernel and user, especially under
> > variable data size, because when overwriting occurs, kernel has to
> > update the consumer posi too; (b) implement map_fd_sys_lookup_elem for
> > perfbuf to expose fds to user via map_lookup_elem syscall, and a
> > mechanism is need to preserve perf_event->rb when process exits
> > (otherwise the buffer will be freed by perf_mmap_close). I am not sure
> > if they are feasible, and which is better. If not, perhaps we can
> > develop another mechanism to achieve this?
> >
>
> There was an RFC a while back focused on supporting BPF ringbuf
> over-writing [1]; at the time, Andrii noted some potential issues that
> might be exposed by doing multiple ringbuf reserves to overfill the
> buffer within the same program.
>

Correct. I don't think it's possible to correctly and safely support
overwriting with BPF ringbuf that has variable-sized elements.

We'll need to implement MPMC ringbuf (probably with fixed sized
element size) to be able to support this.

> Alan
>
> [1]
> https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.microso=
ft.com/

