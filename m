Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856E38B960
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhETWJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 18:09:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:58452 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhETWJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 18:09:08 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ljqpU-000Dpe-U0; Fri, 21 May 2021 00:07:44 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ljqpU-000Wyk-QB; Fri, 21 May 2021 00:07:44 +0200
Subject: Re: [PATCH bpf v4 1/2] bpf: Set mac_len in bpf_skb_change_head
To:     Jussi Maki <joamaki@gmail.com>, bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210519154743.2554771-1-joamaki@gmail.com>
 <20210519154743.2554771-2-joamaki@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <15663d70-b984-28a6-9326-f0711f11e423@iogearbox.net>
Date:   Fri, 21 May 2021 00:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210519154743.2554771-2-joamaki@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26176/Thu May 20 13:14:29 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/19/21 5:47 PM, Jussi Maki wrote:
> The skb_change_head() helper did not set "skb->mac_len", which is
> problematic when it's used in combination with skb_redirect_peer().
> Without it, redirecting a packet from a L3 device such as wireguard to
> the veth peer device will cause skb->data to point to the middle of the
> IP header on entry to tcp_v4_rcv() since the L2 header is not pulled
> correctly due to mac_len=0.
> 
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Signed-off-by: Jussi Maki <joamaki@gmail.com>

Took this one in, the selftest needs a rebase since it doesn't apply to
bpf. Pls fix and resubmit 2/2, thanks.
