Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42192DFA37
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfJVBna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 21:43:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVBna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 21:43:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id l24so3993124pgh.10
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0mmNLAAknDsAK5k4UTNh49XsOwXvJAFLoTg4KERgHA=;
        b=iliSWmbwnDk873wA8JUhpN3af1u5SyEyi6U6GDrQWtmvE9sWvsnp8Fv2MiO+LKBkAY
         Xry89dT6+kOBvIiO+ccbwI236G3o/LQDze/3jRiLfieg13ZsOaZ/6M4OLpeFQMVuTV5X
         b1amDZLJMnnJDd7G/QadF01ejjM7n0ke/WQznwuavZV5kjtfyrKKPifTIMySXlBjlhN2
         KdTTOjrKCHDgEal+wgEr1+cWwwQnLCsoYIsFDBxYQn3qddq7QowN0WH8ivQyT1ibJHci
         OM4ig+nqrndkyabNQjZvHQ9j3F0AjabQAvAAAg8067fwrhmaBIMQWnsZdoRhaJtwfEFY
         GDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0mmNLAAknDsAK5k4UTNh49XsOwXvJAFLoTg4KERgHA=;
        b=E1c0/Dby5Jx1ZhKqcb7XnhHC2bt+wfpaC2psXhEuYwdsc7Nhh7IitG/CuJdrphqG/M
         ei49by1QyR90JpFgIuCbjwcVPZiCNfiAi4BU+OR5bqZsW+3BDX4S90mYZiqc3jT/4Jnn
         M/+u86LzNHrLGZ2OVcrMfZYH0Vo6GN26h1SJ++Ma0XCuN8ZuhdeHhuDdrPXwSLQt/Fc+
         ZeGAZ9OgG9WRum96lrs/s42q0nHCE0df0EPX5r8LgbWyFVPvlwtlPvWAEzWlBn/Me1lZ
         olXi87diUpgYShSga4FZnbQ1LmUxd5ZfmVXlVSaE44fLomQrAftTQvptgsAcMsQc1Pdx
         U9Zg==
X-Gm-Message-State: APjAAAWErzc+LBMrT6x6+hOzTYtCdDxsO4wC8YtTXkxGudsaArmR/0qV
        2WfrOXl6v/ua4hPHYhS853k=
X-Google-Smtp-Source: APXvYqzkG2eNg8UqGP2FNWikv70y+kjW4iIPJrsn67jyE2SFSZzk4CuaulJoCc5zZ75d5TY0jbmzJQ==
X-Received: by 2002:a63:d951:: with SMTP id e17mr906731pgj.243.1571708609272;
        Mon, 21 Oct 2019 18:43:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::5ac])
        by smtp.gmail.com with ESMTPSA id z13sm20311464pfq.121.2019.10.21.18.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 18:43:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 18:43:26 -0700
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
Message-ID: <20191022014324.yfrvdthj6rss742c@ast-mbp.dhcp.thefacebook.com>
References: <20191017145358.GA26267@pc-63.home>
 <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
 <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
 <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
 <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
 <20191018230540.l6e4jtrlu44hk7q5@ast-mbp>
 <alpine.DEB.2.21.1910201043460.2090@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910201043460.2090@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 20, 2019 at 11:06:13AM +0200, Thomas Gleixner wrote:
> On Fri, 18 Oct 2019, Alexei Starovoitov wrote:
> > On Fri, Oct 18, 2019 at 01:28:21PM +0200, Thomas Gleixner wrote:
> > The concept on local_lock() makes sense to me.
> > The magic macro you're proposing that will convert it to old school
> > preempt_disable() on !RT should hopefully make the changes across
> > net and bpf land mostly mechanical.
> > One thing to clarify:
> > when networking core interacts with bpf we know that bh doesn't migrate,
> > so per-cpu datastructres that bpf side populates are accessed later
> > by networking core when program finishes.
> > Similar thing happens between tracing bits and bpf progs.
> > It feels to me that local_lock() approach should work here as well.
> > napi processing bits will grab it. Later bpf will grab potentially
> > the same lock again.
> > The weird bit that such lock will have numbe_of_lockers >= 1
> > for long periods of time. At least until napi runners won't see
> > any more incoming packets. I'm not sure yet where such local_lock
> > will be placed in the napi code (may be in drivers too for xdp).
> > Does this make sense from RT perspective?
> 
> I don't see why the lock would have more than one locker. The code in BPF
> does
> 
> 	preempt_disable();
> 	some operation
> 	preempt_enable();
> 
> So how should that gain more than one context per CPU locking it?

napi is doing preempt_disable() then calls into driver's poll function
which further calls into bpf and when its over it looks at per-cpu
data structures that bpf side shares with drivers.

Even without bpf the networking processing takes long time.
What is the plan for RT there?
Are you planning to replace napi's preempt_disable with local_lock() too?

> Also you might have to accept that there is a world outside of BPF and that
> the 'some out of tree code' which we are talking about is the last part of
> a 15+ years effort which significantly helped to bring the Linux kernel
> into the shape it is today.

No doubt about good stuff that came out of that effort and will continue to come.
I'm arguing that 'pragmatic approach' to disable existing kernel features
to get the rest of RT upstream will backfire on RT in the first place.
ftrace disables preemption too. Lots of things do.
imo it's better to get key RT bits (like local_locks) in without
sending contentious patches like the one that sparked this thread.
When everyone can see what this local_lock is we can figure out
how and when to use it.

