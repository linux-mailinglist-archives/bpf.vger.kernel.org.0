Return-Path: <bpf+bounces-53294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8EA4F927
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3483A6EDD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3D1FDA7E;
	Wed,  5 Mar 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTht5iVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BE155342;
	Wed,  5 Mar 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164687; cv=none; b=uroCXQ6ZcB30dZRbsWdNSgE7GihFroHlOpE6RTxideOlyV5lSduBnmKZ350Q1e7kCnVs4o1To3SRWDOyLwjreumjB3l27oo/J0UDPgHETK0KxYDZ27kh7X4WpDuPYEpovDb8wg4O/ooqPc8NnZ6t8h05XSDRcGvvfkMEdeXBxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164687; c=relaxed/simple;
	bh=Cn0cFNTAZkpwSEDVzdYgVrdTOxR6wqjxB47H6BWXgbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbuS4mFdL/semVLlTWGtQfDeOnbYHsTTjd/3TLAEeqDPLpSMgdtidUIztxsxKgy/IZ7CsxIx0gXmjQvVZsWn6ylcXPE6tzkUjfbHnMAM7F/QwWPBmlPFc7r634V2/lAs/iy47rUmOCQ22DW/ApPhq1Eg1id55fNoVJTJHLCPNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTht5iVc; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6fd47dfe76cso49120807b3.3;
        Wed, 05 Mar 2025 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741164685; x=1741769485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQXKjZHa5r4213wcOvfbsp5orLWVfyC4Oxpcslkw+cY=;
        b=PTht5iVcGGIxtI0Pl8tUHXs2adhL7j2hIOkWxghVyzJAMQdkdtPISeUWOeRa5N0bH+
         iTfBTDFLv80f/v71g+9gLFErLPSrdOhrF1bIxjRhJ45G1ZabL0pr7i3nFPOkveWukILv
         4lDIyuzSPHjiYSKb2vcaU7LWXUl2i6mcHQIVC0W6rOEpu0OYOm8yBKpkGYaKaNCTYk6f
         KW7UHjNiNStP4iUMNm+RngvEYkdBPl+YhulY3PYWyGZpnwYErt4IbTjO3MRqh8wmPovj
         cgp9UnfgyqpcjdICbZAomHztLpjVPZyooQ29UdYRTAGaROexxoapNsB0f84oAPXtHwrT
         q0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164685; x=1741769485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQXKjZHa5r4213wcOvfbsp5orLWVfyC4Oxpcslkw+cY=;
        b=GUlUtmyWHgGMYPxkHHM2s545tyxO6pjlJ6lF9L/vD9cEgyyqd47EFDllpBHSygrlIP
         aamgyUldXhfpw9PFXIPDyvV1zTl/oAKiq41uTHh243YiSn7DVWWNJxoTd7B8b8QYFKZm
         bC5ujS6Ljj/Z0hJDKut+7IOkMz3tuIoXKJNMiU4g4yqcYx3RwIuZ3BT+TZ88H/HtC68N
         8MSqrpRy9oso/DfZnO5WleIS7uMBlJATcEaJh2TsEi6v4jNahMhkfygf49pdZmAobRxW
         Z1VxFvWGk1OlxqPpEdrCy5YYSHUdTgJPSdszpYngeHDHx6IMjSBE7xmD9oZ86riOw++J
         Kf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUZsDx5YNTarkSNfm4SDNv3dvxSP4J61Kfz+ULpRonTw7mPw4GTK9+Gq/g77PEn4e3BihIvqSfYobhDq8YoZftXL36G@vger.kernel.org, AJvYcCWEv26YWeFImkuF6MjeFZVHtRebJoobstcpTXnrjogf9qtGS2cy8cmw3i23VD4PMupbegCyJy4ierfPgCtv@vger.kernel.org, AJvYcCWi2Z1dzwAsfK+kxn5iUvtvfRhPzHr7SS82J/KoNKUPWLkL37nnNViRUX+6TIJRIim5+OQ=@vger.kernel.org, AJvYcCXyJtqrg83P2nGyX2Oo/fWPP5dmOAAqF8THZAGhgOrVjOwdGSrHrJgPTWImG0m56aQ3QreWwZwS@vger.kernel.org
X-Gm-Message-State: AOJu0YyesAm3ZJIdFgOcOMMSsU+OW+1tNLHxeY0BEsf5gQ5S9n1idOE2
	MFw8Qz1nu6BVC2C/IDJj+BmidV/iN2GcHvRhlQ4OKxN+BFYKuXGLzpnU7cIiguM8Ic8jfC25FyJ
	NEwXYRVudY0q67KBCKRCuGbgVVqA=
X-Gm-Gg: ASbGncsKwPmZrHiOrlz5uqmu3bMapUEJ1rrUyjuftydXHgQobnhKP/EW7BpmEN7+ccs
	eBOD/OXqcYG4DWcExzP52BVSPTGIXs3hgJNtf6lFURoJ0gJbNSsiodpBr8buBCCHyCTLBxU0hl/
	YmYwAokO2bmII/N9/oVkR+Wg+6ag==
