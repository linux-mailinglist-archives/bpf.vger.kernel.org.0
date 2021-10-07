Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA00425E60
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhJGVCq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 17:02:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:35820 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJGVCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 17:02:44 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mYaVU-000BZX-A0; Thu, 07 Oct 2021 23:00:48 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mYaVU-000UsV-4s; Thu, 07 Oct 2021 23:00:48 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: remove SEC("version") from test
 progs
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20211007202319.1153540-1-davemarchevsky@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc18832d-5822-2c82-45b4-a2efca47b605@iogearbox.net>
Date:   Thu, 7 Oct 2021 23:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211007202319.1153540-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26315/Thu Oct  7 11:09:01 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/21 10:23 PM, Dave Marchevsky wrote:
> Since commit 6c4fc209fcf9d ("bpf: remove useless version check for prog
> load") these "version" sections, which result in bpf_attr.kern_version
> being set, have been unnecessary.
> 
> Remove them so that it's obvious to folks using selftests as a guide that
> "modern" BPF progs don't need this section.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c  | 1 -
>   tools/testing/selftests/bpf/progs/connect4_prog.c              | 1 -
>   tools/testing/selftests/bpf/progs/connect6_prog.c              | 1 -
>   tools/testing/selftests/bpf/progs/connect_force_port4.c        | 1 -
>   tools/testing/selftests/bpf/progs/connect_force_port6.c        | 1 -
>   tools/testing/selftests/bpf/progs/dev_cgroup.c                 | 1 -
>   tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c         | 1 -
>   tools/testing/selftests/bpf/progs/map_ptr_kern.c               | 1 -
>   tools/testing/selftests/bpf/progs/netcnt_prog.c                | 1 -
>   tools/testing/selftests/bpf/progs/sendmsg4_prog.c              | 1 -
>   tools/testing/selftests/bpf/progs/sendmsg6_prog.c              | 1 -
>   tools/testing/selftests/bpf/progs/sockmap_parse_prog.c         | 1 -
>   tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c       | 1 -
>   tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c       | 1 -
>   tools/testing/selftests/bpf/progs/sockopt_inherit.c            | 1 -
>   tools/testing/selftests/bpf/progs/tcp_rtt.c                    | 1 -
>   tools/testing/selftests/bpf/progs/test_btf_haskv.c             | 1 -
>   tools/testing/selftests/bpf/progs/test_btf_newkv.c             | 1 -
>   tools/testing/selftests/bpf/progs/test_btf_nokv.c              | 1 -
>   tools/testing/selftests/bpf/progs/test_l4lb.c                  | 1 -
>   tools/testing/selftests/bpf/progs/test_map_in_map.c            | 1 -
>   tools/testing/selftests/bpf/progs/test_pinning.c               | 1 -
>   tools/testing/selftests/bpf/progs/test_pinning_invalid.c       | 1 -
>   tools/testing/selftests/bpf/progs/test_pkt_access.c            | 1 -
>   tools/testing/selftests/bpf/progs/test_queue_stack_map.h       | 1 -
>   tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c | 1 -
>   tools/testing/selftests/bpf/progs/test_sk_lookup.c             | 1 -
>   tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c    | 1 -
>   tools/testing/selftests/bpf/progs/test_skb_ctx.c               | 1 -
>   tools/testing/selftests/bpf/progs/test_sockmap_kern.h          | 1 -
>   tools/testing/selftests/bpf/progs/test_sockmap_listen.c        | 1 -
>   tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c   | 1 -
>   tools/testing/selftests/bpf/progs/test_static_linked1.c        | 1 -
>   tools/testing/selftests/bpf/progs/test_static_linked2.c        | 1 -
>   tools/testing/selftests/bpf/progs/test_tcp_estats.c            | 1 -
>   tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c           | 1 -
>   tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c        | 1 -
>   tools/testing/selftests/bpf/progs/test_tracepoint.c            | 1 -
>   tools/testing/selftests/bpf/progs/test_tunnel_kern.c           | 1 -
>   tools/testing/selftests/bpf/progs/test_xdp.c                   | 1 -
>   tools/testing/selftests/bpf/progs/test_xdp_loop.c              | 1 -
>   tools/testing/selftests/bpf/progs/test_xdp_redirect.c          | 1 -
>   42 files changed, 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> index 3f757e30d7a0..88638315c582 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> @@ -14,7 +14,6 @@
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   
> -int _version SEC("version") = 1;
>   char _license[] SEC("license") = "GPL";
>   
>   __u16 g_serv_port = 0;
> diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
> index a943d394fd3a..cf432a527d49 100644
> --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> @@ -31,7 +31,6 @@
>   #define IFNAMSIZ 16
>   #endif
>   
> -int _version SEC("version") = 1;
>   

Overall looks good, small nit: please don't leave a double newline after the
removal (here and in other places).

>   __attribute__ ((noinline))
>   int do_bind(struct bpf_sock_addr *ctx)
