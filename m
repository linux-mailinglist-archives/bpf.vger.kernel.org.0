Return-Path: <bpf+bounces-53104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087FA4CB27
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA91175179
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584022AE6B;
	Mon,  3 Mar 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOlwAX7i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71021638E
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027403; cv=none; b=CvaaXu+U6FAR+hO+oaOTc1XualzjQGBGlvAGmV3dHwzSCFDhQLKZfHBCtZgVEDkRjrMKcf17whV8FsAO1mERrFah9R/s6GjBsh4IH5GnOqsfPWUGA1yUumyi6mSFQQ+eqatiMdaI3YbryqNmyX+HxOnXlWxcrhqAsUAHuAjZshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027403; c=relaxed/simple;
	bh=T3tAXzw45yILnfI7CfOutrgJFUSDJ1BtL6o/yGwTbk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjtIWKxClKQGb3zoJtXSUQ20bKdTeW3oBFszGFQiQpDvEAhgplJNFEKnpyHfKjmZgJmbKFbqbQzAPJWP6efvDXpCXaFTJ3OyK73Xwin9mTunQQRESpyA3TUID/LvoCoDWOv9tARAaX15FNfxykRc1qXrOi3KnTL4mf/SHDH4p9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOlwAX7i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390effd3e85so3473344f8f.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 10:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741027400; x=1741632200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0Qj2do2lKjHM4up5hNRdCkie5ZUt4A6ZgQ1FxVoTq8=;
        b=OOlwAX7i7GXuiwm2y+K9xTC0h1bFd69tn9PUj2M3cCtV9T8vceh6bQgxufAEykNPgW
         M4X9hQxlYMpvSduWsGI8DXAv6Tl25Ku0ZBftZe+LVYz6fEBz99imXxTev6VK5IK7KwyJ
         CaqXaTSTaphgPhw8yfq7sioTw0iY9LpQivMIthAECsnTHx04pkF/Mnr9ESk6vdcxW/QJ
         Kgb/ya748p2O2bJvgAoej9VQ5uHLV4TY6qIkOJYdncMbh9HQaVaIofInUoH5vZeiF1fw
         k/4V9/ikWZznz9FYz4HjYBUF52AIxpJFzliZy37QNa160I4L9lgo2/TuEtaLOvwyhmY6
         iTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027400; x=1741632200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0Qj2do2lKjHM4up5hNRdCkie5ZUt4A6ZgQ1FxVoTq8=;
        b=iC5Au8rmS7iU2C53KbE68BVYhaDsq5Zf7lbsR9bsCgI6DH+QpdWik+BRLDWVvnunSR
         PY5vVwP7S4FABLPEkyDsdKTQcKf6PpFvWHWllNhGLlRW94EdR9ACGLRRBxKhjgVe43fB
         lNURR0EsaJpk/wAuRrPOog5PH4bjhlMbrV9uG5ZW8KkIR6tLX3obyBPYUeal7bgjzHoN
         Ng/an5HTcguiusNkEXx3ul4MMAvgjFoAavmD39cOISnSqfG/pPvzL1XnRtDArZ4CQbTQ
         AgydzdZIS4wK26CYg0GYTcqrDHzYXCEmYfheWThEqXFgzxb0tKbpUv9D7CnOjlOk0ER2
         A5iw==
X-Gm-Message-State: AOJu0YxyRStOwQ8YjQdXZiNyyJespb5bUCFdvmjiC9ST1xJiggRUoRUn
	e42hxyXZxBqClQyFH6HHx+//FUbNYAgpCFwMVkmO9hF7BrS6wCeQNJOhqlI6KDCPBJh3WVL38dj
	FmDLdWcWNYsOdgjBKB9G+KdGCInE=
X-Gm-Gg: ASbGncsMVlmPmYIjy3pwtGE1m/bOaazkklldjBzLUa+Y5WAcAJJIUPbDuXSn3f/DK+7
	qiAjM5y5RrIgJ6e7az67p0SymNvNdwQWnxbOXwcepkYsdtmxtYcD0rCBOSTAhLbI20Ldc4Xt1vL
	SEaFYG7RAnqGcvyP7mmvqTTqi/euMZs9swVqbd1DM6eg==
X-Google-Smtp-Source: AGHT+IGDDnMZt3CWNMZ4/sQPWl3Fx2tgxAa5xRzjOQ98uGHkSButjm55wGRCRQL9ya4vSsAelL2gDCTl1KIzjuqQ0EM=
X-Received: by 2002:a05:6000:156d:b0:391:901:311c with SMTP id
 ffacd0b85a97d-391090131camr3764566f8f.32.1741027398340; Mon, 03 Mar 2025
 10:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin@google.com>
 <202503031631.OeUhVRHz-lkp@intel.com>
In-Reply-To: <202503031631.OeUhVRHz-lkp@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 10:43:07 -0800
X-Gm-Features: AQ5f1JoRxo3CAzV2ykcVy66gZAUbFkQeh9Ko6yETGexZgoB5dBAptBGoLyQICIg
Message-ID: <CAADnVQLLhNRmpjwDYHB0-59TDrGcgXzqSkop+-5eHYsG-Ws08Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	oe-kbuild-all@lists.linux.dev, bpf@ietf.org, 
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
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:55=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Peilin,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Peilin-Ye/bpf-veri=
fier-Factor-out-atomic_ptr_type_ok/20250303-134110
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/2c82b29f3530b961b41f94a4942e490a=
b35a31c8.1740978603.git.yepeilin%40google.com
> patch subject: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and =
store-release instructions
> config: arc-randconfig-002-20250303 (https://download.01.org/0day-ci/arch=
ive/20250303/202503031631.OeUhVRHz-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0

...

>    kernel/bpf/core.c:2228:25: note: in expansion of macro 'LOAD_ACQUIRE'
>     2228 |                         LOAD_ACQUIRE(DW, u64)
>          |                         ^~~~~~~~~~~~

Peilin,

how do you plan on fixing this?
So far I could only think of making compilation conditional for CONFIG_64BI=
T
and let the verifier reject these insns on 32-bit arches.
Other ideas?

