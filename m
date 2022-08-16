Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8747B596032
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiHPQ1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiHPQ1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 12:27:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59337B78E;
        Tue, 16 Aug 2022 09:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 869F0B81A64;
        Tue, 16 Aug 2022 16:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BFC433D6;
        Tue, 16 Aug 2022 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660667224;
        bh=846lcM6Ki+haEfddmtBWQ9IrsmDgWnWnRacmBoXbmmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kT6vSuOcEqqvD9XHGyoRHnsmQ+sxDdRFY7QDP5D6g9kIeWmowmJzNITXF22tpB9P/
         rVtnpB0sJpfKRZOzkPbJo5b7dH0CVjRIqsVLQp1Zg7+Av5WiV9cghsvVAsjPma4s5G
         aF+iIbYJuKqkkkgqcewxzF9wmHMhCFpMJ3W5Llte5IF2Ukk+k6e5Ld9+qTZ2Wf9KaE
         +IyLNMVIMk40+O3PN2Hs/vSJegMLNctlQCGyuizV4Y6EzqbrAGoWcrruWMfQaTb0Up
         WctHHTr+8fzg1hwti4URq3eqqBInTnX8lOpz0zVYHr+S1PxbMFeHWaEZtn7BH3aaeM
         MPKW1CKZ/1fsw==
Date:   Tue, 16 Aug 2022 09:27:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v1 net 00/15] sysctl: Fix data-races around net.core.XXX
 (Round 1)
Message-ID: <20220816092703.7fe8cbb6@kernel.org>
In-Reply-To: <20220816052347.70042-1-kuniyu@amazon.com>
References: <20220816052347.70042-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 22:23:32 -0700 Kuniyuki Iwashima wrote:
>   bpf: Fix data-races around bpf_jit_enable.
>   bpf: Fix data-races around bpf_jit_harden.
>   bpf: Fix data-races around bpf_jit_kallsyms.
>   bpf: Fix a data-race around bpf_jit_limit.

The BPF stuff needs to go via the BPF tree, or get an ack from the BPF
maintainers. I see Daniel is CCed on some of the patches but not all.
