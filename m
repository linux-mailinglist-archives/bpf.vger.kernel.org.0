Return-Path: <bpf+bounces-57251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3184AA77E9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4488C3AD1C5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDF2609D7;
	Fri,  2 May 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="LpRdEPgW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E72550CD
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205186; cv=none; b=f8b5P0iDUWK4e4cyCy6V4qD1htpDq8rEVDfClSdog6bWtK2XRcEJz/DGrUvwxi8/287hWe5AM3S60Mctd9sTK8aaK11aEd66YCaPp9R7ILnBcX3nBGdmCDOT5S/HQgZpn21rMGjuwDbG3FjIi1H1cULl7RB75HKYmjkLWELrU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205186; c=relaxed/simple;
	bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpPQj91sCryXIGmbZKFiglYDpzz8UaXal73oCJbtPpjfZ1gnNXlycBJ6d9wvPE9pdelCLX7He4FpyY9Hc3bCcbe1p9w4Av9PzquGOai+IFvrJ7quUmReQaxs1wAA/vnqx9y6QqSRopaYvViGmWDHRlw5baBGmw1I5o1IKCl3pdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=LpRdEPgW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so410404466b.3
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746205183; x=1746809983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=LpRdEPgWlB6s6mEgbQYv1mVakO6ZU3c2+JS5WACTf8eqN/nc+6azvWIwFbBF8KGfzs
         DNr5kTk4R6616KIdfOGXHXMgBk/Bc9m07sY/nGnIlyce3xWKYlh3oFDo0GJ3rhKj8g6I
         qLAuwzo9/c3FrN8HN4ZKb6v7o7LsGBzyttqUg9wKqhH6fkrn/EyB0tpvGNhxEsvrTD40
         EriVIyVv2oRYvTv8yqu5aC7xZSndFbvvW3rPYG/byFei0sG3Oc/DgbfT10LpDEoi4Iau
         enCxUHmlHB7J6Bhy/Feq6OOIuVIrXdjHkyJ8hWJszFXcpQMSgz2s/Y27Jnjgbg9koP1q
         CBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205183; x=1746809983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=qmw2nI93ZQ72ty6ybByeAiQz9M2+OT5OWKoZ2DtaFLlbdImLRvvP+CT5PSZqkZauGo
         ONYKNvNlxcJMeIpaB8V8LcwDqpEBM86Ea8GcNCWLmByrEORLIAuer5uiWlHF39ukjKM+
         bvzngJFQnd/k+a1RYcqTquVEwbFeceXbXieBPGhUvj4cjKVwSyMy2nl4ln9GIHs/NA/o
         3gNnwYWNItQ5mAOYbJYXAtD1IAXqJz/85DLO8tyneG0sVKBbqXJ7cLt/pr85/xaJScrr
         lRIn4JeW4RpalLB9rR+/gZVkxl4l7/+Hhcu0NoOi/3DjIXW+mOIpb/WGMPETt69fjqZh
         edKw==
X-Forwarded-Encrypted: i=1; AJvYcCVMFsZgdJ7g7CrL0zQiOtX+7ivlImwEF199FdVqLCNxnxcd0dCu7vtFTqLErmASvKXrZts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyap2F6fG4wkKr1TOonqG8iKXc/XIFsJAbmnmyEA7Gjl+QjR1uk
	jFCvdj5Tm/kHd4FeOh8zEavHgpathkh/lhyX+uPhBvd2QP6MpkGVKDyWuL9OAkk5kOTYCkByVCx
	0/z573TcQ4uXu4y71L+tffF51lLfQP+WJ8/B8QAWWMrkQ9u5w
X-Gm-Gg: ASbGncsL9pe7xfGEcJyLPZd7GfdDVJbhMUFtx10+PNv10/uqBDJeMOXKrabnane5yrI
	TiNvwyM1pUDiHzSTjLbtZkv1K4yBRDO6bptZ0PTXY3xnpXJk2fLDa8tRl6BaPT77DlibEWhF/ZA
	UH5ovXnSyUcgLq3p8DrsVJEvUnwIIy0qEotY5a3p0rWZdIGw==
X-Google-Smtp-Source: AGHT+IFtImagR6Lqfgo7XIZ1wWl2+tLkZnQp/pTB1oR1k0UzDInmGHhqpcROEep6B+1QLhfQbASn6A2YAzPAFuoWbdA=
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:b27a with SMTP id
 ffacd0b85a97d-3a099ad70dfmr2371455f8f.23.1746204815370; Fri, 02 May 2025
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com> <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 17:53:24 +0100
X-Gm-Features: ATxdqUEmdXYDqO_tQ1hPoaj8fCjwznGA5fXIlAwLRODgYtT6LMxPzFPPx9AIs8I
Message-ID: <CAN+4W8i0CB+gYcBNyWUxAA+=89Q+nMFopxKUF3nt1+y5ATaNyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.

I just realised that there is also code which exposes module BTF via
sysfs, which my code currently doesn't handle. I'll send a v3.

