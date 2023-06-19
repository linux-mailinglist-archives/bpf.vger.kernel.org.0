Return-Path: <bpf+bounces-2874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA7735E92
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EB9280FD1
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D035BA38;
	Mon, 19 Jun 2023 20:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629FEA8
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 20:35:48 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC219FE;
	Mon, 19 Jun 2023 13:35:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso13900295ad.0;
        Mon, 19 Jun 2023 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206947; x=1689798947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QafMc4pow8R17hdLiBCTnNWnxpxVCHzrAwUWcP3vikA=;
        b=TmF+eRz/UusYNKpfkw2yQWJWjoB2J1kCDjstljPGTMQJSlBzUj1uRIPbBjz+26oyVu
         RhsNbQIxafnnKBXA0ZrP14oUILHMloO/hDbSL9iqQL2NwayHF4F/bjVpn/oy3fAelxnY
         c+7p9JXRNob/2qE/nCTnUcMTLJjnmpSo42ayuHDH93cDoMvyXau1tm0ldGiIwKQTIRnB
         4z4c9LNd0GMHhjiCmbeouKnv7nV+yYeVzRVU/PLmXh3W+ORGxNPk6JMjs5nt+26DvNe7
         KVWI1O8zWscCTl80VfHFNAqlBUriXBdvgBsNNLJYaRBAkJ4ktid59ExyRvhvWPPWXdt7
         6KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206947; x=1689798947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QafMc4pow8R17hdLiBCTnNWnxpxVCHzrAwUWcP3vikA=;
        b=hcWptlyjALhAM3DVTQQrKu7mEnoMv5H2+/yGoZRTOx+MinicP+xNA27w0ll78rsKqo
         CPx3XskebFwWcbiraCFaQuyLNbXF62x1FhPteXogc/oZpAMPsgUsW00a09gO9hANZ4NT
         X5J9zR6mKMFsztB/ypLRPAygZv8Pi4Y4YGQCmVHwaxWxbc9bnMyP0KlXzq4Dd+jRy5HE
         ttmPHZYNDQ+hsyrvvijYHrRTX5Lr/WVMhaRB1K8U1wrtSYeWrGY1ntfoWRxlqEkrPiNZ
         bJkarvrK7I1TGLhDmPG34MZ0DT70Ne4i2RmhxhxIuUprs/QW/GueFpvTFbDq7Uym8k3v
         WhOw==
X-Gm-Message-State: AC+VfDw9qypOeNf1rrY9wjTblgLIQ4m5TxiQRQp3Isg428OeHbQJw8Sq
	eLH6VABAX88DJ43XAcar4Io=
X-Google-Smtp-Source: ACHHUZ570GonVEYF+R0xBoGeCChHDsYx36elEtqOr0VWGbwSccEVjCzuyfmr/IVYNK67ifv+Jq2dfA==
X-Received: by 2002:a17:903:445:b0:1ae:55c8:6b60 with SMTP id iw5-20020a170903044500b001ae55c86b60mr8223454plb.1.1687206947059;
        Mon, 19 Jun 2023 13:35:47 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001aae625e422sm249630plg.37.2023.06.19.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:35:46 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:35:43 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add benchmark for bpf
 memory allocator
Message-ID: <20230619203543.sb3pqx62uxqnucuo@MacBook-Pro-8.local>
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
 <20230613080921.1623219-6-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613080921.1623219-6-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 04:09:21PM +0800, Hou Tao wrote:
> +
> +static void htab_mem_notify_wait_producer(pthread_barrier_t *notify)

notify_wait and wait_notify names are confusing.
The first one is doing map_update and 2nd is map_delete, right?
Just call them such?

> +{
> +	while (true) {
> +		(void)syscall(__NR_getpgid);
> +		/* Notify for start */

the comment is confusing too.
Maybe /* Notify map_deleter that map_updates are done */ ?

> +		pthread_barrier_wait(notify);
> +		/* Wait for completion */

and /* Wait for deletions to complete */ ?

> +		pthread_barrier_wait(notify);
> +	}
> +}
> +
> +static void htab_mem_wait_notify_producer(pthread_barrier_t *notify)
> +{
> +	while (true) {
> +		/* Wait for start */
> +		pthread_barrier_wait(notify);
> +		(void)syscall(__NR_getpgid);
> +		/* Notify for completion */

similar.

> +		pthread_barrier_wait(notify);
> +	}
> +}


> +static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
> +{
> +	if (ctx->from >= MAX_ENTRIES)
> +		return 1;

It can never be hit, right?
Remove it then?

> +
> +	bpf_map_update_elem(&htab, &ctx->from, zeroed_value, flags);

please add error check.
I think update/delete notification is correct, but it could be silently broken.
update(BPF_NOEXIST) could be returning error in one thread and
map_delete_elem could be failing too...

> +	ctx->from += ctx->step;
> +
> +	return 0;
> +}
> +
> +static int overwrite_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	return write_htab(i, ctx, 0);
> +}
> +
> +static int newwrite_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	return write_htab(i, ctx, BPF_NOEXIST);
> +}
> +
> +static int del_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	if (ctx->from >= MAX_ENTRIES)
> +		return 1;

delete?

> +
> +	bpf_map_delete_elem(&htab, &ctx->from);

and here.

> +	ctx->from += ctx->step;
> +
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int overwrite(void *ctx)
> +{
> +	struct update_ctx update;
> +
> +	update.from = bpf_get_smp_processor_id();
> +	update.step = nr_thread;
> +	bpf_loop(64, overwrite_htab, &update, 0);
> +	__sync_fetch_and_add(&op_cnt, 1);
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int batch_add_batch_del(void *ctx)
> +{
> +	struct update_ctx update;
> +
> +	update.from = bpf_get_smp_processor_id();
> +	update.step = nr_thread;
> +	bpf_loop(64, overwrite_htab, &update, 0);
> +
> +	update.from = bpf_get_smp_processor_id();
> +	bpf_loop(64, del_htab, &update, 0);
> +
> +	__sync_fetch_and_add(&op_cnt, 2);
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int add_del_on_diff_cpu(void *ctx)
> +{
> +	struct update_ctx update;
> +	unsigned int from;
> +
> +	from = bpf_get_smp_processor_id();
> +	update.from = from / 2;

why extra 'from' variable? Just combine above two lines.

> +	update.step = nr_thread / 2;
> +
> +	if (from & 1)
> +		bpf_loop(64, newwrite_htab, &update, 0);
> +	else
> +		bpf_loop(64, del_htab, &update, 0);

I think it's cleaner to split this into two bpf programs.
Do update(NOEXIST) in one triggered by sys_enter_getpgid
and do delete_elem() in another triggered by a different syscall.

> +
> +	__sync_fetch_and_add(&op_cnt, 1);
> +	return 0;
> +}
> -- 
> 2.29.2
> 

