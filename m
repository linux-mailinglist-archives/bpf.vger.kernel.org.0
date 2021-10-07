Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35D42503F
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhJGJoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 05:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232678AbhJGJoO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 05:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633599740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yF185G3CUaIimxEtaF4EwIKwxKpiut8yc194c2IfaRo=;
        b=bYhUAHMfOtZhGub/bhhmNSxo9Qfy6XSqFWLc+BRVT/aoagrn/HVZFGZ/YoUfGq5R0ehGsi
        g0lNekRMecFfdY3u5owy1NGnb1K/gSPgzUgELYIQ9anOomefv4gAnhTQShGq5Dwd5BUam/
        ++RlLes1YQQ0f03xxH7Nt0LjxHZscnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-n9J6L_YaNQykxgpnhNy_4g-1; Thu, 07 Oct 2021 05:42:19 -0400
X-MC-Unique: n9J6L_YaNQykxgpnhNy_4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE968010ED;
        Thu,  7 Oct 2021 09:42:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33E7E5C1B4;
        Thu,  7 Oct 2021 09:42:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D53BF416D862; Thu,  7 Oct 2021 06:10:03 -0300 (-03)
Date:   Thu, 7 Oct 2021 06:10:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: introduce helper bpf_raw_read_cpu_clock
Message-ID: <20211007091003.GA337010@fuller.cnet>
References: <20211006175106.GA295227@fuller.cnet>
 <CAPhsuW5Uq78wqK_waeLPpyY6PNgzgtCZkZ4-FFWcF00Pez6cmw@mail.gmail.com>
 <20211007071856.GM174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007071856.GM174703@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter, Song,

On Thu, Oct 07, 2021 at 09:18:56AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 06, 2021 at 02:37:09PM -0700, Song Liu wrote:
> > On Wed, Oct 6, 2021 at 10:52 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > >
> > >
> > > Add bpf_raw_read_cpu_clock helper, to read architecture specific
> > > CPU clock. In x86's case, this is the TSC.
> > >
> > > This is necessary to synchronize bpf traces from host and guest bpf-programs
> > > (after subtracting guest tsc-offset from guest timestamps).
> > 
> > Trying to understand the use case. So in a host-guest scenario,
> > bpf_ktime_get_ns()
> > will return different values in host and guest, but rdtsc() will give
> > the same value.
> > Is this correct?
> 
> No, it will not. 

No, but we can find out the delta between host and guest TSCs.

On x86, you can read the offset through debugfs file:

        debugfs_create_file("tsc-offset", 0444, debugfs_dentry, vcpu,
                            &vcpu_tsc_offset_fops);

Other architectures can expose that offset.

> Also, please explain if any of this stands a chance of
> working for anything other than x86. 

Yes, the same pattern repeats

ARM:

With offset between guest and host:
https://developer.arm.com/documentation/ddi0595/2020-12/AArch64-Registers/CNTVCT-EL0--Counter-timer-Virtual-Count-register?lang=en

Without offset:
commit 051ff581ce70e822729e9474941f3c206cbf7436

PPC:
https://yhbt.net/lore/all/5f267a8aec5b8199a580c96ab2b1a3c27de4eb09.camel@gmail.com/T/

(Time Base Register is read through mftb instruction).

> Or even on x86 in the face of
> guest migration.

It won't, but honestly we don't care about tracing at this level across
migration.

> Also, please explain, again, what's wrong with dumping snapshots of
> CLOCK_MONOTONIC{,_RAW} from host and guest and correlating time that
> way?

You can't read the guest and the host clock at the same time (there will always
be some variable delay between reading the two clocks). And that delay
is not fixed, but variable (depending on scheduling of the guest vcpus, 
for example). So you will need an algorithm to estimate their differences, 
with non zero error bounds:

"
 Add a driver with gettime method returning hosts realtime clock.
 This allows Chrony to synchronize host and guest clocks with 
 high precision (see results below).
 
 chronyc> sources
 MS Name/IP address         Stratum Poll Reach LastRx Last sample
 ===============================================================================
 #* PHC0                          0   3   377     6     +4ns[   +4ns] +/-    3ns
"

Now with the hardware clock (which is usually the base for CLOCK_MONOTONIC_RAW),
there are no errors (offset will be 0 ns, rather than 3/4ns).

> And also explain why BPF needs to do this differently than all the other
> tracers.

For x86 we use:

echo "x86-tsc" > /sys/kernel/debug/tracing/trace_clock

For this purpose, on x86, so its not like anything different is being
done?

