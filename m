Return-Path: <bpf+bounces-59424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18026ACA96D
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C713E1670D6
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8019AD8B;
	Mon,  2 Jun 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSU7IPnO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBA188587
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845219; cv=none; b=c+dQ5plWopggR7gfQeAVphKMBl2q0bn+iJVnq3SuJpQmbpLMdnRKk4T/4+JZ+kHX5i5IKnKnvDGFamewgBREj0URCzymsc+heqN+NqUL9aHlqCH+d5S15hxtbMgubgSHszUuoy9Fhxret/9h7QhlKukZAx8VNxF/wqB/EGeYcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845219; c=relaxed/simple;
	bh=uqhiVvUTjJUz12WNnC5vQ4AYx38ysdEHyQ+YwgWYwRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ic5Ghzok8rsRJzIKYlDD1CUIIyB7u0mH57yjOSME2hluaZQ+jhtTiMW65izqqlWuAIIWWZFtx8OGJFRNLmb4JWbSvbpAJFWvDyfUJalAcV1DYLp8ZsI8EMfkRs9DPeUsB/tqHc5OQuW1lY55xzRUEw9VBA9LZwC0zdwsrtoHzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSU7IPnO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so46216115e9.2
        for <bpf@vger.kernel.org>; Sun, 01 Jun 2025 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748845215; x=1749450015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOEMUoWDeDY5mzeOr4SEl8dbwxhrqozXvwOKEHtHeUk=;
        b=sSU7IPnOUUi7yGcTpR5L7oLOSaKVyOCpIH90T675LubPUAtDorfV2PnXkARETVOF4E
         eSN21BtaPO4Mp3AboQeI7H5hEH9x+yuudFzdhZ+IGQe8mN4Eb3yDjXRYywwANhgBKPuD
         zmar0EDkt2RZmDoC4L5cW3BoNNUnhffc7AxjZ1AUc1sybPS27ySDo8Fu61u+rbgtVcMj
         WmMqNQf9DLHfYY0PsgSN69SvMfiXRmMi8Vbjv9weRrJKcyUhZZXgv2hajgB/hw4BwSoG
         Or1YGfToONsRlikOEfBQx5kAyQSaaIwvQ/AW4DG5BXD67E2STBTZgIYGmg99JuXluCF1
         rSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748845215; x=1749450015;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOEMUoWDeDY5mzeOr4SEl8dbwxhrqozXvwOKEHtHeUk=;
        b=A7vLBx9asN8Dzk7lkmfNUB+JhBoTyWFVygGAKrecL7JG1yAVNjBHa2F9U2b0F2Z3Ir
         2q88qItTg/rgmYq5ihuUAm8f+0SLca6HtrVpEuoGmkmxdgaMekydrra1QBMsGVh2lHm+
         pPl8Q9QQKd75oTffCoVPl7ZOHtWeuLq5GB7ekkIg1fD6xzWSnU66k8WGxNsPDn9dkKW/
         yMKoOhCpeZ/0HdpNODh4RwYrUPFoN61EKYfGAu/ARABEDfeU26QNSpjQEYao4JyGViVV
         ZVeL2O7gKqmazvIRxsqbwwjWYli6Nuvk0Wh9mUh1k+QXQQUaHKYVChiRM6jptx3QPlxU
         04eg==
X-Forwarded-Encrypted: i=1; AJvYcCXFRrnBftrv+9BxGGyBuWH9Z+27uX86vzseAlrDS9uCrsOaTibUgXTjD67ahrgOHH6i5cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBUTxnPr3SWlIfxQxIstSubHLLw3yxQonrfP6pxN5gg2j7dES
	Rjl9K7frtTlwGdv2OxAXszEgZUMb9IqV6hn05+exi1AsOa7ilAaBQknYXELZ3SWPBvM=
X-Gm-Gg: ASbGncsL5/37biWMIWNMAobT9KLAjnGkrsINfKgDVjX6UFaDwCI668tDsK90tK4Kgfk
	S3J6APPVCoIsOotxSSfUE9Mix+St2MyvRxfN70GVBoj8IiP8puPERYGy1kVj96JFfchUPjFT2J1
	Eo2J+1/gbk9hx5rwW0gF24NXd4w++ncsFtH1SJByfu7ISmT/2Y8l1i1M/e/FJLnABkpYH8pzK04
	YGw4tzGTCZNBHnJH3W5+2oU5Pc1zuJ4slLJXc758veTgTvFziDHz3cVBzqD+m4U2TVO8TXm8Rip
	6mJhNIOTDrCRj8/RAxVYFRAtWr4+74Qfo2n/1ap9mDLlYDTpRc9fWH8=
