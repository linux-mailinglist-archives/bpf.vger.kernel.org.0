Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEA55FF71
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 14:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiF2MOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiF2MO3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 08:14:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604CD17E1F
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 05:14:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LY0kn4Hmbz4xZB;
        Wed, 29 Jun 2022 22:14:25 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220627191119.142867-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220627191119.142867-1-naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH powerpc v2] powerpc/bpf: Fix use of user_pt_regs in uapi
Message-Id: <165650484996.3003821.13352352877965822708.b4-ty@ellerman.id.au>
Date:   Wed, 29 Jun 2022 22:14:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 28 Jun 2022 00:41:19 +0530, Naveen N. Rao wrote:
> Trying to build a .c file that includes <linux/bpf_perf_event.h>:
>   $ cat test_bpf_headers.c
>   #include <linux/bpf_perf_event.h>
> 
> throws the below error:
>   /usr/include/linux/bpf_perf_event.h:14:28: error: field ‘regs’ has incomplete type
>      14 |         bpf_user_pt_regs_t regs;
> 	|                            ^~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/bpf: Fix use of user_pt_regs in uapi
      https://git.kernel.org/powerpc/c/b21bd5a4b130f8370861478d2880985daace5913

cheers
