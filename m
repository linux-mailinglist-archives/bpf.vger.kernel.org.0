Return-Path: <bpf+bounces-71646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78EBF9241
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC31519A6F44
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C32868BD;
	Tue, 21 Oct 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkWa2lCS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805121C16E
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086772; cv=none; b=cvK5ejFziwF0YOOReTwX2soGDpBl3UHogompC8S7zoHyIu8dCZrt6BkNhmWLh2XajxNpwd4+il+wsjF2uhLpYC+8ds9Q1AQMvYkUXt+Zxh7bZZ/wrsWjUQDzpqIwOs6iheXTDcpO5qOMqt81/lhBrY3AfmnEAiB7mqg+rMnbW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086772; c=relaxed/simple;
	bh=8Yi4wsLUGlj+LPpx1ZxCTrQv3laOqZ6rrsLk5GaysiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcukpyceCy3lmRMeYvbnCu/uLDSKqkFFqdigjXRd0IF8MyNwvqr/OgyAKw36OCk6x7Y49hiSFF5m6SgYqBHxA8fMpNBgZV7J3URjdZsLQvaRQYlkmrPkpCszMeSD6P/hGlRG0EBnzMiPHpmKfxYsTEZOL8xm9nKa5wFH/IbkDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkWa2lCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C6C4CEFF
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761086772;
	bh=8Yi4wsLUGlj+LPpx1ZxCTrQv3laOqZ6rrsLk5GaysiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VkWa2lCSvnjE17/tgS81wePAfHecfhNG11jPXXED2zGzhsqK11qdo5tM9HSyExuIu
	 4GulW1WNX1wFBoWOK3HmLy/167BS1R0dVCp4lO4V7KbcokjawBgKd09v9zZ/VtGl9r
	 ym4FWaEehbNfIBpNgTi1KghAYO6tWIT/nXxEW932SFrIms6GfR6UP99T5Xj9UXj7ef
	 oryBeOSqy2zL1WtUIv5Ken1IngK3H/k2/zeuxa9+YGbo12vPZk+mPi7pIWSGvRzH2L
	 Jhys/puKeY8EHi7zGtXPczkrdd0EjHzEb1oKgLJGOtfc+/Ddi16JJGfmuGfFeNzuVg
	 DI9whryrlWG2g==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-795be3a3644so51171986d6.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZWtPpufi44i0+4XBdGgGKfLHMgB9ZoqFSbYV3gyMSkK4vdzYZbStTAh/PXO67kwr4J4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTk3fIKaFATR0D8CsB20whlVSleA+tstoSQ727iTqR3LM7qkC
	SFE5ti18HqFSnuLzNkffMjRqSf2+oXoH62p/no7dD63gqmOlRbKUrTeh4gxVQ0qI3vQ+wTwp1Ew
	EU6VWu7K7EiE8hVEK7eIy5r7QEPRfQHQ=
X-Google-Smtp-Source: AGHT+IGbJZonn9gqagn6gyi7iThd5ydwZkXgp5pIwGP34sdgmQ0t/Jmt6mgI+v0Edn839t8DPTWZKlLDZX0KMS6lYes=
X-Received: by 2002:a05:6214:1948:b0:87d:a372:fd3e with SMTP id
 6a1803df08f44-87da3918502mr159614426d6.56.1761086771180; Tue, 21 Oct 2025
 15:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
In-Reply-To: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
From: Song Liu <song@kernel.org>
Date: Tue, 21 Oct 2025 15:46:00 -0700
X-Gmail-Original-Message-ID: <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
X-Gm-Features: AS18NWAItVFqwhj3RByyGzRKQfVCYO_ER0xdHoP_gZ-DIxoEtoXTz3_jzN7jFVI
Message-ID: <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: don't use cached metadata in revalidate for cache=mmap
To: asmadeus@codewreck.org
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Tingmao Wang <m@maowtm.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:10=E2=80=AFPM Dominique Martinet via B4 Relay
<devnull+asmadeus.codewreck.org@kernel.org> wrote:
>
> From: Dominique Martinet <asmadeus@codewreck.org>
[...]
> ---
>
> Reported-by: Song Liu <song@kernel.org>
> Link: https://lkml.kernel.org/r/CAHzjS_u_SYdt5=3D2gYO_dxzMKXzGMt-TfdE_ueo=
wg-Hq5tRCAiw@mail.gmail.com
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Link: https://lore.kernel.org/bpf/CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4=
a4dLYixnOiLg@mail.gmail.com/
> Fixes: 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for uncache=
d mode too")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

I can confirm this fixes bpftrace and the reproducer in the VM.

Tested-by: Song Liu <song@kernel.org>

Thanks for the quick fix!

[...]

