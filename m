Return-Path: <bpf+bounces-55022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE45A77228
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 02:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FF9168723
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6368635B;
	Tue,  1 Apr 2025 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JicIiCxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563A2E3360;
	Tue,  1 Apr 2025 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469085; cv=none; b=QCifJwu1ivOn3NUIVdCsCBhkvLWm1xC8VgbJtpzB1iSu++SJno7U8P6J2Ao6Dn0KGtevDO+bxCTNAC4yvDzLgM9FW0Y3Bh1yi07d4+WvNpZCiKvQCe+AUZunF62u0wXJhfAwTaFDv3K0PHfxVZosxinrvsVtkTM8P8lThUPjQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469085; c=relaxed/simple;
	bh=nUdu/zJn4wgpzoAmOqTRimhj+ytUl4BriFZ5OYJfGW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8asZ6TCZIUjAUSBeEU7ekyP6GOrjMBHr0kqQFADIm4m0VFbYU/1qqvZmqA9pMupZMV4WQVMsD+SFANZwjzQmzpTtrGjaJa9C9ZSBW2XUHmtnjngHxvCp6QfSA7hlE42NUgXrp0Xl5O3u5EcbJ4cbQvBvJHnBTTv8L9WPO2Vlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JicIiCxF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3996af42857so3926201f8f.0;
        Mon, 31 Mar 2025 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743469082; x=1744073882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0iYDOSfDrBlNSH8I6mrWL8jmdYFnSU1gxLCAkOXxFc=;
        b=JicIiCxF1XPSzcLUXm4fVnLoF8kUcAxkh18LlJnwaBsaWYaWA4Hmwjh8Npc9rRfN3M
         jVw2Y+DChtbEpMkdsEPg6SrR62RwPlcVOi4XWKv5EK/XyguxYNAeCoxeyZqvB8kkNnnL
         DrnE7L63fXPdjpaqc+kpw1vSZFL1WfPkyXIEjHGUy05gfpc4ubV1MYl4nJyrnOoyzv++
         CrI4MZDu0iKb55u3a4NeHvhW78eS1iQ7VfLVUVHRAzO0yoFm+hX71Ntl1Gwn94JKKTGt
         1kCKhzqCviLVi649jTwuZwTw5EU6qOKnppZUgJpREnO8xph8S+P8h2xfKhLSDDx0msUA
         7rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743469082; x=1744073882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0iYDOSfDrBlNSH8I6mrWL8jmdYFnSU1gxLCAkOXxFc=;
        b=i0ZII7xgfzoVYMoJIq/4efs5LNEsVogte6oTTo1gvNn+FNhFyPuqhmBMjBaKAe8Irq
         pmQ3BHXfpf3LCakLgrR2ipiflxe4SEVnBAumZerl9lLnrPR3LoSX6kejr23VsDufm8h+
         pqprqYgcp1mWMf3RUDdULG3AoUNmFGZPrQ3/6MQ4XrEHF1XZYf3gebWItR11HAyf6TLV
         mS8Vg2gy6wzypLVshvGNiuggh7tlmRFa+U1XwpAN8iFLbmWqRUX940oToIlMGYl43aCG
         oFKeU0rp5j2miehlUXmj8gmmghgmqbt1er+hgTA77TrUx4jr/VM/MxH7fbaYKqVOGpng
         EZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWfAj2cqIp/Zq1W6XNq6sT/REahVHKyeghFv7R9WoVrjY7Zo+0l8Uf1dOjnib7SOjlQMKs=@vger.kernel.org, AJvYcCX1qUuS0EZeqOo36hNRwfLzjlxE9sXQJ0j2Jp4hrf7W2sTbmqvmgIao9x9fq2AUmRKTlSRjpe9P7AuhciC6@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZxm2OPQZ3yKEQnXiYrrzIE/3coBy6V+b62jv6lgkwqcqFYSR
	JpJJFWY1bj1n7rckhJPQORotHKrp7wjeYvgBiEoarKucLnaFhiZaerp6PDP0NM7wDxrkS6SoEcE
	Z4iindOZjQQwiQjXvKjsi1dQZqIy7X4ep
