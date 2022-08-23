Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04F59ED3B
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiHWUR2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHWURD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 16:17:03 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765ACC22AD
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 12:40:36 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQZlJ-0002Fc-9t; Tue, 23 Aug 2022 21:40:33 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQZlJ-0005iR-2k; Tue, 23 Aug 2022 21:40:33 +0200
Subject: Re: [PATCH bpf-nex] bpf: Fix an inconsitency between copies of bpf.h.
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
References: <20220822195221.1690013-1-kuifeng@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <23c2bf14-ea08-ebe7-a889-29f99288c647@iogearbox.net>
Date:   Tue, 23 Aug 2022 21:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220822195221.1690013-1-kuifeng@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26636/Tue Aug 23 09:52:45 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/22/22 9:52 PM, Kui-Feng Lee wrote:
> struct bpf_lpm_trie_key is inconsistent in two copies of bpf.h.
> It cuases a warning message during building the kernel.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   include/uapi/linux/bpf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 934a2a8beb87..1d6085e15fc8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>   /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>   struct bpf_lpm_trie_key {
>   	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
> -	__u8	data[];	/* Arbitrary size */
> +	__u8	data[0];	/* Arbitrary size */
>   };
>   
>   struct bpf_cgroup_storage_key {
> 

This is fixed in bpf tree already, so it will propagate to bpf-next soon.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3024d95a4c521c278a7504ee9e80c57c3a9750e0

Thanks,
Daniel
