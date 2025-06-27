Return-Path: <bpf+bounces-61718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7279AEACC1
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21A87B22EF
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4926191F89;
	Fri, 27 Jun 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egmTbhbm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5543770B;
	Fri, 27 Jun 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990660; cv=none; b=WK+88+4VHnMUHJ+kle9bQzhnKzBnLLWfT4djEcZYbaHSVzgb3WBygDoGSk7Dy96bB2qWiLd8CL+G/84szxc2SwsLim49AI2r7pwu01dDneFDMrJeYVowhQDuTAokcXCu7TjXtFPpz+1wMJoBjSXN7ScQuaUIdYTEg7i+Ut76ZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990660; c=relaxed/simple;
	bh=6V8nhRdefhkJ5zpLgVnJaZ2+u6oFZCKcrQjsnL/ra8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5L0ZFB+UtNB+uqOj2NT1srWrNx9+Qt7iLhPEgeNpoDksIjKvCTeC+SUZL21HxkBRBYgLDWGjnbx78CAsYNJ/cCCLe9nbZoyGVDqagUjqNA/4WgVTrSySMsgdYscmIOcObsxAghCqPkHb3+j+Idiwx6I/Y7L+J2AGvhsn7G7wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egmTbhbm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a575a988f9so931009f8f.0;
        Thu, 26 Jun 2025 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750990656; x=1751595456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn2gI/3dfst+MEJuneR4iiTqAk2R7396Prx/FoAmbtI=;
        b=egmTbhbmxKdwe0ibT3qOdXzaC2HThjGBQ5PN3EQqdPcp1EWjFpBf5BzHxr7gN9QkhM
         lSbFgShuUVLJIO9yaK+znBF7NkYHwT0mczvMlzkqZJBCSpqfXaZdOyDMQz1zWEMFRnz3
         TGgBGkG97pD7qTAe5iyryq6kcDaR673NWplyjw6mHgvUPVu0Yo5mEPfeKUgpSc4CrMB1
         jA0I9gwU2B8s+E/7W3o01AtxnTVcwy+IGpEA4EsypCnHiWeGKxZyFTv2oXs5IGNdkT9a
         J7E/DJSozrOOJDgK0j6M5uMZZNKE4SxUYNIB6dybeuNcKgbH3zexV1UukoznVN4AGczg
         HZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750990656; x=1751595456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn2gI/3dfst+MEJuneR4iiTqAk2R7396Prx/FoAmbtI=;
        b=JvCoL2qcIi+jLYwPTWJKVqrGLRvmmYGGASXSQy8EbRSAoPjQpHbjSvdI5/cjNCPq5N
         Gwo9zBN1YzNcw3raWXwUzLjZWv8rwjMgrcPoupg9aYhdiqVxXS5X8dDCR3ehzs8o3Foy
         wnI6IsDEzu1JI3g1xGNsznz/C+Ryv5QbC4kRtDu3GpCpc72u0HOo3PpaAbWAEX+KPY7h
         7ZVGvfGi0JnLqLdLLoahLWnYD57WhoSRZ1jiHrREq3aTU8mKM4idy4NoBvUulfjk2F8g
         TlRiXrlvwmWUZIBxpZSH+VKJWF40zVjAdp+b0V1Y+qRUeugh92va36mvyRNJbMpUaqkb
         huLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIlDgjFNZX6qH42HnC1PBhwxRO7TogZ8wuxqg8aHJJMcmDGWI+zdd63H1fiwCrpqXH5qY=@vger.kernel.org, AJvYcCVRlfNr+xQQ/jdyOelM8KNgREc7g9AW/oQo/ROakCjXLD9CrSOQnD1E7j090RStA6cGcz10W6cCHpYAy/bx@vger.kernel.org, AJvYcCWz6/LHM4KBqT6tKg/VUR85lplOgLm05K6JdJsMBqJgNFnuHBaHt3L9k2WP0xwJLaoEs5ebxzja@vger.kernel.org, AJvYcCXovL52Qaks7AFMAIWkXsw990UzQ9aJ8CoNxrqM8gKnLP76zq2MNiArfwlHa2aDruQ/MWySEhK4tSOgmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqI2iwjeU9fsOpzvk2MSe3DhrZOpw0pwHg8kmnQqjK2LQWoWG
	S0txiCojvoZfplsGK/ojIe2ZP4Pg4QTF58q3yRBA0AunluGCz/4IFYDrO1zv54ZFm4idpJgzmMu
	ZeJZV4EYB8k7zxsqNdHuSdgdE8shmNKo=
X-Gm-Gg: ASbGnctT7XdZNbuJZfgmGPeoLACXrItdHbybIGjzJ17Zv0+dioyLF0ngl//kJyPmqZV
	ADBY6LFd57tMeP+nkT8ddwKeEGyJR6s7mfQwZBLm6ywTp+DJQea2hNCKvlSURLOSg0GJeQkwdYI
	rVABEx0blpxIF+PPRZVs4BaoBqMkrL5XeUwSETkuFgFER5/6D6U5KI39dNgpJ7gxhtqPq2IGY8
X-Google-Smtp-Source: AGHT+IE2MKCnXyEXatn+1v7zmEwzvFt7APJouIXo9tXLXDVY1OnZPhfs+VXXtMDsVTuxieWP3fZVO70t9t08XpJyYj8=
X-Received: by 2002:a05:6000:4013:b0:3a5:7904:b959 with SMTP id
 ffacd0b85a97d-3a90b9bfc9bmr1234289f8f.58.1750990656109; Thu, 26 Jun 2025
 19:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627121206.31048e14@canb.auug.org.au>
In-Reply-To: <20250627121206.31048e14@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Jun 2025 19:17:25 -0700
X-Gm-Features: Ac12FXwEgzgRlWLKS_TuEb3UyrZGzL4sLA755bo2s92uzjKkD1UTCsThCLKf8fo
Message-ID: <CAADnVQLo4-jSRh5J=tNeEnN_3Rsxy0zOGccYdfqe934+jteVjA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Song Liu <song@kernel.org>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:12=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/helpers.c
>
> between commit:
>
>   535b070f4a80 ("bpf: Introduce bpf_cgroup_read_xattr to read xattr of cg=
roup's node")
>
> from the vfs-brauner tree and commit:
>
>   e91370550f1f ("bpf: Add kfuncs for read-only string operations")
>
> from the bpf-next tree.

Our emails raced in www :)
A minute ago merged vfs's branch into bpf-next/master,
resolved this conflict and pushed to /master and /for-next.

