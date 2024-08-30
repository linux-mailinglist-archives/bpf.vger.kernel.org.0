Return-Path: <bpf+bounces-38588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C78966875
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB511C218E0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C71BBBCC;
	Fri, 30 Aug 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg9kByCP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363F1BB6BD;
	Fri, 30 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040518; cv=none; b=E2gWWcY1B3W24LEmr6H+qQAPFm2Uf3wFKX1BgkxAfxT/erwXsLHfRKh/ai70l7H7LRbg8mvTPPmMHJ+MTRiK7dT4E8sQbzpP9M2p86aA39m88lcayM/avuyp+ihsZkA+uNDSDaeTkYf8JDtswcOkb9Hd7GFa0J7BScje/FYJoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040518; c=relaxed/simple;
	bh=f3THC0pBTuv9SAl7dOz57STAiV+tmA1lLWhuX8fg/Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/cOd660UJplb/JgHwnp3qXt/grRLZz8ineClIojOZIRyouhQCkr2fNS+mtYALs3VwX59raAm5T5To7GwtiEie4sQGK4WlrzuQ2CCE0zfXhdbu6AMXTvHJMTCmHEL2tQ0u4UWBsa8hcL0Wo5Pwa/bYb+6ZPKI/e4FVk6v64FrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg9kByCP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso1602758a91.1;
        Fri, 30 Aug 2024 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040516; x=1725645316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ762szQ1qEpWPo0O5KQwapOAPZbS/knJpSelWgCLe8=;
        b=Fg9kByCPmwiPICxxkSYdamntmDe34mWjgH7v0hg2M50LP10TYwlaMDCyVBfphPxSWP
         +VvSVjiXN4RzsQFlfG6IEVvbUqO3XO6+eYPuLXWDjaL2erDGzc3Pve+gpC0EGwbbzMiV
         n27XUWcqwKsqjwOBqwnpz/MUKzycTYjXJKdm751Deihl038QrepDOj9qetnBaXt+89gm
         ONuX0gLsAv2S9fWKVZu0KaYit0ZKWhb687TIhgatoqR0WEkzq3tOw84ifnERxxXMzUYM
         I9m5wB17IrDtK9Vsu8wShgHQWpw1iL70St8f91FoWxvkLA/qyzT1qubZ86v4O8W+3R9n
         3UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040516; x=1725645316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ762szQ1qEpWPo0O5KQwapOAPZbS/knJpSelWgCLe8=;
        b=gpeiVkpdmfrD2+LXQnxOdCKCHD2qOIEUh+46uXYJUi0UYvceiN7vTICmQN7DU/pdHM
         dIgpUtpBADIeyo+kuVyqzcXhlUImezuyY0dDKLc1FBhquvg4zUXlYc8EOdHpNcurWj08
         XBps+zM+v9qbGtdhvkxqZomLhQKkcRwNu3Goci6vX5tRiXxRsdfKfv3VU7u/XMKB5WUF
         VroraMqtZZTakHz/0lRtr2Ba0PpDMc691rTboIAuLrSVnAPRUtLX97jp6sBtknjC6jSb
         IxTxlFoOT0+WUbHb5Ferha9CjzZ75FU03sB1Tn5PqUsQYt8uPEqDcr9XTf920sy1uVHI
         TIaw==
X-Forwarded-Encrypted: i=1; AJvYcCUo8TkL0azqtgYPIzLqdboxepp24g4LgUU4+8OUAAcBTApNN6s1eRdpQ9QRFLS9haZIf9w=@vger.kernel.org, AJvYcCVe9RBbyMGmNlgu15f0U/4AF46TI9wx2AH7KnbeVpQAisEh2YtaDArjF5ShVIiCxNTxsO6Pn+XPIZEua35aQ+UUTAhB@vger.kernel.org, AJvYcCXJ37v1PmrtiHC3CnAhmZvOXXLHHdSCg8ba9N6uYjrYF6wYxvofNecajciAHBtYQH9fvTBceHE3gj39P9HE@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeiyecGFCtJal0r77i2zMe2alsI5wtxJgiUJokpwjV2zUFC+4
	hKKkeHzHu5L/SZ1y86/cFvNnyuNepdmxr8RXVi3yA+hPRfcbPLJYz5Jk3Tj2qzaOwaR/bVSreNh
	mLQaPmdkUFVBmd2pHDKx3OmAW0uU=
X-Google-Smtp-Source: AGHT+IHtJjX1Gwk7q65iKPb2jj2ZTbFe6Gbjk0MA9s/QRUze7TuxIpE1CDYdoK+SEpOHhavyYH0EIzF6ReAgjG7xuJ8=
X-Received: by 2002:a17:90a:ce90:b0:2d8:6f73:55a with SMTP id
 98e67ed59e1d1-2d86f7305edmr2818362a91.25.1725040515970; Fri, 30 Aug 2024
 10:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-9-andrii@kernel.org> <202408310130.t9EBKteQ-lkp@intel.com>
In-Reply-To: <202408310130.t9EBKteQ-lkp@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 10:55:04 -0700
Message-ID: <CAEf4BzYiSfyZky+Axab6BwN55cyoY9N-0p7DA9R2OFr=ZdjS5Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] uprobes: switch to RCU Tasks Trace flavor for
 better performance
To: kernel test robot <lkp@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:42=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on next-20240830]
> [cannot apply to perf-tools-next/perf-tools-next perf-tools/perf-tools li=
nus/master acme/perf/core v6.11-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/up=
robes-revamp-uprobe-refcounting-and-lifetime-management/20240830-024135
> base:   tip/perf/core
> patch link:    https://lore.kernel.org/r/20240829183741.3331213-9-andrii%=
40kernel.org
> patch subject: [PATCH v4 8/8] uprobes: switch to RCU Tasks Trace flavor f=
or better performance
> config: i386-buildonly-randconfig-004-20240830 (https://download.01.org/0=
day-ci/archive/20240831/202408310130.t9EBKteQ-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a=
15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240831/202408310130.t9EBKteQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408310130.t9EBKteQ-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> kernel/events/uprobes.c:1157:2: error: call to undeclared function 'sy=
nchronize_rcu_tasks_trace'; ISO C99 and later do not support implicit funct=
ion declarations [-Wimplicit-function-declaration]
>     1157 |         synchronize_rcu_tasks_trace();
>          |         ^
>    kernel/events/uprobes.c:1157:2: note: did you mean 'synchronize_rcu_ta=
sks_rude'?
>    include/linux/rcupdate.h:206:6: note: 'synchronize_rcu_tasks_rude' dec=
lared here
>      206 | void synchronize_rcu_tasks_rude(void);
>          |      ^
>    1 error generated.

Missing #include <linux/rcupdate_trace.h>, will add.

>
>
> vim +/synchronize_rcu_tasks_trace +1157 kernel/events/uprobes.c
>
>   1145
>   1146  void uprobe_unregister_sync(void)
>   1147  {
>   1148          /*
>   1149           * Now that handler_chain() and handle_uretprobe_chain() =
iterate over
>   1150           * uprobe->consumers list under RCU protection without ho=
lding
>   1151           * uprobe->register_rwsem, we need to wait for RCU grace =
period to
>   1152           * make sure that we can't call into just unregistered
>   1153           * uprobe_consumer's callbacks anymore. If we don't do th=
at, fast and
>   1154           * unlucky enough caller can free consumer's memory and c=
ause
>   1155           * handler_chain() or handle_uretprobe_chain() to do an u=
se-after-free.
>   1156           */
> > 1157          synchronize_rcu_tasks_trace();
>   1158  }
>   1159  EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
>   1160
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

