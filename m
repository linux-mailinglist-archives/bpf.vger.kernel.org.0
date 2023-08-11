Return-Path: <bpf+bounces-7604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F977982B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C29B1C2178E
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF212AB5C;
	Fri, 11 Aug 2023 20:07:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7A8468
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:07:24 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1D30F8
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:07:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99d6d5054bcso389547866b.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691784441; x=1692389241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5bVPexHHjNHhXkTKv/bwA8jIfx9jWk4EMMUpVoveDM=;
        b=aavooXLighW6qc8kBYbxtxfsmmyTe7kcaM0Sfy61Bf7IEekYrlHdRp1/cMHRUW0W7S
         yCVrPYEoQ1MVK5nNbZAiatSIFo8G35WMLGC+8jO1pENI0B0N+xsNtdbEZ7i81G1835TH
         EzZhz2trmlGXyNgy9AULzqvmq1j/NB5tA4W3yW06Dy4W22hbcQt2xYLeE3jfsTZHpC0m
         LOWCTyqEhyV3U6lOQe84DiZDXfiDOsEbf38jYwy4xjk0ubbPmLWGMXR15Zyi1C7Qiqjl
         O+wJMA9qBthRBbdbpuaM8XgPWhIAsxIMWIzkl6RcfBlK7rE95zc1ulBko8uJWRKGYYKH
         EJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691784441; x=1692389241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5bVPexHHjNHhXkTKv/bwA8jIfx9jWk4EMMUpVoveDM=;
        b=jR3FFXRjuocpDBVp46wVwqm8csllFIaQIYnQ9ujyK9Hik7tUT3D4ua4YNhlYraOoDe
         IRuiMB6//hv6vTXddmgUvhLBFmEeTIpszJdALFwHtIfASy5VL4t2VRKAUJKh2C0Eptrn
         7MV80HzkkNkNYJ0L5R7OnGt+T1Pm+eVF/cBfycavLkDmngy90q8n/x/Q9/oQeOu+Qcsj
         iNij6n0DWca4mPmu3XSnme7Pha6dbrKitM2nEZ2A8MQgxgb9r5/XmYgJYOnp7eLlsk31
         2Sb/byNJyeTdjX6XQPUBc1D/MxdcZsLq3JB2BH0BkELGjyfU/aQFwHQ1cxTEzcuoHPNn
         Jcmw==
X-Gm-Message-State: AOJu0YwvMe8nRsEhfCtxxB5A0QE703WYlB17C7R0t2jrPFC4FQ26xgY5
	0R553ShB05Rgon+qSFCrbXI=
X-Google-Smtp-Source: AGHT+IGWQqAnC+vi5JPmL4exiyYqLExoMajHj6cWi/ZVQYr4VeSU9JbU+a2tcFedc9TdAHt4Z3ktAw==
X-Received: by 2002:a17:907:d8f:b0:98e:738c:6d39 with SMTP id go15-20020a1709070d8f00b0098e738c6d39mr6714376ejc.36.1691784441407;
        Fri, 11 Aug 2023 13:07:21 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906039000b00993470682e5sm2615808eja.32.2023.08.11.13.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:07:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Aug 2023 22:07:18 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for
 fill_link_info
Message-ID: <ZNaU9rE6NH9T+O39@krava>
References: <20230811023647.3711-1-laoar.shao@gmail.com>
 <20230811023647.3711-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811023647.3711-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 02:36:47AM +0000, Yafang Shao wrote:

SNIP

> +void test_fill_link_info(void)
> +{
> +	struct test_fill_link_info *skel;
> +	int i;
> +
> +	skel = test_fill_link_info__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	/* load kallsyms to compare the addr */
> +	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +		goto cleanup;
> +
> +	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
> +	if (test__start_subtest("kprobe_link_info"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false);
> +	if (test__start_subtest("kretprobe_link_info"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE, false);
> +	if (test__start_subtest("kprobe_invalid_ubuff"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, true);
> +	if (test__start_subtest("tracepoint_link_info"))
> +		test_tp_fill_link_info(skel);
> +
> +	uprobe_offset = get_uprobe_offset(&uprobe_func);
> +	if (test__start_subtest("uprobe_link_info"))
> +		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE);
> +	if (test__start_subtest("uretprobe_link_info"))
> +		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE);
> +
> +	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);

hum, what's the reason for sorting the symbols?

other than that it looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> +	for (i = 0; i < KMULTI_CNT; i++)
> +		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
> +	if (test__start_subtest("kprobe_multi_link_info"))
> +		test_kprobe_multi_fill_link_info(skel, false, false);
> +	if (test__start_subtest("kretprobe_multi_link_info"))
> +		test_kprobe_multi_fill_link_info(skel, true, false);
> +	if (test__start_subtest("kprobe_multi_invalid_ubuff"))
> +		test_kprobe_multi_fill_link_info(skel, true, true);
> +
> +cleanup:
> +	test_fill_link_info__destroy(skel);
> +}

SNIP

