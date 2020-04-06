Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7164E19FF12
	for <lists+bpf@lfdr.de>; Mon,  6 Apr 2020 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFUaw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Apr 2020 16:30:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:53188 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFUaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Apr 2020 16:30:52 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLYOQ-0002uT-5R; Mon, 06 Apr 2020 22:30:50 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLYOP-0003f1-Rk; Mon, 06 Apr 2020 22:30:49 +0200
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
To:     Roman Gushchin <guro@fb.com>, Odin Ugedal <odin@ugedal.com>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        Harish.Kasiviswanathan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200403175528.225990-1-odin@ugedal.com>
 <20200403223704.GA306670@carbon.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4264eb59-920e-20da-a256-23b6f0bbc95e@iogearbox.net>
Date:   Mon, 6 Apr 2020 22:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200403223704.GA306670@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25774/Mon Apr  6 14:53:25 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/4/20 12:37 AM, Roman Gushchin wrote:
> On Fri, Apr 03, 2020 at 07:55:28PM +0200, Odin Ugedal wrote:
>> Original cgroup v2 eBPF code for filtering device access made it
>> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
>> filtering. Change
>> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
>> reverted this, making it required to set it to y.
>>
>> Since the device filtering (and all the docs) for cgroup v2 is no longer
>> a "device controller" like it was in v1, someone might compile their
>> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
>> filter will not be invoked, and all processes will be allowed access
>> to all devices, no matter what the eBPF filter says.
>>
>> Signed-off-by: Odin Ugedal <odin@ugedal.com>
> 
> The patch makes perfect sense to me.
> 
> Acked-by: Roman Gushchin <guro@fb.com>

Tejun, I presume you'll pick this up (given the files this fix touches)?

Thanks,
Daniel
