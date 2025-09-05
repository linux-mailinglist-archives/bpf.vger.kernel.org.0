Return-Path: <bpf+bounces-67541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F87B4521B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC421C23F3C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC527FB27;
	Fri,  5 Sep 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="axQEgHSr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6001FDE14
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062403; cv=none; b=EHekIdOWxXVFhwzu5CwxXt4CDZqKkr+6XDKQJJ49GswMpyIPn9fbG+f1i0izzQ0SmxR8dl6nlwEEuOxd1Z6KoxxXvDC63umqJSdjqI3dn7jjJ0Muqs/fkhFubyY+b6pAViME327Ybrpt/npkaMRtgVlYqyJUf6pOXflE8dhgz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062403; c=relaxed/simple;
	bh=PetPyduZIpB/oPcqQW6IpqKbYzqz/tqiYuaPOWMx4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jwl69ENghl9IrGT3NLb5Ag0NhwPIa21IEPtjjTQWVH06JzpSASRk/ufKaJ6LLD5yBR5pX5jpIlpt7eOhsY3tEvABKy9yyWKO82TasKLdMZhKRozAXZ0B+gvpPT4fY1GmRd9+MZ3KL2KROCl8BV/cqHHWq8E7XzY0L+CM12ZXWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axQEgHSr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1252976f8f.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062400; x=1757667200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NgQ8QPnuRQit7aGJLu142RMrYg/y2W1c0W+2cPMojw=;
        b=axQEgHSr24ZBiwhpTR7ma8FFwvZxBgfFClVXgXwGORXews9Kdy4cQPvYMjdyeApy5A
         kjgUAa5WIS4svLsLLLLOsgcWsiMUlYlh7QgDAjrObpH3R5pHfb2w0JQ1QoAdzBlWLO6e
         K5Ug6FZFJMt4JfNzFcYPmcQccU/4S3Az3IelTm7ra9rbK4nRiUBQhkeiAvjC/4EBLCe+
         Rt1xNuTOH4zZwhMnTow7xSHchCv5z/gwZeONQ6sSJZzI5MpvpuB/gzczVEv3OFcCdtuY
         yM361br6/Msz1Sc6Y2y40gek93nWL8pvxom/UsW+W+6hgXmT+M6GW/Q6vKsXvgU5DqXy
         J/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062400; x=1757667200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NgQ8QPnuRQit7aGJLu142RMrYg/y2W1c0W+2cPMojw=;
        b=MLFUd9Weh4kEfg+fvRQAUWa3bYt2/On4MfIltNFN0oDNkSWRPI3FlCUw9mgRk2tEV9
         QJo4kBokb4uEi2vIuz2HEBXeFUJB0iLEMIigJ+M950shjFxBkrSFlXZOAa//uBuSia3s
         bruEDMSkE6xW3N9Lu21ER3Yr4YR9+CXFBedem61fXS7+rPww2zEM4AN0eDWWdhnjzPZn
         NKi9ziaJDX9Z07yaJvSr4OfriRtectxlLfIB8mDx04pZD8hvIKiuWzZC7RL2UJplYSN7
         vOpufASI5hEVC9da5gxTJwVhyRBZr3EzXy2xZQhtzVpZhPJJ4YhECkljxoMw7s7RC2ek
         BQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDnAOJNl8rdR/0McPblJuFpphA67BwfIWSq81ceH0enbM0vSlJJIeRuwq1zuiN56J7Yro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgIViCXwRg9L7R44lCPOVbEUKIEKCa1IxOVufqZU0uQhNopCLA
	OMx0OoYU53U6cwe7VOtH45ofqShuioKmrYIrIt4hr9KdHkcsTjhoMxbsmapfM1qLd8E=
X-Gm-Gg: ASbGncsQ8G482Gzl0WjN8JnwcIa03M2e1dGi2M1Mrq3HtXpJ6Ym3Yo7l2wGYoeU7jRK
	YHhPp2PqyA0yFBZtuC+h4WlpMSUHv4ba9xmhdMtkLoKJeaJdlj8WNvmFhxt2oABV2TKPReOJlYw
	jL0TSnBppsq/fTJmwSrbxZNiJsM18rK7aRfL9nbRWFchbzkpY580wN606bWl77PGcryVjAmMfjQ
	1wzAuE4OOj2gICPLb7J7RLgqjKdfGcqn9ea5aq8hWmAVqyQLDx5edMw6LpcM0DrHMen3yJ8w0rX
	MNxRO5s5v+rZz8T8Ab9fdlgps7WNkSGv9jDoLjIN5Q1a2yoeNIcHro2H+108GZBQYZwH4xQA9zj
	vTXnhqKgvT6cTsEIeHv/tRUue6Ytljn64sUTTr9/SuWQLGvDNYCxVNANTbQ==
X-Google-Smtp-Source: AGHT+IHQl9jksdiN442oocqmuwM+Cn7y2/9wJITXpvg1zDy2P0is4gUPdRpKYpRdOz1I/pmegtbqGQ==
X-Received: by 2002:a05:6000:4022:b0:3d8:1f1b:9c9f with SMTP id ffacd0b85a97d-3d81f1b9fcemr12241560f8f.55.1757062399707;
        Fri, 05 Sep 2025 01:53:19 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:19 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/3] bpf: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:53:06 +0200
Message-ID: <20250905085309.94596-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (3):
  bpf: replace use of system_wq with system_percpu_wq
  bpf: replace use of system_unbound_wq with system_dfl_wq
  bpf: WQ_PERCPU added to alloc_workqueue users

 kernel/bpf/cgroup.c   | 5 +++--
 kernel/bpf/cpumap.c   | 2 +-
 kernel/bpf/helpers.c  | 4 ++--
 kernel/bpf/memalloc.c | 2 +-
 kernel/bpf/syscall.c  | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.51.0


