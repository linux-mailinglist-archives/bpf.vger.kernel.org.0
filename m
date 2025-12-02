Return-Path: <bpf+bounces-75859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BBEC9A1D0
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 06:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A35AE4E2234
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 05:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85BD2F6938;
	Tue,  2 Dec 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlxgzXLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D01DB356
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654269; cv=none; b=O1oYJWwLOSm71D2G7W3t9NAqHECikPzDmV7zpp8QU0I3uLXKOikA/7MI7wjaVKWsFbDxdZzcwDvfBJntmZvO2kr3dekR2sB2q9b84mEr1+kz8EJkmGuKfus0rVvmXuPoF3bDHIV+A3RsCvGkyhvcS3Xz7lxpLjnBFb/K/80s5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654269; c=relaxed/simple;
	bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMtpArpBrq5Aph0iWRy0T5UG/RHZkC92OumBQ95z6Y/KrfXQ3gY4kb1b8HFGUY8sBR6aRMx6UmRJNxw+vOGY5uPUg4Dde6GyWcZ5JoAFski0YwLV5o2J/SQs3d/zUFipGGPQ4Ywtg3CnhrEqwjmwfMapdnGU1oUZMDmZ9CeFRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlxgzXLR; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f97c4eccaso4572092d50.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 21:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764654267; x=1765259067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
        b=QlxgzXLR690rCMbJnETibgk69L4eFRbRRgK/wq8b0gyPTZ3dWAeFn52p6xqBuTbyz3
         BW+84ET9tfgoKluqAWAhuMZlAo+UbY4z+D4KqLDcSiC9Vo3pbHqpDDUtlChfKTPtb4Aa
         SuHIH2tEJmZsKpL4g++B6bTgcH6JvVP9AZc4OzAFLX9kQ/jVgc8LSHK4BP9AEKP49Y4z
         YEF4H/Zl9qFa6kad+5vqRBTwRT+7vfpJz0o0PRtGP8Tvej8HvX9qwXlqrQH27E5ELM7A
         hCXjXw9JMVtE2vqq3eYWst9VOP0NLrxVoNi6zclzF67KwJp2kk9SXhKYGXDE3aIWYZTI
         k2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764654267; x=1765259067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
        b=K3HUweW0h1VC6CheBjofjMVpkGyypEy7ineXcETQCmAjsUrKdiR2ais79k4A4P0S9s
         2p2NmCCjFeI2y3Yku/xJnZGBXCVp79F9cJWvgHeESJdn8vMY5uF3wthqEwuJ4UGQwDdr
         Sbho7ZGM8y4nZgOe1sAbR/CrVyuBizG6lKPCakUEGU1oHM+I+NCBOaP2N86kaJKn45vm
         u0UdVTeVnTQ0Vw47qoT0p2UncRKnuBkOYLZ3MH/z4Z8Zjg2CiFtL6hi53j4OnvFpEuss
         wtM58fQ+H77JtQHVfP5vV1boXYYFPSMUXdSJ/pqBTB9BRBtdhDb0r9WRARSpybovjNKf
         1jdg==
X-Gm-Message-State: AOJu0YyUdwBd8eHYL0nvv0tVDeO4PIC2vCRfOyq4nYxnQCb3QleugtYW
	aUBMqfnhLVAYAsaH+2rtPZmMUYnzdhy91AVOe4TmqzKo1Y/Q9bT8ai+Z6/tc8ciFNDM82viaD82
	Fvbk9HxdpTFoLU0xdO+kL+J0bt+SSJtM=
X-Gm-Gg: ASbGncvrdC5LHH5NuMvQj/R6qLtQkrArPgoExpepxwHBwCx3FsDxM7c0/PenkTspDTP
	xIZxjy0tLR10zTXUaYXXohiX/36tAQU6kpoQfsr5dj9b4tCImMFKnxE9gIXbk8ZFjA7/2s1KOXP
	b+ZBiNEVkPgEV1Jh5kAbOGdJrZj+9AnpWfbIptwxaGjF2S/wm9w6q+ygYHfaEs4XJRxUsSJ2sM1
	oUtuAdCI2laKpHFXxTMStTcusg9amBAcjKmShwxZyHCd+3R+5/HIKbTUB5VxVngzoYk2CA=
X-Google-Smtp-Source: AGHT+IHuUHMhLE/nocoGIHCdFzqfP8W2AeAsbPg0efL2+PhESyew/pc6r9wR5ERF6r5GC6P1VqvwkLJIBGv0OT75Rps=
X-Received: by 2002:a05:690e:d0f:b0:640:e6aa:b2bf with SMTP id
 956f58d0204a3-64302af07f6mr26362966d50.43.1764654266984; Mon, 01 Dec 2025
 21:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202001822.2769330-1-ameryhung@gmail.com> <20251202001822.2769330-2-ameryhung@gmail.com>
 <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
In-Reply-To: <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Dec 2025 21:44:16 -0800
X-Gm-Features: AWmQ_bmKk84M7vxFOLjErxPn7U6_d6BSBJDqPc8BMD49He9DgGjgo26wnebBkRE
Message-ID: <CAMB2axOBJ-BceMjGwT4=E6h+Jh2ba70s70fFJvL4u9Bq389UXA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a
 tail call callee program
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-12-01 at 16:18 -0800, Amery Hung wrote:
> > Check that a BPF program that uses cgroup storage cannot be added to
> > a program array map.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Hi Amery,
>
> Mabye I'm making some silly systematic mistake, but when I pick this
> test w/o picking patch #1 the test still passes.
> I'm at ff34657aa72a ("bpf: optimize bpf_map_update_elem() for map-in-map =
types").
> Inserting some printk shows that -EINVAL is propagated for map update
> from kernel/bpf/core.c:__bpf_prog_map_compatible() line 2406
> (`ret =3D map->owner->storage_cookie[i] =3D=3D cookie || !cookie;`).

Thanks for the double check! I simplified the selftest too much and
introduced the false negative.

There should be another program using the prog array and the same
cgroup storage in the first place so that the check here passes.

I will fix and resubmit.

>
> [...]

