Return-Path: <bpf+bounces-65405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CDB218CB
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463731A216BA
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BF22A7F2;
	Mon, 11 Aug 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrIQ6cCG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4650199FAC
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953066; cv=none; b=UR9iSyjPqJ0VJbjGlXsUe9HPIgW8A1hBhC5lZeP8AHTDte2ZzZb+JzvcCus8BZQXfPxR1aJoebhBuROnZW0fSIKAgX2JERSIuZyO0vKt3zEPHRDriGqZsW8YTC8FW4MR6YVnb/N/NUT/nElbCRzc8f2744I4v5xKQWiAcB05gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953066; c=relaxed/simple;
	bh=D8u4Wn0nPfgSWBBIR66pa5lEFOZ8jelEVoWLRm1UyK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhyhyy0cYJDc6YUwtJ+6gCdW71SUm/D90xk8HdlIn5Tx2h3oJvEPcyjI843NvAkXekCO/ooUWMHRQstbDwyfEm/W+6x/8j+yV7Kl3gfhaYHqh0eW8wRDmLvtUfiejuibpzMJ8dEpNyffJt5V0K6RiYotZtIyXXuKJCmk1OynMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrIQ6cCG; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-af66d49daffso818226666b.1
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754953063; x=1755557863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwcJc3QWn20XEXh4Ugp8mvIKUxfFY+PGCVe0tQnmgeQ=;
        b=SrIQ6cCGPloPziCzUGpV7jFcKw0e6S338zpU54x83AeiStomNz/l/TvUOpxyMjhJo9
         3TgjhPPT5w0p2aUprKFKaxw2gSx6c+Nr2lNaR+TwsA8bsgXfjlyI1j0aiyjNc/G2DZF6
         PqzoNn+t0f6XCMudQDhz2QjLp9c2zoQvIMJn3XuSx10f0t29i7csVAubT94D/EKUIjHQ
         ymSvzMzvNv/6nvPRqROlE1mll62nj5JTzMkQDDi3CvJZzapFfYNUuGRBydfsisn97hgi
         uqBzMFn/5OpXJmhoCpZ9L3ldFYN/TB+XJApbrHnaJLaOMcNzagtZLV4bUqvUhjed70Hk
         mAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953063; x=1755557863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwcJc3QWn20XEXh4Ugp8mvIKUxfFY+PGCVe0tQnmgeQ=;
        b=TwQQrDk2e/RUfrgvcEY+1/aSjXMbZj0fEK/bYyfPn1f2tid1R2KFAzVK4V1ZAvenSS
         Jffj6R8WBhjp+WnLfCunMoeMvaRYyRXAzAf+cypzG3EsLn4QFOOV+44CEwkv7eMptyRX
         7L10Fee/nB8kQbq0VIuGtHeskmNNzeYq3mp+6C9sZ7L2Xybp1CPwYjTGRLp6+QT6vywC
         NcByPAUUc5X2gJxQQWo/VenLOS9UgYPGlkUBhSfXokd/W8BKUgGHFQutReznAzo8bgMr
         w3ffkiT4gwX6t39fi7cZBQtEAMvIWNa+FmR/1fTeRJi5zmedlMR4kwmz49tsOH0Fvc8q
         REoA==
X-Gm-Message-State: AOJu0Yz39CekdCOzluuXw+ScTkwMKWU8i+TIlJo2wC/U8AykqM/RFu8J
	EUS8neZaSmANER7POSGHSFbotyjLCGkgkWMtLWK62jD8h5vJT4aQl/fPmuauE+hioWBZUlcckNV
	RWj8RSDJyY5tCRk63FMbNb/1dttluf5CjojmRxag=
X-Gm-Gg: ASbGncurtGmIdhdAn4V7vLJu1JHZ5kZceidr1NKBMHQnGYCZv9hcNXWtFxfgXi1Xrs/
	xKgDOVvHw2iJEVucJtGYKWHyAeToL42H9RwYI1Uo8/x5cQ6JECCc7h8riTJ/yHqP6Dxz+aSy5Lo
	eXIoxG4uZCMBtNs8Z0BJ/Yp+aKztu7V3t0xoTZeVPzawNBAEwGZPv592JIZOo7MzZxyikW9DGpa
	av6LIvds+t+6n8ubwihQxCN5/E4dOQia+sTiMq3
