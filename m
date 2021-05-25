Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC40390B0A
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEYVLG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhEYVLF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 17:11:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784DC061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 14:09:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g17so679430qtk.9
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nI4kZUTOS1fNW+k7/4fwjiqHfsrnG4/cylDak6TRdY=;
        b=DW+obGRoI8diCis3mj/ywVv4IfwdniZu2cj1Y3sGYe79cmpiQvPLLRlC0OCAmBu/s4
         2lik5p3AjxfG7jow/I+MGka4DZlms2jAWHMy08JxqVoKj5EgAO6PHJkaG4/3crSp/hgc
         cbvy2ndqd0rMV7QHnKmqr4kU57o9u6ca9NaDXSTpfSxJHWqRQVvJdEWaz5N/N1er+tPb
         2P8nUnMWAG3fteQ149lii3WMIsKiPQN+z2fmztb6/IIxeBUq1LxzykoStnrjdhYv7GcQ
         Pyv25VBjS9pbGPuFAsaGhrw06LEbb7EI4qDeS5RIwEsepZ7vpJdDjOPAj7HCASxxUtw+
         wTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nI4kZUTOS1fNW+k7/4fwjiqHfsrnG4/cylDak6TRdY=;
        b=Czaf81h+aJrz0nn4XOp+v8mdPfWNG20HY5Ktl8zAs73tDIJ3RnaSiqueZXslX+/SxP
         MTLEryfD4aLZdf0A7yebaCAQvmkhcQjEjqdXvI1AH8WO86ExBa/DbfxfZCx21OsSbMFB
         /2JD87oUI8zdOW+hk4otaCU8/D2mIWjP9AeSRatWrXEhwToFJR8kmeM3tfhVsbCt0HDJ
         5mTzAuDuQrLEIjgkJlyBH4rX55kt4mh/E0k2WtczTFfiFpa+AfASZm9AMllVzaW1iMOG
         O8Bani+Hr46mwR+qGyvOtw3z/dJu828uUcvNlz7/A89W2wHyrcd2tR+DO7QBd4taSNYp
         d4vw==
X-Gm-Message-State: AOAM532rfB3Hb8v0iXvJ811Hm1j2buy35Qs1+geDPhWC0xrXthiwwK5i
        J79+5XD2z3Trmt2a12mR6cIorw==
X-Google-Smtp-Source: ABdhPJweKUzdyp7bKCjYTxCLK9SAyCxc2Hg7va+4IbEcMTEeOkRy8MpfyeXlQCPfWrQ9+02aWitQaA==
X-Received: by 2002:ac8:5f8f:: with SMTP id j15mr34147331qta.116.1621976973645;
        Tue, 25 May 2021 14:09:33 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-211.dsl.bell.ca. [184.148.47.211])
        by smtp.googlemail.com with ESMTPSA id g6sm232274qkm.120.2021.05.25.14.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 14:09:33 -0700 (PDT)
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Pedro Tammela <pctammela@gmail.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <CAM_iQpWDgVTCnP3xC3=z7WCH05oDUuqxrw2OjjUC69rjSQG0qQ@mail.gmail.com>
 <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
 <CAM_iQpU-Cvpf-+9R0ZdZY+5Dv+stfodrH0MhvSgryv_tGiX7pA@mail.gmail.com>
 <CAM_iQpVYBNkjDeo+2CzD-qMnR4-2uW+QdMSf_7ohwr0NjgipaQ@mail.gmail.com>
 <CAADnVQJUHydpLwtj9hRWWNGx3bPbdk-+cQiSe3MDFQpwkKmkSw@mail.gmail.com>
 <bcbf76c3-34d4-d550-1648-02eda587ccd7@mojatatu.com>
 <CAADnVQLWj-=B2TfJp7HEsiUY3rqmd6-YMDAGdyL6RgZ=_b2CXg@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <27dae780-b66b-4ee9-cff1-a3257e42070e@mojatatu.com>
Date:   Tue, 25 May 2021 17:09:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQLWj-=B2TfJp7HEsiUY3rqmd6-YMDAGdyL6RgZ=_b2CXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-05-25 3:57 p.m., Alexei Starovoitov wrote:
> On Tue, May 25, 2021 at 12:35 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:

[..]
> The outcome of the last bpf office hours was a general agreement
> that we need new hooks in map update/delete operations
> (including auto-delete by LRU) that will trigger a bpf subprog.

This is certainly a useful feature (for other reasons as well).
Does this include create/update/delete issued from user space?

> It might look very similar to the timer callback that is part of this patch,
> but instead of being called by the timer the LRU logic will call it.
> This way the subprog can transfer the data stored in the
> about-to-be-deleted map element into some other map or pass
> to user space via ringbuf or do any other logic.
> 

The challenge we have in this case is LRU makes the decision
which entry to victimize. We do have some entries we want to
keep longer - even if they are not seeing a lot of activity.
You could just notify user space to re-add the entry but then
you have sync challenges.
The timers do provide us a way to implement custom GC.

So a question (which may have already been discussed),
assuming the following setup:
- 2 programs a) Ingress b) egress
- sharing a conntrack map which and said map pinned.
- a timer prog (with a map with just timers;
    even a single timer would be enough in some cases).

ingress and egress do std stuff like create/update
timer prog does the deletes. For simplicity sake assume
we just have one timer that does a foreach and iterates
all entries.

What happens when both ingress and egress are ejected?

cheers,
jamal
