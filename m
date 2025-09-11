Return-Path: <bpf+bounces-68170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C8B53971
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073295A4442
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E435A289;
	Thu, 11 Sep 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K76+8ZF2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39510288D0
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608747; cv=none; b=cJQyOQGA6fNcmvH8fCQY9/xTUmIpNbbfZyJscDA51nAwn8bheDw8xRxdn+WeVch7s5EwHwBV+kcKLTRYNALxtH+lVVcqXrqAmaFtNsx7Fl74E5IChqWcxho7GC6WMJpO01swL1MmGdJlmVB3kjHJHN1CubdDUA2mRskY4GyCKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608747; c=relaxed/simple;
	bh=dwL41h1NuqZlXxemrgEmX8+q5C+WnwXxaBf52vP+iO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahv8YMrRn3U6hCx5jqbTY7VFP0a2RiVCrz1yd4QIu5ILLIrtS6jjzoExGy6uU0Ee2J2KBor9oKeD5Gr0ZS4autkn7QN5x5Yx9crE+AHPT6ZkLpuHpL8it7tlXJZdMfBNvOKFXITr7+WcNaMrhNM1bYNYc7p46L72G6Wql4USQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K76+8ZF2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so710127f8f.3
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608744; x=1758213544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwL41h1NuqZlXxemrgEmX8+q5C+WnwXxaBf52vP+iO0=;
        b=K76+8ZF2tunqkJt1jYLUrJdt2wAaUYqNKDrylq0JL6ly9ZThTDABNK7yLkhEVsH7fL
         GlRRTrOLS70Q4jG2GGIYom0YoWxHuDH8r5gAHltfDnaDFbeKolNXQJ30L2hfmI6Eswf1
         upoChx4BxCeyByQNGVqu0Dg9+4mzr9MRn6glJfbESYzqiRID+N5RNSHqX5pwneKR302a
         tnLFnZ3DeE9rVG1E1G+Q3TbAlZEufKDz+/ddeaumBl5DrhqbqHeb9IHNwuiBM6WbgthI
         Hq6fqqqonpGTpOuY5Sxb9quHAn2d4egUTpw5gDYEUWh7Ftra2rRQMQ2eE/8cBt/tcea+
         yRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608744; x=1758213544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwL41h1NuqZlXxemrgEmX8+q5C+WnwXxaBf52vP+iO0=;
        b=HNRacNrdRHhROftzjh3FA7Mi0gR5TjyvvaVgPySRDq5YcNtXUmY+hNMNnotJI6Wiqz
         yFcZNL7FLWMjh8lfdNokvvfhX7b9jqGELqLj5y7KMmB4Xg4JJ9NBkqfhMSFsous0WOTI
         1R4tKZalDhPMzyY74Ftckm++MzQiyR/baOQva047YFspXn8GCS107Mo83oN13fk4kSnx
         rg0j3rlqtg+ihfOZ8tV5NWgEhFDkV6DacH07Y5ctfz/MIo72HbK7d4WVMffL71EuZu4U
         ezHfxWBXoESVJhC302A6PmfM/7ym4yILxIvVeRhv1SF7MlF+aQdoQUOGxGcS8JRxb4LU
         qqfw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5nMQCR7a1fFErBNq1reLQ8ObqDZheuMGhhRYZLEdOqHnbO2AO8S1SuL21MQ3KJ5Lilk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1GHDZNpgJu9lgjTspbSNrwYWb8puWI6ZOb39O4JGc1vW0jRP
	FNAdrREiDvvRdKyTMJ6afMBZFPfmr9RpeXnhaOGuvl66X9r3gbmePdch+GqoUt7d53Q29MN7NM+
	5M7Vsxw0P0IdyUtsdTRXxnaea7hY92/I=
X-Gm-Gg: ASbGncs1nw5hQm5J5BOMIjMoPbeN+XPCjg/OwrhqBpKGsrsngTYAwwdgG4sT0gVO6EQ
	nJ+ok7SdLzT8wrMkcKgsLmsgug/aG1RDE32AgCX1I2sB7oCKnBwdJse0sTBmHtBxGQM/zSCJn/r
	bFv5F9iJLIzl8VOknnJ/R5gQWteIt1LNOVkDgOU870UvXhZwTE0w1FSfWnxJkFwHccIJ+Q82/JD
	4EHsGqFMkloR7dcP/8CvLd8mwk89FZVmw==
X-Google-Smtp-Source: AGHT+IF9UDbReTUWx0e/9y3c0wFFLA5kR21u1RL64t8G28gTIrVsEluaeBDUcOOpnMJe40falCWUK0485bEGc3vjd8k=
X-Received: by 2002:a05:6000:1449:b0:3e5:a68:bdd0 with SMTP id
 ffacd0b85a97d-3e643a245f3mr17889427f8f.52.1757608744280; Thu, 11 Sep 2025
 09:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044025.77519-1-leon.hwang@linux.dev> <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com> <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
 <cad23151-7039-4a7f-b4ea-030ec161b2ba@linux.dev> <CAADnVQ+C+Zyzz4MHU1Qh9eVuKec8+F+gnOZy5ZDVUAXWP0O9YQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+C+Zyzz4MHU1Qh9eVuKec8+F+gnOZy5ZDVUAXWP0O9YQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 09:38:52 -0700
X-Gm-Features: AS18NWCx8Jme5n-PgGUAqiydwtwwkHENc-VR9hYD7wnqGEeqqS1UnvvyzTukbvY
Message-ID: <CAADnVQ+SRASFFSyRJA=nDBbojMo8FMw4ihsEGzG78i5wYne-6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
To: Leon Hwang <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Peilin Ye <yepeilin@google.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 7:02=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
> >
> >
> > If I respin the patch for the bpf tree, I have to drop the part that
> > skips the timer_interrupt test case. Should I?
>
> of course.

Leon,

the fix made it all the way to bpf-next.
Please follow up to silence timer_interrupt test.

It shouldn't affect CI, since we don't test RT.

