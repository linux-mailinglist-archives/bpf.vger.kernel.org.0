Return-Path: <bpf+bounces-78027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C8CFB9F5
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74980302BAAA
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4613635C;
	Wed,  7 Jan 2026 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8vVBG/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D91A0BE0
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750404; cv=none; b=IN6vCLLwji4P6p/AnGT/ZIqMZVWKzvsvXNmxpPf49vAKegsIj9t3ts8+05Q/3H1V+wdkVfmTvkua7wz/kO3hekYi4/f8wtGzOihQglvrpp2+RgZLU+PIzDKKHvfLpIQ9yo7gu6QTQaiCDcFNhtLztOmwb/Azu6MgNNIfmuhZkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750404; c=relaxed/simple;
	bh=e8PkpUl9nflmuAAbt49+x2oAxxVyhVjCC8fsrzyEzGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmrnD6CGrkFylhQt4QVDMpzc3bAo6y3c8wFOw71oW2ZLC+MRzflmL32nmA55ismokxt/k7WlUzkFA3tY0nxSpzyDNPMkHakI7D7yx8CjRGjYUhXjb1npleYxzb8GpW/QGEsrn6oyt5bwgxk+fH7gnbjJVjQvkqAItrZT3r3n0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8vVBG/9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430fbb6012bso1164827f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750401; x=1768355201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hh1MBzEHYQ/gIJ+i1UUE+0jfjr7gE19BcvQJu0KifA=;
        b=k8vVBG/9+W3KSJmbiNuT6MrpehUHVnkuq2oS2K3nHupqz5q1YIaCc/+jYlgmiWtx7M
         6L95xlMK678kSF/MpRgXY0ib3i3Iu5bSCESi1lEgvYQPbkepNfEkzrJpB3udcTfnqEfx
         v7VEUql0FmNxNo2TgYzM8TAZ/Xh07h2vBqufjUOFHEoWytYQcFjkVqd0QHQX6aJL6pJW
         HYVTkoFkx3CEgiyCWElkaEBeP7I7ed/nvxPrH8IAW1s32VK2ywJIfn/dK6EeyaT1dMDN
         2wrbyaHMo5hFQed32ZMUDZyNyrLJ7xDFdXfEiUHfCQz6ku+ppl8S+ZmYCdHaTYMC3RGC
         VbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750401; x=1768355201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hh1MBzEHYQ/gIJ+i1UUE+0jfjr7gE19BcvQJu0KifA=;
        b=YdcfbIiast3mm+ABZeOKtW3ZlA5KUm6RwsaRAVzwFoAGBE/tuo/Woe9NUVsR4iiofY
         SxNTtb4WXnEpwjDlqj0yCsLt9mEbmuWnw8yrD0V0Zchg+hAagtOJHAxVFtVIJpuR0RZI
         ytuWqLvSlMwQ7JpMoBSkNpb94yEw1wx29iMHFjOib7/MtBhYIZmw41vrAtJdLFFx5+Wa
         yJ1R2TW7c0OdsRA+9zDvY31sxGRi++S3OUX6AwthkTP1K5YL+TQYOniVq/YUIT3xQ6DC
         j0FMoDqzl5Be5vkNSyhk0C7L1/gsVIqr17lbmdA2XufREu5CmPlBARJec0J3n52hmgPD
         THQA==
X-Gm-Message-State: AOJu0Yw+7yTvEaaDfZqRZPNTesXkYYQ3joymUqJh3lfgVyHHOFWozvlh
	+P3aSZaosJpJiww3rmnhmJC8CtT28qUvkQ8I+erK4bR8moHWGj0G41fd1r7N1Eg1VYkg7wQSbLF
	JdbIf5SEa1ie5Cl3hSjhgof2ECIBia/8=
X-Gm-Gg: AY/fxX4OENyJ2f+tKZQn0kagGAmkOuqVXhB1nsYPXFim9tloxskgiE9FFQOoQfdXyga
	wfOqZRXtjRzHpAj4Wyy+PPm504yu7DPbSTd7D+N8N1iL7AN9fdB0fkkryLzanAQpaWTDTxrXbtX
	CMqTkNQqQTfJsfiocOCNbDW3G2WO1OOLphQUYfqAhKw6fzSruBPE+Iy+p35UQwVDtl0kYGKIxDH
	QzEVJ4FgBJ7LTZeKVNhk1vs0VvMc3ytNZCAN3DOlez/QvoCPD/hbnvOtDAMxmvZkFovs2zRY3+K
	RQz1EOnHEmgWnSDeaH1VZfJZyLrE
X-Google-Smtp-Source: AGHT+IGkdf+/uFCCuTUCyHK+/vV96ipex2O5TQvyN0KagPqXr+o2lmwH0431LiUwP7vr1wDsDCPn2TlbO08tqXCwFWs=
X-Received: by 2002:a05:6000:40e1:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-432c37759f1mr1030042f8f.18.1767750400846; Tue, 06 Jan 2026
 17:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
In-Reply-To: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 17:46:29 -0800
X-Gm-Features: AQt7F2oufoL5WziIlzUX-hTzrYKA17jkADlmBkPMaMaXgEfZMCXANaC6xJjuoFQ
Message-ID: <CAADnVQKizzXsDD_qEguqJ6SKrHSftDPaoV3OdduCMW1BZgBnAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bpf/verifier: allow calling arena functions when
 holding BPF lock
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 3:37=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> BPF arena-related kfuncs now cannot sleep, so they are safe to call
> while holding a spinlock. However, the verifier still rejects
> programs that do so. Update the verifier to allow arena kfunc
> calls while holding a lock.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
> Changes v1->v2: (https://lore.kernel.org/r/20260106-arena-under-lock-v1-0=
-6ca9c121d826@etsalapatis.com)
>
> - Added patch to account for active locks in_sleepable_context() (AI)
>
> ---
> Emil Tsalapatis (3):
>       bpf/verifier: check active lock count in in_sleepable_context
>       bpf/verifier: allow calls to arena functions while holding spinlock=
s
>       selftests/bpf: add tests for arena kfuncs under lock

Applied and reworded 2 subjects.
No need for 'bpf/verifier:'. Just 'bpf:' is enough.
Also pls capitalize the first letter of the sentence
and add () to function names.

