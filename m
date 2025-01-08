Return-Path: <bpf+bounces-48269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D512A063A5
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB9F161538
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DEF1A23B8;
	Wed,  8 Jan 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfBm/1Sb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3C25949C;
	Wed,  8 Jan 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358359; cv=none; b=b7d0l89XH3Dg1QiSl+APAWGLUCr0PmwFYzpt7pFteLK7AbyyvOINfy3Xme5B1uBTKz2Cy8hhf5Fbz6J+mn+lSYeYfB4dxofpilChM+ThWSXG5cB117iossHhSzqn2O/RynXmYZVce7YvBtbfGCkAI36raSOKY4j9KB+sSn376Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358359; c=relaxed/simple;
	bh=CntFd34V+ZehwA1bDAGud6oqD/tsVSgbkgAOGItU+Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLbScgYEwVPwUdy3s7m66/0iDfgoz+jD3bB+7YbrHNM18E/KfidRCruy5V8emCzYagH3WHONSheJJ64zVJKQk+W6chVzAhrfOARHl3j/XoqsHH5AvL3WJOqXHKLB51JyExcEQohG7edA5uQTZHnf355kTGvfag1HqxouBxbYjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfBm/1Sb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43634b570c1so862085e9.0;
        Wed, 08 Jan 2025 09:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736358356; x=1736963156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CntFd34V+ZehwA1bDAGud6oqD/tsVSgbkgAOGItU+Es=;
        b=VfBm/1SbsmR5dbV/9tp+k9FCYp7YDNzW3V8xGFQpOlwhcJ2eXO/uEwYdAnI6DZ8InF
         x3BrMwBAzs8KQ7XE84KHH37Aas+pvSxVhhyyCfPD3ozaeVL3VgFVXE1QU8QAbKXsU5sb
         Jw9JjwTfI7Kx3fFKBVE2bu56tqjzNLJL4VMEnhprg84qp6e9y1JdWCtowte7YC6jBo22
         3NoiBqIOgJ1yUjaRWlVi3MLcYdk5bsgAKGktKSVr8860iKP+ihz6fOhzHo1hBL6JW0EV
         OF8CjxdhRx7fL/YfzWysFYxDY8AUczOy6u9O4Kgo6N2ikMlvfgbcJD5D7EorSC49f63U
         d/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736358356; x=1736963156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CntFd34V+ZehwA1bDAGud6oqD/tsVSgbkgAOGItU+Es=;
        b=EumVb5cIjIeYb4Qlh95UH1Oxxz6NiAa0KvHz5uXmBnLZE6yyjAC7r2WRuQ4tW2P8mk
         P2QA25RE1F0fGZDp28ZW6QHmjhd4QOHlDy/AVxpgoVCKGPfkwtGTQ83YIWovGmgSTlkb
         YM+mWGYituBMcDXfEZPapu8Y4JeZayM1ZFqDTKkeXfWUohsr7Z2V77RsbPJBF7ZXNPVz
         Vn45f8VIx9x48tSL+y0XomsztCZQVlF0fH/ofQ4Qoq0ZfQAX3up+JlgHnP7s6UeBqpW2
         dFpt74iRWLN3VVYD4B73aaMwz3T7tOjxKdmRCECVFvx4ATGgvKYbuiEz4ydXmdgcqyNf
         D3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNNeUJClauN6yl3rmENVAx1TfYVQuTkT15dhP7szm0kLvS7ks2Mrm7vRX8cHngCYInCIE=@vger.kernel.org, AJvYcCURB1mybRQymJuNLc1Sgq9jDW9MWUfWSwyYY3wvTkauR7utzxNYfaDFO3i7ceaD/BfqaGknIQkh6ge+ljnO@vger.kernel.org, AJvYcCVAO+UhwZDCi6Dp1s9BIMzJ0e1MNmTGfGhU5xnkGAVXC7Rc6mP3RABGmkF452wrqARJPfn1YinbHLr38UaZFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHpj29Ul67xYROSbsfoIc19jSb9hlED9nEdlzdMRrolJKz4qs
	OzJKSbWyFSGsWjKHLEHdX3z6SjshGdRcQRoCPeUHGNKxjYCyV6tvjuN1/lZZ2tZlvNMuvhIBAEd
	fM45KXXY67x1FtrNkV8ZnCzaFn2g=
X-Gm-Gg: ASbGncuq1fAFQbf1uIk1+QubnhB5HrCyxCx+jsmBQ3Evxf9d5BaMdcpzHk8lPv+CRSC
	andZXIh3Ro7mYih2bOlkA1W+4edJhvRUmD2YdkdYS
X-Google-Smtp-Source: AGHT+IENYaJN9qJzVvS74XH6AptDhLta++2dMAjueUTCbMsr4OTDR6rI80EcBDLV3vhFQ2EURExJxkFEPfZHEixQvQg=
X-Received: by 2002:a05:6000:18a3:b0:385:f0dc:c9fd with SMTP id
 ffacd0b85a97d-38a8730dcf2mr3304762f8f.27.1736358356386; Wed, 08 Jan 2025
 09:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com> <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
In-Reply-To: <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 09:45:45 -0800
X-Gm-Features: AbW1kvYKPSAAqEJsfNmyLOCD7SVL_sAo95rJ07iFN2FuKSqH132N8xtEs5_kMIo
Message-ID: <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of sysfs_bin_attr_simple_read()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 2:30=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-12-30 16:50:41-0800, Alexei Starovoitov wrote:
> > On Sat, Dec 28, 2024 at 12:43=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@w=
eissschuh.net> wrote:
> > >
> > > Most users use this function through the BIN_ATTR_SIMPLE* macros,
> > > they can handle the switch transparently.
> > >
> > > This series is meant to be merged through the driver core tree.
> >
> > hmm. why?
>
> Patch 1 changes the signature of sysfs_bin_attr_simple_read().
> Before patch 1 sysfs_bin_attr_simple_read() needs to be assigned to the
> callback member .read, after patch 1 it's .read_new.
> (Both callbacks work exactly the same, except for their signature,
> .read_new is only a transition mechanism and will go away again)
>
> > I'd rather take patches 2 and 3 into bpf-next to avoid
> > potential conflicts.
> > Patch 1 looks orthogonal and independent.
>
> If you pick up 2 and 3 through bpf-next you would need to adapt these
> assignments. As soon as both patch 1 and the modified 2 and 3 hit
> Linus' tree, the build would break due to mismatches function pointers.
> (Casting function pointers to avoid the mismatch will blow up with KCFI)

I see. All these steps to constify is frankly a mess.
You're wasting cpu and memory for this read vs read_new
when const is not much more than syntactic sugar in C.
You should have done one tree wide patch without doing this _new() hack.

Anyway, rant over. Carry patches 2,3. Hopefully they won't conflict.
But I don't want to see any constification patches in bpf land
that come with such pointless runtime penalty.

