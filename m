Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630BB25B73C
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 01:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBXUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBXUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 19:20:22 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D9C061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 16:20:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FCF515751F43;
        Wed,  2 Sep 2020 16:03:35 -0700 (PDT)
Date:   Wed, 02 Sep 2020 16:20:21 -0700 (PDT)
Message-Id: <20200902.162021.1729684142181594925.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jose.marchesi@oracle.com, alexei.starovoitov@gmail.com,
        bpf@vger.kernel.org
Subject: Re: EF_BPF_GNU_XBPF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
References: <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
        <87o8mn281a.fsf@oracle.com>
        <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 02 Sep 2020 16:03:35 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 2 Sep 2020 23:33:17 +0200

> if some of these extensions are useful and help/optimize code
> generation, why not add them to the BPF runtime in the kernel so
> they can be properly used in general for code generation from
> gcc/llvm in BPF backend?

+1
