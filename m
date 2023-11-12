Return-Path: <bpf+bounces-14944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F77E91EA
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B04F1C2087C
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF91548F;
	Sun, 12 Nov 2023 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPMbXXAY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90254156E7
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 18:06:38 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61B1BEF;
	Sun, 12 Nov 2023 10:06:35 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-779fb118fe4so238650785a.2;
        Sun, 12 Nov 2023 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699812394; x=1700417194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYBpqt2maZnXJZySEOxbkSAKhJ1TFL1DTl+f6jodsbI=;
        b=CPMbXXAYvvl4XNH3i1Xz0QDUQBmVIrNRqHppSX/obcoSlSClhoBJHlpDAgQv7nrMvL
         l2aLLyWPoPz2zlub5yDoHGcUxj+GpnlefUfCzwJOwEVPKNn44Il4kaouRZd4BY1njPQk
         X2qXNlDe1qP4nZApQyIl2r8boT08VEH/2nwhXoUNffMQSYpA+FcdxBF+YlqQchlWkCeg
         wlpqDYkpOMLLHvLeh6L3FoSCmijDmF2xBYv0tfOCyEDGdIqFihANfHTvDYXD3yzCozJJ
         bdYvTHEljZdubmkpPC9HJNPTIDA/5WVcFEA5DzV7WI29EGFzXJd9WtoTuBzziyDBX/rK
         9cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699812394; x=1700417194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYBpqt2maZnXJZySEOxbkSAKhJ1TFL1DTl+f6jodsbI=;
        b=o9ph4e0/rPTCdyZNgyx139cyj2s+8XHT1ju8UAzUleWDvEzMhoP441a5DNq77VIqmF
         YAhRRpEBwVHZM0+UpYSrKr2BJkjReBz6LHlod1m/TfMLvKtZ9iUc4ZHZWRz5JQvn/oI9
         wPBKAtXARd5IXbC412AVng5oeZNcI6cE8dMpevYQHabZu3t0tKJvFPiEMQFTH9MP1uKb
         JYPkk3oHyoTo2HsEkIAkKwKDLVLyVyJHZmfANVHkZjYrRbbSykrvS5e7xJkZSU1Os/Qh
         B1rWZrnZcyRDRiMGslU77OXLWt9/y7wjGyL0AE1gdIqEK1+YzzIRGg1emYzWcMA4qSgD
         nwHQ==
X-Gm-Message-State: AOJu0Yx2t3A9eHviQxUYpzCsfHYqvg+7dqGg7p5iWLoApJ+0So8fnXp+
	j29hbhOaB/kooGBj1Klv0ZU=
X-Google-Smtp-Source: AGHT+IFJ8x6v+MyEcgCMWlHG75yD0CeUScuXv5i/YFrWW0aTn2r7DUusfgfWijCP870D8Pb8/izHAQ==
X-Received: by 2002:a05:620a:4398:b0:767:2076:5bee with SMTP id a24-20020a05620a439800b0076720765beemr6126323qkp.9.1699812393971;
        Sun, 12 Nov 2023 10:06:33 -0800 (PST)
Received: from localhost ([50.201.95.250])
        by smtp.gmail.com with ESMTPSA id tp9-20020a05620a3c8900b007757eddae8bsm1292696qkn.62.2023.11.12.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:06:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Nov 2023 12:06:32 -0600
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap
 example schedulers
Message-ID: <ZVEUKK2sMgEZsmO_@mtj.duckdns.org>
References: <20231111024835.2164816-14-tj@kernel.org>
 <202311121239.GTR1obNe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311121239.GTR1obNe-lkp@intel.com>

On Sun, Nov 12, 2023 at 12:17:07PM +0800, kernel test robot wrote:
> Hi Tejun,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master next-20231110]
> [cannot apply to tip/sched/core tj-cgroup/for-next v6.6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

The patches are on top of bpf-next:

 git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

Will do.

> url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/sched-Restructure-sched_class-order-sanity-checks-in-sched_init/20231111-145751
> base:   linux/master
> patch link:    https://lore.kernel.org/r/20231111024835.2164816-14-tj%40kernel.org
> patch subject: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap example schedulers
> reproduce: (https://download.01.org/0day-ci/archive/20231112/202311121239.GTR1obNe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311121239.GTR1obNe-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-5.9.0-0.bpo.2-amd64".  Stop.

The example schedulers need the following options enabled.

  CONFIG_BPF=y
  CONFIG_SCHED_CLASS_EXT=y
  CONFIG_BPF_SYSCALL=y
  CONFIG_BPF_JIT=y
  CONFIG_DEBUG_INFO_BTF=y
  CONFIG_BPF_JIT_ALWAYS_ON=y
  CONFIG_BPF_JIT_DEFAULT_ON=y

Thanks.

-- 
tejun

