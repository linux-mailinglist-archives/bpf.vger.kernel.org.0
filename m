Return-Path: <bpf+bounces-47295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FE9F7260
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 03:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFB6188067E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4F78F39;
	Thu, 19 Dec 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXDxl2W3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFA4D8DA
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573244; cv=none; b=fXnxTW8mIcMIX49MKD7LzEG1nrEd8m1GGvSNB4d9QlfelppvRpRG+DQy3cXOSkz8RF5HmRZAJF4LuNcDQgdNnsmRXVRoFp0/4TEUM9bBdeDxrOXxls+lDvEyu3HZS40np43PFNR5DUEnzBODGdu2GTfFA9veL2ZwgyLLvJmFJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573244; c=relaxed/simple;
	bh=10XeDIZaJRKZ2vO6XMwcEnLLR+kxNMCc7bgQ1pNV0gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTo5YDcrL04yqwtrKOpAc79vHVl5BpK4ATBKSQYCTEiE4akuxofKEBDHxmA7sGLzABgI/MUBfgdP55pzoA3OAdoXW3nKVvfEmV95de12zn6/x+m0pZmx1GFZZmShDVWmuqq+Br6LkekI2vJHpjv1hUW7iQAMVNnFrd5S71hvIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXDxl2W3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e3621518so138228f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734573241; x=1735178041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10XeDIZaJRKZ2vO6XMwcEnLLR+kxNMCc7bgQ1pNV0gQ=;
        b=HXDxl2W3e1kWxxrS/oYn227oPAKTiDpg9eUr1QnNBd204HhXMw2owm1MkYMy0gAqU5
         HCply5/azBUBhmxHe8IEvKa8J5KCiMPHkLWs0Dl1/NESqvZeS0nH6qVModiMrLZyIEv3
         lQHFgNi13W/39/1n3O2t67Jjom/AdDJsIMB3FsP3lBlfU+FzTvh7upkAJ5v+Oo0u0nNN
         nk1spMjiaWbdYAxC20b7KgdBO/PIJ8sgtcvDSUTJj0RvvuOS9kRW5lFRH9Lvn6xJesYw
         RzUJDBNBa8Wr3lCm+x3mD1ynNcLbzyJvrRDGvglhnqyab4/x22j0djqZHLsD4GuVA47o
         7jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573241; x=1735178041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10XeDIZaJRKZ2vO6XMwcEnLLR+kxNMCc7bgQ1pNV0gQ=;
        b=gQPXwP+3f25LD11G78+X5sArGj9OtKWJuF+/8kq4SEZbJzm8ib2aUtbuup+JgqkI6w
         WCazkIXf8y92feXVNhQ2g1GD8bkD/ctf0cOk04S+QZtlTAHzW2VEXE8t4cV/qd7IM9p7
         0091NpaRKNEORwkYsTF9Fk82pUmQSntrO5k/rSfnSt8QgjnsMhS3XjevhAWYEjoTuSzB
         xNF23Cg8XUWc6pk6Hl8vF5VbZZIDvw3o78YPjZjvL5cuJMEb5fUZ7/6f1Qgrm01PU5Mg
         RH9C4iaSinH3GBsHNLtY24fJ8bP5tsPvM1iieT2Lh9mrwTR6qwPg0xrm08QX8fn+Wdyk
         QwSw==
X-Gm-Message-State: AOJu0YxPZaz0SUl2Uj5gefMAzr5Dp4NhPOtphx4tcmAGDHUN9/b5UbY4
	Ltfrp+vsu3rYzhxbx1Bev47XOqwyXJw2UY5yCfciTCo70ZQD0mCcq2aegV2kLaDQ8oSLy25+y6c
	V+hq03L6Mhkc6WSXtgLpLAAbdKJ0=
X-Gm-Gg: ASbGncvp/ETz8kUHF+scfQRXlCVG9+vSf//uLOAbO803NXblyBxli0znBYVyQVgHz5i
	Xl5yZCoHqGjN6c7kaJ0KHV2PyR6qaasNIXD5hMg==
X-Google-Smtp-Source: AGHT+IG+f2j+y3YOgHpx9wDxFrrsaRiwjUKBCYEbw+eq9iotxVmhsKe/xHF38k7skEGWq0fCX8lcnRM3c4wstSisGEA=
X-Received: by 2002:a05:6000:18ac:b0:385:df19:cbf with SMTP id
 ffacd0b85a97d-388e4d794a7mr4682001f8f.28.1734573241070; Wed, 18 Dec 2024
 17:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com> <Z2Ky2idzyPn08JE-@tiehlicka>
In-Reply-To: <Z2Ky2idzyPn08JE-@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 17:53:50 -0800
Message-ID: <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg stock_lock.
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:32=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 17-12-24 19:07:17, alexei.starovoitov@gmail.com wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Teach memcg to operate under trylock conditions when
> > spinning locks cannot be used.
>
> Can we make this trylock unconditional? I hope I am not really missing
> anything important but if the local_lock is just IRQ disabling on !RT.
> For RT this is more involved but does it make sense to spin/sleep on the
> cache if we can go ahead and charge directly to counters? I mean doesn't
> this defeat the purpose of the cache in the first place?

memcg folks please correct me.
My understanding is that memcg_stock is a batching mechanism.
Not really a cache. If we keep charging the counters directly
the performance will suffer due to atomic operations and hierarchy walk.
Hence I had to make sure consume_stock() is functioning as designed
and fallback when unlucky.
In !RT case the unlucky part can only happen in_nmi which should be
very rare.
In RT the unlucky part is in_hardirq or in_nmi, since spin_trylock
doesn't really work in those conditions as Steven explained.
Sebastian mentioned that he's working on removing preempt_disable()
from tracepoints. That should help bpf greatly too.

