Return-Path: <bpf+bounces-1924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5737240D4
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B9B28141C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE415AE2;
	Tue,  6 Jun 2023 11:27:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A614264
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 11:27:49 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5CE52;
	Tue,  6 Jun 2023 04:27:46 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qb7PZ539nz18M4Z;
	Tue,  6 Jun 2023 19:22:58 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:27:43 +0800
Subject: Re: [PATCH v4 3/3] kallsyms: make kallsyms_show_value() as generic
 function
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
References: <20230606042802.508954-1-maninder1.s@samsung.com>
 <CGME20230606042825epcas5p13579e5999f3cc7d9d517e4c3040cf16a@epcas5p1.samsung.com>
 <20230606042802.508954-3-maninder1.s@samsung.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bcc1828e-3d8a-5e97-8b7f-e1d5ec04d950@huawei.com>
Date: Tue, 6 Jun 2023 19:27:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606042802.508954-3-maninder1.s@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/6 12:28, Maninder Singh wrote:
> This change makes function kallsyms_show_value() as
> generic function without dependency on CONFIG_KALLSYMS.
> 
> Now module address will be displayed with lsmod and /proc/modules.
> 
> Earlier:
> =======
> / # insmod  test.ko
> / # lsmod
> test 12288 0 - Live 0x0000000000000000 (O)  // No Module Load address
> / #
> 
> With change:
> ==========
> / # insmod test.ko
> / # lsmod
> test 12288 0 - Live 0xffff800000fc0000 (O)  // Module address
> / # cat /proc/modules
> test 12288 0 - Live 0xffff800000fc0000 (O)

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  include/linux/kallsyms.h | 11 +++--------
>  kernel/ksyms_common.c    |  2 --
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 1037f4957caa..c3f075e8f60c 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -65,6 +65,9 @@ static inline void *dereference_symbol_descriptor(void *ptr)
>  	return ptr;
>  }
>  
> +/* How and when do we show kallsyms values? */
> +extern bool kallsyms_show_value(const struct cred *cred);
> +
>  #ifdef CONFIG_KALLSYMS
>  unsigned long kallsyms_sym_address(int idx);
>  int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
> @@ -94,9 +97,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
>  
>  int lookup_symbol_name(unsigned long addr, char *symname);
>  
> -/* How and when do we show kallsyms values? */
> -extern bool kallsyms_show_value(const struct cred *cred);
> -
>  #else /* !CONFIG_KALLSYMS */
>  
>  static inline unsigned long kallsyms_lookup_name(const char *name)
> @@ -154,11 +154,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname)
>  	return -ERANGE;
>  }
>  
> -static inline bool kallsyms_show_value(const struct cred *cred)
> -{
> -	return false;
> -}
> -
>  static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
>  					  void *data)
>  {
> diff --git a/kernel/ksyms_common.c b/kernel/ksyms_common.c
> index e776f12f0f5a..9603bbef095c 100644
> --- a/kernel/ksyms_common.c
> +++ b/kernel/ksyms_common.c
> @@ -6,7 +6,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/security.h>
>  
> -#ifdef CONFIG_KALLSYMS
>  static inline int kallsyms_for_perf(void)
>  {
>  #ifdef CONFIG_PERF_EVENTS
> @@ -42,4 +41,3 @@ bool kallsyms_show_value(const struct cred *cred)
>  		return false;
>  	}
>  }
> -#endif
> 

-- 
Regards,
  Zhen Lei

