Return-Path: <bpf+bounces-6077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECA765551
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF611C216CA
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806E174DF;
	Thu, 27 Jul 2023 13:49:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4505171AB
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:49:53 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E9FFD
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:49:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso1695379e87.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690465790; x=1691070590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBw31Ny2JzZYg8vbuARzgHR3IskCXusfD9RYk9u0un8=;
        b=PcEeuxQqatQh+Agg0XPCFG9Qdh3MqJOpbfg82lFeJt8nQ8SjkDrg2szcw1Kod/82h+
         ejlu725ZixoIUevB7aqJuD4fvlbCt4DrBMpo4IuREMkh7BAHr1nPzofYGyloeL8Tumn/
         9L8uAMUbThw71yIcRx7LOP0x528o9qGuYwOdvfFj6kzvpEDw69Hv1RFCOaH/81D3Rlc5
         QT9wxMxc+KSsY6NUWZ4vuF0DC6dIDshooiQtQ3AgXU+Yp2iHOm/4H2gUQOGD03FTQMRp
         MTXyAb1rRbCMCc63T+/FTwGKfz/HGraxSOecn8mUSsKEH/KduSKDH7vyjpFsVMhzDoDB
         MfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690465790; x=1691070590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBw31Ny2JzZYg8vbuARzgHR3IskCXusfD9RYk9u0un8=;
        b=a1vRryOs75U3hscyBqp/Jc4ERgrNNH5C9lsyAZ49PrIQ653BhVTh3tvg0mSpminmrW
         r5uKIsbm7IADwoLO/g8KNnByM3ukytE3EDob/NTo/W7Djtc9b32mwmfwGDMw4QFw9wrg
         iP1l2xF80cxX6vKxTA7DZ+ltZ1kKjtEBaMOXXaLxHojFfnheKmx4pQmaPhkpurXTQV1s
         8FHdG87kZfp+3bxrDim5XmltRlFdZ+m0IJUkQNpIMSoWq6o0yfoCuwzHh0wFveNWolNe
         kQZBXQe6ROBwhqrs/hf643qPYm8/cFIm3Zb+sz0We6FIH32H+SuULEZ2zE8zurVXtYdA
         FA2w==
X-Gm-Message-State: ABy/qLaSh9khimDk8EscAiRrEAKAUE66+yqXMNwKHG4KhxRSCX8Z9y5j
	mQEyBvr76rlaPeg1d3bWhQHLmZBbrao=
X-Google-Smtp-Source: APBJJlHb+3/V2ay5Q7WOoSsoRS2GQTfB3cBJo9aa//F9zKI7peiYVVDPvGVTqRrliMkpMykaQIIWVg==
X-Received: by 2002:a19:5503:0:b0:4fd:bd8e:8fab with SMTP id n3-20020a195503000000b004fdbd8e8fabmr1851716lfe.7.1690465789925;
        Thu, 27 Jul 2023 06:49:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k10-20020adff28a000000b00311299df211sm2129576wro.77.2023.07.27.06.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:49:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 27 Jul 2023 15:49:47 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftest for
 fill_link_info
Message-ID: <ZMJ1+22ByZfWrL8I@krava>
References: <20230727114309.3739-1-laoar.shao@gmail.com>
 <20230727114309.3739-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727114309.3739-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 11:43:09AM +0000, Yafang Shao wrote:

SNIP

> +static int verify_link_info(int fd, enum bpf_perf_event_type type, long addr, ssize_t offset)
> +{
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	char buf[PATH_MAX];
> +	int err = 0;
> +
> +	memset(&info, 0, sizeof(info));
> +	buf[0] = '\0';
> +
> +again:
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	if (!ASSERT_OK(err, "get_link_info"))
> +		return -1;
> +
> +	switch (info.type) {
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_match"))
> +			return -1;
> +
> +		switch (info.perf_event.type) {
> +		case BPF_PERF_EVENT_KPROBE:
> +		case BPF_PERF_EVENT_KRETPROBE:
> +			ASSERT_EQ(info.perf_event.kprobe.offset, offset, "kprobe_offset");
> +
> +			/* In case kptr setting is not permitted or MAX_SYMS is reached */
> +			if (addr) {
> +				long addrs[2] = {
> +					addr + offset,
> +					addr + 0x4, /* For ENDBDR */
> +				};
> +
> +				ASSERT_IN_ARRAY(info.perf_event.kprobe.addr, addrs, "kprobe_addr");

we have check for IBT in get_func_ip_test, it might be easier
to use the same in here as well and do the exact check

we wouldn't need the ASSERT_IN_ARRAY then and would be correct
wrt other archs


SNIP

> +static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> +				       enum bpf_perf_event_type type, ssize_t offset,
> +				       bool retprobe)
> +{
> +	int link_fd, err;
> +
> +	skel->links.uprobe_run = bpf_program__attach_uprobe(skel->progs.uprobe_run, retprobe,
> +							    0, /* self pid */
> +							    UPROBE_FILE, offset);
> +	if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> +		return;
> +
> +	link_fd = bpf_link__fd(skel->links.uprobe_run);
> +	if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +		return;
> +
> +	err = verify_link_info(link_fd, type, 0, offset);
> +	ASSERT_OK(err, "verify_link_info");
> +	bpf_link__detach(skel->links.uprobe_run);
> +}
> +
> +void serial_test_fill_link_info(void)

why does it need to be serial?

> +{
> +	struct test_fill_link_info *skel;
> +	ssize_t offset;
> +
> +	skel = test_fill_link_info__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	/* load kallsyms to compare the addr */
> +	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +		return;
> +	if (test__start_subtest("kprobe_link_info"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, false);
> +	if (test__start_subtest("kretprobe_link_info"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE, true, false);
> +	if (test__start_subtest("fill_invalid_user_buff"))
> +		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, true);
> +	if (test__start_subtest("tracepoint_link_info"))
> +		test_tp_fill_link_info(skel);
> +
> +	offset = get_uprobe_offset(&uprobe_func);
> +	if (test__start_subtest("uprobe_link_info"))
> +		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE, offset, false);
> +	if (test__start_subtest("uretprobe_link_info"))
> +		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE, offset, true);

do you plan to add kprobe_multi link test as well?

thanks,
jirka


> +
> +cleanup:
> +	test_fill_link_info__destroy(skel);
> +}

SNIP

