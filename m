Return-Path: <bpf+bounces-49880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89AA1DCB3
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B6F1883A91
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19C19309C;
	Mon, 27 Jan 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxxAVW51"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E60190676;
	Mon, 27 Jan 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005856; cv=none; b=PSUbGkN9dyEnsFCZ0DxEVuBCT8Pv2xRILdPyZSwAlDyxfh1zIIGsyNSGpj2vZHj/Vevsrzgi6Iahf76B0hB12zP03orW93pTN6EMv+pKhIZhEn89Gicmvlu5sxun2QqgzHauXeqfKdyYaD86UkDYHouJkpjyMbe3awnWE2Q5RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005856; c=relaxed/simple;
	bh=/kEDHyQVCySMuRNI6U8EsA0JhC7ZkhmXSNlFaLVcBNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUfIPA6jUiYdzVJ8vcFq81Qt5dDUpKj40mlCRlcT7fjTNanvwnH+DvjIDxg6zPxDAdeWGxG7IV8G2HAYN/xAdNNUU2jG/l7uSsBnHdIQN8irKcX1aMbaIWMkQwyaK8quTkuQZMnMaJqPH4UoezO23wD9qOSGVnwCJKZA/6DLpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxxAVW51; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f321876499so2592575eaf.1;
        Mon, 27 Jan 2025 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005854; x=1738610654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHR7FVRJFEmTwnPK4YFb0Tx9FaISLA6KtrQZ5JTIYX0=;
        b=gxxAVW51t1A/3ceXBcMKK+GxKEP355GBGvmydOl9iZreWoiggmt1CMBFzvt9RNZUR7
         AK6togb4+getCYnfqJVeiHD4dAHSEW8rj6mXmMjuj7pjnevCr45Cly5ceyCtwO8KzJFM
         l851HNzFCBAm90l0AotwOaXfjcHJVmOFCMA6cm8BDnJ8Q72ltGbbYThduJhV7+1/T0gE
         X/Y19Y6OSbp76DGvT14emLbcqh7O2EDVRWQKrJ1ZP8ut8S1tEXO6QiW4JtnRi6MGdK42
         2LXW6ZCTbhy0e0/yIbhhQqODpsEVe8IbFx//dSqXCmY7gKpdtnXU6f1VAourLIJdEJMv
         ZExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005854; x=1738610654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHR7FVRJFEmTwnPK4YFb0Tx9FaISLA6KtrQZ5JTIYX0=;
        b=L65y+8z3EFuOAzv4KQ8YQH8zXASjPEMzNoHI0IFJ0hhOQUJlrvlUoqp3xeY4pSWYFc
         GhqgCc1DUmfDi3M9lAmOoPcezwLSPFjNZvBGT4ABMW0/z7kscjI/57Q1EvKl22akYNgj
         +8jV7Zg3aUi/4bPotTuqYsMxxPwb66pwqQBz+9bPa7IDyOXHTCaiZvp/NI3ZWTXS0C+6
         WTTOlcDLWSd5xmBHjOgpIYzUw6ZtTb3vzm63h/EDEAYO+TEM6Fv1qRPpmSK5uA4hrNNh
         nN95/OnX6JAY7cp/Fg9OFDDbxIFY+fnWxbXrPDdYLQbqSKfiFnV/srkkzxBbD4XrK2/3
         67yA==
X-Forwarded-Encrypted: i=1; AJvYcCUDwZHANKNrMOm3d+wNIVxjZxVhAAmp6qu1I+sJfyzMLcz4S2k5wLlEj9b+o/76f3SE6qoZA7yr@vger.kernel.org, AJvYcCVFFpQP4qmuxvnukmphkbkUowrG9DAtpv5RSPAfHcgrn2s1lTeOAQyH0cO4F9Eu6DM6aUGys/t1DpCA0Inv@vger.kernel.org, AJvYcCVt25EBbooskxSN0zrDp9epNFLba/GvGJluHL4Ns3emNdwQ4aFnRvRJAg9M4DUxyVLJoLA=@vger.kernel.org, AJvYcCXVYWlkrg997vdijreOg8NEdQSwsSeMQYFN4FdIUfiooZ7UYjBIrwngYfveH5PBwnU5vQGpuHlE4w9hzG3FgD560v9+@vger.kernel.org, AJvYcCXjShRVZvWJpRT3/GzownGPz4dPFIBcIvzJFhkuzaUejEt0GY2qwj7vf7ci+dk1IoNmOovDzMgnsj1A@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfkIWhIsWUiCfYhyK65CCYzBkWUQWUa7QrAEeF2eMC5L/lbkk
	wcgdo9hmNqhVhFKTB7D03DELT7epuPoeWiJ6alezWfs4fIqmFWxUYbSTKg0Z0oOnKvJQTjVtcGz
	ooZ0EQLBxvkdshMSO40PoN6Oa428=
X-Gm-Gg: ASbGncsth0FE3+H3cLANCcR6quPeR+X9dEoWV7ckmyFVJGnvYeCqfy7tj2U6ppXIQa7
	T/WYvp07+W8BvBQ56IlOdEHAZqILe9moFnDZgllPV4ZztKJkniZxcobe+QzPepg==
X-Google-Smtp-Source: AGHT+IFGxwWBJSrGM4HJ0KrivdNIMXtatHKU92Wv5VUW37qqQGTlsCwXtWtNyC5iXXS0pMEDgnnxp5bTIMk7XjuyXSk=
X-Received: by 2002:a05:6871:a08b:b0:2ae:d23:3c2d with SMTP id
 586e51a60fabf-2b30f2c169bmr355033fac.8.1738005854314; Mon, 27 Jan 2025
 11:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org> <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <202501201334.604217B7@keescook>
In-Reply-To: <202501201334.604217B7@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 27 Jan 2025 11:24:02 -0800
X-Gm-Features: AWEUYZm3VG6eUEE-G6KVXaPssRvWQtf6XoIy3B7FGzCTUmto-UMUqWkpykNUn4M
Message-ID: <CAHsH6Gt4EqSz6TrQa+JKG98y8CUTtOM8=dfCVy0fZ8pwXJr1pw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, Jan 20, 2025 at 1:34=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
> > Alternatively, maybe this syscall implementation should be reverted?
>
> Honestly, that seems the best choice. I don't think any thought was
> given to how it would interact with syscall interposers (including
> ptrace, strict mode seccomp, etc).

I don't know if you noticed Andrii's and others' comments on this [1].

Given that:
- this issue requires immediate remediation
- there seems to be pushback for reverting the syscall implementation
- filtering uretprobe is not within the capabilities of seccomp without thi=
s
  syscall (so reverting the syscall is equivalent to just passing it throug=
h
  seccomp)

is it possible to consider applying this current fix, with the possibility =
of
extending seccomp in the future to support filtering uretprobe if deemed
necessary (for example by allowing userspace to define a stricter policy)?

Thanks,
Eyal.

[1] https://lore.kernel.org/lkml/20250121182939.33d05470@gandalf.local.home=
/T/#me2676c378eff2d6a33f3054fed4a5f3afa64e65b

