Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74007DBD42
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 07:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfJRFw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 01:52:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44928 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJRFw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 01:52:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so2710569pgd.11
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 22:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pUsP4iVbx83LE/6ZmfOpWeA2zOW+LAs43WV2RSNQIls=;
        b=QsumzAch+YfmdHj5zQ3PZ3WX3yVchZrTVT+LQZ9QGWnsnJ2Sh0vO554nvw11d2Imug
         53Bpfs4wO7ZtOINCSgEsKWnCesdX4NKBt7U1Mjy01e68zzbROA4Nbt0Onu3ePV1WDapr
         3Bh9Br6NNEMeePDC4n9u0L9tGjUsO4lz0I9KSBbPl7i4Zt6XDEuzWXKkeyk6Z/9Yc+5w
         RhCatnuWwPIKPxv7qhvyLnnwlRHYwJ1O1L45lorfV3D5O6JmQFX7rSmDEDDwaURHqRf/
         Qi6wucsCvmprWZHwm9kf4r35LPZsj0lNxBN44YmQ8TqbLc+cgkh2LcCjX4b5QA4Ul8+W
         9jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUsP4iVbx83LE/6ZmfOpWeA2zOW+LAs43WV2RSNQIls=;
        b=UxcLx6EwHvJv+qCUDHfnGeGhwcU2iP8/DvvBCP9zmVSQ5DvycSju719fhS3V9F3v2u
         xp5qswE2zF5WabQRc20BHhFe/jGFZqPsDs5A5OU+VjYu+a5bT091qMA8HtAmLWLTf0b6
         aqYn9eCvdEf1KtQutt8/BZp5q/JRArS23T01iImjLSxlN5NIR/cNAwjNXOt//pPR+Nk/
         4+jkydXuePZD7NfE5o6Vxy9BLWWTqkfbNz3cYTQmtzz7IZ5N82WDckGpPGTVbUEmmpSl
         UP3v4bpj5TEtkw0/gXtxt+hLKW8M5o64ZfIX2pdCrVVs50Bc/7I06yh4v7TS0TWCRC9q
         2YMw==
X-Gm-Message-State: APjAAAUc6En/dOjYMd2z7Cr8uJlmss8dNzdOHWg2D1xqCDTu/OyjRe5l
        3+4oiDGYjccG4wWWJP1ZJQA=
X-Google-Smtp-Source: APXvYqzRiv/MQMNzV+/c/DDAYx+VSG3zc/ttvIhLlyYMCpeGJt7MLJRtl9PVtGctzGmUmGnZ89M6Og==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr8782197pji.90.1571377947602;
        Thu, 17 Oct 2019 22:52:27 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::cfd0])
        by smtp.gmail.com with ESMTPSA id t125sm5964637pfc.80.2019.10.17.22.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:52:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 22:52:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home>
 <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
 <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 02:22:40AM +0200, Thomas Gleixner wrote:
> 
> But that also means any code which explcitely disables preemption or
> interrupts without taking a spin/rw lock can trigger the following issues:
> 
>   - Calling into code which requires to be preemtible/sleepable on RT
>     results in a might sleep splat.
> 
>   - Has in RT terms potentially unbound or undesired runtime length without
>     any chance for the scheduler to control it.

Much appreciate the explanation. Few more questions:
There is a ton of kernel code that does preempt_disable()
and proceeds to do per-cpu things. How is it handled in RT?
Are you saying that every preempt_disable has to be paired with some lock?
I don't think it's a practical requirement for fulfill, so I probably
misunderstood something.

In BPF we disable preemption because of per-cpu maps and per-cpu data structures
that are shared between bpf program execution and kernel execution.

BPF doesn't call into code that might sleep.
BPF also doesn't have unbound runtime.
So two above issues are actually non-issues.

May be we should go back to concerns that prompted this patch.
Do you have any numbers from production that show that BPF is causing
unbounded latency for RT workloads? If it's all purely theoretical than
we should share the knowledge how different systems behave
instead of building walls. It feels to me that there are no
actual issues. Only misunderstandings.

All that aside I'm working on new BPF program categories that
will be fully preemptable and sleepable. That requirement came
from tracing long ago. The verifier infrastructure wasn't ready
at that time. Now we can do it.
BPF programs will be able to do copy_from_user() and take faults.
preempt_disable and rcu_read_lock regions will be controlled by
the verifier. We will have to support all existing semantics though.

