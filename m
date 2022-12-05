Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92E64368C
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 22:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLEVLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 16:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiLEVLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 16:11:14 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5CBC1E;
        Mon,  5 Dec 2022 13:11:13 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2Ijq-000Ex2-5I; Mon, 05 Dec 2022 22:10:58 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2Ijp-000AEd-Ik; Mon, 05 Dec 2022 22:10:57 +0100
Subject: Re: [PATCH bpf-next] libbpf: Optimized return value in
 libbpf_strerror when errno is libbpf errno
To:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
References: <20221203093740.218935-1-liuxin350@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6ac9f767-e7f5-6603-6234-97126ea22005@iogearbox.net>
Date:   Mon, 5 Dec 2022 22:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221203093740.218935-1-liuxin350@huawei.com>
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

On 12/3/22 10:37 AM, Xin Liu wrote:
> This is a small improvement in libbpf_strerror. When libbpf_strerror
> is used to obtain the system error description, if the length of the
> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> ERANGE.
> 
> However, this processing is not performed when the error code
> customized by libbpf is obtained. Make some minor improvements here,
> return -ERANGE and set errno to ERANGE when buf is not enough for
> custom description.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>   tools/lib/bpf/libbpf_errno.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> index 96f67a772a1b..48ce7d5b5bf9 100644
> --- a/tools/lib/bpf/libbpf_errno.c
> +++ b/tools/lib/bpf/libbpf_errno.c
> @@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t size)
>   
>   	if (err < __LIBBPF_ERRNO__END) {
>   		const char *msg;
> +		size_t msg_size;
>   
>   		msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
>   		snprintf(buf, size, "%s", msg);
>   		buf[size - 1] = '\0';
> +
> +		msg_size = strlen(msg);
> +		if (msg_size >= size)
> +			return libbpf_err(-ERANGE);

Given this is related to libbpf_strerror_table[] where the error strings are known
lets do compile-time error instead. All callers should pass in a buffer of STRERR_BUFSIZE
size in libbpf.

>   		return 0;
>   	}
>   
> 

