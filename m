Return-Path: <bpf+bounces-42820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B899AB77C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BBB1C22C21
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D31CBE80;
	Tue, 22 Oct 2024 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZoeSuum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D91A0BE0
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627937; cv=none; b=GMlDZHgl+KR0UNNKvP+iQVQ2er20xVA9LcjnXJsMb39tRcg7Lu5Bk9kbwSkATfw/jpSOKLT28t4nkbjRCE8MULeI8qJ07hxgOB46rpn7iA9CH1CuREfNRepGaghAxoMdquOc3QfWSd6CJrx3olzgSU2gIFcI14qIXE4xOcnVwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627937; c=relaxed/simple;
	bh=5n1l/vsFQUGg/piLJVSs81SiGs1qWc+irM8X5M6Lw1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njfYraprqo/JjJtI6EgSkTU/cUQEafc8kUcjD7ptuScAsQaBLWnesqv9QZegmVvEQdLTkOge2xzasYcIFotvxPfcQkN6nY7wBDqhtSSPhXanEbin3NgYrrDA/zAyMtJW+C4YtUa0kPYwEka0ZZekPVoo/brargLUaaBd8CbLrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZoeSuum; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso3309756a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729627935; x=1730232735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e78c6CVvAgJ1/WrnMZ6FQmLOrB4wGRJo8NfkwSfpyV0=;
        b=gZoeSuum19Hjq0dVYUsZ4cq42tqV7FIiC5frhI/x04qleS8NModBiqd844PCkwTgAp
         yBWLwDD0zDrXHCQTY8ITelI4HOswXnpo5PgvVg5m2X7FnbxoMiEgq/xt6zuFzdgUfYbE
         6hgE1by32iEHdXUdBN3nEWWvew3ULDfKNmv3uO2Bu8I+Xvjc6tLsX9mSizIBqoPsIA0m
         tCPV1GoQalZ2agPir5P6HwudcdQFAj9SfGwUdPZ6vvlZ83F7m7mxKgCmlm62fKdqtVvm
         fMxXshxUjZnkcZpIllnV93Vd9kXVGcWCAwlLsOhQlBRPu0Noc1xIACjIrIL07jqZ8+Ym
         1e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627935; x=1730232735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e78c6CVvAgJ1/WrnMZ6FQmLOrB4wGRJo8NfkwSfpyV0=;
        b=GmuQOCBdki75SUOkJBapEfYougFbRYNy5JsZIWqI6VPDRihxnwKu3w558emFEPPMZ3
         9oWGSVoXjL7O8aqyd0p6yc143lr7AC6D+X9Epn9p7bOloB+fgUe3ces31kR7ygKfMzoY
         JktLALc9JiViIPO3/jMxthZsVkNtMvxlPTxizzkei3+1yBCMtnkzU7v1zxDNErNTAnoK
         zRZush0DlL2Y71U7bTVvoWzO4Ap/3+DpHthbDtIbS89kei79WBDSHKeO/JLelPdXisLc
         8+dEnTtAOXIwRqv68vO+xRi+zvUUzfiTwtTTk5XXlNBrXBuKC4tByJXhCXMEvFOB2Hg9
         bALg==
X-Gm-Message-State: AOJu0YyvwA+JBcdn3Es4TJzzlSz3tBgh0BI8RGFWXtOhuC2c3iUVQQHG
	0dUQvWNNC3tls+m/vxHRAe+OUr/64IZm8hnXPbnHNotK7h9EVDbS2qkwp7ZWQ5mYnqLQqH+7eog
	++bHM6M7csQuLRMn6V5xTLQ992go=
X-Google-Smtp-Source: AGHT+IHm/gD3U1t1WVzL9tQxgl1CslsZcvI10JqO8nL8uRO/b5DdReP5t3OMNFTlgvUxg872iV1bFggPp11HaA42Ihc=
X-Received: by 2002:a05:6a21:1707:b0:1d9:b48:8b0b with SMTP id
 adf61e73a8af0-1d978aead8emr258443637.5.1729627935342; Tue, 22 Oct 2024
 13:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY4P282MB2313108B00C833317D0E5938C64C2@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB2313108B00C833317D0E5938C64C2@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 13:12:02 -0700
Message-ID: <CAEf4BzZctXJsR+TwMhmXNWnR0_BV802-3KJw226ZZt8St4xNkw@mail.gmail.com>
Subject: Re: How to combine bpf dynptr and bpf_probe_read_kernel
To: Levi Zim <rsworktech@outlook.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:14=E2=80=AFAM Levi Zim <rsworktech@outlook.com> w=
rote:
>
> Hi,
>
> I have a question about how use bpf dynptr and bpf_probe_read_kernel
> together.
>
> Assuming we have an fexit program attached to pty_write(static ssize_t
> pty_write(struct tty_struct *tty, const u8 *buf, size_t c))
>
> I want to send some metadata and the written bytes to the pty to user
> space via a BPF RingBuf.
> While I could reserve a statistically known amount of memory on ringbuf,
> it is a waste of the ringbuf's space if there are only one or two bytes
> written to pty.
>
> So instead I tried to use bpf_ringbuf_reserve_dynptr to dynamically
> reserve the memory on the ringbuf and it works great,
> until when I want to use bpf_dynptr_write to read the kernel memory at
> buf into the memory managed by dynptr:
>
>        78: (85) call bpf_dynptr_write#202
>        R3 type=3Dscalar expected=3Dfp, pkt, pkt_meta, map_key, map_value,
> mem, ringbuf_mem, buf, trusted_ptr_
>
> The verifier appears to be rejecting using bpf_dynptr_write in a way
> similar to bpf_probe_read_kernel.
>
> Is there any way to achieve this without reading the data into an
> intermediate buffer?

Yes, you can bpf_probe_read_kernel() into dynptr's memory chunk by
chunk. I recently wrote an example of doing chunk-by-chunk copying of
XDP data into ringbuf dynptr, you can find it at [0].

  [0] https://github.com/libbpf/libbpf-bootstrap/commit/046fad60df3e3954093=
7b5ec6ee86054f33d3f28

> Or could we remove this limitation in the verifier at least for tracing
> programs that are already capable of
> calling bpf_probe_read_kernel to read arbitrary kernel memory?

This would have to be a new special API, basically a dynptr version of
bpf_probe_read_kernel, something like:

int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dst, u32 offset,
u32 size, void *untrusted_ptr);

We can probably add that, which seems like a straightforward addition
to me. We'd probably want bpf_probe_read_user_dynptr() and
bpf_copy_from_user_dynptr() to go in a single consistent batch.
Implementation wise it's a super think wrapper around existing
functionality (we are just avoiding fixed buffer size restrictions of
existing probe/copy_from APIs)

Thoughts?

>
> Best regards,
> Levi
>
>

