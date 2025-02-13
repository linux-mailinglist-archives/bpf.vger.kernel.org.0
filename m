Return-Path: <bpf+bounces-51388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C4A33AA1
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E16F162B5B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783C20CCD2;
	Thu, 13 Feb 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIjHg9td"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4020C021;
	Thu, 13 Feb 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437599; cv=none; b=FLudK2VZClSoWkB7QOmzGG9k3BMKJc11aJglwp367W1At1a4KTzqy8OmcEgki2I86AtzZ7ilyeSIgt0XdwFPytQbTLRqIZbDfOh8KWqoNMaSnvlzC55T5GHmFglTGAC3fdt1xgGkrZXlPj7xuVExVIpvWKd64ICCCNpncRqlsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437599; c=relaxed/simple;
	bh=6k2iMBphJk11cRoQgYZxtjp0nlxhrOESdbLJeOMu3PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oELB0qFk8ftWy8meNVw6iSqDbCqpUG0ezsCAwf5NRWkbwxqUeRjgzefHZ4QVtTshbyhWs2WHfQPtR8uente6I78X47m/C8DboDn+4EkMqRWQmJ58+C/N/X9bBQ6/Ipgzv4Jk88ytg4JgEXubnnFymN7TSqZ9QLsSsEftFtBLzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIjHg9td; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso1156224a12.0;
        Thu, 13 Feb 2025 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437596; x=1740042396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2iMBphJk11cRoQgYZxtjp0nlxhrOESdbLJeOMu3PQ=;
        b=KIjHg9td3Y/+Eekdq+4col8u2FP67wRSNTR/zB703lE1HsnpDJYfcDPthSuKtBTTNG
         xW5Wvt8VGYgMPBDtwJDy/Vl4LC6cKDT5T4FDWk0BG142NR+4NVWsM3dj08461AgEH2Hx
         Qkf4y9THZ5bKPhj+nr4wrPYBa3yHXnj6ytplvpx1L0oAGQ2BvBQ0xuCO3aNuiQvU7/44
         rpRxh1VjKhArXQ0uqwYFSA9iJMJYJwgIi6nQpIWIKHk9NCIoPCwHpD7FEimNQqZgDVJY
         bMWTacYVdB/Qcr25pXoj/gw0di0ATKZVCRWPCi5D96GMtS5mxIJkTzRU7aMdyZmcGs3f
         TEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437596; x=1740042396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k2iMBphJk11cRoQgYZxtjp0nlxhrOESdbLJeOMu3PQ=;
        b=U7cVr9sfs84nVexB1chWS1ey3/coVaHHpQFIoeYpiVQhezqAVcZ9jlMt8y6pkok4q9
         KXegUt6Ix12NT6+Qb6ly8YNb2lwx9EIQgZVxy+UoTRp69eE+IvXYSy5TCzkEwIgOA4CU
         uZ8TTxVyfeylyFdIVOOV9ieRvlqSIMzHHzDI7Jaxl3H2T6+GtNuAupUc3fZqImS+Y3xw
         VQgGDIKukaERZtV7Jmarm7FCyclRrTiohps21GJL+cFENcnAWXlV672pVtTbUSrikDuN
         nbSWhXIn8lORZXzeHdwEcHbPbeLWTuyQ50j+cXEWgDctxcKY9SYtAlySpBNaxT1wGaf9
         pOQA==
X-Forwarded-Encrypted: i=1; AJvYcCVnzbXM37tovf7y972+7e4zAqUJlh8V2UZX4VGA89w0IKwWAUnLGJo4ycO65mpI2xNS0laywvi+UuTOb/gw@vger.kernel.org, AJvYcCVoHAXyqr7+rKRzPHIhMgruMhw7yn/SpwRb7q4lkPVE8CschaM8Qaq2ARgL9Msvs4YFweg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJywAMfOiMTHznaCQrpU50X7U5X5/GMK94oVCV9a1vcFGMlAwC
	S+Vo3z2DApp3cQuHVEQG2omw8hH2kyOYpSywsRGduAgOXQCbrbDc3UQZlEzSgRZ7XPleMvoElpb
	TKLdIDyiyDQRiKt3JKmVLFS/jTvo=
X-Gm-Gg: ASbGnctDe811sHOEkx7TtJFjvpYTJX0un4vzZJjIYxJ+W8R+V2Y0BtcxIwu6nCaZRqy
	cs7WNY7w18zN7uddlvu/6KjM/j/FeqgMOXZT0W3Ox18sDqgxxcmSbjjeytA6ABtvzw1bMu0hU4w
	==
X-Google-Smtp-Source: AGHT+IGGwFOKgmZ7jGFTRw29YPqpzOfqivXSsZm+QdFI8w3ZXwZz4sjOtRpvnz2Xh3JeEREittXy1bBv01i0K8t3wRU=
X-Received: by 2002:a05:6402:3606:b0:5dc:7fbe:730a with SMTP id
 4fb4d7f45d1cf-5dec9b70130mr2363579a12.0.1739437595769; Thu, 13 Feb 2025
 01:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084851.150169-1-changwoo@igalia.com> <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
 <1a158ad7-f988-42bf-9a1e-b673ff9122c2@igalia.com>
In-Reply-To: <1a158ad7-f988-42bf-9a1e-b673ff9122c2@igalia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 10:05:59 +0100
X-Gm-Features: AWEUYZk8yRblGXluJ2yJXkq_Voo8-nKmOP26RtKpt4Gj8m-BlNNZsJY499jrA8k
Message-ID: <CAP01T77mcUi4h_dT6QfEPg_xeUGhsegcV+NCqpQSY-VtxuLV4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Changwoo Min <changwoo@igalia.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tj@kernel.org, 
	arighi@nvidia.com, kernel-dev@igalia.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 at 09:42, Changwoo Min <changwoo@igalia.com> wrote:
>
> Hello Song,
>
> Thank you for the review!
>
> On 25. 2. 13. 03:33, Song Liu wrote:
> > On Wed, Feb 12, 2025 at 12:49=E2=80=AFAM Changwoo Min <changwoo@igalia.=
com> wrote:
> >>
> >> When there is no entry in the free list (c->free_llist), unit_alloc()
> >> fails even when there is available memory in the system, causing alloc=
ation
> >> failure in various BPF calls -- such as bpf_mem_alloc() and
> >> bpf_cpumask_create().
> >>
> >> Such allocation failure can happen, especially when a BPF program trie=
s many
> >> allocations -- more than a delta between high and low watermarks -- in=
 an
> >> IRQ-disabled context.
> >
> > Can we add a selftests for this scenario?
>
> It would be a bit tricky to create an IRQ-disabled case in a BPF
> program. However, I think it will be possible to reproduce the
> allocation failure issue when allocating sufficiently enough
> small allocations.

You can also make use of recently introduced
bpf_local_irq_{save,restore} in the selftest.

>
> [...]
>

