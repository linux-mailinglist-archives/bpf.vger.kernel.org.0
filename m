Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC2C9964
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfJCH77 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 3 Oct 2019 03:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfJCH77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 03:59:59 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A7DF81F11
        for <bpf@vger.kernel.org>; Thu,  3 Oct 2019 07:59:58 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id i18so573992ljg.14
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 00:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gXdQCjb3mea8fpG77BjuytGSpJeQzv52OWQdMaO0bp4=;
        b=j5eFBGDxDgePUzi/502YRaJGu1SG2fP6q2KRxSHfCdUPMBybWDQ3sWHoHkpTZ9wghW
         q95+HNLyniCJL4NbJCvroBU2X01kf79ubzt+Qslzlsn9MfLsySuWfpuk1WqldEiM3iqt
         2gOHXtXSEYQg9MpqagEBf4JqpqlV570ncad8RrxKixxL248dvxxu6114qVKVLov+3JGQ
         XDA57PFPwvNgtxXi+aeUbLeF/1kPW3Avgo33ojWbVDmFdjl1MIggkqn2sgqLJ96Fb+cZ
         WIKJ5ME20WL0cSiFBYF454cuvZCxWDJ7By6rer1Gt8Ec7s7+PMEc2e7UdLtj83iqNRv/
         pd8A==
X-Gm-Message-State: APjAAAUihyxyJFUSsaxqqRTZck4MORHPi8zHf0NoyLGO++s7ksN+k+1e
        fj4WI7VDYp3VbEcgWm75+6q0AD98cNOMjxLl3rP0wgw2KOcJ9gUMlJ1E0hyMl6xgS+tJrOSo/z8
        zSjPOu1UfS8bo
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2761600ljj.32.1570089597056;
        Thu, 03 Oct 2019 00:59:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyL/zkT7nLosstv1PXuGpf7DcJnRec3jJ8K/GzW/MA84fty/Inqd7Xwijou2R7W7aoqLnUkQQ==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2761583ljj.32.1570089596863;
        Thu, 03 Oct 2019 00:59:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z14sm362927ljz.10.2019.10.03.00.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 00:59:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8F3DA18063D; Thu,  3 Oct 2019 09:59:55 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/9] xdp: Support multiple programs on a single interface through chain calls
In-Reply-To: <B1372BF2-E0A2-4D01-B012-181B108CF994@fb.com>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1> <E7319D69-6450-4BC3-97B1-134B420298FF@fb.com> <87tv8rq7e2.fsf@toke.dk> <B1372BF2-E0A2-4D01-B012-181B108CF994@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Oct 2019 09:59:55 +0200
Message-ID: <87a7aiqmx0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

>> On Oct 2, 2019, at 12:23 PM, Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> 
>> Song Liu <songliubraving@fb.com> writes:
>> 
>>>> On Oct 2, 2019, at 6:30 AM, Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>> 
>>>> This series adds support for executing multiple XDP programs on a single
>>>> interface in sequence, through the use of chain calls, as discussed at the Linux
>>>> Plumbers Conference last month:
>>>> 
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__linuxplumbersconf.org_event_4_contributions_460_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=YXqqHTC51zXBviPBEk55y-fQjFQwcXWFlH0IoOqm2KU&s=NF4w3eSPmNhSpJr1-0FLqqlqfgEV8gsCQb9YqWQ9p-k&e= 
>>>> 
>>>> # HIGH-LEVEL IDEA
>>>> 
>>>> The basic idea is to express the chain call sequence through a special map type,
>>>> which contains a mapping from a (program, return code) tuple to another program
>>>> to run in next in the sequence. Userspace can populate this map to express
>>>> arbitrary call sequences, and update the sequence by updating or replacing the
>>>> map.
>>>> 
>>>> The actual execution of the program sequence is done in bpf_prog_run_xdp(),
>>>> which will lookup the chain sequence map, and if found, will loop through calls
>>>> to BPF_PROG_RUN, looking up the next XDP program in the sequence based on the
>>>> previous program ID and return code.
>>>> 
>>>> An XDP chain call map can be installed on an interface by means of a new netlink
>>>> attribute containing an fd pointing to a chain call map. This can be supplied
>>>> along with the XDP prog fd, so that a chain map is always installed together
>>>> with an XDP program.
>>> 
>>> Interesting work!
>>> 
>>> Quick question: can we achieve the same by adding a "retval to
>>> call_tail_next" map to each program?
>> 
>> Hmm, that's an interesting idea; I hadn't thought of that. As long as
>> that map can be manipulated outside of the program itself, it may work.
>> I wonder how complex it gets to modify the call sequence, though; say
>> you want to change A->B->C to A->C->B - how do you do that without
>> interrupting the sequence while you're modifying things? Or is it OK if
>> that is not possible?
>
> We can always load another copy of B and C, say D == B, and E == C. And 
> make it A->E->D. 

Yes, thinking some more about this I don't think it's actually a
problem. I'll go prototype something...
