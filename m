Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB6391793
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhEZMmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 08:42:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:40206 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhEZMmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 08:42:14 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1llsq1-0005ZW-Fj; Wed, 26 May 2021 14:40:41 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1llsq1-0006E3-At; Wed, 26 May 2021 14:40:41 +0200
Subject: Re: [PATCH bpf-next 0/3] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>
References: <20210524220555.251473-1-zeffron@riotgames.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <19985175-cb2c-52f2-0c67-f8d3e22726c3@iogearbox.net>
Date:   Wed, 26 May 2021 14:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210524220555.251473-1-zeffron@riotgames.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26182/Wed May 26 13:07:18 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/21 12:05 AM, Zvi Effron wrote:
> This patchset add support for passing a xdp_md via ctx_in/ctx_out in bpf_attr
> for BPF_PROG_TEST_RUN of XDP programs.
> 
> Patch 1 adds initial support for passing XDP meta data in addition to packet
> data.
> 
> Patch 2 adds support for also specifying the ingress interface and rx queue.
> 
> Patch 3 adds selftests to ensure functionality is correct.
> 
> Zvi Effron (3):
>    bpf: support input xdp_md context in BPF_PROG_TEST_RUN
>    bpf: support specifying ingress via xdp_md context in
>      BPF_PROG_TEST_RUN
>    selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN

Looks like this series is consistently causing a NULL pointer deref in the BPF CI:

   - https://travis-ci.com/github/kernel-patches/bpf/builds/226936809
   - https://travis-ci.com/github/kernel-patches/bpf/builds/226909818

Other runs on top of latest bpf-next are fine though:

   - https://travis-ci.com/github/kernel-patches/bpf/builds/226936786

Please double check your series again and fix.

Thanks,
Daniel
