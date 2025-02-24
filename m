Return-Path: <bpf+bounces-52338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB28A41EE8
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997BD1886EB5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F92192E7;
	Mon, 24 Feb 2025 12:23:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3762571AD;
	Mon, 24 Feb 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399792; cv=none; b=MuF9Kqua7O8YPKWV7GJEzB7rAXeCN6AIWoVSs2qPIxbtdXVNTQAXH1dxrqL5epseKBbrL8Nm7HbsgTHayQ4J8QsesWpn7aC5Z1KO5E++572UNDCi0FguqHpu9CHQFWUWPxZWf8wg6j0UW079BmP2TZJr53h3O5l75q4+mlyjnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399792; c=relaxed/simple;
	bh=CmbC/F96+RPZ1IRVYGWb9VjmvwRIpPJc828eSkvb5ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD+BE7G7GHzyb72m+KcbxJ11WCdbfB/GzZKRbJaIrhxdEm3ZQOvIDP95kyLPExIPxWLGaHQma3CbFhZYM1AR1QBOIGFwcnn3DzAIs+clqFTutbulkOPKdCXJaogQH5dam3eJJWYVFua0Wh4LDgdA32FF6k3906HxSIKOg3rBaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb86beea8cso777484766b.1;
        Mon, 24 Feb 2025 04:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399788; x=1741004588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkcVWWowe/XlwLesIA74T7Kc+wW9oSTR0kY7TLZNlyE=;
        b=dBAFaKCz65qtlLj4tsnlg2+94L3RorfWJ98AVikFIpzzLLUZ8x9wGZ33tyM/7Yr1c1
         KmQl5KFrKu0UE9pwJPid4YreUlK1M9HpMWaznN/IFLZRNjxydB7x84dZ9V0QHeL9yH/Q
         f1FCaoKGsPe/gdnlf/fjO64MLXFVpII4b6eq2pOOUwleWvV1TIhNO2PNYLAKB0LykzS4
         OGJf2vNKlLqodyO+NKBqna434rf2HJGIGSJHOm4e+DsImyqkgIpn5R6u12fp9NjSlBkS
         WvbOKto/U7uzlUyeus851XOaG2+/JeT9XKSYTOVpZ5wT5Sxw032JXrDJqyvgq7RE2Hgo
         +3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCW2pwvhCBpFyROHSTQIuf/D91TQOtAAcaZKYcEEfnIndvEkjyC4QJ2XuVX64NG6Cty7lP9ajQRdwmfUBgr5@vger.kernel.org, AJvYcCWhr9j7AmL4vXvo1SIqf8tKS0Xxp9ZOI9zcyBgR8pgATye4lxkVhHa73084H0jUgxeZK0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIi/gE2ueSgmjOaJOXOdXYZgUuKy3fEmSYSFKetVrf6xQeQj6N
	uJN0I+Yyi15n3nyCFJNebmpWUvgTZZAiQ2d1+UX7475lPhxLAApClK7fNg==
X-Gm-Gg: ASbGncsJpsW02ooCFua1xenJSVvNxoMF7QgdkutGd/fCoqNBFp9bNvYpKVyovD61q0F
	+GwKfQlYJfaAL+FqZpCV6wdG+ECTBmr1xfxZcfXITOPl4pOZxVgfV2wsbu+T+Uc/vMWEaqXCgrR
	Bjd9sI5Kns9d0kTt0HFlw8LcoopEHr82eVEQruhwneB1e4GhV5m2TwlukIrPtJzyPrES3aIxO8a
	s/SYYxsLmwW0kvn9deu7T3iczbYop19SSBBC3pCDJ8TCsb0ZvBuUWu7vcUXR4XgPuiIbNRbXmkR
	8q7FoZoepHlXl/fUnA==
X-Google-Smtp-Source: AGHT+IFjZjKDjN5EXWE+BnTyShdH8rCGFExD7eS7HA3oT4lwQ7KO2yLywocY7OLik5IKwG1XKLh3Ig==
X-Received: by 2002:a17:907:3f19:b0:ab7:ea47:dee1 with SMTP id a640c23a62f3a-abc09e56c7emr1080435166b.48.1740399787765;
        Mon, 24 Feb 2025 04:23:07 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbab9e9863sm1436329266b.64.2025.02.24.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:23:07 -0800 (PST)
Date: Mon, 24 Feb 2025 04:22:23 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v3 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <20250224-impressive-onyx-boa-36e85d@leitao>
References: <20241024044159.3156646-1-andrii@kernel.org>
 <20241024044159.3156646-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024044159.3156646-3-andrii@kernel.org>

Hello Andrii,

On Wed, Oct 23, 2024 at 09:41:59PM -0700, Andrii Nakryiko wrote:
>
> +static struct uprobe* hprobe_expire(struct hprobe *hprobe, bool get)
> +{
> +	enum hprobe_state hstate;
> +
> +	/*
> +	 * return_instance's hprobe is protected by RCU.
> +	 * Underlying uprobe is itself protected from reuse by SRCU.
> +	 */
> +	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));

I am hitting this warning in d082ecbc71e9e ("Linux 6.14-rc4") on
aarch64. I suppose this might happen on x86 as well, but I haven't
tested.

	WARNING: CPU: 28 PID: 158906 at kernel/events/uprobes.c:768 hprobe_expire (kernel/events/uprobes.c:825)

	Call trace:
	hprobe_expire (kernel/events/uprobes.c:825) (P)
	uprobe_copy_process (kernel/events/uprobes.c:691 kernel/events/uprobes.c:2103 kernel/events/uprobes.c:2142)
	copy_process (kernel/fork.c:2636)
	kernel_clone (kernel/fork.c:2815)
	__arm64_sys_clone (kernel/fork.c:? kernel/fork.c:2926 kernel/fork.c:2926)
	invoke_syscall (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
	do_el0_svc (arch/arm64/kernel/syscall.c:139 arch/arm64/kernel/syscall.c:151)
	el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:745)
	el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
	el0t_64_sync (arch/arm64/kernel/entry.S:600)

I broke down that warning, and the problem is on related to
rcu_read_lock_held(), since RCU read lock does not seem to be held in
this path.

Reading this code, RCU read lock seems to protect old hprobe, which
doesn't seem so.

I am wondering if we need to protect it properly, something as:

	@@ -2089,7 +2092,9 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
				return -ENOMEM;

			/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
	+               rcu_read_lock();
			uprobe = hprobe_expire(&o->hprobe, true);
	+               rcu_write_lock();

			/*
			* New utask will have stable properly refcounted uprobe or

