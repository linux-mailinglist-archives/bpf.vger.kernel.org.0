Return-Path: <bpf+bounces-1922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A57240C7
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 13:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686A01C20F43
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1115ADA;
	Tue,  6 Jun 2023 11:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201D468F
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 11:23:59 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39DEE52;
	Tue,  6 Jun 2023 04:23:55 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qb7Ng6q2bz1c0Fy;
	Tue,  6 Jun 2023 19:22:11 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:23:52 +0800
Subject: Re: [PATCH v4 1/3] kallsyms: move kallsyms_show_value() out of
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
References: <CGME20230606042812epcas5p262df978931619b2d62e493d08147e120@epcas5p2.samsung.com>
 <20230606042802.508954-1-maninder1.s@samsung.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <df9f7a12-0542-97bb-b6c1-fdf0a21f815e@huawei.com>
Date: Tue, 6 Jun 2023 19:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606042802.508954-1-maninder1.s@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/6 12:28, Maninder Singh wrote:
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
> Thus moving out function to a new file ksyms_common.c.
> 
> With this patch code is just moved to new file
> and no functional change.
> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
> earlier conversations:(then it has dependancy on other change, but that
> was stashed from linux-next, now it can be pushed)
> https://lore.kernel.org/lkml/202205111525.92B1C597@keescook/T/
> https://lkml.org/lkml/2022/4/13/47
> v1 -> v2: separate out bpf and kallsyms change
> v2 -> v3: make kallsym changes in2 patches, non functional and
> functional change
> v3 -> v4: patch order changed, file name changed form knosyms -> ksyms_common
> and copyright header modified.
> 
>  kernel/Makefile       |  2 +-
>  kernel/kallsyms.c     | 35 ---------------------------------
>  kernel/ksyms_common.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 36 deletions(-)
>  create mode 100644 kernel/ksyms_common.c
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index f9e3fd9195d9..3947122d618b 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    extable.o params.o \
>  	    kthread.o sys_ni.o nsproxy.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
> -	    async.o range.o smpboot.o ucount.o regset.o
> +	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
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
> diff --git a/kernel/ksyms_common.c b/kernel/ksyms_common.c
> new file mode 100644
> index 000000000000..e776f12f0f5a
> --- /dev/null
> +++ b/kernel/ksyms_common.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0

Keep it the same as kernel/kallsyms.c. GPL-2.0-only

Sorry, I didn't think of that last time.
Otherwise,

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> +/*
> + * ksyms_common.c: A split of kernel/kallsyms.c
> + * Contains a few generic function definations independent of config KALLSYMS.
> + */
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

