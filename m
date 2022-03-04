Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163354CDB35
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 18:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiCDRqt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbiCDRqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 12:46:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750560052;
        Fri,  4 Mar 2022 09:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5472BB82AB6;
        Fri,  4 Mar 2022 17:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650B6C340E9;
        Fri,  4 Mar 2022 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646415957;
        bh=8HJ9CtJ1nufi02YbUOTBwGwRoByMKoGWsE2xBORGxNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3X1Isq03KUCQ+z55Mp9a9sSvwBrjCfyuW5lAUs1mA1oct7LGwP/nZmUJhvnWH1+e
         NXOCdwYpesvOvZheZOWj8GoGEY1wY88gigD9w7TI6+MNvd5Xd1LGlO50LlRrciJ1RH
         ssQDpUB6qepfA4S1FByjKLsjqQKusDh4ZIPa7Ab48h97KGWSADb8rTe/I1xsRIRgJE
         rZWLe4fVdn7DLpaWZhTsAQ5qYQTj7aohKlJPtB6EaxPKneiI410NP2um4oYcbZH0j7
         SrbcTApTeOV1zrLVtgom6LFfvfHXiFs8xMx1tuGxIrYOAmMCHK6QLKZ++V94nn3vgz
         2+qThNNB8qY0w==
Date:   Fri, 4 Mar 2022 19:45:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     torvalds@linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: Consider __GFP_NOWARN flag for oversized kvmalloc()
 calls
Message-ID: <YiJQUe7qfTHISBW+@unreal>
References: <8a99a175d25f4bcce6b78cee8fa536e40b987b0a.1646403182.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a99a175d25f4bcce6b78cee8fa536e40b987b0a.1646403182.git.daniel@iogearbox.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 04, 2022 at 03:26:32PM +0100, Daniel Borkmann wrote:
> syzkaller was recently triggering an oversized kvmalloc() warning via
> xdp_umem_create().
> 
> The triggered warning was added back in 7661809d493b ("mm: don't allow
> oversized kvmalloc() calls"). The rationale for the warning for huge
> kvmalloc sizes was as a reaction to a security bug where the size was
> more than UINT_MAX but not everything was prepared to handle unsigned
> long sizes.
> 
> Anyway, the AF_XDP related call trace from this syzkaller report was:
> 
>   kvmalloc include/linux/mm.h:806 [inline]
>   kvmalloc_array include/linux/mm.h:824 [inline]
>   kvcalloc include/linux/mm.h:829 [inline]
>   xdp_umem_pin_pages net/xdp/xdp_umem.c:102 [inline]
>   xdp_umem_reg net/xdp/xdp_umem.c:219 [inline]
>   xdp_umem_create+0x6a5/0xf00 net/xdp/xdp_umem.c:252
>   xsk_setsockopt+0x604/0x790 net/xdp/xsk.c:1068
>   __sys_setsockopt+0x1fd/0x4e0 net/socket.c:2176
>   __do_sys_setsockopt net/socket.c:2187 [inline]
>   __se_sys_setsockopt net/socket.c:2184 [inline]
>   __x64_sys_setsockopt+0xb5/0x150 net/socket.c:2184
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Bj�rn mentioned that requests for >2GB allocation can still be valid:
> 
>   The structure that is being allocated is the page-pinning accounting.
>   AF_XDP has an internal limit of U32_MAX pages, which is *a lot*, but
>   still fewer than what memcg allows (PAGE_COUNTER_MAX is a LONG_MAX/
>   PAGE_SIZE on 64 bit systems). [...]
> 
>   I could just change from U32_MAX to INT_MAX, but as I stated earlier
>   that has a hacky feeling to it. [...] From my perspective, the code
>   isn't broken, with the memcg limits in consideration. [...]
> 
> Linus says:
> 
>   [...] Pretty much every time this has come up, the kernel warning has
>   shown that yes, the code was broken and there really wasn't a reason
>   for doing allocations that big.
> 
>   Of course, some people would be perfectly fine with the allocation
>   failing, they just don't want the warning. I didn't want __GFP_NOWARN
>   to shut it up originally because I wanted people to see all those
>   cases, but these days I think we can just say "yeah, people can shut
>   it up explicitly by saying 'go ahead and fail this allocation, don't
>   warn about it'".
> 
>   So enough time has passed that by now I'd certainly be ok with [it].
> 
> Thus allow call-sites to silence such userspace triggered splats if the
> allocation requests have __GFP_NOWARN. For xdp_umem_pin_pages()'s call
> to kvcalloc() this is already the case, so nothing else needed there.
> 
> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> Reported-by: syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com
> Cc: Bj�rn T�pel <bjorn@kernel.org>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Link: https://lore.kernel.org/bpf/CAJ+HfNhyfsT5cS_U9EC213ducHs9k9zNxX9+abqC0kTrPbQ0gg@mail.gmail.com
> Link: https://lore.kernel.org/bpf/20211201202905.b9892171e3f5b9a60f9da251@linux-foundation.org
> ---
>  [ Hi Linus, just to follow-up on the discussion from here [0], I've cooked
>    up proper and tested patch. Feel free to take it directly to your tree if
>    you prefer, or we could also either route it via bpf or mm, whichever way
>    is best. Thanks!
>    [0] https://lore.kernel.org/bpf/CAHk-=wiRq+_jd_O1gz3J6-ANtXMY7iLpi8XFUcmtB3rBixvUXQ@mail.gmail.com/ ]

It will be great to see this patch applied directly to Linus's tree.
We (RDMA) have same false alarms [1].

[1] https://lore.kernel.org/linux-mm/YayptO82EvG3EwKA@unreal/

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
