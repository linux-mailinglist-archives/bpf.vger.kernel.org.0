Return-Path: <bpf+bounces-57168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BFCAA6641
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980294C5ED8
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B196265CDE;
	Thu,  1 May 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4o2lwDGH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943C243969
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138668; cv=none; b=rYKTtHA5xB8UEIZHybh/cb+g1DWPoA6mob+LG/WpZnLmG5Eo7YCl26AjE0xfGmHnGvsLqgBZidORlgaAR04E0O/KHgoUtLbdYrNO5X6SngjXGxNrznTvh3uNak/UOc0L5UBMQyWaKFWY4ApT5PHIcRVbkJcN+SZxUzoRsP5Cuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138668; c=relaxed/simple;
	bh=5jNJ7PmQ1iM85BfunoQWJC8Wakn+kZkigT1EU1plLbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3zc64+OrQ899v/BqPV0Iq2eL97lOG9HdrjvybaZoFW3LCLLeMp/tl/PBE9gih6PjoxxoYmrqyZfIcZqSjDn/Q4XvCWGeiEIgwei1kJLZcaYNdCVLWDhTuNk8tcUFuROCMdv2ibBVH5+YWrwhEx3V76i5LzJWM8jPEpjpOSDRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4o2lwDGH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso22925e9.0
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746138665; x=1746743465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvFaLMmnYAhkMr2ts1Qsuk8rmVsiL5MqMz1A00np0Ec=;
        b=4o2lwDGHESt8qa0XytIneMFHN6s/vQODPWKQw6mFStTcl/luAHrWAQpkzVFsh6Ay1T
         T/420YyACWf3yUtskamUNL1MGDDjvOrJuFVaGDP2qJS9vke2asQUVDdShwJ3lw20qleS
         7ExFNgYYOElg0tZSJua8FeaKvGK85izzRoRVbLBMfsKkL8vEvs9ryiTxl3TGS0Wwj3I5
         arHglnJ1zbqdaHXAnQdnJN6QWNYHye34ombteiMNvIadcc49nRSGB/C5sGDH8b8F5Apg
         zZzKSzgNvsizfdhgEBqGofIb/qMZn3i+c80eCUY8V8oOxTLAjiJHTAJRq/dKlv5tQkzI
         cv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138665; x=1746743465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvFaLMmnYAhkMr2ts1Qsuk8rmVsiL5MqMz1A00np0Ec=;
        b=VBjg5/eqAJXHenvwEuqwzmS1vBSBPLUVpr4O/Tc1cf122AvMlKzUQcAAShFcuRvI92
         BTARU115YYmOqVin82G3B1L0Pj7ri3fwjbsc48hvj4W4cV0b0ub5MHQ1OyTf7Gme7Ebq
         rwLGayUBXP6vnNXF5dM01Ia7aYVqQAsGIerySHcjL5FTfocGGUNcNiKocNTZ4aO15tyg
         VuojRYGtlIqc5EWhZ3P81m9AlYtiWJUn546zuRlN/hMebpYU2f+AezWypJudyuC76Sfh
         yeDXKhjhmfmKweRbHPtzvltNtzcc9CMjntEjBoeMDLxXtroUXxEUvbwSxuvqFeWoAfDv
         eIIg==
X-Forwarded-Encrypted: i=1; AJvYcCX38+o6L0whVd1S1Q+SjR/I7o4PRAmK8i+cpPR88vnFZAaEnPpyboy7kMSeqmg1Xjo3I0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnYAiGO7G6PMlNl+innpkyXRDtfDjV44/9QOAHEcRB9NAXp5T
	5U2V3u3gLEr7u4MYFuXxaD9pQ37UHSxY+U1YVa0NzqicSrQ49HiJg4owml4qvTNC5yXYIfqw6y4
	rxL2BG9cOq1AIt8/h1QK4vy/pHOTbrbU8CMKS
X-Gm-Gg: ASbGnctwK3MnPtqC+LHNak83A8Nkc7Cuw04Ho/xo883mb2qhrvA8gMx534yOAelSbnB
	v3xnWaEbY68Y6AH8NcqfvsQm8byEo2NcVQ9I04EwN6ta1lZKHV02MV4RKyKunPTYbIwmqSC62P5
	DLLJzrINLCasYWRC/+LlY=
X-Google-Smtp-Source: AGHT+IHZeQVSjanU+gebjmksvGiFNo+T+ZOurPfQY2zHeFq43o/7AekSmeEL8Kr/40IywT61pNTgxPJ4rqdxiNUNxZw=
X-Received: by 2002:a05:600c:3544:b0:441:aaa8:312e with SMTP id
 5b1f17b1804b1-441b6499e1cmr2235995e9.6.1746138665030; Thu, 01 May 2025
 15:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428211536.1651456-1-zhuyifei@google.com> <CAEf4BzZXpWC8nWb4zF37PpDX0Y+Bk9=vw8iL5Ehqcjr-Bw=dNQ@mail.gmail.com>
 <55e5aab0-6aa7-4b79-908a-5cbfdc7bd7cd@kernel.org>
