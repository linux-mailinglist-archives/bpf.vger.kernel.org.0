Return-Path: <bpf+bounces-4223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F0749A9A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A812281285
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC38C01;
	Thu,  6 Jul 2023 11:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD888BFA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:30:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EA19A7
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688643019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUyIouoC8ahxmdxehnDEnuXDxYXuSzzBD+vRAySsvH8=;
	b=OMZJanea0rMb6HF2BLM4xXFyXtxZ+eTH15qub9a7GIs4lgPwtn4wgTsgT/bBi6lZ66Gcat
	fcfHmisSxo/52mdV3D8pvDk8TlvL7DhmK7WK8w+bqYaNPpNabpG0ZlmIg8pTO4zt6WINq+
	+St39V0sHFqA6Q63ybg2xLanQUygJiE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-2D8RaEJVNvObm_BeejJDLg-1; Thu, 06 Jul 2023 07:30:17 -0400
X-MC-Unique: 2D8RaEJVNvObm_BeejJDLg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e3871cf9so6547336d6.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643017; x=1691235017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUyIouoC8ahxmdxehnDEnuXDxYXuSzzBD+vRAySsvH8=;
        b=NFpIbjSySbLtEo09taCBjt9VJdNV3EBFaimAgmQpq0oAEh8+r/pfnvx2xOgEXnNiFm
         itITXgAMZpG663McBxrVOCzG3S8Bvvio0kyTJyLdOFnMAW8twBY/uDC9GzwY9vkkXGog
         E9ixW8XyblZtjEY12s3oaLAhZHbNIvPN3B0vWvAisJagHXpYqeQiiOpdIkQ/on71BcTq
         GbVQXOOSpwrGdVT2qOYrzIoXEv6NdRN2RuqTZ0kI2iM6d2HPPw33TENE7AQ/Uvu/zhCA
         w+ywVqpCROiBs+lLryALt3dQDlHdFyiq08/5NfcvCh6Pk8v5JeUyS7fmxsMccFoj5igZ
         jMUQ==
X-Gm-Message-State: ABy/qLbK/4LDhpV8nvELXL662tuGfaKoVqtPpitQvjrFcsWg6jFV5cf3
	PTSknmlYN3sZMmrTdFI2ZkPCDn68VaEkZUzhF7iDkvKJaamjFCJtfa+afjGkq9YGi0goOAMX7fv
	HV3TSNlyK8y7/
X-Received: by 2002:a0c:db08:0:b0:625:aa49:19f1 with SMTP id d8-20020a0cdb08000000b00625aa4919f1mr1114223qvk.62.1688643017308;
        Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGMC/kBtgH7sbrX8rD2ZgNOVsGU4yA48iFb2GJxy2p3hgBQJP/oIfvimw2fu1jmJDlCZa08A==
X-Received: by 2002:a0c:db08:0:b0:625:aa49:19f1 with SMTP id d8-20020a0cdb08000000b00625aa4919f1mr1114196qvk.62.1688643017072;
        Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y12-20020a0c8ecc000000b006360778f314sm751558qvb.105.2023.07.06.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:30:16 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau
 Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo
 Stoakes <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Kees
 Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH 00/14] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <20230705150328.16791f25@gandalf.local.home>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705150328.16791f25@gandalf.local.home>
Date: Thu, 06 Jul 2023 12:30:10 +0100
Message-ID: <xhsmhv8exuvjx.mognet@vschneid.remote.csb>
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

On 05/07/23 15:03, Steven Rostedt wrote:
> On Wed,  5 Jul 2023 19:12:42 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> o Patches 1-5 have been submitted previously and are included for the sake of
>>   testing
>
> I should have commented on the previous set, but I did my review on this set ;-)
>

Thanks for having a look!

> Anyway, I'm all for the patches. Care to send a new version covering my input?
>

Sure thing, I'll send a v2 of these patches soonish.

> Thanks,
>
> -- Steve


