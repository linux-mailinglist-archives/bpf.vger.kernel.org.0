Return-Path: <bpf+bounces-22544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B40860821
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D551A1C20D44
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2D1BA39;
	Fri, 23 Feb 2024 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACGmW1fN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FBB674;
	Fri, 23 Feb 2024 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650700; cv=none; b=ogDlc9OF0Ti6GOd0xwj5R8HV/W/hmoJHjD9oQrTNw2uSS7cIboBLP2/k+Gq06pVwM/cm1SnOgc10/4+3Q5QrO0xb0tGJd7K686Uplc14tZ1ZwMD5+qwjujfXn8lxjYxyhhKcoJnVvNWHFS+RgBq8CfS05SSQNlZv/Teamt3MjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650700; c=relaxed/simple;
	bh=j2k5ZllYgSgBo3TQZdAws0Mk11k9zexmqPy78Wkol7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA4xQRqL11LuTr7oANEERNZpkD0wHEBQCSQTbL0kgwr4pA9nzsQJD3WywDdt9wnKl/nvPOb0YEoK3eUl8AlZy8ocHKQ6fHCprkgW59DK4mfb7TGSrerVBKkHcjpnWfN1rX35g1QXsnfQonrA13npkuf9bYyBmjHjHocTecw0lBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACGmW1fN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d8d5165dbso190672f8f.1;
        Thu, 22 Feb 2024 17:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708650697; x=1709255497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2k5ZllYgSgBo3TQZdAws0Mk11k9zexmqPy78Wkol7I=;
        b=ACGmW1fNRbq5iMMNpluKLTvHZip5x7Zrd3RpzVm/1b6CP3Q8u/5OKgrOg/QM7trC32
         Czs+AeKBchENk2GLjGxt+rnnmQFkXdG4arMIJLKBsHR0C8WH9Ro+4z/JGuWIzTXy4QRn
         66Z67OCOPEpnJN/41/nttMgyBGiyYhQYZFRcDsLVf1pkEFjNyOb2XDRODQv2BGE0Ymvl
         jRZBzW78tE5nWcsR8yJjOzRfxg6k/V2p824dblmCnnDpudjDaTH+BU6axZtI+kLerClr
         nTl1fH4+5RLM4UiXo2OLzSWxJPfyNoWpc38vKS94fYeeZImi2lDqwGBskWLw7WIyMFZp
         hmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650697; x=1709255497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2k5ZllYgSgBo3TQZdAws0Mk11k9zexmqPy78Wkol7I=;
        b=ROoGKOIrbtMSO9Ckt7HqWSitTW1yxOy4KWOJQj/xcYPa3yoMe52lFx+KI1E0ZBQiVP
         sKRqgNxowyQH4erP4JA8RwbCVCy1+O8G+X+2DYUbqtiiZFMgECEFlsVf0WKB+VJ8O0GG
         JgxIfA6pkVyc0Ymtboj6lPoqtvE7AAzJC9QDR1jQBr9llpIW7HPOo5uvW4s5JocGvKR0
         +7gMNE6rCYmuPkouiPVBtqHvIFdbR/UsMyfsi4/K8OPKnYSyn2q96hY39IXyjt6UNB80
         fcnSsovBSrNTlyKw/7eEiUYepcxPEboNc1TSc+scyYDZoauV2gKGWDs1s11fMsiVnIno
         Nyrw==
X-Forwarded-Encrypted: i=1; AJvYcCWrrbyEBNxO8I1Dc14ZAXsDI4RXlMDeW7uz2q6T/Us29RE8LCHA+nP9p+sQCjD0/Keamy9V6k3HNgQLX6u3H9mbg4rQFngQ0eo5HV5cT7vLbLYUeZFfNH3HfrKsXS1gI7xg6U5jGl9u4GcnYLeFgoL16WxYEGOUAhVi
X-Gm-Message-State: AOJu0YwWEtb/oojkFxZJ8G8L1EZurAMyMCk2gRB171EDTculSLOwJNPl
	779Rh33ATfHQs4OCzomR7YZO+2jSyyv3aHnzs4MqXbvZYj9DfPaL2Ilc9tAYhSUCcvTO8s63bQL
	oQj3mBCQ2iM9EymRPf41P8ZAThyU=
X-Google-Smtp-Source: AGHT+IFAm02rgB9C6T0z0mzXjdMNivWCv51WuyNuPebZcpirr2EInwPrFlErIRzAzsNbw4YZu9zNkvHfYkfUW5Z0F00=
X-Received: by 2002:a5d:6512:0:b0:33d:3abb:6db4 with SMTP id
 x18-20020a5d6512000000b0033d3abb6db4mr422898wru.69.1708650696726; Thu, 22 Feb
 2024 17:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87r0jwquhv.ffs@tglx> <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
 <CAADnVQ+9vTBj9GgxotLF0_oV7cNFRebmcq_DNUm+cRJHQXCz1Q@mail.gmail.com> <85cdc364-e19f-625a-16e4-4efc6451fc7d@igalia.com>
In-Reply-To: <85cdc364-e19f-625a-16e4-4efc6451fc7d@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 17:11:25 -0800
Message-ID: <CAADnVQKYu5RXGwq3rCJfzGq5AA-msdgBu4gA0tY0ASGXnXu0Hg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in copy_from_kernel_nofault
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:09=E2=80=AFPM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 22/02/2024 13:04, Alexei Starovoitov wrote:
> > [...]
> > The fix is bpf and net trees and probably will be sent to Linus today
> > as part of net PR.
>
> Thanks a lot Alexei!
>
> So, for completeness / archiving, the patch was now split in 2 and the
> links are:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dee0e39a63b7
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D32019c659ec

Correct.
Please double check with your two syzbot tests.

