Return-Path: <bpf+bounces-66300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9BB3225B
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F19B1C85A6C
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ABF2BEC5C;
	Fri, 22 Aug 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE+6pP4Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964AE19D07A;
	Fri, 22 Aug 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888073; cv=none; b=AqJpFtiA7+GUOPaNomqBoE/RPvNnhxuzxKZicltYfG38ieFT/dMrqPWdlvDfrlm/UCm8xCm6ckvjq5pDIrN7zN34TafF+5YI2LjqZAkwUSwJgVVRFoILktT6W4HKqt+BEZH5/CBPVrrJq+GlUlO4UOFcmx6SZjU2m8PWExEIfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888073; c=relaxed/simple;
	bh=eWwJe3A1Z7j62M+9Pr2zTAPbwqmRmVQUBQ4/NFNiL2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZLQaYVA+0fhmXeBmXnjwID6AqoZ7FrKFiGfejdBVxXRgCWH8Hu0vUUeJvAJ4oh45bKxHlMR/dlnuqez1fRI8CRhd82lMPe4q1lS6R2qgEIxpSKeA3W5dIhIWEKpHaCPdImVCzunWBYSxkUjaWPI7bTJc7ofNcW1WZeui/AoN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE+6pP4Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2465cb0e81bso3771795ad.1;
        Fri, 22 Aug 2025 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755888071; x=1756492871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/rReV2pLJY353C1C0JDT2rm1TlLVMq5dUxAAJs3Tdw=;
        b=PE+6pP4Z7XwAErMDLqDDMc8AiWBOUaPaFuwLAe4lsae4RLX6oVRIKBjtQlpy8x0nUG
         gVlVPJacU/yNl13qqBBm/WyV/Heh886foybz5L1m8vvG/r7mnbuQScsqffC0IHuQQEc9
         ILm0POoP+JO1GbMzyfEk4LSDtvZGk3Wq+xBw00aXArD0kUAI7axJVenlCl9WmvRs+N9g
         SuPzEZD9QZOnJL9xMDamrfKV/E9BNFGgrWb1P3sUxb+19fji13ftRc+lDrBWQH+GdqWS
         +h4CYr4H60FE/zj5wVxXE1GpYXzOsLn2RxhGM/0OOBpofBqZbgW7eS1zqEiioJ8xlNh8
         xV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888071; x=1756492871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/rReV2pLJY353C1C0JDT2rm1TlLVMq5dUxAAJs3Tdw=;
        b=bqHj4/o1VK0PXO9DLW6sQ1RuYHSNQOrGoqvfVUnGkWtuWwTK9hm7bSCuCOwwU6hveZ
         I6z+7yjlgUMqdsUtHHb411OKCJfBfkpb1jmS0gV+JcRqFoAc6mSdB1kbUwVv6kf1cadb
         rbVqH813mIn5t8s73XtPLdRDvHmA4lb95km2Ux8fkl0x5t58pejKBqawjOrbaxQ+1f9E
         glEuEs2NSlXforSwPZYG6r3hsVmf2es6k6uwS6q95QkYtPglWtxQQ/HmsNhBgISiP3Ed
         t0c8+NXbOTblsRmnuTybjasC/2JU4AVagRfqYnKKlmYRnuH2CMH7x5blhxXyvQ/qShUt
         yXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtIQXknFuGoTico6fkxjB38EAQHSlUf+85fqO+9beH3VF2BATliE5aw+R2tvrb7ryBFyzbI9wS6fed7KFd@vger.kernel.org, AJvYcCWlWCetQqRrXrTuQDmAwSB/TBW73Ej6fuHhQeStWd4scKU7hF9DT6ci0ts5DMqHPLKLYbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9OD6YeMDzlBZhwtUGz++mfgtBlyJzKrxzajPvBdOblTjkn+o
	PVPBqbxTnsihwCu1Ud0+aVSXtPFO0PJi5CPj4dqPerDmp/BxMF/nRtC2eJo7iEiWZiyHs7yMtdI
	qQFABTzQkem7mQW1RaV4SmA5BP3bDYDo=
X-Gm-Gg: ASbGncunbP+UN+zNASm+/gebLfyE8+dMOQ2pFAwCLIqpVGQ89Nzs+zE8sVaV3mDZ1WV
	25AHadyDbj5RLRKMQPCZcANwmBjMBk79D8YGL2N0uAfCx4AL+rmLi1kWzxrLzdTUTtff90ru8S9
	4xYBTFcC8sC5Rmsodc62FIPcNvV1syiMevOmLSJLGSZ1H8xEc1Z8INGBuZyu8Tx9V08r/evMyfh
	QTq8YFuUJyIyJEpnkrBjT4=
X-Google-Smtp-Source: AGHT+IF/3jHDoWr5Uflpyg5tER03oKyigEBEc62KHYrnCFzmzwFh3BYqpg8VjNdJM9SvobgfSytwus67ijnHY/6dmuk=
X-Received: by 2002:a17:902:cf04:b0:243:80d:c513 with SMTP id
 d9443c01a7336-2462edd79c9mr55321885ad.4.1755888070723; Fri, 22 Aug 2025
 11:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811201615.564461-1-ebiggers@kernel.org> <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>
