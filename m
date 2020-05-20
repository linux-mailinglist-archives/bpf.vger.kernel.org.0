Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8515D1DBBB4
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETRkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgETRkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 13:40:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D3C061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 10:40:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 132so2502841ybc.22
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JjuT0BvlfRc0YWDoJydhmiVNBxtWkNF7rv8/0zwekGs=;
        b=jYxxD4HE3SIJHytWf1LqVAfz5AsPvv3s0y4taplmDHZw33iS5wQ1zrCsTPYlpE+JNE
         Qrq0mEjjtx/IAjaynJ+xMMakXgtc7D/iaB46h8SfUJT4dQMR2q4lhuMWWdR165IuUvKV
         FiwjjHjsEMtpVhUSS7BqVJirH42j7ILQpU3w0Tkblt2iaJMF1YCel8Jb6SeqmGtNyF84
         uSriUkeuVCgWez2YdK81I9LkinvL+JIciVkCsgfHvsH+ijf/NwlKRUh0Gqrs4Mw5GZuE
         hB0FLcX/L916tvk/GqniEGkVQAA1sH34dFOIyhUmiRXyXdRxflI1GZCc1dpY7r+HzxJi
         VeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JjuT0BvlfRc0YWDoJydhmiVNBxtWkNF7rv8/0zwekGs=;
        b=Mc50GDGMSSJ9/DpHt3voQFfkn7N/spAumCHzEXnjNBO0MkBwdobpnFcYAAB9DchCPx
         yTitJAWa3EI1w1hisWTqffyvl/SmNJZQb0VbcodyMf3R0Na7gqIi2TBrU2JT5puhwxey
         9LRQMcAyeXgG44NgK7w4hVQKxCCoTvDo3uDFm78tViN6AbdAJQE+mHjtpNnfLeKefWAz
         rCCVMwrCLI+10U+g4aMqdTUB9hKIivgSgZfDaAuH8QAPnvBvqQ9y4jzNTuVzDlII2hZK
         GmcFVAYmSROF5QgqDPsyUYljnCfru9DCZWr+mvoVuka24gwTN2sOWpfuXGvSk8WjcxC/
         q+tw==
X-Gm-Message-State: AOAM533wmMLVLd9C3vJsBFsnruYCH07Q+3I58inuFGd/bxguRGKN7tOp
        PxPL080jh6TbervxIr5LPpMu7qY=
X-Google-Smtp-Source: ABdhPJx8JbJfndxuwxbMxlZu3Iw23RmY+6ZflbIIs0uhSYR72FyK3YGgGVxF3foQcQavt2WiMFZh7Q0=
X-Received: by 2002:a25:ba8f:: with SMTP id s15mr8858832ybg.34.1589996403329;
 Wed, 20 May 2020 10:40:03 -0700 (PDT)
Date:   Wed, 20 May 2020 10:40:00 -0700
In-Reply-To: <20200520172258.551075-1-jakub@cloudflare.com>
Message-Id: <20200520174000.GA49942@google.com>
Mime-Version: 1.0
References: <20200520172258.551075-1-jakub@cloudflare.com>
Subject: Re: [PATCH bpf] flow_dissector: Drop BPF flow dissector prog ref on
 netns cleanup
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/20, Jakub Sitnicki wrote:
> When attaching a flow dissector program to a network namespace with
> bpf(BPF_PROG_ATTACH, ...) we grab a reference to bpf_prog.

> If netns gets destroyed while a flow dissector is still attached, and  
> there
> are no other references to the prog, we leak the reference and the program
> remains loaded.

> Leak can be reproduced by running flow dissector tests from selftests/bpf:

>    # bpftool prog list
>    # ./test_flow_dissector.sh
>    ...
>    selftests: test_flow_dissector [PASS]
>    # bpftool prog list
>    4: flow_dissector  name _dissect  tag e314084d332a5338  gpl
>            loaded_at 2020-05-20T18:50:53+0200  uid 0
>            xlated 552B  jited 355B  memlock 4096B  map_ids 3,4
>            btf_id 4
>    #

> Fix it by detaching the flow dissector program when netns is going away.

> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

> Discovered while working on bpf_link support for netns-attached progs.
> Looks like bpf tree material so pushing it out separately.
Oh, good catch!

> -jkbs

>   net/core/flow_dissector.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)

> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 3eff84824c8b..b6179cd20158 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -179,6 +179,27 @@ int skb_flow_dissector_bpf_prog_detach(const union  
> bpf_attr *attr)
>   	return 0;
>   }

> +static void __net_exit flow_dissector_pernet_pre_exit(struct net *net)
> +{
> +	struct bpf_prog *attached;
> +
> +	/* We don't lock the update-side because there are no
> +	 * references left to this netns when we get called. Hence
> +	 * there can be no attach/detach in progress.
> +	 */
> +	rcu_read_lock();
> +	attached = rcu_dereference(net->flow_dissector_prog);
> +	if (attached) {
> +		RCU_INIT_POINTER(net->flow_dissector_prog, NULL);
> +		bpf_prog_put(attached);
> +	}
> +	rcu_read_unlock();
> +}
I wonder, should we instead refactor existing
skb_flow_dissector_bpf_prog_detach to accept netns (instead of attr)
can call that here? Instead of reimplementing it (I don't think we
care about mutex lock/unlock efficiency here?). Thoughts?
