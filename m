Return-Path: <bpf+bounces-7087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805927711F5
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AADD281F3A
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5EC8DB;
	Sat,  5 Aug 2023 19:58:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC32CA6
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 19:58:57 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F74FA
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 12:58:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so688641666b.0
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691265534; x=1691870334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg4vW9SrnygWrtGnV0wP3GYXsTK4dPBgt/fsrSHkJbk=;
        b=JYmPLhTna0IobGh6tq2Bz4OmRmGRYbpAm4Z/l/bEjXqKGjN9M39cAge2I2/CzuIuEW
         6SFmu41LkmflR2gfcGLbBln0c2jTVWrNSkk8BdXBRnYc7Ma/HEvY+b90wL+sdQvXTjGW
         3+mpbstgKVTViaRs3j7RiSLVrK2VcJcXbhqIm8roMzd1ARMedpPPhGwH//iLMO+Tj18g
         Xtir9Q4YUdMEzbkaOeRcRzQbRztFk7neYD7+3r1nq9FeMv79fjgIwn6At5DFUEX0vcJ9
         L6HSUgxaJfHnsEl/Q7E4BJ0HEDLV1CdqqkD6ZHafJt4CXV505PG+QXYrP6Yg7U4+jNyx
         BtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691265534; x=1691870334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg4vW9SrnygWrtGnV0wP3GYXsTK4dPBgt/fsrSHkJbk=;
        b=X5YGowqC+DfZ6b77ujuh4FrwDRLaw2944L6G4J7qM2JeTs1f9BXCxzmGK6zorQWqdO
         ufVeWTXdwceN44GctW2iXb/Tsi9iff+ZJSZVEhri/fzhmfB1v51H2MRmsy9QXeTG8ZaE
         PXa5uCi+EbobnZiu9kqdhP0bM96HUMaROu97d8966Gi6Hj3vk7qiNRDd6uFOlMCjzR5U
         lWNDAawBE4Z59Rgva8lyBPMR07pObblgcMswkh025bSM1Z49dl5ITPRgHL7oqdxi3C2d
         6cdEM4WkR/NdbFuKz3RKNLPOnIaVbcyN/qHcmJjH89uyBEEgT0XqwuxQ+5OCiIyEGmdI
         OVrA==
X-Gm-Message-State: AOJu0YyDkKI6+crtVA3bg9qSOmptYefKaVYrkYQT5rHSwAKZUr0jjAol
	zrjA/fAWoKo2QLMAVRtPPd0=
X-Google-Smtp-Source: AGHT+IHYmixDLshC7UWKOsAHs4laHspVtTEEQZeR4JoctAaO4Uihotq6P6uZkTaeV3dOPrEVMtUJdA==
X-Received: by 2002:a17:906:53ce:b0:99c:7300:94b8 with SMTP id p14-20020a17090653ce00b0099c730094b8mr3242386ejo.10.1691265534018;
        Sat, 05 Aug 2023 12:58:54 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709066b0800b0098921e1b064sm3027493ejr.181.2023.08.05.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 12:58:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 5 Aug 2023 21:58:51 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add selftest for
 fill_link_info
Message-ID: <ZM6p+++fSnKrEYM5@krava>
References: <20230804105732.3768-1-laoar.shao@gmail.com>
 <20230804105732.3768-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804105732.3768-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 10:57:32AM +0000, Yafang Shao wrote:

SNIP

> +
> +static void kprobe_fill_invalid_user_buffer(int fd)
> +{
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	int err;
> +
> +	memset(&info, 0, sizeof(info));
> +
> +	info.perf_event.kprobe.func_name = 0x1; /* invalid address */
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "invalid_buff_and_len");
> +
> +	info.perf_event.kprobe.name_len = 64;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "invalid_buff");
> +
> +	info.perf_event.kprobe.func_name = 0;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "invalid_len");
> +
> +	ASSERT_EQ(info.perf_event.kprobe.addr, 0, "func_addr");
> +	ASSERT_EQ(info.perf_event.kprobe.offset, 0, "func_offset");
> +	ASSERT_EQ(info.perf_event.type, 0, "type");
> +}
> +
> +static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
> +				       enum bpf_perf_event_type type,
> +				       bool retprobe, bool invalid)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
> +		.attach_mode = PROBE_ATTACH_MODE_LINK,
> +		.retprobe = retprobe,

