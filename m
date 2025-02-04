Return-Path: <bpf+bounces-50346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F1A26915
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE33F165594
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9234964F;
	Tue,  4 Feb 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/H6hl5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64596FC3;
	Tue,  4 Feb 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630380; cv=none; b=mZ2dOewEQeFP1wM4ayLr8jihROTh+QzGEnScFf3l4gKkezCnSNaS20PXx6y8qCELnY8YMtROgNAMg+RLC1DlKHj54316l5uUAfSvrETnZ3ZdLHi++oeHklKI0ZWM0nnXbiu9WKDpFPXHIdh3BvxC/6dNKjxSrOU4DMo9s/w0EaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630380; c=relaxed/simple;
	bh=ZYsusg0jHvhq8Rgnx8CGSBpV/AYmn1ZOZIXDZrnVXqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBzGAyWZOSU6i7hZ8pKq6vF1ZEDmpYOSb6Y1sMhUNm1Ng83gDqrIXco89bTofJffGr6AdiUAWahuNnZJG4y468I8hWizarxxX9ZGlW4jpg1Nt4yXt7cVpDFdC/lV7K9z8N1fUnbM+MbDBFdAmJ29OlClfgtUpl+T3MjpBxQPf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/H6hl5W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so86758705ad.0;
        Mon, 03 Feb 2025 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630378; x=1739235178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIVwnmw3+Uqu/f1OwaIZM60ey1qrW+y4C63LWJ9AWxE=;
        b=G/H6hl5W8PshBDMiPLAiGhQ28ZOo4zgWaNwCy9rohjMX0pJiEuAt9hLFG0r7YPSv9h
         LzFcx4zLopIk3D+GBS8LjMx1Y5I9XLxsw6L+xFS2vSUqV3fmiMl6TeP+7P+UE59LJ+Tm
         ehbrxy1bz+8IDeWRmOTZNhryjXugvqg3KaF9CaoEpPwcdvBu3mplRJzi/OLOd/iQLbSH
         Eo3DAeEf4PK1otVcZYJPkZTxAUpI2zpnx9LcRNPmXgFPTdkYLfMLt37I3iyslHkEDqd0
         jIVnvh9/VAk+tIp9NRmJa/vXmNUhjmmsUlhJItq97bqTjUFKDaHbEKMta5Tr76PhYNe8
         TtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630378; x=1739235178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIVwnmw3+Uqu/f1OwaIZM60ey1qrW+y4C63LWJ9AWxE=;
        b=EcmUyj0Dr9q+sjN5xB77ynUHqv2/qE3ubB3/UYZ9uoZIvjuTa3Xt1OknARFJoff61b
         X9VBwB9KF1cphZWUx7zp/6c/shpYd3kGObqVz7JBbX/5SyKrI2VnRYadQ9BFP7MoM5yO
         dR5aLRwdZ2U/E5KxExzE9VtLEE3HUJukoXQPEXy9kXOL1WYgzFEIwqhqL1EoctfpnJHv
         0Y6EfnDcKPo/iRqWgwcmnMij/8a+rIlG43AsjEdsRg9d0o9GdgD/sYIxjULKgcMGeBH1
         fCJl3D4eoZ9DwTdQEZIwYmMBAUBo6GJBZ0FjxeI9s3/w4ZcAqvO6o6OQmq1obklOArpG
         vkZg==
X-Forwarded-Encrypted: i=1; AJvYcCW9FkZMz+GLqoBAuX9xoC3u+G5YQRqjZLUOCBGVxmxXEmAEINE++g1oxwacUOUNubgLUD9rrAguwMhQd/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXikl74bcMsj7w5N3aEd6+ktSpzMN75wVVyRfawyixTPtFQjZ
	mD7gUwiBbvT3r+iWbO6XnIA9WW2qK/HArRirWQ2yZQNb7Snf4/gJ
