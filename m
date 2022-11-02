Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6459361624A
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKBL5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKBL46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:56:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EF205DE
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:56:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t4so10507760wmj.5
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e9t+blyZILLQE6+pdIsU2hY3jSYuQx5qRFvKHlvSLE=;
        b=qxJ9L9frQZsd+GiyQsLz4nLJjiTxQCyCQ4aU6KrpcMdz2BX4mmDrU7AnKEytp4Mmt/
         FcbBjhuTbYqi8/gAWzie7RLuC9+ebGSF1sjLKek+3T9FRBRcPQqBGKOT9yHxsCrCwtxj
         ngvrlZ0aXiC3CX6LDo5uOQnCJKALdFyHKXHRv4ScR7nI86UtCy/AbHDlKGfAzS9sOTAp
         Zqjtiw61z/Hh0QJ7KQh9LvytNl54wcMPrAR34V3M69AgeEE3umxtyGqk44TdVFrk9XLd
         AdjTsAP4m2IT0TfRHb/ziMm94np4auh7McAznjbfU8gEanwhTuIr69uV5AG5/xC2vhTK
         mtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e9t+blyZILLQE6+pdIsU2hY3jSYuQx5qRFvKHlvSLE=;
        b=PzFEP/5b3zIFlYuY978dEByfk0YnW/SnvcRSBJ95aXmeRUQl21CVAQ8aaMOGNP2Uoz
         9XRY8Aie6j8l1povhxWsEpASfnSzOBvsPp+pPP/C6NwUTRaSvbUUoI6LI1qJrVteidiv
         diB2n9FCVc5qc2E9siYom1x6/77xGQIpb09dmut5wtTVCbt+Vdu/93yR2OpG5SBL7BHe
         1z9iKptB4yG65gTDayjszx53CqyTd1Ka5Fp+bt6eCGh+CjoA4ZnDYsURDGyoYJcuhAgW
         0a+SfRNPDOsjk3ACgiwbcXTBubFre9vUfC4klyMGIxVt/Po5m84qq3g6cOp7DRbRg+yi
         ca5w==
X-Gm-Message-State: ACrzQf0d2B4MNruzlOGVaB5jb4Ovi1BH4BPTHREkCFb0C6HoAFn1zefD
        JVAVf5BShhzj7igxNdMvGp4lew==
X-Google-Smtp-Source: AMsMyM7SxlNvhz8doHhCL3CXM9xeACf776xPP8VH08abG36RMKjRN/S8EL6Etwoz7L9l5PvypYpL/w==
X-Received: by 2002:a05:600c:4ecf:b0:3cf:8762:1a67 with SMTP id g15-20020a05600c4ecf00b003cf87621a67mr1700311wmq.41.1667390216130;
        Wed, 02 Nov 2022 04:56:56 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id ck7-20020a5d5e87000000b00235da296623sm13002090wrb.31.2022.11.02.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 04:56:55 -0700 (PDT)
Message-ID: <6927ffa1-e7f5-6691-dc86-da6c0d628c4f@isovalent.com>
Date:   Wed, 2 Nov 2022 11:56:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RESEND PATCH] bpftool: Support use full prog name in prog
 subcommand
Content-Language: en-GB
To:     Tao Chen <chentao.kernel@linux.alibaba.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-11-02 10:35 UTC+0800 ~ Tao Chen <chentao.kernel@linux.alibaba.com>
> Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
> program names") supported show the full prog name, we can also use
> the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
> subcommand, such as "bpftool prog show name PROG_NAME".
> 
> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>

Thanks! But you mean you want something like this, correct?

	# ./bpftool prog pin \
		name prog_with_a_very_long_name /sys/fs/bpf/foo

This is already possible since commit d55dfe587bc0 ("bpftool: Remove
BPF_OBJ_NAME_LEN restriction when looking up bpf program by name"). Your
first version of the patch was based on a version that didn't have this
commit, but bpftool from bpf-next already supports this.

Quentin
