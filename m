Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5960ED4E
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 03:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiJ0BOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJ0BOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 21:14:17 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E441004A0
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 18:14:15 -0700 (PDT)
Message-ID: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666833253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sZHAi7QI8j2X3+zzh0s3a0e5T2N98/95Hv64At1gsFE=;
        b=q37ItUx4cEfQVxyZ9wZjvgTgYacCpJDVdlYlf0Xrvs5E2EN1LDkYrvWyQ5KOaY3FMXdCQO
        l3irGuhwgJQzz0eXXPUumHz/UaAyZcnKA6BTGXGzZCXPiop4j14LZ0kTJv2E3/Mj/KqE4l
        m96DULzw18uOSD4QEEv8xQU/xbDAmvk=
Date:   Wed, 26 Oct 2022 18:14:08 -0700
MIME-Version: 1.0
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Subject: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen >
 PAGE_SIZE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior. 
The bpf prog usually just handles a few specific optnames and ignores most 
others.  For the optnames that it ignores, it usually does not need to change 
the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval). 
The bpf prog needs to set the optlen to 0 for this case or else the kernel will 
return -EFAULT to the userspace.  It is usually not what the bpf prog wants 
because the bpf prog only expects error returning to userspace when it has 
explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes 
optlen for optnames that it does not care to 0,  it may risk if the latter bpf 
prog in the same cgroup may want to change/look-at it.

Would like to explore if there is an easier way for the bpf prog to handle it. 
eg. does it make sense to track if the bpf prog has changed the ctx->optlen 
before returning -EFAULT to the user space when ctx.optlen > max_optlen?
