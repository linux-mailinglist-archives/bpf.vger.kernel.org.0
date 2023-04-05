Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AED6D88DC
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjDEUm1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 16:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjDEUmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 16:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA637ED2;
        Wed,  5 Apr 2023 13:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85FE6416A;
        Wed,  5 Apr 2023 20:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B12BC433D2;
        Wed,  5 Apr 2023 20:40:26 +0000 (UTC)
Date:   Wed, 5 Apr 2023 16:40:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v6 3/5] samples: ftrace: Save required argument
 registers in sample trampolines
Message-ID: <20230405164024.5f5c3b6b@gandalf.local.home>
In-Reply-To: <20230405180250.2046566-4-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
        <20230405180250.2046566-4-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  5 Apr 2023 20:02:48 +0200
Florent Revest <revest@chromium.org> wrote:

> The ftrace-direct-too sample traces the handle_mm_fault function whose
> signature changed since the introduction of the sample. Since:
> commit bce617edecad ("mm: do page fault accounting in handle_mm_fault")
> handle_mm_fault now has 4 arguments. Therefore, the sample trampoline
> should save 4 argument registers.
> 
> s390 saves all argument registers already so it does not need a change
> but x86_64 needs an extra push and pop.
> 
> This also evolves the signature of the tracing function to make it
> mirror the signature of the traced function.
>

Should probably add:

Cc: stable@vger.kernel.org
Fixes: bce617edecad ("mm: do page fault accounting in handle_mm_fault")

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
