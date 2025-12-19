Return-Path: <bpf+bounces-77161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BFACD07AF
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BA16303883A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D537349AF5;
	Fri, 19 Dec 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iF3Ryhgz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1XeyXQ0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CED1DED57
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157672; cv=none; b=KHrod78q1R66U3x2oXZfgIqVIuRvv26iNltC4B9ryRTtv7WcFbeUp4ofGx3eqayCdxwffGTK9CbQ09AsgMQ+P1y3df99Ad7ZJbmPL8GM7Lz+CKFkxwy3c8KDRsHXcdbPqQeFQbcmnFP9sStYEB6vRgMlkOA7JpxY8wi5AdwnI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157672; c=relaxed/simple;
	bh=9IImE2hSXJ/4EvWqXVGrUVzVQ1/uCI+Op22+KXGSARQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0TiLjqWHoDcaKCDmVdFdoDnaIkrG4Ox8lZHriGkonN/9W6jBFY/rgVllAMKqFDZESV3ZiEkO9NACevJK+2vGnB6kQN2bjVMW+LrnzzZXkOp1EHsXjC9yHpGZwlOFODyuqxwmXWZ3BGfw0GRQKjk6UcicKmMpAtJcxU0Cd109vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iF3Ryhgz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1XeyXQ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766157668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GNrUURfSmzebc65djIow5Kw9CK6Frte1+TYEv6Oem4=;
	b=iF3Ryhgz60aLdo8yMQQtFOY25g73GdesCFen8gn2kC+wfoUueCsAOJze/eB6fKE+iY2PJW
	CdhPOI2FB1ck6zGs3MMa/h4eu6wYznzxPXFCQKkd7jvAau+z008biFNI5pn+A+aFynYUvF
	gCuJJPMw7nECwr4Kedm3h/NHrpWAklA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-8V-P_eY8OFmV-kKhdhVW6w-1; Fri, 19 Dec 2025 10:21:07 -0500
X-MC-Unique: 8V-P_eY8OFmV-kKhdhVW6w-1
X-Mimecast-MFC-AGG-ID: 8V-P_eY8OFmV-kKhdhVW6w_1766157665
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so2410170a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 07:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766157664; x=1766762464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GNrUURfSmzebc65djIow5Kw9CK6Frte1+TYEv6Oem4=;
        b=M1XeyXQ0sbrP99SGosytZfheJi/wlyOCugQX5VCN4ZyhpKYhxu08ZqmgFWg9xFuJLB
         ZmK7wLrEPG3Nbd+mYuhxNnET7bJ/XxGcxcOSANkT35jf4y3XGRrF5+MdlMQ87QkQHzcV
         PenQlgoWFNjueVSkvu+Dqc/BegrNqHFvKVdPhxocRsOylE8rVKk6il/vFX6mfrSyrMjW
         a0uDGYC7OSnhlmVyU8otk6/voMycK+y+U4T4UHlaqw0AIinHVasrP+eXgmJXbF0NgtQc
         SXEUJ8+H3DloboLe0NsERXMI7+ecdIOTaEmgAGHs7f7GqiSNriQsVqbeyJKHzwcFmJCG
         vPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157664; x=1766762464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GNrUURfSmzebc65djIow5Kw9CK6Frte1+TYEv6Oem4=;
        b=mnN3fXHA7t+XCr2zFGLonNrDAiBD2EofdzKUWMNBk4CI2guxBWxZlHT2D9rHe+myfF
         RaXDORlyE/rZuLLowDxAXv/MTijILusRk9WYTidzx/D1z3Rmlhay+Np1ZUEU9W1zvrQO
         5kyelwUiJiZSSC60pRKFvkrSj+9Ru6gPIQP3F9fYEROP66gzTZwgu+tYNhUE7KlGFngK
         CmjJ1Z4613C7xCmg7hnkCTJhjydPmUZdofMvZqyrHeOKs4Ymq5oahFvSFZ5AyKWPdAxU
         qiUgnv/1eFCcgoEkgxpCeM0MmsscQiMeKrF2LFLsv+LmgYl0Qd9glg1pj2msHIKXoTRO
         /pfA==
