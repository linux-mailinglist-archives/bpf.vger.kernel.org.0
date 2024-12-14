Return-Path: <bpf+bounces-46987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE559F203D
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 19:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B86D1887C25
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C7198836;
	Sat, 14 Dec 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhePiNSN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD057194C78
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199436; cv=none; b=cy/jKP02y0xLEUYj7FvbgqOPsBwZJZ2MPdPfm8DHs2mNx6lUke9yrHvz2pTjS2rGCgSwDROPpE5tDryYN8oExaF+qedFdtsq519tMuu/Bo+1F1H7POlpKgpSIQcdV5IM2MW7STSjoGcH7L0AYR3qT0WIWeAHk3qIt5FFLr4bH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199436; c=relaxed/simple;
	bh=URUF4szk+eqhD/jJiVupH/dQw6IsRQJa4agyWYEk45c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2orn+4tKnRXxtMPNNA6nfRCitc5kPgI+YzJDPcucFfA8K9yxiNzq3prvz/KgFsQHM332yPJCfXKeyz4O+32bJ+J3dTrpnOOeunujfuxjWUch7nQpcbGJLrT6ZKq/mJ2WQGpbdBntmNhPFjyD76crJIz9nux65sEiTGwxjFWNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhePiNSN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43635796b48so5304465e9.0
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734199433; x=1734804233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URUF4szk+eqhD/jJiVupH/dQw6IsRQJa4agyWYEk45c=;
        b=dhePiNSNkEQoSJVg4k+m0GhN7CQyo4ux2QUpES9zbl642tY95LWwH6nO+EiMqkg2xC
         UHBzfTG64qGh89DAXq1FTb3KCTX9/Mq+EA4U34nKUIH6oiutQej7JonE+EX7dz/lbqGk
         GMV4dkePVEP5eebuL3xmBJnH68JjVE5BtAFts0yQZXBKl9SIpdYdRaotkq7je0UOcERT
         IZn2YORm0eKaQRZt68rQ7dOxpBUNUglnt6ckdXymkpcq9/9GaeqeENqUDHVUI0jXYIXI
         oGc2j26UMypgCEaLcmyBHHx0v7kJU40gKgFa2Cou6C9ZNn6/UBBZMrG+U5XHDePpUmLZ
         LJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734199433; x=1734804233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URUF4szk+eqhD/jJiVupH/dQw6IsRQJa4agyWYEk45c=;
        b=JoP3nX1TtwfHGozA1GGuZTBhFLv1iZy0dq67ARVo38Mxs1gt4V2CNwjpLs59no6b9E
         IpS5QwpBEWBgAaF5odlrFv8eTNr9QTYzchx8cM6xofsOD/Gyr/ptyNNHpKj1vWHp2yG9
         O3s61t8z4Hq2mVp/cI3JBmWvw18iBGfIw9zjOgwmUw1NroT8b8H31y/rqNWOEPkhWgL4
         G5dLR1vYBO3jOGy3fMKAx2+qeYo3Otnn7e8VehWF404yZESvDOHXRu2Lr44slhZ6agdp
         xU+x/Dhj9ilBcf5AcY51Lr7v24glc9xl9u+Mk91dxzLKQ4UllyhAuRMbMHMiGfpr9lRM
         K1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN06Kcfv2OCPgbzMEdNun5gt5qAMegI0ZwvjafCmljqyGJVB/4obVT8dP+VbrFFKLoTBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoe920RiCCF8StCCk4Z0ufHxPPPGrekNRAaE+8m6KW+R48hj/0
	sBJEOSmzuwNrLbKD8MJx8bihC0CTsqVJlSdphgdklGYmUtxSBF1jb1oljhNfrtyV2ZckMq6HPLY
	jGCbNUuCD3tdNdNJGDvF+5+HALn8=
X-Gm-Gg: ASbGncv7mTe1p9TI1BDXO0ue2b8N8GUvwd3FTeE/KHq6VLUYCpoHSOn21vp63oUF3bp
	kBSr6+FdGuz38DOX14zNnfEGMzS8pogBfMexQpvXGIPU7eXiOfxZwizv/CE/hLkaBCV99ag==
X-Google-Smtp-Source: AGHT+IGeB3OBOo3lu/enif4Cyhf6HlRR/RkGAxFizWWusay85wc2seEicYwqeix/fKA4nwaAKLtSERIRp4Eyv/JyU40=
X-Received: by 2002:a05:600c:1c09:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-436230bfd93mr89414095e9.9.1734199432835; Sat, 14 Dec 2024
 10:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEZpjGnsuA26Mf9kYibSaGLm=oF6=12L21X1GEQdqjLnzQ@mail.gmail.com>
In-Reply-To: <CAPPBnEZpjGnsuA26Mf9kYibSaGLm=oF6=12L21X1GEQdqjLnzQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 14 Dec 2024 10:03:41 -0800
Message-ID: <CAADnVQK1=ofB0x90bcwCvFhCkX1sbAkfmDASKr1q3jq6zSOCuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Avoid deadlock caused by nested kprobe and
 fentry bpf programs
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:59=E2=80=AFPM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> BPF program types like kprobe and fentry can cause deadlocks in certain
> situations. If a function takes a lock and one of these bpf programs is
> hooked to some point in the function's critical section, and if the
> bpf program tries to call the same function and take the same lock it wil=
l
> lead to deadlock. These situations have been reported in the following
> bug reports.
>
> In percpu_freelist -
> Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1=
pP9AzJLhKuLQ@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy=
0MuL8LCXmCrQ@mail.gmail.com/T/
> In bpf_lru_list -
> Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=3D6A7KKULdB5Rob_=
NJopFLWF+i9gCA@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OL=
JJYvRoSsMY_g@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_=
oLk6qXR7LBOA@mail.gmail.com/T/
>
> Similar bugs have been reported by syzbot.
> In queue_stack_maps -
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.co=
m/
> Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.com/=
T/
> In lpm_trie -
> Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38@g=
oogle.com/T/
> In ringbuf -
> Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.com/=
T/
>
> Prevent kprobe and fentry bpf programs from attaching to these critical
> sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
>
> The bugs reported by syzbot are due to tracepoint bpf programs being
> called in the critical sections. This patch does not aim to fix deadlocks
> caused by tracepoint programs. However, it does prevent deadlocks from
> occurring in similar situations due to kprobe and fentry programs.
>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>

I've decided to apply to bpf tree.
We may need to whack-a-mole a bit more files until the resilient
spin lock is ready, but this is a good stop gap.

Thanks!

