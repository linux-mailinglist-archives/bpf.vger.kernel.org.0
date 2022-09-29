Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA55EEA9E
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiI2AkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2AkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 20:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB158520
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2A51B8229A
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 00:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCEFC433B5;
        Thu, 29 Sep 2022 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664412018;
        bh=C1uHsR2/hhpemDbrj+CtlmmqLOcp7NTkvuXs3S2w4sg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WqFCBe8X464diWBYJkqWuatN1tO3Zen4pnVqRijoTKgwJRV3aeZjZkBUNOP+MO4i5
         5YjO1ij0SnaGPJw3A3GkXbieLJzZLTLUYQfu9NglXLh+iYlDHhJZzYUAhsxMu8BTvN
         S3XHYGxFsVtADFhqES6/FzIy/0RxcE+0jG6VFz4zEq+K0nlHEUf+vbyaznjhmUvBOD
         zGGqOljE254TkWBikVUlM2pM76mDB3IJh1IMW5AWTkfKO4zHql0Xwoik7huZY6Lodr
         lIFcoa4R5av4n1ImtIbRIWCWQTQ43H/a561Qj3Eg6OW7ZqN2cTthIvzzRVc3JPR3mq
         eR3EcRY05GtFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D3DCC395DA;
        Thu, 29 Sep 2022 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next 00/11] bpf/selftests: convert some tests to ASSERT_* macros
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166441201844.996.858674831191068436.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Sep 2022 00:40:18 +0000
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, delyank@fb.com, zhudi2@huawei.com,
        jakub@cloudflare.com, kuba@kernel.org, kuifeng@fb.com,
        deso@posteo.net, zhuyifei@google.com, hengqi.chen@gmail.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 26 Sep 2022 13:12:00 +0800 you wrote:
> Convert some tests to use the preferred ASSERT_* macros instead of the
> deprecated CHECK().
> 
> Wang Yufen (11):
>   bpf/selftests: convert sockmap_basic test to ASSERT_* macros
>   bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
>   bpf/selftests: convert sockopt test to ASSERT_* macros
>   bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
>   bpf/selftests: convert sockopt_multi test to ASSERT_* macros
>   bpf/selftests: convert sockopt_sk test to ASSERT_* macros
>   bpf/selftests: convert tcp_estats test to ASSERT_* macros
>   bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
>   bpf/selftests: convert tcp_rtt test to ASSERT_* macros
>   bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
>   bpf/selftests: convert udp_limit test to ASSERT_* macros
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/11] bpf/selftests: convert sockmap_basic test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/38e35e1d0cee
  - [bpf-next,02/11] bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/d155fcb3fff1
  - [bpf-next,03/11] bpf/selftests: convert sockopt test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/099763e7da0b
  - [bpf-next,04/11] bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/675bc8abe16d
  - [bpf-next,05/11] bpf/selftests: convert sockopt_multi test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/a605a6bbccce
  - [bpf-next,06/11] bpf/selftests: convert sockopt_sk test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/f19708dfa0bf
  - [bpf-next,07/11] bpf/selftests: convert tcp_estats test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/a0a17296713a
  - [bpf-next,08/11] bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/3082f8cd4ba3
  - [bpf-next,09/11] bpf/selftests: convert tcp_rtt test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/8dda32ac58b6
  - [bpf-next,10/11] bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/9d0b05bdfbea
  - [bpf-next,11/11] bpf/selftests: convert udp_limit test to ASSERT_* macros
    https://git.kernel.org/bpf/bpf-next/c/1fddca3d36d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


