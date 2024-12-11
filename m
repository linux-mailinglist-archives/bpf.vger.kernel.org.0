Return-Path: <bpf+bounces-46670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919099ED82D
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26359281FDE
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D920CCDB;
	Wed, 11 Dec 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/3i7tgJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BD1C4A36;
	Wed, 11 Dec 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951430; cv=none; b=tT2ZQP4BdiVf05Z6bpfJ8TQowEsC706onPPfYeD9SmueGbYncBfyo+25rHfyMihaEJfE7afdD1BjXdmC3cDdAifEiSRzSefhSMmr2xm9A9nBmAbFMvZAXTgktY4skybXuBRL2XFoasu+H8oMczTYG6qHHKCRoH86zM7WAJGt37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951430; c=relaxed/simple;
	bh=OrSrCRThbnz38HRK4gbxPzXWxGq7zO/a92bWosVgsHM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy4VQsoWPVSda8egGq3L37TsTcn+74UjShCA51C2oUjCu3JUHXGb/5Q2191lhD1Yc6UaANXJZMxEM5FC+WBwp3IX05J/TPGSGJe6N2F74MbXOTFDQDzzltVtN1/FjK2uAmGTLZYZRxkQ5EXw/WrI0Xa82IVo2eEk5JxQU4/xdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/3i7tgJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso8529315e9.2;
        Wed, 11 Dec 2024 13:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733951427; x=1734556227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZz00LLpT83ITUjYV+X2dbIbEBxGxb+OmoGdlRCf7RU=;
        b=V/3i7tgJngYS9pDOasUwJpN3K6d8ax7/cyaeqKGQc/J67YA5/URqZ5tMVFdZFhjSFZ
         i82IbxTBJOHHKfPV7YjFNo+ob/GwJDhyOWMNUzx/Yr+r2U/jbB41wQEn+0+xwAr7NaKx
         A9fLD6zu64tfzXc9cAAncxsp1tyI5GuzQMd6S+G5ZSh4nrfV/GE3AHAfC5Coc1C2/QCt
         sQOFO7GPVj5svHUBIKprz8bOObNjI+GLb8+qGvlBXL+e3kZocaSHwNNdvLP8Z7i9C0pI
         QeuWqKzEQdwdedi99WUSLPUo8fj2KEehNLAdwmoqsQGA7HGQrst2S9fWdp45dLIT8bcz
         6W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951427; x=1734556227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZz00LLpT83ITUjYV+X2dbIbEBxGxb+OmoGdlRCf7RU=;
        b=PAYifbIJAPNhofsEUnpaz3O9OR6DNqK88ly0x6gYZvr8+1SGjDvWkqgT4EUFnLrjXW
         jXiJ0Bx5J3kPkfpwjcb/+fVruwLfSMcSuyquMHpqZ2dZ9gqzSeVJLRbzcMiTHEySA8ja
         z7Q9qXhct6XGYZRkKkyQmv6xfs/T5bHsUKKd9nFnff/oHw8cTOcYLImSB1ig7shXHg7W
         y39uy3bH4fCG0YhAq9m9KTWfpYn6adUQLMLuvwIYxQHQV0tjmmxcg4vFyh2fPeEYpjbH
         dhK4e/wq0jdRcmFgJGvsHZEuJmSZ//oLWbd+/TghfYcV/lVdHf3rxqaul3JLad1tYTwm
         u9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA1CC2IeskGNn5n/IfmdNDaQ96QbFnOQHF2emymnnFE+QU3RDQFiOiB6Q/62nwIw32Wek=@vger.kernel.org, AJvYcCV6rVExQL5ZltGZYZHYmLGxQ2Pq7eOOkwONJ3VFRLFWH0MiptwIHWYB43xKkQOar+726oYtPFbIa4ClYIWD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrz0gUkLtGR30rQWf0KZydpQgpplbxxfJ1PaIlbGDVAQqJXRC7
	IC7WtmLz4arx5L/Prm0z5P5Y09aQ1q7xUc+NNDfrCuQK8S2dikla
