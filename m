Return-Path: <bpf+bounces-54078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D7A61DDC
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 22:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F0F19C0E25
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26145193436;
	Fri, 14 Mar 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB3Pgvhs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12610BA38
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987100; cv=none; b=cQi7uAeNxg/i9rHoyH9TgWPpREhM+MreM0oKUT17Jub9qckaSRwpUvzd+AnovtEOIe+8x6JA8xbDflLQ+PA94xjMiW+GVYcqAfPCJMz/kbecb5D0lIxWJPQc5C0h4WBmsxiRKzjzGyB8X7jsIsDD2tCKeziy3Z2iQ1uVqoX2uQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987100; c=relaxed/simple;
	bh=WAV04ApMVn96Iw4iwDfmeg6TkHSzEUGb8ajiO5x/IIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqK0Ep/K9hptg9MLB0npwgBJR0vHmLSAD0igcwGnGTSIfAHBVpjD57U2CVQe1dGDX706rHgsPuU7tnKfMZTMrmp/UKvt4ECau13C4VXJuYMSnQPM+Veba6jVV6EWOOLlynfrF3RxN3cSJsrZWugiacGWGkeOtzLdknM17pPDd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB3Pgvhs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1995275f8f.3
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741987097; x=1742591897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkAtYsDN/lRAhYyBlWsg6XpIv12Yc1rU5UVL3MTjmWM=;
        b=YB3Pgvhs2GKDIAQiav0JspRvctmQuHrCrFa4EoSoX+jzI/LC3sD5W1OEMfrTL7fNww
         H1z+49WjiSC7CPcJI63Ff9sc5EEScGQuhAcgDhGDrUqVuaRGiyR/QK0I7Zqy/00Mx/Zs
         7/JQAKV9KgB1xs/ctemWGvohV7ooeRqxmOXhcsULT7RPZcYfsP9a0KwMIApm6ZmYu3rn
         X61dEunWIxncQsTKLo7JI71Ihohl58ZrGR12mhjN1J+IIwKlojjT6L7RRfA0FjHOWl17
         wh1Byk7ZFtC1wDYsWFAIxSWHKTAKvg7SWEwE7vVBRGfkUX/1yqcILgk876EpX/AM5sOU
         QKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741987097; x=1742591897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkAtYsDN/lRAhYyBlWsg6XpIv12Yc1rU5UVL3MTjmWM=;
        b=TlXtZYlyE6JPcBQTdKlFiwPZR8Ab5GsWnP8pMwem267cUfSuKPlOfM/KSwRtgkZbF5
         BzgYakzG/8ZchaIM7jqbJq8ZIDg7wAS6dKMMNC3M7RiSPcunFTtQxcctTSVZiFvWPyR7
         vRsbGtlzT3s8jbQZIzCQ7maWjFIVke/zxNOHPk00dZba2yp2iTorKcTaIQvY3FT9xHx0
         hFrOxm5J+9Xc4jd2dg3qDxSu4IkUw0Q2+ZIM4sqDTMf9XJ4E/zWgSFOVzULzLcjcxBiU
         W0HgYrQVYBq/BaXbXHTNJ80h2eYvy65cOf8u7j0KiA9JgkBZbcZcisKLPaVhlDdB6IDH
         7fhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU39m3eusoJwnTG4OVV/3GJ2+xx5LuWPLVPaZ1IMnsbqNf1Q85VJtRUGysGgsslLmLIuVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8docZlhmeR2EeNCXwbVSqrjC3acgVN7tDgJ6zIs9/57tF8fDh
	0F0NlCaL+M2LsNpiIP8AYxGrUo0TcnHpF1KVfB9Eaq9nEydyfkdYpY583yL0EqBzBD4UDMz5DvK
	MuXWI8WNyuF/z9aOBR2mvGBKEQ1s=
X-Gm-Gg: ASbGncs2RIbeMmWFcf+bIQNgTZBN3bu1xm91zbQQUwZwrBPQFDg46/jWTkvkUHj3JrO
	etIK1oziu0fID05ohKuig+FEwyiNvr5wHTES94gyCg4adMxZ8Dl9xXTwB1xNMr2idJz+C8bOWHM
	I2SPEvvvmO6xDkwweHbtC5YDkWW8kBOj/gBzxO9EmH7g==
X-Google-Smtp-Source: AGHT+IHi7eVc8OKSnPQTa6FoFbDKV4U+3MMoEemj7DQDHnE36dRNlyylP++snmK2/RJToqSwtAGHbcwU0T9OH7IkrZg=
X-Received: by 2002:a05:6000:4709:b0:391:4390:97e3 with SMTP id
 ffacd0b85a97d-3971dbeaf46mr5460787f8f.33.1741987097011; Fri, 14 Mar 2025
 14:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com> <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de> <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
 <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz> <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
 <496ff0d2-97ac-41f5-a776-455025fb72db@suse.cz> <CAADnVQJnZB52jvQDhA8XbhM3nd7O6PCms1jBKXx+F0jn+HA6fg@mail.gmail.com>
 <c2a6bd1b-bfe2-4716-96e0-1026d4080de2@suse.cz>
In-Reply-To: <c2a6bd1b-bfe2-4716-96e0-1026d4080de2@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 14:18:05 -0700
X-Gm-Features: AQ5f1Jr9dYikWutmxvIH9LrULiizPorg3RV6Am3YULy0KDxisqlH9F6mebSZBG0
Message-ID: <CAADnVQLcLMmeA-MBV_FdW+6GWTZf9dR=3mPnNBxPjh2Xv52TLQ@mail.gmail.com>
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

On Fri, Mar 14, 2025 at 2:08=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/14/25 22:05, Alexei Starovoitov wrote:
> > On Wed, Mar 12, 2025 at 1:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >
> > That's correct.
> >
> >> An if we e.g. have a pointer to memcg_stock_pcp through which we acces=
s the
> >> stock_lock an the other (protected) fields and that pointer doesn't ch=
ange
> >> between that, I imagine gcc can reliably determine these can't alias?
> >
> > Though my last gcc commit was very long ago here is a simple example
> > where compiler can reorder/combine stores:
> > struct s {
> >    short a, b;
> > } *p;
> > p->a =3D 1;
> > p->b =3D 2;
> > The compiler can keep them as-is, combine or reorder even with
> > -fno-strict-aliasing, because it can determine that a and b don't alias=
.
> >
> > But after re-reading gcc doc on volatiles again it's clear that
> > extra barriers are not necessary.
> > The main part:
> > "The minimum requirement is that at a sequence point all previous
> > accesses to volatile objects have stabilized"
> >
> > So anything after WRITE_ONCE(lt->acquired, 1); will not be hoisted up
> > and that's what we care about here.
>
> OK, is there similar guarantee for the unlock side? No write will be move=
d
> after WRITE_ONCE(lt->acquired, 0); there?

Yes, because the first line:

lt =3D this_cpu_ptr(lock);
WRITE_ONCE(lt->acquired, 0);

this_cpu_ptr is pretty much a black box for the compiler.
'lt' can alias with anything before it.

