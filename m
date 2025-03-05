Return-Path: <bpf+bounces-53276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC89A4F47C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCDA16D66A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665D155743;
	Wed,  5 Mar 2025 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HvgnQkLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669214D28C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140891; cv=none; b=umkh4xa41sXzT8AGkD/4j6lBD9W57NJLxgyY1c8BpBBpZpHyUdiArVIfF7fGRkNZJKJ1awbSkltBEQrH7YycKe0mJrb1mF4OtiRFtb6byaWfv0+OIIUCpmNdJsm4+llt0tOnK06k7uaiVCiLGDi5KD+icPql2uFeKqitgCnv+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140891; c=relaxed/simple;
	bh=qQ7kaU1aXWa368p5QkZafRlvPh4Fd0DUTFztungHHGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMRyt6GTDgSQRoxzu1Ax7TxkWDPw1WPouj4JXHLH4ZiAY9qmBhVRABtXkV0nz1U0MiILTFujgZY4xgn/SUwvMtlRY+RtBmGlfjfVv/9Fucpno+KjbjXmgjwaqExUO9TwDBv0KNh+rkemoZHidblWVvP/I9HZbFlDeuaWsrboSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HvgnQkLF; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53c9035003so4817401276.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741140889; x=1741745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=HvgnQkLFwLcFLN4ZPi2E9d9WKKyDc6LC+vLKHcTJjkm4MgWYNtfSRnmZvkZ+ONpDog
         zSI6yu69Lul/YwLMxM82+pJ9XhQnJsbzF29fGYrTvf78PCci05yYK5z3rczvgGFtC1AP
         XJTbPZXmlOMgHxvRXsUlEyXZlCWlSG4yX0d94YypbUjbJUNsorCJnIPR/XQWrOdvuIZ5
         eufCuoFmoepsQGlDuHfAcARmPP+r2OIqiQQBbrzPj1JKmk1skk9Bl/YVsnU5Pa8TwsWu
         5G5N/rDRqNe9Hz15dFNo4GobJjW1vuiy4Ij94xzOJv+iMNWx78QRt9jdtjmHbNyEjIGH
         aRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140889; x=1741745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=qb3mpeUse6I8QmzlUpkNsD2HPS5ryiQpKx8rwuntCtYPKlJ/aIo+mfcmAw0Yb2N4t7
         ywaiU1UL2voxvRbfmb7p88dyImOxWuUed3bNJhrrUMZFI+SznVMUrWuBo01hZqkIDusY
         T+XEKT5aBM7PF/BSxRyu9dLgGsPldEeeHaOfo3eJTj7GWpjDJK0LBisX7dp02StyWwL/
         70rG5C+FQKWHr0yHg1ZEeFuaGJd6tZ4p4Gf6yVSQpHB6weZNWJLlgofAljxc1PQ6ev9t
         C9Sd+gxdYZi4jpyEK416SHpSuzv7HhUX2I/sXCwvrYAwFE1cy2qtwdDa7HdYUPWwevSF
         BL+w==
X-Forwarded-Encrypted: i=1; AJvYcCUrLi3eTM0ft+o+iMG7hXiwFtxi1j2tHYCTEswUpnlRnLuSKKt3jEwUDnm+aMrcZCTmfm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj6BArYjCVWroaQG8uz04+rRGg8oLCOy3ltBcxI441Z6Z1Bkx
	w+VH1kgkXmtP4l+/Gg+lVBKx8xtW45ch9UqIsOTufNn+ouKznQGyunFV0oEVMpiN5nc66k6I0Lv
	5fMu3GnbicYrpKt8ZNt4LAH4/NPLPUEdCmFle
X-Gm-Gg: ASbGncuRscjY0K3LD4+baBGrVzBVcYryXay3ADS0tDjR/p864O1in/H61ROruhRqXsv
	RqHikDTKd0qkqktDRc2Xe1LyaudRmWr7xDIdmRj01sRgH0UtCwPd8TkvQsBSegFyiytDe7TqrqQ
	ATqtWKU0naF2Br5fmHC+IpbSIlNg==
X-Google-Smtp-Source: AGHT+IFJme71+h5rqacVhXNFVVflQX6fN8c82oiacs7z+wy8sz5kKm1uZj7SdqykCNgwPKPqL++9yJVZA6PUA9xV/X8=
X-Received: by 2002:a05:6902:120b:b0:e60:93c5:9b1f with SMTP id
 3f1490d57ef6-e611e19a06fmr1861920276.6.1741140889157; Tue, 04 Mar 2025
 18:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com>
In-Reply-To: <877c54jmjl.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 21:14:38 -0500
X-Gm-Features: AQ5f1JphmYgOBnsZGxupPq2rhiEO06B4bjDitVWyy9PS-JrQ5h-eCAMlWkvCD6Y
Message-ID: <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> The security_bpf LSM hook now contains a boolean parameter specifying
> >> whether an invocation of the bpf syscall originated from within the
> >> kernel. Here, we update the function signature of relevant test
> >> programs to include that new parameter.
> >>
> >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> >> ---
> >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
> >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++--=
-
> >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> >>  7 files changed, 11 insertions(+), 10 deletions(-)
> >
> > I see that Song requested that the changes in this patch be split out
> > back in the v3 revision, will that cause git bisect issues if patch
> > 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> > ensures that the selftests will still run properly?
> >
>
> So there isn't any type checking in the bpf program's function
> arguments against the LSM hook definitions, so it shouldn't cause any
> build issues. To the best of my knowledge, the new is_kernel boolean
> flag will end up living in r3. None of the current tests reference
> that parameter, so if we bisected and ended up on the previous commit,
> the bpf test programs would in a worst-case scenario simply clobber that
> register, which shouldn't effect any test outcomes unless a test program
> was somehow dependent on an uninitialized value in a scratch register.

Esh.  With that in mind, I'd argue that the two patches really should
just be one patch as you did before.  The patches are both pretty
small and obviously related so it really shouldn't be an issue.

However, since we need this patchset in order to properly implement
BPF signature verification I'm not going to make a fuss if Song feels
strongly that the selftest changes should be split into their own
patch.

--=20
paul-moore.com

