Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539A636EDE
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKXASd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKXASU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:18:20 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6734763CE6;
        Wed, 23 Nov 2022 16:18:08 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzwL-0000Gk-KX; Thu, 24 Nov 2022 01:18:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzwL-000Vk9-2M; Thu, 24 Nov 2022 01:18:05 +0100
Subject: Re: [PATCH bpf v2] bpf: Update bpf_{g,s}etsockopt() documentation
To:     Ji Rongfeng <SikoJobs@outlook.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, kuifeng@fb.com,
        lorenzo@kernel.org, maximmi@nvidia.com, quentin@isovalent.com
References: <DU0P192MB15479B86200B1216EC90E162D6099@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0977584d-8aff-624d-4cf8-a6e4868958c5@iogearbox.net>
Date:   Thu, 24 Nov 2022 01:18:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DU0P192MB15479B86200B1216EC90E162D6099@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26729/Wed Nov 23 09:18:01 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/22 9:18 AM, Ji Rongfeng wrote:
> * append missing optnames to the end
> * simplify bpf_getsockopt()'s doc
> 
> Signed-off-by: Ji Rongfeng <SikoJobs@outlook.com>
> ---
>   include/uapi/linux/bpf.h       | 20 ++++++++++++--------
>   tools/include/uapi/linux/bpf.h | 20 ++++++++++++--------
>   2 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 51b9aa640ad2..14f29d95ea71 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2576,14 +2576,19 @@ union bpf_attr {
>    * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
>    * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
>    * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
> - * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
> + * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
> + * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
>    * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
>    * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
>    * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
>    * 		  **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
> - *		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**.
> + * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
> + * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
> + * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
> + * 		  **TCP_BPF_RTO_MIN**.
>    * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
> - * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
> + * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
> + * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
>    * 	Return
>    * 		0 on success, or a negative error in case of failure.
>    *
> @@ -2800,12 +2805,11 @@ union bpf_attr {
>    * 		  and **BPF_CGROUP_INET6_CONNECT**.
>    *
>    * 		This helper actually implements a subset of **getsockopt()**.
> - * 		It supports the following *level*\ s:
> + * 		It supports the same set of *optname*\ s that supported by

nit: that is supported by

> + * 		**bpf_setsockopt**\ () helper with a few exceptions:
>    *
> - * 		* **IPPROTO_TCP**, which supports *optname*
> - * 		  **TCP_CONGESTION**.
> - * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
> - * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
> + * 		* **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
> + * 		* **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.

I think from a user PoV the above is a bit hard to follow, maybe take Martin's
earlier feedback into account and add a proper sentence; it will be much easier
to understand.

>    * 	Return
>    * 		0 on success, or a negative error in case of failure.
>    *
[...]
