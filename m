Return-Path: <bpf+bounces-5082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53A755F0B
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 11:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16171C20AB9
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A183A921;
	Mon, 17 Jul 2023 09:14:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64593846E
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:14:35 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB64BF
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 02:14:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso4370128f8f.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689585272; x=1692177272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TeKpfA00jxkHBGSs8GYNS1KWLPZEgkT3+/8Whuc1Bg=;
        b=stYMQAEprFNp/aDdCgdBdgS3fIoPWuFgk5MaOzCgwSCyWEN8unJMh49q8dTNUP2XdF
         3vNuKK0tWFV1FM+HvHokP3/V/HKMPMKMUcdUpTes3LYUpuf5u87sbjk1gh2MT1yG6WJv
         12rfalKSC4fDYVT5hy7Wl2vigCkh+KGQ1jAyO2F6c/uynJEsJUc1zlZ1w6cUmzxMfhUb
         b5RTe9THRKjKzZJRTUMZ4RigHsMzw9gFNZ7qFR6YlWlA0BoF4fbdQf+QyMn25Ayyn8rp
         6cK/68CuUX01rlB9eBnxRtZBttfNcYzrUt3T+Pv2SDz8P2b5gmqzhZyE3IfdxI/t0SNV
         mOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689585272; x=1692177272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TeKpfA00jxkHBGSs8GYNS1KWLPZEgkT3+/8Whuc1Bg=;
        b=H0R7XHrsRuWYjO7CkbxRkHg/fjy9UjNE+UmYWcTZD+k4m75/nuZFCaWd9ekSnfnTUm
         DTFa4BEJlI+QahRV6A7A7VYO8Ogj5/7kzGdsQ7qRb7gzvG/6PblTO0HGyp82BNpv5ls8
         ehwGCUUtO38FQHhqGCxMhGXNGKTM3lgdWT14xuj2wAc6xPTwmpMb8reKZ8erZdCfseSm
         3iNxh7Wx/ljKvsE8viGja3Ab1vryjnLECK8WgCWhDtinxVy359oN2Nzs8Upy6JPDnwB0
         b/BYqLzyNCqGMRJH8NIfzt6suAzltErGl+Is2mZUwLv1voS1Xsn6cieg/O5eUp7yBil2
         h5LQ==
X-Gm-Message-State: ABy/qLYRMHYCMko3qWYR0X2L3Ts6m3nSPNh06JB39MIBFQ8Frrwe/DAF
	OeDT8Cg0zj/fjveI7UYcF0PeETS8hN1CMETqtec=
X-Google-Smtp-Source: APBJJlGA7XJCKmPt+sZFtcy1F2h2ss4Wn1NXoIAakomBl93U532alANd97odaeKuoW0+1gcX62sXDQ==
X-Received: by 2002:a5d:4acc:0:b0:315:99be:6fe4 with SMTP id y12-20020a5d4acc000000b0031599be6fe4mr11483312wrs.69.1689585271987;
        Mon, 17 Jul 2023 02:14:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d55d1000000b00313f07ccca4sm18623004wrw.117.2023.07.17.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:14:29 -0700 (PDT)
Date: Mon, 17 Jul 2023 12:14:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: laoar.shao@gmail.com
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Support ->fill_link_info for perf_event
Message-ID: <85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Yafang Shao,

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

	kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
	error: uninitialized symbol 'type'.

kernel/bpf/syscall.c
    3402 static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
    3403                                      struct bpf_link_info *info)
    3404 {
    3405         char __user *uname;
    3406         u64 addr, offset;
    3407         u32 ulen, type;
    3408         int err;
    3409 
    3410         uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
    3411         ulen = info->perf_event.kprobe.name_len;
    3412         err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
    3413                                         &type);
    3414         if (err)
    3415                 return err;
--> 3416         if (type == BPF_FD_TYPE_KRETPROBE)

It looks like you could call bpf_get_perf_event_info() without it
initializing *fd_type to anything.  Meanwhile if you initialize it to
zero here, that won't even affect the compiled code at all because
everyone zeroes stack data these days.

    3417                 info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
    3418         else
    3419                 info->perf_event.type = BPF_PERF_EVENT_KPROBE;
    3420 
    3421         info->perf_event.kprobe.offset = offset;
    3422         if (!kallsyms_show_value(current_cred()))
    3423                 addr = 0;
    3424         info->perf_event.kprobe.addr = addr;
    3425         return 0;
    3426 }

regards,
dan carpenter

