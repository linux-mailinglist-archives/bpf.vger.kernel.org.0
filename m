Return-Path: <bpf+bounces-65561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9BB255AF
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9243AE474
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2603009D6;
	Wed, 13 Aug 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkMt/4Eu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98623009C8
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121051; cv=none; b=ez/CHFaQQbAMnatWfBEv47Pl7lUTY3CoXFw2yzby11H8YP5loDbdi60tUQNJmvuyBxmsTCFgF5KJwCVV2OonNzQ4ZHHHmaVoMLX6UmyLV7dg25gpJhGLi8frqNTje9kN8lbVD1saQyLiycHuRYmJs2HY4eTuCfh4lSOTczZTMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121051; c=relaxed/simple;
	bh=wOqJs2Uu5zNGB3bRDeNVkkDh9Rlkyh9x0BYbzqutDNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwngAokDLhq2C+MpgNq5fJmjlMTuH+79y6PYk0RJ3cboqLRDRIUudLcMigFHzS1fVzX7ZOVUiqeQVBhKuSxLls+cA1NvuDEEDv34jebBcvD3tR6h5waDPh3UsxafFQ0Ln2Kq/5V04NAmoC5R8GrwG+Mo/P0ppuPP2Lwh4UrggYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkMt/4Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F1C4CEEB
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121051;
	bh=wOqJs2Uu5zNGB3bRDeNVkkDh9Rlkyh9x0BYbzqutDNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PkMt/4EuEwEBCnTgwRocX5dUy6/SYTV39xW5syFEalUOhA9f19a4ZisVXGK+Q9pJW
	 vnhyxK9QhpIYLAxOF8zTUoizTqq1b8zPNKlI+1krS9SzgPY1IgakbLw7AcujlF7R97
	 +ua/A27OQG6Q/HKmEiD7JYsd/mpjAkMoiZ81krd8y2q1uR1c59Y3ok6jcC5Uf7eyHL
	 9E1gpyExX2o6fzgp5z3FPlbVdtm//3sv18joW24kfqtLOcEr8ZiFHb8dyBQWldS1uu
	 tAfrlPBNPA7CDb3K2MJjofe8KD0i0yhgkptB8YKVd5hrrzgLiJGvWwbJRvIPIoAJff
	 n1kUZKMR/lqBQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b7400e6so410901a12.3
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:37:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoIUuFhVefxLCWyMGDywyG5+AzOU4f7T7g+2gwjLRXZj6KnrK7
	YQrFjfAXKoANrI+DK6g9MbVTz4r9tHUwLJaz8un7Cl2dqHM01jLddYn4L0HaWlhz4c5v9QSugmV
	TU1QDEftDegniQTeDIUcwbFGJfMP4FG3whC6VHvBP
X-Google-Smtp-Source: AGHT+IG8CEI49aDyPYWGAG2tpACx3rNoZuWtbbtsWv+WDx7cPuUcwffn2MpgWZt+1/g16X85iG6EjSIly2iFADoZJsU=
X-Received: by 2002:a05:6402:278e:b0:618:3bc5:88a9 with SMTP id
 4fb4d7f45d1cf-6188b9300c1mr537180a12.5.1755121050040; Wed, 13 Aug 2025
 14:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
 <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
In-Reply-To: <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 13 Aug 2025 23:37:19 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com>
X-Gm-Features: Ac12FXxK8cQ6SjWGeVMUIz2OFgfF4sxH-i03KpBxBNbwKn8ufnQhZxtrVvg2cjg
Message-ID: <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Aug 13, 2025 at 4:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > This patch extends the BPF_PROG_LOAD command by adding three new fields
> > to `union bpf_attr` in the user-space API:
> >
> >   - signature: A pointer to the signature blob.
> >   - signature_size: The size of the signature blob.
> >   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
> >     the user or session keyring) containing the trusted public keys.
> >
> > When a BPF program is loaded with a signature, the kernel:
> >
> > 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> > 2.  Verifies the supplied signature against the BPF program's
> >     instruction buffer.
> > 3.  If the signature is valid and was generated by a key in the trusted
> >     keyring, the program load proceeds.
> > 4.  If no signature is provided, the load proceeds as before, allowing
> >     for backward compatibility. LSMs can chose to restrict unsigned
> >     programs and implement a security policy.
> > 5.  If signature verification fails for any reason,
> >     the program is not loaded.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  crypto/asymmetric_keys/pkcs7_verify.c |  1 +
> >  include/linux/verification.h          |  1 +
> >  include/uapi/linux/bpf.h              | 10 +++++++
> >  kernel/bpf/helpers.c                  |  2 +-
> >  kernel/bpf/syscall.c                  | 42 ++++++++++++++++++++++++++-
> >  tools/include/uapi/linux/bpf.h        | 10 +++++++
> >  tools/lib/bpf/bpf.c                   |  2 +-
> >  7 files changed, 65 insertions(+), 3 deletions(-)
>
> It's nice to see a v3 revision, but it would be good to see some
> comments on Blaise's reply to your v2 revision.  From what I can see
> it should enable the different use cases and requirements that have
> been posted.

I will defer to Alexei and others here (mostly due to time crunch). It
would however be useful to explain the use-cases in which signed maps
are useful (beyond being a different approach than the current
delegated verification).

>
> https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.co=
m


>
> --
> paul-moore.com

