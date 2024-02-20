Return-Path: <bpf+bounces-22348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2185CA79
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28C52836E9
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98313152E0B;
	Tue, 20 Feb 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TYZa+R7U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A2151CF3
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467134; cv=none; b=OwbBrSpGXwnAcPjFb/ZwUspo6QJu17HbEkjTAnfoOzArj1wDLjCRhbpCgayV75wHIyd1Job7EZfWzngERhymTwJT8RUNYmf5Eg9xgLBDAW+pbx+32aUVGFYDZ1qiwpvHP6oLWAGiorMYI+AAW6vKMHJPjbYIKRRlVf/vszBl+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467134; c=relaxed/simple;
	bh=LUbJlvJuIV7XYM0rbCvTM0VLK0c4K1LguGjYBMqYRAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgAUhdwLqMAAo14vkVcIzzIQPFYFLLG6+eVuC/Yxzdi1ijiP+BdR7AN3kyaWj2u2nE5i+WCogT3USIyYVoqXZrkhQZ0ifzXOILIpVgcSlSmHiiZFqQhTw6bQO+FUr87oBSTxt07S5pogbOUD8c50MfxIZAKmyJVRrFwx66QgjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TYZa+R7U; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512c4442095so1742998e87.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708467130; x=1709071930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRo/+/dQVV/a/ImMPl3aMRQaGyZPvODzniivdVj3xis=;
        b=TYZa+R7U0MyTU+kK9fQGfUicHJXN6SDOuSvyU3Y5vFCcb6Nw7T/Q7obtVT5CaJBfO4
         4mqto7xAmGJdjs8yQPcLDzWysDIQ9IMyFQVQALWoW/NsKpRdvmGn9sFSHzuM2/XF4a85
         p82HH8uuzNZXPNXgcDmvwkZgy4NjBBe1AhwwV49PYKk+C1cADpyUf8/03yY89xQhgth/
         HoVNc1RxH9VokglN5c5wLpFTVaMx5B9s55ziFyU8cJEaUkPeeusyA1R9wXYXPFA6uB85
         kLku5fhSsvhhiHOIs/PFm9oUc8igE5uk7c9cjKnZHvAInoDWWUALpLspeBZQddDOIYcJ
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467130; x=1709071930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRo/+/dQVV/a/ImMPl3aMRQaGyZPvODzniivdVj3xis=;
        b=Zdj5v4rGsNPeYM1IcnW8lOA1wi7VP0+BqnQbU96jn0VfO/eqoiZSoZ1Ab1reck6L4c
         Sicot7aTprKqgP6LsCpa9v4rRjF55StLKYpDB/BO4hQQRPJUGTXASTRpBTm3nlnQDirX
         IqkjLAc1Ic8VpvGNjNI1Fk2RnVYpMpFJZPM/Z4ox/K2kY345gP9eCApQ7qrdvjH4GjYo
         ZGa0rU+JmpUfoER+PBPefjNcJUbneVgRN5socPPGWcIuiSmy6eVqLVgo8BzAJQG3vo2a
         /h5QAwY2JxB0iFoTCKWciILCMI5cHzXFcJhTjxzz9M8kreC/RT2Uat1rUPa6JPlrW/10
         WTBw==
X-Forwarded-Encrypted: i=1; AJvYcCXRPKU2qkn1gARQ1p79P6xHnZ8wEJE6l/r2dorDi5yTUgx70/rk/SfXthRTVlSTHGCmBi9TuPe3A4+lRB8x2CPk46i9
X-Gm-Message-State: AOJu0Yx+aknJKNUrvvOCqYVeAvdzgASoVwg5boB4At6YqiuPVxr4wFso
	18B4cBgvQQOtor+pIFkfTRPUOimOC9oQWe30JufOzXKfN21mO8p/ZQGcklG9JT3D2EnqG+lGhzA
	cQH/eVaYzHR5RlmJYZgxOfkhqYGMUBKtf2MXw0w==
X-Google-Smtp-Source: AGHT+IF41cHVf8ZA8jWjXcqW2BbWtC3Rb1Ku6snBa4xpJmFc8WxJcGwU0ffhbradvu2yDnKUnM01mRzJI37t9np6kYY=
X-Received: by 2002:a05:6512:159c:b0:512:ca2f:4b2 with SMTP id
 bp28-20020a056512159c00b00512ca2f04b2mr2540948lfb.44.1708467130344; Tue, 20
 Feb 2024 14:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <ZctnfZWWO3HCiXe5@andrea> <87msrwfxpa.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msrwfxpa.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 20 Feb 2024 23:11:54 +0100
Message-ID: <CAHVXubjdpFER1v54dAD-Bg=Ya4NkDxn=v+9bug0Xng2Ta=Nz8Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:25=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Andrea Parri <parri.andrea@gmail.com> writes:
>
> > Hi Samuel,
> >
> > On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
> >> Here are a few changes to minimize calls to stop_machine() and
> >> flush_icache_*() in the various text patching functions, as well as
> >> to simplify the code.
> >>
> >>
> >> Samuel Holland (7):
> >>   riscv: jump_label: Batch icache maintenance
> >>   riscv: jump_label: Simplify assembly syntax
> >>   riscv: kprobes: Use patch_text_nosync() for insn slots
> >>   riscv: Simplify text patching loops
> >>   riscv: Pass patch_text() the length in bytes
> >>   riscv: Use offset_in_page() in text patching functions
> >>   riscv: Remove extra variable in patch_text_nosync()
> >
> > This does look like a nice clean-up.  Just curious (a "teach me"-like q=
uestion),
> > how did you test these changes? kselftests, micro-benchmarks, other?
> >
> > BTW, I recall a parallel work from Alex and Bjorn [1] that might have s=
ome minor
> > conflict with these changes; + both of them to Cc: for further sync.
>
> Indeed! I think Alex is still working on the v2.

Actually I was blocked by Andrea's comment about patch_map(), but it's
not related so I can spin another version soon. I'd say mine should
land first because AIA support may get into 6.9 (?) and then this
patch would be needed. In case you re-spin another version, can you
rebase on top of it? Unless you have another solution of course.

Thanks,

Alex