you could got rid of the retprobe argument and just do

		.retprobe = retprobe == BPF_PERF_EVENT_KRETPROBE,


> +	);
> +	ssize_t offset = 0, entry_offset = 0;
> +	int link_fd, err;
> +	long addr;
> +
> +	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
> +								 KPROBE_FUNC, &opts);
> +	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.kprobe_run);
> +	addr = ksym_get_addr(KPROBE_FUNC);
> +	if (!invalid) {
> +		/* See also arch_adjust_kprobe_addr(). */
> +		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> +			entry_offset = 4;
> +		err = verify_perf_link_info(link_fd, type, addr, offset, entry_offset);
> +		ASSERT_OK(err, "verify_perf_link_info");
> +	} else {
> +		kprobe_fill_invalid_user_buffer(link_fd);
> +	}
> +	bpf_link__detach(skel->links.kprobe_run);
> +}
> +
> +static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> +{
> +	int link_fd, err;
> +
> +	skel->links.tp_run = bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CAT, TP_NAME);
> +	if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.tp_run);
> +	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
> +	ASSERT_OK(err, "verify_perf_link_info");
> +	bpf_link__detach(skel->links.tp_run);
> +}
> +
> +static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> +				       enum bpf_perf_event_type type, ssize_t offset,
> +				       bool retprobe)
> +{
> +	int link_fd, err;
> +
> +	skel->links.uprobe_run = bpf_program__attach_uprobe(skel->progs.uprobe_run, retprobe,
> +							    0, /* self pid */
> +							    UPROBE_FILE, offset);

same here with 'type == BPF_PERF_EVENT_URETPROBE'


> +	if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.uprobe_run);
> +	err = verify_perf_link_info(link_fd, type, 0, offset, 0);
> +	ASSERT_OK(err, "verify_perf_link_info");
> +	bpf_link__detach(skel->links.uprobe_run);
> +}
> +

SNIP

> +
> +static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> +					     bool retprobe, bool buffer)
> +{
> +	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +	const char *syms[KMULTI_CNT] = {
> +		"schedule_timeout_interruptible",
> +		"schedule_timeout_uninterruptible",
> +		"schedule_timeout_idle",
> +		"schedule_timeout_killable",

nit, might be better to use some of the bpf_fentry_test[1-9] functions,
also for KPROBE_FUNC

> +	};
> +	__u64 addrs[KMULTI_CNT];
> +	int link_fd, i, err = 0;
> +
> +	qsort(syms, KMULTI_CNT, sizeof(syms[0]), symbols_cmp_r);
> +	opts.syms = syms;
> +	opts.cnt = KMULTI_CNT;
> +	opts.retprobe = retprobe;
> +	skel->links.kmulti_run = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run,
> +								       NULL, &opts);
> +	if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.kmulti_run);
> +	for (i = 0; i < KMULTI_CNT; i++)
> +		addrs[i] = ksym_get_addr(syms[i]);
> +
> +	if (!buffer)
> +		err = verify_kmulti_link_info(link_fd, addrs, retprobe);
> +	else
> +		verify_kmulti_user_buffer(link_fd, addrs);

verify_kmulti_user_buffer is actually what you call 'invalid' in other
tests right? seems better to keep it in here unless I miss something

thanks,
jirka

> +	ASSERT_OK(err, "verify_kmulti_link_info");
> +	bpf_link__detach(skel->links.kmulti_run);
> +}
> +

SNIP

