Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446E04DDC44
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiCRO4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiCRO4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 10:56:46 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A32BF022
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 07:55:27 -0700 (PDT)
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nVE0k-0008yt-8K; Fri, 18 Mar 2022 15:55:26 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nVE0k-0000xn-2d; Fri, 18 Mar 2022 15:55:26 +0100
Subject: Re: [PATCH bpf-next] libbpf: Close fd in bpf_object__reuse_map
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
References: <20220317020301.2680432-1-hengqi.chen@gmail.com>
Cc:     toke@redhat.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <37ed012e-cd83-0aeb-b9d0-a905be940e00@iogearbox.net>
Date:   Fri, 18 Mar 2022 15:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220317020301.2680432-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26485/Fri Mar 18 09:26:47 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Cc +Toke ]

On 3/17/22 3:03 AM, Hengqi Chen wrote:
> pin_fd is dup-ed and assigned in bpf_map__reuse_fd. Close it
> after reuse successfully.
> 
> Fixes: 57a00f416toke@redhat.com44f ("libbpf: Add auto-pinning of maps when loading BPF objects")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 43161fdd44bb..10ad500f1d6e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4804,6 +4804,7 @@ bpf_object__reuse_map(struct bpf_map *map)
>   		close(pin_fd);
>   		return err;
>   	}
> +	close(pin_fd);

Lgtm, but in that case, pls just do ...

         err = bpf_map__reuse_fd(map, pin_fd);
         close(pin_fd);
         if (err)
                 return err;
         [...]

... given we close it in both branches.

>   	map->pinned = true;
>   	pr_debug("reused pinned map at '%s'\n", map->pin_path);
>   
> 

