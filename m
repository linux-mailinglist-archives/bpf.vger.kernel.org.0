Return-Path: <bpf+bounces-39802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABF9777E0
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 06:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D73284F44
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A21D4168;
	Fri, 13 Sep 2024 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUZVsg0E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B713A87C;
	Fri, 13 Sep 2024 04:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201605; cv=none; b=DOSw36UWR/t6/TDpLDXFFZvauH6HQFOZWPgwLfXPnG1DpjNvaCEi4iCxyjzqddTj1rmmtWJ9J/GY3Ab6FYvA3R2r3w95+H61agbSKJh1ISmNQ5yE8FKs3TOZYmtA4Y0NYlSnWx73/NRZxy637fSFWb5Lu7gu/Zi+ROMwRuPalO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201605; c=relaxed/simple;
	bh=s8y2LxutHw1JNq+rOeyZekzVclfC3r0yw8vj7dA/mZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6W4QsiTD/U+xGUnKSUzxeJx9KMRl6VeB2gTSJRObeqmy/XOS5WBBiV/n57r+CiNDHX1Op+a7eADYtG8O/cOSnDfAvTUvUYLo0vGqoo3bp4r6To4aaIN11EEsigYV5+zTUFjzuxxDSPxTwyyTT4F3x5LyNTFi4nJBDmfN3dmEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUZVsg0E; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1408611a12.2;
        Thu, 12 Sep 2024 21:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726201603; x=1726806403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UCSDqZtrxdlfDIyJ4PYB/eyUMcd92kaOx6CvjF7g6Q=;
        b=mUZVsg0EwYhnVfcoijV8d9hLFYJTm/+8ieqhD8mY4cu9DKfZ7O1zmUJxrIvFSDWfmJ
         78HtAIZKakLdpJKsqn/AXodpdTMKlMBP7w5oIUsbctitPlJKNRtXYbD8xxN/vSV8RZtw
         94dKUeHFWLCMNgKJ22DrYMwffXoRiVwMb5TuWbITQfJY3UYlrMVCUcNq7VoE8ZljFNkw
         jqr8q8H/sxEZRLmCsVigS+zcef5WKMX2ixapRaL7CkklMAg1mBX1zcAk+kJUhjIQYUa2
         kieuW5cTv5pmHzD+eTsqTvWLDAoHVpX6/sucafaXiyNaRhkYrMp4tix4coSp8K4HgXfR
         0dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726201603; x=1726806403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UCSDqZtrxdlfDIyJ4PYB/eyUMcd92kaOx6CvjF7g6Q=;
        b=HwnYjJeTBrqfpBiVZLVoBt5NcsDqVLDQ89SWf/XO33Ra+GbHE3+ZXX3fENSbhR3TaW
         FL6v3dlAoOi/MhRZsB0L+YWaQkUjbljRzs+EAQ0pOxFXrqrVs4HsSJpOBoVrppGyTEoC
         L9RPQmrRkUmKiISNIohSfcx5SUYbpAGt3hP0gEsLsNOBKasUCsawsAsdXeu43GAlIqAb
         yAcUBzOTvJKle/+jGuMYnN2eHBxFU8m/tSv0N9H3nKKv8W+FMVu60Vcx83zGTyFu0hlQ
         PvlNGRzDckfi+j6uSiDH/xKQrJQmC3Q0FsQ8TSSynCek4l/Re9Ob48awt8NQoT80QOX/
         GUgA==
X-Forwarded-Encrypted: i=1; AJvYcCUgPhdvogtUSAJmXILqSBNzubfNx8IMvJyBrY0zjjLuBpYMUjO0uOtD5gX1kQqEEXD0/R8=@vger.kernel.org, AJvYcCVcLOeFLil3lCgEfpOgz2pZRJWJU0KuFinG+LK4833749h2KeGODKsLZt6YdkAcUO6emVAYVJS+WxypTgeU@vger.kernel.org, AJvYcCVqH7cMQuSTe2b5AmNEuq9H71F59DMKplE39K+nkN9Epim3KUvXFf/O8d6scCENpWU9QdCn7b/sg2rPSQ==@vger.kernel.org, AJvYcCWEsWbMseyzJaS01AfkjutTTTdmk6I4mx3aGyHGe4o/Rmtil0ja109lLd4nRZ6NcI1jFmZs0n1U+Re+@vger.kernel.org, AJvYcCXI1yOdfxOSvTVJZ5er3GQmG7ty+q1edADSOAiTaixX1FoUoaD+PIeLM2NJg4CEJCVlQ//LeiEM@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEP5Uw8tuF5SegdBl6E/OZz3byKAXN5giljnW2wfco3VEGMk1
	OA75ZrwXnnbV+IY7i5E2J6DhPmveBjTIIfwD4ULmT4am5/G2e6DeXNaclPYvRxa7oAb5qYe9tzo
	iM/fKQz5Pk6hh5uaMH+4d1NChMIo=
X-Google-Smtp-Source: AGHT+IHwOdOFteLST4od4RwYt9rmDfY2JPAQXl9/wd1FLajiqtRgjBhS0MTgoNifm/7YfojeHqx1nMXkbHKudo7SzyM=
X-Received: by 2002:a17:90a:9384:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2dba0067fa7mr5810882a91.30.1726201603388; Thu, 12 Sep 2024
 21:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913135551.4156251c@canb.auug.org.au> <20240913040038.GA2825852@ZenIV>
In-Reply-To: <20240913040038.GA2825852@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 21:26:31 -0700
Message-ID: <CAEf4BzashWCozzD7KetgC0Wya-KqUzj0omguAOt+oUVDzHys=Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Chinner <david@fromorbit.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Sep 13, 2024 at 01:55:51PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > fs/xfs/xfs_exchrange.c: In function 'xfs_ioc_commit_range':
> > fs/xfs/xfs_exchrange.c:938:19: error: 'struct fd' has no member named '=
file'
> >   938 |         if (!file1.file)
> >       |                   ^
> > fs/xfs/xfs_exchrange.c:940:26: error: 'struct fd' has no member named '=
file'
> >   940 |         fxr.file1 =3D file1.file;
> >       |                          ^
> >
> > Caused by commit
> >
> >   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
> >
> > interacting with commit
> >
> >   398597c3ef7f ("xfs: introduce new file range commit ioctls")
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Fri, 13 Sep 2024 13:53:35 +1000
> > Subject: [PATCH] fix up 3 for "introduce fd_file(), convert all accesso=
rs to
> >  it."
> >
> > interacting with commit "xfs: introduce new file range commit ioctls"
> > from the xfs tree.
>
> ... and the same for io_uring/rsrc.c, conflict with "io_uring: add IORING=
_REGISTER_COPY_BUFFERS method".
>
> FWIW, that (sub)series is in viro/vfs.git#for-next - I forgot to put it
> there, so when bpf tree reorgs had lost their branch on top of that thing=
,
> the conflict fixes got dropped from -next.  Sorry... ;-/

Should I take out the following from bpf-next/for-next for now?

a8e40fd0f127 ("Merge branch 'bpf-next/struct_fd' into for-next")

Al, currently I'm basing my patches on top of your stable-struct_fd
branch. If you need to update it, I think that's fine, I can rebase on
top of the updated branch, given my patches weren't yet merged
anywhere. Let me know.

