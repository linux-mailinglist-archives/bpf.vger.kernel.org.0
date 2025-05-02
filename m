Return-Path: <bpf+bounces-57213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB295AA6F5C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8782F3B10BD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EC23C4E9;
	Fri,  2 May 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DzoasPK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1E23A99F
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181186; cv=none; b=QerK4B/HrmbPQRw/XagNmIFlRFXhmEfxL41RmBHFae95o/Fa6jeG/TGy4ZkF2qd6vfqngn2Su3kjQRB/4SpDb70v++VG+PUytxlxM+nYXHLUj7qdfdCYOpdW9iGwJ2ypITmp3xMg3g60DYNzVvB8tERFZrgIJH9uW16QDzQMM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181186; c=relaxed/simple;
	bh=rf1UbGG3UspPN/9brMtSukZGCz7Qty1bFnxHg1aKkvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lijnk7rOmBs7sii8mHRhZZHaSy8ht+GjMPbvY/eI6+HO7SHbJJCNdAD9VRiPXOu87FxCZvv6ldQrHeFOCEIzDnMAIHQy82XY72I3vf6OHUcLA0otVySO6O0nRvFTbmKnfBovS98UkJjRpTp9jzwDKP0mbcgjRyWmhd/XjIO7OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DzoasPK4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso1151102f8f.2
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181182; x=1746785982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=DzoasPK4sV7RwQNpK7n6mfIw5GhfzsJPvep7nqPwRSRHak2AZlHO9AEPAc2Sut1Gr/
         yLHHKZbRfVwUZZCHX740pkKXAchJS0/Vo6Tz5PtPbm36bNeF5TF+36KcPTuSbzg/vklo
         mZbEekfpVMElKZ99aw4ZH5UF+SZUN9psS6t5RqaABcBFtjSpaBRI5EaDiRVpTET85TK9
         MPlxSBq0cLLyMYpkRuWB2vuGN8XosL8RT17WV8xHzBZuB1+6pzZscnnQckxafjld9ZjC
         LxJ5hUIPEEZOrXiDL67b+ys88MVNwFunTJ+sF8fW7CN0jm6HuUz5sec7r+3+hngk+4qk
         HeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181182; x=1746785982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=sPbujOrCk8FWut5BtN0xGiHKqOAitFkrneaOOwQ4SAkPYEyAiugcHRDsPyoS+zYmEz
         mPzOeZcApNwKHXJgh4gQf0cP02gth8eFO105dax2KwTbXAT/Oh7SwWpVMb+o9I6zZNPa
         7UN5YE2XEPJVm17DrPPTDfHgbmeFDO3dtBAM8E+lCGgHRa5F2FCC5tlFfOPhrQKPziMP
         pCBBJnkW83+cbkCsApyjTlwaqDO7wETZFWe7/yfXz3i7Un10g+0wUlx8H7J1jwnNfX42
         nfKfGr1UO+iJGlN3VdLRTOTsDWJU0o934SCNBGtNhd10eeJKDvUpaXXQqyscRYD24jv0
         0Otg==
X-Forwarded-Encrypted: i=1; AJvYcCXNUbWURO+yYv0JMMADuw2g3Uitx8/oTzJZp4C6++M9BLC0jiqB5X+PTVJaHNZ1hqGKUIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCp/aH3MPojFMLDoZDKwokGJ2osduSqEdXawPXm+dhuh+QDhj
	7aaEG6hWGLkURLDN5TV80sYBKbAX4opPxisLGE+HsXRNBMbbqyYe6aS28gKHdDyFo2NMulbSH+Y
	e2/6QHJyFtCq0tieOzYxf3Fn4YEGuc0TfOqLZKg==
X-Gm-Gg: ASbGnctK3hE0X4GmI4yOapsLbe6jJ28ZK2Gq2gwkkl4pCxZeTp0Ol8SMxWiLgtM+ENs
	g0hBt27QPSX0AZfEqhwqWGInNGdbc7/tsinzBMx9YkgqELmK8r7HmCOgGRz/oBRM3R3vSeMcqTz
	lK+DSiwHjRe8gn7fAl1wHJ2Zc/6JwnqRtPrhM=
X-Google-Smtp-Source: AGHT+IGc7/7ZFHGC09Y6oPlxiiiAyWXOIhQLSULd58hpmnRmxebelvil7hczjMUB00Kr9zZDZNhsc+5+jzgD4fz6cfI=
X-Received: by 2002:a05:6000:1a8b:b0:39c:1f04:bb4a with SMTP id
 ffacd0b85a97d-3a099ad1b70mr1701591f8f.10.1746181182606; Fri, 02 May 2025
 03:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
 <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com> <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
In-Reply-To: <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 11:19:31 +0100
X-Gm-Features: ATxdqUFBpdbdrog4Z53_JyxwTJC7G2efSJ-kkbIOit1-1PBgRel5uCzelrycCew
Message-ID: <CAN+4W8hqyi+MFS3975stXPWOxfMtdWQXPFnuvSieFzReDcV0rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > +
> > +       return vm_iomap_memory(vma, virt_to_phys(__start_BTF), btf_size=
);
>
> and this one should probably be vm_insert_pages().
> Since it's not an IO area.

FYI I went with open coding with remap_pfn_range since that allows me
to avoid struct page.

Lorenz