X-Forwarded-Encrypted: i=1; AJvYcCUIpGZUs3eT64XyrTugaX1frRO8GgUaIT5YgjiS8v6FctpD2NcMu1rZ8pGnqoERfWzORFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDXNAOJHHuJQmoDi8icATSloCQq+3TxAqCKJujI13WODfjbmB
	cNPcaUCld9SL51RoBzyWSEYV/PhVf5nwyjidGv+uC6oYW7BHeJrnC6pL8SMO7HKDsqMN3uDNv+m
	D4hbG0LO1ROHAZC49S2Jsfoc4TSxcmgLNNuoEJu9Lb1Yk8DmUtqTHvBjRlsBKWPEnXm62P454dg
	4Cj877xzTFFhcIOSw1mpau60U807tt
X-Gm-Gg: AY/fxX5aWgHfZMCFGORTo3v8JNHpafsW0GBO6hH+RlB9SidKHQJNRUilcQepGOSIdaD
	QQqnUmgBjhGxgjzZfcD8n9PNN5jAInL9Oo2sBHrHfKJ56gr+EdRvznxI+P449x+Bne4y2AJHGAQ
	2mECKdkpi/DyUa6IgLXIMzwzwBloINeuHFuBNvT6eWAmHwoPkrBK90IUlGg99STTNp4yJyin+Z2
	v+b5a8=
X-Received: by 2002:a17:90b:5547:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-34e921cc010mr3005040a91.27.1766157664001;
        Fri, 19 Dec 2025 07:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFEpuejWFp7fSKwerVlVcCgXqrnYOoWHQGcUkurutrqVKPcESqG+rFzqWmLZAKiKvlEuJhChthrKgtuozV8HA=
X-Received: by 2002:a17:90b:5547:b0:34c:9cec:dd83 with SMTP id
 98e67ed59e1d1-34e921cc010mr3005011a91.27.1766157663469; Fri, 19 Dec 2025
 07:21:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD_bPKbZaEHmKzVcLPGJuR3Y3MO1AJDA0TmLZrLkCJ0PzCM1A@mail.gmail.com>
 <CADxym3b=gBhefPMUCeiE_H0WPbG9AuL5tGe_6gsCZ8wi1ifJoA@mail.gmail.com>
In-Reply-To: <CADxym3b=gBhefPMUCeiE_H0WPbG9AuL5tGe_6gsCZ8wi1ifJoA@mail.gmail.com>
From: Jason Montleon <jmontleo@redhat.com>
Date: Fri, 19 Dec 2025 10:20:51 -0500
X-Gm-Features: AQt7F2qqt-p_zldZTjyDB7sjira-h7NBbmxMyRxRQLiF0daePQk2q7cGbnDUSYo
Message-ID: <CAJD_bPJyCZGm5zBhnB_tfSkFjn7BgeDMgmTuRNDsz24F73ofWw@mail.gmail.com>
Subject: Re: [REGRESSION] Cannot boot 6.19-rc1 on riscv64 with BPF enabled.
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, ast@kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 9:52=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Dec 19, 2025 at 10:36=E2=80=AFPM Jason Montleon <jmontleo@redhat.=
com> wrote:
> >
> > When booting riscv64 systems with BPF enabled using 6.19-rc1 the
> > system produces the following panic. I tried on several boards and
> > they resulted in the same error.
>
> Sorry about the problem. I have sent a fix for this issue:
> https://lore.kernel.org/bpf/20251219124748.81133-1-dongml2@chinatelecom.c=
n/T/#u
>
> And here is the discussion about it:
> https://lore.kernel.org/bpf/CADxym3Y098836fHHRSjeryxCp=3DCPB8sDU19TBBVs07=
VZOERJXw@mail.gmail.com/T/#u
>
> Thanks!
> Menglong Dong
>

Thank you for the quick response! I can confirm your patch fixes the issue.

Thanks you!

