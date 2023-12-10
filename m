Return-Path: <bpf+bounces-17330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0A80B897
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F695B209C4
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C3615C4;
	Sun, 10 Dec 2023 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUKRaYTU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3696102
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:45:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be4f03b06so3256946e87.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702179934; x=1702784734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls5EZcIx2gVfawr4Am8X6tHx5viZzghNu8HNRfJma+o=;
        b=LUKRaYTUbgw5VadxxT8A11vbNogYsa79aErm7weWiB6+CBPikQo54LXUIL2HcUkTH4
         IUpsP3jqtWNApdrOZz+AMcSosPMhvOIB8PDh5OHT3jWeAXoALaEdwcuMRX54hUQFHQ0U
         0ZBCgfsVdjJDwO7ImktLtXyR7+wltHjZk3/Z8lKshs07jISi/W8qHQakY2n0/J34fMu4
         4k1ryok/98Y7nGyx5pqCH7fpickXYPsfciJuHyPjjxWeNUpKV+xAYjFCOE2QbE6Rpth+
         fqIKFiGAkLXwpfm/XY1uHSwc3+nm2VpE7uJoaQznboP+3wbqC/00Iop+F2vC+O/vIx5Z
         MveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702179934; x=1702784734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls5EZcIx2gVfawr4Am8X6tHx5viZzghNu8HNRfJma+o=;
        b=fOfO1UuD/izhXLVsEiNCtOd8WHEKcYNJ1uOuxEerdiuT7grG0AbBgqGqAteQZwSYeK
         8S+thitkA2e6jhDiTS/Fl37oBoYpkHPhia8k6gUvlD1d5XoKnKMLlNqhhk5h+vD/TcEY
         xwFkqKkUrmLCEojhuDWghdZ8es8DT3/wHd6DIUVX3UEXft1jsyITQNV8zLDrhoZFHqSH
         5wwKN5kyaYqtgacIER10P9kgakLqHKWVCNvGG3tVUv7JiH2sNtUYl28EYeWBgecudGoM
         LIxl6ZF/GYv4uSqOyvTSd1K0Fa+oGyKSNp/qFwfuWdbY20XZJqEj0wkJ3P+VucLccTxk
         Kz1Q==
X-Gm-Message-State: AOJu0Yyyr6IPqL8jtGW6uIYOVq7z3TJvnz+Fy7SdkkzMNYq0IelBe6l5
	rr2HxTitdIChRVFL1bSiNWRsAABqjTVxvT1kybMS0SI7P+7Oow==
X-Google-Smtp-Source: AGHT+IE+c9X+eqk+8UpJVZQCxq3z3mqOwnGJ8XLnnlRAeJnv0zg6OFwMaCTcJi2//OEv6ZU1X7UJIn1EWyEFE70fdPY=
X-Received: by 2002:ac2:4da8:0:b0:50b:f7b1:d87b with SMTP id
 h8-20020ac24da8000000b0050bf7b1d87bmr626372lfe.142.1702179933731; Sat, 09 Dec
 2023 19:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWLsesOeyfiUuV_Mgz3xJ0WfNVeNunRQZsN5Esv-aqNO3iT-Q@mail.gmail.com>
 <CAADnVQ+1e1_4vyr7wC5GV5jWdQND3bH+nxnWH8wd9zry0-Z-CQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+1e1_4vyr7wC5GV5jWdQND3bH+nxnWH8wd9zry0-Z-CQ@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sat, 9 Dec 2023 22:45:20 -0500
Message-ID: <CABWLseum_8QnZPRDdyh=gzoWD6GqSmzUSQJFBuVFEFoc4a3mcg@mail.gmail.com>
Subject: Re: [bug report] until recently, code for bpf_loop callbacks using
 stack for ctx was mangled by verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrew Werner <andrew@dataexmachina.dev>, kernel-team@dataexmachina.dev, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 9:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 1:58=E2=80=AFPM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > If Eduard's patch cannot be backported, I had a random thought that per=
haps
> > dead-code elimination could be partially disabled (perhaps only for loo=
p
> > callbacks, ignoring the functions that the callbacks call).
>
> imo the dead code elimination issue is a minor pain point compared to
> the safety issue that patches addressed.

Sounds like backports will happen; that's all I wanted, so I'm happy.
Just to beat a dead-horse -- working around the issue might be doable once =
you
know what the issue is. But I can say from personal experience that startin=
g
with a C program which appears buggy and *figuring out* that the verifier
"mis-compiled" it, and then understanding *why* and what kind of work-aroun=
d
might help is not easy.

> The barrier_var() and asm volatile can workaround "wrong dead code" issue=
.
> Pls use it while the fixes are slowly getting into older kernels.

Thanks for letting me know about barrier_var(), seems like a trick that wil=
l
come in handy in the future. But I'm not entirely sure how it applies here.=
  It
seems like barrier_var() can be used to inhibit some *compiler* optimizatio=
ns.
But how does that translate to getting the *verifier* to forget a fixed val=
ue
that it knows for a register or a set of stack slots or a C variable (which=
 is
what I think is what's needed in order to avoid the "wrong dead code
elimination" issue)? Would you mind kindly spelling it out for my learning?


> Eduard's patches are the only feasible path to backport.
> We cannot support franken kernels with different verifier logic.
> The patches were designed to be backportable.
> We didn't start backport activities to make sure the fixes
> are not causing regressions in bpf progs.
> The backports don't have to be done in order either.
> If there is a particular kernel version you care about please
> prepare a backport and cc bpf list, Greg KH and Sasha Levin.
> It could happen that your favorite kernel is not on their list though.

