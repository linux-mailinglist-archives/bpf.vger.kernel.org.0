Return-Path: <bpf+bounces-66132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C3B2E90F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD57BB563
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07D2E1C7A;
	Wed, 20 Aug 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpKC7u12"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC021D3EC
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734176; cv=none; b=kllt53C9J2vWXIkVsbbEMcR/ak74cP7SIs9aQwZP3C4nWnS8eLvxGqpZBEBOXHDvOdjuHZznR5YryGKDQmbAjVQx+ESvvtLuUKJblUFYvFtoEv/g82gacYnR+U6EVGJ+ZHiy62q/uEeo5oj8eIDJVKPM4GXXFiZYQKcXoukny6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734176; c=relaxed/simple;
	bh=z+AOkpF/yO6AtuBejxpf/9uQGEK+mqZlahXWOFtOEnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQtqAtdYmG+gKTkiEwmr1RdJHCxTp+zRFS6XmnK6vS2UbxbJV+ClI4zfr0gkl4qoOq4wLQOHUgeVf13KqKV0sqPhMu6S5Wa/urctWHmL0LR+Bd2XkuMii5z5KydJ4QA+zmqONKiNPJqjoGP8On0EuB/SpjGwM5ezhOc0bfb7OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpKC7u12; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b29b715106so87921cf.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755734173; x=1756338973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWLf9Ffl8Lgjnm4H3/4VJgmHdaGpuVsmKnK8xjeBnZY=;
        b=mpKC7u125pzwdyiUD64PzDO7vCSaX5SxR4l0d4NZy7pMpbhi/UB7bX8tC5z05xYWEv
         wOYeACcSxFOqbrIuruv4rfyV8gonf/HQCgkvg3nXrnCHDpuLv36Al8uYzdHqkf4PKAmo
         pt0zYKdFWuCa3RPY9k8tPDelEb3PUHnfSlpcyRDdhR1Z/tWDFgj+sT1p/Ml+d5NEOp+m
         HPRF6Nv7/fhD7CMsAY++kf/6C5DW0ohpK2TcN7dq3/1WTucuG4W1Baw0CjGUNS+zt+h4
         Lxo7oc0iv1wQHuNah+wB1UChl5ocT81kXv5ICrz3C5AlHYn+DOPSnyANmFN8UdAnduM2
         QDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734173; x=1756338973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWLf9Ffl8Lgjnm4H3/4VJgmHdaGpuVsmKnK8xjeBnZY=;
        b=YECWPFj9amHfw3OuEu60BCEr00m2qxp5RV+loPwDUmmFDVrbSLhgYIANsCPw0VNZAX
         BPKNoODkUiOLSY40Wic33paDVov6znQ8G7NkKbu4zmDSHLgFXCWsiXL6VDI4oR2dqYX4
         9YDr9hzIDCi3JvO7JNlsVWYU9Tb9Ij0OlNwo8VhRDBofnV1TV2fH2jxQ3UIEih7Vjvbd
         Rr3wwi8fHJmDaeA3ajUQaAkQq9yh4l9Nzo5Af1jTD1jGdaB0kFvM9r4AJxbtNtBF7aD9
         Q5EXOA8R5R3MVAcnmBAzNiP5f0xt6ah6FgtgIiz4U+O2fKd9oZOGAMtCPLn73oXW9O+l
         k5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGrfr0BGQMJNpOSz9Wf38R8cLXeD6C4nM0xK6Aw1xsIF/j6vS640PqkNr+XKo9V14J5dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+C9kjN9SYBzzQetjZIwoWzxXrSGmDHcc3n48xxztcPtLp/Kl
	4lcgMaeB1akd1fA8R7rX6iYgM11qIbjsenxvdCxpjNqT7kodPHTEQAJDU8h7LtqSC2hFRUOV9hq
	vLCcnw8agedeVF/nPGgU5H2jnrf12hT77A91qU+cZ
X-Gm-Gg: ASbGnct2jCXcewUym5Lg1yZ89yfGSL5zy9cS2xiXkwhhjdEBofuF6ALXikNcIjrlJFx
	vfuo1Tg2EhZ2aGoZrRnzi7D/vTmo9nl7lbNMRbhBTx/RIXBQFLKAaJhJI06rOYQsY3pQVwQ8b5v
	mSuw3IGrUqP68NX2YZ7XCN/GP/4AsNTgbO1f+7maGAi8S8Y1vrkubtgMlEM58AAjZmHgR8WeyJn
	VwwMFtfW5tIQ/8IMYgEpwc=
X-Google-Smtp-Source: AGHT+IErfm7yT7BCKqe17sShglHdYpqJIMTG3Y4aNX1t1u/ZKhg8vLO6UDcBNhy14F6ojhVjQYxhN/ouE9gCg8dt1rk=
X-Received: by 2002:a05:622a:594:b0:4a6:f577:19bc with SMTP id
 d75a77b69052e-4b29f797447mr1131141cf.18.1755734172886; Wed, 20 Aug 2025
 16:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-13-roman.gushchin@linux.dev> <CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
 <87tt23vt8u.fsf@linux.dev> <87cy8qx50g.fsf@linux.dev>
In-Reply-To: <87cy8qx50g.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Aug 2025 16:56:01 -0700
X-Gm-Features: Ac12FXwHFX4DgL6ZNVWka_tcMoj1Wu2SMzrvjJmRsLac3uNbaTN5z0M9dFMR-KA
Message-ID: <CAJuCfpGGAEh0pnbp8jA+0LgdT5k5qtGthJQopHZz9vzXZ8KQ1w@mail.gmail.com>
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling using bpf
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:31=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Roman Gushchin <roman.gushchin@linux.dev> writes:
>
> > Suren Baghdasaryan <surenb@google.com> writes:
> >
> >> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> >> <roman.gushchin@linux.dev> wrote:
> >
> >>
> >>> +
> >>> +       /* Cgroup Id */
> >>> +       u64 cgroup_id;
> >>
> >> This cgroup_id field is weird. It's not initialized and not used here,
> >> then it gets initialized in the next patch and used in the last patch
> >> from a selftest. This is quite confusing. Also logically I don't think
> >> a cgroup attribute really belongs to psi_trigger... Can we at least
> >> move it into bpf_psi where it might fit a bit better?
> >
> > I can't move it to bpf_psi, because a single bpf_psi might own multiple
> > triggers with different cgroup_id's.
> > For sure I can move it to the next patch, if it's preferred.
> >
> > If you really don't like it here, other option is to replace it with
> > a new bpf helper (kfunc) which calculates the cgroup_id by walking the
> > trigger->group->cgroup->cgroup_id path each time.
>
> Actually there is no easy path from psi_group to cgroup, so there is
> no such option available, unfortunately. Or we need a back-link from
> the psi_group to cgroup.

Ok, I obviously missed some important relations between these
structures. Let me digest it some more before commenting further.

