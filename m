Return-Path: <bpf+bounces-17322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233780B86E
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D03A1C2083A
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AF15A0;
	Sun, 10 Dec 2023 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeylPBs6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F2D0
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 18:38:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333a3a599fso2291797f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 18:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702175901; x=1702780701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pscw3WcBdq5GIG0FtrcVnuU2Cz3Nrz4SYGX6nqtDZM=;
        b=aeylPBs69RLtXxtHc/52vg9wyKKt9wWJkG2StmkZDc3YvTdKv6HhUF4xhzHvPjB3CR
         i/Lo8EwsX6/iOEKQ3LoK0SEzgyim1bUQT5ZQEbhYU3QT/FoUWmAKHZSujP2dbQuqg2Sg
         LHLiI2IqxSJDE1JxMYs5qf2jSbrC/0xbQDZ+JU49taKwY3a0utOc0Bx0dAkftr0B1MUk
         PLsmEW7xwVTtqGtYDHw5f+Qyn8W6+hQ0Tu2BQboXG+GPodLUYEfPUhvL9ZVdPI/2V/Ul
         UZK0f+CbCKovIu4WVDXT5VjeaOCo9MS8asJ2+a2QZjMHaSHxtz0A0j+ika6dcW8Mpk1J
         vaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702175901; x=1702780701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pscw3WcBdq5GIG0FtrcVnuU2Cz3Nrz4SYGX6nqtDZM=;
        b=XsQp5B7tpnMY6o1iJhWQ52ap3Oii4yIFAZjsiGIoO4xM2i1z13H7wlOR6LUopEokZq
         nDn5VMkFCNQGyJPbWQ1RUQZCO3GLr1hxoeS6I8ouAYPpyjO8MlYZ7/+UAQ6hNHHbDutM
         QxHPzkdii53FRgwI8J+qSpP7lolXq89x1kjhb26GtuL05dcZOKFV29zRFBqVw2jym5hd
         plWg3n4W/NF7Friv7/LU5YfU+jP9rhx5/orAhCbo7cQ9hhQRtXzPu/iUgcONZniU1oZn
         cqG9AGER9XJvmUedyUaUFO9pCvb/svnB8XStffbs7Hirh0prZv1sxzP131Ag7oXVa6iQ
         lrFQ==
X-Gm-Message-State: AOJu0Yx3ChBW02Mu+nbgI4nFMJfjm0NNf0VcqSMWzEqrjtUxW72iVW8P
	MuTj2v1n69/oTC93QIVcT/BZVPqxGVb2n/qAfdY=
X-Google-Smtp-Source: AGHT+IHchaRA5N6WXF4BhER6CoQu2NQWE9ShibJ/WL2xH92q6ajbT6ARN6wfk35LcMkTCdc9hxND/ObPK+5ZPM9Mc7I=
X-Received: by 2002:a5d:4c4d:0:b0:333:87d:7175 with SMTP id
 n13-20020a5d4c4d000000b00333087d7175mr1431829wrt.28.1702175900954; Sat, 09
 Dec 2023 18:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWLsesOeyfiUuV_Mgz3xJ0WfNVeNunRQZsN5Esv-aqNO3iT-Q@mail.gmail.com>
In-Reply-To: <CABWLsesOeyfiUuV_Mgz3xJ0WfNVeNunRQZsN5Esv-aqNO3iT-Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 18:38:09 -0800
Message-ID: <CAADnVQ+1e1_4vyr7wC5GV5jWdQND3bH+nxnWH8wd9zry0-Z-CQ@mail.gmail.com>
Subject: Re: [bug report] until recently, code for bpf_loop callbacks using
 stack for ctx was mangled by verifier
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrew Werner <andrew@dataexmachina.dev>, kernel-team@dataexmachina.dev, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:58=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> If Eduard's patch cannot be backported, I had a random thought that perha=
ps
> dead-code elimination could be partially disabled (perhaps only for loop
> callbacks, ignoring the functions that the callbacks call).

imo the dead code elimination issue is a minor pain point compared to
the safety issue that patches addressed.
The barrier_var() and asm volatile can workaround "wrong dead code" issue.
Pls use it while the fixes are slowly getting into older kernels.
Eduard's patches are the only feasible path to backport.
We cannot support franken kernels with different verifier logic.
The patches were designed to be backportable.
We didn't start backport activities to make sure the fixes
are not causing regressions in bpf progs.
The backports don't have to be done in order either.
If there is a particular kernel version you care about please
prepare a backport and cc bpf list, Greg KH and Sasha Levin.
It could happen that your favorite kernel is not on their list though.

