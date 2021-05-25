Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA0390624
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhEYQEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 12:04:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:49382 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhEYQEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 12:04:51 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1llZWb-0003BR-37; Tue, 25 May 2021 18:03:21 +0200
Received: from [85.7.101.30] (helo=linux-2.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1llZWa-000NlF-Vn; Tue, 25 May 2021 18:03:21 +0200
Subject: Re: [PATCH bpf v5] selftests/bpf: Add test for l3 use of
 bpf_redirect_peer
To:     Jussi Maki <joamaki@gmail.com>, bpf@vger.kernel.org
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210525102955.2811090-1-joamaki@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <47f6801b-38f1-66f7-d64f-28f8d5423a1f@iogearbox.net>
Date:   Tue, 25 May 2021 18:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210525102955.2811090-1-joamaki@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26181/Tue May 25 13:17:38 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/21 12:29 PM, Jussi Maki wrote:
> Add a test case for using bpf_skb_change_head in combination with
> bpf_redirect_peer to redirect a packet from a L3 device to veth and back.
> 
> The test uses a BPF program that adds L2 headers to the packet coming
> from a L3 device and then calls bpf_redirect_peer to redirect the packet
> to a veth device. The test fails as skb->mac_len is not set properly and
> thus the ethernet headers are not properly skb_pull'd in cls_bpf_classify,
> causing tcp_v4_rcv to point the TCP header into middle of the IP header.
> 
> Signed-off-by: Jussi Maki <joamaki@gmail.com>

Applied, thanks!

[...]
> +void test_tc_redirect(void)
> +{
> +	pthread_t test_thread;
> +	int err;
> +
> +	/* Run the tests in their own thread to isolate the namespace changes
> +	 * so they do not affect the environment of other tests.
> +	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
> +	 */
> +	err = pthread_create(&test_thread, NULL, &test_tc_redirect_run_tests, NULL);
> +	if (ASSERT_OK(err, "pthread_create"))
> +		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
> +}
> +

Also fixed up the extra newline while applying.

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
