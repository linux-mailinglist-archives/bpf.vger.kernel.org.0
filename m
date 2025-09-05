Return-Path: <bpf+bounces-67569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BAB45B06
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03311754F7
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11600371EB2;
	Fri,  5 Sep 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="YWDkWDlO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18636CDE5
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084072; cv=none; b=OMD3I3V9zJNhr6TkneHOi+7EjFPkgwdxZcOhccMg8Q13VxF377L2JbD/gPkEnIc995HbmxDRHHeKyCxYtK0bnYALQ1zO/wRebAupTYVr4Ol5KZGx4kTKfEY3T0qrgwrrmBX61X7QSZhtiYAdPOAjA4AvNcNyvO4ohctzxmLjABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084072; c=relaxed/simple;
	bh=2QGDmWuuR0Q3I5spDA6jKf30IjmU5r3dVWiu2VclS8c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DaMuRUs01F3d/9obn9jultmiJGhzZ7a2uzvE5vxSine83yAFxp7m3ouKLq6fHvpgmRWnVyUkRfVz0pMh3A2uefTpX0cOxs2KjQa0ayZWl658BOrsYRVvvR4x40SvNpHWmEZwcrZxsd7Hq0R4yVRgbdZ1FOTjT/C+3stNMIaWkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=YWDkWDlO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e20aadso2435699a91.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1757084069; x=1757688869; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EUGswAdRItueoSYQPU7jm1v44GCGzqxzoNxIhfsat5o=;
        b=YWDkWDlOiSO0t24AQ3irHXNwg9LbNARWYiP53d3aqXTyTnZxRM1Aq4r+UL5Y6T7FOx
         rRq/3vqf5z7yGLtJZxEb4BcQD+IB04Ja2Ai+7MFLet0xcGOrKXAKVbWUZ/mcE1sr2ylQ
         bkvWtm/LkDa7hwsilHsz02sXfq/crBqShdZX/CO2H5IS6xH2xR8r2Sz5QHg55V+6x+GD
         HK9PaJu4q6SP75LDQDhS69MfeWfca3hEZF9e13Yzak2vquGL7R63ydYGN+ciOz3qUStp
         FbyQUU/NMMHGxmFCeNKQld6TvKZ84BjaSl7V+MoK8v7nJ7AO4aKoQ6HgDTPcbVHFjrUt
         qInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084069; x=1757688869;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUGswAdRItueoSYQPU7jm1v44GCGzqxzoNxIhfsat5o=;
        b=itwK/s12MNn7hj6zcQA5Y0hkAQhyKqhqJELdiZLOY607toGoUUwlYTJnHyXBLZztdF
         UVGIIbBbjrD0ijpfTuDvpAecneYfTHHrYZJfDn04v1hI/9D/MuJKZsNf2f7F3hE2aaIu
         Xlz7T1Yz95+xfDGdGfmevA+hIuCcfM3RyM8nqW3BqL9NjfnTYOAr200hO2yzGAkDpO9w
         hAiP9Md9tYZgFTaxbT6M+O+9e0cFjRNnWU0jB2TH8hwqZR5xkaxjxeYIXKI2enLIrEJv
         JJF/yjNvyYYngYXaNdvC+svx+T5mCFAgaAzRmCBneOTM7zxcFFqeX2d/xd3vXrVFRgkz
         XX8w==
X-Gm-Message-State: AOJu0Yy/kfu1/0WcOQdoeXaW9OtkZVkbYYPqqGdIUvfhi68guYmY2RoU
	JklhgKvxy042fX0yGRiSnQy/6k2puVr+7+ivVgra8hvRckwRQZ6YGLpfABi7cXRVecdFV6Rtg6s
	aLaj/lK79v6V6ySsh+ADTNM4TG2OcRSu/tEys6SWn62f5fOmh/NKw39g=
X-Gm-Gg: ASbGnct2BMnZW3ZR50YeCnuFm83sRpevn+mZxzl0+K7QOoxE16ibPZeKGQd3Kn+LCBv
	F9vfyqIYRkOvNB/dCuMOl8umWvYZk9/oGarlMYr+z3aSl9EAU+WRYkpYzPG4U20AjDydtLzPfye
	aos5aDjWAarIlDzFt+wqGEoa/vxCOhS2WAVBHd8QzglHtGHlEOLRjONHMl05GBA+faRWEu8KVd+
	afW2GfT0ziWxiUEtAc=
X-Google-Smtp-Source: AGHT+IGVDRL34ICZB5fqSj2g9AtAWwf3kFf6mJXzvvv5/3qI+MxVFX9TpEgwbnmZmNOIWDnKTMYULgUtrubVy57+FB4=
X-Received: by 2002:a17:90b:1d8f:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-32d17ce4d41mr1018715a91.23.1757084068872; Fri, 05 Sep 2025
 07:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Fri, 5 Sep 2025 16:54:18 +0200
X-Gm-Features: Ac12FXyFQZlSvqRV8e5HtPwJGSWd3jeHqhyyAqZRVdEAQ49uh4b1P8F6oU6aHts
Message-ID: <CAH6OuBRzMZfa2kR6KYw2-F3mo3LfqwdVDqLSAD6e-xU9C56Fdw@mail.gmail.com>
Subject: Kernel lockup on bpf_probe_read_kernel in BPF_PROG_TYPE_RAW_TRACEPOINT
 sched_switch program
To: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We're running into an issue with our eBPF-based CPU profiler that
we've been attempting to debug for a week now. The issue is that as
soon as our eBPF program(s) are attached, the entire system (kernel)
hangs, but only on specific distributions. We've managed to reduce the
problem down to the following code:

SEC("raw_tracepoint/sched_switch")
int raw_tracepoint__sched__sched_switch(struct bpf_raw_tracepoint_args *ctx)
{
    struct task_struct *prev_task = (struct task_struct
*)BPF_CORE_READ(ctx, args[1]);
    struct task_struct *next_task = (struct task_struct
*)BPF_CORE_READ(ctx, args[2]);
    return 0;
}

i.e. this is just a raw tracepoint attached to sched_switch. Loading &
attaching this program, which just reads the tracepoint args, will
result in the system immediately locking up on some distributions. It
works fine on Ubuntu, Debian (on various distros & kernel versions),
but will hang on Arch and Fedora. As far as we can tell there is no
relation to kernel version; we've tested both old (5.11 on Fedora 34)
and new (6.16.3-arch1-1 on Arch) kernels and both hang immediately
when this program executes.

The code above calls BPF_CORE_READ, which compiles down to
bpf_probe_read_kernel, which we've verified by dumping the xlated
version of the program after loading it (without attaching it. And
indeed, if we replace the BPF_CORE_READ with direct calls to
bpf_probe_read_kernel, it hangs in the same way.

To debug, we've attempted the following:

- Enabled nmi_watchdog, hardlockup_panic, softlockup_panic and hard &
softlockup backtraces. This doesn't give any further information.
- There is no relevant output from dmesg
- Regarding Arch, of note is that a Manjaro distro with its own kernel
works fine, but an Arch kernel doesn't. We suspect there is some kind
of kernel config option this code is interacting badly with, but we
have been unable to find such an option by diffing the kernel configs
of both the working & non-working machines.
- Attaching a kernel debugger via network. Unfortunately, the lockup
also locks up the networking layer, so gdb is unable to remotely
inspect the hanging state. We're currently in the process of setting
up a serial debugger.

We'll continue debugging this on our end once we get the serial
debugger components, but we were wondering if anybody has seen this
before or has any tips with regards to tracking down the cause of the
hang? Any input would be greatly appreciated.

Thanks,
Ritesh

