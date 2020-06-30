Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2520F6E2
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbgF3OLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 10:11:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:46754 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgF3OLU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 10:11:20 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqGyl-0000qD-AR; Tue, 30 Jun 2020 16:11:19 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqGyl-000XWF-4U; Tue, 30 Jun 2020 16:11:19 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for getting
 number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hangbin Liu <haliu@redhat.com>
References: <159344647797.836609.7781883615056725815.stgit@firesoul>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6e7543fa-f496-a6d2-a6d5-70dff9f84090@iogearbox.net>
Date:   Tue, 30 Jun 2020 16:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <159344647797.836609.7781883615056725815.stgit@firesoul>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25858/Mon Jun 29 15:30:49 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/29/20 6:01 PM, Jesper Dangaard Brouer wrote:
> It can be practial to get the number of tests that test_progs
> contain.  This could for example be used to create a shell
> for-loop construct that runs the individual tests.
> 
> Like:
>   for N in $(seq 1 $(./test_progs -c)); do
>     ./test_progs -n $N 2>&1 > result_test_${N}.log &
>   done ; wait
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Applied, thanks!
