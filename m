Return-Path: <bpf+bounces-40621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AC98B07A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15491F21A90
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7F189525;
	Mon, 30 Sep 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQPXPWgk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDA1836FA;
	Mon, 30 Sep 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736564; cv=none; b=Jf150J6pCA9+6ftcKNyF0nKl5SphheDeLhdu43SGEWyvocS9B+Cl9Zx9qSgO0QVuFd8IMNoFmpMFZ5oSZI7PQ3GNXswxBMGUiSWfLqWvchy7VpEeUBmQv/RpaT9xIiHvja+9Ib6H7xplMZ1HAbkoO4B3EoEmUaorWHaYI2PcMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736564; c=relaxed/simple;
	bh=b1Ub7vjzXG1JxcuY8YrpRapQ3DGfAHgOWzWTrgrHibg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G64fEcR12DygDJ3i1ZlHV3Xl2SdwhUun64oAu9cxVZI6uUUejRgQLUS84Uv3TUFFPp5zlUb4x76OIShu6jjNzIEw2qTY5rIYWqoM0lgIbqe/JvcZMHN67BMD7KaJB3eNbMJTJvJ2vkHCUfOSeMBayqHI0XQ3DvKqwHzf0Z1shDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQPXPWgk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so2746406a91.0;
        Mon, 30 Sep 2024 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736563; x=1728341363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFCtZ4IVA2m1Lj5aqGv3zrCdBL7HWHsE7cae39370r0=;
        b=UQPXPWgklSk57GaMnaKWq6YLVS/gT7oTtTb9gCLc7d4GxapLxDo4TphR6AfJ0LOiCe
         NV8Is6salkmxhIThM9WnShKhk9TjEb17UcMdMz4lg2Mwe1vyj6AG5B9+B5XTvtgNXhJG
         9erERpzjLpsUtTr7t1jq2KKadUbzD/xKnNLwpKBTUXLcWw4Bad3u0P4GDhB3yYIXHnma
         ATq5kP2acj9JMRBto01JLH9/QAxy2YMrf2bmqJZRuN5CkJOJJaNAbB1fhjawPsGKTqVc
         bSWmBZs317SeQ80QeyschEKvRauL3ZS/ZClWZT8PFsH8tPT9A04SmqUTx1ULOZ85peZe
         Gs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736563; x=1728341363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFCtZ4IVA2m1Lj5aqGv3zrCdBL7HWHsE7cae39370r0=;
        b=jsJJ3uJWD8NOnc8bwdKIYyhNc3qS+pN18ACV6U69zvZhx2Qw/Hd4vFy2uzXQtExaXL
         hCMD3rMjwD+NDzqgphA+InuMpN4nk1pmVq3AZsAUbNWEtRueNcpBtppVnKmSkDYLghBy
         1h1tf3qQs/RrXZO3Ganzg9QKv9E6zGn6MkDQsssDOCXTvIaqm6DMAG36rTI3cCCaTtCT
         8Et7p6Jnf4crmUbzlPbHOoV33FkjkHXhHuQBLhJpoZ1556+tz+mD0OiudpvT2Qiz6Rqi
         CdV2ScNYS+9V5TTe7j3a5X9OicjrD5E1ud4gZKQn6naHgMdzmNsXtmW/UkbaYBPhPwsz
         4VaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEhkT7+Dws/cmK4pLCr96D2KncpGptolEtl+mObgV5W0SnCO9EbMf64bGEUR8WTfP+rlEx+z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw+PIkpqITBNFFR2igU2+Xu9q9wHWJjVcGLNZEuG7HMd0qt/P
	sKvFl4NJWst10sbcOLt70UPDPWP5RzO7mBpxTYJx/jNphmPDO/IwVsfrBRUmWrYzLSUpvYTtteK
	PYZlLCa1bgZ+vfuH26JjQcCwqC6Iz1Q==
X-Google-Smtp-Source: AGHT+IFuKB4zY5vTIwV7/54rW47Z9RPjZ6K1HqqDQaTT34pC/m4IY6rxI8TNv6QYbi7VkuUvcLURRq3CofTPSFZQMaI=
X-Received: by 2002:a17:90a:8c1:b0:2d8:f515:3169 with SMTP id
 98e67ed59e1d1-2e0b89a437bmr13524338a91.6.1727736562738; Mon, 30 Sep 2024
 15:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 15:49:10 -0700
Message-ID: <CAEf4BzbRMXmD2K3hku+UJEw61C3nnw1pJr52SySJLtXq5voghg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] BPF static linker: fix failure when
 encountering duplicate extern functions
To: i@hack3r.moe
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 2:31=E2=80=AFAM Eric Long via B4 Relay
<devnull+i.hack3r.moe@kernel.org> wrote:
>
> Currently, if `bpftool gen object` tries to link two objects that
> contains the same extern function prototype, libbpf will try to get
> their (non-existent) size by calling bpf__resolve_size like extern
> variables and fail with:
>
>         libbpf: global 'whatever': failed to resolve size of underlying t=
ype: -22
>
> This should not be the case, and this series adds conditions to update
> size only when the BTF kind is not function.
>
> Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for fu=
nctions and global variables")
> Signed-off-by: Eric Long <i@hack3r.moe>
> ---
> Changes in v2:
> - Fix compile errors. Oops!
> - Link to v1: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-=
v1-0-df15fbd6525b@hack3r.moe
>
> ---
> Eric Long (2):
>       libbpf: do not resolve size on duplicate FUNCs
>       selftests/bpf: make sure linking objects with duplicate extern func=
tions doesn't fail

please shorten second patch's subject and patch set's owb subject as
well, they are too long, generally we try to fit them under 80
characters


>
>  tools/lib/bpf/linker.c                             | 23 ++++++++++++----=
------
>  tools/testing/selftests/bpf/Makefile               |  3 ++-
>  .../selftests/bpf/prog_tests/dup_extern_funcs.c    |  9 +++++++++
>  .../selftests/bpf/progs/dup_extern_funcs1.c        | 20 ++++++++++++++++=
+++
>  .../selftests/bpf/progs/dup_extern_funcs2.c        | 18 ++++++++++++++++=
+
>  5 files changed, 62 insertions(+), 11 deletions(-)
> ---
> base-commit: 93eeaab4563cc7fc0309bc1c4d301139762bbd60
> change-id: 20240929-libbpf-dup-extern-funcs-871f4bad2122
>
> Best regards,
> --
> Eric Long <i@hack3r.moe>
>
>

