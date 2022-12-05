Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB164353E
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 21:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLEUF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 15:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLEUFW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 15:05:22 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C11EEEF;
        Mon,  5 Dec 2022 12:05:19 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2Hi9-0004RO-UX; Mon, 05 Dec 2022 21:05:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2Hi9-000GPh-Ee; Mon, 05 Dec 2022 21:05:09 +0100
Subject: Re: [PATCH] bpftool: Fix memory leak in do_build_table_cb
To:     Miaoqian Lin <linmq006@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205081300.561974-1-linmq006@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8d7ac47d-5d76-eaf1-7c1e-a4418d80dac5@iogearbox.net>
Date:   Mon, 5 Dec 2022 21:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221205081300.561974-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26741/Mon Dec  5 09:16:09 2022)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/5/22 9:13 AM, Miaoqian Lin wrote:
> strdup() allocates memory for path. We need to release the memory in
> the following error paths. Add free() to avoid memory leak.
> 
> Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   tools/bpf/bpftool/common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 0cdb4f711510..8a820356525e 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -499,9 +499,11 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
>   	if (err) {
>   		p_err("failed to append entry to hashmap for ID %u, path '%s': %s",
>   		      pinned_info.id, path, strerror(errno));
> -		goto out_close;
> +		goto out_free;
>   	}
>   
> +out_free:
> +	free(path);

It would be ok if you were to add the free(path) into the err condition, but here you
also cause the !err to be freed which would trigger as UAF. See the hashmap_insert()
where just set the pointer entry->value = <path>.. how was this tested before submission?

>   out_close:
>   	close(fd);
>   out_ret:
> 

