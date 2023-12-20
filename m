Return-Path: <bpf+bounces-18366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B004B819A95
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9811F2687E
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0DB1BDD6;
	Wed, 20 Dec 2023 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwuQ+qT8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C951BDE3;
	Wed, 20 Dec 2023 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so58934665e9.3;
        Wed, 20 Dec 2023 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703061294; x=1703666094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+g9MgkrsbgeWzmQbqUX9megZSG5rFi9XsjBl/q/N6s=;
        b=CwuQ+qT85kLdKH90ah/k3VSlb4YQwcXcc3fK+zgUKJmMrazdhsGgevoTnYVSg1ywIR
         Rk1g/ivSlRvLqlgT9D0TwTQJka111BKF7r2R0LhPYNt76AQaVZFTrCWuLtw4EG/vWLar
         APLs3e1ufAa6ROwy9jX/yyTd/6SK8oOj9M8Harb+yzuofVl9auAHtKa6l0+2ABTIvOL3
         M91bgmRWndKTD4LuBf/kfYRPPRGlizcooOG3Z9PUpxIVU8AzQoCDkVR4iMYiE50JxsvX
         I52t0tfKE2CgoV6iwTJCCbP/qW391wonHRA6OHYIq0aZrEKWk0vE9eppy6Rx+uJFoFBz
         KYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703061294; x=1703666094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+g9MgkrsbgeWzmQbqUX9megZSG5rFi9XsjBl/q/N6s=;
        b=JE9uAGQZb+7K0TYy7SMnJ2BGPFdD8P81ZpT68pW3dJU92yX4Q5B5g42r4hQ0xsJFJB
         5HvWsxsv9pq6bv9HYOGSVcrq/kEWm0wCp6ueblLr7/jiqlchGP4E0Vk0gKTdn+FXQrHV
         H4qU5I7LHtntUf1Lphnw/45q3/CEBCPZhJx52mURC/0sAbEvq2sQIRppWLtRkI+aVLMR
         KSkcukjA45JxupxHX8T9dSJe7DeKRSgKEe0BQ+bToaOz1tRkY61LB2Zf+Sd9hbuIXJVo
         +CwPUy6tpyH5GvGvQGCTTChBEmVwuWOqSArmUDnvlKa9CDKiK/ofZXqgcA9Q2iTXyqvx
         ntZQ==
X-Gm-Message-State: AOJu0Yx/M5GyiDNzpLhDLAWyhtidCbFOH7UzM3sxFiaAXJ8wNo8ums4I
	r4EDpRYdKnTP61POInjEV1v6f8PFGyU=
X-Google-Smtp-Source: AGHT+IHGrbj451rfQVp0+FydzdHi9UUXoEZ2TryCJ8J4y+4vcFbqlJRt8EExJkGlSWGjGX26u8Dd9A==
X-Received: by 2002:a05:600c:b43:b0:40b:4b2a:1605 with SMTP id k3-20020a05600c0b4300b0040b4b2a1605mr9510357wmr.41.1703061293371;
        Wed, 20 Dec 2023 00:34:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c4f1100b003fe1fe56202sm6401875wmq.33.2023.12.20.00.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:34:52 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Dec 2023 09:34:50 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [bug] splat in perf event
Message-ID: <ZYKnKry7zjxy6jFd@krava>
References: <CAADnVQ+vEstw90A-Urt-SgrdNNhuXO_VmWuojOJ=3zKReFWY2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+vEstw90A-Urt-SgrdNNhuXO_VmWuojOJ=3zKReFWY2g@mail.gmail.com>

On Tue, Dec 19, 2023 at 05:34:13PM -0800, Alexei Starovoitov wrote:
> Hi,
> 
> after rebasing bpf-next to the latest net-next.
> I consistently see the following while running
> test_progs -t attach_probe/manual-default
> 
> [   28.638654] WARNING: CPU: 1 PID: 2135 at kernel/events/core.c:1950
> __do_sys_perf_event_open+0x14e0/0x15b0
> [   28.639329] Modules linked in: bpf_testmod(O)
> [   28.639632] CPU: 1 PID: 2135 Comm: test_progs Tainted: G
> O       6.7.0-rc5-01520-gc337f237291b #5281
> [   28.640299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   28.641062] RIP: 0010:__do_sys_perf_event_open+0x14e0/0x15b0
> [   28.647751] Call Trace:
> [   28.647919]  <TASK>
> [   28.648082]  ? __warn+0xa1/0x1f0
> [   28.648311]  ? __do_sys_perf_event_open+0x14e0/0x15b0
> [   28.648641]  ? report_bug+0x1fa/0x230
> [   28.648902]  ? handle_bug+0x3c/0x70
> [   28.649164]  ? exc_invalid_op+0x17/0x40
> [   28.649416]  ? asm_exc_invalid_op+0x1a/0x20
> [   28.649699]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [   28.650062]  ? __do_sys_perf_event_open+0x14e0/0x15b0
> [   28.650406]  ? perf_event_set_output+0x2a0/0x2a0
> [   28.650727]  ? __audit_syscall_entry+0x4f/0x200
> [   28.651063]  do_syscall_64+0x2f/0xa0
> [   28.651306]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [   28.651635] RIP: 0033:0x7fc0846f752d
> [   28.656060]  </TASK>
> [   28.656219] irq event stamp: 413681
> [   28.656461] hardirqs last  enabled at (413689):
> [<ffffffff81193e67>] console_unlock+0x137/0x140
> [   28.657083] hardirqs last disabled at (413698):
> [<ffffffff81193e4c>] console_unlock+0x11c/0x140
> [   28.657663] softirqs last  enabled at (413368):
> [<ffffffff810c0e89>] irq_exit_rcu+0x99/0xf0
> [   28.658215] softirqs last disabled at (413351):
> [<ffffffff810c0e89>] irq_exit_rcu+0x99/0xf0
> 
> Line 1950 is
>         for_each_sibling_event(sibling, group_leader) {
>                 if (__perf_event_read_size(sibling->attr.read_format,
>                                            group_leader->nr_siblings +
> 1) > 16*1024)
>                         return false;
>         }
> 
> 
> Probably a known issue?

yes, https://lore.kernel.org/linux-perf-users/20231214000620.3081018-1-lucas.demarchi@intel.com/

looks like there'll be patch out soon

jirka

