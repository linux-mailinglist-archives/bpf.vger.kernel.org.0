Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC354EE5CC
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 03:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiDABud (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 21:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiDABud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 21:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AE9674E8;
        Thu, 31 Mar 2022 18:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788D86191F;
        Fri,  1 Apr 2022 01:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35167C340ED;
        Fri,  1 Apr 2022 01:48:38 +0000 (UTC)
Date:   Thu, 31 Mar 2022 21:48:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: ftrace_direct (used by bpf trampoline) conflicts with live
 patch
Message-ID: <20220331214836.663bc7cf@rorschach.local.home>
In-Reply-To: <0962AC9B-2FBD-4578-8B2F-A376A6B3B83F@fb.com>
References: <0962AC9B-2FBD-4578-8B2F-A376A6B3B83F@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 1 Apr 2022 01:11:01 +0000
Song Liu <songliubraving@fb.com> wrote:

> Hi Steven, 
> 
> We hit an issue with bpf trampoline and kernel live patch on the 
> same function. 
> 
> Basically, we have tracing and live patch on the same function. 
> If we use kprobe (over ftrace) for tracing, it works fine with 
> live patch. However, fentry on the same function does not work 
> with live patch (the one comes later fails to attach).
> 
> After digging into this, I found this is because bpf trampoline
> uses register_ftrace_direct, which enables IPMODIFY by default. 
> OTOH, it seems that BPF doesn't really need IPMODIFY. As BPF 
> trampoline does a "goto do_fexit" in jit for BPF_TRAMP_MODIFY_RETURN.
> 
> IIUC, we can let bpf trampoline and live patch work together with
> an ipmodify-less version of register_ftrace_direct, like attached 
> below. 
> 
> Does this make sense to you? Did I miss something?

I thought the BPF trampoline does:

	call bpf_trace_before_function
	call original_function + X86_PATCH_SIZE
	call bpf_trace_after_function

Thus, the bpf direct trampoline calls the unpatched version of the
function call making the live patch useless. Or is this not what it
does?

-- Steve
