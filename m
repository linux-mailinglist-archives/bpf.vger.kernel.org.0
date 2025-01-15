Return-Path: <bpf+bounces-48907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BDEA1192D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B2A7A3ACB
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BA22F820;
	Wed, 15 Jan 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY+PiwCZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583D22F3A0;
	Wed, 15 Jan 2025 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919944; cv=none; b=FIMU3alspwjEVuEjmTvPW9BQMHpkuBtVyLWcnKXYBMM04j9pTTBgGsbK9jGnFmc88FqYSzJpg5lzWEeHvm6MFD23OTtoN2dXogkA0G8EKdYLtg1McCfg/7ycTQxKtBnMO0YGlrgqd4p0DZZa9L4As6A3UAThxER0j2QdxDchnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919944; c=relaxed/simple;
	bh=XKENOgIBOcFJ1Ixn11DwRC+1OO9t+dwhEIs0TG0ausA=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGfW0UHy9CA4XKPmX2RFvzqvxI1gyKnEtj7qTEYotX5os3bWHEgI1C4s3RZYnDw6b5Wq2lzB37eTpgoPq9G6vSsO5sAh5ySVSQoQsBr0J7new6fhIuB0Zu9f7ludBb8FSNYfJGB+h7173+MeaQI78Fowhx/RVlTr3kpjTN9O1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY+PiwCZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a8b35e168so265777f8f.1;
        Tue, 14 Jan 2025 21:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736919941; x=1737524741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn1csCT/GVnGPTaPaSCG8wldp2T9Q83b/lBJN/si5VA=;
        b=LY+PiwCZR/pnvToxhyHBhjeYvr3qrDpG+FJg+pIxQaauPcgh1zagrKLBoS2Yeq3Op5
         FJRGvkKZqvLT54Wqkky6iJQZBW18NNcRYBxecnzqYON8Qck2FLlSWFROg/Tbg5M7I1FJ
         49wRpwD5YypqJaXVByKv+eUnJ95jB6I6ck7wwrlMjcbncHkRAUlYQbTtiDWQ1SQEHmUd
         6IM29ZDIJJlfF0SBYglvHSIv7O41gIHiMd2AqS+jaWdtCRhLYces7T3XVPBF9hmvlov9
         32+cF6G870RlGgUIpLqJcP9Gh7tSL1eekT0YrW1rHp6Hs0S4zry9z8l9BjfqHiLMteit
         1WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736919941; x=1737524741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn1csCT/GVnGPTaPaSCG8wldp2T9Q83b/lBJN/si5VA=;
        b=mVu9PYu9X4wydg8SBmWVlVOMvRFQl57Kplz7i1q90oyUoVFkXgYFV4dulwC7B91Gon
         Y6A1E3tfbFt2kpF1tB3Wwm7EthDwACObtweW+EQPjv+O8u2g1KUsvd+ldjx95uhX+NwK
         IVduejuiFOAbeMB6IBlhgtnu2eEsl84Sb6fnJ4S8m17uDai+5OBlSWJ0MoWLwW4z5gmw
         uAs1wyH5YtNDRw0zSbiSO40y8jcJr7Jt9NQI4qwXP4/z2QgfgRIqJK8nTfQqFeBybPlx
         dch8lQjFyW4UTro8CusvR0HCMsw+p/Q0zZZFuEQ/s6Y4sWDVC66ywrceKlrQkVhhgWFX
         1A+w==
X-Forwarded-Encrypted: i=1; AJvYcCWJEJLfJb8Uxgo8h66p5PJmNnZw+2UmBjdP3HNYALpwiubQDvYQ8P7bmFue65KjaSBN6eq6ipd21d/JP3cvuxpqOUwz@vger.kernel.org, AJvYcCWd0wTPTOReZ6hDIbzLxFugRFPBirKRP8lrjWU3exWmayORHib8VcxyAr/cW6hv1On5kgkytGBBP+4k6Kez@vger.kernel.org, AJvYcCX/rueNdGLCSqPGuY4Fmw4puxS8mfw957Y+QcYP/3WZz5c8/44aY6WjZ/C7bLlCMZ7BuxTREseGvj2S@vger.kernel.org, AJvYcCX3gVkvoXDwBr8FrzDReRlQo+DQ7Ahug7PNWBUqmIxQst4lRPl5UKQacyPzw5s8Y09kW8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtanvxhc8u+7sXog0ze6Zy3WNtqCxyTdmDYW9Qgl8L9SVSDAmV
	JDml5bQfVFGrz7O8Gg+JjjwzkkCipJWloiXDgvwuyYMgFAq7M1rc