In-Reply-To: <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 11:40:55 -0700
X-Gm-Features: Ac12FXxJ6_JzY9yyE5wT9l263pTbwsQkoCpgYV8QHAQ6HYWCKXi0qJey-UAWLc8
Message-ID: <CAEf4BzZ5Qpe+APUgFvWL51EWML9e1nQc1OG7k-XT+bBM-tTrDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use sha1() instead of sha1_transform() in bpf_prog_calc_tag()
To: Song Liu <song@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, linux-crypto@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:58=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Aug 11, 2025 at 1:17=E2=80=AFPM Eric Biggers <ebiggers@kernel.org=
> wrote:
> >
> > Now that there's a proper SHA-1 library API, just use that instead of
> > the low-level SHA-1 compression function.  This eliminates the need for
> > bpf_prog_calc_tag() to implement the SHA-1 padding itself.  No
> > functional change; the computed tags remain the same.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  include/linux/filter.h |  6 -----
> >  kernel/bpf/core.c      | 50 ++++++++----------------------------------
> >  2 files changed, 9 insertions(+), 47 deletions(-)
>
> Nice clean up!
>
> It appears this patch changes the sha1 of some programs, but not
> some other programs. For example, sha1 of program
> test_task_kfunc_flavor_relo_not_found from task_kfunc_success.bpf.o
> stays the same before and after the patch, while other programs from
> task_kfunc_success.bpf.o have different sha1 after the patch.
>
> Is this expected?
>

I modified veristat.c locally to print prog tags, and they were
identical before and after. So I'm landing the patch as it's a nice
clean up (and it looks like we might change sha1 for sha256 soon
anyways with KP's work on signing). Thanks!

$ sudo ./veristat task_kfunc_success.bpf.o
Processing 'task_kfunc_success.bpf.o'...
TAG for task_kfunc_success.bpf.o/test_task_kfunc_flavor_relo: 3ec44141eafbb=
946
TAG for task_kfunc_success.bpf.o/test_task_kfunc_flavor_relo_not_found:
a2b1538278853bab
TAG for task_kfunc_success.bpf.o/test_task_acquire_release_argument:
81814696d4ca6b04
TAG for task_kfunc_success.bpf.o/test_task_acquire_release_current:
da78e4661f6fc0f5
TAG for task_kfunc_success.bpf.o/test_task_acquire_leave_in_map:
6987ab3c231b11c8
TAG for task_kfunc_success.bpf.o/test_task_xchg_release: 243afeabd9545c81
TAG for task_kfunc_success.bpf.o/test_task_map_acquire_release: 52c2aa84fd0=
f4163
TAG for task_kfunc_success.bpf.o/test_task_current_acquire_release:
0a49c6127a61f92e
TAG for task_kfunc_success.bpf.o/test_task_from_pid_arg: f2c0d6eb9d6f1c87
TAG for task_kfunc_success.bpf.o/test_task_from_pid_current: 3a7cc6125deb09=
20
TAG for task_kfunc_success.bpf.o/test_task_from_pid_invalid: a41a7678b91b0f=
12
TAG for task_kfunc_success.bpf.o/task_kfunc_acquire_trusted_walked:
8c38bae3eeaab179
TAG for task_kfunc_success.bpf.o/test_task_from_vpid_current: 4d5bd93fd0615=
005
TAG for task_kfunc_success.bpf.o/test_task_from_vpid_invalid: 87a101256cffd=
707
File                      Program
Verdict  Duration (us)  Insns  States  Program size  Jited size
------------------------  -------------------------------------
-------  -------------  -----  ------  ------------  ----------
task_kfunc_success.bpf.o  task_kfunc_acquire_trusted_walked
success           1111     13       1            13          73
task_kfunc_success.bpf.o  test_task_acquire_leave_in_map
success            376     73       7            57         282
task_kfunc_success.bpf.o  test_task_acquire_release_argument
success            211     18       2            41          83
task_kfunc_success.bpf.o  test_task_acquire_release_current
success            229     18       2            41          82
task_kfunc_success.bpf.o  test_task_current_acquire_release
success            212     20       2            19          96
task_kfunc_success.bpf.o  test_task_from_pid_arg
success            235     31       3            26         173
task_kfunc_success.bpf.o  test_task_from_pid_current
success            239     32       3            27         181
task_kfunc_success.bpf.o  test_task_from_pid_invalid
success            234     42       4            42         213
task_kfunc_success.bpf.o  test_task_from_vpid_current
success            139     21       2            19         106
task_kfunc_success.bpf.o  test_task_from_vpid_invalid
success            107     29       3            19         107
task_kfunc_success.bpf.o  test_task_kfunc_flavor_relo
success            270     17       1            37          88
task_kfunc_success.bpf.o  test_task_kfunc_flavor_relo_not_found
success            146      8       0            13          38
task_kfunc_success.bpf.o  test_task_map_acquire_release
success            428    126      12            95         469
task_kfunc_success.bpf.o  test_task_xchg_release
success            634    202      19           173         854
------------------------  -------------------------------------
-------  -------------  -----  ------  ------------  ----------
Done. Processed 1 files, 0 programs. Skipped 14 files, 0 programs.

> Thanks,
> Song

