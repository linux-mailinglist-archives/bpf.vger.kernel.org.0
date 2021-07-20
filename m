Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98F3CF195
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 03:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhGTBDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 21:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhGTA7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 20:59:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2596AC061767;
        Mon, 19 Jul 2021 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=VPslFF/zeZEn4JJOEfZN5MEgA42KT6C8T7MZnexgON8=; b=kS6uL8x4SfuJQcn28GfFZN3joa
        nydiNdvKdcQhwKwzRBH3jo154/gB2yr+6O7GTp8pt/aqn6PelFCC6+9SKXK6zyRGsTHqfKxAzYhpI
        3rD/xiPufvdUI+q0d8ufOpVtjaQpw8Hutp7XR+chfZTUjB4iWpj6QpVKaALRDzAxVWziIZBzLULjw
        OBiIMCnvRiYvhRlIoeKsT+TnxeVkAMMTPlOuT6330SR+CvI/H4CpLwvT7/j5TTfwocQe+kOOPfGf1
        uvsqbc1ouZ0oTMGYVEdPgN2AkfmKie+JcX5nPSf6drVpmtARzv4yXB21tfbegTMUmnYr8C1uw/zlr
        ZsfhUYFw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5ej9-00Ba0z-KP; Tue, 20 Jul 2021 01:39:19 +0000
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
To:     paulmck@kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
 <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
 <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
 <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
 <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com>
 <20210718210854.GP4397@paulmck-ThinkPad-P17-Gen-1>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de4785f8-8a9f-c32e-7642-d5bb08bff343@infradead.org>
Date:   Mon, 19 Jul 2021 18:39:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718210854.GP4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/18/21 2:08 PM, Paul E. McKenney wrote:
> On Sun, Jul 18, 2021 at 06:03:34AM +0800, Zhouyi Zhou wrote:
>> Hi Paul
>> During the research, I found a already existing tool to detect
>> undefined Kconfig macro:
>> scripts/checkkconfigsymbols.py. It is marvellous!
> 
> Nice!  Maybe I should add this to torture.sh.
> 

Paul, I believe that subsystems should take care of themselves,
so you can do that for RCU, e.g., but at the same time, I think that
some CI should be running that script (and other relevant scripts)
on the entire kernel tree and reporting problems that are found.

-- 
~Randy

