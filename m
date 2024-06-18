Return-Path: <bpf+bounces-32431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4790DCB3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9901F23DD0
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CA16D328;
	Tue, 18 Jun 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FSocZMz8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3516CD2B
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739888; cv=none; b=W7Cs9IDQhwaioTYwD63vkGUpOuJarmbZQQb7d/5Bz6B05HmnzAHOh3PuR77fW4Fdy/OXRZWJfNBcL8/dovi9GsJT9b2Xj+7KzAB4dKorkKJVYxwAktJiFjxb/0XjjB4fCBrIAFq4TBHOMigJqbL5rISDW4ow2hDwSV0apMlk7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739888; c=relaxed/simple;
	bh=VN547w+VN5o5DE8HvJwoLrfKRWnxFAxA+jTsnbyfBGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq9fikwfCfIoEHP+GGdm53FzQ9AKuYLTDEer17gLEzIgyrtTYRWL1GShuaSgYqUXEmpcT5HxK7OOOQR/nEYDvVhxWTzJNyS/4KM4sJZPTRf3dDUzbmm2eqSqnCCaRDweNQMfufcDX/03Gs1UL0Pn5hjLlwQHGFpmRdqs6BYVxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FSocZMz8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6312dc52078so61436337b3.1
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718739886; x=1719344686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM17wTy9/rRfZ8ThkdkO+gn1FlG9OhXzhFhng4YH2g0=;
        b=FSocZMz8jCkpT5aT5sI3sOfzvvkR1PEDcsAdE9qFY04j+ZRXsqMhcukEg2JQ8zs5la
         924yAUg0DyGmqCI2J6p8dy0CLoUH2nP1FoW4etBYpA0TE19plvFeMRlegOHUUllpe0/u
         JgvY+vJa+iM9oCAJzZIOa70sKAP7eHOeQqXUnS69QgszfwSr8lNH7S0znUTTynWKlk7K
         aUvVWNLFavkBflI79gP0N0bTGFkRV1OoZb5+EXumi/2X8DfhYGHboAswptLtldI7ezde
         0ibM1S2GlMyCw+bWTeYa7Yfiw7DY9ClG1YfhcqAXFS3HN8XOVBkttXRLw1wpQYI+L3nL
         dE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739886; x=1719344686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM17wTy9/rRfZ8ThkdkO+gn1FlG9OhXzhFhng4YH2g0=;
        b=MEHZercfzrIbyFD8xiTX5/c222v68V0fLcnODtS1EZhEf1waujn8NjGapPHLjfJkf2
         y7If5gRDnmLlm7c17qEaG93I6XfyZesNR+lBoar0fsADaNbl9NyWQN4+pMcbv+eYKL8M
         E3wUDh9V+nSwqafgDCWeuGnOkb5AvkC+Vih/pVHaCSXiLwVcsl3NCJkpHGoxp2Z9tKTK
         pThGpDfAxcLn061XT7+EW1Y5uW6qh47JlPv7oStVri9H67EwEYUTySNBtd8XVcqr/Z0Q
         JijwSqGgJRori0yicYA2Njkenukdozlir1tUcL+mALr/H+KPIrc+De11qpB4JEWYqCkv
         JHcg==
X-Gm-Message-State: AOJu0YxqjxmE+uXeiDKbnUEZqLNAvpd6hafLTNCEFhzulmH429d5UEKC
	YEcYkWYqIQquSzJHtyEg8YnORQhtkJtODtEiZE2IFU/LBoBeBC9/qTre1/6ABzZM5kcEpw5vvlN
	N+P80kAXvK77hrLYig9RE8DsOFifVnk67kYYd
X-Google-Smtp-Source: AGHT+IEK8Dtm/LMdflWvORsofjcPiKC+teg8B3fl6iBIXLr9a2xcHWfRb0owhtf0/w3ajHDDj/VarFLrnIWOR7HVMfk=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr8814347b3.16.1718739885749; Tue, 18 Jun 2024
 12:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618192923.379852-1-mattbobrowski@google.com>
In-Reply-To: <20240618192923.379852-1-mattbobrowski@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Jun 2024 15:44:35 -0400
Message-ID: <CAHC9VhTMmPC47A91NqazrR=RKwt4JxBMRbpsPowTqxQ06ZjgZA@mail.gmail.com>
Subject: Re: [PATCH] bpf: add security_file_post_open() LSM hook to sleepable_lsm_hooks
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:29=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> The new generic LSM hook security_file_post_open() was recently added
> to the LSM framework in commit 8f46ff5767b0b ("security: Introduce
> file_post_open hook"). Let's proactively add this generic LSM hook to
> the sleepable_lsm_hooks BTF ID set, because I can't see there being
> any strong reasons not to, and it's only a matter of time before
> someone else comes around and asks for it to be there.
>
> security_file_post_open() is inherently sleepable as it's purposely
> situated in the kernel that allows LSMs to directly read out the
> contents of the backing file if need be. Additionally, it's called
> directly after securuty_file_open(), and that LSM hook in itself

*cough*

"security_file_open()"

*cough*

> already exists in the sleepable_lsm_hooks BTF ID set.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  kernel/bpf/bpf_lsm.c | 1 +
>  1 file changed, 1 insertion(+)

--=20
paul-moore.com

