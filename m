Return-Path: <bpf+bounces-46122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE99E47B3
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429292855C0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351D190471;
	Wed,  4 Dec 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeIXYDID"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C6171CD;
	Wed,  4 Dec 2024 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350742; cv=none; b=lNK6E7uIgXUq0yZrlZ4wjxb5ifTl4BY2QHp1Q6UVoaYXX/y7esmjZHNz8XTkS9ej/zMHO/0p4xEuShTIgjFpiyzaIKR4r53SLx9EX9OZl5lfnJWj+B1ShxjEkBd1lP0E4ieUVyxu5PJeplGQwbygydf4pu51FOSjzN/t3FkbVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350742; c=relaxed/simple;
	bh=Wp0PTle/BHGhcTvLa7B8zRmlNzq3MdHFa2kOSeQrpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMNCYbBh5x1QH5ltxaQQu+2UlmSDSzKcsKqat0+DbejxaDsd31jbhc7g86eWfLf+6XoUpEdt4imkyVVUqHm0jzHzbEGKwtQLu3aFZX6cD21iowEdSNWZvebZBsqVXn03XCbOV1qW14V1yewjxkKjHOigdV98hpjFp8oYt8iueJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeIXYDID; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349f160d62so1893205e9.2;
        Wed, 04 Dec 2024 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733350739; x=1733955539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp0PTle/BHGhcTvLa7B8zRmlNzq3MdHFa2kOSeQrpHk=;
        b=KeIXYDIDGODtp0kuRh5iOF1/F3V9sg+0+v6ESlm5EeeccfuMdrJUL2pQROKL8EGkfr
         gIgsWMoisRsMKDoGthBlwND3h+gbUQz3+/IeHhPyPDqzUzlTIBOYr8icHHmytIkLwAGH
         f+hMwAemQeYfQcDDsgM9vs1rMwCaTiqdqa2EnMqdH878mEEay7GNk8ZG9qm672fk9rlr
         5Uzur3R2FlE5jszkz3uysfpax31LV9BGxCMQJOPh0OULu4WN2VtfZuCndHO389KX8Emt
         i4gqF118dQWHXztKTvcEGI1Xyc21Pp/7N3yMqvqoatzZVK5hey47VXsURoS0dzCzHdlH
         JZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350739; x=1733955539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp0PTle/BHGhcTvLa7B8zRmlNzq3MdHFa2kOSeQrpHk=;
        b=QtUpaylJUgJ+durv3fE3A3ALQ9wi/nK909kQqn56YvRMHEtb6M0mx4ieKZ0wJMgTBc
         RpESo6e+a2f+0Mf/Vjf5AhSY2GAxqn/ZplXCFJhxSWTKvOai4YJpQd9dbBNF8BXWsXTu
         UyBt8oM4uu0YAoXjMULchR+toRUo2tM7PisS/MPQ9J4IFCC7ivQ7HK8M3NEzdzk1E+kz
         BghdY+/82QHT4JIU2e6w/NpH+yKok9UnXCdKSb6hrT8OVsukck/c70Tj6uoaG0t60KnP
         d7+PGUM57qbsbT3QrIifzTKl2Vg7BhzZ9O0y38uagxRe/BXAMe8g46zIZhNxsAG9LNzK
         DBrg==
X-Forwarded-Encrypted: i=1; AJvYcCWSsvyEy6ERCjVZdecH3pwhDKj1RtZdncntYmEeZXWLB9CYxPKriPiLchMkkH57RSfAatw=@vger.kernel.org, AJvYcCX+DPQzWXRXIRNwbU3o8zRN+23J4umUm0/ooqqsDgxXTxeVVfv4AgfvfDGVmFTw5enfQ8kZwoU/JR+qUNZd@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjA3I9LK4TK/dwEmnLE+XyMEVnuGEa2a4+hg+6vmPNSiHzAR6
	AiIHS6t4+UHBzeExZsHEc2wfMWXB2GzrxJePnXoWJ7WL9TP2wnN48mcOOFlmX0MaCuvIvcLc/Ga
	10sM2e0fynQISIErzZokeNswmoQ8=
X-Gm-Gg: ASbGncsbK6WtQuhjkN01ZO3h18/YntCh6RNRLsbEQ8tvVig057wMqC94P8c3+8h95/c
	XCVkFXVjuRlVR49HwtDgKewHeuoW2vv/9Opwx/EF0dULKaCs=
X-Google-Smtp-Source: AGHT+IGG3kuqd8+aNV0WyDqWWtmf3emAnGN83yWGfcoTC/lmN/+vTDtaSB/HNlFawpm394bKEBIg9HzwYvyEd5IXUwc=
X-Received: by 2002:a05:600c:1c0e:b0:434:a802:e99a with SMTP id
 5b1f17b1804b1-434d09b1590mr73836775e9.4.1733350738500; Wed, 04 Dec 2024
 14:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126005206.3457974-1-andrii@kernel.org> <20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
 <CAEf4BzZF8Gt_H=7J9SYXGorcjukQAqPJoX-a8vqBFdo73ZnXFA@mail.gmail.com>
 <CAADnVQKwZqajMd04Fp2CMmNbSAkfSKkUZiBwzoo4Dno1AzX7zQ@mail.gmail.com> <20241204135038.1fa7e7803e14c41050584fc2@linux-foundation.org>
In-Reply-To: <20241204135038.1fa7e7803e14c41050584fc2@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Dec 2024 14:18:47 -0800
Message-ID: <CAADnVQ+ZtUWOUheHYriAwSRAqyrt5YOtRveWeV-Usae2FLnKKA@mail.gmail.com>
Subject: Re: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, dakr@kernel.org, 
	Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:50=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 4 Dec 2024 09:01:06 -0800 Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
>
> > Andrew,
> >
> > What is the status of this urgent fix ?
> >
>
> In mm-hotfixes for an upstream maerge later this week.

Awesome. Thanks!

