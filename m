Return-Path: <bpf+bounces-72949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B05C1DE59
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778224E1C74
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CF1DE8A4;
	Thu, 30 Oct 2025 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHRYghhf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7E3A1C9
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783869; cv=none; b=LSLimGkIXuRlxU8pf5QWqKApr3HC7RZUZgwQPSuhcI8ZwV6Dm8shPnkwE/NqwNbDZzKjU7DpvcS4522LJZTCf/ZHDsFO265nMJgA5WSuFL0Vi/4yGTTzOqFDMF1bv9OP+ai3BO7jVPf1BT5643gFY7kHVn3FoYceRJZEDAulB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783869; c=relaxed/simple;
	bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8d3G2lhQTIWCPoAxF/yT9uQmE1Bih5XOajppC1i8Sm6NAXipu1+Nb6MQnYiKbUH720Sg6woW4qNZldhUx7Krb/yDPkqN4WLfrs7adnwmGiyNsEBFd0fj7Gkrnbuto1nl0vLddMMKyC2xV35FJWfY5acSNbpfH/OsJCUIvoFx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHRYghhf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429a0d1c31aso262967f8f.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783867; x=1762388667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=NHRYghhfkQvBTg9FloCLd24x86Tv3mKkfmd2h3rV79t2wicG73+mIYw5ObWgNM4XeW
         ZdNeR4CLV8pWF/KJC95TQAxBqsHuMMiMxauGAg72gnuaIskTioBPgnbsub9pJiKywVhV
         DLfdEOfYXKYK93aWKBBXAxoZMlviqYfrQBouoDv3k7WxV46v2G+6eBGCICAhKO86Nns5
         yXwroNAb6gIFfL/NtMtDcNEeAC1IfN05BT3JTIgh9jphYTWWO9LgzsXlKQOzRvzWgBg+
         huasfBwcHUWDmfhQ51dH3FCUe/pMnJ/5Jxeg0sOq5v9JG8zc1ZD0NDxGTDUSqrWRBNhO
         7I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783867; x=1762388667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=P9oZeipgshEKC1tikiAgK+SJb58yzVlokamXhch8aEpZfMETDBTFzW5eo+mxUgVZva
         oPWH3ydrnfjzQUoBNB5AEpGv7FuLw0+tXZ3ODso4CW6sym/QHG8HVPpr87eEx8b4DZAw
         deVv1a2S0tNCtvUgkNr/wq4FoGSpDhbsesswdP1yKzoZ8iNKgGwYA9HCHN1e8SsC3954
         /b9y3cOS4EhjsqMIJ31opfXtx5eUAkTYgr2QuCWJF2TEQ2VgTniN9pg9sWMIWweR18sw
         /2CqK+jJE9CLUf/cv9zWTGUCJUg4/KkXBuv9os71He8Z0gKNzKGxJLXr710IvXc2b4yA
         3/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6357HgHycw29SqF3qoJvChdS6UT4Mw1Gg8voiW1P4n63vhE3nrnxX1Efsr1H1bhVC/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfpLdkcXzh7t9/x0z2Y2WqpBA1efr/0CN6bSRdH8+dM4d/bJ/
	kbf/rtc24PUFHBF+Bya1sw4QhBgIJ9qaTIiyA4uZFdXKcETPDnPux/ad+PXdnas6hVzHXu3Nj4j
	/o5ai4fRZMbwFQe31cgJc69G9Nykh1P4=
X-Gm-Gg: ASbGncsD4kY5fBN+PzbQKSbTG6BSwZn27GJXpKo9hImQ/i94tXvLnyGUVTo/VAs08IO
	cerM80BYA/MTh1EedbEgsG3/TD3EbwyxQq7XV0Fg4sraMSYyfulf1+AGzfdyLhgdqJMZAr/D3wk
	cmHjAvlCkxnIHfs930Deb2UaKjlVKeu6uP+QdCrJE1wV05J55Bq23QwRialaQ2yKC7camsPLOjy
	9Z6x2q6Ro2RTuMYzNEC8BJqgQftv+ZhlDJI4biC9dLAGtzP0vdni1bIcnRPsHynfsy1+nbcESO/
	AsgIX4D3mcf2J8lcNQ==
X-Google-Smtp-Source: AGHT+IGrpyN5vXmTDxAJ2Hbps4KQtgd5KIZx2gAkx82y7AWs2BOA0ibbW+EbXbkybCTf6OBaGDisHC0/rb+R99V6Svo=
X-Received: by 2002:a05:6000:2584:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-429b4c56bbbmr1308255f8f.17.1761783866576; Wed, 29 Oct 2025
 17:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz> <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
 <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
In-Reply-To: <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:24:15 -0700
X-Gm-Features: AWmQ_bm8V8LdP4A-G3QXinsd8ut065vtjAkDQw3A14j7is_ar0KxcjD8kryVmlU
Message-ID: <CAADnVQ+8x2b5qddRxU50xeq69XMY5RNi8ZfvTbERidKwTYrzqA@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:44=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
> You mean the one that doesn't go the "if (unlikely(slab !=3D c->slab))" w=
ay?
> Well that unlikely() there might be quite misleading. It will be true whe=
n
> free follows shortly after alloc. If not, c->slab can be exhausted and
> replaced with a new one. Or the process is migrated to another cpu before
> freeing. The probability of slab =3D=3D c->slab staying true drops quickl=
y.
>
> So if your tests were doing frees shortly after alloc, you would be indee=
d
> hitting it reliably, but is it representative?
> However sheaves should work reliably as well too with such a pattern, so =
if
> some real code really does that significantly, it will not regress.

I see. The typical usage of bpf map on the tracing side is
to attach two bpf progs to begin/end of something (like function entry/exit=
),
then map_update() on entry that allocates an element, populate
with data, then consume this data in 2nd bpf prog on exit
that deletes the element.
So alloc/free happen in a quick succession on the same cpu.
This is, of course, just one of use cases, but it was the dominant
one during early days.

