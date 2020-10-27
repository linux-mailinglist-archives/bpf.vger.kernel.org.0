Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D729C715
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504154AbgJ0N5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 09:57:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:50670 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752926AbgJ0N5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 09:57:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 635AE2C2690;
        Tue, 27 Oct 2020 09:57:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eDaiIT2lTZWQ; Tue, 27 Oct 2020 09:57:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B88C92C268D;
        Tue, 27 Oct 2020 09:57:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B88C92C268D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603807061;
        bh=dn77Djd8sf1HxHN4odngIadpn0rpb7OxAXVukoxK5Rs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=s9sV7s9WTJ0S5aXWAaHciEcvuk34IanTnxQTaYitIEn+CgjZsuPNii5LpOLVei5gE
         o38aVyxCFB8BHXEXdP1jyki+6dzzA2lnJIW+lhDzmh+OOk0ZNBzCCFHexAJ5eC5qUb
         OzHAowazcG0G363dEGP53CDDhaG4Co8Nfb6ZY1X4OHcLVVchIVNwaU7XGFvM706+Q7
         HvC3tZ5D5zovZoXmRbCxSaRPgbHqgCW6Wv+aMm2n2t/bs/pcENKoqW9mnQP454aJ6C
         w+k8+3gA+LGdG/ldgwApa64xQhw4AfTGufHtpk2AgP5KYWhJXBRZxJg7ZjNXr8w2fa
         O82oQRZpqFvzA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b0TPTQe6cAif; Tue, 27 Oct 2020 09:57:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 935182C2532;
        Tue, 27 Oct 2020 09:57:41 -0400 (EDT)
Date:   Tue, 27 Oct 2020 09:57:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Message-ID: <993741332.38579.1603807061504.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201026164459.1d514d0a@gandalf.local.home>
References: <20201023195352.26269-1-mjeanson@efficios.com> <20201023195352.26269-7-mjeanson@efficios.com> <20201023211359.GC3563800@google.com> <20201026082010.GC2628@hirez.programming.kicks-ass.net> <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com> <20201026164459.1d514d0a@gandalf.local.home>
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_38577_64406330.1603807061503"
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3968)
Thread-Topic: tracing: use sched-RCU instead of SRCU for rcuidle tracepoints
Thread-Index: hA6NcqXvXTFG6vKWeFxLIK22cqq+9g==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

------=_Part_38577_64406330.1603807061503
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 26, 2020, at 4:44 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I agree with Peter. Removing the trace_.*_rcuidle weirdness from the tracepoint
>> API and fixing all callers to ensure they trace from a context where RCU is
>> watching would simplify instrumentation of the Linux kernel, thus making it
>> harder
>> for subtle bugs to hide and be unearthed only when tracing is enabled. This is
> 
> Note, the lockdep RCU checking of a tracepoint is outside of it being
> enabled or disable. So if a non rcuidle() tracepoint is in a location that
> RCU is not watching, it will complain loudly, even if you don't enable that
> tracepoint.
> 
>> AFAIU the general approach Thomas Gleixner has been aiming for recently, and I
>> think it is a good thing.
>> 
>> So if we consider this our target, and that the current state of things is that
>> we need to have RCU watching around callback invocation, then removing the
>> dependency on SRCU seems like an overall simplification which does not regress
>> feature-wise nor speed-wise compared with what we have upstream today. The next
>> steps would then be to audit all rcuidle tracepoints and make sure the context
>> where they are placed has RCU watching already, so we can remove the tracepoint
> 
> Just remove the _rcuidle() from them, and lockdep will complain if they are
> being called without RCU watching.

That's the easy part. The patch removing rcuidle is attached to this email,
and here are the splats I get just when booting the machine (see below). The
part which takes more time is fixing those splats and figuring out how to
restructure the code. For instance, what should we do about the rcuidle
tracepoint within printk() ?

Also, how do we test rcuidle tracepoints triggered only when printk is called
from printk warnings ? We'd also need to test on arm32 boards, because some arm
architecture code uses rcuidle tracepoints as well.

