Return-Path: <bpf+bounces-36354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924BD9471EB
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A0280EE8
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 00:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F10110A;
	Mon,  5 Aug 2024 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy34lnmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB0197
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722817932; cv=none; b=Wo0bJWNIdvnPMo6e+/CFIq3+ZTgDZtLaSDjaptUFK541mjzAnuVUBYmelcGlFsTwcrjScWRk0fJSBItNG/BLXwaghjxTjE72W5mdfFj5mZv/KwuchFHTPbjIRrQtkZz74I4yywKKqA6hU0kP2JJsexSfrYUH/lx+q6G19IZVwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722817932; c=relaxed/simple;
	bh=D0xQgUarIhAITgiA/24UCCiIfjFMUpeRBjW68Jkv3+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWs0+MW9uxvngxvN3WU8HE01Iw6DKicp+TKI+OwnQ1dtyyIMltipi5p7vLts9O9PAorMp+iqZwFIBcUcK7tjzH1uZzIG2s4vh7vo8XdYKJeYmgxBcGrdLAWrLtnW+jzLMshXaLbg9Y9C+Vspcwunwq62ZGb6LIk1r6lMvGQPUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy34lnmE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428141be2ddso66919915e9.2
        for <bpf@vger.kernel.org>; Sun, 04 Aug 2024 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722817929; x=1723422729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0xQgUarIhAITgiA/24UCCiIfjFMUpeRBjW68Jkv3+k=;
        b=Xy34lnmEl2eUcpDkrsNaYzNsOwxDiBiS9ZLct3HIDyYefZk6+JOF8OXm1NoFvHgamm
         tj/4bKH2NiZcF5jkVuFKB5cA78xghsd6Pm86AgKZE1BbxxGKlKwsFGVNsCk3FYwoa1m1
         +O+HvVWIVRuYckk1+d7MWcdTznAVO2VCaDXgSEAPc98Hd9WNFsgBiAoutwCbKyLzMb7A
         QdGPCMv14smQ4kdeqsO9BeAEQuHMtu0UHKUj9gVshCzVuaiumnsN7Whm2Zwqa9aUgnkZ
         J/uJ4ZLjlSiRmrg5jBGOD99nw4sAZKrgGRnzAR+flZFo1ipUhdD8rMuLUOOk5TNtfYOn
         FzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722817929; x=1723422729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0xQgUarIhAITgiA/24UCCiIfjFMUpeRBjW68Jkv3+k=;
        b=jrbhi3s9U1MUaND2afejLV2v+4k4DfU7Haw/5XCG7PKRrVfRLjBtsBgmieG9Pqcevq
         VcXS9X7wIE7227DJeg6vcTJu8o6HljgSNw3ea9DmyCyWQtlFo5QVuSWnCttaffg/u5CQ
         sa9bW19ozVk40wSYGh5GjjGlc3cqwjBi2RwK89sAT9umeUp3lBY4PgXbZY8t7wIONk8y
         VlHOqX4zBBYWFxHw246NRp/tospiwuF1wF1nQumBJLGarDTIKVZYiwQ3WKNrtFgAfTzx
         Bzh71gdpQiw6AzdukrSSN8B/IGYPasx29X3EcKrmcgyWFSpEg0Iz2CBClunsJWLKgzMD
         imVw==
X-Gm-Message-State: AOJu0Yyk+rS3c4JDW3GM9lUXGV0jtkZtq7EBwXi8hH3svBpglnzt4KFY
	rEo/oNonkoLf+XszfGmQyE5eyzDKV+ddIM7SZ8RVQA08x4yV43Z3VU+t9MC2/Iq9m+1g2iT8m6o
	z8rjyovMKBYw3D24uQC/09F/buhNaOmO4
X-Google-Smtp-Source: AGHT+IG/tUp72ALZLDz5ZoaVZeWX8dh4e8S8nWFYVXryhApyB+P5jNnD0ZKrO9ILwr6Niiy88d+p/XfoebvrXkVRgY8=
X-Received: by 2002:a05:600c:35d4:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-428e6b81ca4mr72262035e9.23.1722817928795; Sun, 04 Aug 2024
 17:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5i2ggshxbl66rm7jiy2fbqg2s5roiqjq6fv5u3pswlxodz2xw@cn47hrarvapn> <s2pee4ycr6u7jlpp2y4zibmwtqb4ak3z25zvizlgfgrez4dpvm@27bbxbskjxgj>
In-Reply-To: <s2pee4ycr6u7jlpp2y4zibmwtqb4ak3z25zvizlgfgrez4dpvm@27bbxbskjxgj>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 4 Aug 2024 17:31:57 -0700
Message-ID: <CAADnVQLH62GEB+uwjqqUa+uGhNyvBsDCFzQkyK2rYr-G9Ubtcw@mail.gmail.com>
Subject: Re: BPF arena atomic example not working
To: Jose Fernandez <jose.fernandez@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:40=E2=80=AFPM Jose Fernandez <jose.fernandez@linux=
.dev> wrote:
>
> On 24/08/04 09:59AM, Jose Fernandez wrote:
> > Hi folks,
> >
> > I have not found BPF arena documentation, beyond the patches and selfte=
sts.
> > I'm using the arena_atomics selftest as reference to create a simple BP=
F program
> > that increments a value atomically.
> >
> > bpf: https://github.com/jfernandez/bpf-playground/blob/main/arena.bpf.c
> > userspace: https://github.com/jfernandez/bpf-playground/blob/main/arena=
.c
> > common header: https://github.com/jfernandez/bpf-playground/blob/main/b=
pf_arena_common.h
> >
> > I'm using the 6.10.2 kernel and libbpf 1.4.3.
>
> I forgot to mention that I was using the latest clang release (18.1.8), a=
nd this
> turned out to be the issue. The arena bpf program loaded after I used cla=
ng
> compiled from the llvm-project master branch.
>
> I now realise that __BPF_FEATURE_ADDR_SPACE_CAST flag is only available s=
tarting
> with the 19.1.0 RC:
>
> $ git --no-pager tag --contains 65b123e287d1320170bb3317179bc917f21852fa
> llvmorg-19.1.0-rc1
> llvmorg-20-init


That is correct and sorry about this footgun in bpf_arena_common.h.
The cast_kern() and cast_user() macros were added there only for
selftests to make sure the kernel part of arena is tested when llvm is
older than 19 which is likely the case for many bpf developers.
The cast_kern/user() are obviously unnecessary with llvm 19+.

I think we need to create a common directory/repo somewhere
with ready-to-be-consumed .h and .c with various algorithms based on arena.
So people don't repeat your debugging experience.
For example I've copy pasted glob_match() from kernel to bpf prog and
it works:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Dare=
na&id=3D7fd6f96cc80ac8e1ba2838bb1570dd4aed81c567
More such examples/samples are needed to realize the power of arena.

