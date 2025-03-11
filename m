Return-Path: <bpf+bounces-53868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1DA5D27E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A7C7A92C5
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E8264FA9;
	Tue, 11 Mar 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nobDFqKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA61E7C06
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731872; cv=none; b=IBCAXVKLU54UWRZc/NaE7TwmS9nrwy42TgB6fG7uQhkPDHDFLq41fKgaEiUty66dJ9x3Vlo3hYUsd8ZUiL7TmAofu7pSSOneinLl+jjD/f0uvy6Xi5gRtFpFX2DSG+OxwgoNhdqH7WxnUhTb6i89cqpyVBVdGqBFrdYWK9GXvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731872; c=relaxed/simple;
	bh=A36CVXayjmvvaW1VwVlP3kT7ro7Dga8TtWLoRyXHUw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ote9SES4qzl8GiZbQ5gsmSh8IbOZr2WVcc38bo/jil0hdDNXkDn7CN8l9x+eGM4to+vdECZt5jrfPZsjB50MvgvG+ZH9L58u3Nqq8Cn5m/ig8DaGV2//RhKljzkbWLWO3ddlvOE1tShtXUAajUp/JYT8iRl7WD5jYGx9HRIWJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nobDFqKe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913b539aabso2213734f8f.2
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741731869; x=1742336669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOAXAk2KXa+XTRWtgCfacuwFFvidihY7fqMUpjjCr8Q=;
        b=nobDFqKev9POuta7S5fsh3fzrq77fPvWkkOjSFxS+5NKpfq5qmHh7aBw9G4MuJgmP+
         +JI85hrUugWykAwkAt+Dws5Jh1EWCSnG80M2GbzTvg0nXPGae1wxDYY3DdoWu4f0eEHh
         mXGfzTMENiAzUV0dyd+Ps/fA4d/vd/UTMkQdnn6BS9p0dTLrnR2T5UeZJVn87DuY/bS/
         r+XiIgUebKn31TTsBc4rYeaB1eozQsczqVEwdg1/PpacRhn01UPSW1R8PJSUoFnh4/pA
         3EudjxjE/mWXJDCYH0NbKWF74qydFshAkn9LsD6HqoHgyrEB2CrR/+M/GwPVH9b05dox
         OU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741731869; x=1742336669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOAXAk2KXa+XTRWtgCfacuwFFvidihY7fqMUpjjCr8Q=;
        b=FP7jNU6LLM1Dfu3TY3xpcmkwC3yOPrbJrTq22sOOU4mFFti0jLTUnR3noshm4H5Wox
         Ud0HZDijtuMc/juIIcKg9/p+9sluxFPjKwvigklWIGeZEalCovQU43q6Sg65MZlO16ng
         UrHdEhlLwlKy4/ACJ4aWrhlKaEpi0WJOZu3fW84x7tTP8sc4gL4y2LOkaWdj4YyuIf2/
         FDDI2YSA0bc9Yr8lSFQrKsQRsnuQx49VkPPrLp5OmZGgJynHGLPN2x2aAX4mbR9BIoTl
         rakwJc/uuGdEA8zLJU5AYyQMe4/yDpf4P8tAe+hPHNJ1p8NDdb+vEcc9ucFVH1A47Dgx
         ataQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaDh1yryapDd9u06awXxKrRxX90Yo5GfiHj6Zc3GGkaHCeaE4URx7tvUZ4OLmFQBB7qmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwgEz0ybdzrM8gVRB8b+IozNzs0vJGx1d/KQ2JSTqHKSERgh9
	3zWMlbb/XnBSenLA/mFhTfGcNSsqp7Ue0zYLLVspRqGILvlqGuidGk05H9CMWDIGa7N6gw+fIUE
	vKtWiZMGR3AYS40iElQm5i9DhcQ0=
X-Gm-Gg: ASbGncsINDHiDrn48X3ftU6JPF5rqeXhj4vy4CSsNFVAOTvobTsNWE21x2W+rx3MitV
	NvtwHr1kpnhiXWGADvK66eNSr/5cZ7xBot7ys2j14ObcgUxr32h9ENElZjSf3ikT++WD86wjs/X
	7sdXYiJBz3MQlDT+iTjpk2I3F/+Q==
X-Google-Smtp-Source: AGHT+IFr5cNLKtyEHiIseRQ0hcMIRT9PUhdSGq8vWKKtjVW+w5dRZcSyz2nZIgB4AIRZ0apB4EK1xyVdI49AxcjB4b0=
X-Received: by 2002:adf:8c09:0:b0:391:3915:cfea with SMTP id
 ffacd0b85a97d-3913915d3c9mr9460157f8f.38.1741731868893; Tue, 11 Mar 2025
 15:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com> <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de> <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
 <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz>
In-Reply-To: <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Mar 2025 23:24:17 +0100
X-Gm-Features: AQ5f1JrBx1xboasj7wpVadRwAZkrWICF3qXP1iKeT5lMrlXWHmypeXNk7sXFFeE
Message-ID: <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:21=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/11/25 17:31, Mateusz Guzik wrote:
> > On Tue, Mar 11, 2025 at 5:21=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> >>
> >> On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
> >> > On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
> >> > > +#define __localtry_lock(lock)                                    =
  \
> >> > > +   do {                                                    \
> >> > > +           localtry_lock_t *lt;                            \
> >> > > +           preempt_disable();                              \
> >> > > +           lt =3D this_cpu_ptr(lock);                        \
> >> > > +           local_lock_acquire(&lt->llock);                 \
> >> > > +           WRITE_ONCE(lt->acquired, 1);                    \
> >> > > +   } while (0)
> >> >
> >> > I think these need compiler barriers.
> >> >
> >> > I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatile=
s.html)
> >> > and found this as confirmation:
> >> > > Accesses to non-volatile objects are not ordered with respect to v=
olatile accesses.
> >> >
> >> > Unless the Linux kernel is built with some magic to render this moot=
(?).
> >>
> >> You say we need a barrier() after the WRITE_ONCE()? If so, we need it =
in
> >> the whole file=E2=80=A6
> >>
> >
> > I see the original local_lock machinery on the stock kernel works fine
> > as it expands to the preempt pair which has the appropriate fences. If
> > debug is added, the "locking" remains unaffected, but the debug state
> > might be bogus when looked at from the "wrong" context and adding the
> > compiler fences would trivially sort it out. I don't think it's a big
> > deal for *their* case, but patching that up should not raise any
> > eyebrows and may prevent eyebrows from going up later.
> >
> > The machinery added in this patch does need the addition for
> > correctness in the base operation though.
>
> Yeah my version of this kind of lock in sheaves code had those barrier()'=
s,
> IIRC after you or Jann told me. It's needed so that the *compiler* does n=
ot
> e.g. reorder a write to the protected data to happen before the
> WRITE_ONCE(lt->acquired, 1) (or after the WRITE_ONCE(lt->acquired, 0) in
> unlock).

I think you all are missing a fine print in gcc doc:
"Unless...can be aliased".
The kernel is compiled with -fno-strict-aliasing.
No need for barrier()s here.

