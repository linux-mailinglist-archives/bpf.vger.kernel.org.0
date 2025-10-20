Return-Path: <bpf+bounces-71442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51591BF3582
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBE15350E48
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFF2D6400;
	Mon, 20 Oct 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF3yDw5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9A2D47E0
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991153; cv=none; b=DYotoocDTpmRFPSNfXtfv/2xKACNzj6IeXdw2YNbNITJNbfUydG/JP//gaxK8JkNJBPmLiinPZ06Ns0AuuIusllnleWC12rSBM2RHWBtkpxV7djK66zNDUfH5dq/onAIl2Ub6s/Nv+ruRauesN9MqzzOMIaqei5V+5sUv6rM/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991153; c=relaxed/simple;
	bh=XDW8E1K3bkQ9i4Kqx7G5/637yEd2blJb+FQsNxfJ8dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z54aFXNnBE0uEEgg6dp2D1yWQ1oZAeVkeTeWhQoWuoEU0MrhksDVmpWGfijCTarVJ+XnVa/4suSpjZajsLIOVp+PHRQa56TCQ28UKObxjwb42TDhKTHnJFJPThoDMXmKl6SgpjNkeE0gbDrlvuPHsyx0aAW7dg5iDGsyqTi7m3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF3yDw5m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3487186b3a.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991151; x=1761595951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtJl8gwJ8fJtUB7up03kcnGklNDXDEpKtP8NLBXeBeI=;
        b=OF3yDw5mM1Azc3YVlHqYaTLvCfwHmzoYsbTzBSIqM9mGP4USBWVD1FIkrFqJoOu6Ra
         oiR7gyrEYLAlFeWL/2zAv/QNXNYUprZexOTGli2gYaOUOnys542HBbq6xAm6DwWBtKdG
         miGEe/P8cW7OquDTUol7WuQm5HEc4kziekCY3Kn1J5WcoUsEn0GgYFAmS0GkY4t5MS9e
         EcYtHH9LT/6lWLEx+O8+2u/h5rhrEXKJ0YarPnLRVwqpZrEHEHasEq6mOZIrSVW9j3G4
         soXxP2moUs61hbshFQMMPhy6y9EKtBxkAgrHTq0pO9DtHxlzoMGsgqROhdomyXay/uih
         FHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991151; x=1761595951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtJl8gwJ8fJtUB7up03kcnGklNDXDEpKtP8NLBXeBeI=;
        b=qyTcc0OKSc4x+iXin6asKrcbVZ6rQmShZb/dcrj1U8gOd0LhF5MtT/Hy3D5tmvUPEK
         7XlVdPXr9+QXDLJ5bakhf8Zi7hWiz/Nm9+x1E0veAdEz1IWlp9A/hpPPgebzBJ3JXfhv
         R8acedqmabQq8FEeYyteLFfM3y6snXecOHg9heg9Ft5xYE+GiUoh9A1fbIzjaYHv9Ld5
         trIDriFzxlDFUmXDrXvvQiSP+NWA0WKsBYz0xr65BPrMjqolLIWsuJwsTnVXhdEmibUB
         xXD449t2GYyHkFjNZphCW+0Wb+3oKAULzI+rxezYrddlFFnO7yxgPop6lHw9IzPhDrj4
         90DA==
X-Forwarded-Encrypted: i=1; AJvYcCXBrgbThtI9ZJg3JMzLWBIMY9xNe/FYYkpxvjX8uiaAN1D3AqlHahMfDokXJRG8JLqunU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYHRRiC7uCVxlF9UOpiYicvov4h92mhkAgCOtj74UkDoisubY
	MV4IGV4ZkYg6YHxPoNBbMAo8Dxvb0P+9/ipIGqHK1iEGukRCeRICFPu8EreJMd6s2a3R7rw6fOe
	Q/JDq2nIwNGPlBNLgIETJCVnlhS6AWNM=
X-Gm-Gg: ASbGncvmAibQhH4xkk0NFT2iinW8G6XEBKxHU6g7NZaf5jVUjFJeNaPie7O9clClh6S
	4HmFsVvb6LG609JgVDVmM+dc1qSVUq07jSG1RQGIPV3CUNRgqKhGXI59aZRZdIVahqY4JULMA//
	EeC0tm7dS3YMMP4t7Z9f2KvLGnm3Owxl08wZ/KiYIFA/pnEwksI6L7W+ERl9PqVSgAMRFzxBOjU
	shvAeCzixdBmARdECeVHYiUhmzaloIbQ8a1qyqV+E9mbjB5c+hxIvf9EsquPlhhLjiLE8p2zarG
	8qNXUUR9nig=
X-Google-Smtp-Source: AGHT+IFzr63scrASjGpXgPHvF1iqfssnD2ptyGNMsO9gT08qsXSIRnbt8kE6ZV+uKwVDPzXJQKWadxwBnTHGnSrz99s=
X-Received: by 2002:a17:902:e78b:b0:288:e46d:b325 with SMTP id
 d9443c01a7336-290caf858bcmr172651785ad.43.1760991150823; Mon, 20 Oct 2025
 13:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
 <20251020085918.1604034-1-higuoxing@gmail.com> <CAADnVQLDQpNEa0bT6nyX3UfGTE94YxrM4gPD+PirmqHwXRB15Q@mail.gmail.com>
