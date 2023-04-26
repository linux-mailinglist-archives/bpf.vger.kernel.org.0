Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1C6EFD0C
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 00:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjDZWHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbjDZWH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 18:07:29 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE91BFC
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 15:07:28 -0700 (PDT)
Message-ID: <1879ff8d-87e2-6132-9b47-99e40af26d2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682546846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ovzg2cWWExNm8UXqjfcd7FaCtR2dp9C8p0k7ZLlD2Sg=;
        b=fKJwkI5gN5kdag/kndRBIcaYbzDH/nrhwpOgF5XiRB4WAcjQyoGEcG72hT7J6ZWhhk9Mew
        ZOczGxroEoAWutDpV1d2nC2DqjJg6bm4o9O/Yh7YLHhVQpMOqd0k2rFVoWRaryrQEZ3o6j
        KaonGRTjIN//8voXR0tYDEeMwN8jsu8=
Date:   Wed, 26 Apr 2023 15:07:24 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Allow read access to addr_len from
 cgroup sockaddr programs
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-4-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230421162718.440230-4-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/23 9:27 AM, Daan De Meyer wrote:
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's expose the sockaddr addrlen in bpf_sock_addr_kern. While not
> important for AF_INET or AF_INET6, the sockaddr length is important
> when working with AF_UNIX sockaddrs as the size of the sockaddr cannot
> be determined just from the address family or the sockaddr's contents.
> 
> __cgroup_bpf_run_filter_sock_addr() is modified to return the addr_len
> in preparation for adding unix socket support for which we'll need to
> return the modified address length.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   include/linux/bpf-cgroup.h | 73 +++++++++++++++++++-------------------
>   include/linux/filter.h     |  1 +
>   kernel/bpf/cgroup.c        | 16 +++++++--
>   net/ipv4/af_inet.c         |  8 ++---
>   net/ipv4/ping.c            |  8 ++++-
>   net/ipv4/tcp_ipv4.c        |  8 ++++-
>   net/ipv4/udp.c             | 17 ++++++---
>   net/ipv6/af_inet6.c        |  8 ++---
>   net/ipv6/ping.c            |  8 ++++-
>   net/ipv6/tcp_ipv6.c        |  8 ++++-
>   net/ipv6/udp.c             | 14 ++++++--
>   11 files changed, 111 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..f3f5adf3881f 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
>   
>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   				      struct sockaddr *uaddr,
> +				      u32 uaddrlen,

If the bpf_sock_addr_set() kfunc can only change the sin[6]_addr and unix_path 
(the comment in patch 5), the "u32 uaddrlen" can be changed to "u32 *uaddrlen" 
here. The new unix_path length can be passed back to af_unix.c in "*uaddrlen". 
The inet[6] code path can just pass NULL and most of the code churn in this 
patch will no longer be needed?

