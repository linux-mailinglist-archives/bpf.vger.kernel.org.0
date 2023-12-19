Return-Path: <bpf+bounces-18268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBE81817F
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 07:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4081C23620
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 06:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35779C6;
	Tue, 19 Dec 2023 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tp1E5CRn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED912B8C
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc5a0130faso38132361fa.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 22:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702967052; x=1703571852; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Auxou83JdnsHIJC7wnABg9DC+uIr9hzQFpgIW17Duo=;
        b=Tp1E5CRnh6gnxx0TYdcrR4VTmH4OxE4CLoC9VS5WIa3qEp0YS0vA0x1/W43A5Ef+NB
         FtoCQULaPpL36EBQCaS4B51X2/t8KIRWkdwrviAksaiNcLccULwAlOf1vkQ9/oFHlkIs
         nc5LQHovGWTKXtQJiAnZk+/YRO1SQ72SSqFScTUf9NtcqwXE16nkAtLSPqI46th64zHy
         U2ENin46KSfDRDEERxffvPMGkoMHvVcZ/zKLTf34czsKTT3KXKOExTh1zRThN1RTa1U2
         hVSMg/7+lolBqyFsRuP8w69IG5dqBJ3SIjL2fRYTR/jfZJ6x1pZ3Cwfh+3QElAPIKwbV
         B30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702967052; x=1703571852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Auxou83JdnsHIJC7wnABg9DC+uIr9hzQFpgIW17Duo=;
        b=M8ZBs7T0eILwrf/OY0BDccEubN2TriypB4joCzZpsvntWG2pfIXW9fDpPo2jZHtRtF
         JVi3XdhogAudYL2aS8OfSdwpUR5P5c0TCFQ/LWDuSrZlmdsHxYPbIxvK+Tv0co/CPa60
         V8E834t/Q0KVkDVtCkdqBGfPK1g8F4uiHcmuK5vufiSBsIylMTbrNY/SEyISVA/IHujC
         yuwlNMQ1NBZR/Qr2yOYzKrxUGxS7joJf5eS/c1x/AM8QSh9/Iq1Wl3/ueFdAktNW95DL
         I0OOgTirVdmoygo3+UkgThDRdrB3s/vPw6rxilNJHkud6uGegxePhNPVlmkNzE+ZI4le
         RPIA==
X-Gm-Message-State: AOJu0Yyk/fQCLYroOeBYXf0hf0EKcvKb3SLDJCz/A3JjfqmtEwMp2f34
	4IQZFrC+nuaFmuwlV82L8lrvXg==
X-Google-Smtp-Source: AGHT+IGH900/aZY9sNxMTGw9nRG2mPGsKzKG7JYilU+W2GHS64Nu+zCzNN6qX6VL8kfur12XSzjzrQ==
X-Received: by 2002:a2e:7c17:0:b0:2cc:57a7:9076 with SMTP id x23-20020a2e7c17000000b002cc57a79076mr2447126ljc.65.1702967051892;
        Mon, 18 Dec 2023 22:24:11 -0800 (PST)
Received: from u94a ([2401:e180:8d03:b561:561e:cf3c:7434:b888])
        by smtp.gmail.com with ESMTPSA id g22-20020a62e316000000b006d273997cd5sm5538320pfh.91.2023.12.18.22.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 22:24:11 -0800 (PST)
Date: Tue, 19 Dec 2023 14:23:59 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, song@kernel.org, andrii@kernel.org, 
	ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, guwen@linux.alibaba.com, 
	alibuda@linux.alibaba.com, hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>, 
	"rihams@meta.com" <rihams@meta.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Message-ID: <qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
 <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
 <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>

On Wed, Dec 13, 2023 at 03:35:19PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 11, 2023 at 4:39 AM Philo Lu <lulie@linux.alibaba.com> wrote:
> [...]
> > >>> Imagine a simple case: the bpf program output a log (some tcp
> > >>> statistics) to user every time a packet is received, and the user
> > >>> actively read the logs if he wants. I do not want to keep a user process
> > >>> alive, waiting for outputs of the buffer. User can read the buffer as
> > >>> need. BTW, the order does not matter.

Not sure if it's the same usecase, but I'd imagine for debugging
hard-to-reproduce issue where little is known (thus minimal filtering is
applied and the volume of event is large), this would be quite useful.
You just want to gather as much details as possible for events that
happens just before the issue occurs, and don't care about events that
happended much earlier.

> > >>> To conclude, I hope the buffer performs like relayfs: (1) no need for
> > >>> user process to receive logs, and the user may read at any time (and no
> > >>> wakeup would be better); (2) old data can be overwritten by new ones.
> > >>> 
> > >>> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
> > >>> ringbuf: only satisfies (1). However, if data arrive when the buffer is
> > >>> full, the new data will be lost, until the buffer is consumed. (ii)
> > >>> perfbuf: only satisfies (2). But user cannot access the buffer after the
> > >>> process who creates it (including perf_event.rb via mmap) exits.
> > >>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> > >>> perf_events, but I do not know how to get the buffer again in a new
> > >>> process.
> > 
> > [...]
> > 
> > If it is indeed difficult with ringbuf, maybe I can implement a new type
> > of bpf map based on relay interface [1]? e.g., init relay during map
> > creating, write into it with bpf helper, and then user can access to it
> > in filesystem. I think it will be a simple but useful map for
> > overwritable data transfer.
> 
> I don't know much about relay, tbh. Give it a try, I guess.
> Alternatively, we need better and faster implementation of
> BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
> support overwriting and generally be a fixed elementa size
> alternative/complement to BPF ringbuf.

Curious whether it is possible to reuse ftrace's trace buffer instead
(or it's underlying ring buffer implementation at
kernel/trace/ring_buffer.c). AFAICT it satisfies both requirements that
Philo stated: (1) no need for user process as the buffer is accessible
through tracefs, and (2) has an overwrite mode.

Further more, a natural feature request that would come after
overwriting support would be snapshotting, and that has already been
covered in ftrace.

Note: technically BPF program could already write to ftrace's trace
buffer with the bpf_trace_vprintk() helper, but that goes through string
formatting and only allows writing into to the global buffer.