X-Google-Smtp-Source: AGHT+IHJHBBsGtFfE4z2mPAk21mETs2dOEwyYu6mGke3XwoXSNX7h5iKIMLg2OfM/L0feLDcyFXEy1rx6kLoqIY81uk=
X-Received: by 2002:a05:690c:6c82:b0:6ea:5da9:34cc with SMTP id
 00721157ae682-6fda2f6ae73mr31701457b3.7.1741164685004; Wed, 05 Mar 2025
 00:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net>
 <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
 <20250304094220.GC11590@noisy.programming.kicks-ass.net> <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
 <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com> <694E52E0-C9E5-49D2-A677-09A5EE442590@zytor.com>
In-Reply-To: <694E52E0-C9E5-49D2-A677-09A5EE442590@zytor.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 5 Mar 2025 16:49:47 +0800
X-Gm-Features: AQ5f1JpDhhwKYSzWqZc9I3K1CFCu-n4ujPK1HFEHMI_ufAKecdbRxf_kS4Jud7Q
Message-ID: <CADxym3Zu1u1xF0k+N4gZ50jHtZ9iRRQ0ZTtt_koG8Ta+B0DPJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, mark.rutland@arm.com, 
	alexei.starovoitov@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:30=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On March 4, 2025 5:19:09 PM PST, Menglong Dong <menglong8.dong@gmail.com>=
 wrote:
> >On Tue, Mar 4, 2025 at 10:53=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> w=
rote:
> >>
> >> On March 4, 2025 1:42:20 AM PST, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> >> >On Tue, Mar 04, 2025 at 03:47:45PM +0800, Menglong Dong wrote:
> >> >> We don't have to select FUNCTION_ALIGNMENT_32B, so the
> >> >> worst case is to increase ~2.2%.
> >> >>
> >> >> What do you think?
> >> >
> >> >Well, since I don't understand what you need this for at all, I'm fir=
mly
> >> >on the side of not doing this.
> >> >
> >> >What actual problem is being solved with this meta data nonsense? Why=
 is
> >> >it worth blowing up our I$ footprint over.
> >> >
> >> >Also note, that if you're going to be explaining this, start from
> >> >scratch, as I have absolutely 0 clues about BPF and such.
> >>
> >> I would appreciate such information as well. The idea seems dubious on=
 the surface.
> >
> >Ok, let me explain it from the beginning. (My English is not good,
> >but I'll try to describe it as clear as possible :/)
> >
> >Many BPF program types need to depend on the BPF trampoline,
> >such as BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_EXT,
> >BPF_PROG_TYPE_LSM, etc. BPF trampoline is a bridge between
> >the kernel (or bpf) function and BPF program, and it acts just like the
> >trampoline that ftrace uses.
> >
> >Generally speaking, it is used to hook a function, just like what ftrace
> >do:
> >
> >foo:
> >    endbr
> >    nop5  -->  call trampoline_foo
> >    xxxx
> >
> >In short, the trampoline_foo can be this:
> >
> >trampoline_foo:
> >    prepare a array and store the args of foo to the array
> >    call fentry_bpf1
> >    call fentry_bpf2
> >    ......
> >    call foo+4 (origin call)
> >    save the return value of foo
> >    call fexit_bpf1 (this bpf can get the return value of foo)
> >    call fexit_bpf2
> >    .......
> >    return to the caller of foo
> >
> >We can see that the trampoline_foo can be only used for
> >the function foo, as different kernel function can be attached
> >different BPF programs, and have different argument count,
> >etc. Therefore, we have to create 1000 BPF trampolines if
> >we want to attach a BPF program to 1000 kernel functions.
> >
> >The creation of the BPF trampoline is expensive. According to
> >my testing, It will spend more than 1 second to create 100 bpf
> >trampoline. What's more, it consumes more memory.
> >
> >If we have the per-function metadata supporting, then we can
> >create a global BPF trampoline, like this:
> >
> >trampoline_global:
> >    prepare a array and store the args of foo to the array
> >    get the metadata by the ip
> >    call metadata.fentry_bpf1
> >    call metadata.fentry_bpf2
> >    ....
> >    call foo+4 (origin call)
> >    save the return value of foo
> >    call metadata.fexit_bpf1 (this bpf can get the return value of foo)
> >    call metadata.fexit_bpf2
> >    .......
> >    return to the caller of foo
> >
> >(The metadata holds more information for the global trampoline than
> >I described.)
> >
> >Then, we don't need to create a trampoline for every kernel function
> >anymore.
> >
> >Another beneficiary can be ftrace. For now, all the kernel functions tha=
t
> >are enabled by dynamic ftrace will be added to a filter hash if there ar=
e
> >more than one callbacks. And hash lookup will happen when the traced
> >functions are called, which has an impact on the performance, see
> >__ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
> >metadata supporting, we can store the information that if the callback i=
s
> >enabled on the kernel function to the metadata, which can make the perfo=
rmance
> >much better.
> >
> >The per-function metadata storage is a basic function, and I think there
> >may be other functions that can use it for better performance in the fea=
ture
> >too.
> >
> >(Hope that I'm describing it clearly :/)
> >
> >Thanks!
> >Menglong Dong
> >
>
> This is way too cursory. For one thing, you need to start by explaining w=
hy you are asking to put this *inline* with the code, which is something th=
at normally would be avoided at all cost.

Hi,

Sorry that I don't understand the *inline* here, do you mean
why puting the metadata in the function padding?

