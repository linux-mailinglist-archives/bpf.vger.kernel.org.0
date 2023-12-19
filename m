Return-Path: <bpf+bounces-18248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF21817EB0
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619F91C2306C
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36E62B;
	Tue, 19 Dec 2023 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwtnDheb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A217F7;
	Tue, 19 Dec 2023 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366005be7bso2743889f8f.1;
        Mon, 18 Dec 2023 16:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702945161; x=1703549961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUjjR8kp3UfZK0lfKcY2X3t0uXzPlXrLKfdZrVz+ObM=;
        b=HwtnDhebvwtHRL1/XgXJ9mXe7ORkPlrO+0/vHU3Rig8IMQlSJah3JoPHi6LiecoMXU
         K8tgsSFX4V+EqlxUXT18L6z+u0Kykbr390Sv9EBFPo3D1IRKzPCDiwrCKCPCVvh5qe4N
         15tGyWBCa7Ting5Wq1lIzumeuBn3JWfVONcd9CwBtrWy7Hj19XgJO1kjWUL/qP5mqISS
         dDZ+PncDhWBIR+UBnaeGlpK4Vlf6Lswwq+dgMviEtQkHSmyrIBxz1Z6Skbok89o03/kS
         KrIOcU/8qcTMTpBN/KFz7sCe6uYUrWmVfufFBLlLd8YvcvrLD7KN1KRLOjCJW1EcVgh6
         t42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702945161; x=1703549961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUjjR8kp3UfZK0lfKcY2X3t0uXzPlXrLKfdZrVz+ObM=;
        b=R3zfL9v6QrEKgj53q30z+8TOYsiOjEJLz0D7q3xjzvRioqVQvSs7OOKHgIGYZUdwWE
         ze2Z49u9LVrCeisajxmZajvNpQV5f3Wv/AkMGzLNprscmwZlstDSW47gD0OPKIlGTl3t
         0C40uIQmeXUcN8pbwnVYqBdMwUYnF5/so+deCWBECxOG5CvrH0X3wChJSyVo/BjfH2qx
         XkdS2zB5UwipRL17pBwZbiyO2IoYl66Sa0FO1hiiDIrZvr2PfLPZUklvntBkHea9yuI5
         YvKBgdbbftZN3aMJtxmBx6qMkIwHQChCcJPw/1euEkPkh8hYNoAKgeFpx/QM+ubsBZiF
         p3Rg==
X-Gm-Message-State: AOJu0YwXd+7nvvhCRt2ly1jsZ2bmA+MGAj3JgdOByqwNlgH3CCAp9Jy0
	gqDLThq6rlsLOnvqzVKdtUfPWhhvKHnhXelhysU=
X-Google-Smtp-Source: AGHT+IEhvCaV7SwHiDFXblqbHh6gxdIBT5ag5WsSKGdGSVL/DAyRQGBDtadU26ldlXAQYJMhFHEDSKFayqNqz2tMI2M=
X-Received: by 2002:a5d:4486:0:b0:336:64fd:72e7 with SMTP id
 j6-20020a5d4486000000b0033664fd72e7mr1442508wrq.52.1702945161134; Mon, 18 Dec
 2023 16:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Dec 2023 16:19:09 -0800
Message-ID: <CAADnVQJ-Epw8KbGvHz6UHXgk=rMmp_1DTDVB=prOBOxXeswOSg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Please consider pulling these changes from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for=
-netdev

Forgot to mention that there are two conflicts in
include/linux/skbuff.h
and
tools/net/ynl/generated/netdev-user.c
that should be easy to resolve.
First is due to typo fix in the word 'variant' and code move.

