Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599603FBF06
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhH3WgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 18:36:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:58092 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbhH3WgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 18:36:22 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mKpPF-0002sE-Ci; Tue, 31 Aug 2021 00:05:29 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mKpPF-000KyG-6y; Tue, 31 Aug 2021 00:05:29 +0200
Subject: Re: [PATCH bpf-next v2] bpf testing: permit ingress_ifindex in
 bpf_prog_test_run_xattr
To:     Neil Spring <ntspring@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
References: <20210828011437.2917851-1-ntspring@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6db32cd5-8285-63bc-6a0a-60b6bb09dae8@iogearbox.net>
Date:   Tue, 31 Aug 2021 00:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210828011437.2917851-1-ntspring@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26279/Mon Aug 30 10:22:08 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/21 3:14 AM, Neil Spring wrote:
> bpf_prog_test_run_xattr takes a struct __sk_buff, but did not permit
> that __skbuff to include an nonzero ingress_ifindex.
> 
> This patch updates to allow ingress_ifindex, convert the __sk_buff field to
> sk_buff (skb_iif) and back, and test that the value is present from
> tested bpf.  The test sets an unlikely distinct value for ingress_ifindex
> (11) from ifindex (1), but that seems in keeping with the rest of the
> synthetic fields.
> 
> Adding this support allows testing BPF that operates differently on
> incoming and outgoing skbs by discriminating on this field.
> 
> Signed-off-by: Neil Spring <ntspring@fb.com>

This triggers CI test suite failure, pls double check and fix:

   [...]
   test_skb_ctx:PASS:load 0 nsec
   test_skb_ctx:PASS:ctx_size_in 0 nsec
   test_skb_ctx:PASS:ctx_size_out 0 nsec
   test_skb_ctx:PASS:len 0 nsec
   test_skb_ctx:PASS:tc_index 0 nsec
   test_skb_ctx:PASS:hash 0 nsec
   test_skb_ctx:PASS:sk 0 nsec
   test_skb_ctx:PASS:run 146200 nsec
   test_skb_ctx:PASS:ctx_size_out 146200 nsec
   test_skb_ctx:PASS:ctx_out_cb 146200 nsec
   test_skb_ctx:PASS:ctx_out_cb 146200 nsec
   test_skb_ctx:PASS:ctx_out_cb 146200 nsec
   test_skb_ctx:PASS:ctx_out_cb 146200 nsec
   test_skb_ctx:PASS:ctx_out_cb 146200 nsec
   test_skb_ctx:PASS:ctx_out_priority 146200 nsec
   test_skb_ctx:PASS:ctx_out_ifindex 146200 nsec
   test_skb_ctx:FAIL:ctx_out_ifindex skb->ifindex == 1, expected 11
   test_skb_ctx:PASS:ctx_out_tstamp 146200 nsec
   test_skb_ctx:PASS:ctx_out_mark 146200 nsec
   #111 skb_ctx:FAIL
   [...]

https://github.com/kernel-patches/bpf/runs/3466106681?check_suite_focus=true

Thanks,
Daniel
