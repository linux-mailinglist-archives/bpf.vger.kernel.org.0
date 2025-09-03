Return-Path: <bpf+bounces-67362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E765EB42D9E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975335E0FD9
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9C2F9C3C;
	Wed,  3 Sep 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb06azAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21522E175F;
	Wed,  3 Sep 2025 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943363; cv=none; b=mNDPnbjVk0rMnYokGbV6zF0e/VXoCbXRTh+JvZxB/vGDuSfQykwG9PR+ghQMXpedG92jN4BOj8PMT/N/Ve22mlln/PpDkEG1NRogE2ezMMVS431UcUHf4V5OL9DDemAccoRY6oyQY+Nf4+La7iDoGRRnJKAqdoE3hQJr1ezq4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943363; c=relaxed/simple;
	bh=1e2VPBJRb2SumtHWQng7eeyZ6tzwVUcxphTI4n8onhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0eFZbGnm6RqrgJWD0IGcggNCpB9Rh81NPJbACKFIEt0Y9aFd3zEN+W90Kopgaid8F9dW/Fbcv4fa85vu66tLKrkrPPW38hHF4x+JY0RgtDyhl7q6i272axoZwMR/ceBG82G0oMgKOSYOiVJHhP/JL9LaKB4b8rmbCbiDmhXS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb06azAp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96df7ff20eso622278276.1;
        Wed, 03 Sep 2025 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756943355; x=1757548155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e2VPBJRb2SumtHWQng7eeyZ6tzwVUcxphTI4n8onhM=;
        b=gb06azApK/FuHb/5BaHQMutJcuqHQ1L7SqYvB39NugxxGj1sh+NaUlNi4qVq0vCmMp
         /OHQrNRVS8xvQvonexGmTS+PC8WwLOMZy2TBNsASN7TDv0J14lLiG50YfuOkj/CJ+Z+B
         YxiupC8SH2mdyqWJbcblgl9tw7/jz9Yy3TIU5kYbkNOLRsgFoOWlX8L28l9gY3GFxZNg
         4eNqhYMgrCMRQjVqbntGMmXfoVgKJZUvNuGhDRKgcR+IgfVYnpmhQNZAzCXHb45uFI7r
         6UnNoq/BtJtH8rINTZ/tImv157kUPWJ7Tm+evhWSMvD+/bwUCRSijYbiaX3C+V+CrrOv
         potg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943355; x=1757548155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e2VPBJRb2SumtHWQng7eeyZ6tzwVUcxphTI4n8onhM=;
        b=msPIUtPccPXkBBJJWo87byYYllqE/X8KjmVx5a7fD5N7KqaedKDOvZadTFT6ao5JHQ
         51bdTWXWs096pVthQ5BMpe8hS6XyvD94YfD7Au+76Ns/tN+TWw/HIwUZn5faAiBslS0a
         mf5bRPAsFyJJN0ZrECn9EhxccPi3g3noBC/Qg5WMUtBDAtVkfwFuU0Yu5CRhaIPFOTYK
         td1Lwsz/qGiCrqdj1FXuwiTea1+2jCasA33pAiiVTWbgCqCMN/w+UgYx3KrWILKDCC4z
         cIEYpIj/951Usfm2B6FTkU8+U+za+1M5ECgLzkSzlxXwjz4v7Qt4Cz4lgZ/3ZhuSy5gu
         X8xg==
X-Forwarded-Encrypted: i=1; AJvYcCUtQlV7KPkWqN/gG0anEQEQawA/VzNnpE9ljdUuR9/b9eJxJ4xQLj/5rB2JKNkVuOs7fXaw91u8ggU9lLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdfve2IhtAOc6siATZ9vJNcJ2nAZT/5N2fkB5GgPa8YdjolJ3s
	AES2VxXdY1YEi1OQN4kHqA7GDsjds32hP4wXLRH9VrIT2lHfJJIvmbGxY+s2wjhAy7GzeTuqo5l
	tJ4waiBxTK/3p8nLGMLypIV+Qu5rmdIs=
X-Gm-Gg: ASbGncsttxCPACjTXRahnc1s/2ks/OSYEFYbjyNqT1F2NNbiTaXACSnb4wGiUy8gejV
	esJSTmrYSoL451qMLfUZmes7UYXAkDY4MG8OhLROBO3JJIPZFC8lFGCKflD6ZbMvWcNVkHEGAzK
	+upJLr9HglRyl9KUfzGvaTOfjL8tnLrmbtUtqz1TYwIuqtFlqZ42x74btzp706Uq6Fm1JCX+UpL
	28ane1C60aQJ1dMrjHZaN7LVWV5+A==
X-Google-Smtp-Source: AGHT+IFR5rjRPWaWR6TzK5ZR33n5riqyaFR8yS53EHckWUkRYUMnCYTVZjaRuxwmE+RqpKQGXhocaeE2X16/Ocp42Lw=
X-Received: by 2002:a05:690e:1515:b0:5fa:39ae:6928 with SMTP id
 956f58d0204a3-601760a4940mr1600295d50.16.1756943354805; Wed, 03 Sep 2025
 16:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903175841.232537-1-dwindsor@gmail.com> <CAADnVQLRhdLkZB8wFybofC8P8AP9sruMHzaYJbB4zUAKAv87dA@mail.gmail.com>
In-Reply-To: <CAADnVQLRhdLkZB8wFybofC8P8AP9sruMHzaYJbB4zUAKAv87dA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 3 Sep 2025 19:49:03 -0400
X-Gm-Features: Ac12FXw_tFNTNVr5WKZUutCEhPDHZTT16-28s-g0HuufjJWcoAcyQ9CPSCwYVHQ
Message-ID: <CAEXv5_i6hsUqXWpb7xLuffxmosz8_KGueQfJD2K9VvT0tJbmGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type
 and kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> cred is not something that needs fast access and automatic lifetime
management.

Use case is for eg KRSI to be able to track credential leakage.
Lifetime management absolutely helps there. Also, the use case is
"whatever the bpf-lsm maintainers had in mind in their presentation,"
right?

Also, this entire presentation says otherwise:
https://lpc.events/event/18/contributions/1940/attachments/1438/3389/kfuncs=
%20for%20BPF%20LSM%20Use%20Cases.v4.pdf

From that:

"Still missing storage for following types:

struct file
struct cred
struct ipc
struct msg_msg
struct superblock"

> Technically it's doable, but sorry not going to.

Sweet I'll do it

On Wed, Sep 3, 2025 at 7:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 3, 2025 at 10:58=E2=80=AFAM David Windsor <dwindsor@gmail.com=
> wrote:
> >
> > All other bpf local storage is obtained using helpers which benefit fro=
m
> > RET_PTR_TO_MAP_VALUE_OR_NULL, so can return void * pointers directly to
> > map values. kfuncs don't have that, so return struct
> > bpf_local_storage_data * and access map values through sdata->data.
>
> The commit log tells nothing about motivation for such "cred local storag=
e".
> Technically it's doable, but sorry not going to.
> cred is not something that needs fast access and automatic lifetime
> management. Use hash map with 'struct cred *' as a key.
>
> pw-bot: cr

