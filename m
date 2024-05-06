Return-Path: <bpf+bounces-28736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058EB8BD838
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 01:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D2EB21576
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630C15D5A1;
	Mon,  6 May 2024 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqHaMFlA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767115B131;
	Mon,  6 May 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038569; cv=none; b=LLT2nt/NjL6qwi42zlpCYHr/C3WmAlOkrEXSRpGCJC+cbRhYw35yDHkLcYjFiA6pZ3vjLCuzn2qX+n+BoBfZmoiEzxCbt7bBtYCftJMP6SgvTLhqxGuUgeYvJXs7nhjrq8i/ggS49dybywY9nxkbAC9Qz7FUnvRMci7MRb2aAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038569; c=relaxed/simple;
	bh=1IVbn48SaZRlWHmSAYL0VGXv8W1m+hKXQFeTuINxXh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCjxuXmI8VOr2HL02TyqAXJNnP/ulnUdecQOekHCK+wXW2z5TANGmqTLBHuC2VqQ2B9VUDO53QNApPkEjvSdGTEX34sDKq6tlH9oRLdIY8UVau67gGIDP7i1jqRCOquKPnWhETDL6DXYPlU8JhGAFcBI5hyYKC4arrc+rBRDodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqHaMFlA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34db6a299b8so1645366f8f.3;
        Mon, 06 May 2024 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715038566; x=1715643366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVbn48SaZRlWHmSAYL0VGXv8W1m+hKXQFeTuINxXh8=;
        b=XqHaMFlAzbah75MO6E50vlAVVf6dNegXYw0jzlfvjRXwLbiSRsQtvUiFaxqMylUgpp
         y+OHiIvBMcR49IdWxsVVDRuEqzyGqFqkmtIsePx7LSLS3OgrmVlfp3TsQ26mbzJbtg7r
         9sfIWxxOoNMv+oPl9a5B77QUXNZkNKjWkcbCgFJWMlPP5syNVIVrlst/HDkV3kAYveWv
         EjLdlho5FiL7GxaRbp46ZjvMtsf6Wq2VktCc7c26QBHIThQh3iFpzeger36MD6kZlajp
         hiPl8EACdwBhjP9NMkqQ14/AYaeXW/1XUEezz5fqvAAcWQtPdwszW0E3kAYTlQ5elWAS
         Xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715038566; x=1715643366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IVbn48SaZRlWHmSAYL0VGXv8W1m+hKXQFeTuINxXh8=;
        b=nPfI88JJMO+wdVco2X3GuLH86fEUdA8jT/ltRDCXZ124f7XBWgtkK2h9uKE/kX1bgh
         8XeUGRvScQLzwciE1glYbyVSQYQqXQ23wEsVkVDBAo77/TemiXVu1FYkHZhqmp/0w/+K
         Wd27wT665Gvca8MIYyWhxQuQ/mJ3034oLab3RKxtr1ZueWXJhJuWQMK4yN13d2yqzHiB
         cx7oce36pWpTZWG+lapjua76h/A841Tis2pm4cbNAfeUFLBqmu/62cqYMW2VAknYkVKV
         lhFEYqCZ9PAZd+GdK0G+/vJdgfwuniHyOeuqonGfuCmbbgmBETNkjBx/6j/cvKIegLRl
         YPOA==
X-Forwarded-Encrypted: i=1; AJvYcCXMcFz4iQ79KtMnGxVw2HWFdPc8Lkd1jRp4B0uFkNO80gJOHJFi0l0SK56UCJ1Gr1gE/6Ywo7d0/v4rjOjKnxnrwMEZC3pBwgJgbRGMz267RpbUw3YSWHcRnBtTZbkh/WRe
X-Gm-Message-State: AOJu0YzqI1l5CtctENqEN93AqkhMWCwe5mZpiMRUsdOYjL65UOIk0V6L
	urdfpwIEtYQ7FT5N/SpyQso4QuF8vW2IKUJ+z8YuXDoUPJrRp8rHfaZzEoAlP4l5OuzOYtLJIF+
	kYyd1inIlAWsgMYPYf9GDix9ydrA=
X-Google-Smtp-Source: AGHT+IHgA28g3YSCc6rp0DCCyi7xufJmrX6RMYy1KnpYmyznCbqvH1sbt2cix116kayzS+oeIsyPQgPd4y5UuGNqq8A=
X-Received: by 2002:a05:6000:e42:b0:34d:9467:d6d7 with SMTP id
 dy2-20020a0560000e4200b0034d9467d6d7mr8401009wrb.9.1715038566138; Mon, 06 May
 2024 16:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505014641.203643-1-cam.alvarez.i@gmail.com>
 <CAADnVQ+Y5k0XMytXo9CLGYDUnVNXcgtz+2mTLUdS-yWV7JDjeQ@mail.gmail.com> <43a0853d-e7f3-702b-e7c4-f360ae1e3a70@macbook-pro-de-camila.local>
In-Reply-To: <43a0853d-e7f3-702b-e7c4-f360ae1e3a70@macbook-pro-de-camila.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 May 2024 16:35:55 -0700
Message-ID: <CAADnVQ+eQ36rc8Ew5a4YfFbB0rgbJhXXwwgPASjFVQ7=QFyM1A@mail.gmail.com>
Subject: Re: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
To: Camila Alvarez Inostroza <cam.alvarez.i@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:18=E2=80=AFPM Camila Alvarez Inostroza
<cam.alvarez.i@gmail.com> wrote:
>
>
>
> On Sun, 5 May 2024, Alexei Starovoitov wrote:
>
> > On Sat, May 4, 2024 at 6:49=E2=80=AFPM Camila Alvarez <cam.alvarez.i@gm=
ail.com> wrote:
> >>
> >> The error indicates that the verifier is letting through a program wit=
h
> >> a stack depth bigger than 512.
> >>
> >> This is due to the verifier not checking the stack depth after
> >> instruction rewrites are perfomed. For example, the MAY_GOTO instructi=
on
> >> adds 8 bytes to the stack, which means that if the stack at the moment
> >> was already 512 bytes it would overflow after rewriting the instructio=
n.
> >
> > This is by design. may_goto and other constructs like bpf_loop
> > inlining can consume a few words above 512 limit.
> >
>
> Is this the only case where the verifier should allow the stack to go ove=
r
> the 512 limit? If that's the case, maybe we could use the extra stack
> depth to store how much the rewrites affect the stack depth? This would
> only be used to obtain the correct interpreter when
> CONFIG_BPF_JIT_ALWAYS_ON is not set.
> That would allow choosing the interpreter by considering the stack depth
> before the rewrites.
>
> >> The fix involves adding a stack depth check after all instruction
> >> rewrites are performed.
> >>
> >> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
> >
> > This syzbot report is likely unrelated.
> > It says that it bisected it to may_goto, but it has this report
> > before may_goto was introduced, so bisection is incorrect.
> >
> > pw-bot: cr
>
> I can see that may_goto was introduced on march 6th, and the first report
> was on march 13th. Is there any report I'm missing?

Could you please craft a selftest for this issue then?
It will be much easier to reason about the fix.
We can either add another interpreter to interpreters_args[]
or just gate may_goto with prog->jit_requested.