X-Gm-Gg: ASbGncsZ+BknMFtFonQIIRj8Uz3vqdzzr9QzYgQPvIykjgZvNbqCO4+rIHfPNn2lKB2
	d8Pe06n4v8HOYCNDtNo1PFFFkcHggHTB7S0odWDDfEfVmdt+MYdrAlOK/PX2YNc7pMBsYl4qBt1
	KeScKS1lR2MhEIE9slMHIcnOQMzz8BiEm/lW0iyhm8eoRopMKpyvXslzEaQpQ0u+qKlel/CjqQJ
	oI2zymWR+dHT1HTeacT2ODSOKVU0SnxUbQx0VxeHu6ZZf7qJpF5ryJ1pRG6cNg=
X-Google-Smtp-Source: AGHT+IEp2uMXDIkOxShSAYjUBrAlKxhF4uX0JMMlo/sAFC+3wKNjBf0sJpCC3d++DiPXOy4W2WS6iw==
X-Received: by 2002:a05:6000:1445:b0:386:4a16:dadb with SMTP id ffacd0b85a97d-38a8b0c712fmr18653518f8f.11.1736919940759;
        Tue, 14 Jan 2025 21:45:40 -0800 (PST)
Received: from titan. ([5.29.15.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753ca42sm10098225e9.35.2025.01.14.21.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 21:45:40 -0800 (PST)
Message-ID: <67874b84.7b0a0220.3935f4.1f48@mx.google.com>
X-Google-Original-Message-ID: <20250115074538.02f1ce02@titan.>
Date: Wed, 15 Jan 2025 07:45:38 +0200
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, Sarai Aleksa
 <cyphar@cyphar.com>, mhiramat@kernel.org, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
 linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 rostedt@goodmis.org, rafi@rbk.io
Subject: Re: Crash when attaching uretprobes to processes running in Docker
In-Reply-To: <20250115005012.GA10946@redhat.com>
References: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
	<EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
	<20250115005012.GA10946@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 01:50:13 +0100 Oleg Nesterov <oleg@redhat.com>
wrote:

> On 01/14, Eyal Birger wrote:
> >
> > Its software, that=E2=80=99s working fine in previous kernel versions a=
nd
> > upon upgrade starts creating crashes in other processes.
> >
> > IMHO demanding that other software (e.g docker) be upgraded in
> > order to run on a newer kernel is not what Linux formerly
> > guaranteed. =20
>=20
> Agreed.

IMO There are 2 problematic aspects with ff474a78cef5
("uprobe: Add uretprobe syscall to speed up return probe").

The first, as Eyal mentioned, is the kernel regression: There are
endless systems out there (iaas and paas) that have both
telementry/instrumentation/tracing software (utilizing uprobes) and
container environments (duch as docker) that enforce syscall
restrictions on their workloads.
These systems worked so far, and with kernels having ff474a78cef5 the
workloads processes fault.

The second, is the fact that ff474a78cef5 (which adds a new syscall
invocation to the uretprobe trampoline) *exposes an internal kernel
implementation* to the userspace system:

There are millions of binaries/libraries out there that *never issue*
the new syscall: they simply do not have that call in their
instructions. Take for example hello-world.

However, once hello-world is traced (with software utilizing
uprobes) hello-world *unknowingly* DO issue the new syscall, just
because the kernel decided to implement its uretprobe trampoline using
a new syscall - a mechanism that should be completely transparent and
seamless to the user program.

This is totally unexpected, and to ask a system admin to "guess" whether
hello-world is "going to issue the syscall despite the fact that
such invocation does not exist in its own code at all" (and set seccomp
permissions accordingly) is asking for the admin to know the exact
*internal mechanisms* that the kernel use for implemeting the
trampolines.

Just like we won't add a div-by-zero fault to the trampoline, we
shoudn't add any instruction (such as a syscall) that isn't *completely
transparent* to the userspace program.

Best,
    Shmulik

