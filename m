Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73516CCA0A
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 20:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC1Sbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjC1Sbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 14:31:31 -0400
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [IPv6:2001:41d0:1004:224b::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A419A0
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:31:30 -0700 (PDT)
Message-ID: <1dab862d-7070-2529-ba88-22cf73b2126a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680028288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y28tvYq4TZpbwgBtKY3fsSmMyGufMkjleI7RFB0Fi8g=;
        b=igP9hH2I1beex6LjZaM6BDm/LMIPda9YnfVoLp8s2WEF6oZzeFqcWPl3REvIVBKnqtuckW
        clHbnKFV/E785++bt8v99+1AMCYQpJTJ7je8xNZtEd9ioZOyB3+IPJZ7yDXagRmW174YcD
        3l5z9JnvpkRdjiJMHT9XT5rXACpodYo=
Date:   Tue, 28 Mar 2023 11:31:24 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] selftests/bpf: test a BPF CC writing app_limited
Content-Language: en-US
To:     Yixin Shen <bobankhshen@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org
References: <20230328132035.50839-1-bobankhshen@gmail.com>
 <20230328132035.50839-3-bobankhshen@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230328132035.50839-3-bobankhshen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/28/23 6:20 AM, Yixin Shen wrote:
> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c
> new file mode 100644
> index 000000000000..de5c9b5045a1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define USEC_PER_SEC 1000000UL
> +
> +#define min(a, b) ((a) < (b) ? (a) : (b))
> +
> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
> +{
> +	return (struct tcp_sock *)sk;
> +}
> +
> +static inline unsigned int tcp_left_out(const struct tcp_sock *tp)
> +{
> +	return tp->sacked_out + tp->lost_out;
> +}
> +
> +static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
> +{
> +	return tp->packets_out - tcp_left_out(tp) + tp->retrans_out;
> +}
> +
> +SEC("struct_ops/write_app_limited_init")
> +void BPF_PROG(write_app_limited_init, struct sock *sk)
> +{
> +#ifdef ENABLE_ATOMICS_TESTS
> +	__sync_bool_compare_and_swap(&sk->sk_pacing_status, SK_PACING_NONE,
> +				     SK_PACING_NEEDED);
> +#else
> +	sk->sk_pacing_status = SK_PACING_NEEDED;
> +#endif
> +}
> +
> +SEC("struct_ops/write_app_limited_cong_control")
> +void BPF_PROG(write_app_limited_cong_control, struct sock *sk,
> +	      const struct rate_sample *rs)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	unsigned long rate =
> +		((tp->snd_cwnd * tp->mss_cache * USEC_PER_SEC) << 3) /
> +		(tp->srtt_us ?: 1U << 3);
> +	sk->sk_pacing_rate = min(rate, sk->sk_max_pacing_rate);
> +	tp->app_limited = (tp->delivered + tcp_packets_in_flight(tp)) ?: 1;

Please add this line testing tp->app_limited to tcp_ca_write_sk_pacing.c instead 
of creating a new bpf prog that looks pretty much the same.

Also tag the subject with bpf-next in v2.

Others lgtm.

