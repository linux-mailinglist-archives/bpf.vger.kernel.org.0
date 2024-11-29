Return-Path: <bpf+bounces-45884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D69DEB36
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A407161030
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60AD19C552;
	Fri, 29 Nov 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLcHSN0f"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE014E2E6
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898446; cv=none; b=XwSP5QU0DDkeLWfJpfzElUgXis90RHNvX2mJWze/qZAhh+oIEn4E1mCHdFL4GbCirZ8GeDuoDpHYyYNnWhoFDNy9TCFIgO3ROj05zisLk+aPVrKFzcsL6teGI7+7rIHQCfdvljW5die/mu/erD93Ns3LSYSdqmdeZnQtlftcuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898446; c=relaxed/simple;
	bh=az39fDf+MhRZMw9gFTdPNqw5XUR3nQ20B8N3wHXK3SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ub2B9/fUim6y7TZDsoCT/Fkxmf4XRdqaIf+AEhlI+hh2do9Y5ptubN+RFwQG8VX60HVAj8S0ikxtLgC8elWx2/UwC9uHRkQWIJo8i9iaV9dBWVAZWjcNPzFuDGK0HIEjslES+Mq2sabTbx1M8dxR8RyLGmkti+dz/fKfF7wse5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLcHSN0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732898443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oxQ2EopQjYunks2eIxH2qb+BPEjEvokj+yvCZveiP0=;
	b=HLcHSN0fqRsvoYLqKz7fg/gLlrP6cRc2KBHRkF3VNk7yE75efKv4ol64zvgZmSAvYUfjgG
	ALaA2Gf5rIs0wNHGD4Nj/70UF3QZwf9RzM0UkamRTQ7fpwFup/ck7sQOGIc4VzBUooSFqo
	YtmaaA5wkUzhdGK3Dh+vPfhOUTviWSM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-RpQ0mlaWOD2K5fsERC4OTg-1; Fri, 29 Nov 2024 11:40:42 -0500
X-MC-Unique: RpQ0mlaWOD2K5fsERC4OTg-1
X-Mimecast-MFC-AGG-ID: RpQ0mlaWOD2K5fsERC4OTg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3729a555dso28321606d6.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 08:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898442; x=1733503242;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oxQ2EopQjYunks2eIxH2qb+BPEjEvokj+yvCZveiP0=;
        b=Ctaup6/RSasz4//PIcySbImkAseXIOTh0Lx8JFCyN1t1n5ymibYSPL0fPxMXvf5Jnc
         HmXjCbq51iBmaDyHX6Q2nd6xXHcR/eEH17zhRZeA0dfjtXEh+cu91x+LAE80rL1QrDln
         +acbJksC/aVSMOVu+fFMgsJk7lWBcCWH5lSQEWuBM6D4ok2rJ8LzhjCvy/+ixwt2zeSa
         fyzzGM6A6trrR4UC8GS4/yzNs6RHNChvWSG/EhrQgxG0ZLtO900C6EyQ4hFbfQ+nNUD8
         Ov29ANJdzphtwvt36kbbk64ve3yxgHEkdRM+T6uz8AUNFckXJf28QFxS8r5QWHyO8/pD
         NgMA==
X-Forwarded-Encrypted: i=1; AJvYcCWJmkbAmNVmR+UoWnHNPKsD0vLZ4lJ2UzH1/GVGRrPQRDRuamV+tx3LdUSoLRih+DXhN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEuiw8ir1ncoDHeLpFkqHyhinZmZ70SAfC3Py12pFnWnkycuEo
	FRbLbuh7QJwdMa8X8i0SiJvskeLBrj56ZL14qRKt7IHDgDbDj/kI6OeLDXhI6NWxapd9KFHyWzU
	SCi35+tvj8/9/mHSOsx3ORXClRb6HFXrIWWi58L3ZxzTDaBtQOw==
X-Gm-Gg: ASbGncvClTdew9J4bcvgcQPuNkZGepvyuVWwR9TuzlKoVbC71UYbya7gK2nFUpS/PFX
	uzSSsK2hV8Lb6zLUNnuN/KSDZfsQHyddqJEtgKm1f4qoN1Xefbz6eQHjKRS87umJCEZrnmShVWO
	KGi3o/xfSWEUUjx2fyYPOIZijI51i1cUiMdn/iakV7HWL31ALW1fo6XKjJKsq1Z7BHx/+AxUr2C
	TDPiZCuF2zkJPFT0NweLiVTNKyvsHinilp4DHQv2HvADSTouvSpOfho785t0CQR7vT9FeRIM0j7
	mCnHv8kAyXseM5EASlYASsa5R05GAiEqMg0=
