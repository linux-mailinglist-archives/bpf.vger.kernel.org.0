Return-Path: <bpf+bounces-4222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB52749A99
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B0E1C20D34
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62A8C00;
	Thu,  6 Jul 2023 11:30:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48038824
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:30:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D6199C
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688643007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuiRGI269Np92lVN6nJmdyMw4xzKbo2Z74mCs1dTD80=;
	b=ZIrvz+UT9MvLt9g0Kv5zgzQBjBJ6v+24y8vWughqhuQLE91Z27uJsWgEIccj0LcZfh/bwb
	+khlTGNcc7Ar0TYIjJ577CBXZhpbgA4N8cBRRy1cCH/H9kpkdt+4gk4rhlZoxZeDKyHnEl
	PVwmsT9xnR4ItJwZcudSbkpmbtVEYkU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-4Ae6DBC_MFmayBcbq-rP9g-1; Thu, 06 Jul 2023 07:30:05 -0400
X-MC-Unique: 4Ae6DBC_MFmayBcbq-rP9g-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-47e989378bcso13104e0c.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 04:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643005; x=1691235005;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuiRGI269Np92lVN6nJmdyMw4xzKbo2Z74mCs1dTD80=;
        b=V3R6D16deG47ABtBPKiywDKziPEdTLY7LL/OhqU/jVetqeF4HnOWh2H8YXDYo+3I4j
         co2gZMNDFYcqJYnQfQm3e2n/8bKsP5PflOsXGirgG4dCLyxhVCYM5HWey3iYmdzZJws7
         Pn69rFmAT/akjE7WgjDhLv6uNK6d/zINR/9FKwNVb9FhtMAaFJlG68sjhq5dgKOrnkD7
         mdf17qjs7VjiZLcWvPXxVLAJ5CwAtx+jFtDj6Fsp3I7TcX91OdOMHC7cevspUrIdTo0k
         cD+PqEyD01M1UEMIbiPvws41KbsSpS5ycmQXmDMVYph+ONwh+1hcJ15NbHvv5D9hN4Km
         F17w==
X-Gm-Message-State: ABy/qLZd3C11XeHAXwc8QUU4iNE9F4a1d44jWO4CGlUqkVk8RWiZUeM7
	FpGpo8pVBLcpNUnpEAkaBl59rpqXlDNClg5mX5rAAA1wBEYHfZ0b01YvfzH7ds/4F+SSsyIjWtq
	wjfISE+6Um4t/
X-Received: by 2002:a67:ead2:0:b0:443:7599:d460 with SMTP id s18-20020a67ead2000000b004437599d460mr514998vso.1.1688643005211;
        Thu, 06 Jul 2023 04:30:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEOiF8Wo8ldpNlkhzPot2vQELEDG+c71tqhQGpmzmO1eN6k2V6nMi6SJLmlPXMGtcsuw7emcA==
X-Received: by 2002:a67:ead2:0:b0:443:7599:d460 with SMTP id s18-20020a67ead2000000b004437599d460mr514990vso.1.1688643004926;
        Thu, 06 Jul 2023 04:30:04 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id a25-20020a0ca999000000b0063645f62bdasm761336qvb.80.2023.07.06.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:30:04 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nadav Amit <namit@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, the arch/x86 maintainers
 <x86@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph
 Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, Sami
 Tolvanen <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Dan Carpenter <error27@gmail.com>,
 Chuang Wang <nashuiliang@gmail.com>, Yang Jihong <yangjihong1@huawei.com>,
 Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna
 Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>,
 Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH 00/14] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <57D81DB6-2D96-4A12-9FD5-6F0702AC49F6@vmware.com>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <57D81DB6-2D96-4A12-9FD5-6F0702AC49F6@vmware.com>
Date: Thu, 06 Jul 2023 12:29:58 +0100
Message-ID: <xhsmhwmzduvk9.mognet@vschneid.remote.csb>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/07/23 18:48, Nadav Amit wrote:
>> On Jul 5, 2023, at 11:12 AM, Valentin Schneider <vschneid@redhat.com> wr=
ote:
>>
>> Deferral approach
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Storing each and every callback, like a secondary call_single_queue turn=
ed out
>> to be a no-go: the whole point of deferral is to keep NOHZ_FULL CPUs in
>> userspace for as long as possible - no signal of any form would be sent =
when
>> deferring an IPI. This means that any form of queuing for deferred callb=
acks
>> would end up as a convoluted memory leak.
>>
>> Deferred IPIs must thus be coalesced, which this series achieves by assi=
gning
>> IPIs a "type" and having a mapping of IPI type to callback, leveraged up=
on
>> kernel entry.
>
> I have some experience with similar an optimization. Overall, it can make
> sense and as you show, it can reduce the number of interrupts.
>
> The main problem of such an approach might be in cases where a process
> frequently enters and exits the kernel between deferred-IPIs, or even wor=
se -
> the IPI is sent while the remote CPU is inside the kernel. In such cases,=
 you
> pay the extra cost of synchronization and cache traffic, and might not ev=
en
> get the benefit of reducing the number of IPIs.
>
> In a sense, it's a more extreme case of the overhead that x86=E2=80=99s l=
azy-TLB
> mechanism introduces while tracking whether a process is running or not. =
But
> lazy-TLB would change is_lazy much less frequently than context tracking,
> which means that the deferring the IPIs as done in this patch-set has a
> greater potential to hurt performance than lazy-TLB.
>
> tl;dr - it would be beneficial to show some performance number for both a
> =E2=80=9Cgood=E2=80=9D case where a process spends most of the time in us=
erspace, and =E2=80=9Cbad=E2=80=9D
> one where a process enters and exits the kernel very frequently. Reducing
> the number of IPIs is good but I don=E2=80=99t think it is a goal by its =
own.
>

There already is a significant overhead incurred on kernel entry for
nohz_full CPUs due to all of context_tracking faff; now I *am* making it
worse with that extra atomic, but I get the feeling it's not going to stay
:D

nohz_full CPUs that do context transitions very frequently are
unfortunately in the realm of "you shouldn't do that". Due to what's out
there I have to care about *occasional* transitions, but some folks
consider even that to be broken usage, so I don't believe getting numbers
for that to be much relevant.

> [ BTW: I did not go over the patches in detail. Obviously, there are
>   various delicate points that need to be checked, as avoiding the
>   deferring of IPIs if page-tables are freed. ]


