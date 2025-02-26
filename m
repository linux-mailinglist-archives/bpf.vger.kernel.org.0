Return-Path: <bpf+bounces-52609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBBA453EE
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66553A62A8
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ECA2528F5;
	Wed, 26 Feb 2025 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx5KcwKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D372528F3
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539957; cv=none; b=kKXsTAhe8CMdpL2ovLtS839ljgwnDsX8BdHa/oXbfW2i5z4/wtgWugW8W9nVhv8CXq1IydgpQYuo7N4zDcL/X8CTRnN7hS6POWdLvZxwbMjrV7NmSawjrh5i+VKl5QMTq4aEPRrA7XPVz/zxcIfFSgfmPrb7F4yKrK1qolAcNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539957; c=relaxed/simple;
	bh=v14tD/JON5R2X0O4EJrmLlDuR77rju1FWkOgRQfd2K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koCfwXzbIVFw2gwpfiw2/w2c3CzyeKeADIB4yJfJEZr5qnCfGbXlSY56OXU79NYxr7O4IiXT/zqIuUDCos6oTJxCYCEo70ceDNafOMF+WevXYAf6/CjTITl8uLIIV5FBPvNYCAaRBXlE/kwtAZ5or8h6l4ovpMAmRqQpRtoeivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx5KcwKE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3411464f8f.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 19:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740539953; x=1741144753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTsvWqSe/qhH0xBPnQdhZM7dB7kKjGTpxhLaO57s1Jw=;
        b=jx5KcwKEV0xAFrZZePNOkpMjgLobBkXgDGActA55swKgAp5RKMM6HXtbq09w6199PC
         2hS2/zR6GUlTBggxKHHaSRhbkYoRxuTkYrWyZ1gkra4Ry+d7sa/SvIVhv40Cpp5OkzoG
         qL00nE+hNBLIdzLJy1NTI1qeszsXnPSELu3YY3VJvvn78+VD4QG1DNfBUnMYvx3Y+yqq
         PC0GFjVWGKX9xFItfn9733UmKEtqPPuUf+ILsC3DMAvnUTNAOgI9RX0Yo4nkE3Mp2T81
         fWYp2zhYs8/Ps5Bft3BujmK0oQ/vtOq9YcCcOgY7IM/kWmuFeBylI9MxOR8NNahJABhp
         xfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740539953; x=1741144753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTsvWqSe/qhH0xBPnQdhZM7dB7kKjGTpxhLaO57s1Jw=;
        b=Mop7olFdlBaPhu+aBDRuEygsu1E2OfNNgVcn0Uf7N7PiolABexX5zxkizfgTMKsk6l
         lL0m8C/vhQv+1CqCG8funTl4wcZGO0w7nF1BrbUMWCgcEXaT9pdKcdn3yjRkLmY/azDF
         bXAW8rLf3x7sUNM35ct1Upib9LAlM2XkE5GiRQC2hzvKXO8KijlDd/jjx509ofoeDVhT
         J3++wHRE4AryKk4YS4tLBXM/QFQaZCm4NxEg3KDiAI48+ncnoKoGDHVOuKlEiBh7tR2i
         DGly9zfWDIHmxM0HSIYz/6SLI3ZDzdWkmBJI5SaQUXrtsIhgCfS3rb4x46SwSguoLt6d
         odmQ==
X-Gm-Message-State: AOJu0YxEzF7VZpEG1ewbKYpjGF4Y05OPPf6ZqX87TBZg/ft3gc5GmwWq
	cLIFC58K1id0+HtIZu2p41tNlSgxHoEjPREO12Nod9V0/G4fddjUzlfL04KxUX7GAqioDiaZbGL
	95FjPVyhnNysuFxLQikPSGDs9KcMqSg==
X-Gm-Gg: ASbGncvpLErX+VG8LpWJ1pO50APfFvaaFi0pOjo4zMjVuYt3sd03DIOZVOK2pZ28ECt
	GOaSsdMgYNNV4nBhJCXIe/ZRCrLia6/PQYGUH5fP83GIg70ch84L8cv3ihkvoOCnZ+bjlK4mvuO
	f5bweikKCOFOsR1FJLjFPE7A0=
X-Google-Smtp-Source: AGHT+IFRxXibRw3dde0JPefqEwxnx2fwsRP8A89fC0gotgcAx3tl6e30nS55YPVwe8RbfnowT6RoDtuNPUT0vfm1VtA=
X-Received: by 2002:a5d:6d8c:0:b0:38d:e61a:bc7 with SMTP id
 ffacd0b85a97d-390cc63235dmr5482586f8f.40.1740539953230; Tue, 25 Feb 2025
 19:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 19:19:02 -0800
X-Gm-Features: AQ5f1JrizlwnWPxzKzuU5w0moccY9lgw-xyRCi7LXX-J7xAuhKiWgDe8RwpNu6U
Message-ID: <CAADnVQJbPKMLN-RBK1wTOEvmcdNssPmOmDqr0mPvrSOXLSLRYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 0/6] bpf, mm: Introduce try_alloc_pages()
To: bpf <bpf@vger.kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Hi All,
>
> The main motivation is to make alloc page and slab reentrant and
> remove bpf_mem_alloc.
>
> v8->v9:
> - Squash Vlastimil's fix/feature for localtry_trylock, and
>   udpate commit log as suggested by Sebastian.
> - Drop _noprof suffix in try_alloc_pages kdoc
> - rebase

Looks like there are no more comments.
I'm going to apply to bpf-next soon.
There is always room for followups if necessary.

