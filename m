Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5C1702E7
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2020 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZPmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 10:42:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:41870 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBZPmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 10:42:47 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j6yph-0001IR-3G; Wed, 26 Feb 2020 16:42:45 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j6ypg-000EMe-S9; Wed, 26 Feb 2020 16:42:44 +0100
Subject: Re: [PATCH bpf-next] bpftool: Support struct_ops, tracing, ext prog
 types
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, kernel-team@fb.com
References: <20200225223441.689109-1-rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e012e6e7-1c67-7e15-6409-51ccb79be970@iogearbox.net>
Date:   Wed, 26 Feb 2020 16:42:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200225223441.689109-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25734/Tue Feb 25 15:06:17 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/25/20 11:34 PM, Andrey Ignatov wrote:
> Add support for prog types that were added to kernel but not present in
> bpftool yet: struct_ops, tracing, ext prog types and corresponding
> section names.
> 
> Before:
>    # bpftool p l
>    ...
>    184: type 26  name test_subprog3  tag dda135a7dc0daf54  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 112B  jited 103B  memlock 4096B  map_ids 136
>            btf_id 85
>    185: type 28  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 72B  jited 69B  memlock 4096B  map_ids 136
>            btf_id 85
> 
> After:
>    # bpftool p l
>    ...
>    184: tracing  name test_subprog3  tag dda135a7dc0daf54  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 112B  jited 103B  memlock 4096B  map_ids 136
>            btf_id 85
>    185: ext  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 72B  jited 69B  memlock 4096B  map_ids 136
>            btf_id 85
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Applied, thanks!
