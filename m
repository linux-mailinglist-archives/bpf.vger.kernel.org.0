Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B022A1D5890
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOSBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOSBx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 14:01:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15072C061A0C;
        Fri, 15 May 2020 11:01:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F50D14EC309A;
        Fri, 15 May 2020 11:01:52 -0700 (PDT)
Date:   Fri, 15 May 2020 11:01:51 -0700 (PDT)
Message-Id: <20200515.110151.71697527447953033.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2020-05-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200515172523.44348-1-alexei.starovoitov@gmail.com>
References: <20200515172523.44348-1-alexei.starovoitov@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 May 2020 11:01:52 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2020 10:25:23 -0700

> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 9 non-merge commits during the last 2 day(s) which contain
> a total of 14 files changed, 137 insertions(+), 43 deletions(-).
> 
> The main changes are:
> 
> 1) Fix secid_to_secctx LSM hook default value, from Anders.
> 
> 2) Fix bug in mmap of bpf array, from Andrii.
> 
> 3) Restrict bpf_probe_read to archs where they work, from Daniel.
> 
> 4) Enforce returning 0 for fentry/fexit progs, from Yonghong.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
