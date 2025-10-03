Return-Path: <bpf+bounces-70345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13089BB805E
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 22:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C076F3C862D
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0EE203710;
	Fri,  3 Oct 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ+eJWQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D017A2E1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521904; cv=none; b=JnL6QQVfc//qUFo/NR9c3XMj56M2GPpYfAahPe0K91IDkMASrRSSE0Gf8OjPWxhXgTzfmkZu7S7F90nL+1/yHyjxW4Py+1cmKM+h5/2gXYU47rxXxoE0g9h1oZWbWkgl8vtPO+5aFEqZQuR7S65ezRmaE0Be0HpYHXitbvdrl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521904; c=relaxed/simple;
	bh=oEg8tIsIC58HTMS2A1kpleh+25w35gugnGp9CGZZ4K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZoIGGpZOQMjxMx2hKehTLkmsoaJTdYg/99HdraV5vbZqKQ+n3E4nsiWX7Gx4QH6ZOXGtd5DUjVz6K4J6cb45ZPpUXmJwVslJgGwcwnfLu9BdUkEnqbZj1TMlkr7z6dSvaMoZoLVuj7HPkgfYaIVXnHaO6eBkUrJs6QH5kUsdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ+eJWQ4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso21516115e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521901; x=1760126701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QouYmczGicW3zQ/QltZkNbFY5oekMPlNP9t/krMeOKk=;
        b=BJ+eJWQ4c4TJaSfIbjfglqiVhqvTXp2pzGbrGJIijYfyI0ymJzpYilN8u/YJkxtEQS
         HzmSO2RWnipMIXZL/xarg1+qg6MTIoHl//YYOvt+fCVq1ioPRnoXdnrhcyBC4ocUeSAY
         unUiqXWV6r9XKLi/PiTWXnlD/SIxIeOqoZEnIpC48qL9ip6YorBEGQv83xtIy2b5BdGi
         tdxKGllKy+HRB/1JSUHNnvF65eVjxpeiZQbI98+IR1iSKWpyBvzTHwsPfI7NKPLvdyiE
         1pXzgDvZkPhVs7XIyliNAq4lGqWcmdgQeXQSGA7Wl5OLDkIq4XbnbhGtmAA3Q0Tzvy7i
         Aw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521901; x=1760126701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QouYmczGicW3zQ/QltZkNbFY5oekMPlNP9t/krMeOKk=;
        b=XbHU4CPVDRLzSrc6Ke+bVr4A9emNpKs9dkPtMdutqh5KgmattvoJh7xwJ0YI81+uJo
         xdd6lOChrL7EIfYqDAKqbHxPq63jkuexdz3fyH28qV5/we9Cebn7VQCt1RcMxdN45F64
         sQzAMjyzSxhWsNF6m8pwBzkmqL+wt3v8VWSsZa2PHtgMWNNVv5oGrHtxF1qHRLQqu4uS
         hdlwW4Edx/+rDo6iSoI2X71a8doysRSP7Z2DMeVMdkeD4qzclGZmh9M5EX0lnwlYFO6V
         JYAVVs1iEtGA1GRleO5qgLkDUJnNkMBFBGiZxbirNlZcS/l5U26BvaYF5uHOtTW1AZnj
         DtWA==
X-Gm-Message-State: AOJu0YxeOYcr6+G6GOaW/jgFu0VbaPk8f+4aKB19o7ICdY18NclhlJXN
	qraAzKMIP3aWpKJj7/wcrBGhoGQcyL+IxKFkGjTP6MbAFNXqhkH5CyXLOAkeUAmR10ogzEG56FQ
	/qhFUOIB7qQ2tL7kUnApgIajodCeuL10=
X-Gm-Gg: ASbGnctPBOwKs8nkJXFQOc99ffr/l9M4RJkBhEMLJrjDS4oZYhYBypiDm4g5dyhuqgl
	cUiR5zF9U5V2MVarz8QB+2AmzC1+4xD6y5RzM/LOBEdkFu98yh4A7BxwjxhKKAlU6359xYQZEqb
	Ju7r3EKxW20Ci/XnoIXLq5dOgTTH26Tu7q/KJNhtws6ipISXK1LQ7tNwX2bI7WJMcFjnoowY7Qx
	W0hxWK/e2uHR37BQ63Xzffz0pCpa8ekUhNOF2TC4iVNNqA=
X-Google-Smtp-Source: AGHT+IEwfBP1s7tm96NDtSRVg9hJhthQiAo4VWZuJMjjzWWF58pGiU6wCMKrGzowv5yyIOhPcSZcrrTiSpg3bqE2ssc=
X-Received: by 2002:a05:600c:34cc:b0:46e:1f86:aeba with SMTP id
 5b1f17b1804b1-46e7113f7a4mr38010645e9.17.1759521901206; Fri, 03 Oct 2025
 13:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-4-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Oct 2025 13:04:47 -0700
X-Gm-Features: AS18NWAgdMVW55UAQeXBhgAlv007aTSuS0a52zFSdcmrYgTWGSwZzzgzLghXU5U
Message-ID: <CAADnVQLQU5Wf=H4Y=Aywu1H24+6OhNg_tvqJALUd7F58wYBrPg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 03/10] lib: extract freader into a separate files
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the freader implementation from buildid.{c,h} into a dedicated
> compilation unit, freader.{c,h}.
>
> This allows reuse of freader outside buildid, e.g. for file dynptr
> support added later. Includes are updated and symbols are exported as
> needed. No functional change intended.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/freader.h |  32 +++++++++
>  lib/Makefile            |   2 +-
>  lib/buildid.c           | 145 +---------------------------------------
>  lib/freader.c           | 133 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+), 145 deletions(-)
>  create mode 100644 include/linux/freader.h
>  create mode 100644 lib/freader.c

Pls update maintainers file in this patch as well to
make sure that ./scripts/get_maintainer.pl lib/freader.c
does the right thing.

tbh I'd rather move it to kernel/bpf/ directory,
and include/linux/freader.h into kernel/bpf/freader.h,
since include/linux/ is for generic api-s
for the whole kernel to use. This is not generic.
It's dynptr and buildid specific.

