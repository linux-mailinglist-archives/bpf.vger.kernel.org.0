Return-Path: <bpf+bounces-52770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4FA48538
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E104172F83
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D91AF0C7;
	Thu, 27 Feb 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw/K0prK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0314F9F4
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673471; cv=none; b=aUxZe7sVLVNBnEhG0fft+mbq6mdO006QnL/4df5gyvdkxqbYsACX9cQEXnkiUEfECdnYXqDGqP7eizsQr8Mvd+gFC2R6Xn3pOD0dz4f74JjZMA/KBOL90FIx5P43NpCejdDLr5AIhZD7EAQvz2+tsjUYIEZz5Qfu25blNI9l/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673471; c=relaxed/simple;
	bh=T/UWXdMktXEFBXCKgaSJyy40tqAJDhesORy68t8uwwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijljA7VQXmrwnvnIHIiQkD1dheib+1foA5eApojbaLDwpsKkks3noSlXQXgAtRGsb596Z/smccXeEbXtzgC2vX2DDZOxg4dkf+CJTrTwOI02bA8VbYx1KnqooiXjUlRg9RhaM1ZNiMJ8uT126RPLYk1ZCInO7tMAzTZWvOOSwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw/K0prK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43995b907cfso7780485e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673467; x=1741278267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/UWXdMktXEFBXCKgaSJyy40tqAJDhesORy68t8uwwk=;
        b=Lw/K0prKDxwLr9uJaX5RtifUehgljiu/6QaBEqY8n836v79D5bl0n2+k7RBzIwHoO9
         EzRwAnx0ra2P2BijDnEJvh5nHrDA+W7BGYQGZ5KzkSu6CndIYzYXqDlc6yErTMiqrPs2
         c88Ecw1KF6TVfXlGn9mtGAnTsvRyTxNSMyTFpMo14VeP+AZGboUmowAhp/KuDWKgOcw3
         wIUMdF+waYDq8ImRh3XrER2LQKUZSZ8PPxxk9mMdoYS6Hyw69nqqavXTUIOLyzBeYaUd
         4ir4z1NOPzOXb2bCNF8IuTL3nlu4cxJ2UU9PkMYvzQsfSkcDkVdzRY1xyC+StvC2kpOm
         yB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673467; x=1741278267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/UWXdMktXEFBXCKgaSJyy40tqAJDhesORy68t8uwwk=;
        b=miB04Y2aYx5olwF235kLrHxXy3u9eg0JlyovR4+co0TZN3m2Px7YS/fDri0UiLcJVB
         V4tXurP+JeJnAJ30bRuDDWr7euCsQ7BYxgbyDkmDNDlB4PpW+PmTM7+WYZLBZ6XKCdGX
         dmzBuRQbK5aIxBbCuxzc3vLFYB4IKBJFjTGg17CFEcJsLPMKhW+q/H1/bQ2sGIGSHTxo
         LXDr4emBX61VDOst5Bkq6QbR2OkQg5ZJTRRYZN/BfhHQJKnZsNWgtrVXtTl6Lpz2N4vJ
         ym2UQvdaMgDWdMJ4R/c002T2HQqOfr4BTx/K291dGntg0YDQIJvlSVzuqLZWLSNL88Il
         Qnfw==
X-Forwarded-Encrypted: i=1; AJvYcCVWFZ4vWZCTXNwI78ZV8W5VvafbH0+G7eSFhQ/fGtHYM0wXeanwU+oUfkF7GcJegci+4UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71fJKMW2YVSzfVYXT1JtGh0dxrmzwNVXk06/1LujEQHDOGbQd
	lc6LwVlZLmPqVqryUjXOJMcm173yEKaBdGq3rdsNDoMshpK7rn1p+zAk76b3s2ffSkq0F+wKRad
	yWev4bMHBlDENNFvGS+G3suN5on0=
X-Gm-Gg: ASbGncsuDhjbT66OaJwsNjKjqRXi8Q6LmeG7kj1YmOwPudgbHpJ6IuFiuv0hHkKMPe4
	Nw1ryHkzteB8WFYS8UZ6I33rBEWDTX0F6givNqgs9cioFvLjynsuBIJ63F7rQH5I4Gq4gnfOotK
	YsE4IiOFyTQr0Fm8O8Sy9Ldi4=
X-Google-Smtp-Source: AGHT+IHjpkplI7OhBD9W0wbWwgCoHOinqHP0r6OchSWpv56QbVcpFtGUzY2nK9lUVbrPXMBBIBi7BFOhdaKHJx4LZuE=
X-Received: by 2002:a5d:64ce:0:b0:38f:3224:6615 with SMTP id
 ffacd0b85a97d-390cc5f5b27mr9264171f8f.7.1740673467324; Thu, 27 Feb 2025
 08:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com> <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com> <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
 <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com> <CAADnVQKJr_Gmf1SjTpmVLSWaPi=0irza365_Jb2-3kOKhKULdg@mail.gmail.com>
In-Reply-To: <CAADnVQKJr_Gmf1SjTpmVLSWaPi=0irza365_Jb2-3kOKhKULdg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 08:24:15 -0800
X-Gm-Features: AQ5f1JpPg3VQf4MAwBumQenn8MPV9xt7Oz1tf9aW0W55L2xcxx2jgsuBny-16Pw
Message-ID: <CAADnVQLOq835yg2przDwvNfPNiJf4BW2Pczbj_Bf7Lfy1JP2ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Viktor,

Are you still planning to work on string kfuncs ?

I think we more or less converged on requirements.
So only a small matter of programming is left ? :)

If you're busy with other things we can take over.

On Wed, Oct 9, 2024 at 7:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 3, 2024 at 12:37=E2=80=AFPM Viktor Malik <vmalik@redhat.com> =
wrote:
> >
> > Anyways, it seems to me that both the bounded and the unbounded version=
s
> > have their place. Would it be ok with you to open-code just the
> > unbounded ones and call in-kernel implementations for the bounded ones?
>
> Right. Open coding unbounded ones is not a lot of code.
> We can copy paste from arch/x86/boot/string.c and replace
> pointer deref with __get_kernel_nofault().
> No need to be fancy.
>
> The bounded ones should call into in-kernel bits that are
> optimized in asm.
>
> Documenting the difference in performance between bounded vs unbounded
> should be part of the patch.
>
> > Also, just out of curiosity, what are the ways to create/obtain strings
> > of unbounded length in BPF programs? Arguments of BTF-enabled program
> > types (like fentry)? Any other examples? Because IIUC, when you read
> > strings from kernel/userspace memory using bpf_probe_read_str, you
> > always need to specify the size.
>
> The main use case is argv/env processing in bpf-lsm programs.
> These strings are nul terminated and can be very large.
> Attackers use multi megabyte env vars to hide things.
>
> Folks push them into ringbuf and strstr() in user space as a workaround.
> Unbounded bpf_strstr() kfunc would be handy.

