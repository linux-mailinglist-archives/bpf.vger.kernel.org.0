Return-Path: <bpf+bounces-5828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31F761A1C
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1341C280EA8
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868B1F938;
	Tue, 25 Jul 2023 13:37:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441A1ED32
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:37:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F641FDF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690292228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuHDDSh+hqntXfEBDTeZy9lkclJmyfPYzRYLt1ff+f8=;
	b=Qrixst/ENYRVqVxuG2i01AUXJRbvpF1XhLd4QZDc38rBCgL5OGihc3fpcg/JnD9/ANaImE
	xxr5G+gVc8RfjKrBfHD57LqQEsmQqve0/xn5r/EaM/Mda4wNMZdO1psGeaCtF9aKZMVFXL
	hUtKw1+1B/khey73i+uu2o/Q+KiqpbI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-J5lvFBm_PZKR-_ipDWIldA-1; Tue, 25 Jul 2023 09:37:07 -0400
X-MC-Unique: J5lvFBm_PZKR-_ipDWIldA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31444df0fafso3261970f8f.2
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292223; x=1690897023;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuHDDSh+hqntXfEBDTeZy9lkclJmyfPYzRYLt1ff+f8=;
        b=XLCeTVQziePZekmPy96eqYITSd7Aj7NdQDBb6bNa2DFYUeRo0buP3L/nN8w6M5BUZ0
         htNfuls9flPTrbNUjEjjO37vH2dHlz/F2wihA21jPyoNimNw1LaYJNReGtBUOuI0C9nV
         4FheD7VSu3lAmBEcvKsSjxIqvmf4YjLkLsldMhI5rbKhufJoM7zYVIV90+8jXvisc2Dm
         naT+FOuZpqS4Pf0ZvvM8bxGhgq5NWtJiV48MFPLIhe92I9bswVbv/0FF6mMz5sK7ArIj
         Pf0deO6kP9Nz31ZEZUnvQv59L5WAHQV98an3FXE+uXgEqkOKb5wRBKq4S1KrWK0ID0XY
         qBgA==
X-Gm-Message-State: ABy/qLaYZAJplR/7YwLZuC8hPtqmtlIKJfEYJrkf/rEQVTgy8mA9UrZt
	daivePG9UozSGk/JVyaYrzTI6igPV9rHoD1FZ/W+Ljlrexn0e8VvDufXBg5SX9vSlnHiDzeoxTb
	rS05pZRCUxGUV
X-Received: by 2002:adf:edd1:0:b0:313:df09:ad04 with SMTP id v17-20020adfedd1000000b00313df09ad04mr11718244wro.57.1690292223005;
        Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEu1q96uzpYLmrQ6ZyLxOIliHI6bjUjLVOksOKXP2KWpblMNlkbQak2J3cKJncV5JGWmoXhZA==
X-Received: by 2002:adf:edd1:0:b0:313:df09:ad04 with SMTP id v17-20020adfedd1000000b00313df09ad04mr11718201wro.57.1690292222669;
        Tue, 25 Jul 2023 06:37:02 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b00314329f7d8asm16390715wrw.29.2023.07.25.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:37:01 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text
 patching IPIs
In-Reply-To: <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
References: <20230720163056.2564824-19-vschneid@redhat.com>
 <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
Date: Tue, 25 Jul 2023 14:36:59 +0100
Message-ID: <xhsmhtttsru2s.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/07/23 06:49, Joel Fernandes wrote:
> Interesting series Valentin. Some high-level question/comments on this on=
e:
>
>> On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> w=
rote:
>>
>> =EF=BB=BFtext_poke_bp_batch() sends IPIs to all online CPUs to synchroni=
ze
>> them vs the newly patched instruction. CPUs that are executing in usersp=
ace
>> do not need this synchronization to happen immediately, and this is
>> actually harmful interference for NOHZ_FULL CPUs.
>
> Does the amount of harm not correspond to practical frequency of text_pok=
e?
> How often does instruction patching really happen? If it is very infreque=
nt
> then I am not sure if it is that harmful.
>

Being pushed over a latency threshold *once* is enough to impact the
latency evaluation of your given system/application.

It's mainly about shielding the isolated, NOHZ_FULL CPUs from whatever the
housekeeping CPUs may be up to (flipping static keys, loading kprobes,
using ftrace...) - frequency of the interference isn't such a big part of
the reasoning.

>>
>> As the synchronization IPIs are sent using a blocking call, returning fr=
om
>> text_poke_bp_batch() implies all CPUs will observe the patched
>> instruction(s), and this should be preserved even if the IPI is deferred.
>> In other words, to safely defer this synchronization, any kernel
>> instruction leading to the execution of the deferred instruction
>> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
>
> If it is not infrequent, then are you handling the case where userland
> spends multiple seconds before entering the kernel, and all this while
> the blocking call waits? Perhaps in such situation you want the real IPI
> to be sent out instead of the deferred one?
>

The blocking call only waits for CPUs for which it queued a CSD. Deferred
calls do not queue a CSD thus do not impact the waiting at all. See
smp_call_function_many_cond().


