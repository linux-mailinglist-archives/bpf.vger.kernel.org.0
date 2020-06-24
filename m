Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386BC207564
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbgFXOOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 10:14:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:36596 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbgFXOOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 10:14:18 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jo6AH-0003Dn-Fs; Wed, 24 Jun 2020 16:14:13 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jo6AH-0004nF-6s; Wed, 24 Jun 2020 16:14:13 +0200
Subject: Re: [PATCH bpf-next v2 2/2] tools, bpftool: Define attach_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
References: <20200623104227.11435-1-tklauser@distanz.ch>
 <20200623104227.11435-3-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fcb30532-e596-1381-6a67-387b5eca6281@iogearbox.net>
Date:   Wed, 24 Jun 2020 16:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200623104227.11435-3-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25853/Wed Jun 24 15:13:27 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/23/20 12:42 PM, Tobias Klauser wrote:
> Define attach_type_name in common.c instead of main.h so it is only
> defined once. This leads to a slight decrease in the binary size of
> bpftool.
> 
> Before:
> 
>     text	   data	    bss	    dec	    hex	filename
>   399024	  11168	1573160	1983352	 1e4378	bpftool
> 
> After:
> 
>     text	   data	    bss	    dec	    hex	filename
>   398256	  10880	1573160	1982296	 1e3f58	bpftool
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> v2: move attach_type_name to common.c instead of cgroup.c as suggested
>      by Andrii
> 
>   tools/bpf/bpftool/common.c | 36 ++++++++++++++++++++++++++++++++++++
>   tools/bpf/bpftool/main.h   | 36 +-----------------------------------
>   2 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 6c864c3683fc..3c767dd114c7 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -29,6 +29,42 @@
>   #define BPF_FS_MAGIC		0xcafe4a11
>   #endif
>   
> +const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
> +	[BPF_CGROUP_INET_INGRESS] = "ingress",
> +	[BPF_CGROUP_INET_EGRESS] = "egress",
> +	[BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
> +	[BPF_CGROUP_SOCK_OPS] = "sock_ops",
> +	[BPF_CGROUP_DEVICE] = "device",
> +	[BPF_CGROUP_INET4_BIND] = "bind4",
> +	[BPF_CGROUP_INET6_BIND] = "bind6",
> +	[BPF_CGROUP_INET4_CONNECT] = "connect4",
> +	[BPF_CGROUP_INET6_CONNECT] = "connect6",
> +	[BPF_CGROUP_INET4_POST_BIND] = "post_bind4",
> +	[BPF_CGROUP_INET6_POST_BIND] = "post_bind6",
> +	[BPF_CGROUP_INET4_GETPEERNAME] = "getpeername4",
> +	[BPF_CGROUP_INET6_GETPEERNAME] = "getpeername6",
> +	[BPF_CGROUP_INET4_GETSOCKNAME] = "getsockname4",
> +	[BPF_CGROUP_INET6_GETSOCKNAME] = "getsockname6",
> +	[BPF_CGROUP_UDP4_SENDMSG] = "sendmsg4",
> +	[BPF_CGROUP_UDP6_SENDMSG] = "sendmsg6",
> +	[BPF_CGROUP_SYSCTL] = "sysctl",
> +	[BPF_CGROUP_UDP4_RECVMSG] = "recvmsg4",
> +	[BPF_CGROUP_UDP6_RECVMSG] = "recvmsg6",
> +	[BPF_CGROUP_GETSOCKOPT] = "getsockopt",
> +	[BPF_CGROUP_SETSOCKOPT] = "setsockopt",
> +
> +	[BPF_SK_SKB_STREAM_PARSER] = "sk_skb_stream_parser",
> +	[BPF_SK_SKB_STREAM_VERDICT] = "sk_skb_stream_verdict",
> +	[BPF_SK_MSG_VERDICT] = "sk_msg_verdict",
> +	[BPF_LIRC_MODE2] = "lirc_mode2",
> +	[BPF_FLOW_DISSECTOR] = "flow_dissector",
> +	[BPF_TRACE_RAW_TP] = "raw_tp",
> +	[BPF_TRACE_FENTRY] = "fentry",
> +	[BPF_TRACE_FEXIT] = "fexit",
> +	[BPF_MODIFY_RETURN] = "mod_ret",
> +	[BPF_LSM_MAC] = "lsm_mac",

Just a small nit given we touch these here, could you properly align the strings
such that it looks similarly to prog_type_name[] one? That plus the typo fix that
Quentin mentioned, and it's good to go.

Thanks,
Daniel
