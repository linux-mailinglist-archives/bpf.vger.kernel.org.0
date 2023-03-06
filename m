Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A706AD166
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCFWUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 17:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCFWUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 17:20:09 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974E5D440;
        Mon,  6 Mar 2023 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=6SMG2y85qlWl9rXIC5Vu/6a2pGG6CNaDI1Qm4HZXZYc=; b=HXRlh2ZugTXHUvbzhCYeIbK0/f
        kwpFMAe+UGyvuIfdKgmuYlRcuXmVC0n5yqwe6SpDBcKbfPvMGg/lNbC6lciY5X5jP5gnaKc/31Osj
        InwftpPuwDCi5QEFEcUAjx+DWgdIlpy0hPb2aSZJni9+lBxZqi5lLEV86XMDlLDiyskXs0C1kIq5I
        VnjUXGioPmgW9D17Ra42mmldQi/mqQwrt7WkPk6ftqaaC2ed7qR/b5cOXLpVKfQHFvh4tWeDPplBv
        cvFEjScxYVfU1p1ApCL9LnSMhjCWIqrhxpZAdnG91ImHgX+7rsUQxo6OIQxacXQOt1hnsffwenIFU
        HHHcsbBg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pZJBY-000BVa-Lx; Mon, 06 Mar 2023 23:20:00 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pZJBY-000Pts-5m; Mon, 06 Mar 2023 23:20:00 +0100
Subject: Re: [PATCH bpf v2 1/2] btf: fix resolving BTF_KIND_VAR after ARRAY,
 STRUCT, UNION, PTR
To:     Lorenz Bauer <lorenz.bauer@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Lorenz Bauer <lmb@isovalent.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230306112138.155352-1-lmb@isovalent.com>
 <20230306112138.155352-2-lmb@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <19d825ad-0ec3-9979-a157-99289339d438@iogearbox.net>
Date:   Mon, 6 Mar 2023 23:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230306112138.155352-2-lmb@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26833/Mon Mar  6 09:22:59 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/6/23 12:21 PM, Lorenz Bauer wrote:
> btf_datasec_resolve contains a bug that causes the following BTF
> to fail loading:
> 
>      [1] DATASEC a size=2 vlen=2
>          type_id=4 offset=0 size=1
>          type_id=7 offset=1 size=1
>      [2] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
>      [3] PTR (anon) type_id=2
>      [4] VAR a type_id=3 linkage=0
>      [5] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
>      [6] TYPEDEF td type_id=5
>      [7] VAR b type_id=6 linkage=0
> 
[...]
> The fix is to reset resolve_mode to RESOLVE_TBD before attempting to
> resolve a VAR from a DATASEC.
> 
> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Looks like patchbot is on strike, the series got applied to bpf, thanks!
