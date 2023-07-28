Return-Path: <bpf+bounces-6215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37E767157
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91B9282777
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755A14A87;
	Fri, 28 Jul 2023 16:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76F14013
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95828C433C8;
	Fri, 28 Jul 2023 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690560024;
	bh=hYf2rKT66EA0CLZn0dh5++ZEnZG97g1m9o59RcdzOUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Td4BxKeLp8QaPwWqHQy6Fx8W2LrPCrYUlu1FHCBUsHZ8/LXjVoR3VvSXxZEnMOk+8
	 i337flH1gYWa/tB98k96VkLHwDSJ+1PwC98Kzs1DyywIpuw5G7NXMPM3FLfSrU1/tC
	 cBI6M2GLk95RDUgycJ7+eBXJGEKJyIkwRBbAKoJNmRJunmbvtQI5nDCnoXjP/MQf1D
	 3yLjOHYu0p2S53UnrI14nFrYm+1xXZxoO7U7N+5vLDMvCBs59Sf7pwbG6y4K8qb+UV
	 73axdh7/A0S74p9M6VVrD8rFpNpgPlupr2+Ne5VA9RxvXeOoCAEAAxKv1+S9w1/tRQ
	 v+JeeohU1wfFw==
Date: Fri, 28 Jul 2023 11:00:14 -0500
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 13/20] context_tracking: Make context_tracking_key
 __ro_after_init
Message-ID: <20230728160014.vjxikkoo4rieng55@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720163056.2564824-14-vschneid@redhat.com>

On Thu, Jul 20, 2023 at 05:30:49PM +0100, Valentin Schneider wrote:
> objtool now warns about it:
> 
>   vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: Non __ro_after_init static key "context_tracking_key" in .noinstr section
>   vmlinux.o: warning: objtool: enter_from_user_mode+0x50: Non __ro_after_init static key "context_tracking_key" in .noinstr section
>   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x60: Non __ro_after_init static key "context_tracking_key" in .noinstr section
>   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x62: Non __ro_after_init static key "context_tracking_key" in .noinstr section
>   [...]
> 
> The key can only be enabled (and not disabled) in the __init function
> ct_cpu_tracker_user(), so mark it as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

It's best to avoid temporarily introducing warnings.  Bots will
rightfully complain about that.  This patch and the next one should come
before the objtool patches.

Also it would be helpful for the commit log to have a brief
justification for the patch beyond "fix the objtool warning".  Something
roughly like:

  Soon, runtime-mutable text won't be allowed in .noinstr sections, so
  that a code patching IPI to a userspace-bound CPU can be safely
  deferred to the next kernel entry.

  'context_tracking_key' is only enabled in __init ct_cpu_tracker_user().
  Mark it as __ro_after_init.

-- 
Josh

