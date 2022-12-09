Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C014648B44
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 00:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIXNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 18:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIXNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 18:13:17 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CE96578;
        Fri,  9 Dec 2022 15:13:15 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p3mY8-000Mpu-6s; Sat, 10 Dec 2022 00:13:00 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p3mY7-000CtS-JF; Sat, 10 Dec 2022 00:12:59 +0100
Subject: Re: [PATCH bpf-next v2] libbpf: Optimized return value in
 libbpf_strerror when errno is libbpf errno Xin Liu
To:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
References: <20221209110502.231677-1-liuxin350@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a34fe87e-42a8-7bed-805e-218b9d4554c0@iogearbox.net>
Date:   Sat, 10 Dec 2022 00:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221209110502.231677-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26745/Fri Dec  9 12:50:19 2022)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/9/22 12:05 PM, Xin Liu wrote:
> This is a small improvement in libbpf_strerror. When libbpf_strerror
> is used to obtain the system error description, if the length of the
> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> ERANGE.
> 
> However, this processing is not performed when the error code
> customized by libbpf is obtained. Make some minor improvements here,
> return -ERANGE and set errno to ERANGE when buf is not enough for
> custom description.

nit: $subject line got corrupted?

> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
> 
> v2:
> Check the return value of snprintf to determine whether the buffer is
> too small.
> 
> v1:
> https://lore.kernel.org/bpf/20221209084047.229525-1-liuxin350@huawei.com/T/#t
> 
>   tools/lib/bpf/libbpf_errno.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> index 96f67a772a1b..6240c7cb7472 100644
> --- a/tools/lib/bpf/libbpf_errno.c
> +++ b/tools/lib/bpf/libbpf_errno.c
> @@ -39,14 +39,13 @@ static const char *libbpf_strerror_table[NR_ERRNO] = {
>   
>   int libbpf_strerror(int err, char *buf, size_t size)
>   {
> +	int ret;

nit: newline after declaration

>   	if (!buf || !size)
>   		return libbpf_err(-EINVAL);
>   
>   	err = err > 0 ? err : -err;
>   
>   	if (err < __LIBBPF_ERRNO__START) {
> -		int ret;
> -
>   		ret = strerror_r(err, buf, size);
>   		buf[size - 1] = '\0';
>   		return libbpf_err_errno(ret);
> @@ -56,12 +55,20 @@ int libbpf_strerror(int err, char *buf, size_t size)
>   		const char *msg;
>   
>   		msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
> -		snprintf(buf, size, "%s", msg);
> +		ret = snprintf(buf, size, "%s", msg);
>   		buf[size - 1] = '\0';
> +		if (ret < 0)
> +			return libbpf_err_errno(ret);

This would pass in ret == -1 and then eventually return 1 which
is misleading, no?

We have buf and msg non-NULL and a positive size, afaik, the only
case where you could get a negative error now is when you pass in
a buf with size exceeding INT_MAX..

> +		if (ret >= size)
> +			return libbpf_err(-ERANGE);
>   		return 0;
>   	}
>   
> -	snprintf(buf, size, "Unknown libbpf error %d", err);
> +	ret = snprintf(buf, size, "Unknown libbpf error %d", err);
>   	buf[size - 1] = '\0';
> +	if (ret < 0)
> +		return libbpf_err_errno(ret);
> +	if (ret >= size)
> +		return libbpf_err(-ERANGE);
>   	return libbpf_err(-ENOENT);
>   }
> 

