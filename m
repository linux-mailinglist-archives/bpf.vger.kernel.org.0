Return-Path: <bpf+bounces-18698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554281F116
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAC628200B
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C546542;
	Wed, 27 Dec 2023 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQzUiqyq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01046522
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so4701622f8f.2
        for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703700149; x=1704304949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QOuG7g7nCDoycJifFUA1qqNA34Cf6FDgmD/vmx4StA=;
        b=nQzUiqyqMIJ85gfdOXwmBZobdgIWKEVesvG/KgHncW3PWpZlt3H21Z/KjOtUhfyvxJ
         FsXW/RdmmZfKqHq3so+YKJ3ibp6fTZ42UA7SJJ4dlIHpKz5Rp+Qq8AUswrxh0FP9VR6p
         yyeq7yt04hy5C8myaWU4zRIwzDBGjaXFQ1ugS2ggb5TB616/FfFxf3ZWYVcZwqYJoia/
         ve+c0beH5ea0BepagmZ2y3/mowiKo6WImt3ph4bp/jSsxxpUPKFsf/OiZ4zBgW/AMSC7
         FUBoLEEhZq9feTZPJRbIUJZ6MHKD3aFWuPS9eMrYoDcaIIIBJ02OLbuSih9BKWGMyE3Z
         J1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703700149; x=1704304949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QOuG7g7nCDoycJifFUA1qqNA34Cf6FDgmD/vmx4StA=;
        b=RQMJB4WqtuNy4/CCQJVPHG2wLT54zhyL+izN5yVCKM+sHhZSsxWn4ZGPxbuf8pvCgt
         tK7bdU7ruTYyJZE6rhrJ1D/MeU3DAG6p+AijKW+mcJIEVZRwf0YBIExee4Ysw9bk9B0g
         N0Mv2wE8MpTdt4YIO8MmxkZHWTOMYRdsNEVBOkAo2LkfGOWqLB5r7U4+yFcikST1JSzV
         0vfHCjYny9Jj0mW+s5RoRCaz7pqpXI55Os8ebMNWdMs0D4xQFRAmdXQilkMFjKHxz5Bc
         RXFLSuIzcqpJAN7nWEs1bH5IW0CRSZcd7Juj43TypvpaY93Wb6O1sIfDIsH2ugIkG2rc
         mbRw==
X-Gm-Message-State: AOJu0YwM/l5KB5N5ZUUsRIc1eeU32mNxp3sn8ya5S9OTxau8nvKe8ymK
	pcspEMN6IDDKk3tRXzLxSaMkoqN7DscZO62HCYI=
X-Google-Smtp-Source: AGHT+IHuaF0A0Qh4uzwc9aM4bNZKjFSSQhhk0o/WUu6EOEo2yLW5mp9LCjPkgeZh953ty8c+LhRRP3unU+iFXWyxpEk=
X-Received: by 2002:a5d:5984:0:b0:336:e160:d4d3 with SMTP id
 n4-20020a5d5984000000b00336e160d4d3mr882035wri.82.1703700149165; Wed, 27 Dec
 2023 10:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
In-Reply-To: <20231227100130.84501-1-lulie@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Dec 2023 10:02:17 -0800
Message-ID: <CAADnVQ+8GJSqUSBH__tTy-gEz9LMY5pPex-p-ijtr+OkFoqW1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	Hou Tao <houtao@huaweicloud.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, guwen@linux.alibaba.com, 
	hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 2:01=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based on
> relay interface [0]. It provides a way for persistent and overwritable da=
ta
> transfer.
>
> As stated in [0], relay is a efficient method for log and data transfer.
> And the interface is simple enough so that we can implement and use this
> type of map with current map interfaces. Besides we need a kfunc
> bpf_relay_output to output data to user, similar with bpf_ringbuf_output.
>
> We need this map because currently neither ringbuf nor perfbuf satisfies
> the requirements of relatively long-term consistent tracing, where the bp=
f
> program keeps writing into the buffer without any bundled reader, and the
> buffer supports overwriting. For users, they just run the bpf program to
> collect data, and are able to read as need. The detailed discussion can b=
e
> found at [1].

Hold on.
Earlier I mistakenly assumed that this relayfs is a multi producer
buffer instead of per-cpu.
Since it's actually per-cpu I see no need to introduce another per-cpu
ring buffer. We already have a perf_event buffer.

Earlier you said:
"I can use BPF_F_PRESERVE_ELEMS flag to keep the
perf_events, but I do not know how to get the buffer again in a new process=
.
"

Looks like the issue is lack of map_fd_sys_lookup_elem callback ?
Solve the latter part.
perf_event_array_map should be pinnable like any other map,
so there is a way to get an FD to a map in a new process.
What's missing is a way to get an FD to perf event itself.

