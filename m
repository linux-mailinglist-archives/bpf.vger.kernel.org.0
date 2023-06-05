Return-Path: <bpf+bounces-1810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCAA7224A1
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591721C20AA5
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702817AA5;
	Mon,  5 Jun 2023 11:32:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113511C9B
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 11:32:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67BDE6;
	Mon,  5 Jun 2023 04:32:19 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QZWYH1RjJzqTh4;
	Mon,  5 Jun 2023 19:27:31 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:32:15 +0800
Subject: Re: [PATCH v3 1/3] kallsyms: move kallsyms_show_value() out of
 kallsyms.c
To: Maninder Singh <maninder1.s@samsung.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <mcgrof@kernel.org>, <boqun.feng@gmail.com>,
	<vincenzopalazzodev@gmail.com>, <ojeda@kernel.org>, <jgross@suse.com>,
	<brauner@kernel.org>, <michael.christie@oracle.com>,
	<samitolvanen@google.com>, <glider@google.com>, <peterz@infradead.org>,
	<keescook@chromium.org>, <stephen.s.brennan@oracle.com>,
	<alan.maguire@oracle.com>, <pmladek@suse.com>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Onkarnath
	<onkarnath.1@samsung.com>
References: <CGME20230605040744epcas5p21968bee09fba5c3505a729fe2f57c507@epcas5p2.samsung.com>
 <20230605040731.13828-1-maninder1.s@samsung.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fb89d084-9ccb-ee90-25aa-43122e86d663@huawei.com>
Date: Mon, 5 Jun 2023 19:32:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605040731.13828-1-maninder1.s@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/5 12:07, Maninder Singh wrote:
> function kallsyms_show_value() is used by other parts
> like modules_open(), kprobes_read() etc. which can work in case of
> !KALLSYMS also.
> 
> e.g. as of now lsmod do not show module address if KALLSYMS is disabled.
> since kallsyms_show_value() defination is not present, it returns false
> in !KALLSYMS.
> 
> / # lsmod
> test 12288 0 - Live 0x0000000000000000 (O)
> 
> So kallsyms_show_value() can be made generic
> without dependency on KALLSYMS.
> 
> Thus moving out function to a new file knosyms.c.
> 
> With this patch code is just moved to new file
> and no functional change.
> 
> Next patch will enable defination of function for all cases.
> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
> earlier conversations:(then it has dependancy on other change, but that
> was stashed from linux-next, now it can be pushed)
> https://lkml.org/lkml/2022/5/11/212
> https://lkml.org/lkml/2022/4/13/47
> v1 -> v2: separate out bpf and kallsyms change
> v2 -> v3: make kallsym changes in2 patches, non functional and
> functional change
> 
>  kernel/Makefile   |  2 +-
>  kernel/kallsyms.c | 35 ----------------------------------
>  kernel/knosyms.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 36 deletions(-)
>  create mode 100644 kernel/knosyms.c
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index f9e3fd9195d9..918d3e9b14bc 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    extable.o params.o \
>  	    kthread.o sys_ni.o nsproxy.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
> -	    async.o range.o smpboot.o ucount.o regset.o
> +	    async.o range.o smpboot.o ucount.o regset.o knosyms.o \
>  
>  obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
>  obj-$(CONFIG_MULTIUSER) += groups.o
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 8193e947aa10..0f82c3d5a57d 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -907,41 +907,6 @@ late_initcall(bpf_ksym_iter_register);
>  
>  #endif /* CONFIG_BPF_SYSCALL */
>  
> -static inline int kallsyms_for_perf(void)
> -{
> -#ifdef CONFIG_PERF_EVENTS
> -	extern int sysctl_perf_event_paranoid;
> -	if (sysctl_perf_event_paranoid <= 1)
> -		return 1;
> -#endif
> -	return 0;
> -}
> -
> -/*
> - * We show kallsyms information even to normal users if we've enabled
> - * kernel profiling and are explicitly not paranoid (so kptr_restrict
> - * is clear, and sysctl_perf_event_paranoid isn't set).
> - *
> - * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
> - * block even that).
> - */
> -bool kallsyms_show_value(const struct cred *cred)
> -{
> -	switch (kptr_restrict) {
> -	case 0:
> -		if (kallsyms_for_perf())
> -			return true;
> -		fallthrough;
> -	case 1:
> -		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
> -				     CAP_OPT_NOAUDIT) == 0)
> -			return true;
> -		fallthrough;
> -	default:
> -		return false;
> -	}
> -}
> -
>  static int kallsyms_open(struct inode *inode, struct file *file)
>  {
>  	/*
> diff --git a/kernel/knosyms.c b/kernel/knosyms.c

Maybe it's better to have the words like 'common' in the file name.
This file is also used when CONFIG_KALLSYMS=y, and knosyms is contradictory.

> new file mode 100644
> index 000000000000..9e2c72a89ea5
> --- /dev/null
> +++ b/kernel/knosyms.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Samsung Electronics Co., Ltd

This copyright notice is a little inappropriate. Now it's just moved, not original.

> + *
> + * A split of kernel/kallsyms.c
> + * It will contain few generic function definations independent of config KALLSYMS.
> + */
> +
> +#include <linux/kallsyms.h>
> +#include <linux/security.h>
> +
> +#ifdef CONFIG_KALLSYMS
> +static inline int kallsyms_for_perf(void)
> +{
> +#ifdef CONFIG_PERF_EVENTS
> +	extern int sysctl_perf_event_paranoid;
> +
> +	if (sysctl_perf_event_paranoid <= 1)
> +		return 1;
> +#endif
> +	return 0;
> +}
> +
> +/*
> + * We show kallsyms information even to normal users if we've enabled
> + * kernel profiling and are explicitly not paranoid (so kptr_restrict
> + * is clear, and sysctl_perf_event_paranoid isn't set).
> + *
> + * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
> + * block even that).
> + */
> +bool kallsyms_show_value(const struct cred *cred)
> +{
> +	switch (kptr_restrict) {
> +	case 0:
> +		if (kallsyms_for_perf())
> +			return true;
> +		fallthrough;
> +	case 1:
> +		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
> +				     CAP_OPT_NOAUDIT) == 0)
> +			return true;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +}
> +#endif
> 

-- 
Regards,
  Zhen Lei

