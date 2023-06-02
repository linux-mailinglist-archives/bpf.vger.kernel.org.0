Return-Path: <bpf+bounces-1744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D1720A62
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C0281B0E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF685257;
	Fri,  2 Jun 2023 20:37:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA73FFB
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:37:04 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2131BE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:37:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d44b198baso1984066b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738223; x=1688330223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kQv4zVokLyMJTHfdMLxe3p8+k8inH7u1gaevaeok/4=;
        b=iEd4GBV158Q8sfOUVOdzH2rj0CqD8LjDdVOwd0FnWvuXBUzrNBv1V8THgJwYh+5ame
         I4ghHyZUbYcbTtdjArc4zrUrhWVYs6wF2EXBY/e7wki/1eSGP5JA18wM4M9RxIReeCRT
         04WWX9ljo+rg2SIEABTd0q7CU1HsKbjTMO1yocYwkaQORANdURK/MvDGSpQgziiydFKA
         HXsvewBiOWku6e5VzKQB2NFX/Ks2bXr+zpW//r3O39/QAhGmujzwMqFiXPEZT/Gpg0/p
         hLlmEaneUgDZ8TaeY/T6b/4pnHmNF9b+BtLsGXwBGFeJcnyt9pKG7IBRxwyfFs2lpXXF
         TAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738223; x=1688330223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kQv4zVokLyMJTHfdMLxe3p8+k8inH7u1gaevaeok/4=;
        b=EooOr7EHBwzCzLzE/kSq4Xva+bQkTVfboCE+mTu6zi47y7+FfGBUzTl7VaOUsHdpXm
         T+PdUPleryipJ+X4SQukyVlGpcx5LpHF+D0w9BpreuCZJaZikl6XOR1Us+EsxG2EYymf
         ak4KPvZGL71d56bnaQ0YKBkTjeJiRUOy9ORNnOCsIS3nMOCmyLKRLIHE+TQJNV0gUTqS
         J7dRaRTUkFY+QewQ9PL4SZMsrlPcZoaLxHC1csyVhEXQe/J5sxW/0BFm/j7nr2NmA86S
         v0bsF771+y5+A5WY5RNnBadO7f+6pNJKNejXG6u99P6g1OgZaalKfzyn2kzLXk835eRR
         8Tzw==
X-Gm-Message-State: AC+VfDxAZx7uB+rki4QMXN5KaxzNnyyP85mVyb1EzFeEiGHz3aAD7mXl
	NHPoOOtprwDwy0NFH9KiQzs=
X-Google-Smtp-Source: ACHHUZ5oXltY3Xxwg8MFm+wdKX6RyE5sLV/2caczvbDjIMIy6sAFq4VARMi8TXlUISTety4Vy9BSEQ==
X-Received: by 2002:a05:6a20:3ca2:b0:101:1e75:78e with SMTP id b34-20020a056a203ca200b001011e75078emr6542019pzj.14.1685738222888;
        Fri, 02 Jun 2023 13:37:02 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:bddd])
        by smtp.gmail.com with ESMTPSA id bv131-20020a632e89000000b0050927cb606asm1628662pgb.13.2023.06.02.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 13:37:02 -0700 (PDT)
Date: Fri, 2 Jun 2023 13:36:59 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpftool: Show probed function in
 kprobe_multi link info
Message-ID: <20230602203659.fzmvfjysdqdf7guq@MacBook-Pro-8.local>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
 <20230602085239.91138-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602085239.91138-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 08:52:35AM +0000, Yafang Shao wrote:
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
> $ tools/bpf/bpftool/bpftool link show
> 1: kprobe_multi  prog 5
>         func_cnt 4  addrs            symbols
>                     ffffffffb4d465b0 schedule_timeout_interruptible
>                     ffffffffb4d465f0 schedule_timeout_killable
>                     ffffffffb4d46630 schedule_timeout_uninterruptible
>                     ffffffffb4d46670 schedule_timeout_idle
>         pids trace(8729)
> 
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":1,"type":"kprobe_multi","prog_id":5,"func_cnt":4,"addrs":[{"addr":18446744072448402864,"symbol":"schedule_timeout_interruptible"},{"addr":18446744072448402928,"symbol":"schedule_timeout_killable"},{"addr":18446744072448402992,"symbol":"schedule_timeout_uninterruptible"},{"addr":18446744072448403056,"symbol":"schedule_timeout_idle"}],"pids":[{"pid":8729,"comm":"trace"}]}]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..3b00c07 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -166,6 +166,57 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
>  	return err;
>  }
>  
> +static int cmp_u64(const void *A, const void *B)
> +{
> +	const __u64 *a = A, *b = B;
> +
> +	return *a - *b;
> +}
> +
> +static void kprobe_multi_print_plain(__u64 addr, char *sym, __u32 indent)
> +{
> +	printf("\n\t%*s  %0*llx %s", indent, "", 16, addr, sym);
> +}
> +
> +static void kprobe_multi_print_json(__u64 addr, char *sym)
> +{
> +	jsonw_start_object(json_wtr);
> +	jsonw_uint_field(json_wtr, "addr", addr);
> +	jsonw_string_field(json_wtr, "symbol", sym);
> +	jsonw_end_object(json_wtr);
> +}
> +
> +static void kernel_syms_show(const __u64 *addrs, __u32 cnt, __u32 indent)
> +{
> +	char buff[256], sym[256];
> +	__u64 addr;
> +	int i = 0;
> +	FILE *fp;
> +
> +	fp = fopen("/proc/kallsyms", "r");
> +	if (!fp)
> +		return;
> +
> +	/* Each address is guaranteed to be unique. */
> +	qsort((void *)addrs, cnt, sizeof(__u64), cmp_u64);
> +	/* The addresses in /proc/kallsyms are already sorted. */
> +	while (fgets(buff, sizeof(buff), fp)) {
> +		if (sscanf(buff, "%llx %*c %s", &addr, sym) != 2)
> +			continue;
> +		/* The addr probed by kprobe_multi is always in
> +		 * /proc/kallsyms, so we can ignore some edge cases.
> +		 */
> +		if (addr != addrs[i])
> +			continue;
> +		if (indent)
> +			kprobe_multi_print_plain(addr, sym, indent);
> +		else
> +			kprobe_multi_print_json(addr, sym);
> +		i++;
> +	}
> +	fclose(fp);

There is kernel_syms_load().
Let's reuse it instead of reimplementing kallsysm parsing?

