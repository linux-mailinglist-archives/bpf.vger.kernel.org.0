Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C201FD79
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 03:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEPBqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEPB3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 21:29:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C4E814EAD031;
        Wed, 15 May 2019 18:29:07 -0700 (PDT)
Date:   Wed, 15 May 2019 18:29:05 -0700 (PDT)
Message-Id: <20190515.182905.1990277618812551333.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-05-16
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190515235428.16904-1-daniel@iogearbox.net>
References: <20190515235428.16904-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 May 2019 18:29:07 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 16 May 2019 01:54:28 +0200

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) Fix a use after free in __dev_map_entry_free(), from Eric.
> 
> 2) Several sockmap related bug fixes: a splat in strparser if
>    it was never initialized, remove duplicate ingress msg list
>    purging which can race, fix msg->sg.size accounting upon
>    skb to msg conversion, and last but not least fix a timeout
>    bug in tcp_bpf_wait_data(), from John.
> 
> 3) Fix LRU map to avoid messing with eviction heuristics upon
>    syscall lookup, e.g. map walks from user space side will
>    then lead to eviction of just recently created entries on
>    updates as it would mark all map entries, from Daniel.
> 
> 4) Don't bail out when libbpf feature probing fails. Also
>    various smaller fixes to flow_dissector test, from Stanislav.
> 
> 5) Fix missing brackets for BTF_INT_OFFSET() in UAPI, from Gary.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
