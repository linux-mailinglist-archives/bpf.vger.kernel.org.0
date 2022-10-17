Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35666006C6
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJQGfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJQGfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 02:35:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D3A4B9BB;
        Sun, 16 Oct 2022 23:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1FA9B80E48;
        Mon, 17 Oct 2022 06:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE300C433C1;
        Mon, 17 Oct 2022 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665988547;
        bh=rZyWQiABeLWts3jlfUmft7CVgttT6trUfj+DCShdiW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgqfhjAYH9VH+0LjV8q9VyWThIj+LmVg0rc7d+e6qfph2lE5FBmDea81WiKwF0/UJ
         ybRwCPm8qBK3ZlGFqCzODxFGjKFSU4fDc9HLZronmDDnJnFyVPMc5ex1nd1HZDwoDu
         wUPgkZx06wc8nuXCdvyEYOBkLMEIl8QAwc+s47GU+EIf5kcA+iZFGajXO7NjC+oFqs
         8UfnUN6fIArk1izpQr1/eSEENeOM6zJyoKq9BnJjYW1ExhszKqcBPxl4OXpthvVtAy
         YkHfGYTEGuD7OuJvdP819esLOdWhmujJD5wq1Jj3yiyp18zlw55qEb/xng/VzFlk5g
         AChZhbY5ay+Yg==
Date:   Mon, 17 Oct 2022 08:35:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, H@wittgenstein
Cc:     Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
Message-ID: <20221017063542.bj7aqcxjfzd5l4da@wittgenstein>
References: <20221012091356.16632-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012091356.16632-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 11:13:56AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/cramfs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
> of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
