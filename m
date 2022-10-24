Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0460BD4D
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiJXWWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJXWWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 18:22:04 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32391310139
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 13:39:35 -0700 (PDT)
Message-ID: <d1b0ab2c-db05-d629-4545-a1d9d95955e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666643404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsWI96o4w8c8eUFgtigJ/z1UpFVy3skQcupzwRs6fgU=;
        b=YM749q7JKK6b0APfcTk4m5hBPm6TqTLrhIQSbM3JutdWTsF7af6XPgfHluk/9Pj6exI6yc
        EdP8TZwXc5vSPJURl70ke6OL+DH2A8WQ4g7I+CTZdePc9xYxgDuXEDHfyhyJ/WV0c0s8Yd
        waUs+UlFc/2wEjEBU3vMs6ZCJFEgncA=
Date:   Mon, 24 Oct 2022 13:30:01 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Add selftests for new
 cgroup local storage
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180546.2863789-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221023180546.2863789-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/23/22 11:05 AM, Yonghong Song wrote:
> Add two tests for new cgroup local storage, one to test bpf program helpers
> and user space map APIs, and the other to test recursive fentry
> triggering won't deadlock.

Other than tracing, it will be very useful to add a bpf_cgrp_storage_get() usage 
in a cgroup-bpf prog.  Exercising this helper in the existing 
SEC(cgroup)/SEC(sockops) tests should be pretty easy.  eg. The 
SEC("cgroup/connect6") in socket_cookie_prog.c.

