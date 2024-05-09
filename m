Return-Path: <bpf+bounces-29334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84F8C19E2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB221F239BE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C112D770;
	Thu,  9 May 2024 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUIz6Yqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45612D755
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715297078; cv=none; b=PjtN8qXtUjocIuSoimP6ScsQHDv5dGQV5/gVWxNO2RICU/RAygfFBY5/sSFh0rz5Zvmw4FpFCJUFt1onD1g1RcSl3wxk5e2KC8bUhK3sSLRZncPSKZ6SoFwSOkYNtEz7SVNlfX9NXuzpVHboxBLMIXpLRjgWdVjlaiKZtCk4bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715297078; c=relaxed/simple;
	bh=vgnAtuzVgt67Jx/gyaloRRQkrIp0ljld/vHnYsBUvU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sabUm9dgFxWi2aUKdvQhitcKIBo2obAl1vpp0r9wrVYyRcao74yjOJ0PMZr1gS1RJxQa9c4rN9D/r0KFt1KE4aCSCiK/ekt2FS5QISotR5nBQMX3xQbSuuQwOJC/vHSQc4ytU8y8gcXA7vHH30HtuwqWwCVnXWc32T1YFpknzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUIz6Yqo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34e663aa217so893285f8f.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715297075; x=1715901875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgnAtuzVgt67Jx/gyaloRRQkrIp0ljld/vHnYsBUvU4=;
        b=fUIz6YqosRRxGL35/EWzQXGjaGU9Q4eoxhjSKqIURd/Wst7H7lS2BhDPuDrcCFrgE8
         mUItWCaFq2iYVIcemeOqHXy1n7vvJvCumVz5Js4kW7EQhWbDFTNVBmr1sUCPhyXI6mEL
         0XVUGE3ZsVPe9qb8nn0LKgkVbAX+oUtv3/GugLLQ+Br9XPGLZiUHCYi2+/d6TYFey/C8
         ck2Ffqs/KVJD+BeqTRB05IoIrK/9iKaNpu4xnf/x4a5AOX51fA1OmI66TsbAKR4S3eLA
         8dW4b2wauqUaZ1b958Jnlt+8kYum62NsDLobd61594RfDk7IVIyAMYDU545qrrIRKOEx
         qE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715297075; x=1715901875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgnAtuzVgt67Jx/gyaloRRQkrIp0ljld/vHnYsBUvU4=;
        b=X/Av3E4A7JO15A81a80nIanL5CbXoxi5FW8lfL03qnQqxnyg79m+yMK4pwdbQ+qW63
         nkvuyJRoHo8/aQUnBKo3pysafXOq9Ans9HA1GNjF3keMVxLSnu5I0v8O2WMC9OO3rLqF
         4eDFkUoHoyTuDxM0flcnbP4GzqCs6Xnvj2oYaEr4w073ldpQZWEYhNQEc75u6ZDMjFa4
         D6yptekRPHcsollIARBpWI9Z7Bm+tGOCd6zZ5kLvQPjEVwYT/pOf/6O1mECm2MRd51j5
         p/wxPpAC0U0P7ezKKMfo1A5d4fO/EVBa5V1Ms6axMRsEkLLY6yBD46+VHU+T0NsbwJEX
         8BdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6dG2PqnrLDEXA9Lq15PcXQarpAzEdOcVNHH4PvDZxoISxL9tfwzCBv6enp7eEJp+2dhcSMTkJ9TaRtNA4sbJDDacE
X-Gm-Message-State: AOJu0Yx8hmGXQk3e0qjaK1WW/f0Olo0liejikd202Udax9d2fXdjg6CC
	7PWx8gSIKxMNeOhOyer/G42N9E0YurWfV4CUHFI+NsweRd/u8NVwyVDXA7290wRz444fMq16iNM
	Guhw994msc14RZXoCh1MkZsC2dwk=
X-Google-Smtp-Source: AGHT+IHyOQlvw0RHtfirqjA8DXvAkz9NkKdGyl4W657C3JJXSw9xV5If8IEnKkkJihYQSuqCxOSIpWDkJPnX8PHkiOc=
X-Received: by 2002:a05:6000:924:b0:34c:4c88:3c9d with SMTP id
 ffacd0b85a97d-3504a9688a8mr663021f8f.52.1715297075064; Thu, 09 May 2024
 16:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509151744.131648-1-yatsenko@meta.com> <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
 <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
In-Reply-To: <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 May 2024 16:24:23 -0700
Message-ID: <CAADnVQKUZtOjMKWq9OxmLVH=zShnOF7DNCmncK+qFkTpdRz9dg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:09=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> Nit: Most variables in the file are declared in "reverse-Christmas-tree"
> order (longest lines first, unless there's a reason not to). Could you
> please try to preserve this order, here and elsewhere, for consistency?

I so hate this nitpick.
I'll start introducing non-rev-xmas tree everywhere just
to stop this madness.

