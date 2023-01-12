Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75D667E86
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 19:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbjALS7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 13:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjALS7T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 13:59:19 -0500
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4DF60D6
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 10:37:06 -0800 (PST)
Message-ID: <2ad43e3b-ed24-f9cf-490a-5e4e91348f02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673548624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2++N0OHRBPGt8Hj0ImG5HTI2S6FDkm5sbdD9yMGa0ng=;
        b=hIRAUtKreUlOGQJ9++2ZGyeQSVjvxVM3F82xHVCODvtCYuK9ihYog+SMMwNSqhEAEcfAV8
        ScRy27lUbB5AYy7mRu3IQaZQX0AQ4UwuL9iu0yN7qpqCOTErJBRzxBrPhqngJwgA92ASZr
        E00UP+ByEyO3Wp5vBC0amt8KRMigRmA=
Date:   Thu, 12 Jan 2023 10:37:00 -0800
MIME-Version: 1.0
Subject: Re: Potential write after free to a task local storage within an eBPF
 program
Content-Language: en-US
To:     Ori Glassman <ori.glassman@aquasec.com>
References: <DU2PR03MB8006816CEC3A464A3E94752E96FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <DU2PR03MB80060A94A9078440548B901196FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
In-Reply-To: <DU2PR03MB80060A94A9078440548B901196FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/12/23 6:04 AM, Ori Glassman wrote:

> I think I am able to write to an non allocated task local storage memory within an eBPF program (raw_tracepoint program), could anyone confirm this is really a bug, and that I'm not missing anything? Here's the code (thanks!):

Not a bug. There is no use-after-free issue. bpf_task_storage_delete() deletes 
the value from map_a but it does not mean the value is freed immediately. The 
value is still protected under the RCU grace period.

> 
> ----------------------------------------------------
> long *ptr;
> struct task_struct *task = bpf_get_current_task_btf();
> ptr = bpf_task_storage_get(&map_a, task, 0, (1ULL << 0)); // create if doesn't exist
> if (ptr)
>      *ptr = 200;
>   
> int ret = bpf_task_storage_delete(&map_a, task);
> if (ret != 0)
>      return 0;
>            
>   if (ptr)
>      *ptr = 300; // writing to an un-mapped address
> 
> const char fmt[] = "%ld";
> bpf_trace_printk(fmt, sizeof(fmt), *ptr); // this prints 300
> ----------------------------------------------------
> 
> My system is ('uname -a'): 'Linux ip-172-31-3-230 5.15.0-1027-aws #31-Ubuntu SMP Wed Nov 30 20:19:26 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux'

