Return-Path: <bpf+bounces-76046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337ECA4069
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0F7304B20B
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800433EAFF;
	Thu,  4 Dec 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SonUgAeH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119D31B107
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858461; cv=none; b=G4ar6w7kgqQW2vIT7L36jCRqgqmUlJGj4StDD839wn2EXn8+ZWBB2Aa15yyJDulmyS0TKDFE6blc3o/yn6PSTfMxlYRk3ONAUNgKoOQuKN7pgU2Tvb7DKKgR67s9lFjlvEvCBmroTD05isJN470Cm/Eder8l+mZfrPLJZnMUX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858461; c=relaxed/simple;
	bh=ogzhs+K8/nncQzYMAXtApIYDNbrH0JpnISXUE/QTmCs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9ec62Vb7wpA4eqg2PHc02cZFxa1dethE+aEBOgmh+ZrtUw3k6W98rc7Y6OuGo6VoMVc5xyeqjGmq4PLXLT6xd74DvbRS8H+ex2mpu/U339amGEXxZPtUi8X8WulOa5BMFR4k8LuUAalUii703Ij5oiPTwCPe8fGhjhdR94tUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SonUgAeH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e2eccd2so732871f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 06:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764858458; x=1765463258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OQ1axH1q6YiDBepsExxh/kCsQ5we62M82u0CfkZBOI=;
        b=SonUgAeHCcEa7Nb3JT4W9cZ2HoB/2ll+TFeaOdCRaQZUS9GpfkYkk0bvwvnGeyzSEe
         arqDIcbuAoXCpZwU0UL1h6LIqk9w3aNcMeI+YvIuc4FdGXXS9IA3N7Vk82Whu69cXM04
         JtWSbNyjy2ldE7gtJmrh9HPtfn1pZH8iUojf3LAt29lq2rqNaJobGF9aMpFzOfMhDZoK
         yZoASd0WTnbhc6l9HDgweIns67yOUGvKelQKGkpD2+3q58WGx3Vr+1VzVRQnoT4tPsbp
         ExiFDFyWTw0sJCHX1cM93pOZWeL0QX5NZT+71bfWIiXu/tlo8nOo7Ek9vD3Kr6XedaXn
         479w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858458; x=1765463258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OQ1axH1q6YiDBepsExxh/kCsQ5we62M82u0CfkZBOI=;
        b=Zaah99Wr0xMoMoO/7yalhKKqahDxCO8cU7FWX5HPM0wRw48KS+b+4qA25ClzvjPu69
         JFEofTBxczpetbpVqBvtPy+Q9Qa584NXp6E2I7pp33vxa5zFaiLAjRkbXQsg9AHCnPne
         vPpH1qL2yK5q0osJMMXm4zZ0ix78k7WY38JJf/82D9673gXE9H5TaRr1bOI2k6qTxLcU
         sZ5EUpQrKOHtm+pgb2SqcjdNz7iV8NAh4eAIhr9nOGJhSZKIDqu4FXIendhcssNQzKIl
         A3Fs13TyzC2Cl54UDAeHEIGVrR2R0ri5wT+qRgaYDZqWw0PS99dEYY2s5XkB6JmJvEjV
         MPkw==
X-Forwarded-Encrypted: i=1; AJvYcCUSCkZRYowSodNtrT3NOBX41yU+wPq9Rn64soOHy+syklTZClHo736J/o1/1PHOXhY+5dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnWcOifPKYj61KtS97RlfId2qV0Juu9YryyFgkVZKGxr/HgmU
	7gw312P0D/rrxblsVdn5ZpAF+xwRGQYOcl8QzaUF+59AmfC84Z0YNuRv
X-Gm-Gg: ASbGnctHpRDeNX4J5oII4mFHddW+2bGSHg6lL0VS2GNbOOlB+9scYai+byvqNfHAHZh
	QnC8u+FWQjEdDsTdOJFQeejgjTwic3ND5lSyzIZ8NMarfe2+ujoYRYX5Cyr1cQRuaVPC2aH92Mq
	bp0V/gT3e/gLJpkKLCXAtIfoVv0i7jpPv5lihUC0/xKATJFskHcztHYfa3phiLHy5lM1AHOrcyW
	I33mu7OB0iBS9uvZXVa0MooPrwQk1wqzpq8g+mE7u/S79siOZXSQvi8bIQHvR4ll2SAxd7xhmsn
	z0HDVV95ZMVnEhEUMAOdCIc0KXoCujmSqRllc8TYiwjnxAqbtrd/anjnXqt2AVWs9Aba/eERS4z
	S/KeM6FGcirssQ7EDuYRhr3yp1EAKqWq6CQrEGUz0R9Pm9VfjNJELslpDBLhy
X-Google-Smtp-Source: AGHT+IFnQQ8becnEaTn0KTt23OR8N4k5GgFAhsktS6Tsxf/fO9l7JvekT4rS8R2skMQ7eIQ1nU66aA==
X-Received: by 2002:a5d:5d05:0:b0:42b:3ab7:b8a8 with SMTP id ffacd0b85a97d-42f731727dfmr6824903f8f.17.1764858458166;
        Thu, 04 Dec 2025 06:27:38 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm3444201f8f.19.2025.12.04.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:27:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Dec 2025 15:27:35 +0100
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, bpf@vger.kernel.org,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
	Raja Khan <raja.khan@crowdstrike.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] bpf, x86/unwind/orc: Support reliable unwinding
 through BPF stack frames
Message-ID: <aTGaVw005i8-Lb3L@krava>
References: <cover.1764818927.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764818927.git.jpoimboe@kernel.org>

On Wed, Dec 03, 2025 at 07:32:14PM -0800, Josh Poimboeuf wrote:
> Fix livepatch stalls which may be seen when a task is blocked with BPF
> JIT on its kernel stack.
> 
> Changes since v1 (https://lore.kernel.org/cover.1764699074.git.jpoimboe@kernel.org):
> - fix NULL ptr deref in __arch_prepare_bpf_trampoline()
> 
> Josh Poimboeuf (2):
>   bpf: Add bpf_has_frame_pointer()
>   x86/unwind/orc: Support reliable unwinding through BPF stack frames
> 

tried with bpftrace and it seems to go over bpf_prog properly
in this case:

        bpf_prog_2beb79c650d605dd_fentry_bpf_testmod_bpf_kfunc_common_test_1+320
        bpf_trampoline_354334973728+60
        bpf_kfunc_common_test+9
        bpf_prog_f837cdd29a0519b9_test1+25
        trace_call_bpf+345
        kprobe_perf_func+76
        aggr_pre_handler+72
        kprobe_ftrace_handler+361
        drm_core_init+202
        bpf_fentry_test1+9
        bpf_prog_test_run_tracing+357
        __sys_bpf+2263
        __x64_sys_bpf+33
        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

