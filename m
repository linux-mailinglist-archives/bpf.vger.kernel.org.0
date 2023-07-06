Return-Path: <bpf+bounces-4214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B267498E2
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8875B1C20CE1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6755F79F8;
	Thu,  6 Jul 2023 10:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CB4A3B
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD42C433C8;
	Thu,  6 Jul 2023 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688637709;
	bh=1uw7peNXWbOZLFcB9mq2BFk7tvD/drZrJVzzlsJCqFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snLh+kbUGeVCMoA+6j1NiXgyGq/FjkZbnGTrm9nidVQVXwFkv/QVK3CL/JdJdM6DD
	 Mk/HKookNBQppeS2LPYd8249BnWwqm4wB2vqfiloLXWNRHrYUMi0Z4zu8O6lJVeXcl
	 ETwReQjSDLhKY6oTbxVrRpRplbDZIaziMv0oJAOlYhOqurXwm/n6Il2lb6fXtAmq0B
	 1nhf0VTZF3pX/pgxr7OcXS1KSRfjTFs6gMLl3gWBfp3aQ4HB5y8TxFmtVk8jpGSdaz
	 sF03Ca3zNDHqfqeHjaHqdg5fmoQgyCM4cSWpq0Yd6oOGBvocG3HDVvgjYE8xKbJwWp
	 G85Mz/024v2zQ==
Date: Thu, 6 Jul 2023 12:01:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
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
Subject: Re: [RFC PATCH 11/14] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <ZKaRCsWfYVPVMBcz@lothringen>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
 <ZKXtfWZiM66dK5xC@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKXtfWZiM66dK5xC@localhost.localdomain>

On Thu, Jul 06, 2023 at 12:23:57AM +0200, Frederic Weisbecker wrote:
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index fdd537ea513f..ec3d172601c5 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -10,14 +10,19 @@
>  #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
>  
>  enum ctx_state {
> +	/* Following are values */
>  	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
>  	CONTEXT_KERNEL		= 0,
>  	CONTEXT_IDLE		= 1,
>  	CONTEXT_USER		= 2,
> -	CONTEXT_GUEST		= 3,
> -	CONTEXT_MAX		= 4,
> +	/* Following are bit numbers */
> +	CONTEXT_WORK		= 2,
> +	CONTEXT_MAX		= 16,
>  };
>  
> +#define CONTEXT_MASK (BIT(CONTEXT_WORK) - 1)
> +#define CONTEXT_WORK_MASK ((BIT(CONTEXT_MAX) - 1) & ~(BIT(CONTEXT_WORK) - 1))
> +
>  /* Even value for idle, else odd. */
>  #define RCU_DYNTICKS_IDX CONTEXT_MAX

And that should be:

#define RCU_DYNTICKS_IDX BIT(CONTEXT_MAX)

Did I mention it's not even build tested? :o)

