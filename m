Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482C5381FF
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFFX6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 19:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFFX6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 19:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13495307D864;
        Thu,  6 Jun 2019 23:58:31 +0000 (UTC)
Received: from treble (ovpn-120-211.rdu2.redhat.com [10.10.120.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AB627842C;
        Thu,  6 Jun 2019 23:58:29 +0000 (UTC)
Date:   Thu, 6 Jun 2019 19:58:26 -0400
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190606235826.ryudsd37bcjolbb2@treble>
References: <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble>
 <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
 <20190524232312.upjixcrnidlibikd@treble>
 <CACPcB9cFGQ6OU7Zk=q_c8V8ob6vg3HMaaXGaNjaKn8rvS-wg-g@mail.gmail.com>
 <145B7F65-2E06-4266-A816-A3445FE47638@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <145B7F65-2E06-4266-A816-A3445FE47638@fb.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 06 Jun 2019 23:58:31 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 06, 2019 at 04:04:48PM +0000, Song Liu wrote:
> >> Here's a tentative BPF fix for the JIT frame pointer issue.  It was a
> >> bit harder than I expected.  Encoding r12 as a base register requires a
> >> SIB byte, so I had to add support for encoding that.  I also simplified
> >> the prologue to resemble a GCC prologue, which decreases the prologue
> >> size quite a bit.
> >> 
> >> Next week I can work on the corresponding ORC change.  Then I can clean
> >> all the patches up and submit them properly.
> 
> Hi Josh, 
> 
> Have you got luck fixing the ORC side?

Sorry, I've been traveling this week and I haven't had a chance to work
on it.  It's at the top of my TODO list for next week.

-- 
Josh
