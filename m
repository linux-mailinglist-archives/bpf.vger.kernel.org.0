Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB02DB669
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 23:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgLOWRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 17:17:51 -0500
Received: from www62.your-server.de ([213.133.104.62]:38936 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgLOWRs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 17:17:48 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpId1-000G8L-0K; Tue, 15 Dec 2020 23:17:07 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpId0-000Vhs-Rp; Tue, 15 Dec 2020 23:17:06 +0100
Subject: Re: Why n_buckets is at least max_entries?
To:     Cong Wang <xiyou.wangcong@gmail.com>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d50dad4-1bfa-12a0-7516-b361e5ca803b@iogearbox.net>
Date:   Tue, 15 Dec 2020 23:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/15/20 10:44 PM, Cong Wang wrote:
> Hello,
> 
> Any reason why we allocate at least max_entries of buckets of a hash map?
> 
>   466
>   467         /* hash table size must be power of 2 */
>   468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
> 
> This looks very odd to me, as I never see any other hash table
> implementation like this. I _guess_ we try to make it a perfect hash?
> But in reality no hash is perfect, so it is impossible to have no
> conflicts, that is, there is almost always a bucket that has multiple
> elements.
> 
> Or is it because other special maps (LRU?) require this? I can not
> immediately see it from htab_map_alloc().

hash/LRU map is optimized for lookup speed, so __select_bucket() makes use
of the fact that it's power of 2.

Thanks,
Daniel
