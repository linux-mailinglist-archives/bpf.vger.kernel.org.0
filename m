Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CD1D5854
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEORx3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEORx3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 13:53:29 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F052C061A0C;
        Fri, 15 May 2020 10:53:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA0D214EAD473;
        Fri, 15 May 2020 10:53:28 -0700 (PDT)
Date:   Fri, 15 May 2020 10:53:27 -0700 (PDT)
Message-Id: <20200515.105327.1379350387536444274.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2020-05-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200515172124.44077-1-alexei.starovoitov@gmail.com>
References: <20200515172124.44077-1-alexei.starovoitov@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 May 2020 10:53:29 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2020 10:21:24 -0700

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 37 non-merge commits during the last 1 day(s) which contain
> a total of 67 files changed, 741 insertions(+), 252 deletions(-).
> 
> The main changes are:
> 
> 1) bpf_xdp_adjust_tail() now allows to grow the tail as well, from Jesper.
> 
> 2) bpftool can probe CONFIG_HZ, from Daniel.
> 
> 3) CAP_BPF is introduced to isolate user processes that use BPF infra and
>    to secure BPF networking services by dropping CAP_SYS_ADMIN requirement
>    in certain cases, from Alexei.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Alexei.
