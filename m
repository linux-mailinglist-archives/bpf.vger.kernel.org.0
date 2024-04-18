Return-Path: <bpf+bounces-27117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7508A947E
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB6B1F22B48
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594E76050;
	Thu, 18 Apr 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFlxowWd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24841A8F
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427172; cv=none; b=PFbZtTYnfL99JjCjqPbIBOrhKO0WWCutQzsi1KPm4M0AG+N1p0u+YGMsj7VyM+ITuOyKpPpRvTx5thZY/sBku3srM4tyIEBcwNTJq6sQN/UuGr9xJwDaconBhdzSv3O5nTEk1i3CVlUcipG9ApBHGgOt+oHQ85YERIfwq9PFfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427172; c=relaxed/simple;
	bh=XghVFOhSOXYtS0ZzPlbb1ffc7Q2YWLhi8qHOjMBw5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kurbynThkYV+fp5xLEP6V7fHKthQzRrERXybbFYbrqHgK31xxGGtVfbehKozhGIEQG3WR+7j6hs2JiWJhGXnM6Aw+J1Fc9MAvBVLMPLZ6hboRqnpl99Euq+6vm7uAVGNgKpaW7Rh10GLvRnUrKSnzyOWUUBDiqdjPdbwu2tNzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFlxowWd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-696315c9da5so5800486d6.2
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713427170; x=1714031970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XghVFOhSOXYtS0ZzPlbb1ffc7Q2YWLhi8qHOjMBw5n8=;
        b=zFlxowWd5tuqKoOzB84rDNRlEQjw28s1UWYAt5asqGcj8iEY9Ne0KY2R7lxsdFPe8o
         53D0gnBeydCeWH96q6lriHDpFxCJDTM7hJ+9LngA91XhiXiXhJq5f82xDaE2nqQmM2h2
         2j+os80CkRLsKzW6aPJi3SEZWhIWBBqEOMjtvQ47q1jCG08HT2amQtuk9qHa86annMp0
         PtWWwR5rAVT8PNNLQF/crAH5dSI5acYXdzFGO1P2QK2DhY5rkgnWcfS28bEtUhlB+5nD
         uD97OyXNKV3qMLog2c66SEH/EUaPLDOPUDaN51ZUbad2bnmhgcjPXksTOcjkcK+Gp9iF
         D3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427170; x=1714031970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XghVFOhSOXYtS0ZzPlbb1ffc7Q2YWLhi8qHOjMBw5n8=;
        b=rogz7aLOamhvNeKAo7TwWYBTGa5QCsJu99SRRRiJ++BJv/6GUnR0V94WS6mSBQ1okz
         0rb3TdMj3SSbp4Cy1ObePsi0J9W66BH2gE8UjpNjMBdKIpYtRZnlcz4W7czhHOvfMlKl
         GkF+vTltGZlkvp7ijRpNmtrdRfLq/QDiihqCUUSyhfs04mt+Cu7hDySH3xqE5wYQauDL
         IE3zoEdOpqutg8pZxjVHMxVuH525CYLJz7862GmmLdGvWiTBqMS/1QEP5JEwBEc3hAQM
         6O9KDYvAUnr060dVE3893K9uUop7ZYB+xnElDNw/Nv8oLvnNSbztgueLT5Y3xnVHtVXA
         sqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8KtgoHvZ2TsyAyv6rGeFMDAhiY/U6C77cWFuzspF1OhNf/iR2JnW8cWbSuwQOwiGamQLOx9aQqN2hHqB7az0fyxBS
X-Gm-Message-State: AOJu0YzDJY+DTT3TtOBl2lcroP6DM4waNNSG3uInmDPZipaq+griBPhY
	1ob1XQPE83BwY9AKKPuHUL+8p73nIzNSVeV5NKHyJMiBYNLLL4ORiNXtG+Qtt3q8CJCFjGjYo3k
	vOSDKlSaxclELINnUcDs3ztZd/s/Uf/MJm2v0
X-Google-Smtp-Source: AGHT+IGbcFRzLv6pomaBBc3XVX/IDYVa1Em//BE8YnIPhB/knIvodX6f6UaF9q+nacJvhbygoj0jKyZj5LFrCrDisKE=
X-Received: by 2002:a0c:f782:0:b0:69b:798b:e9c6 with SMTP id
 s2-20020a0cf782000000b0069b798be9c6mr2121417qvn.42.1713427170252; Thu, 18 Apr
 2024 00:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fe696d0615f120bb@google.com> <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
 <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
 <CAG_fn=Uxaq1juuq-3cA1qQu6gB7ZB=LpyxBEdKf7DpYfAo3zmg@mail.gmail.com> <CAADnVQLUXVV_viC7mmm6VaAyveQKMzibdCMpnUQdf_-3FdjM7Q@mail.gmail.com>
In-Reply-To: <CAADnVQLUXVV_viC7mmm6VaAyveQKMzibdCMpnUQdf_-3FdjM7Q@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Apr 2024 09:58:48 +0200
Message-ID: <CAG_fn=X-etq6NQOo70tDJb9m8RZ8z67E1imSqn-Pq1nYV7Ub_g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 1:52=E2=80=AFAM Alexander Potapenko <glider@googl=
e.com> wrote:
> >
> > On Mon, Apr 15, 2024 at 11:06=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > syzbot folks, please disable such "bug" reporting.
> > > The whole point of bpf is to pass such info to userspace.
> > > probe_write_user, various ring buffers, bpf_*_printk-s, bpf maps
> > > all serve this purpose of "infoleak".
> > >
> >
> > Hi Alexei,
> >
> > From KMSAN's perspective it is fine to pass information to the
> > userspace, unless it is marked as uninitialized.
> > It could be that we are missing some initialization in kernel/bpf/core.=
c though.
> > Do you know which part of the code is supposed to initialize the stack
> > in PROG_NAME?
>
> cap_bpf + cap_perfmon bpf program are allowed to read uninitialized stack=
.

Out of curiosity, is this feature supposed to be used in production kernels=
?

> And recently we added
> commit e8742081db7d ("bpf: Mark bpf prog stack with
> kmsan_unposion_memory in interpreter mode")
> to shut up syzbot.

I checked that the report in question is not reproducible with this
patch anymore. Let's just wait until it reaches the mainline.

