Return-Path: <bpf+bounces-63285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE733B04D9E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164C14E180B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34D2C08AF;
	Tue, 15 Jul 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBlh4Rno"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466D1553A3;
	Tue, 15 Jul 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544520; cv=none; b=YSXZRtlxOfrCeUyrbIEknuBknk7R16hgv4fGur2PMfB+hhpQ1QFaQB54ijobaOQAc0ODGN8ihQCT0LcxIpcGksn1BQySLJR3veYN6VkSRQdvrXzK/QU2GzEh/A0zwXot38X1Ru3uy5VxuRAJnkm4SM6++2WHGU9eS3xYCFQxTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544520; c=relaxed/simple;
	bh=DImRPRvxDgWbeCAzhaTtT7PrVBbubCPYG8h/cRXEM5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=may2rGL6z1hqwApBZtI3BurOzZaQMNuPhnCui50fCkKvPAW39jWetpU2g0CwH8JYdvPBxHrDCIxWKho9eaSKm356zJnt7ACaZWLr01PFbhq7hlqNaV09pN6u8nnGyANkW5ht+FG2szILwPAYx4/DorfWIu0oufdzBWsTwroP+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBlh4Rno; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso35404605e9.2;
        Mon, 14 Jul 2025 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752544515; x=1753149315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DImRPRvxDgWbeCAzhaTtT7PrVBbubCPYG8h/cRXEM5w=;
        b=VBlh4RnoD3RyMzxfOeys3xd+xQLaXZTJ5wmlsR9c8mJmYsrMZDxAMWn9FOxVli4oAP
         m7+itQ1GJlmVLLW2FkvBeB2OlRb9LU0koGASDLwfx0Q2QgkJRNsOveVhFbLfO58jKNga
         1UfTo93eJ52RHUCdzZxv2pk1vRK0XCEDGSTLll+ug3NXEVHe9QnS9wGA6l4jQjsTtWGP
         NKnaMbWL1OAbSce1Jp7SziMaNrUs38qqgJkdWz9OwHVakajO465lyxbL0TAp/JSuVN/i
         6bq39B454NGFKPo59kfvbsqOPwiIgRu/4ejsrQnf3ZO+m7nlJGImVRwpURT1dsMz/BP6
         TbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752544515; x=1753149315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DImRPRvxDgWbeCAzhaTtT7PrVBbubCPYG8h/cRXEM5w=;
        b=d8ocBhMNj2hZ4iaBIo9/6IoSFjQOFOq696yCFj/yfDHcbLL4v5AKRFatgWC03vcEop
         6UzmiJLwX4kawwJ4svIugKG4/0Qt73mC6GFgYXtrv//Dkz3HPj+GNRY8/oxYqPSmxx+Q
         ZLI/1rBtNmKSoB13071EJA5gPLToW/UBMB7R/dZWgkTnVX7y1OUzO1t/2/nixxxW+1nI
         qo0LZ4D+jHsOviKHCAAmog1HYw/Fj28jQEn4kyEDyL4TB7tEWKsFpLQ2pxgYvihZFn1c
         y4T5gvi2lBT4NKUQJGtsDsAMyMG+XsXv2znpSkpYemtQ7j/V+0nHFV3xKmwqMLPJAGaO
         Q3qA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfgZGRYb1xOuAoRqdhSd3WiGgd+NikzFRjott4TAC6Bpr64R80M+ZLUq5pOzAsYG6Deg=@vger.kernel.org, AJvYcCVAaybQ4zs9wo7aq24dkQMOhY5PZvlWd6p+hMDSTzuqZGc+pu2GX9dLrnhPKE2mx7d5K1IWQa0oG/ZvDj7B@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrxwubIIMyW/X+pxU0F92DnqTVnxUdO4FErcxBTAzENee8mBA
	ftQGIaVhVJC2liPF06aGUv+2Y1k/PnPPTfyoP+oPx49GyNDTLZ1Muc7fg8bLPX1CPd6XJEUiLk1
	743Cl8kXwAtcdS92F3k+ebFRyLPF4dyE=
X-Gm-Gg: ASbGncufMUfbPTJbQwmnHGik1MTArftvUwDIVLyfms1descGVjtWvSVnFsUkYV965zQ
	HAgjAEa8372C+4XM8VIIpCHnOfUuBWN2zF7/OMfRgSU67hFDhHDB8YFx4Br+JoBjGEad2xd7Ggf
	+/xrMVIFwbD2qkv9Q8GCyN1s5dwj7Ej8q+mTeHb/xFNjzZGrUl1nx5dmhO9GVEcgkrBZvGww6Zh
	v2AQ3tGHgaAfYSJKu7Q/rmaMX7Mh+e6iTipEtOUDcJ71lk=
X-Google-Smtp-Source: AGHT+IFLTddzqT4inSm+V4/Hitukugy3+0Ab3ec/Aoqe4dKEpEIBSQOMzT1lUy+egTARhVv6e3Gw2etp174yCmVKqWY=
X-Received: by 2002:a05:600c:4f94:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-456043ce1f3mr86853735e9.33.1752544514366; Mon, 14 Jul 2025
 18:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-2-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 18:55:03 -0700
X-Gm-Features: Ac12FXx_6JpR6UsqCbv8yKOCCE76HvgTTyK0ylrYchmBKjXP0_8q6HyDzUpsYxc
Message-ID: <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> We don't use rhashtable here, as the compiler is not clever enough and it
> refused to inline the hash lookup for me, which bring in addition overhea=
d
> in the following BPF global trampoline.

That's not good enough justification.
rhashtable is used in many performance critical components.
You need to figure out what was causing compiler not to inline lookup
in your case.
Did you make sure that params are constant as I suggested earlier?
If 'static inline' wasn't enough, have you tried always_inline ?

> The release of the metadata is controlled by the percpu ref and RCU
> together, and have similar logic to the release of bpf trampoline image i=
n
> bpf_tramp_image_put().

tbh the locking complexity in this patch is through the roof.
rcu, rcu_tasks, rcu_task_trace, percpu_ref, ...
all that look questionable.
kfunc_mds looks to be rcu protected, but md-s are percpu_ref.
Why? There were choices made that I don't understand the reasons for.
I don't think we should start in depth review of rhashtable-wanne-be
when rhashtable should just work.

