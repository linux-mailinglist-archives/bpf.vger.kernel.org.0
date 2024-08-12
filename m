Return-Path: <bpf+bounces-36907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B869A94F542
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4341DB25001
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EC1891A9;
	Mon, 12 Aug 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRS48Se6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A318754F;
	Mon, 12 Aug 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481369; cv=none; b=AOsTXnun3OCN4y8n8JyNO65qbE4vR4i1Itk9/2+/kDXWBX+0DnX/0x8yj4PslUMqeQQCg+Yi7JZ3FeyvbdDkipqOESrzVkuudQbs0XUJFHrdu5cUCGzw1RQd0AhiQaCdd1HYZEqdgbE3IXqORkkyfDWrQxDxVr6I9eVYH+Cjsd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481369; c=relaxed/simple;
	bh=gZ71JIUY6ZArmzi4xtfLFI83/0QyzpC82m2h2ix6kPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8bUKEGR2jFPWVPxek7tGqSjzpnJKbAx2mpiSugShKwspbTQ9ITCsZYyJhQUKVsVk9lBOfihxrt6PZ9EPsMCWZ6eidCAP/qAOdXauy2fD2TeWkzMMFR2NcyTuSpfVKvleIXqbCkNu3kSydFcmNvUQ759Up2i1ryZxip0stIYUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRS48Se6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a975fb47eso513215466b.3;
        Mon, 12 Aug 2024 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481366; x=1724086166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9uZeDuPO0pLPh6ITetlZN/9YjMUNqFK4FAQ3VBPba0Q=;
        b=jRS48Se6tt/CDLr5Lg+Hz/7EfP8Zjs3TKHuUkdRAdcpWOHZMCaE3Yk7IFuGQvvzTqQ
         wxjQ9NT1ENSbLoSaMBIXb8jn0kR7RLpFkJrlveH7cTM3+pm1SS8dxEbr2G+zq8H7HNQ2
         0CtiGpYK5Y6PxkUGFNngcRexhZh0bD3DfS8nSMgBk6E2eKmdBFuIH5CBTbTbQWykc0SB
         rt74Oz+zbEPigwNxNR3t6DCNk9xE1ROTbOlw4ShudbqI6NZEGeN5NxWpbuY+ppHAAcpv
         rfb7xMGcT85jki1Q4A0KYPfFxng2KVtKBsExGXOyH3UAyjdkm0M49S/w5lcxCWzsQJLY
         o7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481366; x=1724086166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uZeDuPO0pLPh6ITetlZN/9YjMUNqFK4FAQ3VBPba0Q=;
        b=kmL0u9GYfHmXs+Em9wdkU/6fnX6Zs8Uk3sfela99syyj+t0FAiH6wltImCVOlSgEwi
         WO0/8cCcasBI5P78llT7ZCWb2w5hNhtJEc3r3dwCWsYkeCrkE+wg7Hg6hJf/TgrpBZwo
         aAlktNGRsiakby8hQlznxTNTMD853qEcun+yO/W/AWckU3IoZPrnqO2B+Og+oty1GeeG
         rtk6N4FsPREe6h+9NHlaZT1o2c9AsVCeqTOrWbH6ktylKFGZu5UYa5osCxDNkeNAsQJe
         aMXY/Z4ewHGqsclC3B5zTRuBXGYZx6T27FW0T2t7FRErIbYmFJHQNDJUfoCMCS7NjbZg
         WIWg==
X-Forwarded-Encrypted: i=1; AJvYcCXb2t1XOM7Q6+NRmIespY3hRD3bNKqVywmkYw6nrcpDjDGrQ6BcEk+RgGHewB6jTqQINkVyarLVGVKSr8vg2iXJYjDH085uhZV8kMDGB09RZHo/I1/O7kmw1TB9RhDHKBZlVEyh2rx3
X-Gm-Message-State: AOJu0YytxWRGTH0OnQ5J3jeD+9DJY7R3v/RTYMCoAVf68+6Y08qL7ENC
	75i04NGr6cLepIq+cFHu7YzHOJ+Fi6bxJMOMKuqM3YkuZCRZGpYRg3sE1f+tim+uPbWLALcu6pM
	0ySso5EWvVxfwB5rGVhQVp3OplAY=
X-Google-Smtp-Source: AGHT+IETp1u9kozZxrM/pEb5Ga6JdC1ydH2ooYxdgtbe72RB1uSrOXzZBoXZJqJAfxGhl/H6Kyo/lTiGipnefw1tkUU=
X-Received: by 2002:a17:907:e607:b0:a7a:c256:3cb with SMTP id
 a640c23a62f3a-a80ed25af8cmr67309966b.39.1723481365998; Mon, 12 Aug 2024
 09:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725001411.39614-1-technoboy85@gmail.com> <20240725001411.39614-2-technoboy85@gmail.com>
In-Reply-To: <20240725001411.39614-2-technoboy85@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Mon, 12 Aug 2024 18:48:47 +0200
Message-ID: <CAFnufp1jxnjL2apUwxWKkNzS5QKpDXYTWPnVLn-VQyZazFujCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: enable generic kfuncs for
 BPF_CGROUP_* programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 25 lug 2024 alle ore 02:14 <technoboy85@gmail.com> ha scritto:
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3052,6 +3052,12 @@ static int __init kfunc_init(void)
>         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
>         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
>         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEVICE, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYSCTL, &generic_kfunc_set);
> +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &generic_kfunc_set);
>         ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
>                                                   ARRAY_SIZE(generic_dtors),
>                                                   THIS_MODULE);

This seems not enough, some kfuncs like bpf_cgroup_from_id are still rejected.
To fix this we need also this chunk:

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8309,7 +8319,11 @@ static int bpf_prog_type_to_kfunc_hook(enum
bpf_prog_type prog_type)
        case BPF_PROG_TYPE_SYSCALL:
                return BTF_KFUNC_HOOK_SYSCALL;
        case BPF_PROG_TYPE_CGROUP_SKB:
+       case BPF_PROG_TYPE_CGROUP_SOCK:
+       case BPF_PROG_TYPE_CGROUP_DEVICE:
        case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+       case BPF_PROG_TYPE_CGROUP_SYSCTL:
+       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
                return BTF_KFUNC_HOOK_CGROUP_SKB;
        case BPF_PROG_TYPE_SCHED_ACT:
                return BTF_KFUNC_HOOK_SCHED_ACT;

but even with this it won't work, because
bpf_prog_type_to_kfunc_hook() aliases many program types with a single
hook, and btf_kfunc_id_set_contains() will fail to check if the kfunc
is in the set.

One solution could be to extend the btf_kfunc_hook enum with an entry
for every CGROUP program type, but a thing I wanted to avoid is to let
this enum proliferate in this way.
I wish to group all the CGROUP_ program types into a single hook, and
perhaps drop the "SKB" in "BTF_KFUNC_HOOK_CGROUP_SKB" which will have
no meaning anymore.

Ideas?

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

