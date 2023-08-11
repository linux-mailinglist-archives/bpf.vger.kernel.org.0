Return-Path: <bpf+bounces-7594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23E7795C0
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CEF1C2180A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27473219CA;
	Fri, 11 Aug 2023 17:08:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5F219C2
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:08:03 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE8E54
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:08:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586b0ef17daso62610427b3.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773682; x=1692378482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayz3zWc5n3NudgvHTBCmK21hNqKenj4cKODpSVkSh7g=;
        b=5wQtFFTKe7JU84UnUAeBPgLTdVs+EP8+6Do7b6+vVW9RuOTz9jwCgCWfe565qsLApw
         bfMG9/8zSqb5S5Qshu/bhlurAnhIS15yOErL5ifV5nrGBPJKyD4CoiZ28xyzQtluxXta
         Wv53XGNFIaJi+vkf4P3sy/JLKA/NfL+GeZlg6z6NlG9v4a4Q3maZRuuPnZuyeYNDv7CH
         MXb7RrCrhaEqhWcFIrE3ZjcBfdr12ZM9J3aObGNFDeVousviT7uBHMojSywWR3C11TMJ
         rId6X4H+ibZc4m6Y9YVrApUJfYluBz2HiA5OxlHtEkoPrsQG4CtE2+5f+bv6AymtLVKJ
         mfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773682; x=1692378482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayz3zWc5n3NudgvHTBCmK21hNqKenj4cKODpSVkSh7g=;
        b=kFoKQfNYQvlYky8kH5Y0wIxM67VoPbQFNEPcNflL+T8Kc2urb57llkG5CG4VNmBxdL
         2+3PAIeDXoSD7MHNIPdR7j2dt4OvA2C99z6/DffGLUDiYWB29yOspXF9Ls0AiDT9jkhZ
         baanurd0vLQXtht601sRrDe70FcmJufwb2S22MgWZel9kRl3MzHj2AvMhG4Db9ZkC3rn
         X43IbHxAfH6DPvwKDge/zodMoToWIJKtppcPeTp7dNRPw8os5XS6x+27teMGppgroF2F
         m/4Y+f4i3WxCmwto3eeWiKY+vd852Vs5ZZQzZ2spJQaICHVXf17YR5sr9Z/35jeTiU1P
         7iiw==
X-Gm-Message-State: AOJu0YzOPFe+/N37Z/qWd5DbFIq31KQMeoiPwiTqGRQRXwN2KOcYPHOT
	cCaUQTUQbSwDvx1L6p4+aav+6z4=
X-Google-Smtp-Source: AGHT+IF253YnhQbVEgKkS2r0RUIcWNjp4R4hKGjDuiQ7+PhQKLu1ym8TIYnfVPFUKmv1uY2Nh0/7NUw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:72c:b0:589:a3d6:2e02 with SMTP id
 bt12-20020a05690c072c00b00589a3d62e02mr58827ywb.3.1691773681829; Fri, 11 Aug
 2023 10:08:01 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:07:59 -0700
In-Reply-To: <tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com>
Message-ID: <ZNZq76jCnzNy7QVF@google.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From: Stanislav Fomichev <sdf@google.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [SELFTESTS] (Test Runners & Infrastructure)" <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Rong Tao wrote:
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
> v2: Do the usual len/capacity scheme here to amortize the cost of realloc, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 73 ++++++++++++++-------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..cda5a2328450 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,9 +18,37 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> -static int sym_cnt;
> +static struct {
> +	struct ksym *syms;
> +	unsigned int sym_cap;
> +	unsigned int sym_cnt;
> +} ksyms = {
> +	.syms = NULL,
> +	.sym_cap = 1024,
> +	.sym_cnt = 0,
> +};

Not sure what the struct buys you here (besides grouping everything
nicely), maybe do the following?
static struct ksym *syms;
static int sym_cnt;
static int sym_cap = 1024;

Will reduce the churn elsewhere..

> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;
> +
> +	if (ksyms.sym_cnt + 1 > ksyms.sym_cap) {
> +		new_cap = ksyms.sym_cap * 4 / 3;
> +		tmp = realloc(ksyms.syms, sizeof(struct ksym) * new_cap);
> +		if (!tmp)
> +			return -ENOMEM;
> +		ksyms.syms = tmp;
> +		ksyms.sym_cap = new_cap;
> +	}
> +
> +	ksyms.syms[ksyms.sym_cnt].addr = addr;
> +	ksyms.syms[ksyms.sym_cnt].name = strdup(name);
> +
> +	ksyms.sym_cnt++;
> +
> +	return 0;
> +}
>  
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
> @@ -33,9 +61,10 @@ int load_kallsyms_refresh(void)
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
>  
> -	sym_cnt = 0;
> +	ksyms.syms = malloc(sizeof(struct ksym) * ksyms.sym_cap);
> +	if (!ksyms.syms)
> +		return -ENOMEM;
>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> @@ -46,16 +75,10 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
> -
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ksyms__add_symbol(func, (unsigned long)addr);

Need to check the return of ksyms__add_symbol here?

