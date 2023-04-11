Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7B6DE40B
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDKShs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDKShp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 14:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4145B8D;
        Tue, 11 Apr 2023 11:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B1362AE1;
        Tue, 11 Apr 2023 18:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B5C433D2;
        Tue, 11 Apr 2023 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681238261;
        bh=bVNFNE0AyvC9VYJ6To61TadIe2WW1fg0uKBdoz+410I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0SYWHwoxs7cZ0gkfU2np4bNg78D348+38aigs5n6bgtBQUhGwI65OobImNSGr8NY
         /i8YbgdqjOgxbNYhNZU7RNoKXwbB9EmXRnhCnRsP9HA1KZuVsGi5jRgfSRfl1twCUm
         XHUVdNHRS6YghAI08tqMyV0IbDW7LyuvVuJaGqyJ2azl5T3AYf7JyyX9n2x54PXM45
         u04jSSffIG7RquB8gDxQmOHoq7ioCZdoPA7soF0JqXt+fashjm4/ivcphIE3UmzgOi
         pRQ/XCaEiujXQhg/zOku3PIHiuqvxNIvz9wwrYhmNfFVdfTtmVtsS20zn5WONWKUlG
         y8W+qpd+Ig+bw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        daniel@iogearbox.net, andrii@kernel.org, xukuohai@huaweicloud.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        ast@kernel.org, lihuafei1@huawei.com, kpsingh@kernel.org
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Date:   Tue, 11 Apr 2023 19:37:27 +0100
Message-Id: <168123280013.1317107.14827742829060906340.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 5 Apr 2023 20:02:45 +0200, Florent Revest wrote:
> This series adds ftrace direct call support to arm64.
> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
> 
> It is meant to be taken by the arm64 tree but it depends on the
> trace-direct-v6.3-rc3 tag of the linux-trace tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> That tag was created by Steven Rostedt so the arm64 tree can pull the prior work
> this depends on. [1]
> 
> [...]

Applied first two to arm64 (for-next/ftrace), thanks!

[1/5] arm64: ftrace: Add direct call support
      https://git.kernel.org/arm64/c/2aa6ac03516d
[2/5] arm64: ftrace: Simplify get_ftrace_plt
      https://git.kernel.org/arm64/c/0f59dca63bf2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