X-Gm-Gg: ASbGncubQRTQecXfSuyVwPhwnI9m0RvnKNWxUiObVLBEQrnfQqqXbf9VxzTL25+cEHS
	Oci/s4cuAlW1z1kChZOEj2cMD206anVnOn8KBHWP5H6El89X6oOvdtIPn/McWq4FrLp8DMEK07J
	RuQZIbDX+75wdwd4lHFy/I1efad5f0x8c4OuMoPK+CBA==
X-Google-Smtp-Source: AGHT+IFlk3G2zYxRJMwjk4o5Y4bO1F4MGPYwtlysnw//yIzwHhOdEHlNTaSPnjITPpwzmi5G3cRc8i5Cf5r7VJkeNko=
X-Received: by 2002:a05:6000:420d:b0:39c:cc7:3c93 with SMTP id
 ffacd0b85a97d-39c11b9b835mr8415922f8f.18.1743469081837; Mon, 31 Mar 2025
 17:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
 <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>
 <20250331071409.ycI7q6Q2@linutronix.de> <39586553-6185-4b83-b18a-3716caf2f3cf@suse.cz>
 <CAHk-=wj1jFH2Gc2Pq+-m_32BL9-CbdD7vReTJgd7Wbt2_EnH3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj1jFH2Gc2Pq+-m_32BL9-CbdD7vReTJgd7Wbt2_EnH3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Mar 2025 17:57:50 -0700
X-Gm-Features: AQ5f1Jp-Ql02zVDgk6NuaN77iqrZ_5gNwycxoItRpXGJKC2W427iDqIaVxXr490
Message-ID: <CAADnVQLpSkaB7WtZDPiJ6qRBUjLE4tkwGo0i6Rqoko1aeLML4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 8:35=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 31 Mar 2025 at 02:59, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > Yes I was going to point out that e.g. "nmisafe_local_lock_irqsave()" s=
eems
> > rather misleading to me as this operation is not a nmisafe one?
>
> Yeah, it's not a great name either, IO admit.
>
> > The following attempt [2] meant there would be only a new local_trylock=
_t
> > type, but the existing locking operations would remain the same, relyin=
g on
> > _Generic() parts inside them.
>
> Hmm. I actually like that approach.
>
> That avoids having the misleading operation naming. IOW, you'd not
> have a "localtry" when it's not a trylock, and you'd not have
> "nmisafe" when it's not an operation that is actually nmi-safe.
>
> The downside of _Generic() is that it's a bit subtle and can hide the
> actual operation, but I think that in this situation that's the whole
> point.
>
> So yes, I'd vote for the "let's just introduce the new type that has
> the required 'acquired' field, and then use a _Generic() model to
> automatically pick the right op".

Here is the patch that goes back to that approach:

https://lore.kernel.org/bpf/20250401005134.14433-1-alexei.starovoitov@gmail=
.com/

btw the compiler error when local_lock_t (instead of
local_trylock_t) is passed into local_trylock_irqsave()
is imo quite readable:

../mm/memcontrol.c: In function =E2=80=98consume_stock=E2=80=99:
../include/linux/local_lock_internal.h:136:20: error: assignment to
=E2=80=98local_trylock_t *=E2=80=99 from incompatible pointer type =E2=80=
=98local_lock_t *=E2=80=99
[-Werror=3Dincompatible-pointer-types]
  136 |                 tl =3D this_cpu_ptr(lock);                        \
      |                    ^
../include/linux/local_lock.h:76:9: note: in expansion of macro
=E2=80=98__local_trylock_irqsave=E2=80=99
   76 |         __local_trylock_irqsave(lock, flags)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
../mm/memcontrol.c:1790:19: note: in expansion of macro =E2=80=98local_tryl=
ock_irqsave=E2=80=99
 1790 |         else if (!local_trylock_irqsave(&memcg_stock.stock_lock, fl=
ags))
      |                   ^~~~~~~~~~~~~~~~~~~~~

