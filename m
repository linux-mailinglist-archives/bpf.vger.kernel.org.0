Return-Path: <bpf+bounces-7815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5977CEE6
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769721C20CA1
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DD14A90;
	Tue, 15 Aug 2023 15:17:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1D134DB
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:17:30 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457521BFB;
	Tue, 15 Aug 2023 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YjYoGIziY2w2SX5FBV0LAvBmWZHGropt2vcWSdUJdtY=; b=DPdWmj470BuEOBTtkKtzBY4ko2
	ghXqtKYBFMKaAHfIqy/iQsBzO8ndnDytW/wQ07TaT4+8ykvDusl2fSXblwPhU+ijTG7NwC6ILJ3id
	EGcW75/+va4eU4AC762RGDeEco/Pf5yxETdGE/+7Q3WtZ1HDFlJik1+Ssvr3YZLddVD2xSvdk4Ljp
	X9FcUvebMUbSufuSh/lz1sqqGqmXitA9RLd4Hu/TnFidSBAVlGNkw2rLHcU7vgitTuFXtln2UIA8h
	tL8w/zPsM37Xx/+Q3V26P72XUh2RaECKXqkjuSQbzS2pqLo/5RBuWAk7S164AjCww5XbQ0As3lcYf
	8b9nhQxw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVvml-000Mk3-02; Tue, 15 Aug 2023 17:16:43 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVvmk-0004Dw-EL; Tue, 15 Aug 2023 17:16:42 +0200
Subject: Re: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
To: Rong Tao <rtoax@foxmail.com>, sdf@google.com, ast@kernel.org
Cc: rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20230812055703.7218-1-rtoax@foxmail.com>
 <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d1ad0b4d-574c-15e5-928f-2d9acc30dfe1@iogearbox.net>
Date: Tue, 15 Aug 2023 17:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27001/Tue Aug 15 09:40:17 2023)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/12/23 7:57 AM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v3: Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
>      Do the usual len/capacity scheme here to amortize the cost of realloc, and
>      don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>   tools/testing/selftests/bpf/trace_helpers.c | 42 ++++++++++++++++-----
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..d8391a2122b4 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,10 +18,32 @@
>   #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>   #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>   
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static int sym_cap;
>   static int sym_cnt;
>   
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;
> +
> +	if (sym_cnt + 1 > sym_cap) {
> +		new_cap = sym_cap * 4 / 3;
> +		tmp = realloc(syms, sizeof(struct ksym) * new_cap);
> +		if (!tmp)
> +			return -ENOMEM;
> +		syms = tmp;
> +		sym_cap = new_cap;
> +	}
> +
> +	syms[sym_cnt].addr = addr;
> +	syms[sym_cnt].name = strdup(name);

Fwiw, strdup() should error check too.. and for teardown in the test suite, lets
also have the counterpart where we release all the allocated mem.

> +	sym_cnt++;
> +
> +	return 0;
> +}
> +
>   static int ksym_cmp(const void *p1, const void *p2)
>   {
>   	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
> @@ -33,9 +55,13 @@ int load_kallsyms_refresh(void)
>   	char func[256], buf[256];
>   	char symbol;
>   	void *addr;
> -	int i = 0;
> +	int ret;
>   
> +	sym_cap = 1024;

On my dev node, I have:

   # cat /proc/kallsyms | wc -l
   242586

Why starting out so low with 1k? I would have expected that for most cases we
don't need the realloc() path to begin with, but just in corner cases like in
e76a014334a6.

>   	sym_cnt = 0;
> +	syms = malloc(sizeof(struct ksym) * sym_cap);
> +	if (!syms)
> +		return -ENOMEM;
>   
>   	f = fopen("/proc/kallsyms", "r");
>   	if (!f)
> @@ -46,15 +72,11 @@ int load_kallsyms_refresh(void)
>   			break;
>   		if (!addr)
>   			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
> -
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ret = ksyms__add_symbol(func, (unsigned long)addr);
> +		if (ret)
> +			return ret;
>   	}
>   	fclose(f);
> -	sym_cnt = i;
>   	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
>   	return 0;
>   }
> 


