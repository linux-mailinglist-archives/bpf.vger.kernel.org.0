Return-Path: <bpf+bounces-59299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223DAC80DB
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EBE3A4B5F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6822D9F9;
	Thu, 29 May 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmTCjz7l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AD22D7B8
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536110; cv=none; b=mP7KfSPjn9fAETdRs3Kz9Ih+vAKAqJQMrqgjCr/Njc+24FgsXjM5HckXgf6ImIoOCq35IZAc4eZKunwKj8OHSIajoAJig/J5UI39jxHxFv342OfrpM/rppYuOEUVD4YjwPMf59657853XYx+ZLyVVLX6hCwQT0i1y+0HtvSOUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536110; c=relaxed/simple;
	bh=1z2dJN1ycztboRWWlQ4xo4I69TuJDZHFkKBLRppAFxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ya6UVv8cMzYIRzCzMnxg/ZfyEN25JO+MJQP4eGs68rvM2n+7xoHDvNNo1+e1CyJhonYiFHNFd4dj0jyQCAmSXVWrdJ0OjFWUqBDHTfEGhxvAw83jGNXPYsQ7gasuf96QRgjq0PyJOopliviaRSyps4bbe8Aq3zmkDKSHXEywA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmTCjz7l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33677183so10072905ad.2
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536108; x=1749140908; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zevbcQ6jz0/cKDLau1jW5QMV3IRY82YimfGAPPT1SoI=;
        b=lmTCjz7ljISacKEXlT+3NDlQHsXB02Ayfj+DWzNKWfZE88AchdgRL95IbDOMbio45f
         SSR+JnUYVvhTiXaL1UOGFjFlpHBMFg56ES8mN197FY+EcPJ1E+NNS0b8A2z/t5MLnOP9
         InZNN9pK0AgP8RW1vx/SQvgi/HdAB4vteu1BctxUKoYlI4PNLHHiUUafNuTqn8yieKLH
         JD/3JcXieiNYLm74zp1jim2yOk2hzIM6PvChDeYR56hd4ikZlYC1Bo4s1KoJpAWWLSGG
         R4TERs9woSiI0L8pwZdE4y9fG4D9LGZUOJ/FMss1l298v1B+EjR1oWYInY+gyS0tYz4+
         ckKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536108; x=1749140908;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zevbcQ6jz0/cKDLau1jW5QMV3IRY82YimfGAPPT1SoI=;
        b=HTGw5hhRefX0Gb3/hnGmzKj9uCUOW9cfCGjArE4DbbzrX6zDG5SoslmZCmxF280WnL
         JQp1jO+25z1G6khcCumqXZttqlVNqoFZ6A6lOxQPfP4FLDxpf2cs1FcP4ZckuEWQPLUt
         KOHonSjDzXdL+kt2s3O5ISV/E8obB1i3FxNrAbZnioeD7GP46A/xxF20fCrIMVyj9we3
         CFGM/c2uE5vduXUmeom2JjT87en5nGM+KB9+aKDHNbLNaruOqZQmR8/Yb3UxKNPDe/Ar
         kEcZWvj/K2pE+Rw0Nr+l6S0WLu9KsdChTEM1CJ3pUzyc9pX/g9c2hzzvdwNitV9CKxT7
         2L7w==
X-Gm-Message-State: AOJu0YzWG2GZHNY2cwwRmA7dm0pZXuy2dQB+bKVk4czfvuBkZsik0o4q
	J2cVIHbf9p2ZOkXWIyV7O+TMQ5YznEf3r2DU2JgRCHeTyti9atFxaiqV
X-Gm-Gg: ASbGnctnTm0tFYIGNPHM1OYZVg/MiG0NlI9yfYxMYvM1ObV3jlKNZrdjnUphFPe+aCP
	4XUEoKVOrBmdb4Zj84kesM0CG9gPxvgKVc8D6Mc44shufSgtPJ42LmvmuMa4Sr3bUKcOumL0AZj
	a9ekrsGqWoifKcqhzzp3dJ36oqNlrm4HlLy9ebExpoAeCh16l93xa1HXKFlKeWyj0Q3tV1mk1N3
	lGpAUvo7zU7VMYjqIPZuzwuYbM5XGB/X4ymrXI1pTMA7zmAsXKMb4zEu2W/QX5JkqvNzk2RirAS
	Z3OjJ1tJ0WhQeuuKiVuGR8joRtzdDbHxY1bo2mMsvtxXAtzMMDrMo+0FY/apQKvqBg==
X-Google-Smtp-Source: AGHT+IFPk5klwIg1pNEAxptwr+5xMc3r3l7gwQdIB2jJJRL3C8uwzPqyQawTTIHVC5vrzxRrHzixvg==
X-Received: by 2002:a17:903:32c2:b0:234:d292:be84 with SMTP id d9443c01a7336-235287d8d54mr3969995ad.10.1748536108294;
        Thu, 29 May 2025 09:28:28 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:c539])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc85c5sm14344055ad.14.2025.05.29.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:28:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 11/11] selftests/bpf: Add tests for prog
 streams
In-Reply-To: <CAP01T77AyzvwW7p7BBpNTdzWCEU7PLFqMgN3xg1dG5ahz_K=Bg@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Thu, 29 May 2025 16:57:06
	+0200")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-12-memxor@gmail.com> <m2wma01xaz.fsf@gmail.com>
	<CAP01T77AyzvwW7p7BBpNTdzWCEU7PLFqMgN3xg1dG5ahz_K=Bg@mail.gmail.com>
Date: Thu, 29 May 2025 09:28:24 -0700
Message-ID: <m28qmf1ivr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, 28 May 2025 at 19:04, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> [...]
>>
>> > +struct {
>> > +     int prog_off;
>> > +     const char *errstr;
>> > +} stream_error_arr[] = {
>> > +     {
>> > +             offsetof(struct stream, progs.stream_cond_break),
>> > +             "ERROR: Timeout detected for may_goto instruction",
>> > +     },
>> > +     {
>> > +             offsetof(struct stream, progs.stream_deadlock),
>> > +             "ERROR: AA or ABBA deadlock detected",
>> > +     },
>> > +};
>>
>> Wild idea: instead of hand-coding this for each test, maybe add
>> __bpf_stderr, __bpf_stdout annotations to test_loader.c?
>> With intent for them to operate like __msg.
>
> Good idea. But we'll have to run the program, which is slightly
> different for each type.
> I guess I can just support tc, syscall etc. for now with some default
> setup to support this.

We currently have a __retval annotation which does BPF_PROG_TEST_RUN.
BPF_PROG_TEST_RUN is supported for "syscall" program type that you use
in the tests, so that should be covered.

