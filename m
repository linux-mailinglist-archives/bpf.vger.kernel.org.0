Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D05582AA
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFWRSv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiFWRSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 13:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8189D1F
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 10:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E4461573
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCAA4C341C4;
        Thu, 23 Jun 2022 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656003614;
        bh=tGY5b5h9pFCyQMhgOcTawZNfc8Es5adYT4oNwRSQoN0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G4Qc8h6d59OVLlVDeCDMeAkTC84RBdnhWR/HuTQDVUEu9shbGdIH7r2cJVe00Zp0u
         9pwF731uxdTvXa3bQ6sRp/sEmX2BXQUOiGJrcBxx0aQwqTaDLYZCj+M/oW/uv/ATHe
         siEKnXh/520jhS0qmTemHCkcZHSxLxZ5uMjl7l62at3yyujHhBDPWEOpRE2qZlogtK
         H6VWx5BfBLK3n3SkuU1VyYCaUQvjg6xPUN7cQPfSFdLawxLYzpM6KNSclj18Y4VMDl
         xMGG+BFXGuLQnYsLCZHpS8h+LFr6ToTZWvmCnykZZO1xmOrh2y3CLX/+he/GzfHxTS
         XgDnGTEmsiKqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2621E7BA3C;
        Thu, 23 Jun 2022 17:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/5] Align BPF TCP CCs implementing cong_control()
 with non-BPF CCs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165600361466.15099.15840998947275266596.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Jun 2022 17:00:14 +0000
References: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
In-Reply-To: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
To:     =?utf-8?q?J=C3=B6rn-Thorben_Hinz_=3Cjthinz=40mailbox=2Etu-berlin=2Ede=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, yhs@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 22 Jun 2022 21:12:22 +0200 you wrote:
> This series corrects some inconveniences for a BPF TCP CC that
> implements and uses tcp_congestion_ops.cong_control(). Until now, such a
> CC did not have all necessary write access to struct sock and
> unnecessarily needed to implement cong_avoid().
> 
> v4:
>  - Remove braces around single statements after if
>  - Don’t check pointer passed to bpf_link__destroy()
> v3:
>  - Add a selftest writing sk_pacing_*
>  - Add a selftest with incomplete tcp_congestion_ops
>  - Add a selftest with unsupported get_info()
>  - Remove an unused variable
>  - Reword a comment about reg() in bpf_struct_ops_map_update_elem()
> v2:
>  - Drop redundant check for required functions and just rely on
>    tcp_register_congestion_control() (Martin KaFai Lau)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] bpf: Allow a TCP CC to write sk_pacing_rate and sk_pacing_status
    https://git.kernel.org/bpf/bpf-next/c/41c95dd6a604
  - [bpf-next,v4,2/5] bpf: Require only one of cong_avoid() and cong_control() from a TCP CC
    https://git.kernel.org/bpf/bpf-next/c/9f0265e921de
  - [bpf-next,v4,3/5] selftests/bpf: Test a BPF CC writing sk_pacing_*
    https://git.kernel.org/bpf/bpf-next/c/6e945d57cc9f
  - [bpf-next,v4,4/5] selftests/bpf: Test an incomplete BPF CC
    https://git.kernel.org/bpf/bpf-next/c/0735627d78ca
  - [bpf-next,v4,5/5] selftests/bpf: Test a BPF CC implementing the unsupported get_info()
    https://git.kernel.org/bpf/bpf-next/c/f14a3f644a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


