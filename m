Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE902ED0FA
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2019 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKBXLB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Nov 2019 19:11:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfKBXLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Nov 2019 19:11:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 25F6514EC308C;
        Sat,  2 Nov 2019 16:11:00 -0700 (PDT)
Date:   Sat, 02 Nov 2019 16:10:58 -0700 (PDT)
Message-Id: <20191102.161058.2119575310571747872.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2019-11-02
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191102202632.2108287-1-ast@kernel.org>
References: <20191102202632.2108287-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 02 Nov 2019 16:11:00 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Sat, 2 Nov 2019 13:26:32 -0700

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 30 non-merge commits during the last 7 day(s) which contain
> a total of 41 files changed, 1864 insertions(+), 474 deletions(-).

Pulled, please double check my handling of the test_offload.py revert.

Thank you.
