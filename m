Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686093C63B4
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhGLT3I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:29:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:37248 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbhGLT3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 15:29:08 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1m31ZK-0001Cd-5q; Mon, 12 Jul 2021 21:26:18 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1m31ZJ-000DDs-V5; Mon, 12 Jul 2021 21:26:17 +0200
Subject: Re: [PATCH bpf-next v3] libbpf: fix compilation errors on ubuntu
 16.04
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20210712192055.2547468-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <de4d44a7-32a9-e558-3c42-ed983f355320@iogearbox.net>
Date:   Mon, 12 Jul 2021 21:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210712192055.2547468-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26229/Mon Jul 12 13:09:43 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/12/21 9:20 PM, Yonghong Song wrote:
> libbpf is used as a submodule in bcc.
> When importing latest libbpf repo in bcc, I observed the
> following compilation errors when compiling on ubuntu 16.04.
>    .../netlink.c:416:23: error: ‘TC_H_CLSACT’ undeclared (first use in this function)
>       *parent = TC_H_MAKE(TC_H_CLSACT,
>                           ^
>    .../netlink.c:418:9: error: ‘TC_H_MIN_INGRESS’ undeclared (first use in this function)
>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>             ^
>    .../netlink.c:418:28: error: ‘TC_H_MIN_EGRESS’ undeclared (first use in this function)
>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>                                ^
>    .../netlink.c: In function ‘__get_tc_info’:
>    .../netlink.c:522:11: error: ‘TCA_BPF_ID’ undeclared (first use in this function)
>      if (!tbb[TCA_BPF_ID])
>               ^
> 
> In ubuntu 16.04, TCA_BPF_* enumerator looks like below
>    enum {
> 	TCA_BPF_UNSPEC,
> 	TCA_BPF_ACT,
> 	...
> 	TCA_BPF_NAME,
> 	TCA_BPF_FLAGS,
> 	__TCA_BPF_MAX,
>    };
>    #define TCA_BPF_MAX	(__TCA_BPF_MAX - 1)
> while in latest bpf-next, the enumerator looks like
>    enum {
> 	TCA_BPF_UNSPEC,
> 	...
> 	TCA_BPF_FLAGS,
> 	TCA_BPF_FLAGS_GEN,
> 	TCA_BPF_TAG,
> 	TCA_BPF_ID,
> 	__TCA_BPF_MAX,
>    };
> 
> In this patch, TCA_BPF_ID is defined as a macro with proper value and this
> works regardless of whether TCA_BPF_ID is defined in uapi header or not.
> TCA_BPF_MAX is also adjusted in a similar way.
> 
> Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/lib/bpf/netlink.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> Changelog:
>    v2 -> v3:
>      - define/redefine TCA_BPF_MAX based on latest uapi header.
>        this enables to remove the v2 check "TCA_BPF_MAX < TCA_BPF_ID"
>        in __get_tc_info() which may cause -EOPNOTSUPP error
>        if the library is compiled in old system and used in
>        newer system.
>        
>    v1 -> v2:
>      - gcc 8.3 doesn't like macro condition
>          (__TCA_BPF_MAX - 1) <= 10
>        where __TCA_BPF_MAX is an enumerator value.
>        So define TCA_BPF_ID macro without macro condition.
> 
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 39f25e09b51e..37cb6b50f4b3 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -22,6 +22,29 @@
>   #define SOL_NETLINK 270
>   #endif
>   
> +#ifndef TC_H_CLSACT
> +#define TC_H_CLSACT TC_H_INGRESS
> +#endif
> +
> +#ifndef TC_H_MIN_INGRESS
> +#define TC_H_MIN_INGRESS 0xFFF2U
> +#endif
> +
> +#ifndef TC_H_MIN_EGRESS
> +#define TC_H_MIN_EGRESS 0xFFF3U
> +#endif
> +
> +/* TCA_BPF_ID is an enumerator value in uapi/linux/pkt_cls.h.
> + * Declare it as a macro here so old system can still work
> + * without TCA_BPF_ID defined in pkt_cls.h.
> + */
> +#define TCA_BPF_ID 11
> +
> +#ifdef TCA_BPF_MAX
> +#undef TCA_BPF_MAX
> +#endif
> +#define TCA_BPF_MAX 11
> +
>   typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nlattr **tb);
>   
>   typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlmsg_t,
> 

See 49a249c38726 ("tools/bpftool: copy a few net uapi headers to tools directory").
If this is not included from tools/lib/bpf/ then it would need fixing from Makefile
side.

Thanks,
Daniel
