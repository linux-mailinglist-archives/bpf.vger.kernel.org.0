Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492B29E15E
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfH0IAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 04:00:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:49752 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbfH0IAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 04:00:42 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i2WP7-0004I7-4I; Tue, 27 Aug 2019 10:00:37 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i2WP6-000MiT-VI; Tue, 27 Aug 2019 10:00:36 +0200
Subject: Re: [bpf, lru] 107e215c29: kernel_selftests.bpf.test_lru_map.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, bpf@vger.kernel.org
References: <20190827002724.GC22771@shao2-debian>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f418599-b959-30c5-657e-ade16c0f62b6@iogearbox.net>
Date:   Tue, 27 Aug 2019 10:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190827002724.GC22771@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25553/Mon Aug 26 10:32:22 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/19 2:27 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 107e215c2962c00c79351b4bfc2d3c0fe7df50f6 ("bpf, lru: avoid messing with eviction heuristics upon syscall lookup")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y

That is expected, the fix has been backported to 4.19, but without the corresponding
BPF kselftest changes. The latter has way too much churn to be a reasonable candidate
for stable kernels.

Thanks,
Daniel
