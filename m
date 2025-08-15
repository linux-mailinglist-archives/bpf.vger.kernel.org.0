Return-Path: <bpf+bounces-65711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCEB278A0
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5973BC66C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 05:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371C29B793;
	Fri, 15 Aug 2025 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH8PRcbW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1690288C81;
	Fri, 15 Aug 2025 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236573; cv=none; b=p1v3oKLidKmjnksJDv6wb4ZTV1NSPVEaHZPI33R2vZDrjzCheLdOpTnPdYOz0En36sPrhMECmebwcW0sszgDfAJFwWm+pZ5b2AtqvbRY4i0rHmAwf0bGt9ypBaGluYCWWdagEgMnjUNuOXdy9bz13xd5nGq1W9BUNDKyygQE60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236573; c=relaxed/simple;
	bh=Q4YQH6cWJsZz4qinVDbwYOaB+pWn6a03uleW081a7Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWkCQDu3pfJ21IMk7epNSWzc71Et9yFXILeFxu+CxqOQxTBL0uLUMC1WbUk9+cqP6jpKlleNGuL3AKTfVAt0jh9HxT+urT89+X4zZqc2t3Wn+LqyqYj9NwUxmp4R105PpxT/6Mm7506uQmAiBM8PAq2qOrs08iK7J6jr/h3Zd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH8PRcbW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so8467035e9.1;
        Thu, 14 Aug 2025 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755236570; x=1755841370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4YQH6cWJsZz4qinVDbwYOaB+pWn6a03uleW081a7Cw=;
        b=JH8PRcbWW5WjibmNZK44nb7SITTK19yPfR85e2ayhhaZwoT89JTOp9jMPE/baAETdd
         f/gP3s6NWmgtJnqHn6/p+hikgtxnVmPS6UVEMDEuP30ZUW0VlL8P0QmWVSzLsCdFSxi6
         0nTJhLs7mfc+Ili0qNV81dAXOhJdjAuunFYYjNnsw/frkuqisM04Hptj3is8k3YWfgiG
         fOHNoe/sMWw0gjUawgsT8JOceivvpbC8a44XVIpNeWOz6wvF9Rax+qkbQloC1CCp18pP
         f1Gg4wYs3w4VCkY0ODiaZKAAFGzILmGK7+bTO77/whebctCwVyXvRH1ISSHf8nnMnGlP
         GpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236570; x=1755841370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4YQH6cWJsZz4qinVDbwYOaB+pWn6a03uleW081a7Cw=;
        b=PG9L6fDDtG/CbZIVRYY4MMwu+U0xUrVWCQMYpA8bTNmqrKWbcVVfixJ9qTGPDujOCw
         m9qp/aRXfQwax8aOuCy78MJAvc4mZnElRLjZGBi9Irw91JblarKNytWBrHIhpAsXFjAI
         3731iNsezpb/CaieKSgQoa05vQ0cuPPIChZXc8njNmXgVFVyA7ZDCVM0o+gYo2NGLEle
         VaS0HnK6kpHRxtU+tZXU2ml4maRs5ljen0e9gTmPt/1zaQtyhKMdznAJDy8PlrRVuYLc
         xAkKSjTzp8n7s8ZyeAkuGchTZXukeTDoeViT74C59qWnQ1xS14gq2Qqm3G42YWoTP5vR
         RsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWKjWTvA/7NRLROuvlGtCJ3HYPGoNHooOZnaS6Rn6rID/p1QG6hkHRyIIptZWUgi43cM=@vger.kernel.org, AJvYcCXupfK0leRxdj6CfBMOt8tdKVKCu/yi0KDteX0/kyTZaiSojs+kFBXZEVZOV7s+iHVBEa3slFvcSmJq6NyL@vger.kernel.org
X-Gm-Message-State: AOJu0YzNA7EchEtRGQftRK6Lm7XwDYYH0FHRdqD6yfCS0ZFj+9khmTav
	dZ7/E9Vip1NfcjdsFGYo/sMagS86ZqX8Loc6I/XWkQwBSMNNpZHlZr9QkJWFaDZwsRTkTvF/l3g
	+7RT8n8kSFYNloXHY+nNMtWE5aB7NB70=
X-Gm-Gg: ASbGnctTCW4kwaBfyw4vXQRKSPQw8AIPl1gaDbh9Miia34J7Fu3J5Pxc4mZFkFguIBr
	FfZo2aQa5VLgOOX1GYo5EvQUAifYIfboaEgmDwC704kdjMS7V28zVox2iJuHDd6DZJczqSc8ZNa
	etQP2q3WI9+Y2jNP9tgW2RmxwgO9W4LSGbeSzYFiC7h5Or0V/bsPqkVW/VdwYIZkrEpHpHYqU9r
	sNe
X-Google-Smtp-Source: AGHT+IEM5O9amfVROz+7OGGTTqnSXOHJpVrvUbEZswP5wO4Djp2vAuChMXi4xtsyz5T8Jpuu1JhpHFBPP2PnmzT8IOI=
X-Received: by 2002:a05:600c:1d25:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45a218001damr7771305e9.10.1755236569971; Thu, 14 Aug 2025
 22:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Aug 2025 08:42:39 +0300
X-Gm-Features: Ac12FXw_UHa0ImOo-HDwZnqbXlrvBiDx98NWCB9sSLIboZlng6gipQuw5tqV4IM
Message-ID: <CAADnVQLyahEsFereM_-Y-MUdWm2mLHNKfffwNKX5Fvy+EaH-Nw@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>, Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:17=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi!
>
> A while ago FineIBT started using the instruction 0xEA to generate #UD.
> All existing parts will generate #UD in 64bit mode on that instruction.
>
> However; Intel/AMD have not blessed using this instruction, it is on
> their 'reserved' list for future use.
>
> Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> will be called UDB (per the next SDM or so).
>
> Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> had to switch the hash register to EAX in order to free up some bytes.
>
> Per the x86_64 ABI, EAX is used to pass the number of vector registers
> for varargs -- something that should not happen in the kernel. More so,
> we build with -mskip-rax-setup, which should leave EAX completely unused
> in the calling convention.

rax is used to pass tail_call count.
See diagram in commit log:
https://lore.kernel.org/all/20240714123902.32305-2-hffilwlqm@gmail.com/
Before that commit rax was used differently.
Bottom line rax was used for a long time to support bpf_tail_calls.
I'm traveling atm. So cc-ing folks for follow ups.

