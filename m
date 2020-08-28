Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0442559BF
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgH1MBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 08:01:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:36850 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgH1MAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 08:00:40 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kBd3d-0005IW-FZ; Fri, 28 Aug 2020 14:00:37 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kBd3d-000SHh-8q; Fri, 28 Aug 2020 14:00:37 +0200
Subject: Re: [PATCH bpf] selftests/bpf: Fix massive output from test_maps
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ykaliuta@redhat.com, zsun@redhat.com, vkabatov@redhat.com
References: <159842985651.1050885.2154399297503372406.stgit@firesoul>
 <20200826102930.51486b11@carbon>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0d1a5e79-2f6a-69a0-3b6e-d1789636902e@iogearbox.net>
Date:   Fri, 28 Aug 2020 14:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200826102930.51486b11@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25912/Thu Aug 27 15:16:21 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/20 10:29 AM, Jesper Dangaard Brouer wrote:
> On Wed, 26 Aug 2020 10:17:36 +0200
> Jesper Dangaard Brouer <brouer@redhat.com> wrote:
> 
>> When stdout output from the selftests tool 'test_maps' gets redirected
>> into e.g file or pipe, then the output lines increase a lot (from 21
>> to 33949 lines).  This is caused by the printf that happens before the
>> fork() call, and there are user-space buffered printf data that seems
>> to be duplicated into the forked process.
>>
>> To fix this fflush() stdout before the fork loop in __run_parallel().
>>
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> Fixes: 1a97cf1fe503 ("selftests/bpf: speedup test_maps")
> 
> I forgot to add the fixes line to the patch, I hope patchwork[1] will
> pick it up for maintainers.

It won't but I've just added it manually. Applied, thanks!

> [1] http://patchwork.ozlabs.org/project/netdev/patch/159842985651.1050885.2154399297503372406.stgit@firesoul/
> 