X-Gm-Gg: ASbGnctbJVGHsDEawLN1ofqJg27iNEYS6VXF9/s35O/FyxPYUEONtg55O9owwQsYPZ4
	20IQzNLETnYpkJm/usX/lKrqUyDMHs+LmIMiG4WnHW6MlStNhvysaOV9iIdW1alNxDcaqGitX+Y
	qSySTxdTrEEwEOO6q/rh9fsNzxXyYIyuKEQL+JBv2bxgLKRUpIYsUj157CsGzAIrXSzRMjhgd/x
	5A0xrxC5RyeI0sNxpzVBGwXxcoHeQNsR9Rkx6rzytn2gaNNhalLR3eMUdz2cgTzhj7GL2jgLCLR
	xRgl4M0M6Luq
X-Google-Smtp-Source: AGHT+IFFrOOp9tSCjr6GLI3eesNOiZDZvaAY/wNz+1FZqhhHxSr5HGXiX3u1YhbOfgi7hgk0EZO6Fw==
X-Received: by 2002:a05:6a20:9f45:b0:1ea:ddd1:2fcf with SMTP id adf61e73a8af0-1ed7a462e94mr37266584637.4.1738630377942;
        Mon, 03 Feb 2025 16:52:57 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ccea1sm9117958b3a.122.2025.02.03.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:52:57 -0800 (PST)
Message-ID: <dead664fa11ac274db00b509931c533883dd4fdf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
  Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet <void@manifault.com>,
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Feb 2025 16:52:52 -0800
In-Reply-To: <Z6Ffquq8IORjCqrI@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
	 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
	 <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
	 <Z6Ffquq8IORjCqrI@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 00:30 +0000, Peilin Ye wrote:
> Hi Eduard,
>=20
> One more question (for my understanding):
>=20
> On Tue, Jan 28, 2025 at 05:06:03PM -0800, Eduard Zingerman wrote:
> > On Sat, 2025-01-25 at 02:19 +0000, Peilin Ye wrote:
> > > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > [...]
> >=20
> > > +SEC("raw_tp/sys_enter")
> > > +int load_acquire(const void *ctx)
> > > +{
> > > +	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> > > +		return 0;
> >=20
> > Nit: This check is not needed, since bpf_prog_test_run_opts() is used
> >      to run the tests.
>=20
> Could you explain a bit more why it's not needed?
>=20
> I read commit 0f4feacc9155 ("selftests/bpf: Adding pid filtering for
> atomics test") which added those 'pid' checks to atomics/ tests.  The
> commit message [1] says the purpose was to "make atomics test able to
> run in parallel with other tests", which I couldn't understand.
>=20
> How using bpf_prog_test_run_opts() makes those 'pid' checks unnecessary?
>=20
> [1] https://lore.kernel.org/bpf/20211006185619.364369-11-fallentree@fb.co=
m/#r


Hi Peilin,

The entry point for the test looks as follows:

    void test_arena_atomics(void)
    {
    	...
    	skel =3D arena_atomics__open();
    	if (!ASSERT_OK_PTR(skel, "arena atomics skeleton open"))
    		return;
   =20
    	if (skel->data->skip_tests) { ... }
    	err =3D arena_atomics__load(skel);
    	if (!ASSERT_OK(err, "arena atomics skeleton load"))
    		return;
    	skel->bss->pid =3D getpid();
   =20
    	if (test__start_subtest("add"))
    		test_add(skel);
            ...
   =20
    cleanup:
    	arena_atomics__destroy(skel);
    }

Note arena_atomics__{open,load} calls but absence of the
arena_atomics__attach call. W/o arena_atomics__attach call the
programs would not be hooked to the designated extension points,
e.g. "raw_tp/sys_enter".

The bpf_prog_test_run_opts() invokes BPF_PROG_TEST_RUN command of the
bpf system call, which does not attach the program either,
but executes jitted code directly with fake context.
(See bpf_prog_ops->test_run callback (method?) and
 bpf_prog_test_run_raw_tp()).

Same happens in prog{,_tests}/arena.c: no attachment happens after
commit [2]. Commit [1] is unnecessary after [2].

[2] commit 04fcb5f9a104 ("selftests/bpf: Migrate from bpf_prog_test_run")


