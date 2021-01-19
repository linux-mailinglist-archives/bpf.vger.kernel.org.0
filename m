Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680402FC20E
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbhASVOj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 16:14:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:37766 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392087AbhASVN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 16:13:29 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l1yIl-000Foz-4q; Tue, 19 Jan 2021 22:12:35 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l1yIl-000FQV-0X; Tue, 19 Jan 2021 22:12:35 +0100
Subject: Re: [PATCH] bpf: helper bpf_map_peek_elem_proto points to wrong
 callback.
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        mauriciovasquezbernal@gmail.com
References: <AM7PR02MB6082663DFDCCE8DA7A6DD6B1BBA30@AM7PR02MB6082.eurprd02.prod.outlook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ae7fe32f-5a2b-fc68-9f91-5e50dbf605e2@iogearbox.net>
Date:   Tue, 19 Jan 2021 22:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <AM7PR02MB6082663DFDCCE8DA7A6DD6B1BBA30@AM7PR02MB6082.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26054/Tue Jan 19 13:32:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/21 8:05 PM, Mircea CIRJALIU - MELIU wrote:
> I assume this was obtained by copy-paste.
> 
> Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>

Ugh, big yikes (!), thanks a lot for the fix, applied!

I've added Fixes tag to f1a2e44a3aec ("bpf: add queue and stack maps"). I bet
either noone has been using bpf_map_peek_elem() in practice (at least from BPF
program side) or it was most of the time hidden behind 84430d4232c3 ("bpf,
verifier: avoid retpoline for map push/pop/peek operation") as JIT is enabled
in most cases.

> ---
>   kernel/bpf/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bd8a3183d030..41ca280b1dc1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -108,7 +108,7 @@ BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
>   }
> 
>   const struct bpf_func_proto bpf_map_peek_elem_proto = {
> -       .func           = bpf_map_pop_elem,
> +       .func           = bpf_map_peek_elem,
>          .gpl_only       = false,
>          .ret_type       = RET_INTEGER,
>          .arg1_type      = ARG_CONST_MAP_PTR,
> --
> 2.25.1
> 

