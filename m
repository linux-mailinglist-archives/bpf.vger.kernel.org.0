Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267805FA936
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 02:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJKAS5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJKASy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 20:18:54 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549E5F9B4;
        Mon, 10 Oct 2022 17:18:53 -0700 (PDT)
Message-ID: <c63b7b3e-803b-7e6f-a96c-e75f738f6448@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665447531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQLEPAmV5cNBPcCs5f0QOw5e3ZgyzzZvangEjwzUuWI=;
        b=lcm0A331dxflDnCuebMo/e6Yop5lqvzwOoDoPQGVBJf/dNzXX/fwoEAM9f1/iIjP2ulDYA
        i6MGPJP7kfCPe8L36ZrLFNVmAcSk3SBNdlvClGmPIo7NMlB+6O6bGuBv/GspwmsB87+VxC
        XGlcQVgwuqrmpCPWSN7v2PPTENiWheI=
Date:   Mon, 10 Oct 2022 17:18:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Add SO_REUSEPORT to bpf_{g,s}etsockopt documentation
Content-Language: en-US
To:     Rongfeng Ji <SikoJobs@outlook.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        joannelkoong@gmail.com, kuifeng@fb.com, maximmi@nvidia.com,
        quentin@isovalent.com
References: <DU0P192MB15474ECC548CE7103DCE65FBD65F9@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <DU0P192MB15474ECC548CE7103DCE65FBD65F9@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/22 10:55 AM, Rongfeng Ji wrote:
> SO_REUSEPORT has been supported by bpf_{g,s}etsockopt for a long time.
> It is added at the beginning of the optname list under level
> SOL_SOCKET because it is supported by both helper functions.
> 
> Signed-off-by: Rongfeng Ji <SikoJobs@outlook.com>
> ---
>   include/uapi/linux/bpf.h       | 7 ++++---
>   tools/include/uapi/linux/bpf.h | 7 ++++---
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 51b9aa640ad2..ccae9cb833b8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2574,9 +2574,9 @@ union bpf_attr {
>    * 		It supports the following *level*\ s:
>    *
>    * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
> - * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
> - * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
> - * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
> + * 		  **SO_REUSEPORT**, **SO_RCVBUF**, **SO_SNDBUF**,
> + * 		  **SO_MAX_PACING_RATE**, **SO_PRIORITY**, **SO_RCVLOWAT**,
> + * 		  **SO_MARK**, **SO_BINDTODEVICE**, **SO_KEEPALIVE**.

More options has recently been added to SOL_SOCKET, IPPROTO_TCP, and 
IPPROTO_IPV6.  Could you take this chance to also add them together?

Also, it seems the optnames here is not in any particular order.  Please append 
the new ones to the end to avoid shifting code churn like the above.

>    * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
>    * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
>    * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
> @@ -2802,6 +2802,7 @@ union bpf_attr {
>    * 		This helper actually implements a subset of **getsockopt()**.
>    * 		It supports the following *level*\ s:
>    *
> + * 		* **SOL_SOCKET**, which supports *optname* **SO_REUSEPORT**.

For bpf_getsockopt(), it supports all optnames in bpf_setsockopt() with a few 
exceptions.  The exceptions should be the TCP_BPF_* which is Set only.  The 
TCP_SAVED_SYNC is Get only.  Please check.

The doc for bpf_getsockopt() could be simplified to "... the same set of 
bpf_setsockopt's optnames is supported.  The exceptions are... TCP_BPF_* which 
is bpf_setsockopt() only.... TCP_SAVED_SYNC is bpf_getsockopt() only..."

Please tag it as bpf-next and also v2 in the next revision:
Documentation/bpf/bpf_devel_QA.rst  (Q: How do I indicate which tree....)


