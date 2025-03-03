Return-Path: <bpf+bounces-53107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF642A4CBDF
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D043166158
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A322E402;
	Mon,  3 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb/bU8nU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEF23717F;
	Mon,  3 Mar 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029302; cv=none; b=NdMyTDbNxiCZY1/cTXMrfnQF31zyiUgKH2Lu2Tj42PxqzMcbuIMRPT8bw73QLVmqCJZm03qzaEODZdSTaaR3JnXp2detauH1xjHYXvVDvAOB7E387WEhtB7kSi/a+FStL1y5ZjOJEGGRDtNf9MYBGKiB+U7f6bu4px7AD6af48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029302; c=relaxed/simple;
	bh=Y3VDqmm3jr2UgSN6L629ELvPv02TbFEvykBtCsCN33g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZdFrU5Z2+BPwiTB72MZjCDdDFUoa25wIbJQH24dpkaTk2lYhohd3COIMOujKWbClFZ7vZPlP/PC3kXJkeLSakmMD8L0OQmzGLU8USmAtUIrl96u8UT06hvJKJvXqeyx94ou8tGcekAhchdQiyKsbwDskTcckOyVel7Rdwu8fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb/bU8nU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390eebcc371so1785934f8f.0;
        Mon, 03 Mar 2025 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741029299; x=1741634099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWSgdcI8dG/w3NgMEY0KO0rcu2pqeCGSWeCl1Jx/eh8=;
        b=Vb/bU8nUWhWNseSnC4/oLFilEds3/k49tP82N2qRh+cgDxiznbwIca1mll/n/ncVtq
         Y+0r0ODBPWegvI4QIf5cDnBX1GBqsvJT0Xu23AebrSSpk3SrKbiDzhbDisJ11aUAavqw
         hULDlSwLn2gD+hkLIYdYrImWIbWy3aOAMwZ/WLw3H3D0ME6cMOS0/mLzA1zJAqzWCcNJ
         Ja0k6hfP9xLd6r9v2eiDsl7uv90uX3SO2/EaSJE5+bqWPKTMOy9XKMo5tGA/mHgeYgir
         4njfxkh9HgMQQ5l33ymZeN+U0L2Msxi9Z0V5gFLHVwKAISUyb+60gQfQBEFGi5VBFmJk
         IadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029299; x=1741634099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWSgdcI8dG/w3NgMEY0KO0rcu2pqeCGSWeCl1Jx/eh8=;
        b=iNxru7WAk/V8hpKNzk9O1IMFkMhNyTO5asKeBgdzmta9fBiMvTEEXdEumsPENkMXa/
         C7xkJABtxR3gUA23syorzEA3TKL/n3sQQSb8R9YlpsVjtN8YE/1qU6yUfyuhmPunwL3P
         AghDelTEMP9fHb10lrtF4WOkQg/9CVrtwPbxfAUP73ig6d8RhuWJaMn4oZZlkbQ6e7FH
         sYDyI+I3lMd4UF2ZtlkavlgqiJkLIBbussqV3oIdOmEareO7RziXL9Xu7HK7z3uUIszt
         EyLRb6Lad0qdROjClSBre31DOafVdrwAusvK4eVN1Vb7YO1Os+13uCYdxFbbiG7jWoj8
         GyCw==
X-Forwarded-Encrypted: i=1; AJvYcCWwP57T7vgzn7a/tkZlKvubWyN7jBcZ5wVmAcvr6htmK5jLxj7hPXwMKHerLdQ6sq/MH8vzlK7JPYLMco8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1o1D+qs4vvDfLNRUxw8PbFoIOrFYcSl+FvDLHYza3ECzKUyge
	7rJzjeUa0TlJErC2TxrA3OUu8Bl9WjyZolGxdHfRxvAYXW3Yna/feXlesrz+cGVtCS7kZkjUoK/
	8VGuR7B70bfdv9EBHxIumRtYwJ5jv9MDE
X-Gm-Gg: ASbGncs5TUNjtUF2y8Nerw4Q1XB/VFZrlOWqXEQ2pX+/8oiIzKEIwighQ1cyWBjPGVT
	BYwp+jMHygpXjOEpD/Q99c7B4Ri9MyT/vuAt+nDNJLYA4XowIkW/dJvaTUeRGMPa6ryUIuo0sqO
	tWjdVO+g4nAitSjwJvbX4MP+YFnSRIyCnEAe7zIh7Fqg==
X-Google-Smtp-Source: AGHT+IHpw6BVblTB/molY0Q0Y/ADp05hOeMI7HCXhDo9q5bq91y5rh4QhpWVIspkwtFNbOUmUW2kmujxGQNENx4qkDA=
X-Received: by 2002:a05:6000:156d:b0:390:ea19:d182 with SMTP id
 ffacd0b85a97d-390ec7c9728mr11013342f8f.6.1741029298655; Mon, 03 Mar 2025
 11:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com> <c835515c35ec4ed59232adc3c02e1e90aa8ed8be.1740978603.git.yepeilin@google.com>
In-Reply-To: <c835515c35ec4ed59232adc3c02e1e90aa8ed8be.1740978603.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 11:14:47 -0800
X-Gm-Features: AQ5f1Jqm92S27bYfKP6E_fjREpNJNcb270wk3R_NNsZJZvSBllfjQErWMz2uTWM
Message-ID: <CAADnVQKGF-yD6UZ8Xha-wHu+7Jzn7Xa4Xu9Rju0hL2vFknqNEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/10] bpf, docs: Update instruction-set.rst
 for load-acquire and store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Alexei Starovoitov <ast@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 9:38=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Update documentation for the new load-acquire and store-release
> instructions.  Rename existing atomic operations as "atomic
> read-modify-write (RMW) operations".

rmw renaming looks like a churn. I don't think it adds clarity.

> Following RFC 9669, section 7.3. "Adding Instructions", create new
> conformance groups "atomic32v2" and "atomic64v2", where:
>
>   * atomic32v2: includes all instructions in "atomic32", plus the new
>                 8-bit, 16-bit and 32-bit atomic load-acquire and
>                 store-release instructions
>
>   * atomic64v2: includes all instructions in "atomic64" and
>                 "atomic32v2", plus the new 64-bit atomic load-acquire
>                 and store-release instructions

I think it's better for new groups to include only newly added insns.
Also we probably should add barriers to kernel/llvm and only
then update the doc with all insns together.
Otherwise we very quickly get to atomicv3 and v4 groups.
Naming wise I would call these two insns plus all barriers as
barrier32 and barrier64 groups.
cmpwait insn should probably be there as well.