X-Google-Smtp-Source: AGHT+IEhg9lSTzexUaVbkdcQrdyWsGg7a4BXZ1AHF91UKUvvwVHEH4xwEI9JAg73XATTsIBgax4M7A==
X-Received: by 2002:a05:600c:4f05:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-4511ee13fb8mr65790875e9.18.1748845215311;
        Sun, 01 Jun 2025 23:20:15 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fa24c6sm108973155e9.12.2025.06.01.23.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:20:14 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:20:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
	daniel@iogearbox.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, rtoax@foxmail.com,
	rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juntong Deng <juntong.deng@outlook.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Hou Tao <houtao1@huawei.com>,
	"(open list:BPF (Safe Dynamic Programs and Tools))" <bpf@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
Message-ID: <202505300432.nZC50gOu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>

Hi Rong,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Tao/selftests-bpf-Add-selftests-for-bpf_task_cwd_from_pid/20250529-113933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_97F8B56B340F51DB604B482FEBF012460505%40qq.com
patch subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
config: x86_64-randconfig-161-20250529 (https://download.01.org/0day-ci/archive/20250530/202505300432.nZC50gOu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505300432.nZC50gOu-lkp@intel.com/

smatch warnings:
kernel/bpf/helpers.c:2687 bpf_task_cwd_from_pid() warn: inconsistent returns 'rcu_read'.

vim +/rcu_read +2687 kernel/bpf/helpers.c

b24383bde5a454 Rong Tao     2025-05-29  2657  __bpf_kfunc int bpf_task_cwd_from_pid(s32 pid, char *buf, u32 buf_len)
b24383bde5a454 Rong Tao     2025-05-29  2658  {
b24383bde5a454 Rong Tao     2025-05-29  2659  	struct path pwd;
b24383bde5a454 Rong Tao     2025-05-29  2660  	char kpath[256], *path;
b24383bde5a454 Rong Tao     2025-05-29  2661  	struct task_struct *task;
b24383bde5a454 Rong Tao     2025-05-29  2662  
b24383bde5a454 Rong Tao     2025-05-29  2663  	if (!buf || buf_len == 0)
b24383bde5a454 Rong Tao     2025-05-29  2664  		return -EINVAL;
b24383bde5a454 Rong Tao     2025-05-29  2665  
b24383bde5a454 Rong Tao     2025-05-29  2666  	rcu_read_lock();
b24383bde5a454 Rong Tao     2025-05-29  2667  	task = pid_task(find_vpid(pid), PIDTYPE_PID);
b24383bde5a454 Rong Tao     2025-05-29  2668  	if (!task) {
b24383bde5a454 Rong Tao     2025-05-29  2669  		rcu_read_unlock();
b24383bde5a454 Rong Tao     2025-05-29  2670  		return -ESRCH;
b24383bde5a454 Rong Tao     2025-05-29  2671  	}
b24383bde5a454 Rong Tao     2025-05-29  2672  	task_lock(task);
b24383bde5a454 Rong Tao     2025-05-29  2673  	if (!task->fs) {
b24383bde5a454 Rong Tao     2025-05-29  2674  		task_unlock(task);
b24383bde5a454 Rong Tao     2025-05-29  2675  		return -ENOENT;

rcu_read_unlock();

b24383bde5a454 Rong Tao     2025-05-29  2676  	}
b24383bde5a454 Rong Tao     2025-05-29  2677  	get_fs_pwd(task->fs, &pwd);
b24383bde5a454 Rong Tao     2025-05-29  2678  	task_unlock(task);
b24383bde5a454 Rong Tao     2025-05-29  2679  	rcu_read_unlock();
b24383bde5a454 Rong Tao     2025-05-29  2680  
b24383bde5a454 Rong Tao     2025-05-29  2681  	path = d_path(&pwd, kpath, sizeof(kpath));
b24383bde5a454 Rong Tao     2025-05-29  2682  	path_put(&pwd);
b24383bde5a454 Rong Tao     2025-05-29  2683  	if (IS_ERR(path))
b24383bde5a454 Rong Tao     2025-05-29  2684  		return PTR_ERR(path);
b24383bde5a454 Rong Tao     2025-05-29  2685  
b24383bde5a454 Rong Tao     2025-05-29  2686  	strncpy(buf, path, buf_len);
b24383bde5a454 Rong Tao     2025-05-29 @2687  	return 0;
b24383bde5a454 Rong Tao     2025-05-29  2688  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


