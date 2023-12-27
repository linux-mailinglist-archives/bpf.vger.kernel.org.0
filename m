Return-Path: <bpf+bounces-18699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4F81F11C
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E58D1C20DC2
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455E46547;
	Wed, 27 Dec 2023 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpPtlNJm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374146522
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33677fb38a3so5555408f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703700437; x=1704305237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlGylqNq8TdIFjLBf/A/PFKt/Ri/0qWWW1D+4Vm4D28=;
        b=NpPtlNJmga1g5kj4hq8lywQDhoWaKfLkFubY0vJffGS6TsdaAmdNiJhXP2FibvsJE8
         vX2mD5SNHa1LcObqzn8C351jZ512+spRa46gb4oD7c/6hVAnr3sl1kjT6LAnKRY1hMgl
         R/x8yAq3Rs5PYp4WmT0RlnaHnvEP6a0G1N69o/g5RnsjbDlI+KCP6s6f/pA7P21d/9g8
         whtzgREx+Pt63nkYq5jX5jud64+hhq2FjKN8+l+/YJtzzOuc2415xe6EvY9tRt5cEUVP
         aDEBHJsanhZGJ7b0N8FidPF/wN0dRM+0udDeTTXV6aHFne4Z5dlRfW5lamaqRNTuBK7e
         AT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703700437; x=1704305237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlGylqNq8TdIFjLBf/A/PFKt/Ri/0qWWW1D+4Vm4D28=;
        b=C0ZzYCVtBmy5upUE6dbId87ESwMIQSVj4xwEhWLQk9pGw5g7vHe0lbyrgp48Nu/BHt
         yGE5Go0FVNKAPBhANXReSvCrJZr9EUoXioOIY8IrjywrTX+mWuTjhlVj6WnUYzSOgWjn
         zv4h7OvkydY7ctLx6XY2N4VFMPUW4WiWCHVvQ8jyrqA74/m8WlT/ayaK7FPoAJijNDUU
         DKgbTjs6WvkQZwDyv63VeTOAnz7W3O3M8b1JYOovoBOHPBftzgTdLm/ROPi38hONXMed
         ONcXQpdQHjFdoU7Zk8jD2ZHFopdWne7pCxL82l6+XxBI6xbUB4EqMmqCk1cf/pqiLzcb
         q9vg==
X-Gm-Message-State: AOJu0YzQGOaDdNFUpsdcXUcxPf8A/E93H2RvoGMte3Nr2DZdhqdjkOuF
	+cCy85+I4c/nbytZQD59eVbhjlRZ421KdM3L1UA=
X-Google-Smtp-Source: AGHT+IHv3sk2NJWE8dziATcNm8LXLgvIZXVxE6WN1eaE5vzPuSo9fbN/v6VnntgEQtzuORH/B3yPOqiVNXf0wVyXEuY=
X-Received: by 2002:a05:600c:468f:b0:40d:50a4:97bc with SMTP id
 p15-20020a05600c468f00b0040d50a497bcmr3463642wmo.25.1703700436669; Wed, 27
 Dec 2023 10:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227100130.84501-1-lulie@linux.alibaba.com> <20231227100130.84501-3-lulie@linux.alibaba.com>
In-Reply-To: <20231227100130.84501-3-lulie@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Dec 2023 10:07:05 -0800
Message-ID: <CAADnVQLZS4Do63myRNqL-1ho7SBm+fc2si9i3Km5spkxRtzKfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: add bpf_relay_output kfunc
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
> +__bpf_kfunc int bpf_relay_output(struct bpf_map *map,
> +                                  void *data, u64 data__sz, u32 flags)
> +{
> +       struct bpf_relay_map *rmap;
> +
> +       /* not support any flag now */
> +       if (unlikely(!map || flags))
> +               return -EINVAL;
> +
> +       rmap =3D container_of(map, struct bpf_relay_map, map);
> +       if (!rmap->relay_chan->has_base_filename)
> +               return -ENOENT;
> +
> +       relay_write(rmap->relay_chan, data, data__sz);
> +       return 0;

This just opens a can of worms.
Above is not nmi safe. relay_write() can be used only out of
known context which effectively makes it unusable out of bpf tracing
progs that can kprobe attach anywhere in the kernel.
perf_event buffer is the only sure way to deliver events to user
space with overwrite.
bpf ringbuf is a best effort due to
if (in_nmi()) if (!spin_trylock_irqsave

Sorry, but it's a nack to allow bpf progs interface with relay.

