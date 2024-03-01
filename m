Return-Path: <bpf+bounces-23162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405186E72D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B9C28966F
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182FF79C2;
	Fri,  1 Mar 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT4HH7r7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CA5228
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314032; cv=none; b=NpWj8IMm3d7efOQxv0HGxmM4Tv/e3qG9HFoqOhRIyF5b2btgixgIPzMDgc+1/9eIswI5yWSxVOi2CrhPxNz7lp2XchSzFO0FTeVxHXgdJFwCUwzoBldzh9yFMJYRHCFgoDeQmI2MLdz6xVqmjQU9XfYYq8+tdFI4ErSnL2wipCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314032; c=relaxed/simple;
	bh=cscJbfYfILxK1x5mOjioCWcRXohflXHVzAOkX9sd+kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzvYpdJ65Wv0dBsE7EJjZgeIyeCZMeY8D9Q3GPLw7s27WXcj6rIFhbKLtLv5AxXdi8t+wzqPpBuxiNJG+TUj9C2GpIF/VWToKx7o+0Yz6eOAnF6zr3U7MUMQBfMSTD/00vzIBnkBcBzGyffaQxARR5SB1ERg0ER+0jrVEQjBAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT4HH7r7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1506804a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709314029; x=1709918829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxJTc2fIW9k692ehMfBqRbVf3uLFv4WnpgpFv4U6Y+4=;
        b=UT4HH7r7+eQW5cVbTdsG0wNRbz02X2+QWNowxLV6G6Aon63ERij2Rb3ljyPrUwzlUc
         e7gGfTWob0zlvcoBGnetZsMQrUzxw18vFPwh8C0niOtSz3CjLJsGBbLYccIHvLBONw8K
         UkspHJLlNXDo/9fpff0S2wQP+Zdt5iJLxOBwhD9PxKzsGj6qkiCWlayUok0PEEYz+y0q
         hDlIAMtEhB+T7WyXuCQl3EXWfbyXIHb8p+qLLO+3LRzztWS6XegNF98o8S7+BSoRRVGl
         9dESJ/yS/nZNGgureJfgXh7frU89X7+pk8Ha/lY67/YtkMV0GaHSAAd0FpAitgnrAGgt
         v3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314029; x=1709918829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxJTc2fIW9k692ehMfBqRbVf3uLFv4WnpgpFv4U6Y+4=;
        b=VQiqDbGRrjylzOkU1XPectNA/UVs4M6n+Kw/wZSDsEzRFL/8UcytTfBCXSGSfufIOx
         +T22UULv3tFg6VfrHceeEUCG3Is2G55CB0c2/8cukxj+3IiA+qr3bQ1QADzxh7CtaWRf
         +Kih74cXIZq91nbIHosjZUvkI+MlThUTRFvcgny/LFRbNcxFJuBzpRdkvtg52zhgoWCB
         n25goYV8g19Xa/PfniunyXLBjkdVmz9HAh+Sd8QcB5fLu+oYmJQi9fNpYXkkez9dTDBb
         ZmR+bq+Qqc3vJFVkTE19mrnJEW7p1JqYSA+ADGMfYDw33gKsJwG4WEuegHZ+f8HEYDpU
         Ypdg==
X-Forwarded-Encrypted: i=1; AJvYcCV2beRy39BFSUZIm+BA4ymnADS9uJDLr94XSop+QwVGwqgdlQizGknNlvtC4U9L5kN0zkZ5GkAH8mHMwR2sum241ekB
X-Gm-Message-State: AOJu0YwCNxeZdqYWIcFhnLJOPLhfMRYn5c7d1NgWrutiseupwLWe2qZR
	AmVpnIEleKzdmDnl9ZvEY0wi3BFCNzvOwJ3LSmbKTodI5QSOenJSqz6jYZkjOzwjanDH9l7qFTQ
	9fZrOkaq7s0YkqSKq2ycS2r5WxMk=
X-Google-Smtp-Source: AGHT+IH9uuRL3NAi2NOD3TmmlAYyJYe31vVf0bhgzhumHaF6AHQN3CrpQGsYaTVRizvWeojcI3x20L2zf956IsAj7HY=
X-Received: by 2002:a17:90a:8c89:b0:29b:242d:b123 with SMTP id
 b9-20020a17090a8c8900b0029b242db123mr2295388pjo.33.1709314029561; Fri, 01 Mar
 2024 09:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava> <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
In-Reply-To: <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Mar 2024 09:26:57 -0800
Message-ID: <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, yunwei356@gmail.com, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:01=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > One of uprobe pain points is having slow execution that involves
> > > > two traps in worst case scenario or single trap if the original
> > > > instruction can be emulated. For return uprobes there's one extra
> > > > trap on top of that.
> > > >
> > > > My current idea on how to make this faster is to follow the optimiz=
ed
> > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > user space trampoline that:
> > > >
> > > >   - executes syscall to call uprobe consumers callbacks
> > >
> > > Did you get a chance to measure relative performance of syscall vs
> > > int3 interrupt handling? If not, do you think you'll be able to get
> > > some numbers by the time the conference starts? This should inform th=
e
> > > decision whether it even makes sense to go through all the trouble.
> >
> > right, will do that
>
> I believe Yusheng measured syscall vs uprobe performance
> difference during LPC. iirc it was something like 3x.

Do you have a link to slides? Was it actual uprobe vs just some fast
syscall (not doing BPF program execution) comparison? Or comparing the
performance of int3 handling vs equivalent syscall handling.

I suspect it's the former, and so probably not that representative.
I'm curious about the performance of going
userspace->kernel->userspace through int3 vs syscall (all other things
being equal).

> Certainly necessary to have a benchmark.
> selftests/bpf/bench has one for uprobe.
> Probably should extend with sys_bpf.
>
> Regarding:
> > replace the normal uprobe trap instruction with jump to
> user space trampoline
>
> it should probably be a call to trampoline instead of a jump.
> Unless you plan to generate a different trampoline for every location ?
>
> Also how would you pick a space for a trampoline in the target process ?
> Analyze /proc/pid/maps and look for gaps in executable sections?

kernel already does that for uretprobes, it adds a new "[uprobes]"
memory mapping, so this part is already implemented

>
> We can start simple with a USDT that uses nop5 instead of nop1
> and explicit single trampoline for all USDT locations
> that saves all (callee and caller saved) registers and
> then does sys_bpf with a new cmd.
>
> To replace nop5 with a call to trampoline we can use text_poke_bp
> approach: replace 1st byte with int3, replace 2-5 with target addr,
> replace 1st byte to make an actual call insn.
>
> Once patched there will be no simulation of insns or kernel traps.
> Just normal user code that calls into trampoline, that calls sys_bpf,
> and returns back.