X-Received: by 2002:a05:6214:c62:b0:6d4:1a99:427b with SMTP id 6a1803df08f44-6d864d8e4famr151983746d6.30.1732898442040;
        Fri, 29 Nov 2024 08:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9RcRtBRvnIDfzr2/iRL96o9fRk4J92A47PIoCtseLUfNoii93tfgZQ/3Nm/m06TGA/XDcKA==
X-Received: by 2002:a05:6214:c62:b0:6d4:1a99:427b with SMTP id 6a1803df08f44-6d864d8e4famr151982836d6.30.1732898441562;
        Fri, 29 Nov 2024 08:40:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8752064besm18111326d6.71.2024.11.29.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:40:40 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
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
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <Z0Oeme2yhxF_ArX0@pavilion.home>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home> <Zz3w0o_3wZDgJn0K@localhost.localdomain>
 <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zz4cqfVfyb1enxql@localhost.localdomain>
 <xhsmh1pz39v0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z0Oeme2yhxF_ArX0@pavilion.home>
Date: Fri, 29 Nov 2024 17:40:29 +0100
Message-ID: <xhsmhttbqm1s2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/11/24 22:46, Frederic Weisbecker wrote:
> Le Fri, Nov 22, 2024 at 03:56:59PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 20/11/24 18:30, Frederic Weisbecker wrote:
>> > Le Wed, Nov 20, 2024 at 06:10:43PM +0100, Valentin Schneider a =C3=A9c=
rit :
>> >> On 20/11/24 15:23, Frederic Weisbecker wrote:
>> >>
>> >> > Ah but there is CT_STATE_GUEST and I see the last patch also applie=
s that to
>> >> > CT_STATE_IDLE.
>> >> >
>> >> > So that could be:
>> >> >
>> >> > bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
>> >> > {
>> >> >    struct context_tracking *ct =3D per_cpu_ptr(&context_tracking, c=
pu);
>> >> >    unsigned int old;
>> >> >    bool ret =3D false;
>> >> >
>> >> >    preempt_disable();
>> >> >
>> >> >    old =3D atomic_read(&ct->state);
>> >> >
>> >> >    /* CT_STATE_IDLE can be added to last patch here */
>> >> >    if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
>> >> >            old &=3D ~CT_STATE_MASK;
>> >> >            old |=3D CT_STATE_USER;
>> >> >    }
>> >>
>> >> Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL che=
ck,
>> >> but we get an extra loop if the target CPU exits kernelspace not to
>> >> userspace (e.g. vcpu or idle) in the meantime - not great, not terrib=
le.
>> >
>> > The thing is, what you read with atomic_read() should be close to real=
ity.
>> > If it already is !=3D CT_STATE_KERNEL then you're good (minus racy cha=
nges).
>> > If it is CT_STATE_KERNEL then you still must do a failing cmpxchg() in=
 any case,
>> > at least to make sure you didn't miss a context tracking change. So th=
e best
>> > you can do is a bet.
>> >
>> >>
>> >> At the cost of one extra bit for the CT_STATE area, with CT_STATE_KER=
NEL=3D1
>> >> we could do:
>> >>
>> >>   old =3D atomic_read(&ct->state);
>> >>   old &=3D ~CT_STATE_KERNEL;
>> >
>> > And perhaps also old |=3D CT_STATE_IDLE (I'm seeing the last patch now=
),
>> > so you at least get a chance of making it right (only ~CT_STATE_KERNEL
>> > will always fail) and CPUs usually spend most of their time idle.
>> >
>>=20
>> I'm thinking with:
>>=20
>>         CT_STATE_IDLE		=3D 0,
>>         CT_STATE_USER		=3D 1,
>>         CT_STATE_GUEST		=3D 2,
>>         CT_STATE_KERNEL		=3D 4, /* Keep that as a standalone bit */
>
> Right!
>
>>=20
>> we can stick with old &=3D ~CT_STATE_KERNEL; and that'll let the cmpxchg
>> succeed for any of IDLE/USER/GUEST.
>
> Sure but if (old & CT_STATE_KERNEL), cmpxchg() will consistently fail.
> But you can make a bet that it has switched to CT_STATE_IDLE between
> the atomic_read() and the first atomic_cmpxchg(). This way you still have
> a tiny chance to succeed.
>
> That is:
>
>    old =3D atomic_read(&ct->state);
>    if (old & CT_STATE_KERNEl)
>       old |=3D CT_STATE_IDLE;
>    old &=3D ~CT_STATE_KERNEL;
>
>
>    do {
>       atomic_try_cmpxchg(...)
>
> Hmm?

But it could equally be CT_STATE_{USER, GUEST}, right? That is, if we have
all of this enabled them we assume the isolated CPUs spend the least amount
of time in the kernel, if they don't we get to blame the user.


