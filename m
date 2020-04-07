Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3267F1A18C1
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 01:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDGXoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 19:44:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:57744 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGXoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 19:44:54 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLxtk-0001Td-M8; Wed, 08 Apr 2020 01:44:52 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLxtk-000AzP-Dk; Wed, 08 Apr 2020 01:44:52 +0200
Subject: Re: [PATCH bpf 0/2] libbpf: Fix bpf_get_link_xdp_id flags handling
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, kernel-team@fb.com, toke@redhat.com
References: <cover.1586236080.git.rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ecc86032-c5e3-7ed0-8f8f-52c7b167b7d8@iogearbox.net>
Date:   Wed, 8 Apr 2020 01:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1586236080.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25775/Tue Apr  7 14:53:51 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/7/20 7:09 AM, Andrey Ignatov wrote:
> This patch set fixes bpf_get_link_xdp_id() behavior for non-zero flags and
> adds selftest that verifies the fix and can be used to reproduce the
> problem.
> 
> 
> Andrey Ignatov (2):
>    libbpf: Fix bpf_get_link_xdp_id flags handling
>    selftests/bpf: Add test for bpf_get_link_xdp_id
> 
>   tools/lib/bpf/netlink.c                       |  2 +-
>   .../selftests/bpf/prog_tests/xdp_info.c       | 68 +++++++++++++++++++
>   2 files changed, 69 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_info.c

LGTM, applied, thanks!
