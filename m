Return-Path: <bpf+bounces-62005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97248AF04EC
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A7648484E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8885296150;
	Tue,  1 Jul 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l06at6Rf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8C2EF28A
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401709; cv=none; b=MQMbFuZ1Zgj5PqXBgcsz5gG1QXSjd3c6JU9J2pfdlVnjOwIhVbItVoDM9l4vVTU+SxC6inCD7AuWP1xg8m51+6xXd2N0CHR1PJn2BbK6RoTZ8/kOYI8hlzCDLpJH1H988MLhAooYbgIC521nmCa3FfMrA/4elUjXG5iD6B1a6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401709; c=relaxed/simple;
	bh=JscTfN7ikrissEGt+Aa9Ud0tScmNTsCJffKRDUXdzMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxRoB1b1v79eEuDX7YM+ctGB4aMEFr7yGeqlqiW1x76O86GgOXbExeS/KNm5vxfbm28xXJd1PzSxOcRUN9ouzNfHX24KB/b/EH+USgt6J57Y7SFonQEma7xjauRnKb+TLyPus3bqLTv46NL4ZwLzmTmofU2Yt/4xIvDm8ECcOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l06at6Rf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31c978688dso3695773a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401707; x=1752006507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JscTfN7ikrissEGt+Aa9Ud0tScmNTsCJffKRDUXdzMQ=;
        b=l06at6Rf3QSE7ESnWxYScrXqwe8XQf3wnJwaPu+6z1xEEpWW9+mjcDozyHLpTC4Uzj
         wCsWw+ZrkHQOxrlGoHhLFK+gRak1KnpfyD2IVc+WOZt+npB4GzXDtbNfJpZorKndCxys
         mM2Ix/7VKzRd8GXo6S3XSk3jEjvspqhkx1iX0UFyN790p4PSmt1oj+ALr0CSueMFEQBf
         w0zKP8ny3IzmtlgzrNFKy1gEZMRWdYV5P23PwT0Ubi8MNEwMemumpwucsM/092EuuNg/
         UWYSMpQArUQis3lkSJwCcf8NY8zAwQCTQxkp9n2RIYulM3djO/5ViE4BAolPTvgKwm3C
         pCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401707; x=1752006507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JscTfN7ikrissEGt+Aa9Ud0tScmNTsCJffKRDUXdzMQ=;
        b=qHN3oMZFfWhHe7JoeAd/M+tspw3W2DaODANpuLNHrNKjsHjO29rvNPQSsNyyFZZGrG
         wXHiK46tAo3qwt2B6SZad57mHzjJn6SQ5OtDgTUU7fY+UX9Bl/a6VNiABi3pI2b2Ju1y
         rQhmFYliMq/TQbxk/gIm8x6AEUyi2qNze3JH+jCC58+GqBsbrke9uBMh3goUjsRNJtxx
         anY1187vcIC1lvYp4WEf/vIU90Lnxz/+gOv0oErI+OncFQrW90EQd9vClvwet1Kh+UtE
         4Vrs2MtQHvq3hqNc0dX6E95xa5tHYdsUWWykPHUO4GOUR/NERTYV6/9v5np/gHM5VGtA
         Gimg==
X-Forwarded-Encrypted: i=1; AJvYcCXuzy107bb86K3j9001+daq1IvKkh6My5LCuNPb9vUDdP4FCjpjzMtEQQkV46QhlP/VaTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3f9c5wyANW0wAHx2WfD8AivYKuZUQefuvuzKUM0ZnFku5i6h
	7t2co2dVUGsaga4dUkTkCZ6buMMFjDnwYfGuMRjEqs9AntkhUTI8BNdxnKGYK1NJVgkyNbHaC+m
	MWXBvLFh6ofjCgyikDN8EVViS/sovEmk=
X-Gm-Gg: ASbGncvcDH2zqccc8nT0CxiZdF3qkJoXO3JKLEqPUUoYyLeDcGer27THXQsP7GteWnj
	Clji7kFf7N9tUcEOQCjpdkUmlIuE1Ry2k28sqcSL3cfpCWkLohN6cnUBIOXWn49psF5ObR6gOYY
	qMXR5naifKvW50/w1zIUYrP27K567s2hcXr/arWF54GCVEhMSm07c0OMTlxt0=
X-Google-Smtp-Source: AGHT+IExRj89A9KJkge0tab/2kxazj5RT2fE+SjriFHH1cmGd9XBhEAsyum85z514NKPNfmY/H4Sl4yXE6lnIUbvz2s=
X-Received: by 2002:a05:6300:6199:b0:1f5:8678:1820 with SMTP id
 adf61e73a8af0-222d7de5001mr758618637.12.1751401707148; Tue, 01 Jul 2025
 13:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630133524.364236-1-vmalik@redhat.com> <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com> <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
In-Reply-To: <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:28:12 -0700
X-Gm-Features: Ac12FXyZHFEHmc7Pdn3a5FLycq3msFcjBxEmRDLrAAjihFEKBwMrpBF2OEUIuwo
Message-ID: <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 1, 2025 at 12:43=E2=80=AFPM Viktor Malik <vmalik@redhat.com> =
wrote:
> >
> > On 7/1/25 19:46, Alexei Starovoitov wrote:
> > > On Mon, Jun 30, 2025 at 6:35=E2=80=AFAM Viktor Malik <vmalik@redhat.c=
om> wrote:
> > >>
> > >> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=
=3Dn.
> > >> The reason is that qdisc-related kfuncs are included via vmlinux.h b=
ut
> > >> when qdisc is disabled, they are not defined and do not appear in
> > >> vmlinux.h.
> > >
> > > Yes and that's expected behavior. It's not a bug.
> > > That's why we have CONFIG_NET_SCH_BPF=3Dy in
> > > selftests/bpf/config
> > > and CI picks it up automatically.
> > >
> > > If we add these kfuncs to bpf_qdisc_common.h where would we
> > > draw the line when the kfuncs should be added or not ?
> >
> > I'd say that we should add kfuncs which are only included in vmlinux.h
> > under certain configurations. Obviously stuff like CONFIG_BPF=3Dy can b=
e
> > presumed but there're tons of configs options which may be disabled on =
a
> > system and it still makes sense to compile and run at least a part of
> > test_progs on them.
> >
> > > Currently we don't add any new kfuncs, since they all
> > > should be in vmlinux.h
> >
> > This way, we're preventing people to build and therefore run *any*
> > test_progs on systems which do not have all the configs required in
> > selftests/bpf/config. Running selftests on such systems may reveal bugs
> > not captured by the CI so I think that it may be eventually beneficial
> > for everyone.
>
> Not quite. What's stopping people to build selftests
> with 'make -k' ?
> Some bpf progs will not compile, but test_progs binary will be built and
> it will run the rest of the tests.
>
> We can take this patch, but let's define the rules for adding
> kfuncs explicitly.

Note, we have a VMLINUX_H argument that can be passed into BPF
selftests' makefile. We used to use this for libbpf CI to build latest
selftests against (very) old kernels, and it worked well.

I don't think we need to make exceptions for a few kfuncs, all it
takes is to have vmlinux.h generated from kernel image built from
proper configuration.

Also note, that "proper configuration" only applies to *built* kernel,
not the actually running host kernel. See how VMLINUX_BTF_PATHS is
defined and handled: host kernel is the last thing we use for
vmlinux.h generation, only if all other options are unavailable.

> What are you proposing exactly ?
> Anything that is gated by some CONFIG_FOO _must_ be added explicitly ?
> Assuming we won't be going back and retroactively adding them ?

