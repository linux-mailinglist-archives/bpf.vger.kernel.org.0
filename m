Return-Path: <bpf+bounces-22596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70A86180A
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DF1F22E16
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9A128834;
	Fri, 23 Feb 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxVs56UC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B9126F2C
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706144; cv=none; b=jK2wdNKI9JuY6CxA3FtNLLamcCIwdjkIMD6nwqrGoAJY+tSQNRJOPVV0SoPdNx8iYcjUU6gPKjJzC3rGu2/pV+IgaCvxfIzWUpViRYPNa0w/bka5C3/4YDgLqwEBBJfPLSDACFeZeS2ELnw1RyVTnk77Ouq1n6AMvg9FmyWyfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706144; c=relaxed/simple;
	bh=k68/rAROY6ax/AG//6WOYvNJ2taLzaZPI09jrgg9CvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1Wmos91AOmHqzIzKongRO+5kmg1O70tLLScws+PNnv5qT/VW+rxAAcBixUlyIuDhZGjP4+tT3vIXKcG67TOhoQZWM+9oTYjNfwUO4xZ4lJ3So18hqCsg7QcsDnK8atcj4hkbSwOZ7/cu/sqh1MqAgowXeAl7cgqZSBXexM/dDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxVs56UC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412960dbb0eso4129845e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708706140; x=1709310940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snJfQePWU5LKH74nXvdbOx3e9j8F2Gk9Mrpo/geNT20=;
        b=SxVs56UCteJH5u/64RUH+zWVvMgdPGAT+G0TWk0skP3YcLwkdTWqCAfHsUiexdhLq/
         9PduBXopS39LEj760VlmzSJQ+PUsSXd6HFDNvpLSZgI4UOZsiX1ZE1GJ8Iho9sn+S0Uu
         gLsp8K3P+B3eN4owR5ctrwPuREtyx62IZRpCD0x860PfHSyePjbQ00iipmRPOrKOojvH
         ikanAYJ1lkMVxa7EprcW+RivaLTB6IGHMxapbExCLVb52B9W3j0sYzv0x/u9vma0gtKf
         hG+mDHFKI0PbSqgwU0pZ22L5sYSGFw+4ak+iVP0nd6JYqiZzhfsgOnS+AprkbOZXPhCG
         8/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706140; x=1709310940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snJfQePWU5LKH74nXvdbOx3e9j8F2Gk9Mrpo/geNT20=;
        b=BtvYNAszejlsSzynStebzg9yKw0XO8pSN6Ba/moooeXrG+L0wd2gQC1oprL4sEF7K/
         EQAAHvb9I+S+wTw8KwAmBARO4oUrFt/+EnocFiafGYklBbu/j+wuTyrbsLI6QcGEj175
         orA3jE8d4tIsC3WUWCavmd6Z1Gc+ukgfgzl5cocUoEhItDgqM3dc9uPLeLe1fyAKb0tQ
         Wy+jqtqc3RGQWW/qRALJOyAKZ6MjaDRLHzzMAXMgTGzfJLu/cFZ3YBS8eQdo9QZfWcux
         +DsLC4gb0pdvQDWIPr1ZU7xY3scJaLSgnlL8kmf0xAtgeZjRzAOpeoRvrHVghD6y7r1S
         4viw==
X-Forwarded-Encrypted: i=1; AJvYcCVgsoYPbGl5RtaqKFvziqsHxqV6/puCfaZi7dGYChzwBQkWym9XHPBahCgsRPnZsulr92TjviXko9048aKrIERYmWga
X-Gm-Message-State: AOJu0Ywkqacj6BuUUmyoAKeqkew0nP/pSEwwqqkPg5dMOiAkz2Myyy4H
	sG9dImh7UJPCPGkN747mfuaZ9GkNxvW5V4ikFvvpI79FtIA4KH3hbUtOC+cPOvPfrtJrMVoKF+S
	9Qyv5phkx+1ImLS+3a6tkeZBcdv0=
X-Google-Smtp-Source: AGHT+IFPtjUPjr3csOEpyFayQryIKCr0/XSPbzgxRv2DiaCkkk/SxLYPBkCLrPfuFfvp0BCmA/GU6xVn0sgs6ZIAvx4=
X-Received: by 2002:a05:6000:48:b0:33c:ec8f:7b51 with SMTP id
 k8-20020a056000004800b0033cec8f7b51mr217296wrx.16.1708706140425; Fri, 23 Feb
 2024 08:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222085232.62483-1-hffilwlqm@gmail.com> <20240222085232.62483-2-hffilwlqm@gmail.com>
 <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com> <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
In-Reply-To: <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 08:35:28 -0800
Message-ID: <CAADnVQ+yzkAxCK=L9qVUzSEmj72CH=9kqe25=Risj_BdaLDA=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Pu Lehui <pulehui@huawei.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:30=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/2/23 12:06, Pu Lehui wrote:
> >
> >
> > On 2024/2/22 16:52, Leon Hwang wrote:
>
> [SNIP]
>
> >>   }
> >>   @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
> >>       *pprog =3D prog;
> >>   }
> >>   +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
> >
> > Hi Leon, the solution is really simplifies complexity. If I understand
> > correctly, this TAIL_CALL_CNT becomes the system global wise, not the
> > prog global wise, but before it was limiting the TCC of entry prog.
> >
>
> Correct. It becomes a PERCPU global variable.
>
> But, I think this solution is not robust enough.
>
> For example,
>
> time      prog1           prog1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> line              prog2
>
> this is a time-line on a CPU. If prog1 and prog2 have tailcalls to run,
> prog2 will reset the tail_call_cnt on current CPU, which is used by
> prog1. As a result, when the CPU schedules from prog2 to prog1,
> tail_call_cnt on current CPU has been reset to 0, no matter whether
> prog1 incremented it.
>
> The tail_call_cnt reset issue happens too, even if PERCPU tail_call_cnt
> moves to 'struct bpf_prog_aux', i.e. one kprobe bpf prog can be
> triggered on many functions e.g. cilium/pwru. However, this moving is
> better than this solution.

kprobe progs are not preemptable.
There is bpf_prog_active that disallows any recursion.
Moving this percpu count to prog->aux should solve it.

> I think, my previous POC of 'struct bpf_prog_run_ctx' would be better.
> I'll resend it later, with some improvements.

percpu approach is still prefered, since it removes rax mess.