In-Reply-To: <55e5aab0-6aa7-4b79-908a-5cbfdc7bd7cd@kernel.org>
From: YiFei Zhu <zhuyifei@google.com>
Date: Thu, 1 May 2025 15:30:53 -0700
X-Gm-Features: ATxdqUG3KM0CyJNPsFvlqNwOATY_iVJ4iA3bVbkViPwufxCqrYOhktkaOa0y1kg
Message-ID: <CAA-VZPmtxpRCB_o52vuEuGW4UeHgzc+xO+8JMA-2G04P1r3Pug@mail.gmail.com>
Subject: Re: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree"
 EINVAL on older kernels
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Kenta Tada <tadakentaso@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>, 
	Mahesh Bandewar <maheshb@google.com>, Minh-Anh Nguyen <minhanhdn@google.com>, 
	Sagarika Sharma <sharmasagarika@google.com>, XuanYao Zhang <xuanyao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 1:04=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-05-01 10:54 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Mon, Apr 28, 2025 at 2:15=E2=80=AFPM YiFei Zhu <zhuyifei@google.com>=
 wrote:
> >>
> >> If cgroup_has_attached_progs queries an attach type not supported
> >> by the running kernel, due to the kernel being older than the bpftool
> >> build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.
> >>
> >> Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
> >> attach types"), this EINVAL would be ignored by the function, allowing
> >> the function to only consider supported attach types. The commit
> >> changed so that, instead of querying all attach types, only attach
> >> types from the array `cgroup_attach_types` is queried. The assumption
> >> is that because these are only cgroup attach types, they should all
> >> be supported. Unfortunately this assumption may be false when the
> >> kernel is older than the bpftool build, where the attach types queried
> >> by bpftool is not yet implemented in the kernel. This would result in
> >> errors such as:
> >>
> >>   $ bpftool cgroup tree
> >>   CgroupPath
> >>   ID       AttachType      AttachFlags     Name
> >>   Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid =
argument
> >>
> >> This patch restores the logic of ignoring EINVAL from prior to that pa=
tch.
> >>
> >> Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types"=
)
> >> Reported-by: Sagarika Sharma <sharmasagarika@google.com>
> >> Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
> >> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> >> ---
> >>  tools/bpf/bpftool/cgroup.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> >> index 93b139bfb9880..3f1d6be512151 100644
> >> --- a/tools/bpf/bpftool/cgroup.c
> >> +++ b/tools/bpf/bpftool/cgroup.c
> >> @@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd=
)
> >>         for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
> >>                 int count =3D count_attached_bpf_progs(cgroup_fd, cgro=
up_attach_types[i]);
> >>
> >> -               if (count < 0)
> >> +               if (count < 0 && errno !=3D EINVAL)
> >>                         return -1;
> >
> > let's maybe change count_attached_bpf_progs() to return error directly
> > as returned by bpf_prog_query(), instead of translating that to -1 and
> > then requiring relying on errno?
> >
> > so just
> >
> > if (ret)
> >     return ret;
> >
> > and then just
> >
> > if (count < 0 && count !=3D -EINVAL)
> >     return /* well whatever, I'd return error probably instead of -1 ag=
ain */
> >
> > Thoughts?
>
> It feels maybe slightly less intuitive to me to compare "count" - rather
> than "errno" - with "-EINVAL", but I don't mind really. It does make
> sense to check the return code from the function. Looks OK from my side.

Hmm. I'm not strongly against it, but consider the current
cgroup_has_attached_progs. If I see

    int count =3D count_attached_bpf_progs(cgroup_fd, type);
    if (count < 0 && errno !=3D EINVAL)
        return -1;

I know "negative is error, error number is propagated though errno".
If instead, I see

    int count =3D count_attached_bpf_progs(cgroup_fd, type);
    if (count < 0 && count !=3D -EINVAL)
        return count;

I know "negative is error, error number is propagated though return
value". So I would expect the caller to do

    has_attached_progs =3D cgroup_has_attached_progs(cgroup_fd);
    if (has_attached_progs < 0) {
        p_err("can't query bpf programs attached to %s: %s",
              path, strerror(-has_attached_progs));

(strerror(-has_attached_progs) rather than strerror(errno)). While I'm
fine with such a change, it looks a bit extraneous for what was a
simple one-line bug fix, and feels like it should be on a separate
patch and probably on bpf-next and not bpf. Wdyt?

YiFei Zhu

> Thanks,
> Quentin

