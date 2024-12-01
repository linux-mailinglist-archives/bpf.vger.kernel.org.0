Return-Path: <bpf+bounces-45911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB29DF599
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81193281561
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4051C2441;
	Sun,  1 Dec 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtpV4EV7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0011C1F32;
	Sun,  1 Dec 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057628; cv=none; b=aaW0fnZC2fpwUzFnhVExLcZYjUfc/kKhrdlBYBp71+A1Za7QrPFJSVMB/3CoIzyHuGxAyQTfJGllTwkRx4UWANgaK/qiFE7g4eRWlOr5+w6I6a0ibQKXXPSrR7bPrH/e4FAZK+ldGP+rs500ctqCII9xinHzelSKwy+nYVLH7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057628; c=relaxed/simple;
	bh=swYWVztl7R/XV5vyzXdHShiqPYgMrpHNocMOXVqEngI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpDecCcrsEi8hY8j0bxUez3PDpJVKMQ9RxJzaon/UZ+ZczPaSPhxwEQxffQCksTwVrO9rFbWiGkWqOVyZchPVgMZmsJslxMlBdMhX/SsCyt9NR/DfLyiFZ8orTgEGdu4U19SpBLGWqwBfPRPpVemlf6RJCUjjbZEynqO274mjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtpV4EV7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d87e0082b8so21274556d6.2;
        Sun, 01 Dec 2024 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733057626; x=1733662426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GVWtIbIAnpeYXqJoSnTz1UiTRNCVUNdZXjZbPFhtMg=;
        b=NtpV4EV7UqZYjkAXlT8Hm+LGh0+e1Adf0CNlhjuahZXhU1+VXv5sZyl+VmQur2YuRi
         iMTRjY+DMHgoXUEjATI1np1LYb30Og4sCPBrY0HiINkut7zMdFXzlcR+SO8yjJ2cwnhg
         yNSYK4dk9zYS1DGdqHX0Be1DiKSndUbOkOWe3ma7gFdOQxvTucwwhmZOceUDryfrHmlV
         ojuprmEJMs4SV+EFz53d1him3muJ3Vc5AdAniTBJA1EPWdW2XIK6NHfxDeJpDdHGtpOW
         U9FqUoX6vF0EihE/JgT3ysfX10gFEthluBZt8oTd6xCyT/VCygr5E61nv5Sa0lXRn+94
         p8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733057626; x=1733662426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GVWtIbIAnpeYXqJoSnTz1UiTRNCVUNdZXjZbPFhtMg=;
        b=i3bfBCPO/eRP3FAwscwXlk1Uynl6LuFG1CGTw4AstDwPRUbn9Ic+WpZojGrDLaBeoP
         Ng78k7FxzxcXA835mKzo/GfS020jWBLZmou4Iw+vbVmzUdxd7xaKScYYB8uC4WHjl0qF
         QtlzV5y4Txw/OVY4Bhg14S6Vzhksmeq7qal7vO3bJpjX2gu+K0xbIhAkaHs+b5n6yldP
         NNMo0CD/zNKc54RnfeDNT5erePGu/97+UbH7rr6Duj4+A+cHygWUTcmqsd9UmBVwnne4
         5W+8/vIENJRVzoqsZlyGiBjh/o5wxKteXPkWExAwBHPr+LZXIoAr1Oi+Eh6KzjOHQ4vk
         T7wA==
X-Forwarded-Encrypted: i=1; AJvYcCVKGYE6KsI0Siqx/cH1LS3Lgr8y7bcnUAso9cv8Dsf2iqaK5mm/TkRpkvVmQvhSNeoZYB6g8rWl@vger.kernel.org, AJvYcCVze4+m6MQhHZkn70F2HXQpbktsW+W8h8xDrDmVK2RgW+FqU2QadC81wRWCbdmE2ZyksC3ldEpkLEKUf5ir2kfjtOk9@vger.kernel.org, AJvYcCWs2A0JI08UQn6sOP8iniAOA1d0FyeP64AyF0+P3dR4CVrg0wAR83oTYVbwnv9eP1JYSTq7u3yx/4SlhVg6@vger.kernel.org, AJvYcCXj25gsphJ3sez9tfawtbIp7qrtGkaNfrHnWrqqSI886ZvlDCb8wgDD8/3P/E+/SntnHGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoYzR64IzDma4WRs2h91jKWjhkQsrGS3oPkG364GbPpmHrnwr
	Pbqws2qkaDXvUgX7y4+NlttlYL+ro8JSaCCbGuO56WPPU2flcYmy3RNc3OxwIJY6GE+JZc/rQFk
	uv0pRp2h/SjxfKpH+e2Azo8BCVr4=
