Return-Path: <bpf+bounces-46791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C89F0133
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A4228611C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2B3D64;
	Fri, 13 Dec 2024 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzGF7bL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DB17D2
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050495; cv=none; b=R9Y3pl7TTJ1jY9cDjulb3E3iBok8KyT86q5TDQTy0IQiOIsRxyAlqmLI3HSgqU+sEAt5VGGXHzx54vCfY3340bL2m8g36GeKe35QT7v3qnmkNs5yZ/4elA4wdFO6V1aFg7uJ9Qnc8dJ6Yidc3U7qhNTG7ZjC+E+n3z7Ct1G6Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050495; c=relaxed/simple;
	bh=DJq6Ms4IVRquSJqX7EANytjz0NI9Ts7COYpV6ki8tuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX3MnWeDYTUjAI49vktsE+i4jPJ6ltTJ/2xsaXG9M0yOxfuI0RhDXTl0CvBByr5bAKQ4PKa0BfLiZ0CPnwT0gyX+na8VqnN2PctXFf4v6TXuDmP4FTb1G8DbW0Hr/Y/zYsImO33MahiUAAMXPldZHM136Wtma2XXiv9UChM0udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzGF7bL8; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5174f9c0d2aso332569e0c.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050492; x=1734655292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m+ZCldnUitqGlgGE0YS5tH/pwa/s4iNsTv5JehlLJ04=;
        b=mzGF7bL8F2/HqgtG7ZA0Hdh1+8X7ehBgEBISekFExOXi9VsjwKtC7PATuGi/8a6nnH
         sC/W2HQDGBrkbFByOB73H+MnJjcu7shTPiKTQeqwvLbj91icxMrUIidHOmmjqrZXVhoR
         s+hn1/ToQrqgFBC0qpOx4g9M320tvgkCHAkqpAqvJeXp3mL53CT2Cdx6xOeBpwsmasZO
         jtejMXzWph3VIwqY1SjGxij62Dd8CyNSES7C3wcp9R6/LOO0alOhZXWX49wFlTKy/4o1
         IUEApWJXrhqGVq/NwWeA1UxdnK14X1MRD0t7ZmDTndR83i5pnTaKwihy84S0M842yc2b
         Xmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050492; x=1734655292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+ZCldnUitqGlgGE0YS5tH/pwa/s4iNsTv5JehlLJ04=;
        b=w0BAoa7+PTqugKZciobCAcZpXNVIAMDXzElhe+yUaCupQaazcZdAN3kIQoD/Ri4P6P
         3c2oLh+J8XDRH5WPMAeLUTXwXaS/ewGn5W4Wno16j7prUDGLpOu5Q1LhRrdU0+YcgTok
         crM0E8+/rtykAzLG9JbhEggeMJcMCVboa14BojzMeJ3wsrvFUU6YEQsbYWUGJdhQToZ4
         6TVpL1b+PqC/M/ZZhaCt4GHCj+LDC7MuTUtAfGDOh3mO5Ui+4nAHh/svRFxh/EjEzugY
         PFsFyWi8Qz6OkT7DvJSLTqIUQflyPVobafOdWYmIS3jGtAtbBRTAGbk9Pf1gWd6ARN14
         fhJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrZIADAH3i+L4l0VJlU111zAWB+0k5g0UsFW6z68BIw8hZxlD3WAgA6o8YAL57LHdf/lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDb+vmTMZJKf+UONKbKHq9wqkwkmTdAiVyI0aTv40ktOcMRZS
	euTUWPsv/MwI89XV3AXPMNEzOwDRR7j15WbUnIEjZPBhrUmh7/2kinxksDO3J+EjwRrIds9pHIl
	DmO1Lj8UvJ5coilrJS1eQfiiTyubWesSm
X-Gm-Gg: ASbGnctjkxkP1TFf6nxf/7MmO/KMI/3cEMB6VEiu373VxUWjlYe2chI7bUhCd9hJu7J
	z3krKz/OQYtFe1tl7NaEXE989ev19jCsZ2d3wF4a5ZHl94cU6rVK7xC6X444r9qcid+BcGg0=
X-Google-Smtp-Source: AGHT+IG7LRO2L2OAPX+m3nDrplExwJ7Grkqzz+/MLAK/KsNnXahpj0t3FgZ2fYKf08EvcptoSYdbQI76pZcFvjeZ1Y0=
X-Received: by 2002:a05:6122:2a02:b0:518:9866:b79d with SMTP id
 71dfb90a1353d-518ca39956dmr1164689e0c.5.1734050492277; Thu, 12 Dec 2024
 16:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
In-Reply-To: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Thu, 12 Dec 2024 19:41:21 -0500
Message-ID: <CAE5sdEjZCDqgtvAFd_MpTyc+68UMLDufbsS9H2wMOLJiHQJQyw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry
 bpf programs
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 18:58, Priya Bala Govindasamy <pgovind2@uci.edu> wrote:
>
> BPF program types like kprobe and fentry can cause deadlocks in certain
> situations. If a function takes a lock and one of these bpf programs is
> hooked to some point in the function's critical section, and if the
> bpf program tries to call the same function and take the same lock it will
> lead to deadlock. These situations have been reported in the following
> bug reports.
>
> In percpu_freelist -
> Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCXmCrQ@mail.gmail.com/T/
> In bpf_lru_list -
> Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_oLk6qXR7LBOA@mail.gmail.com/T/
>
> Similar bugs have been reported by syzbot.
> In queue_stack_maps -
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.com/T/
> In lpm_trie -
> Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38@google.com/T/
> In ringbuf -
> Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.com/T/
>
> Prevent kprobe and fentry bpf programs from attaching to these critical
> sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
>

I think the current solution is to use a per-CPU variable to prevent
deadlocks. You can look at the hashmap implementation for reference.
However, ABBA deadlocks are still possible, so to avoid these, I think
the BPF community is working towards implementing resilient spinlocks.

I was planning to send patches for some of these bugs earlier. I'm
wondering if per-CPU checks would still be valid once resilient
spinlocks are introduced?

> The bugs reported by syzbot are due to tracepoint bpf programs being
> called in the critical sections. This patch does not aim to fix deadlocks
> caused by tracepoint programs. However, it does prevent deadlocks from
> occurring in similar situations due to kprobe and fentry programs.
>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  kernel/bpf/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7eb9ad3a3ae6..121ebcdc26cc 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,3 +52,10 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
>  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
>         $(call if_changed_rule,cc_o_c)
> +
> +CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_queue_stack_maps.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_lpm_trie.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_ringbuf.o = $(CC_FLAGS_FTRACE)
> +
> --
> 2.34.1
>

