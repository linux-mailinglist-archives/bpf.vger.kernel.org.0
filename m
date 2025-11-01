Return-Path: <bpf+bounces-73222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 477BAC27607
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F524E223A
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BD257851;
	Sat,  1 Nov 2025 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOlLvTjT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A571946AA
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761964841; cv=none; b=PxFKByTIgXgAISRgh56auoMDG739JguAQVkXKxxmwbMrumkJgEKonBapBi0zQdn/gQATjl8GkTf6ENSnizCb/PBHLXmFc2Hae2v6/AIIyjFU/VNhqr45cNcOS+LKeeeZyHfOmY0I+qaf43QualJRB+uZI128kbs0UXdcc4+eTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761964841; c=relaxed/simple;
	bh=axS1AwrdNVI7tVpvEa8pgAkJwAmLP6jVbPzD72OGAp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFDG7gSEhv8bNSt0jkBAYTAp0UFKIpOdur87Ptafsu4jdatYd8qc2lcUn7kzalbach4U8EEiUdLqhaXc//HOy9g6ztINJXqjg0AJ7HPqDeMRMoHraHGDqCP4Mal+nzOt6R4/PUi+rilvb9GgwWkYdH3d0dXuFDvRaADVBIuGwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOlLvTjT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c82bf86bso79821f8f.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761964838; x=1762569638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6psaUgB7frXIi9Wul4agSrCXKtzqnC8UJp95OWWUv0=;
        b=jOlLvTjTjrXqU2TuQtFG+wUdK9SlgGRCsi4UIyiiWC9vlDaCPQiMeAhCGM2EyI5EH5
         Mf18KQSpoLTWlVdGDtiGhGNym/mHi4vtV6+CYznvjilCcp9rR/sUBDV7MkLok8ui0M8m
         164YDAJtpwtWFZQFKgC8HVM7TKl/Y6HUMW/F+fv6wpYSEkgBlZsxxQ00yqHGIrv11JKi
         w9pMykIpULGS5n0suuVH6bGBZOWdKRQ9CdMJRhLfWoSzXG5QOkWROAEHWAhSxidLzpse
         gARp2ZR07ateSaO6B6+4Q0o6q0+GE3gDLUEZEqb1AGEW4W3Y8dfWvtfAXrik6ml/E3Ze
         ducA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761964838; x=1762569638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6psaUgB7frXIi9Wul4agSrCXKtzqnC8UJp95OWWUv0=;
        b=scLfgJAQKWTVM9dGdZmu65UDjpbtD6eR5Sg0SHZZNLmg38ZeTFAK6u3PIuyDB2OK3D
         +Rdd5tzo+BCzJejsfBrkf3qIOmigH6h6tvAqIb7gkW5/m33xbEutinpa+x6oZ9ho4XhR
         WUlxDsY02jOZBApVR1rKdyLBkVclb/ZeWnoMjZyGdg1BH/krzeTKtC4FmsUgdgZ5+eDb
         OmmpEq8BXvZg0/ec9fAslbBFhTeTS6DIfB4ZN8sYx7gOnShODmeTXsb1EuAdcB7GQOKb
         cun8BGR15VxobmvZ+AN5EoVu9ahHR+ygKOszmjvvhxdWUKjmc9iiuW0B4jJTDtl3i4jW
         sL5w==
X-Gm-Message-State: AOJu0YwqR/UrQgKODdcukJ6Gk7MBTZ7g7/cW10fkr41osy+vyGvdiyB2
	UH3ANI/7DxvxoT4/KkBAYC+EMzB6VgbYYboomxShSMexIjDaIOz5rgGjgjT3sYkCRBvT3c81RN3
	zJe0MDpAAVQj4FUQ7MAu79BLCgqxsOx4=
X-Gm-Gg: ASbGncvI8TMtcyDVi9aS/Flhn1OGkmCsIbinCTR2YMzejv+Y8K+est8N5PJ8+3g3R9G
	t47z0IttCko1eQknQLlqlY7ISl44uXTzCo5oL4s1Fwz7qLS/3yvjmYRnWw46PJZtoMtJd7A1ZiO
	LhSFMBlWFBBMMzE+AF1MX2OIKeYhvmzEt5WYyQHQgDwBY0EhAFQFkCzKRkpbNXczCPujvXnlaG+
	ICIGPhX4ry4bvkmI22EatkbhoreZ426scIKQalDay05LP3oXiTLwCVjkKmioGQaW9Jq0uMiEFGB
	CBBM4qjI5wnQANs+2uvnpT5cJ7Kw
X-Google-Smtp-Source: AGHT+IGgUuZ73Ms8ElYI+3Ho9D5l9eu10ZN8QAVQ/sxw+WAEuRnSLlhVzegt9rkU6NmTXF6GKagdskVAQNNvEbCuvB8=
X-Received: by 2002:a05:6000:240a:b0:427:84a:6dc9 with SMTP id
 ffacd0b85a97d-429bd6efb8dmr4646325f8f.59.1761964838150; Fri, 31 Oct 2025
 19:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101004014.80682-1-alexei.starovoitov@gmail.com> <CAHk-=whL4iSY6kzZ+usiPHyBqf-soqJc8JhFdq1wgZkh4WPZBQ@mail.gmail.com>
In-Reply-To: <CAHk-=whL4iSY6kzZ+usiPHyBqf-soqJc8JhFdq1wgZkh4WPZBQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 19:40:27 -0700
X-Gm-Features: AWmQ_blVHXtzCLt7Ka9HXgpoSg6CgwUYFZmSQ_j8JZbU50WcNLitB8Ei9mAMj9Y
Message-ID: <CAADnVQLO1nz-B3+MyVbDDc=RTU8TnFJaxeh9pezdX9TzTPLvHw@mail.gmail.com>
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 31 Oct 2025 at 17:40, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > - Mark migrate_disable/enable() as always_inline to avoid issues with
> >   partial inlining (Yonghong Song)
>
> Well, that still calls "__migrate_disable()" which is still just a
> plain "inline".
>
> Apparently the __always_inline on just the caller fixes this in
> practice, but I get the feeling that the fix might just have pushed
> the same problem down the line...

True.
If you're curious we added this bpf specific deny list for migrate*()
because they're called before a recursion check can be done.
That denylist was introduced in
commit 35e3815fa810 ("bpf: Add deny list of btf ids check for tracing
programs").
That was in addition to usual notrace,nokprobe denylists.

There are other calls that are just "inline" in __bpf_prog_enter_recur()
path from asm generated trampoline and it's indeed
"kicking the can down the road".
"noinstr" with objtool tracking would have been a 100% solution,
but we're not that paranoid. It's root only and such.

> But maybe there's some documented semantics for this that says that it
> affects inlining decisions deeper in the chain too?

I believe always_inline attribute affects only that specific
function only.

