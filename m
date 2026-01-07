Return-Path: <bpf+bounces-78152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9737CFFBC2
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 085B230A8EA6
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE733DEE6;
	Wed,  7 Jan 2026 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB7YYQgL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8130AD15
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810671; cv=none; b=PKfGIa9BPKIf25Oa640aUV29xmPxj75kYzMx7QhLduladjNv8D1w226BfjexEhP+okqKl5k7DjJ5Zhg2vaoXQ8fJDj7fFCMf3bgM6ncTE8SJSiBQ/pxva4QDYWZ+iodj3e4MvymKZ3QZ+U7TM648QFsNsZq8Llk7FBaOg+iJaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810671; c=relaxed/simple;
	bh=L1UE6UZGVBGpjUXO8FTNKoTJdBuYU5aYHJ6eSBWdquo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsB7FcOpqHAloQT+HqKpq2ofcEz4pyNc5m8K5IMyOl6CDUrNtAPUJj89zN4o5W+pD8sz8DsKVaVeC3JIdsSFLqZQLHw1VeVM9YWbyBqWl1+apiDQNioOFnt3haQxanPgxlyojrwwA9l0ypHbVhRbzxOHVDPOzWnTHXx7RkId4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB7YYQgL; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43246af170aso665582f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 10:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767810657; x=1768415457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bx2taddgtABc2OMI6OXSOW8L/uzHIuesESNW5Hivnss=;
        b=DB7YYQgLDI/4ktw1dAYFByaOv2awzHeuEjbzOyj6b+0Sh+Fp2Mvx0JiXk99xN2vVt/
         ZoKKmXOK2ZXW5JrPcxHU5J97THmC4YDMuxQLoCPOD1SYDSAjBkdOWv6CbhUPmP3llBA+
         DhD6EQ5qm9+drK+Tkir5bW8TWtuW5i2WWC+eAq/OOwNYA8Mz1LkjNfCwPnlYfu1oe9dB
         pRvvpIz6+jSr/YetwKIsLYVf2O6cH8cg5SSDRSmf7yjS34HRVLbc0PjfNbhvMFhiGbKu
         fTO4T/an20VGKBFojYhXu67bT1jJ0ZGB2RBa8aD9xM4wjGg/fKnTfbWqMObAuI1afUT0
         aNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767810657; x=1768415457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx2taddgtABc2OMI6OXSOW8L/uzHIuesESNW5Hivnss=;
        b=QE8xe4+SdEqPeGAiF/GbuoixIygcWBy2FG6yppwgFQQzTjhxTqmkwk89GaWrz761/U
         0j6hsMvo+h21jt/uRYRmLeVByoKhO68muqy1fL2h92ajXU2EVi31KWI4kkLpYBoaR2xZ
         OmpfdjY/6osfyInGWGzb/dmQMCUCK+IDoAm9DkoUHWrm41IIjxjOJiwx+UqBpRDxygBf
         YTCq9S/jzdHmSfnEwHU6QHl38W6d1XJHwDe6NRM24nFyBvDJIvneU8VQzW/BvTYOgvfP
         /k5egZY3S0VgKzd9HahwCIfI9hlBidq7C7ZyurnMadaUZ4CX4GjXSS9nW/MEceHWMaCS
         Vefw==
X-Gm-Message-State: AOJu0Yy8h071Qsm4Cc5kvwHyG8TYp6WVuZk0YdvV0FFPvJoPZ7T+gl0G
	TFI/Xl4mzGCxANuyPcMAI4XQd1yVvzymoaC2szyrpRYwUUJs9zIVxM+al83sAQyaPjCfSLEXu0C
	0Ps7hIY9sHpQ7UEv0wWr109H3ythXNbo=
X-Gm-Gg: AY/fxX4DF1wMoxz0blN8mfTBsSxypMI1f8EkKy80ahHUITHY/XgyQNIOlMHG5PAIDwf
	98yhVIIajiCcteZOdkIRTksFyrBxyjOzH1ax92OjSopos6CTmv8DNAxPWJRVxj5DKdHHQqO/W5h
	7Dd0xRdE1+JTSltaCSVJxV3I5h8tcIk/004hvjg090ht07vCaQjP+B5DejFz8RKOjlIR+t5aTt4
	dwzAQTdgx0Vs/xqrjOJeCFsjFB2O4KwRziLqyOQ1YsX3FVIbsyE8xJwP9D9aefzam0PhrDNoTtG
	wkDOP68DR3HfMvGmn9wv4k9trAqjSg==
X-Google-Smtp-Source: AGHT+IGYNguBgltfyQNIxy5vX+0ih/uFM+OYVueRe/Him0Roz6kWWUUu4dQGg4Qvyh6cR2NN9qLuVJm7IwDQvcELAbU=
X-Received: by 2002:a5d:5d11:0:b0:429:d3c9:b8af with SMTP id
 ffacd0b85a97d-432c3764450mr4468788f8f.25.1767810656483; Wed, 07 Jan 2026
 10:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 Jan 2026 19:30:19 +0100
X-Gm-Features: AQt7F2p2cU5phKP92KVSajP9NIwfXLm6yH7_ZZJ5nrHdnMzcM5XQo-ul1gSKBAA
Message-ID: <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce mpmc_cell, a lock-free cell primitive designed to support
> concurrent writes to struct in NMI context (only one writer advances),
> allowing readers to consume consistent snapshot.
>
> Implementation details:
>  Double buffering allows writers run concurrently with readers (read
>  from one cell, write to another)
>
>  The implementation uses a sequence-number-based protocol to enable
>  exclusive writes.
>   * Bit 0 of seq indicates an active writer
>   * Bits 1+ form a generation counter
>   * (seq & 2) >> 1 selects the read cell, write cell is opposite
>   * Writers atomically set bit 0, write to the inactive cell, then
>     increment seq to publish
>   * Readers snapshot seq, read from the active cell, then validate
>     that seq hasn't changed
>
> mpmc_cell expects users to pre-allocate double buffers.
>
> Key properties:
>  * Writers never block (fail if lost the race to another writer)
>  * Readers never block writers (double buffering), but may require
>  retries if write updates the snapshot concurrently.
>
> This will be used by BPF timer and workqueue helpers to defer NMI-unsafe
> operations (like hrtimer_start()) to irq_work effectively allowing BPF
> programs to initiate timers and workqueues from NMI context.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

We already have a dual-versioned concurrency control primitive in the
kernel (seqcount_latch_t). I would just use that instead of
reinventing it here. I don't see much of a difference except writer
serialization, which can be done on top of it. If it was already
considered and discarded for some reason, please add that reason to
the commit message.

>  [...]
>

