Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882063CF1F3
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 04:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhGTBf6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 21:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241853AbhGTB1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 21:27:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C3EC61164;
        Tue, 20 Jul 2021 02:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626746861;
        bh=r5wSh0N4B6XoXmmj5VoGs+TOmUC23WqLrxAwPTMxhoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OBWz8xXpkqJGSA8ojBaW0KwNmW7OQyIdOvwR3SaOz64AUscnJJqspPyQ+ILyM0Hli
         8CnpSqb8pMhHw2n4RozPYP9v69Z2i11mXUfVV+zBA70Y5kMSe0THk640gSjSrqgxFX
         oBBZJRIAfbt33d0Tv79cCnsxBpyXjwv1VZirwa8b5hJ04TFpFjh3cqCo5HQkNAsQvF
         bwZLO7aHRGVVpjxkA2cjrwUBdipSA29QMZ3XWX6FgevtDDkaBAEuPSBRmUJZ9yMalN
         5jltaLsOX3aRzqLcqX2rDMGnvQ/4Q+BRGsdHGkWH70yvFxVoGiLehnvhz7pRGyrtmt
         YbyXQGBBLd4wA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67CFC5C06CA; Mon, 19 Jul 2021 19:07:41 -0700 (PDT)
Date:   Mon, 19 Jul 2021 19:07:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, apw@canonical.com,
        joe@perches.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        mingo@kernel.org
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210720020741.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
 <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
 <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
 <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com>
 <20210718210854.GP4397@paulmck-ThinkPad-P17-Gen-1>
 <de4785f8-8a9f-c32e-7642-d5bb08bff343@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4785f8-8a9f-c32e-7642-d5bb08bff343@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 06:39:17PM -0700, Randy Dunlap wrote:
> On 7/18/21 2:08 PM, Paul E. McKenney wrote:
> > On Sun, Jul 18, 2021 at 06:03:34AM +0800, Zhouyi Zhou wrote:
> >> Hi Paul
> >> During the research, I found a already existing tool to detect
> >> undefined Kconfig macro:
> >> scripts/checkkconfigsymbols.py. It is marvellous!
> > 
> > Nice!  Maybe I should add this to torture.sh.
> 
> Paul, I believe that subsystems should take care of themselves,
> so you can do that for RCU, e.g., but at the same time, I think that
> some CI should be running that script (and other relevant scripts)
> on the entire kernel tree and reporting problems that are found.

Even better!  ;-)

							Thanx, Paul
