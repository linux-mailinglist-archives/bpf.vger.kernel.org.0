Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109268A8A3
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 07:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBDG6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 01:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDG6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 01:58:31 -0500
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A501CAEE
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 22:58:29 -0800 (PST)
Message-ID: <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675493908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnVbDM3tODiOoPOU6J9Bc2hHvqzzwVji+olsb/JrusU=;
        b=Q5GITzVcjTvOpiwUBE9wrLPyL3ykfA0kvyAihDaOhA6/iz28ItQSfa+nSTWXqAEsHQNSuB
        qF0eNbRBL6lFwOYftGmAgficCipDmdic+yDNRo8rEzN3ek/i6UM7ocOwcMIrUemYd3FtTX
        Vr7TbUtu4llyGGj/PIpeSMGT7gflaTw=
Date:   Fri, 3 Feb 2023 22:58:20 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] Add support for tracing programs in
 BPF_PROG_RUN
Content-Language: en-US
To:     Grant Seltzer <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, kpsingh@kernel.org, bpf@vger.kernel.org
References: <20230203182812.20657-1-grantseltzer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230203182812.20657-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/23 10:28 AM, Grant Seltzer wrote:
> This patch changes the behavior of how BPF_PROG_RUN treats tracing
> (fentry/fexit) programs. Previously only a return value is injected
> but the actual program was not run.

hmm... I don't understand this. The actual program is run by attaching to the 
bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c

> New behavior mirrors that of running raw tracepoint BPF programs which
> actually runs the instructions of the program via `bpf_prog_run()`

Which tracepoint and how is it tested?

The CI kernel is crashing:
https://patchwork.kernel.org/project/netdevbpf/patch/20230203182812.20657-1-grantseltzer@gmail.com/

