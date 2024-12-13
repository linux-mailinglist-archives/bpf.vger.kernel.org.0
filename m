Return-Path: <bpf+bounces-46812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E79F030C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE9F284668
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464D13DDAA;
	Fri, 13 Dec 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpnjSMOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636F22094
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060415; cv=none; b=JgvtMqTsskIslIbnjT5Y+hos73ud4l04o2XgAXSzeEmZp5+mLPwuZD2yNHoGR9OBIy544dtyrtUB8DAIFPTbnb7MOkf3P9SVoIy8OAcPhxS+uKQUqdo8UygappU0i3+fqnj6AOQc1lKJcWPKJPw9iuKqeqv43R4M6QymaMRUc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060415; c=relaxed/simple;
	bh=OgzOyv6t+mXAh1m1kts2kmlN/pNyzHRhohXJrp3PehU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMnZB41lZLYb31ZLlEd52Vf0UK2jicOuh8B9fyCld9WlARnrhHgwy3205xQkNA+/Z6//W3/2Lv+ZyquKZf21BfUQMHwAttfaPSU3Jtyir8GUlhhX2w7Zv6IosPE8Qbjk4IbCXCf48qx8HuIx0eikVZpwRHyWKpAmpqEW5RnUjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpnjSMOl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1200809f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734060412; x=1734665212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgzOyv6t+mXAh1m1kts2kmlN/pNyzHRhohXJrp3PehU=;
        b=DpnjSMOl5g/0Y2u693rMb8OmQcFXv3dq98xElQsOv0CfoE89nHE1gsdyv/7s3IpMDH
         b8x074jcK1yB7gQO8qrmzeo9VX0VXtggoa2yTFYgPg9NBCLTsTH5f2WkdQlLTBo/e1ch
         js4PTCXQ/PIA1EE7EQppzAP3sKuxirQ3NW7NqRxx09CqRXV1m2akcZ5Q9SoYmA9RNyEq
         T6sMgIgHeFgaDGRsJ9dNjXhhfKtFccZZZRendOsHb7TPupIqw3yCOzTTC991+NlPJEuQ
         2UXq/B6oKF5Et83IXHMrNM0CNuwZchFdtpxgPmfSn54KkNTxkRt8HCtztrkOhhoeO4RX
         RrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060412; x=1734665212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgzOyv6t+mXAh1m1kts2kmlN/pNyzHRhohXJrp3PehU=;
        b=WeyuZffE75K5LaPvqjmc3uN2rLWYi9OY9naqH7koQjSo+nI55u0cE/BPRKC8bbVUmF
         rfltaMNZmG42x0wkoTqLopepEQnNMP0JMEmutdFyNOveXg2IWygYkcJ5Fb+WOTW69sk3
         8LGNBVKtWnl2OoCnGHMO1iHBdtN6HW31WHgNMJRw6Oe5H5vk0E8sywpHIAjXR3tOQBfI
         cyuSlQjA65deiFVGi7YRYSZ+bpA7/BMFFGM8vWMtOXYJI0MvzBX1ImW4uwr5o3Mx7Vwz
         fUsLUn37XyilQwjqXFJb6QRJNAqLFVfsK+L+f3lgYo9plY9P7B4w/3O4jfKoV4GFDIQ9
         O+mA==
X-Forwarded-Encrypted: i=1; AJvYcCUiMen+odxIRqYa9a3myQmU5rrS8AP83b+HUoDuBS+HS71PalhYoNIcF61U5uuqX+xEUWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37Y5+nZgJB/kJFEIrhDlNoKgrII5nvTAUUCfMAITDTlsOBEOn
	UKa4sVhr9h3zY2c5lffbGgvDvrCQ+l9MdzD2udtkbVTXyfYmEOuN8rFuEhYaoi2U3+sF3Qwucg1
	rairELzWWTrd65v6iclvdKeImB6w=
X-Gm-Gg: ASbGncs4dj4b2iV5M2SHAi6ewxKTTlBwP+8C0URoqwyU1I+83FW8BoarCn6NWXrwLzi
	+sY7560Xaut7QPSwvFEXPH+HTfMpFugmwz6oubn4Z3zEZGtSng91vDEQK59FpqzMZe93pQw==
X-Google-Smtp-Source: AGHT+IEMi5fN7orRHhbHdcFCyhieC0tqS8JrKe6gQfbxPyZkVjGkBEcnsyb9RwhKO3Y/yS2VKCRwLadMn8IdGL1UzTA=
X-Received: by 2002:a05:6000:1f82:b0:386:256c:8e59 with SMTP id
 ffacd0b85a97d-38880ac601dmr503941f8f.3.1734060412224; Thu, 12 Dec 2024
 19:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
 <CAE5sdEjZCDqgtvAFd_MpTyc+68UMLDufbsS9H2wMOLJiHQJQyw@mail.gmail.com>
In-Reply-To: <CAE5sdEjZCDqgtvAFd_MpTyc+68UMLDufbsS9H2wMOLJiHQJQyw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 19:26:41 -0800
Message-ID: <CAADnVQKSTqJOU_B7MQ-+Byt4GXLNFVv=ce32Y74F3=8DCWL05Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry
 bpf programs
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:41=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Thu, 12 Dec 2024 at 18:58, Priya Bala Govindasamy <pgovind2@uci.edu> w=
rote:
> >
> > BPF program types like kprobe and fentry can cause deadlocks in certain
> > situations. If a function takes a lock and one of these bpf programs is
> > hooked to some point in the function's critical section, and if the
> > bpf program tries to call the same function and take the same lock it w=
ill
> > lead to deadlock. These situations have been reported in the following
> > bug reports.
> >
> > In percpu_freelist -
> > Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1Wj=
B1pP9AzJLhKuLQ@mail.gmail.com/T/
> > Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9=
jy0MuL8LCXmCrQ@mail.gmail.com/T/
> > In bpf_lru_list -
> > Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=3D6A7KKULdB5Ro=
b_NJopFLWF+i9gCA@mail.gmail.com/T/
> > Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0=
OLJJYvRoSsMY_g@mail.gmail.com/T/
> > Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk=
3_oLk6qXR7LBOA@mail.gmail.com/T/
> >
> > Similar bugs have been reported by syzbot.
> > In queue_stack_maps -
> > Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.=
com/
> > Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.co=
m/T/
> > In lpm_trie -
> > Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38=
@google.com/T/
> > In ringbuf -
> > Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.co=
m/T/
> >
> > Prevent kprobe and fentry bpf programs from attaching to these critical
> > sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> > bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
> >
>
> I think the current solution is to use a per-CPU variable to prevent
> deadlocks. You can look at the hashmap implementation for reference.
> However, ABBA deadlocks are still possible, so to avoid these, I think
> the BPF community is working towards implementing resilient spinlocks.

Right. The resilient spinlocks are wip, but in the meantime
we need to stop the bleeding.

> I was planning to send patches for some of these bugs earlier. I'm
> wondering if per-CPU checks would still be valid once resilient
> spinlocks are introduced?

The wip patches with res_spin_lock remove these per-cpu
recursion counters from hash map and other places.

