Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14A20AFE6
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFZKkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgFZKkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 06:40:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23663C08C5DB
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 03:40:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so2648996lji.9
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yB42FIdlaXuGcBA5JHEjJpviYDlsFT6iBhIqQaCjtTA=;
        b=Ud1H9p6XGO0mXDpH4vRAGBFoB/eqqlXgQdkzqDD3wG1nYJRo6YakRjSYmzge8d3IUz
         mwIdjt3Dv+jiXadPbvVMCPg52rNFbbNBYDW8Zt8h/OgHQO0vqoVrlQW6QY3U9dR8D0I6
         4NIKD3ZJA5iAkoqDEuSKnibNjzbsQ+sj2I0K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=yB42FIdlaXuGcBA5JHEjJpviYDlsFT6iBhIqQaCjtTA=;
        b=GS9QrAoXcQ7jiLBmCW7qeTn+z7pZr4nkf1SrV7DIoSq/gB+Q2CUUuv2MvakcWUrZyD
         XFcoMILvp+w7ypju9qqF+vZLiG6AqCDt2WICHw7pTtOQhY9Hu+Si5Xcs5a4cFWwB4wHZ
         sziaVfu3mMmGuxWBL3IjYCfDCioWTSvEVpOLCkisORZM+24gCYUxAnGNe/crZ5Cvlo6k
         Dgco/sH4vPCFK7+99DQjQuETT+kHdCZw9bFZ6lBIlbHvxKNatqPvjBtvB4E/AUlMVui8
         9/1M+BYEowV5719YuZADcLGIpAMrOyN86hvGbQBCBHiBHxkxVXeA4hZwgIwNa+WtTt61
         tfwQ==
X-Gm-Message-State: AOAM533nBgJxbxnOD0VWwB0FkHLjzkMx4WhApKD0rQXWrX0IHWz0lPBX
        vj/MZCboKXepF5dZUyNB/t+NRg==
X-Google-Smtp-Source: ABdhPJwbSNs8Dd+VNp9wiaxQWPJSM7GoaiYqRDDe7+akgUu9u952VEoB7wWN+UwKAfjpzlsW/6SzSg==
X-Received: by 2002:a2e:9a09:: with SMTP id o9mr1080190lji.323.1593168008344;
        Fri, 26 Jun 2020 03:40:08 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 193sm7805655lfa.90.2020.06.26.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 03:40:07 -0700 (PDT)
References: <20200625141357.910330-1-jakub@cloudflare.com> <20200625141357.910330-3-jakub@cloudflare.com> <20200626054105.rpz6py7jqc34vzyl@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 2/4] bpf, netns: Keep attached programs in bpf_prog_array
In-reply-to: <20200626054105.rpz6py7jqc34vzyl@kafai-mbp.dhcp.thefacebook.com>
Date:   Fri, 26 Jun 2020 12:40:06 +0200
Message-ID: <87h7uym7p5.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 26, 2020 at 07:41 AM CEST, Martin KaFai Lau wrote:
> On Thu, Jun 25, 2020 at 04:13:55PM +0200, Jakub Sitnicki wrote:
>> Prepare for having multi-prog attachments for new netns attach types by
>> storing programs to run in a bpf_prog_array, which is well suited for
>> iterating over programs and running them in sequence.
>>
>> After this change bpf(PROG_QUERY) may block to allocate memory in
>> bpf_prog_array_copy_to_user() for collected program IDs. This forces a
>> change in how we protect access to the attached program in the query
>> callback. Because bpf_prog_array_copy_to_user() can sleep, we switch from
>> an RCU read lock to holding a mutex that serializes updaters.
>>
>> Because we allow only one BPF flow_dissector program to be attached to
>> netns at all times, the bpf_prog_array pointed by net->bpf.run_array is
>> always either detached (null) or one element long.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/net/netns/bpf.h    |   5 +-
>>  kernel/bpf/net_namespace.c | 120 +++++++++++++++++++++++++------------
>>  net/core/flow_dissector.c  |  19 +++---
>>  3 files changed, 96 insertions(+), 48 deletions(-)
>>
>> diff --git a/include/net/netns/bpf.h b/include/net/netns/bpf.h
>> index a8dce2a380c8..a5015bda9979 100644
>> --- a/include/net/netns/bpf.h
>> +++ b/include/net/netns/bpf.h
>> @@ -9,9 +9,12 @@
>>  #include <linux/bpf-netns.h>
>>
>>  struct bpf_prog;
>> +struct bpf_prog_array;
>>
>>  struct netns_bpf {
>> -	struct bpf_prog __rcu *progs[MAX_NETNS_BPF_ATTACH_TYPE];
>> +	/* Array of programs to run compiled from progs or links */
>> +	struct bpf_prog_array __rcu *run_array[MAX_NETNS_BPF_ATTACH_TYPE];
>> +	struct bpf_prog *progs[MAX_NETNS_BPF_ATTACH_TYPE];
>>  	struct bpf_link *links[MAX_NETNS_BPF_ATTACH_TYPE];
> With the new run_array, I think the "*progs[]" is not needed.
> It seems the original "*progs[]" is only used to tell
> if it is in the prog_attach mode or the newer link mode.
> There is other ways to do that.
>
> It is something to think about when there is more clarity on how
> multi netns prog will look like in the next set.

Having just the run_array without *progs[] is something I've tried
initially but ended up rewriting it. The end result was confusing to me.
I couldn't convince myself to sign off on it and present it.

Adding back the pointer to bpf_prog was counterintutivive, because it is
wasteful, but it actually made the code readable.

Best I can articulate why it didn't work out great (should have tagged
the branch...) is that without *progs[] the run_array holds bpf_prog
pointers sometimes with ref-count on the prog (old mode), and sometimes
without one (new mode). This mixed state manifests itself mostly on
netns teardown, where we need to access the prog_array to put the prog,
but only if we're not using links.

Then again, perhaps I simply messsed up the code back then, and it
deserves another shot. Either way, getting rid of *progs[] is a
potential optimization.

[...]
