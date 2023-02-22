Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9269FD88
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBVVKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVVKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C02149B8;
        Wed, 22 Feb 2023 13:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCC3EB81895;
        Wed, 22 Feb 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96953C4339C;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100217;
        bh=c0aWc426aYJm6s52Obhi7fLq+eANWuURTxgJqffX7eA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jCp+CPqNGruZDN4VPXyE0x6kOwpjVvYeFqZT08eaIVjCzeAYiqknr6ggWQMlFvszA
         ehl2Xh1Hyt01JcYGgzw1jeTGBIEbRPMq3fTUPskpREsLA+dXs4KS8HXkn/vvQO/3hc
         8VX1/Ee2oo7ebHykPRrm65bFviMqfipdnUMkrA4Edgz1HmA6KxWt9z+5B66IaoFClO
         apnb3yECVALx4cZ4kRutVyPbZO6xZHEDMPfPhqmyaKWqZZealPn/xkLTQIPjw67xwU
         emqX4sWBI8zaPnLmZRb8bHYjIo3S/K6Kc2umGv29jrK8hiF4JjbO2Y85uCxlMfvU1A
         vnKskLcDLfpGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BA67C395E5;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove not used headers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710021750.10496.4702478918450314201.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:10:17 +0000
References: <1676533861-27508-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1676533861-27508-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Feb 2023 15:51:01 +0800 you wrote:
> The following three uapi headers:
> 
>     tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
>     tools/arch/s390/include/uapi/asm/bpf_perf_event.h
>     tools/arch/s390/include/uapi/asm/ptrace.h
> 
> were introduced in commit 618e165b2a8e ("selftests/bpf: sync kernel headers
> and introduce arch support in Makefile"), they are not used any more after
> commit 720f228e8d31 ("bpf: fix broken BPF selftest build"), so remove them.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Remove not used headers
    https://git.kernel.org/bpf/bpf-next/c/1f265d2aea0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


