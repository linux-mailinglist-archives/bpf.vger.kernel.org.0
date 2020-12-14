Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536FB2DA1EA
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503428AbgLNUqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 15:46:52 -0500
Received: from www62.your-server.de ([213.133.104.62]:33924 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503422AbgLNUqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 15:46:52 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1koujS-0008m6-GC; Mon, 14 Dec 2020 21:46:10 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1koujS-000Por-9g; Mon, 14 Dec 2020 21:46:10 +0100
Subject: Re: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20201214113812.305274-1-jackmanb@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f19112d6-7ee7-f685-b203-e0961a246b80@iogearbox.net>
Date:   Mon, 14 Dec 2020 21:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201214113812.305274-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26017/Mon Dec 14 15:33:39 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/14/20 12:38 PM, Brendan Jackman wrote:
> This provides a convenient perf ringbuf -> libbpf ringbuf migration
> path for users of external polling systems. It is analogous to
> perf_buffer__epoll_fd.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Difference from v1: Added entry to libbpf.map.
> 
>   tools/lib/bpf/libbpf.h   | 1 +
>   tools/lib/bpf/libbpf.map | 1 +
>   tools/lib/bpf/ringbuf.c  | 6 ++++++
>   3 files changed, 8 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6909ee81113a..cde07f64771e 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -536,6 +536,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   				ring_buffer_sample_fn sample_cb, void *ctx);
>   LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>   LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__epoll_fd(struct ring_buffer *rb);
> 
>   /* Perf buffer APIs */
>   struct perf_buffer;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7c4126542e2b..7be850271be6 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
>   		btf__new_split;
>   		xsk_setup_xdp_prog;
>   		xsk_socket__update_xskmap;
> +                ring_buffer__epoll_fd;

Fyi, this had a whitespace issue, Andrii fixed it up while applying.

>   } LIBBPF_0.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 5c6522c89af1..45a36648b403 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -282,3 +282,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>   	}
>   	return cnt < 0 ? -errno : res;
>   }
> +
> +/* Get an fd that can be used to sleep until data is available in the ring(s) */
> +int ring_buffer__epoll_fd(struct ring_buffer *rb)
> +{
> +	return rb->epoll_fd;
> +}
> 
> base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
> --
> 2.29.2.576.ga3fc446d84-goog
> 

