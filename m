Return-Path: <bpf+bounces-50308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5CA2500F
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 22:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C1816354A
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268E2147F2;
	Sun,  2 Feb 2025 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bffY4Cpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC561FBCB0;
	Sun,  2 Feb 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738530824; cv=none; b=Tkjy5KIR7rORDxQgcTG+Jgx9zLOlcSPQgHIUGb4GDnHAHNIkrT2NQyTbQIJzQTVzLatO0X8Ohtm+vvimoVkwpMJekCYjOT5kgTgWarcqwiMpNhQvLRl6F5HAalaYTU8qIlufbRQ32i1dY4I6nA8Fhr8GggI8M26Lqs3b/9rYks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738530824; c=relaxed/simple;
	bh=f8D4eCkbmwbrXSeOkhu8vQGp6QAVZzZxPYw7QMMzjXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emyHgZ2OIBJpwtTrt6CQdnRRvrfZUdeumTQ+hcpMVvJuIHBMxO8R8fDJhVO1fSUDokGdF6DT/qSXGg2SgGY2z4NJdw1WQNsITgc291sfxb87YU62SrUxqxa+GO9O4DUiU4hxtB/dQhU4CI5kB7zhkqYEgN9F5x5IDO8J33PaCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bffY4Cpq; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a383315d96so1787003fac.3;
        Sun, 02 Feb 2025 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738530820; x=1739135620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFdogcQ38XtltGxTmlK+t8AjVtfSqqnvtssQcQR2L8E=;
        b=bffY4Cpq/kK6mrrTP9xgb5Uesb2LM05s1zXFcPJxDNvdMFQP/SyuDRo4oKn1jzxq0S
         dSXoeEgW8qZuW1mmS6Nu+fGrTcuQ3AACI3CAEr0aIckl2rJ+78e3PKJjaGCkjZkOpRFy
         jGhaZZbkE1Xgeuu9ATqobskJyhz+rXdJMdBLUNMfRr84fKNz8QXRynsqyFvXB7IjyifF
         280zFDlN8u6K5ySVGL7BfmCePc75whEsh9i6inhpPY+dK6jSYQZIPHmcRj5A7WytA/rF
         RsjmN18Kp4iVorGq6jWQHwA3e9WXSXZfM87TOa1OXPOEZp0K2ywjvDze5k2nnZ4bJslb
         gzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738530820; x=1739135620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFdogcQ38XtltGxTmlK+t8AjVtfSqqnvtssQcQR2L8E=;
        b=bnioqYMt+8JyncrE0y+QF6t713fUrzWYFDNy551zmi8G4QJGJAv0DM02Dv6/9vIek7
         TtTacD5jVz+YFW7aX/XG0C+9p1OpuKkX9NzJlwkkhvKwL3/WLwk5PgMD2jYOyWl2c3Yy
         WOv+2ZKpsgwOW7biHleRWYff/m+cqezDBf8H/yT2iHjY+oeCyABSBqjja5sqiFN9f6TK
         5vsoNrM2RXsHDhhy6l6nF3Th1lvu5/mtdeD7rOpTPGDPYWMKiWPh0pMzfHVFvuAbX7s/
         NMR3rejlAHRdldug3pz35DFyPd9EgZDo+Tk8NA8nftQjs9FkfzRgexG8RnBEA72KkTJ7
         COfA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fvaosuLBdQ0OVAQww5VWIodjt0EwaHV4O8du0XtPukNJKHOOrk27gU9+5luTuwizUvWGUsgPvKX9@vger.kernel.org, AJvYcCU8e3NpUOsblVd51GgyK/GH0nf6+KMrOzHtEe+78+3MicMh3xqzwcy2rdlBNs1WJKvp7PLI3qHbfXRzW5Nw0r0+9wl+@vger.kernel.org, AJvYcCW2kNuyLwHIMDVB4X1EKMajdxl0xSr2ywWkHP8ji7gZCpwYSYoq/s78pPiRhydd1RBzqqg7S/5W638HI8JB@vger.kernel.org, AJvYcCX6iRCvP6DLOtatTT6RECwDo3+3ZREym+BAgNAJ8+gHiAITpJketIZZP5HMW22CHDONF8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4wP7qIHxalbolScfpNjjugeJX+rudR24f6bMzQOyUPXAEDr7
	0x78G6ZoA0JcCydsOvxd5HyNofvme7VBFEmF1cnfM62SLeC0pn2DPQJBAuDCqDDpA+fptHBMae0
	vp47C7sD/OHRETqrYQPsz1Lh+TP0=
X-Gm-Gg: ASbGncuUIWnm2jsXyq7zuo7bU0FGgMQNuvNkjetMxydZELdSU9NLVyTRSQQeG89eCHB
	pO2ZP9Clcp6mGgfeJjgkBqP3nVCXfy5qfZEZYF1rHJ5rD11tCnejKidYA6Di0JKapsZoOoHdF
X-Google-Smtp-Source: AGHT+IGf9eyqtItD7cVcNjPi3qnIkRLeIuC4KuUtTs0k8IHWIMuBxP01qGDI93YWTZbpDHV1elM8AorjQnBA5q1pTSM=
X-Received: by 2002:a05:6871:8087:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2b32f4665f3mr12792188fac.36.1738530820380; Sun, 02 Feb 2025
 13:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <20250202162921.335813-3-eyal.birger@gmail.com> <Z5_a33NQwrVC9n3r@krava>
In-Reply-To: <Z5_a33NQwrVC9n3r@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 2 Feb 2025 13:13:28 -0800
X-Gm-Features: AWEUYZmWR5YpDXatpSIxOx9bDPa966-XZ8hkoN1gdAmg5wYWJItSzUKk2wlvF0Y
Message-ID: <CAHsH6GtpzR5_X4e0KphnyNSkKqBdgivfvyGQ1mbtA8fpnuu5sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/seccomp: validate uretprobe syscall
 passes through seccomp
To: Jiri Olsa <olsajiri@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 12:51=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Feb 02, 2025 at 08:29:21AM -0800, Eyal Birger wrote:
>
> SNIP
>
> > +TEST_F(URETPROBE, uretprobe_default_block)
> > +{
> > +     struct sock_filter filter[] =3D {
> > +             BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > +                     offsetof(struct seccomp_data, nr)),
> > +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
> > +             BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> > +             BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> > +     };
> > +     struct sock_fprog prog =3D {
> > +             .len =3D (unsigned short)ARRAY_SIZE(filter),
> > +             .filter =3D filter,
> > +     };
> > +
> > +     ASSERT_EQ(0, run_probed_with_filter(&prog));
> > +}
> > +
> > +TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
> > +{
> > +     struct sock_filter filter[] =3D {
> > +             BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > +                     offsetof(struct seccomp_data, nr)),
> > +#ifdef __NR_uretprobe
> > +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
> > +#endif
>
> does it make sense to run these tests on archs without __NR_uretprobe ?

I considered ifdefing them out, but then thought that given it's not
a lot of code it'd be better for the tests to be compiling and
ready in case support is added on a new platform than to have to
worry about that at that point.

Eyal.

