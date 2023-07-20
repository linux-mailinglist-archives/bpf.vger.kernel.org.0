Return-Path: <bpf+bounces-5528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E814F75B853
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 21:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A791E281EC4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC241BE74;
	Thu, 20 Jul 2023 19:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0B1BE67
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E0DC433CC;
	Thu, 20 Jul 2023 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689882785;
	bh=f2zoX/f2BDWXdTqXLQTyx96joLx1NKF0n400nYI5mHs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rt1oe06eBVoHzBMd47hKt4olPkaF18XXvn1lyClLZKV6+ZHxv6EpK+TUu9b07DlTT
	 Zca8fuPLdqwjPzJe9xU7W7nlQHTmn1+IuzoXDyJzDc5b4cAutVAPBvBZYKhocIx027
	 K+MjktTzgY4QiuRVnLdG79zzeH+/qZgtDlEcAW2Ovul+iOKkUleYhVAJxseB1x9mOR
	 SjgkUoHScZpkz2XmAtgze6BTT56VqgeixCI2mEGvozqv9lmgVYYbudDiT3orqzpwQ+
	 3LKVCGaSveRlC6eR8TB2o4O7GHx7/QAY3ehnWzXbu6UG1961PabOzPMK9xaksANQNa
	 gkrKkk2S4w12Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48CD5CE03CF; Thu, 20 Jul 2023 12:53:05 -0700 (PDT)
Date: Thu, 20 Jul 2023 12:53:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 17/20] rcutorture: Add a test config to torture
 test low RCU_DYNTICKS width
Message-ID: <24b55289-1c35-41cc-9ad3-baa957f1c9cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-18-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720163056.2564824-18-vschneid@redhat.com>

On Thu, Jul 20, 2023 at 05:30:53PM +0100, Valentin Schneider wrote:
> We now have an RCU_EXPORT knob for configuring the size of the dynticks
> counter: CONFIG_RCU_DYNTICKS_BITS.
> 
> Add a torture config for a ridiculously small counter (2 bits). This is ac
> opy of TREE4 with the added counter size restriction.
> 
> Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  .../selftests/rcutorture/configs/rcu/TREE11   | 19 +++++++++++++++++++
>  .../rcutorture/configs/rcu/TREE11.boot        |  1 +
>  2 files changed, 20 insertions(+)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> new file mode 100644
> index 0000000000000..aa7274efd9819
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> @@ -0,0 +1,19 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=8
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=y
> +CONFIG_PREEMPT=n
> +CONFIG_PREEMPT_DYNAMIC=n
> +#CHECK#CONFIG_TREE_RCU=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=n
> +CONFIG_NO_HZ_FULL=y
> +CONFIG_RCU_TRACE=y
> +CONFIG_RCU_FANOUT=4
> +CONFIG_RCU_FANOUT_LEAF=3
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_RCU_EXPERT=y
> +CONFIG_RCU_EQS_DEBUG=y
> +CONFIG_RCU_LAZY=y
> +CONFIG_RCU_DYNTICKS_BITS=2

Why not just add this last line to the existing TREE04 scenario?
That would ensure that it gets tested regularly without extending the
time required to run a full set of rcutorture tests.

> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> new file mode 100644
> index 0000000000000..a8d94caf7d2fd
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> @@ -0,0 +1 @@
> +rcutree.rcu_fanout_leaf=4 nohz_full=1-N
> -- 
> 2.31.1
> 

