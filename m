Return-Path: <bpf+bounces-41502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A34997931
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F22284482
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A31E3DF7;
	Wed,  9 Oct 2024 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZCJGcXH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B21E3DD6;
	Wed,  9 Oct 2024 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517023; cv=none; b=EJoSFqU0TfNlBCmTzRK5bdxMTQl8vuPOe7l0a3oRJojHP73PhqP1Dx61EnFkRCmUgPLZtgWhZUOjezpSDm1+IQm5/5GyxOb9QlPmso1pypZk9zN2EgwR4fvFKRa740WePZsvBuo9T4xTu66NwlU1zNSPB/rXqfpGygCdrzj9AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517023; c=relaxed/simple;
	bh=wUG1D8/JF0SUTbWugDeCKFgHLZU5zyUNJg6GkytmOrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbm5V/rJ4e3GlAE6jxvz/Q4eoP228PCPK9jney1/SZ+pcLkzHi+GsBhSpCRIVJsz2nzx21+uI+OaqE/GkB+0nf7Ou2tK6AvDpeI556PhjtI1xXPenbnHW3RDy6cWyZL9+mkmLTkyOnrhg2XJPOWYKDlN7nGl7nsb99ApKtZklQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZCJGcXH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so2720615e9.1;
        Wed, 09 Oct 2024 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517019; x=1729121819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUG1D8/JF0SUTbWugDeCKFgHLZU5zyUNJg6GkytmOrI=;
        b=NZCJGcXH6c//taI9sHvZXJn0gXPnLjDw78cqE585NDxdSDsaC+wnle/nJUwgrKpGpp
         A8ZUMRnR5zv79JiZKZwLXx2KksE1tUySmPHj4jdcbF+0WHpS1Jun9698NEGTJtnqoNAi
         2gFedPgdacINzA5Stv8PYXp1LUb+X9Omupw01u/RgbRX/lAwygJBYbggIik+/ODHW4ru
         r003dMYxOlHtGfEci0bKMf+hQFmIdydF42NvNKIrZztC9NliUklqfVhccGnhaX6NadPU
         2Ut/nii0nKKAnYPK1NcRUb8x021HVQd/TXXFwOLXYAow+FxiqX45VyIMUCP5UCiuPLAv
         W5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517019; x=1729121819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUG1D8/JF0SUTbWugDeCKFgHLZU5zyUNJg6GkytmOrI=;
        b=bOz4ZUE3aFMwjXhFucSGXxIydIJXakWIxso5u1Ii1zxcZ7c/hUXGHaYiWhHKlzAB/X
         Mq97BCkdbzMqCqC06ZRmgXIfimIXH+BCRLEwpzG/0SPcYkKvwVt4bvCPdPEtSSI9QAvr
         s6wrXnM4Ksa5ZClqCUQfkLH0sZh0RyCXl8Ys/WD9Iir65d0RggV3dkDXH7VtmyBrpA4o
         lu7Nzx90ZXYHf5X9WoVl91V+uPlDqBlnZ6gSdDqy7jxEe/CJaCeu7nxpopW6lDpsx/WO
         XmEIIHg9fuOpaZD5PMveYPQu6eAt2poBR1D2CvXDGwIyVZI38vkRANYpUEB9ejYqFF4H
         58pg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTKmIIHdE3jIpWOLzNU5wLcPvktrCIETS28ulL5rI6qbNr6MeF1zyi+esrXcdEWa+7SE=@vger.kernel.org, AJvYcCW/NAMelrKv4rAdzXhNnB3+/tg89Ozn9sbXvIih5szfKHQgHihdFbsNCOPXIO2exXKqnFUQGZe6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zfQS2HKjmxs8BsCTBKBZkXapw43i3fujJS1ccl9kSxKg+8O0
	m269aEIrdT9XctYk7MFkfrQkoawXmOY6sqqhj28OVcoB8Kb9Bgmz18KAw2FOK1qliCNvcSRXQkg
	Xb04zTe2NP/AAoQPXaG7czMTHh1c=
X-Google-Smtp-Source: AGHT+IHqIWbZVifNDlT8DeMkyoyAF2MOb7xZrxOqjs+EkXDp+KFRBCvU+99Fq2KqCJiCcJFUtHOkqVh4DlZLORfSf/g=
X-Received: by 2002:a05:600c:3ac4:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-430d7487f4fmr36662795e9.32.1728517018355; Wed, 09 Oct 2024
 16:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com> <87bjztsp2b.fsf@toke.dk>
In-Reply-To: <87bjztsp2b.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 16:36:47 -0700
Message-ID: <CAADnVQKuw=HqtzRok5NyxMDLoe=AHQfwtBxpe9hs3G1HDRJmfA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon Sundberg <simon.sundberg@kau.se>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:39=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> The selftests build two kernel modules (bpf_testmod.ko and
> >> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
> >> bit messy, and doesn't scale so well when we add more modules, so let'=
s
> >> consolidate these rules into a single rule generated for each module
> >> name, and move the module sources into a single directory.
> >>
> >> To avoid parallel builds of the different modules stepping on each
> >> other's toes during the 'modpost' phase of the Kbuild 'make modules', =
we
> >> create a single target for all the defined modules, which contains the
> >> recursive 'make' call into the modules directory. The Makefile in the
> >> subdirectory building the modules is modified to also touch a
> >> 'modules.built' file, which we can add as a dependency on the top-leve=
l
> >> selftests Makefile, thus ensuring that the modules are always rebuilt =
if
> >> any of the dependencies in the selftests change.
> >
> > Nice cleanup, but looks unrelated to the fix and hence
> > not a bpf material.
> > Why combine them?
>
> Because the selftest adds two more kernel modules to the selftest build,
> so we'd have to add two more directories with a single module in each
> and copy-pasted Makefile rules. It seemed simpler to just refactor the
> build of the two existing modules first, after which adding the two new
> modules means just dropping two more source files into the modules
> directory.
>
> I guess we could technically do the single-directory-per-module, and
> then send this patch as a follow-up once bpf gets merged back into
> bpf-next, but it seems a bit of a hassle, TBH. WDYT?

The way it is right it's certainly not going into bpf tree.
So if you don't want to split then the whole thing is bpf-next then.

