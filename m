Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59053883B8
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfHIUPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Aug 2019 16:15:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37412 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHIUPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Aug 2019 16:15:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 989E5144FF0E5;
        Fri,  9 Aug 2019 13:15:19 -0700 (PDT)
Date:   Fri, 09 Aug 2019 13:15:19 -0700 (PDT)
Message-Id: <20190809.131519.1657041102672906491.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, m@lambda.lt,
        edumazet@google.com, ast@kernel.org, willemb@google.com
Subject: Re: [PATCH net v2 0/2] Fix collisions in socket cookie generation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190808115726.31703-1-daniel@iogearbox.net>
References: <20190808115726.31703-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Aug 2019 13:15:19 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu,  8 Aug 2019 13:57:24 +0200

> This change makes the socket cookie generator as a global counter
> instead of per netns in order to fix cookie collisions for BPF use
> cases we ran into. See main patch #1 for more details.
> 
> Given the change is small/trivial and fixes an issue we're seeing
> my preference would be net tree (though it cleanly applies to
> net-next as well). Went for net tree instead of bpf tree here given
> the main change is in net/core/sock_diag.c, but either way would be
> fine with me.
> 
> Thanks a lot!
> 
> v1 -> v2:
>   - Fix up commit description in patch #1, thanks Eric!

Series applied.
