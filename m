Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2416BC1A8
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 00:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCOXpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjCOXpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 19:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AD13537;
        Wed, 15 Mar 2023 16:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD5ABB81E8F;
        Wed, 15 Mar 2023 23:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9067C433D2;
        Wed, 15 Mar 2023 23:43:37 +0000 (UTC)
Date:   Wed, 15 Mar 2023 19:43:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v2 04/10] ftrace: Store direct called addresses in their
 ops
Message-ID: <20230315194334.58eb56ab@gandalf.local.home>
In-Reply-To: <20230207182135.2671106-5-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
        <20230207182135.2671106-5-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  7 Feb 2023 19:21:29 +0100
Florent Revest <revest@chromium.org> wrote:

> @@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
>  	tmp_ops.func_hash = ops->func_hash;
> +	tmp_ops.direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(&tmp_ops);
>  	if (err)
> @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  			entry->direct = addr;
>  		}
>  	}
> +	WRITE_ONCE(ops->direct_call, addr);

I'm curious about the use of WRITE_ONCE(). It should not go outside the
mutex barrier.

-- Steve

>  
>  	mutex_unlock(&ftrace_lock);
>  