X-Gm-Gg: ASbGncuRUzt9KUQwGtT9GcFinJZmto0R94i4EqxT2CReCKeMH9pyx4MeBptoHLRdkx3
	abUk0GqYrQ1gNX0SKEcfRFZSdti+jEygoBIz7F41s3ER+MJ+1YWBpVJGAXQ==
X-Google-Smtp-Source: AGHT+IGgwtwOP6tqXQqLQyPFg+9HwWnvlYrKm6Wd3xlS9AEmYhzmzUm0uqeInm+oHP92XrlHvZzF0UtwHtdZBi62qTQ=
X-Received: by 2002:a05:6214:21e8:b0:6d4:1fbc:2f88 with SMTP id
 6a1803df08f44-6d864dac355mr310468856d6.39.1733057625664; Sun, 01 Dec 2024
 04:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241129173554.11e3b2b2f5126c2b72c6a78e@kernel.org> <20241129120939.GG35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241129120939.GG35539@noisy.programming.kicks-ass.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 1 Dec 2024 21:53:34 +0900
Message-ID: <CAC5umyh49maikh0E4pUB_28=rqG1k9rvtQ70XOJNDMxNsu03sg@mail.gmail.com>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ruan Bonan <bonan.ruan@u.nus.edu>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"longman@redhat.com" <longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Fu Yeqi <e1374359@u.nus.edu>, tytso@mit.edu, 
	Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B411=E6=9C=8829=E6=97=A5(=E9=87=91) 21:09 Peter Zijlstra <peterz=
@infradead.org>:
>
> On Fri, Nov 29, 2024 at 05:35:54PM +0900, Masami Hiramatsu wrote:
> > On Sat, 23 Nov 2024 03:39:45 +0000
> > Ruan Bonan <bonan.ruan@u.nus.edu> wrote:
> >
> > >
> > >        vprintk_emit+0x414/0xb90 kernel/printk/printk.c:2406
> > >        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
> > >        fail_dump lib/fault-inject.c:46 [inline]
> > >        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
> > >        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
> > >        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
> > >        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [i=
nline]
> > >        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inli=
ne]
> >
> > Hmm, this is a combination issue of BPF and fault injection.
> >
> > static void fail_dump(struct fault_attr *attr)
> > {
> >         if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
> >                 printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.=
\n"
> >                        "name %pd, interval %lu, probability %lu, "
> >                        "space %d, times %d\n", attr->dname,
> >                        attr->interval, attr->probability,
> >                        atomic_read(&attr->space),
> >                        atomic_read(&attr->times));
> >
> > This printk() acquires console lock under rq->lock has been acquired.
> >
> > This can happen if we use fault injection and trace event too because
> > the fault injection caused printk warning.
>
> Ah indeed. Same difference though, if you don't know the context, most
> things are unsafe to do.
>
> > I think this should be a bug of the fault injection, not tracing/BPF.
> > And to solve this issue, we may be able to check the context and if
> > it is tracing/NMI etc, fault injection should NOT make it failure.
>
> Well, it should be okay to cause the failure, but it must be very
> careful how it goes about doing that. Tripping printk() definitely is
> out.
>
> But there's a much bigger problem there, get_random*() is not wait-free,
> in fact it takes a spinlock_t which makes that it is unusable from most
> context, and it's definitely out for tracing.
>
> Notably, this spinlock_t makes that it is unsafe to use from anything
> that holds a raw_spinlock_t or is from hardirq context, or has
> preempt_disable() -- which is a TON of code.
>
> On this alone I would currently label the whole of fault-injection
> broken. The should_fail() call itself is unsafe where many of its
> callsites are otherwise perfectly fine -- eg. usercopy per the above.
>
> Perhaps it should use a simple PRNG, a simple LFSR should be plenty good
> enough to provide failure conditions.

Sounds good.

> And yeah, I would just completely rip out the printk. Trying to figure
> out where and when it's safe to call printk() is non-trivial and just
> not worth the effort imo.

Instead of removing the printk completely, How about setting the default va=
lue
of the verbose option to zero so it doesn't call printk and gives a loud
warning when changing the verbose option?