X-Gm-Gg: ASbGnct3pKmAh0oeP/esMJNYuQeA39FGAS3wAWT5aE9Y618/2jtGZtXVDnKAjiPneJO
	PcIsrcm1XiWaA8NhG0JQI91kylWyuxtgXAW94ulSpZZS0fPuygFopzIf+G9cKVLm/VPH+3jqaKo
	m7Zbb6f5dHtdQ4JVLK6SwceCz9EckCe3wol5FCaIxa6jk8+odgLoS+Ejee/fOMg0+CYt7zV/6Rq
	qHVf0tFO7E7m9a4zL0NMoSyoqwrl9rstEQICzzMfmzZL1J+JZMGMJtdViUEaiY=
X-Google-Smtp-Source: AGHT+IEoFF9lfFi/tcgC2R9iqPaNL1Un1IvsKyFFFNVGF8Q2i3Q3Ttd2SniT7E4tri3YhTDfR23Oqg==
X-Received: by 2002:a05:600c:4446:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4361c3723acmr35152305e9.13.1733951426556;
        Wed, 11 Dec 2024 13:10:26 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361e323828sm17329325e9.0.2024.12.11.13.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:10:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Dec 2024 22:10:24 +0100
To: Laura Nao <laura.nao@collabora.com>
Cc: olsajiri@gmail.com, alan.maguire@oracle.com, bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@collabora.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on
Message-ID: <Z1n_wGj0CGjh_gLP@krava>
References: <Z1LvfndLE1t1v995@krava>
 <20241210135501.251505-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210135501.251505-1-laura.nao@collabora.com>

On Tue, Dec 10, 2024 at 02:55:01PM +0100, Laura Nao wrote:
> Hi Jiri,
> 
> Thanks for the feedback!
> 
> On 12/6/24 13:35, Jiri Olsa wrote:
> > On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
> >> On 11/13/24 10:37, Laura Nao wrote:
> >>>
> >>> Currently, KernelCI only retains the bzImage, not the vmlinux
> >>> binary. The
> >>> bzImage can be downloaded from the same link mentioned above by
> >>> selecting
> >>> 'kernel' from the dropdown menu (modules can also be downloaded the
> >>> same
> >>> way). I’ll try to replicate the build on my end and share the
> >>> vmlinux
> >>> with DWARF data stripped for convenience.
> >>>
> >>
> >> I managed to reproduce the issue locally and I've uploaded the
> >> vmlinux[1]
> >> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of
> >> the
> >> modules[3] and its btf data[4] extracted with:
> >>
> >> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko >
> >> cros_kbd_led_backlight.ko.raw
> >>
> >> Looking again at the logs[5], I've noticed the following is reported:
> >>
> >> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
> >> [    0.416029] BPF:
> >> [    0.416083] BPF: Invalid offset
> >> [    0.416165] BPF:
> >>
> >> There are two different definitions of rcu_data in '.data..percpu',
> >> one
> >> is a struct and the other is an integer:
> >>
> >> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> >> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> >>
> >> [115801] VAR 'rcu_data' type_id=115572, linkage=static
> >> [115803] VAR 'rcu_data' type_id=1, linkage=static
> >>
> >> [115572] STRUCT 'rcu_data' size=1152 vlen=69
> >> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
> >> encoding=(none)
> >>
> >> I assume that's not expected, correct?
> > 
> > yes, that seems wrong.. but I can't reproduce with your config
> > together with pahole 1.24 .. could you try with latest one?
> 
> I just tested next-20241210 with the latest pahole version (1.28 from
> the master branch[1]), and the issue does not occur with this version
> (I can see only one instance of rcu_data in the BTF data, as expected).
> 
> I can confirm that the same kernel revision still exhibits the issue
> with pahole 1.24.
> 
> If helpful, I can also test versions between 1.24 and 1.28 to identify
> which ones work.

I managed to reproduce finally with gcc-12, but had to use pahole 1.25,
1.24 failed with unknown attribute

	[95096] VAR 'rcu_data' type_id=94868, linkage=static
	[95098] VAR 'rcu_data' type_id=4, linkage=static
	type_id=95096 offset=177088 size=1152 (VAR 'rcu_data')
	type_id=95098 offset=177088 size=1152 (VAR 'rcu_data')

will try to check what's going on

jirka

