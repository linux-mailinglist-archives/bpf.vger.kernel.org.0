Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FE685FBC
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 07:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBAG0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 01:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAG0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 01:26:14 -0500
Received: from out-113.mta0.migadu.com (out-113.mta0.migadu.com [IPv6:2001:41d0:1004:224b::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CB38EB7
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 22:26:12 -0800 (PST)
Message-ID: <cd2888bc-0828-e0e1-1a9e-e2a9b5d93181@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675232769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o51/xctERUG44DB0qNH2UTmv4u8pAyVO2fLD3z82Bi4=;
        b=a3sWvmC6ZE1195bzSldEcPeGG6osiydmB1QLUKhQD257NOmJfbaDmLH/Do9s5CUoCLdaEJ
        NskEgojeCL5SNbrHWzu4HFLWmLcA8rihELPbSmhCf49iRlsTwQfiAaSZYPhNgsVLaU8iIt
        q6G6O0xrEcKqShrffHOb5JLYCsCPSZw=
Date:   Tue, 31 Jan 2023 22:25:56 -0800
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Multi-kfunc sets / restricted scoping
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
References: <Y9KLHZ1TNXVHdVKm@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y9KLHZ1TNXVHdVKm@maniforge>
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

On 1/26/23 6:15 AM, David Vernet wrote:
> I would like to propose discussing a potential new kfunc-related feature
> at LSF/MM/BPF: Enabling kfuncs to be restricted to only being callable
> from a subset of specific BPF programs, e.g. from only a subset of
> callbacks defined in a struct_ops struct, rather than from any
> struct_ops program.
> 
> Some kfuncs may not be safe or logical to call from all contexts. For
> example, the backend kernel implementation which is invoking a
> struct_ops callback may set some global state before calling into BPF,
> and may thus expect that the state is set when the program calls back
> into the kernel from that struct_ops callback, via a kfunc. If the kfunc
> can't actually rely on that expectation, whether for safety reasons or
> correctness reasons, it has to implement its own methodology for
> ensuring it was called from the right context.
> 
> Providing developers with an ability to specify the specific programs
> that a kfunc should be invokable from would address this problem, and
> would avoid every kfunc implementation from having to implement its own
> scope checking / validation where required.
> 
> I would like to discuss possible design approaches, UX approaches, etc.
> 
> Thoughts?
SG. This can be combined together with your another kfunc topic (per-arg flags).

