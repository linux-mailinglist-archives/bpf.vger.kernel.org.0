Return-Path: <bpf+bounces-5625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535075CAF2
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EEF1C2171E
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB027F3E;
	Fri, 21 Jul 2023 15:08:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5527F33
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 15:08:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862193580
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689952096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SD81e7NZBdmvFs/0moOEoRHsNzw2ypppSDOfYt+K9oA=;
	b=HwZSLzxi0P1oAdGrffqa8WSat0EVVskjrWXXVBpZ8+doOSiy6LZnGhz0tGpLx9EuROcd+x
	HbqZeBdo/ARZ+i1IfjwKh5Xu4Wzj20gsYUL/ulclIRpCYM9j8D2YOfVSOOuErRfbLmutU+
	+7cbCnryJszXJUl5lmN+702Ri+DIMYs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-a1C3z0dtPUm5l4Lexp0Ueg-1; Fri, 21 Jul 2023 11:08:15 -0400
X-MC-Unique: a1C3z0dtPUm5l4Lexp0Ueg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so10633085e9.3
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 08:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952094; x=1690556894;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD81e7NZBdmvFs/0moOEoRHsNzw2ypppSDOfYt+K9oA=;
        b=MCj5a8GEztv8UAnDrjnXDO4r9Rc9NvT7RH/IvlT8YXEL1rJ2oozryWzzXUook6Zuvt
         MAbKLYf3K3wPJeR403VSBnGrGE1PFL62/mKJWLgAEYvWRre28NYXIDd1gXF2q0F7lisp
         iYMI28O2SuQCN0zog2XdDv+EnK1xAnWxTC74z+evI5EgulkiFFI9K6hk2S88M36kon4b
         ZcZK+kE35D6NqDlsF73RWUuzOiyx/6Sktf/inwFzPDe7TyREqxlK2fPhnhYkreaYiANW
         ud6IL8S2vW0DCbX/X8Lk2UpV8zg+Qk2mgpJtw7sw/K1cDsYbcDyjLkuHpshVL1peF41M
         upNQ==
X-Gm-Message-State: ABy/qLaazQBtQQmupFoDWq/0g78oDG740+y4xAbyWeh6RtTUx/yc/gro
	nDMIRj91ivQvPN4lj0d/Ah+z4Izth8PXAEMKl2aoB2mSjE7Y6jR6F83EQrHKVm/RYAPIqHJfx1T
	YrJnbxi6Iq/UU
X-Received: by 2002:a7b:c455:0:b0:3fc:627:ea31 with SMTP id l21-20020a7bc455000000b003fc0627ea31mr1714686wmi.38.1689952094111;
        Fri, 21 Jul 2023 08:08:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF9fiPWFBcIAw2j2QV4lTYmt4mtAVTwBGD8BbL2O21cgVm0IYBel5tSTfnfWuFcEvQp7qgXww==
X-Received: by 2002:a7b:c455:0:b0:3fc:627:ea31 with SMTP id l21-20020a7bc455000000b003fc0627ea31mr1714619wmi.38.1689952093765;
        Fri, 21 Jul 2023 08:08:13 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id q7-20020a5d5747000000b0031434936f0dsm4459951wrw.68.2023.07.21.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:08:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [RFC PATCH v2 16/20] rcu: Make RCU dynticks counter size
 configurable
In-Reply-To: <28d4abb7-8496-45ec-b270-ea2b6164537b@paulmck-laptop>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-17-vschneid@redhat.com>
 <xhsmhjzutu18u.mognet@vschneid.remote.csb>
 <28d4abb7-8496-45ec-b270-ea2b6164537b@paulmck-laptop>
Date: Fri, 21 Jul 2023 16:08:10 +0100
Message-ID: <xhsmhbkg5ti91.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/07/23 07:10, Paul E. McKenney wrote:
> On Fri, Jul 21, 2023 at 09:17:53AM +0100, Valentin Schneider wrote:
>> On 20/07/23 17:30, Valentin Schneider wrote:
>> > index bdd7eadb33d8f..1ff2aab24e964 100644
>> > --- a/kernel/rcu/Kconfig
>> > +++ b/kernel/rcu/Kconfig
>> > @@ -332,4 +332,37 @@ config RCU_DOUBLE_CHECK_CB_TIME
>> >         Say Y here if you need tighter callback-limit enforcement.
>> >         Say N here if you are unsure.
>> >
>> > +config RCU_DYNTICKS_RANGE_BEGIN
>> > +	int
>> > +	depends on !RCU_EXPERT
>> > +	default 31 if !CONTEXT_TRACKING_WORK
>>
>> You'll note that this should be 30 really, because the lower *2* bits are
>> taken by the context state (CONTEXT_GUEST has a value of 3).
>>
>> This highlights the fragile part of this: the Kconfig values are hardcoded,
>> but they depend on CT_STATE_SIZE, CONTEXT_MASK and CONTEXT_WORK_MAX. The
>> static_assert() will at least capture any misconfiguration, but having that
>> enforced by the actual Kconfig ranges would be less awkward.
>>
>> Do we currently have a way of e.g. making a Kconfig file depend on and use
>> values generated by a C header?
>
> Why not just have something like a boolean RCU_DYNTICKS_TORTURE Kconfig
> option and let the C code work out what the number of bits should be?
>
> I suppose that there might be a failure whose frequency depended on
> the number of bits, which might be an argument for keeping something
> like RCU_DYNTICKS_RANGE_BEGIN for fault isolation.  But still using
> RCU_DYNTICKS_TORTURE for normal testing.
>
> Thoughts?
>

AFAICT if we run tests with the minimum possible width, then intermediate
values shouldn't have much value.

Your RCU_DYNTICKS_TORTURE suggestion sounds like a saner option than what I
came up with, as we can let the context tracking code figure out the widths
itself and not expose any of that to Kconfig.

>                                                       Thanx, Paul


