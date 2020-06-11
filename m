Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E51F69DC
	for <lists+bpf@lfdr.de>; Thu, 11 Jun 2020 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgFKOZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 10:25:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:57536 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFKOZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 10:25:22 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjO8t-00082Z-To; Thu, 11 Jun 2020 16:25:20 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjO8t-0006Nr-Ms; Thu, 11 Jun 2020 16:25:19 +0200
Subject: Re: [PATCH bpf v2 0/2] Fix bpf_skb_load_bytes_relative for
 cgroup_skb/egress
To:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1591812755.git.zhuyifei@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d12ca6f5-0980-90eb-7330-9b4803b4f955@iogearbox.net>
Date:   Thu, 11 Jun 2020 16:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1591812755.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25840/Thu Jun 11 14:52:31 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/20 8:41 PM, YiFei Zhu wrote:
> When cgroup_skb/egress triggers the MAC header is not set. On the other hand,
> load_bytes_relative unconditionally calls skb_mac_header which, when MC not
> set, returns a pointer after the tail pointer, breaking the logic even if the
> caller requested the NET header.
> 
> Fix is to conditionally use skb_mac_header or skb_network_header depending on
> the requested header, -EFAULT when the header is not set. Added a test that
> asserts during cgroup_skb/egress request for MAC header returns -EFAULT and
> request for NET header succeeds.
> 
> Updates since v1:
> * Reverted the bound condition check to account for bad offset parameter
>    larger than data length.
> * Add test asssertion for failure return code on the condition above.
> 
> YiFei Zhu (2):
>    net/filter: Permit reading NET in load_bytes_relative when MAC not set
>    selftests/bpf: Add cgroup_skb/egress test for load_bytes_relative
> 
>   net/core/filter.c                             | 16 +++--
>   .../bpf/prog_tests/load_bytes_relative.c      | 71 +++++++++++++++++++
>   .../selftests/bpf/progs/load_bytes_relative.c | 48 +++++++++++++
>   3 files changed, 128 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
>   create mode 100644 tools/testing/selftests/bpf/progs/load_bytes_relative.c
> 
> --
> 2.27.0
> 

Applied, thanks!
