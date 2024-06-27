Return-Path: <bpf+bounces-33272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BAC91AD1E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB8EB20C86
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB001993B7;
	Thu, 27 Jun 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEYADTZq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16313E56A;
	Thu, 27 Jun 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506844; cv=none; b=m+SfVK5eUfGcX+nYGQzDr0Bwvyiqy5ZBYKJ4+cit6WigH+oncdZhDIFpCEjrYLsupujATXgBRs72HZ/L0D6RqC/NAvX+GkyXPfx87kGl4wIeDyH+8CzOsmfr8FHUtAHDr8Zb0NQJ6LoHSWzGS+uGlVedoBXyYa66hdbSdbm3nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506844; c=relaxed/simple;
	bh=Dq9zyZxB5Tjhs4VAjVCQb+aaRWymV9vkVxFm8OEoxTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn24t+4piguXK0GUDQSjPGw0khflXbNHgsRgndUt9EACGbTdF8l1ZPqJS4xCoUCnJnsBG/Oo7rIa6YSAhomrUn6kMTW6LYqYzH5t3rRTGtyXIADApp8oGqAqqtv8/eMIucj7roAwmeGb87a2ddu7d1hDU5XWUpsU03niZY6wxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEYADTZq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9cd92b146so62608545ad.3;
        Thu, 27 Jun 2024 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719506842; x=1720111642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx/8vkmfwSR7BxnO3245yFMjBsK0SXa9E9u3paaEo2s=;
        b=QEYADTZqDSTKkRt00kIxAmKXhizrc+S+Dur0kmebole3jKqM42ESde05eMXNOTW3U6
         ele9IJy5pD1OZe+9LR2r3kVE1+vabEYqS5kDy4bqUKRdnzClGy4u1XJBP+nc8I33OXbu
         40BHYnTWTqogAMKo2KHDeWQRuIT3M3JiIkfRpZjQeo7wUcL6TqzsIId58LzSlf/UBDXG
         cM4cez8F/mtjyN5zR7PfQaj7p/vtLpAC/NiIfo789YVfUPJxOoEV+JRpui2tigSNtOgS
         lN6LhWzB0i8AvRI8mO0Y5SadWqR7HH+J6pcN8Toa06JcFUDA7+XV0ds9el3tuPchtumE
         Nxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506842; x=1720111642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx/8vkmfwSR7BxnO3245yFMjBsK0SXa9E9u3paaEo2s=;
        b=DQUL93Th9IhBhQ2DRLWsTayWWTsVKoGRFMVKFFWBCmUwk3nvkgkQVVXp+J1H1Xft+E
         qhklNTmw/2t84cz8TToMv5qR+xRxqvpmTJ/mE2f/69SLOlnL+8OX2ADsAkjInSu0QC+f
         h/XjctOMO10fZyey87Ieu1icvmyR68PN71YPZMqpiZ+uBI56nPKfmrZsZ8IjkWJvT2xY
         ZnsQA0FBW+UcQcJ7JVvvXtWgObbOydmvhFQvzWyidqdK58boD+FxSlZl3U+LEUSttsDJ
         tmNchJZRdzp3aRnGzIt46H5Goe7B0+Y6pMWs/HXQ9HfrS81RVWxFHTl1CWansmwPFypU
         T9hA==
X-Forwarded-Encrypted: i=1; AJvYcCWv1/p4q8k6xxJ7XzA0GRNCGGNmarlxZNxd7GHk8dLJzkvDdDZ5R/9Fk1a560k0Jk7J5ipqRm8K+SBEeDG4i1Ld7IT0Jy4Ie8wBWX5IyDy5HGNRE2vkVpUthFOoGP4WNf76oP968fti
X-Gm-Message-State: AOJu0YxhyO4s7RzxB5c4RzXjln1Gx6N6UnRLvkiSQdNk9za9VLtC/9nQ
	Ne4g0vU9v68MLL4vpsRMJKF6lHxcti6dh+2x3g3UlPf7bN88V4coKMpd7VrPqEHJQu6+44dum/q
	xYnbxjs3InwgYYie/c2Vvwl7N5Kc=
X-Google-Smtp-Source: AGHT+IHfHM9fZyd8Od0hiWuP+2c+ckNOVnoLawFsBRjZSSP2fA1KScCAJ/JsiNGHenpd/hkXBgoRgUS+blThWyoDONI=
X-Received: by 2002:a17:90a:1f44:b0:2c4:ab0b:9d9e with SMTP id
 98e67ed59e1d1-2c8581cd072mr13022241a91.15.1719506842289; Thu, 27 Jun 2024
 09:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
In-Reply-To: <20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Jun 2024 09:47:10 -0700
Message-ID: <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:04=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 24 Jun 2024 17:21:38 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > -static int __uprobe_register(struct inode *inode, loff_t offset,
> > -                          loff_t ref_ctr_offset, struct uprobe_consume=
r *uc)
> > +int uprobe_register_batch(struct inode *inode, int cnt,
> > +                       uprobe_consumer_fn get_uprobe_consumer, void *c=
tx)
>
> Is this interface just for avoiding memory allocation? Can't we just
> allocate a temporary array of *uprobe_consumer instead?

Yes, exactly, to avoid the need for allocating another array that
would just contain pointers to uprobe_consumer. Consumers would never
just have an array of `struct uprobe_consumer *`, because
uprobe_consumer struct is embedded in some other struct, so the array
interface isn't the most convenient.

If you feel strongly, I can do an array, but this necessitates
allocating an extra array *and keeping it* for the entire duration of
BPF multi-uprobe link (attachment) existence, so it feels like a
waste. This is because we don't want to do anything that can fail in
the detachment logic (so no temporary array allocation there).

Anyways, let me know how you feel about keeping this callback.

>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