In-Reply-To: <CAADnVQLDQpNEa0bT6nyX3UfGTE94YxrM4gPD+PirmqHwXRB15Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 13:12:16 -0700
X-Gm-Features: AS18NWAes5P_XPnKYSlRrr7vtNNOsfz7WT3J-c3JQinfMqjOVU5S3FZqCyldy_k
Message-ID: <CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com>
Subject: Re: strace log before the fix, with fsync fix and with fclose fix.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xing Guo <higuoxing@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+linux-fsdevel

On Mon, Oct 20, 2025 at 9:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 20, 2025 at 1:59=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wr=
ote:
> >
> > Test with fsync:
>
> I doubt people will be reading this giant log.
> Please bisect it instead.
> Since it's not reproducible when /tmp is backed by tmpfs
> it's probably some change in vfs or in the file system that
> your laptop is using for /tmp.
> It changes a user visible behavior of the file system and
> needs to be investigated, since it may affect more code than
> just this selftest.

dmesg output was certainly too much, but I filtered all that out. Here
are relevant pieces of strace log.

BEFORE (FAILING)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.Pf280c",
O_RDWR|O_CREAT|O_EXCL, 0600) =3D 4
fcntl(4, F_GETFL)                       =3D 0x8002 (flags O_RDWR|O_LARGEFIL=
E)
fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
write(4, "# comment\n  test_with_spaces    "..., 175) =3D 175
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.Pf280c", O_RDONLY) =3D 5
fstat(5, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
read(5, "", 8192)                       =3D 0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -- THIS IS BAD, NO CONTENTS
close(5)                                =3D 0
close(4)                                =3D 0
unlink("/tmp/bpf_arg_parsing_test.Pf280c") =3D 0

WITH SYNC
=3D=3D=3D=3D=3D=3D=3D=3D=3D
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.UK5nUq",
O_RDWR|O_CREAT|O_EXCL, 0600) =3D 4
fcntl(4, F_GETFL)                       =3D 0x8002 (flags O_RDWR|O_LARGEFIL=
E)
fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
write(4, "# comment\n  test_with_spaces    "..., 175) =3D 175
fsync(4)                                =3D 0
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.UK5nUq", O_RDONLY) =3D 5
fstat(5, {st_mode=3DS_IFREG|0600, st_size=3D175, ...}) =3D 0
read(5, "# comment\n  test_with_spaces    "..., 8192) =3D 175
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -- GOOD,
because fsync(4) before second openat()
read(5, "", 8192)                       =3D 0
close(5)                                =3D 0
close(4)                                =3D 0
unlink("/tmp/bpf_arg_parsing_test.UK5nUq") =3D 0

WITH CLOSE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.WavYEa",
O_RDWR|O_CREAT|O_EXCL, 0600) =3D 4
fcntl(4, F_GETFL)                       =3D 0x8002 (flags O_RDWR|O_LARGEFIL=
E)
fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
write(4, "# comment\n  test_with_spaces    "..., 175) =3D 175
close(4)                                =3D 0
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.WavYEa", O_RDONLY) =3D 4
fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D175, ...}) =3D 0
read(4, "# comment\n  test_with_spaces    "..., 8192) =3D 175
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -- GOOD,
because close(4) before second openat()
read(4, "", 8192)                       =3D 0
close(4)                                =3D 0
unlink("/tmp/bpf_arg_parsing_test.WavYEa") =3D 0


So as can be seen above, kernel does see the write(4, <175 bytes of
content>) in all cases (so libc's fflush(fp) works as expected), but
without either fsync(4) or close(4), kernel won't return those 175
bytes if we open() same file (returning FD 5 this time).

Is that a reasonable behavior of the kernel? I don't know, it would be
good for FS folks to double check/confirm. The complication here is
that we have two FDs open against the same underlying file (so my
assumption is that kernel should share underlying page cache data),
and documentation I've found isn't particularly clear on guarantees in
that case.

write()'s man page states:

  > POSIX requires that a read(2) which can be proved to occur after a
write() has returned returns the new data. Note that not all file
systems are POSIX conforming.

(but this doesn't clarify if all this is applied only within the same *FD*)

POSIX itself says:

  > Writes can be serialized with respect to other reads and writes.
If a read() of file data can be proven (by any means) to occur after a
write() of the data, it must reflect that write(), even if the calls
are made by different processes. A similar requirement applies to
multiple write operations to the same file position. This is needed to
guarantee the propagation of data from write() calls to subsequent
read() calls. This requirement is particularly significant for
networked file systems, where some caching schemes violate these
semantics.

But again, no mention of multiple FDs opened against the same underlying fi=
le.

So unclear, which is why it would be nice for FS folks to double
check. It's certainly a change in behavior, it used to work reliably
before. [0] is the source code of the test (and note that we now added
fsync(), without it the test is now broken).

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/prog_tests/arg_parsing.c

