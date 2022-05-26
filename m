Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F1535430
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiEZT6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiEZT6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 15:58:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8746667
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 12:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD05EB8219C
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 19:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9157C385A9;
        Thu, 26 May 2022 19:58:39 +0000 (UTC)
Date:   Thu, 26 May 2022 15:58:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: help to debug a kretprobe_dispatcher issue with 5.12
Message-ID: <20220526155838.2cdef490@gandalf.local.home>
In-Reply-To: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
References: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
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

On Thu, 26 May 2022 12:48:41 -0700
Yonghong Song <yhs@fb.com> wrote:

> So I suspect there is a race condition between kretprobe_dispatcher()
> (or higher level kretprobe_trampoline_handler()) and 
> unregister_kretprobes(). I looked at kernel/trace code and had not
> found an obvious race yet. I will continue to check.
> But at the same time, I would like to seek some expert advice to see
> whether you are aware of any potential issues in 5.12 or not and where
> are possible places I should focus on to add debug codes for experiments.

First thing I'll ask is if you can reproduce this on a vanilla 5.12 kernel.

If not, then we can't help you.

If you can, I would ask if it is reproducible on the latest mainline kernel.
If it is, then we'll help you look into it. If not, we'll ask if you can
try to bisect it to at least find what version it was fixed in.

-- Steve
