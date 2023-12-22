Return-Path: <bpf+bounces-18612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8981CB79
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4F71C22152
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282422F0E;
	Fri, 22 Dec 2023 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFHtmP5s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E022F0A;
	Fri, 22 Dec 2023 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2343c31c4bso236786666b.1;
        Fri, 22 Dec 2023 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256329; x=1703861129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PaGO3e4S7Mz7DX2ik/Mn+M/lkAUdon/WP8bigAYURNM=;
        b=AFHtmP5sPk1dDITrJ5kcxFGEbLF2+CalpyIrwYfRHraxCK0FJ3yhcOGcSj+dUGpqGY
         WzU7CGNdyVBTIiOefl043XMCJDUQxLF0tCUeNFPuJHTnQ3ZoJYtj1kvy7VSl7DNYbLrE
         Ia8awBqWIYeK3DpQ8zoN+qMiizALn98g0l9v6tViksd9TcbALy6OkKMkk7OCyWO42PCD
         LqrZo4vgnJ9N1cFjLsT9Q6BMFosCP5VC8VkS5yIwq9Sw5AGi0hQyAqea9DYoFHouy4ab
         VJycxYIJZ7rZchy5bn3zJIyS+W9lEmeIGzeEBURoVAz4vvb+FeWiMkzgS9fCNf5oH9Vk
         F0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256329; x=1703861129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaGO3e4S7Mz7DX2ik/Mn+M/lkAUdon/WP8bigAYURNM=;
        b=QaHNyExNX4ETy03V5YXCGF+e0Ed39LlKVnkRYSNwladSmzBetQ24Ifm665904j61Ym
         LqyBeuWurZ+0vuVLxj+ccT3XKRvXvzww3CKd/AZPAQfKQzUuVroWHXOjG4bsWObyhfuo
         fz3ugIiUkOOjeTkGC3UwG2sPNZfp0igGPCf/6YBjybzn3SBto/gaTFizWZ6OPZX+C4S9
         3KF0vJHFpZQt1K0nB7VyCng8mBd3a2jvH6KUHRfLsYXNt37YY9cKOFMFonzMfQ/eiqpa
         mveeBBWy9McC46Z1QDmfQSqAUudBt/irNOu6vtNolutxYXJOcODNcKgHBbiRWAUIo4c9
         Wgig==
X-Gm-Message-State: AOJu0YxE5+1qFwoYYw2SKKgozLAM7UcYzIRtC8qgXzCZUYP76FhBvUm2
	7uarxND4IOEr47QfSz6A6/8=
X-Google-Smtp-Source: AGHT+IHRq9vNtcPD6TI5+IAcMNZtPOwYWCZ+wZEukAEDwSlagGTGRU+GsvExJIrz2conL0o0JW/Oxg==
X-Received: by 2002:a17:906:51cc:b0:a26:bd3a:a838 with SMTP id v12-20020a17090651cc00b00a26bd3aa838mr315392ejk.215.1703256329345;
        Fri, 22 Dec 2023 06:45:29 -0800 (PST)
Received: from krava (host-87-27-10-76.business.telecomitalia.it. [87.27.10.76])
        by smtp.gmail.com with ESMTPSA id bz8-20020a1709070aa800b00a234b686f93sm2115645ejc.187.2023.12.22.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:45:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Dec 2023 15:45:25 +0100
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, hengqi@linux.alibaba.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
Message-ID: <ZYWhBWP_J_esr6TW@krava>
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222122146.65519-1-lulie@linux.alibaba.com>

On Fri, Dec 22, 2023 at 08:21:43PM +0800, Philo Lu wrote:
> The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based on
> relay interface [0]. It provides a way for persistent and overwritable data
> transfer.
> 
> As stated in [0], relay is a efficient method for log and data transfer.
> And the interface is simple enough so that we can implement and use this
> type of map with current map interfaces. Besides we need a new helper
> bpf_relay_output to output data to user, similar with bpf_ringbuf_output.
> 
> We need this map because currently neither ringbuf nor perfbuf satisfies
> the requirements of relatively long-term consistent tracing, where the bpf
> program keeps writing into the buffer without any bundled reader, and the
> buffer supports overwriting. For users, they just run the bpf program to
> collect data, and are able to read as need. The detailed discussion can be
> found at [1].
> 
> The buffer is exposed to users as per-cpu files in debugfs, supporting read
> and mmap, and it is up to users how to formulate and read it, either
> through a program with mmap or just `cat`. Specifically, the files are
> created as "/sys/kerenl/debug/<dirname>/<mapname>#cpu", where the <dirname>
> is defined with map_update_elem (Note that we do not need to implement
> actual elem operators for relay_map).
> 
> If this map is acceptable, other parts including docs, libbpf support,
> selftests, and benchmarks (if need) will be added in the following version.

looks useful, selftests might be already helpful to see the usage

jirka

> 
> [0]
> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/relay.rst
> [1]
> https://lore.kernel.org/bpf/20231219122850.433be151@gandalf.local.home/T/
> 
> Philo Lu (3):
>   bpf: implement relay map basis
>   bpf: implement map_update_elem to init relay file
>   bpf: introduce bpf_relay_output helper
> 
>  include/linux/bpf.h       |   1 +
>  include/linux/bpf_types.h |   3 +
>  include/uapi/linux/bpf.h  |  17 +++
>  kernel/bpf/Makefile       |   3 +
>  kernel/bpf/helpers.c      |   4 +
>  kernel/bpf/relaymap.c     | 213 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c      |   1 +
>  kernel/bpf/verifier.c     |   8 ++
>  kernel/trace/bpf_trace.c  |   4 +
>  9 files changed, 254 insertions(+)
>  create mode 100644 kernel/bpf/relaymap.c
> 
> --
> 2.32.0.3.g01195cf9f
> 

