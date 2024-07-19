Return-Path: <bpf+bounces-35040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302C93724D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D181F21F46
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4958847C;
	Fri, 19 Jul 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HpMOg9hP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CB22331
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354889; cv=none; b=Mf3Dqlwb+T0LI8fhucZk5XkHtd1L1es63zrCnqqUgcfR1Av6d3KB1/b2c6gcRTF9FeMFaVDanRb1M9OlrBbestlV5zTP0lYMzz8OGBYs8rA99pPKK0v1FAeYqdLsekJnlO0f7K/2St1653hvC6fjnMi9jCtVingUkNX1Jc48XgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354889; c=relaxed/simple;
	bh=3kQS2cZBJ39f+nV1qKNmNoKNDB7FDTY1mI5qcsc0L6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KN/giISuiqqNRYx+rRm6jYKhjCgll4OYReuFKeT0cwSpYwNTN3wx0o+vGOQ4V3A/mE2tsVPr1elw2wf6vMc/taDtYTvF/hHRtNYAvGn3m+p9PgJ0ucaRJ/d/vdd4ZajhLjNqDcbVAB9xdiZ1M7ypwybuWAoSt0QpKZ5ZgFj40/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HpMOg9hP; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5f46191b5so7977896d6.3
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354886; x=1721959686; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=HpMOg9hP2D2CTIPEDAoJCR0GMOLmSCcqBQi5wznRJIrnLgRAQtG1TjSvV7e9U6dDbq
         DgOXGYY81ajdwliU84ZqZynv8JissDXi9EGoLvHwR5IfaPpmuxm5FkUrAYes8b+4gAZi
         6EmN8C5F1Q51+9W6JN2IlDACNzY4elkY7tv7mQmcDT5oNGrX/1CISKwP2uM9Hiy+vsC+
         ESvRK8rQjUl3QQZmlCE5KiSkc0BjFp/l9FIUTmgbaQ95Jj8LXz3lkI/fvNJCz6KwGytb
         6YmgUyci89NY1g0YBukW/VwWwsoqPYZfvji94ceyMbBydexVHF/8klkLWDM4jzklkH3S
         N3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354886; x=1721959686;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=eFG0jmXdOt2BoTY2F3gW/WQD7g4i06u/D+JwCG48AdOGf7j08b2guZ3T8scbX844ry
         V8DtEdcIEtgTPq7ydzoZm2Fl8gzMOnyaQtejDGwMOGQA00ruWmxMXWKGvo7wbEEaZONd
         lqra4na/grWmJVW3+v53s2vgsZmfOLi+zXAqGhv9l5N179TEyt9h9mywxgKpLVsg/oKj
         0UDuojIlDvgQNZ9n/LqNXId4Uga4t9F6jjIWOUsZ6Q6yemt5mgJkTfQiQlbqiWK78CiW
         jIIKkq9nPV6mZh9jUA7HH4Ex0jOpyIj3K7TP7zya85TngUZO6kMJzVSxzNd1JF27TevH
         8S+g==
X-Forwarded-Encrypted: i=1; AJvYcCUyThZGu+Cfm6CrtFwyh3n30iepXICOVPn59HAwHDATq69VT7Rbm9zvVB2OdhBLq7lTIduuVKl4WhyaneGB4VZyfl4A
X-Gm-Message-State: AOJu0Ywkr25E4TnVungFznxtL4pUp8HuULVQmWnwI5JTrCIO8lZUom7S
	LgT5i6qcUAQW0ctnu0KmCuP3T/I3fdPBJi/FSCuDNsH+OD3HiDKjRYEEU2mPQQ==
X-Google-Smtp-Source: AGHT+IF74+EqudtKUL7i1ZCCvXjz+qd3zopM19m0jWGVbddz7RHlAWv2UgDf87dhf8FKY+88djubgQ==
X-Received: by 2002:a05:6214:2301:b0:6b5:3c06:a58b with SMTP id 6a1803df08f44-6b78e364c4fmr77396666d6.59.1721354885611;
        Thu, 18 Jul 2024 19:08:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7dfc97sm1785356d6.46.2024.07.18.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:04 -0400
Message-ID: <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 6/20] lsm: Refactor return value of LSM hook getselfattr
References: <20240711111908.3817636-7-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-7-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getselfattr to 0 or a negative error code.
> 
> Before:
> - Hook getselfattr returns number of attributes found on success
>   or a negative error code on failure.
> 
> After:
> - Hook getselfattr returns 0 on success or a negative error code
>   on failure. An output parameter @nattr is introduced to hold
>   the number of attributes found on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  5 +++--
>  security/lsm_syscalls.c       |  6 +++++-
>  security/security.c           | 18 +++++++++++-------
>  security/selinux/hooks.c      | 13 +++++++++----
>  security/smack/smack_lsm.c    | 13 +++++++++----
>  7 files changed, 41 insertions(+), 21 deletions(-)

The getselfattr hook is different from the majority of the other LSM
hooks as getselfattr is used as part of lsm_get_self_attr(2) syscall and
not by other subsystems within the kernel.  Let's leave it as-is for now
as it is sufficiently special case that a deviation is okay.

--
paul-moore.com

