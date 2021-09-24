Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC6417CF5
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbhIXVVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 17:21:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:51344 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 17:21:40 -0400
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mTsc1-000EKG-KV; Fri, 24 Sep 2021 23:20:05 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mTsc1-000Cmh-E3; Fri, 24 Sep 2021 23:20:05 +0200
Subject: Re: [PATCH bpf 1/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc
 when called from interrupt
To:     Tejun Heo <tj@kernel.org>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org,
        bpf@vger.kernel.org,
        syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@google.com>
References: <fe51fd2101fe9df82750d0beb2772ef77ba06bcf.1632427246.git.daniel@iogearbox.net>
 <YU4JDMTCRJU38e4+@slm.duckdns.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <020b6abd-9ec5-b196-e019-969e43dfacfa@iogearbox.net>
Date:   Fri, 24 Sep 2021 23:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YU4JDMTCRJU38e4+@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26302/Fri Sep 24 11:04:11 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/24/21 7:21 PM, Tejun Heo wrote:
> On Thu, Sep 23, 2021 at 10:09:23PM +0200, Daniel Borkmann wrote:
>> If cgroup_sk_alloc() is called from interrupt context, then just assign the
>> root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
>> Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
>> on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path. Rather
>> than re-adding the NULL-test to the fast-path we can just assign it once from
>> cgroup_sk_alloc() given v1/v2 handling has been simplified.
> 
> I think you should explain why this is safe - ie. when do we hit the
> condition and leak the socket to the root cgroup and why is that okay?

I'll add it to the commit log. What I was trying to say is that before the
8520e224f547 fix, the cgroup_sk_alloc() would bail out and return early when
in_interrupt(), and in that case skcd->cgroup remained NULL. sock_cgroup_ptr()
had a NULL check for it in the old code where it says 'v ?: &cgrp_dfl_root.cgrp'
and I wonder given the !CONFIG_CGROUP_NET_PRIO && !CONFIG_CGROUP_NET_CLASSID
path doesn't have it, whether syzbot never tripped over it because it was not
testing with such config. From the repro [0], this is specific to old netrom
legacy code where RX handler nr_rx_frame() calls nr_make_new() which calls
sk_alloc() and therefore cgroup_sk_alloc() with in_interrupt() condition. Thus
the NULL skcd->cgroup, where it trips over on cgroup_sk_free() side [1]. I'm
certain you hit the same in netrom with mentioned configs off.

Thanks,
Daniel

   [0] https://syzkaller.appspot.com/x/repro.syz?x=12f2b28d300000
   [1] https://lkml.org/lkml/2021/9/17/1041
