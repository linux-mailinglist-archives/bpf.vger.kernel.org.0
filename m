Return-Path: <bpf+bounces-8083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABC780FA2
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBD2821F3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9F7198B7;
	Fri, 18 Aug 2023 15:55:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B8171AF
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:54:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316C2722
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yn274hMHRMAASrrzggxZXWE/R6ZCVm2wRval78WX0ks=; b=UbngDWRysE5TB0+kB3ySA3nZRU
	bLqjSLIX/AOUxYIR914B2c9qKRpUVdRBhi6fBlPFpsTWabHDWmzIbiXOuiwjvv72B5iuoWyL3SHW2
	MCLy3ZzaZtplF+zeZhFuO6wOU/XNsni3pckeSZgXvacaSbOS4Sbwk67IM3SbswAqdewZzhTBFmV55
	5kbaBzgujOu6fc2fG6FQRq2DuCESjwiLZdo8ez/09XyF3TcjBT7xFzcRG8I4MH/Xgl4Ckpl60lpB+
	M75x9r7t8X1KLo1uQdX/1IEgXpNO00nc1RyIKOF0am3lu16vF5ijT3lBkKVvCWteoAXQPXhnPSqrd
	Qa39STZQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX1oO-000Nqy-3V; Fri, 18 Aug 2023 17:54:55 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX1oN-0001sx-DH; Fri, 18 Aug 2023 17:54:55 +0200
Subject: Re: [PATCH bpf-next 15/15] bpf: Mark
 BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172928.1373311-1-yonghong.song@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3adfd28e-f4ba-cab5-2204-fa0342a53de9@iogearbox.net>
Date: Fri, 18 Aug 2023 17:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230814172928.1373311-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27004/Fri Aug 18 09:41:49 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/23 7:29 PM, Yonghong Song wrote:
> Now 'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE + local percpu ptr'
> can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
> and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   include/uapi/linux/bpf.h       | 9 ++++++++-
>   tools/include/uapi/linux/bpf.h | 9 ++++++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21deb46f49f..5d1bb6b42ea2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -932,7 +932,14 @@ enum bpf_map_type {
>   	 */
>   	BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>   	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> -	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
> +	/* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
> +	 * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
> +	 * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> +	 * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> +	 * deprecated.
> +	 */
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>   	BPF_MAP_TYPE_QUEUE,
>   	BPF_MAP_TYPE_STACK,
>   	BPF_MAP_TYPE_SK_STORAGE,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d21deb46f49f..5d1bb6b42ea2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -932,7 +932,14 @@ enum bpf_map_type {
>   	 */
>   	BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>   	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> -	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
> +	/* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
> +	 * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
> +	 * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> +	 * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> +	 * deprecated.
> +	 */
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,

This breaks bpftool tests in BPF CI, presumably it thinks doc is missing here:

   [...]
   bpftool_checks - Running bpftool checks...
   Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type) and /tmp/work/bpf/bpf/tools/bpf/bpftool/map.c (do_help() TYPE): {'percpu_cgroup_storage_deprecated', 'percpu_cgroup_storage'}
   Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type) and /tmp/work/bpf/bpf/tools/bpf/bpftool/Documentation/bpftool-map.rst (TYPE): {'percpu_cgroup_storage_deprecated', 'percpu_cgroup_storage'}
   bpftool checks returned 1.
   [...]