X-Google-Smtp-Source: AGHT+IH+NxaqZ9k6GjJOv62UqReOpVi4+UG0Zy+oo3+u9hCmCWG1ZTqAAfZ+U2n5VuEL6cZZSdxcfwt1lHCVnd2PIvg=
X-Received: by 2002:a17:906:684b:b0:afa:1d2c:2dc7 with SMTP id
 a640c23a62f3a-afa1d2c2efdmr109040966b.57.1754953062781; Mon, 11 Aug 2025
 15:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811195901.1651800-1-memxor@gmail.com> <20250811195901.1651800-3-memxor@gmail.com>
 <ad1f513174bcbc48ca3eb21a746e4de8e4dd68a5.camel@gmail.com>
In-Reply-To: <ad1f513174bcbc48ca3eb21a746e4de8e4dd68a5.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 Aug 2025 00:57:06 +0200
X-Gm-Features: Ac12FXyC221Hy1ha_nxNBfck-SsGIaF3iZMPQPxsx9nHU0_1KdeiEkMlrLdpT74
Message-ID: <CAP01T75o3K3XdJm6JV3s51dgzO90scVQC8SiqbGn5mV5=R6vWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test for
 bpf_cgroup_from_id lookup in non-root cgns
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, tj@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 00:51, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2025-08-11 at 12:59 -0700, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +static void test_cgrp_from_id_ns(void)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +     struct cgrp_kfunc_success *skel;
> > +     struct bpf_program *prog;
> > +     int fd, pid, pipe_fd[2];
> > +
> > +     skel = open_load_cgrp_kfunc_skel();
> > +     if (!ASSERT_OK_PTR(skel, "open_load_skel"))
> > +             return;
> > +
> > +     if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
> > +             goto cleanup;
> > +
> > +     prog = bpf_object__find_program_by_name(skel->obj, "test_cgrp_from_id_ns");
>
> Nit: skel->test_cgrp_from_id_ns ?

Fixed.

>
> > +     if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> > +             goto cleanup;
> > +
> > +     if (!ASSERT_OK(pipe(pipe_fd), "pipe"))
> > +             goto cleanup;
> > +
> > +     pid = fork();
> > +     if (!ASSERT_GE(pid, 0, "fork result"))
> > +             goto pipe_cleanup;
> > +
> > +     if (pid == 0) {
> > +             int ret = 1;
> > +
> > +             close(pipe_fd[0]);
> > +             fd = create_and_get_cgroup("cgrp_from_id_ns");
> > +             if (!ASSERT_GE(fd, 0, "cgrp_fd"))
> > +                     _exit(1);
> > +
> > +             if (!ASSERT_OK(join_cgroup("cgrp_from_id_ns"), "join cgrp"))
> > +                     goto fail;
> > +
> > +             if (!ASSERT_OK(unshare(CLONE_NEWCGROUP), "unshare cgns"))
> > +                     goto fail;
> > +
> > +             ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> > +             if (!ASSERT_OK(ret, "test run ret"))
> > +                     goto fail;
> > +
> > +             remove_cgroup("cgrp_from_id_ns");
>
> If this test is executed in -vvv mode, the following is printed:
>
>   (cgroup_helpers.c:412: errno: Device or resource busy) rmdiring cgroup cgrp_from_id_ns ...
>
> And cgroup is still in place after exit.  As far as I understand,
> child process needs to change cgroup again or remove_cgroup needs to
> be called in the parent process.

It is probably because the cgroup fd is still open, I will check and fix.

>
> > +
> > +             if (!ASSERT_OK(opts.retval, "test run retval"))
> > +                     _exit(1);
>
> Nit: why not 'exit'? '_exit' does not flush file descriptors.

Fixed.

>
> > +             ret = 0;
> > +             close(fd);
> > +             if (!ASSERT_EQ(write(pipe_fd[1], &ret, sizeof(ret)), sizeof(ret), "write pipe"))
> > +                     _exit(1);
> > +
> > +             _exit(0);
> > +fail:
> > +             remove_cgroup("cgrp_from_id_ns");
> > +             _exit(1);
> > +     } else {
> > +             int res;
> > +
> > +             close(pipe_fd[1]);
> > +             if (!ASSERT_EQ(read(pipe_fd[0], &res, sizeof(res)), sizeof(res), "read res"))
> > +                     goto pipe_cleanup;
> > +             if (!ASSERT_OK(res, "result from run"))
> > +                     goto pipe_cleanup;
> > +     }
> > +
> > +pipe_cleanup:
> > +     close(pipe_fd[1]);
>
> Nit: should this be pipe_fd[0]?
>      in case of a fork() failure, should this be both?

Yeah, fixed.

>
> > +cleanup:
> > +     cgrp_kfunc_success__destroy(skel);
> > +}
> > +
> >  void test_cgrp_kfunc(void)
> >  {
> >       int i, err;
>
> [...]

