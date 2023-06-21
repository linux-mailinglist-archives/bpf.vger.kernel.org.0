Return-Path: <bpf+bounces-3002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C1737FB2
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6AD281598
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5E101C2;
	Wed, 21 Jun 2023 10:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC531BE61
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D79BC433C8;
	Wed, 21 Jun 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687344485;
	bh=vQW8SpknqhfYsLd//ycoQUF1XEoKmVOh7WQXK7qiNdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3axtBl09Uj+gGhVy84WdPlv59/aPeu632cEchdYe8a/k5iJl0+IXsbF+vopEWDYq
	 NwenFITRTKDLMCVF8CzPXY6p9Hti1Q2TT7eK4GXO8pT0fRmZYBTPxe1ckDw7AxLZe2
	 wT9Wmou6gxTC0sVGsza4KPz7hQ7x6JjyXWzC0NK4=
Date: Wed, 21 Jun 2023 12:47:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Amir Goldstein <amir73il@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, kexec@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Message-ID: <2023062150-outbound-quiet-2609@gregkh>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
 <20230621091000.424843-9-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621091000.424843-9-j.granados@samsung.com>

On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
>  static int __init random_sysctls_init(void)
>  {
> -	register_sysctl_init("kernel/random", random_table);
> +	register_sysctl_init("kernel/random", random_table,
> +			     ARRAY_SIZE(random_table));

As mentioned before, why not just do:

#define register_sysctl_init(string, table)	\
	__register_sysctl_init(string, table, ARRAY_SIZE(table);

or something like that?

That way no callers need to change AND you prevent the size from ever
being incorrect?

thanks,

greg k-h