As this is beyond the scope of this patch set, I can either drop this patch
entirely (it's not required for sleepable tracepoints), or keep it as an
intermediate cleanup step. Removing rcuidle tracepoints entirely is beyond
the effort Michael and I can undertake now.

=============================
WARNING: suspicious RCU usage

5.9.1+ #72 Not tainted
-----------------------------
=============================
./include/trace/events/preemptirq.h:42 suspicious rcu_dereference_check() usage!
WARNING: suspicious RCU usage

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
5.9.1+ #72 Not tainted
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.
-----------------------------
./include/trace/events/preemptirq.h:38 suspicious rcu_dereference_check() usage!

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
RCU used illegally from extended quiescent state!
no locks held by swapper/1/0.
 dump_stack+0x8d/0xbb

stack backtrace:
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.1+ #72

=============================
WARNING: suspicious RCU usage
5.9.1+ #72 Not tainted
-----------------------------
./include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 lock_acquire+0x346/0x3b0
 ? __lock_acquire+0x2e7/0x1da0
 _raw_spin_lock+0x2c/0x40
 ? vprintk_emit+0x9f/0x410
 vprintk_emit+0x9f/0x410
 printk+0x52/0x6e
 lockdep_rcu_suspicious+0x1b/0xe0
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0

=============================
WARNING: suspicious RCU usage
5.9.1+ #72 Not tainted
-----------------------------
./include/trace/events/lock.h:63 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff97a80158 (logbuf_lock){-...}-{2:2}, at: vprintk_emit+0x9f/0x410

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 lock_release+0x25a/0x280
 _raw_spin_unlock+0x17/0x30
 vprintk_emit+0xdf/0x410
 printk+0x52/0x6e
 lockdep_rcu_suspicious+0x1b/0xe0
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0

=============================
WARNING: suspicious RCU usage
5.9.1+ #72 Not tainted
-----------------------------
./include/trace/events/printk.h:33 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
RCU used illegally from extended quiescent state!
2 locks held by swapper/0/0:
 #0: ffffffff97a801a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x126/0x410
 #1: ffffffff97a7fec0 (console_owner){....}-{0:0}, at: console_unlock+0x190/0x5d0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 console_unlock+0x5ad/0x5d0
 vprintk_emit+0x133/0x410
 printk+0x52/0x6e
 lockdep_rcu_suspicious+0x1b/0xe0
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0

=============================
WARNING: suspicious RCU usage
5.9.1+ #72 Not tainted
-----------------------------
./include/linux/rcupdate.h:636 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
RCU used illegally from extended quiescent state!
4 locks held by swapper/0/0:
 #0: ffffffff97a801a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x126/0x410
 #1: ffffffff97a7fec0 (console_owner){....}-{0:0}, at: console_unlock+0x190/0x5d0
 #2: ffffffff97b7d598 (printing_lock){....}-{2:2}, at: vt_console_print+0x7d/0x3e0
 #3: ffffffff97a82d80 (rcu_read_lock){....}-{1:2}, at: __atomic_notifier_call_chain+0x5/0x110

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 __atomic_notifier_call_chain+0xd7/0x110
 vt_console_print+0x19e/0x3e0
 console_unlock+0x417/0x5d0
 vprintk_emit+0x133/0x410
 printk+0x52/0x6e
 lockdep_rcu_suspicious+0x1b/0xe0
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0

=============================
WARNING: suspicious RCU usage
5.9.1+ #72 Not tainted
-----------------------------
./include/linux/rcupdate.h:685 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
RCU used illegally from extended quiescent state!
4 locks held by swapper/0/0:
 #0: ffffffff97a801a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x126/0x410
 #1: ffffffff97a7fec0 (console_owner){....}-{0:0}, at: console_unlock+0x190/0x5d0
 #2: ffffffff97b7d598 (printing_lock){....}-{2:2}, at: vt_console_print+0x7d/0x3e0
 #3: ffffffff97a82d80 (rcu_read_lock){....}-{1:2}, at: __atomic_notifier_call_chain+0x5/0x110

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.1+ #72
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 __atomic_notifier_call_chain+0x101/0x110
 vt_console_print+0x19e/0x3e0
 console_unlock+0x417/0x5d0
 vprintk_emit+0x133/0x410
 printk+0x52/0x6e
 lockdep_rcu_suspicious+0x1b/0xe0
 ? default_idle+0xa/0x20
 trace_hardirqs_on+0xed/0xf0
 default_idle+0xa/0x20
 default_idle_call+0x4f/0x1e0
 do_idle+0x1ef/0x2c0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x578/0x59d
 secondary_startup_64+0xa4/0xb0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8d/0xbb
 ? rcu_idle_exit+0x32/0x40
 trace_hardirqs_off+0xe3/0xf0
 rcu_idle_exit+0x32/0x40
 default_idle_call+0x54/0x1e0
 do_idle+0x1ef/0x2c0
 ? lockdep_hardirqs_on_prepare+0xec/0x180
 cpu_startup_entry+0x19/0x20
 start_secondary+0x11c/0x160
 secondary_startup_64+0xa4/0xb0

Thanks,

Mathieu


> 
> -- Steve
> 
> 
>> rcuidle API. That would effectively remove the calls to
>> rcu_irq_{enter,exit}_irqson
>> from the tracepoint code.
>> 
>> This is however beyond the scope of the proposed patch set.
>> 
>> Thanks,
>> 
>> Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_38577_64406330.1603807061503
Content-Type: application/mbox;
 name=0001-wip-remove-rcuidle-tracepoint-API.patch
Content-Disposition: attachment;
 filename=0001-wip-remove-rcuidle-tracepoint-API.patch
Content-Transfer-Encoding: base64

RnJvbSA3YTE2MDI5ZWI1NjkyMWE0MmU0YzE2MzIzZTBkZWUxMjhkNzI0YzFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPgpEYXRlOiBUdWUsIDI3IE9jdCAyMDIwIDA5OjI4OjQ2IC0wNDAwClN1Ympl
Y3Q6IFtXSVAgUEFUQ0ggMS8xXSB3aXA6IHJlbW92ZSByY3VpZGxlIHRyYWNlcG9pbnQgQVBJCgot
LS0KIGFyY2gvYXJtL2tlcm5lbC9zbXAuYyAgICAgICAgICAgICB8ICA2ICsrKy0tLQogYXJjaC9h
cm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5jIHwgMTAgKysrKystLS0tLQogYXJjaC9hcm02NC9r
ZXJuZWwvc21wLmMgICAgICAgICAgIHwgIDQgKystLQogZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRp
bWUuYyAgICAgIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2Nsay9jbGsu
YyAgICAgICAgICAgICAgICAgfCAgOCArKysrLS0tLQogZHJpdmVycy9zb2MvcWNvbS9ycG1oLXJz
Yy5jICAgICAgIHwgIDIgKy0KIGluY2x1ZGUvbGludXgvdHJhY2Vwb2ludC5oICAgICAgICB8IDI2
ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9wcmVlbXB0
aXJxLmggfCAgOCAtLS0tLS0tLQoga2VybmVsL3ByaW50ay9wcmludGsuYyAgICAgICAgICAgIHwg
IDIgKy0KIGtlcm5lbC90cmFjZS90cmFjZV9wcmVlbXB0aXJxLmMgICB8IDE4ICsrKysrKy0tLS0t
LS0tLS0tLQogc2NyaXB0cy90YWdzLnNoICAgICAgICAgICAgICAgICAgIHwgIDIgLS0KIDExIGZp
bGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDc0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2tlcm5lbC9zbXAuYyBiL2FyY2gvYXJtL2tlcm5lbC9zbXAuYwppbmRleCA1
ZDlkYTYxZWZmNjIuLjQ5OTdhOTY1YTM4YSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0va2VybmVsL3Nt
cC5jCisrKyBiL2FyY2gvYXJtL2tlcm5lbC9zbXAuYwpAQCAtNTIxLDcgKzUyMSw3IEBAIHN0YXRp
YyBjb25zdCBjaGFyICppcGlfdHlwZXNbTlJfSVBJXSBfX3RyYWNlcG9pbnRfc3RyaW5nID0gewog
CiBzdGF0aWMgdm9pZCBzbXBfY3Jvc3NfY2FsbChjb25zdCBzdHJ1Y3QgY3B1bWFzayAqdGFyZ2V0
LCB1bnNpZ25lZCBpbnQgaXBpbnIpCiB7Ci0JdHJhY2VfaXBpX3JhaXNlX3JjdWlkbGUodGFyZ2V0
LCBpcGlfdHlwZXNbaXBpbnJdKTsKKwl0cmFjZV9pcGlfcmFpc2UodGFyZ2V0LCBpcGlfdHlwZXNb
aXBpbnJdKTsKIAlfX3NtcF9jcm9zc19jYWxsKHRhcmdldCwgaXBpbnIpOwogfQogCkBAIC02MzMs
NyArNjMzLDcgQEAgdm9pZCBoYW5kbGVfSVBJKGludCBpcGluciwgc3RydWN0IHB0X3JlZ3MgKnJl
Z3MpCiAJc3RydWN0IHB0X3JlZ3MgKm9sZF9yZWdzID0gc2V0X2lycV9yZWdzKHJlZ3MpOwogCiAJ
aWYgKCh1bnNpZ25lZClpcGluciA8IE5SX0lQSSkgewotCQl0cmFjZV9pcGlfZW50cnlfcmN1aWRs
ZShpcGlfdHlwZXNbaXBpbnJdKTsKKwkJdHJhY2VfaXBpX2VudHJ5KGlwaV90eXBlc1tpcGlucl0p
OwogCQlfX2luY19pcnFfc3RhdChjcHUsIGlwaV9pcnFzW2lwaW5yXSk7CiAJfQogCkBAIC02OTQs
NyArNjk0LDcgQEAgdm9pZCBoYW5kbGVfSVBJKGludCBpcGluciwgc3RydWN0IHB0X3JlZ3MgKnJl
Z3MpCiAJfQogCiAJaWYgKCh1bnNpZ25lZClpcGluciA8IE5SX0lQSSkKLQkJdHJhY2VfaXBpX2V4
aXRfcmN1aWRsZShpcGlfdHlwZXNbaXBpbnJdKTsKKwkJdHJhY2VfaXBpX2V4aXQoaXBpX3R5cGVz
W2lwaW5yXSk7CiAJc2V0X2lycV9yZWdzKG9sZF9yZWdzKTsKIH0KIApkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wb3dl
cmRvbWFpbi5jCmluZGV4IDFjYmFjNzYxMzZkNC4uNDA5M2VmYWZiMTY4IDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9wb3dlcmRvbWFpbi5jCkBAIC0xODcsOSArMTg3LDkgQEAgc3RhdGljIGludCBfcHdyZG1fc3Rh
dGVfc3dpdGNoKHN0cnVjdCBwb3dlcmRvbWFpbiAqcHdyZG0sIGludCBmbGFnKQogCQkJdHJhY2Vf
c3RhdGUgPSAoUFdSRE1fVFJBQ0VfU1RBVEVTX0ZMQUcgfAogCQkJCSAgICAgICAoKG5leHQgJiBP
TUFQX1BPV0VSU1RBVEVfTUFTSykgPDwgOCkgfAogCQkJCSAgICAgICAoKHByZXYgJiBPTUFQX1BP
V0VSU1RBVEVfTUFTSykgPDwgMCkpOwotCQkJdHJhY2VfcG93ZXJfZG9tYWluX3RhcmdldF9yY3Vp
ZGxlKHB3cmRtLT5uYW1lLAotCQkJCQkJCSAgdHJhY2Vfc3RhdGUsCi0JCQkJCQkJICByYXdfc21w
X3Byb2Nlc3Nvcl9pZCgpKTsKKwkJCXRyYWNlX3Bvd2VyX2RvbWFpbl90YXJnZXQocHdyZG0tPm5h
bWUsCisJCQkJCQkgIHRyYWNlX3N0YXRlLAorCQkJCQkJICByYXdfc21wX3Byb2Nlc3Nvcl9pZCgp
KTsKIAkJfQogCQlicmVhazsKIAlkZWZhdWx0OgpAQCAtNTQxLDggKzU0MSw4IEBAIGludCBwd3Jk
bV9zZXRfbmV4dF9wd3JzdChzdHJ1Y3QgcG93ZXJkb21haW4gKnB3cmRtLCB1OCBwd3JzdCkKIAog
CWlmIChhcmNoX3B3cmRtICYmIGFyY2hfcHdyZG0tPnB3cmRtX3NldF9uZXh0X3B3cnN0KSB7CiAJ
CS8qIFRyYWNlIHRoZSBwd3JkbSBkZXNpcmVkIHRhcmdldCBzdGF0ZSAqLwotCQl0cmFjZV9wb3dl
cl9kb21haW5fdGFyZ2V0X3JjdWlkbGUocHdyZG0tPm5hbWUsIHB3cnN0LAotCQkJCQkJICByYXdf
c21wX3Byb2Nlc3Nvcl9pZCgpKTsKKwkJdHJhY2VfcG93ZXJfZG9tYWluX3RhcmdldChwd3JkbS0+
bmFtZSwgcHdyc3QsCisJCQkJCSAgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7CiAJCS8qIFByb2dy
YW0gdGhlIHB3cmRtIGRlc2lyZWQgdGFyZ2V0IHN0YXRlICovCiAJCXJldCA9IGFyY2hfcHdyZG0t
PnB3cmRtX3NldF9uZXh0X3B3cnN0KHB3cmRtLCBwd3JzdCk7CiAJfQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rZXJuZWwvc21wLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zbXAuYwppbmRleCAzNTVl
ZTllZWQ0ZGQuLmRkMDQxNWZkOWZhOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvc21w
LmMKKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMKQEAgLTg5Niw3ICs4OTYsNyBAQCB2b2lk
IGhhbmRsZV9JUEkoaW50IGlwaW5yLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAlzdHJ1Y3QgcHRf
cmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3JlZ3MocmVncyk7CiAKIAlpZiAoKHVuc2lnbmVkKWlw
aW5yIDwgTlJfSVBJKSB7Ci0JCXRyYWNlX2lwaV9lbnRyeV9yY3VpZGxlKGlwaV90eXBlc1tpcGlu
cl0pOworCQl0cmFjZV9pcGlfZW50cnkoaXBpX3R5cGVzW2lwaW5yXSk7CiAJCV9faW5jX2lycV9z
dGF0KGNwdSwgaXBpX2lycXNbaXBpbnJdKTsKIAl9CiAKQEAgLTk1Niw3ICs5NTYsNyBAQCB2b2lk
IGhhbmRsZV9JUEkoaW50IGlwaW5yLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAl9CiAKIAlpZiAo
KHVuc2lnbmVkKWlwaW5yIDwgTlJfSVBJKQotCQl0cmFjZV9pcGlfZXhpdF9yY3VpZGxlKGlwaV90
eXBlc1tpcGlucl0pOworCQl0cmFjZV9pcGlfZXhpdChpcGlfdHlwZXNbaXBpbnJdKTsKIAlzZXRf
aXJxX3JlZ3Mob2xkX3JlZ3MpOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIv
cnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYwppbmRleCA4MTQzMjEwYTVj
NTQuLjQxOGIzZTM3MzIzMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUu
YworKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCkBAIC00MDEsNyArNDAxLDcgQEAg
c3RhdGljIGludCBycG1faWRsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1mbGFncykKIAlp
bnQgKCpjYWxsYmFjaykoc3RydWN0IGRldmljZSAqKTsKIAlpbnQgcmV0dmFsOwogCi0JdHJhY2Vf
cnBtX2lkbGVfcmN1aWRsZShkZXYsIHJwbWZsYWdzKTsKKwl0cmFjZV9ycG1faWRsZShkZXYsIHJw
bWZsYWdzKTsKIAlyZXR2YWwgPSBycG1fY2hlY2tfc3VzcGVuZF9hbGxvd2VkKGRldik7CiAJaWYg
KHJldHZhbCA8IDApCiAJCTsJLyogQ29uZGl0aW9ucyBhcmUgd3JvbmcuICovCkBAIC00MzcsNyAr
NDM3LDcgQEAgc3RhdGljIGludCBycG1faWRsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1m
bGFncykKIAkJCWRldi0+cG93ZXIucmVxdWVzdF9wZW5kaW5nID0gdHJ1ZTsKIAkJCXF1ZXVlX3dv
cmsocG1fd3EsICZkZXYtPnBvd2VyLndvcmspOwogCQl9Ci0JCXRyYWNlX3JwbV9yZXR1cm5faW50
X3JjdWlkbGUoZGV2LCBfVEhJU19JUF8sIDApOworCQl0cmFjZV9ycG1fcmV0dXJuX2ludChkZXYs
IF9USElTX0lQXywgMCk7CiAJCXJldHVybiAwOwogCX0KIApAQCAtNDUyLDcgKzQ1Miw3IEBAIHN0
YXRpYyBpbnQgcnBtX2lkbGUoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpCiAJd2Fr
ZV91cF9hbGwoJmRldi0+cG93ZXIud2FpdF9xdWV1ZSk7CiAKICBvdXQ6Ci0JdHJhY2VfcnBtX3Jl
dHVybl9pbnRfcmN1aWRsZShkZXYsIF9USElTX0lQXywgcmV0dmFsKTsKKwl0cmFjZV9ycG1fcmV0
dXJuX2ludChkZXYsIF9USElTX0lQXywgcmV0dmFsKTsKIAlyZXR1cm4gcmV0dmFsID8gcmV0dmFs
IDogcnBtX3N1c3BlbmQoZGV2LCBycG1mbGFncyB8IFJQTV9BVVRPKTsKIH0KIApAQCAtNTE5LDcg
KzUxOSw3IEBAIHN0YXRpYyBpbnQgcnBtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2LCBpbnQg
cnBtZmxhZ3MpCiAJc3RydWN0IGRldmljZSAqcGFyZW50ID0gTlVMTDsKIAlpbnQgcmV0dmFsOwog
Ci0JdHJhY2VfcnBtX3N1c3BlbmRfcmN1aWRsZShkZXYsIHJwbWZsYWdzKTsKKwl0cmFjZV9ycG1f
c3VzcGVuZChkZXYsIHJwbWZsYWdzKTsKIAogIHJlcGVhdDoKIAlyZXR2YWwgPSBycG1fY2hlY2tf
c3VzcGVuZF9hbGxvd2VkKGRldik7CkBAIC02NTcsNyArNjU3LDcgQEAgc3RhdGljIGludCBycG1f
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1mbGFncykKIAl9CiAKICBvdXQ6Ci0J
dHJhY2VfcnBtX3JldHVybl9pbnRfcmN1aWRsZShkZXYsIF9USElTX0lQXywgcmV0dmFsKTsKKwl0
cmFjZV9ycG1fcmV0dXJuX2ludChkZXYsIF9USElTX0lQXywgcmV0dmFsKTsKIAogCXJldHVybiBy
ZXR2YWw7CiAKQEAgLTcwOSw3ICs3MDksNyBAQCBzdGF0aWMgaW50IHJwbV9yZXN1bWUoc3RydWN0
IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpCiAJc3RydWN0IGRldmljZSAqcGFyZW50ID0gTlVM
TDsKIAlpbnQgcmV0dmFsID0gMDsKIAotCXRyYWNlX3JwbV9yZXN1bWVfcmN1aWRsZShkZXYsIHJw
bWZsYWdzKTsKKwl0cmFjZV9ycG1fcmVzdW1lKGRldiwgcnBtZmxhZ3MpOwogCiAgcmVwZWF0Ogog
CWlmIChkZXYtPnBvd2VyLnJ1bnRpbWVfZXJyb3IpCkBAIC04NzIsNyArODcyLDcgQEAgc3RhdGlj
IGludCBycG1fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHJwbWZsYWdzKQogCQlzcGlu
X2xvY2tfaXJxKCZkZXYtPnBvd2VyLmxvY2spOwogCX0KIAotCXRyYWNlX3JwbV9yZXR1cm5faW50
X3JjdWlkbGUoZGV2LCBfVEhJU19JUF8sIHJldHZhbCk7CisJdHJhY2VfcnBtX3JldHVybl9pbnQo
ZGV2LCBfVEhJU19JUF8sIHJldHZhbCk7CiAKIAlyZXR1cm4gcmV0dmFsOwogfQpAQCAtMTAwNSw3
ICsxMDA1LDcgQEAgaW50IF9fcG1fcnVudGltZV9pZGxlKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50
IHJwbWZsYWdzKQogCiAJaWYgKHJwbWZsYWdzICYgUlBNX0dFVF9QVVQpIHsKIAkJaWYgKCFhdG9t
aWNfZGVjX2FuZF90ZXN0KCZkZXYtPnBvd2VyLnVzYWdlX2NvdW50KSkgewotCQkJdHJhY2VfcnBt
X3VzYWdlX3JjdWlkbGUoZGV2LCBycG1mbGFncyk7CisJCQl0cmFjZV9ycG1fdXNhZ2UoZGV2LCBy
cG1mbGFncyk7CiAJCQlyZXR1cm4gMDsKIAkJfQogCX0KQEAgLTEwMzksNyArMTAzOSw3IEBAIGlu
dCBfX3BtX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBycG1mbGFncykK
IAogCWlmIChycG1mbGFncyAmIFJQTV9HRVRfUFVUKSB7CiAJCWlmICghYXRvbWljX2RlY19hbmRf
dGVzdCgmZGV2LT5wb3dlci51c2FnZV9jb3VudCkpIHsKLQkJCXRyYWNlX3JwbV91c2FnZV9yY3Vp
ZGxlKGRldiwgcnBtZmxhZ3MpOworCQkJdHJhY2VfcnBtX3VzYWdlKGRldiwgcnBtZmxhZ3MpOwog
CQkJcmV0dXJuIDA7CiAJCX0KIAl9CkBAIC0xMTIyLDcgKzExMjIsNyBAQCBpbnQgcG1fcnVudGlt
ZV9nZXRfaWZfYWN0aXZlKHN0cnVjdCBkZXZpY2UgKmRldiwgYm9vbCBpZ25fdXNhZ2VfY291bnQp
CiAJfSBlbHNlIHsKIAkJcmV0dmFsID0gYXRvbWljX2luY19ub3RfemVybygmZGV2LT5wb3dlci51
c2FnZV9jb3VudCk7CiAJfQotCXRyYWNlX3JwbV91c2FnZV9yY3VpZGxlKGRldiwgMCk7CisJdHJh
Y2VfcnBtX3VzYWdlKGRldiwgMCk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5wb3dl
ci5sb2NrLCBmbGFncyk7CiAKIAlyZXR1cm4gcmV0dmFsOwpAQCAtMTQ1OCw3ICsxNDU4LDcgQEAg
dm9pZCBwbV9ydW50aW1lX2FsbG93KHN0cnVjdCBkZXZpY2UgKmRldikKIAlpZiAoYXRvbWljX2Rl
Y19hbmRfdGVzdCgmZGV2LT5wb3dlci51c2FnZV9jb3VudCkpCiAJCXJwbV9pZGxlKGRldiwgUlBN
X0FVVE8gfCBSUE1fQVNZTkMpOwogCWVsc2UKLQkJdHJhY2VfcnBtX3VzYWdlX3JjdWlkbGUoZGV2
LCBSUE1fQVVUTyB8IFJQTV9BU1lOQyk7CisJCXRyYWNlX3JwbV91c2FnZShkZXYsIFJQTV9BVVRP
IHwgUlBNX0FTWU5DKTsKIAogIG91dDoKIAlzcGluX3VubG9ja19pcnEoJmRldi0+cG93ZXIubG9j
ayk7CkBAIC0xNTI3LDcgKzE1MjcsNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfYXV0b3N1c3BlbmQo
c3RydWN0IGRldmljZSAqZGV2LCBpbnQgb2xkX2RlbGF5LCBpbnQgb2xkX3VzZSkKIAkJCWF0b21p
Y19pbmMoJmRldi0+cG93ZXIudXNhZ2VfY291bnQpOwogCQkJcnBtX3Jlc3VtZShkZXYsIDApOwog
CQl9IGVsc2UgewotCQkJdHJhY2VfcnBtX3VzYWdlX3JjdWlkbGUoZGV2LCAwKTsKKwkJCXRyYWNl
X3JwbV91c2FnZShkZXYsIDApOwogCQl9CiAJfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9j
bGsuYyBiL2RyaXZlcnMvY2xrL2Nsay5jCmluZGV4IDBhOTI2MWEwOTliZC4uMWMwOTk2MzIzMTcx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Nsay9jbGsuYworKysgYi9kcml2ZXJzL2Nsay9jbGsuYwpA
QCAtOTU5LDEyICs5NTksMTIgQEAgc3RhdGljIHZvaWQgY2xrX2NvcmVfZGlzYWJsZShzdHJ1Y3Qg
Y2xrX2NvcmUgKmNvcmUpCiAJaWYgKC0tY29yZS0+ZW5hYmxlX2NvdW50ID4gMCkKIAkJcmV0dXJu
OwogCi0JdHJhY2VfY2xrX2Rpc2FibGVfcmN1aWRsZShjb3JlKTsKKwl0cmFjZV9jbGtfZGlzYWJs
ZShjb3JlKTsKIAogCWlmIChjb3JlLT5vcHMtPmRpc2FibGUpCiAJCWNvcmUtPm9wcy0+ZGlzYWJs
ZShjb3JlLT5odyk7CiAKLQl0cmFjZV9jbGtfZGlzYWJsZV9jb21wbGV0ZV9yY3VpZGxlKGNvcmUp
OworCXRyYWNlX2Nsa19kaXNhYmxlX2NvbXBsZXRlKGNvcmUpOwogCiAJY2xrX2NvcmVfZGlzYWJs
ZShjb3JlLT5wYXJlbnQpOwogfQpAQCAtMTAxOCwxMiArMTAxOCwxMiBAQCBzdGF0aWMgaW50IGNs
a19jb3JlX2VuYWJsZShzdHJ1Y3QgY2xrX2NvcmUgKmNvcmUpCiAJCWlmIChyZXQpCiAJCQlyZXR1
cm4gcmV0OwogCi0JCXRyYWNlX2Nsa19lbmFibGVfcmN1aWRsZShjb3JlKTsKKwkJdHJhY2VfY2xr
X2VuYWJsZShjb3JlKTsKIAogCQlpZiAoY29yZS0+b3BzLT5lbmFibGUpCiAJCQlyZXQgPSBjb3Jl
LT5vcHMtPmVuYWJsZShjb3JlLT5odyk7CiAKLQkJdHJhY2VfY2xrX2VuYWJsZV9jb21wbGV0ZV9y
Y3VpZGxlKGNvcmUpOworCQl0cmFjZV9jbGtfZW5hYmxlX2NvbXBsZXRlKGNvcmUpOwogCiAJCWlm
IChyZXQpIHsKIAkJCWNsa19jb3JlX2Rpc2FibGUoY29yZS0+cGFyZW50KTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc29jL3Fjb20vcnBtaC1yc2MuYyBiL2RyaXZlcnMvc29jL3Fjb20vcnBtaC1yc2Mu
YwppbmRleCBhZTY2NzU3ODI1ODEuLmZhYmUzOTBkY2UxOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
b2MvcWNvbS9ycG1oLXJzYy5jCisrKyBiL2RyaXZlcnMvc29jL3Fjb20vcnBtaC1yc2MuYwpAQCAt
NDk1LDcgKzQ5NSw3IEBAIHN0YXRpYyB2b2lkIF9fdGNzX2J1ZmZlcl93cml0ZShzdHJ1Y3QgcnNj
X2RydiAqZHJ2LCBpbnQgdGNzX2lkLCBpbnQgY21kX2lkLAogCQl3cml0ZV90Y3NfY21kKGRydiwg
UlNDX0RSVl9DTURfTVNHSUQsIHRjc19pZCwgaiwgbXNnaWQpOwogCQl3cml0ZV90Y3NfY21kKGRy
diwgUlNDX0RSVl9DTURfQUREUiwgdGNzX2lkLCBqLCBjbWQtPmFkZHIpOwogCQl3cml0ZV90Y3Nf
Y21kKGRydiwgUlNDX0RSVl9DTURfREFUQSwgdGNzX2lkLCBqLCBjbWQtPmRhdGEpOwotCQl0cmFj
ZV9ycG1oX3NlbmRfbXNnX3JjdWlkbGUoZHJ2LCB0Y3NfaWQsIGosIG1zZ2lkLCBjbWQpOworCQl0
cmFjZV9ycG1oX3NlbmRfbXNnKGRydiwgdGNzX2lkLCBqLCBtc2dpZCwgY21kKTsKIAl9CiAKIAl3
cml0ZV90Y3NfcmVnKGRydiwgUlNDX0RSVl9DTURfV0FJVF9GT1JfQ01QTCwgdGNzX2lkLCBjbWRf
Y29tcGxldGUpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90cmFjZXBvaW50LmggYi9pbmNs
dWRlL2xpbnV4L3RyYWNlcG9pbnQuaAppbmRleCAxNDE0YjExZjg2NGIuLmVlNTEzZTY5Njc5OSAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90cmFjZXBvaW50LmgKKysrIGIvaW5jbHVkZS9saW51
eC90cmFjZXBvaW50LmgKQEAgLTE2MCw3ICsxNjAsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB0
cmFjZXBvaW50ICp0cmFjZXBvaW50X3B0cl9kZXJlZih0cmFjZXBvaW50X3B0cl90ICpwKQogICog
aGFzIGEgInZvaWQiIHByb3RvdHlwZSwgdGhlbiBpdCBpcyBpbnZhbGlkIHRvIGRlY2xhcmUgYSBm
dW5jdGlvbgogICogYXMgIih2b2lkICosIHZvaWQpIi4KICAqLwotI2RlZmluZSBfX0RPX1RSQUNF
KHRwLCBwcm90bywgYXJncywgY29uZCwgcmN1aWRsZSwgdHBfZmxhZ3MpCQlcCisjZGVmaW5lIF9f
RE9fVFJBQ0UodHAsIHByb3RvLCBhcmdzLCBjb25kLCB0cF9mbGFncykJCQlcCiAJZG8gewkJCQkJ
CQkJXAogCQlzdHJ1Y3QgdHJhY2Vwb2ludF9mdW5jICppdF9mdW5jX3B0cjsJCQlcCiAJCXZvaWQg
Kml0X2Z1bmM7CQkJCQkJXApAQCAtMTcyLDggKzE3Miw2IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0
IHRyYWNlcG9pbnQgKnRyYWNlcG9pbnRfcHRyX2RlcmVmKHRyYWNlcG9pbnRfcHRyX3QgKnApCiAJ
CQlyZXR1cm47CQkJCQkJXAogCQkJCQkJCQkJXAogCQltaWdodF9zbGVlcF9pZihtYXlzbGVlcCk7
CQkJCVwKLQkJaWYgKHJjdWlkbGUpCQkJCQkJXAotCQkJcmN1X2lycV9lbnRlcl9pcnFzb24oKTsJ
CQkJXAogCQlpZiAobWF5c2xlZXApCQkJCQkJXAogCQkJcmN1X3JlYWRfbG9ja190cmFjZSgpOwkJ
CQlcCiAJCWVsc2UJCQkJCQkJXApAQCAtMTkzLDI0ICsxOTEsOCBAQCBzdGF0aWMgaW5saW5lIHN0
cnVjdCB0cmFjZXBvaW50ICp0cmFjZXBvaW50X3B0cl9kZXJlZih0cmFjZXBvaW50X3B0cl90ICpw
KQogCQkJcmN1X3JlYWRfdW5sb2NrX3RyYWNlKCk7CQkJXAogCQllbHNlCQkJCQkJCVwKIAkJCXBy
ZWVtcHRfZW5hYmxlX25vdHJhY2UoKTsJCQlcCi0JCWlmIChyY3VpZGxlKQkJCQkJCVwKLQkJCXJj
dV9pcnFfZXhpdF9pcnFzb24oKTsJCQkJXAogCX0gd2hpbGUgKDApCiAKLSNpZm5kZWYgTU9EVUxF
Ci0jZGVmaW5lIF9fREVDTEFSRV9UUkFDRV9SQ1UobmFtZSwgcHJvdG8sIGFyZ3MsIGNvbmQsIGRh
dGFfcHJvdG8sIGRhdGFfYXJncywgdHBfZmxhZ3MpIFwKLQlzdGF0aWMgaW5saW5lIHZvaWQgdHJh
Y2VfIyNuYW1lIyNfcmN1aWRsZShwcm90bykJCVwKLQl7CQkJCQkJCQlcCi0JCWlmIChzdGF0aWNf
a2V5X2ZhbHNlKCZfX3RyYWNlcG9pbnRfIyNuYW1lLmtleSkpCQlcCi0JCQlfX0RPX1RSQUNFKCZf
X3RyYWNlcG9pbnRfIyNuYW1lLAkJXAotCQkJCVRQX1BST1RPKGRhdGFfcHJvdG8pLAkJCVwKLQkJ
CQlUUF9BUkdTKGRhdGFfYXJncyksCQkJXAotCQkJCVRQX0NPTkRJVElPTihjb25kKSwgMSwgdHBf
ZmxhZ3MpOwlcCi0JfQotI2Vsc2UKLSNkZWZpbmUgX19ERUNMQVJFX1RSQUNFX1JDVShuYW1lLCBw
cm90bywgYXJncywgY29uZCwgZGF0YV9wcm90bywgZGF0YV9hcmdzLCB0cF9mbGFncykKLSNlbmRp
ZgotCiAvKgogICogTWFrZSBzdXJlIHRoZSBhbGlnbm1lbnQgb2YgdGhlIHN0cnVjdHVyZSBpbiB0
aGUgX190cmFjZXBvaW50cyBzZWN0aW9uIHdpbGwKICAqIG5vdCBhZGQgdW53YW50ZWQgcGFkZGlu
ZyBiZXR3ZWVuIHRoZSBiZWdpbm5pbmcgb2YgdGhlIHNlY3Rpb24gYW5kIHRoZQpAQCAtMjMxLDE1
ICsyMTMsMTMgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgdHJhY2Vwb2ludCAqdHJhY2Vwb2ludF9w
dHJfZGVyZWYodHJhY2Vwb2ludF9wdHJfdCAqcCkKIAkJCV9fRE9fVFJBQ0UoJl9fdHJhY2Vwb2lu
dF8jI25hbWUsCQlcCiAJCQkJVFBfUFJPVE8oZGF0YV9wcm90byksCQkJXAogCQkJCVRQX0FSR1Mo
ZGF0YV9hcmdzKSwJCQlcCi0JCQkJVFBfQ09ORElUSU9OKGNvbmQpLCAwLCB0cF9mbGFncyk7CVwK
KwkJCQlUUF9DT05ESVRJT04oY29uZCksIHRwX2ZsYWdzKTsJCVwKIAkJaWYgKElTX0VOQUJMRUQo
Q09ORklHX0xPQ0tERVApICYmIChjb25kKSkgewkJXAogCQkJcmN1X3JlYWRfbG9ja19zY2hlZF9u
b3RyYWNlKCk7CQkJXAogCQkJcmN1X2RlcmVmZXJlbmNlX3NjaGVkKF9fdHJhY2Vwb2ludF8jI25h
bWUuZnVuY3MpO1wKIAkJCXJjdV9yZWFkX3VubG9ja19zY2hlZF9ub3RyYWNlKCk7CQlcCiAJCX0J
CQkJCQkJXAogCX0JCQkJCQkJCVwKLQlfX0RFQ0xBUkVfVFJBQ0VfUkNVKG5hbWUsIFBBUkFNUyhw
cm90byksIFBBUkFNUyhhcmdzKSwJCVwKLQkJUEFSQU1TKGNvbmQpLCBQQVJBTVMoZGF0YV9wcm90
byksIFBBUkFNUyhkYXRhX2FyZ3MpLCB0cF9mbGFncykJXAogCXN0YXRpYyBpbmxpbmUgaW50CQkJ
CQkJXAogCXJlZ2lzdGVyX3RyYWNlXyMjbmFtZSh2b2lkICgqcHJvYmUpKGRhdGFfcHJvdG8pLCB2
b2lkICpkYXRhKQlcCiAJewkJCQkJCQkJXApAQCAtMzEwLDggKzI5MCw2IEBAIHN0YXRpYyBpbmxp
bmUgc3RydWN0IHRyYWNlcG9pbnQgKnRyYWNlcG9pbnRfcHRyX2RlcmVmKHRyYWNlcG9pbnRfcHRy
X3QgKnApCiAjZGVmaW5lIF9fREVDTEFSRV9UUkFDRShuYW1lLCBwcm90bywgYXJncywgY29uZCwg
ZGF0YV9wcm90bywgZGF0YV9hcmdzLCB0cF9mbGFncykgXAogCXN0YXRpYyBpbmxpbmUgdm9pZCB0
cmFjZV8jI25hbWUocHJvdG8pCQkJCVwKIAl7IH0JCQkJCQkJCVwKLQlzdGF0aWMgaW5saW5lIHZv
aWQgdHJhY2VfIyNuYW1lIyNfcmN1aWRsZShwcm90bykJCVwKLQl7IH0JCQkJCQkJCVwKIAlzdGF0
aWMgaW5saW5lIGludAkJCQkJCVwKIAlyZWdpc3Rlcl90cmFjZV8jI25hbWUodm9pZCAoKnByb2Jl
KShkYXRhX3Byb3RvKSwJCVwKIAkJCSAgICAgIHZvaWQgKmRhdGEpCQkJCVwKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdHJhY2UvZXZlbnRzL3ByZWVtcHRpcnEuaCBiL2luY2x1ZGUvdHJhY2UvZXZlbnRz
L3ByZWVtcHRpcnEuaAppbmRleCAzZjI0OWUxNTBjMGMuLmY5OTU2MmQyYjQ5NiAxMDA2NDQKLS0t
IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvcHJlZW1wdGlycS5oCisrKyBiL2luY2x1ZGUvdHJhY2Uv
ZXZlbnRzL3ByZWVtcHRpcnEuaApAQCAtNDMsOCArNDMsNiBAQCBERUZJTkVfRVZFTlQocHJlZW1w
dGlycV90ZW1wbGF0ZSwgaXJxX2VuYWJsZSwKICNlbHNlCiAjZGVmaW5lIHRyYWNlX2lycV9lbmFi
bGUoLi4uKQogI2RlZmluZSB0cmFjZV9pcnFfZGlzYWJsZSguLi4pCi0jZGVmaW5lIHRyYWNlX2ly
cV9lbmFibGVfcmN1aWRsZSguLi4pCi0jZGVmaW5lIHRyYWNlX2lycV9kaXNhYmxlX3JjdWlkbGUo
Li4uKQogI2VuZGlmCiAKICNpZmRlZiBDT05GSUdfVFJBQ0VfUFJFRU1QVF9UT0dHTEUKQEAgLTU4
LDggKzU2LDYgQEAgREVGSU5FX0VWRU5UKHByZWVtcHRpcnFfdGVtcGxhdGUsIHByZWVtcHRfZW5h
YmxlLAogI2Vsc2UKICNkZWZpbmUgdHJhY2VfcHJlZW1wdF9lbmFibGUoLi4uKQogI2RlZmluZSB0
cmFjZV9wcmVlbXB0X2Rpc2FibGUoLi4uKQotI2RlZmluZSB0cmFjZV9wcmVlbXB0X2VuYWJsZV9y
Y3VpZGxlKC4uLikKLSNkZWZpbmUgdHJhY2VfcHJlZW1wdF9kaXNhYmxlX3JjdWlkbGUoLi4uKQog
I2VuZGlmCiAKICNlbmRpZiAvKiBfVFJBQ0VfUFJFRU1QVElSUV9IICovCkBAIC02OSwxMCArNjUs
NiBAQCBERUZJTkVfRVZFTlQocHJlZW1wdGlycV90ZW1wbGF0ZSwgcHJlZW1wdF9lbmFibGUsCiAj
ZWxzZSAvKiAhQ09ORklHX1BSRUVNUFRJUlFfVFJBQ0VQT0lOVFMgKi8KICNkZWZpbmUgdHJhY2Vf
aXJxX2VuYWJsZSguLi4pCiAjZGVmaW5lIHRyYWNlX2lycV9kaXNhYmxlKC4uLikKLSNkZWZpbmUg
dHJhY2VfaXJxX2VuYWJsZV9yY3VpZGxlKC4uLikKLSNkZWZpbmUgdHJhY2VfaXJxX2Rpc2FibGVf
cmN1aWRsZSguLi4pCiAjZGVmaW5lIHRyYWNlX3ByZWVtcHRfZW5hYmxlKC4uLikKICNkZWZpbmUg
dHJhY2VfcHJlZW1wdF9kaXNhYmxlKC4uLikKLSNkZWZpbmUgdHJhY2VfcHJlZW1wdF9lbmFibGVf
cmN1aWRsZSguLi4pCi0jZGVmaW5lIHRyYWNlX3ByZWVtcHRfZGlzYWJsZV9yY3VpZGxlKC4uLikK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEva2VybmVsL3ByaW50ay9wcmludGsuYyBiL2tlcm5lbC9wcmlu
dGsvcHJpbnRrLmMKaW5kZXggOWI3NWY2YmZjMzMzLi5lYzY0MWE3N2FkNTIgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9wcmludGsvcHJpbnRrLmMKKysrIGIva2VybmVsL3ByaW50ay9wcmludGsuYwpAQCAt
MTgwNiw3ICsxODA2LDcgQEAgc3RhdGljIHZvaWQgY2FsbF9jb25zb2xlX2RyaXZlcnMoY29uc3Qg
Y2hhciAqZXh0X3RleHQsIHNpemVfdCBleHRfbGVuLAogewogCXN0cnVjdCBjb25zb2xlICpjb247
CiAKLQl0cmFjZV9jb25zb2xlX3JjdWlkbGUodGV4dCwgbGVuKTsKKwl0cmFjZV9jb25zb2xlKHRl
eHQsIGxlbik7CiAKIAlmb3JfZWFjaF9jb25zb2xlKGNvbikgewogCQlpZiAoZXhjbHVzaXZlX2Nv
bnNvbGUgJiYgY29uICE9IGV4Y2x1c2l2ZV9jb25zb2xlKQpkaWZmIC0tZ2l0IGEva2VybmVsL3Ry
YWNlL3RyYWNlX3ByZWVtcHRpcnEuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9wcmVlbXB0aXJxLmMK
aW5kZXggZjQ5MzgwNDBjMjI4Li5iODliZDEzM2M4ZmMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90cmFj
ZS90cmFjZV9wcmVlbXB0aXJxLmMKKysrIGIva2VybmVsL3RyYWNlL3RyYWNlX3ByZWVtcHRpcnEu
YwpAQCAtNDAsOCArNDAsNyBAQCBOT0tQUk9CRV9TWU1CT0wodHJhY2VfaGFyZGlycXNfb25fcHJl
cGFyZSk7CiB2b2lkIHRyYWNlX2hhcmRpcnFzX29uKHZvaWQpCiB7CiAJaWYgKHRoaXNfY3B1X3Jl
YWQodHJhY2luZ19pcnFfY3B1KSkgewotCQlpZiAoIWluX25taSgpKQotCQkJdHJhY2VfaXJxX2Vu
YWJsZV9yY3VpZGxlKENBTExFUl9BRERSMCwgQ0FMTEVSX0FERFIxKTsKKwkJdHJhY2VfaXJxX2Vu
YWJsZShDQUxMRVJfQUREUjAsIENBTExFUl9BRERSMSk7CiAJCXRyYWNlcl9oYXJkaXJxc19vbihD
QUxMRVJfQUREUjAsIENBTExFUl9BRERSMSk7CiAJCXRoaXNfY3B1X3dyaXRlKHRyYWNpbmdfaXJx
X2NwdSwgMCk7CiAJfQpAQCAtNzgsOCArNzcsNyBAQCB2b2lkIHRyYWNlX2hhcmRpcnFzX29mZih2
b2lkKQogCWlmICghdGhpc19jcHVfcmVhZCh0cmFjaW5nX2lycV9jcHUpKSB7CiAJCXRoaXNfY3B1
X3dyaXRlKHRyYWNpbmdfaXJxX2NwdSwgMSk7CiAJCXRyYWNlcl9oYXJkaXJxc19vZmYoQ0FMTEVS
X0FERFIwLCBDQUxMRVJfQUREUjEpOwotCQlpZiAoIWluX25taSgpKQotCQkJdHJhY2VfaXJxX2Rp
c2FibGVfcmN1aWRsZShDQUxMRVJfQUREUjAsIENBTExFUl9BRERSMSk7CisJCXRyYWNlX2lycV9k
aXNhYmxlKENBTExFUl9BRERSMCwgQ0FMTEVSX0FERFIxKTsKIAl9CiB9CiBFWFBPUlRfU1lNQk9M
KHRyYWNlX2hhcmRpcnFzX29mZik7CkBAIC04OCw4ICs4Niw3IEBAIE5PS1BST0JFX1NZTUJPTCh0
cmFjZV9oYXJkaXJxc19vZmYpOwogX192aXNpYmxlIHZvaWQgdHJhY2VfaGFyZGlycXNfb25fY2Fs
bGVyKHVuc2lnbmVkIGxvbmcgY2FsbGVyX2FkZHIpCiB7CiAJaWYgKHRoaXNfY3B1X3JlYWQodHJh
Y2luZ19pcnFfY3B1KSkgewotCQlpZiAoIWluX25taSgpKQotCQkJdHJhY2VfaXJxX2VuYWJsZV9y
Y3VpZGxlKENBTExFUl9BRERSMCwgY2FsbGVyX2FkZHIpOworCQl0cmFjZV9pcnFfZW5hYmxlKENB
TExFUl9BRERSMCwgY2FsbGVyX2FkZHIpOwogCQl0cmFjZXJfaGFyZGlycXNfb24oQ0FMTEVSX0FE
RFIwLCBjYWxsZXJfYWRkcik7CiAJCXRoaXNfY3B1X3dyaXRlKHRyYWNpbmdfaXJxX2NwdSwgMCk7
CiAJfQpAQCAtMTA3LDggKzEwNCw3IEBAIF9fdmlzaWJsZSB2b2lkIHRyYWNlX2hhcmRpcnFzX29m
Zl9jYWxsZXIodW5zaWduZWQgbG9uZyBjYWxsZXJfYWRkcikKIAlpZiAoIXRoaXNfY3B1X3JlYWQo
dHJhY2luZ19pcnFfY3B1KSkgewogCQl0aGlzX2NwdV93cml0ZSh0cmFjaW5nX2lycV9jcHUsIDEp
OwogCQl0cmFjZXJfaGFyZGlycXNfb2ZmKENBTExFUl9BRERSMCwgY2FsbGVyX2FkZHIpOwotCQlp
ZiAoIWluX25taSgpKQotCQkJdHJhY2VfaXJxX2Rpc2FibGVfcmN1aWRsZShDQUxMRVJfQUREUjAs
IGNhbGxlcl9hZGRyKTsKKwkJdHJhY2VfaXJxX2Rpc2FibGUoQ0FMTEVSX0FERFIwLCBjYWxsZXJf
YWRkcik7CiAJfQogfQogRVhQT1JUX1NZTUJPTCh0cmFjZV9oYXJkaXJxc19vZmZfY2FsbGVyKTsK
QEAgLTExOSwxNSArMTE1LDEzIEBAIE5PS1BST0JFX1NZTUJPTCh0cmFjZV9oYXJkaXJxc19vZmZf
Y2FsbGVyKTsKIAogdm9pZCB0cmFjZV9wcmVlbXB0X29uKHVuc2lnbmVkIGxvbmcgYTAsIHVuc2ln
bmVkIGxvbmcgYTEpCiB7Ci0JaWYgKCFpbl9ubWkoKSkKLQkJdHJhY2VfcHJlZW1wdF9lbmFibGVf
cmN1aWRsZShhMCwgYTEpOworCXRyYWNlX3ByZWVtcHRfZW5hYmxlKGEwLCBhMSk7CiAJdHJhY2Vy
X3ByZWVtcHRfb24oYTAsIGExKTsKIH0KIAogdm9pZCB0cmFjZV9wcmVlbXB0X29mZih1bnNpZ25l
ZCBsb25nIGEwLCB1bnNpZ25lZCBsb25nIGExKQogewotCWlmICghaW5fbm1pKCkpCi0JCXRyYWNl
X3ByZWVtcHRfZGlzYWJsZV9yY3VpZGxlKGEwLCBhMSk7CisJdHJhY2VfcHJlZW1wdF9kaXNhYmxl
KGEwLCBhMSk7CiAJdHJhY2VyX3ByZWVtcHRfb2ZmKGEwLCBhMSk7CiB9CiAjZW5kaWYKZGlmZiAt
LWdpdCBhL3NjcmlwdHMvdGFncy5zaCBiL3NjcmlwdHMvdGFncy5zaAppbmRleCA4NTBmNGNjYjZh
ZmMuLjMwNTdmYmU5ZWJhMCAxMDA3NTUKLS0tIGEvc2NyaXB0cy90YWdzLnNoCisrKyBiL3Njcmlw
dHMvdGFncy5zaApAQCAtMTQ3LDkgKzE0Nyw3IEBAIHJlZ2V4X2M9KAogCScvXkJQRl9DQUxMX1sw
LTldKFwoW1s6YWxudW06XV9dKlwpLiovXDEvJwogCScvXkNPTVBBVF9TWVNDQUxMX0RFRklORVsw
LTldKFwoW1s6YWxudW06XV9dKlwpLiovY29tcGF0X3N5c19cMS8nCiAJJy9eVFJBQ0VfRVZFTlQo
XChbWzphbG51bTpdX10qXCkuKi90cmFjZV9cMS8nCi0JJy9eVFJBQ0VfRVZFTlQoXChbWzphbG51
bTpdX10qXCkuKi90cmFjZV9cMV9yY3VpZGxlLycKIAknL15ERUZJTkVfRVZFTlQoW14sKV0qLCAq
XChbWzphbG51bTpdX10qXCkuKi90cmFjZV9cMS8nCi0JJy9eREVGSU5FX0VWRU5UKFteLCldKiwg
KlwoW1s6YWxudW06XV9dKlwpLiovdHJhY2VfXDFfcmN1aWRsZS8nCiAJJy9eREVGSU5FX0lOU05f
Q0FDSEVfT1BTKFwoW1s6YWxudW06XV9dKlwpLiovZ2V0X1wxX3Nsb3QvJwogCScvXkRFRklORV9J
TlNOX0NBQ0hFX09QUyhcKFtbOmFsbnVtOl1fXSpcKS4qL2ZyZWVfXDFfc2xvdC8nCiAJJy9eUEFH
RUZMQUcoXChbWzphbG51bTpdX10qXCkuKi9QYWdlXDEvJwotLSAKMi4xNy4xCgo=
------=_Part_38577_64406330.1603807061503--