> >
> > [ 5.380583] Insufficient stack space to handle exception!
> > [ 5.385986] Task stack: [0xffffffc600020000..0xffffffc600024000]
> > [ 5.392339] Overflow stack: [0xffffffd7fef7a070..0xffffffd7fef7b070]
> > [ 5.398693] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
> > 6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
> > [ 5.409302] Tainted: [W]=3DWARN
> > [ 5.412271] Hardware name: starfive StarFive VisionFive 2
> > v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
> > [ 5.423134] epc : copy_from_kernel_nofault_allowed+0xa/0x28
> > [ 5.428718] ra : copy_from_kernel_nofault+0x28/0x198
> > [ 5.433774] epc : ffffffff8024062a ra : ffffffff80240670 sp : ffffffc60=
001fff0
> > [ 5.440997] gp : ffffffff82464ce8 tp : 0000000000000000 t0 : ffffffff80=
024620
> > [ 5.448219] t1 : ffffffff8017c052 t2 : 0000000000000000 s0 : ffffffc600=
020030
> > [ 5.455442] s1 : ffffffd6c2198260 a0 : ffffffd6c2198260 a1 : 0000000000=
000008
> > [ 5.462664] a2 : 0000000000000008 a3 : 000000000000009d a4 : 0000000000=
000000
> > [ 5.469885] a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000=
000003
> > [ 5.477106] s2 : ffffffc600020070 s3 : 0000000000000008 s4 : 0000000000=
000000
> > [ 5.484327] s5 : ffffffc600020080 s6 : 0000000000000000 s7 : 0000000000=
038000
> > [ 5.491549] s8 : 0000000000008002 s9 : 0000000000380000 s10: ffffffc600=
023cf8
> > [ 5.498771] s11: ffffffd6c419bf00 t3 : 0000000077ab9db9 t4 : 0000000011=
3918e7
> > [ 5.505993] t5 : ffffffff9e9bcc29 t6 : ffffffc600023ad4
> > [ 5.511304] status: 0000000200000120 badaddr: ffffffc60001fff0 cause:
> > 000000000000000f
> > [ 5.519221] Kernel panic - not syncing: Kernel stack overflow
> > [ 5.524967] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
> > 6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
> > [ 5.535574] Tainted: [W]=3DWARN
> > [ 5.538544] Hardware name: starfive StarFive VisionFive 2
> > v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
> > [ 5.549408] Call Trace:
> > [ 5.551859] [<ffffffff8001e438>] dump_backtrace+0x28/0x38
> > [ 5.557262] [<ffffffff80002462>] show_stack+0x3a/0x50
> > [ 5.562317] [<ffffffff80016d02>] dump_stack_lvl+0x5a/0x80
> > [ 5.567720] [<ffffffff80016d40>] dump_stack+0x18/0x20
> > [ 5.572776] [<ffffffff80002b7a>] vpanic+0xf2/0x2d0
> > [ 5.577570] [<ffffffff80002d96>] panic+0x3e/0x48
> > [ 5.582191] [<ffffffff8001e110>] handle_bad_stack+0x98/0xc0
> > [ 5.587765] [<ffffffff80240670>] copy_from_kernel_nofault+0x28/0x198
> > [ 5.594122] SMP: stopping secondary CPUs
> > [ 5.598070] ---[ end Kernel panic - not syncing: Kernel stack overflow =
]---
> >
> > A bisect identified 47c9214dcb as the problematic commit:
> > [47c9214dcbea9043ac20441a285c7bb5486b8b2d] bpf: fix the usage of
> > BPF_TRAMP_F_SKIP_FRAME
> >
> > This commit reverts cleanly and when building 6.19-rc1 without it I am
> > able to boot successfully.
> >
> > A copy of the trace, bisect log, and config used to reproduce the
> > problem are at:
> > https://gist.github.com/jmontleon/b8b861352e7b9bc9fd3a93d391926dec
> >
> > #regzbot introduced: 47c9214dcb
> >
> > Thank you,
> > Jason Montleon
> >
>


--=20
Jason Montleon        | email: jmontleo@redhat.com
Red Hat, Inc.         | gpg key: 0x069E3022
Cell: 508-496-0663    | irc: jmontleo / jmontleon


