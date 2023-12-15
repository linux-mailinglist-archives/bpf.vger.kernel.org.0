Return-Path: <bpf+bounces-17932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8B813F88
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC491F22D6E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63927815;
	Fri, 15 Dec 2023 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlYgpdFF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A977E4;
	Fri, 15 Dec 2023 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-333536432e0so108055f8f.3;
        Thu, 14 Dec 2023 17:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702605588; x=1703210388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BPXHZiXrCumILWBdbm2jyfqq1EYY5OqKA7tVcfSWPY=;
        b=jlYgpdFFYhZAWqAHB5IBqWBGkbZUw7y/UkQSyY2plDrFQ8ZPpin4wqUgn96mlzwruW
         YCgEGYZiOsEJBuU0qf4ZZA4mUuaOvuyohXkOflRfaPX1epN49tLx+TCYap33a6OkMDCj
         5tPnSTTYz5nx5wHzmdpj/weIbZS2CWIXtOq8DnVQDd77vOq1ut+SwfxTPavMfrjCa/Ir
         Pf+483Yd2UsT3abY3doi7UCHfzKXU9yh8UmC4axdak7aqnT+fDyZWn0ibxFP8LhGcK54
         xLMT1QZ+t6cGE6/VXOV2q+fTFnjkZojpels6S0UyXXyD55a3UD2mYWbjrD7T8oi7uyCL
         0Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702605588; x=1703210388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BPXHZiXrCumILWBdbm2jyfqq1EYY5OqKA7tVcfSWPY=;
        b=reks1Z1jWYhSlxqUYrOOiotypmCWT3oLavbdqUWbgHws9TM5M0ZB11AOJx+DOxh7nM
         TyP/t1ZyUJ7nUM+Bi0oNTvyNo4oqc6Apam4roqOunmqiM9AfWkwhnGAKgiCwyM8DO2tq
         z0p+ceITuPUTZ/zKMgljuScZSfBjSXrrO021MLAm/dXlSsVoqBnIcGFQxumirpZHyIOt
         /KtXKpArNm908KRrMxn6mwVhV91DjE28yBY9fwL3EugfRfmZtfsDn5tzz9frjdFLe7Ih
         PR0ITo7/tM/6t9sCNUzBRfvE4o8XdfhZiE9jr1FL4iqoMn6KMmKVEVidmdaaGV8dELmk
         SZnQ==
X-Gm-Message-State: AOJu0Yxty8J42RbwK/TszEicZBQKTfE6ZMoxQZgbJwKi9BQRIErDbRjZ
	EAk4u4WpU258/MvFp/AN/vI73hf4dE9wIHEdy8A=
X-Google-Smtp-Source: AGHT+IEQ9/UVkiTTf2mynkBFhgR6IeL+g82WMufDcGhjlUpuHcP0aPoLuAa4ko36Eu3GeZlCWMCgLkRy74ioo1IewCY=
X-Received: by 2002:a05:6000:1183:b0:336:4736:e695 with SMTP id
 g3-20020a056000118300b003364736e695mr908420wrx.52.1702605587460; Thu, 14 Dec
 2023 17:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+dPML0DW=Miuq=n7nC8m4gcPj7Dk_nhedzs9zTE30arw@mail.gmail.com>
 <20231214204629.1b380b82@gandalf.local.home>
In-Reply-To: <20231214204629.1b380b82@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 17:59:36 -0800
Message-ID: <CAADnVQJSvFeqRT+x3y5AWOC396nOdZQ4Zf66Es-71PxBtpj_GA@mail.gmail.com>
Subject: Re: [bug] splat at boot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 14 Dec 2023 17:25:46 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Hi All,
> >
> > just noticed a boot splat that probably was there for lone time:
> >
> > [    1.118691] ftrace: allocating 50546 entries in 198 pages
> > [    1.129690] ftrace: allocated 198 pages with 4 groups
> > [    1.130156]
> > [    1.130158] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    1.130159] [ BUG: Invalid wait context ]
> > [    1.130161] 6.7.0-rc3-00837-g403f3e8fda60 #5272 Not tainted
> > [    1.130163] -----------------------------
> > [    1.130165] swapper/0 is trying to lock:
> > [    1.130166] ffff88823fffb1d8 (&zone->lock){....}-{3:3}, at:
> > __rmqueue_pcplist+0xe80/0x1100
> > [    1.130181] other info that might help us debug this:
> > [    1.130182] context-{5:5}
>
> Can you trigger this with CONFIG_PROVE_RAW_LOCK_NESTING disabled?
>
> If not, then I wouldn't worry about it for now, but this will need to be
> addressed when PREEMPT_RT is included.
>
> Basically, a spin_lock() in PREEMPT_RT is converted into a mutex, and mos=
t
> interrupt handlers and all softirqs are turned into threads. But there's
> still cases where spin_lock() can not be used. One is for interrupt
> handlers that will not turn into a thread (like the timer interrupt), and
> for when a raw_spin_lock is held. You can't have:
>
>   raw_spin_lock(rawlock);
>   spin_lock(spinlock);
>
> order.

Thanks for explaining.
It's fine without PROVE_RAW_LOCK_NESTING.

