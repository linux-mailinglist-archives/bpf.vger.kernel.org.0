Return-Path: <bpf+bounces-10590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C259D7AA1A3
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D09028160E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8D19464;
	Thu, 21 Sep 2023 21:04:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E99CA47
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F960C433CD;
	Thu, 21 Sep 2023 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695330261;
	bh=NTY7su3N/P2WqqRzczFkl8JOvt37OHhVmbjZ8iNmugA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AU8T9OUxruM0ffekGAIqSrplEPdTc9AqH7s03iPvcKKsgq+5U+/jN2cJbvYq3LKde
	 giClDisO36MuXCiAae9jGhCm+mQaPox0kxug6ekce7jmvep68xhZ95+duhwffYiMHU
	 mBQJITs6ME68Jg5uuyDx2biRR+1nWUJxxHpB6bASRKjf0ID7GznTQTRIi4Nwp6eOzR
	 O98sKlGLbiU5q5ihJ1VNJo6T5xsq03RcbBJ8XBoKjom+HR095WcpjsXPb8qqMrKqj/
	 JLnckei++nxjmzLb3oqCKw1Y/UFZKwhUyWKFn4QFYzZcciQktUYPIjA/PHZPFGvtMX
	 qsuGQ7Zn1r3hg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c008042211so24402731fa.2;
        Thu, 21 Sep 2023 14:04:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywfdj3vxLuJm/8CTnk47Sm4B4y9KcK8VCgX+rgNTpML0u2YnCDD
	CQDABanC6cTUQVK8gUyllZitqZ/+SSxGXYuqzJ4=
X-Google-Smtp-Source: AGHT+IGchco3KaA/oi5PITa7B6FkBv6AT1muk4ex3g3wUPXLcjswGOqkbSw748chLyeUbgzglZ5fELGDRKjZXgn2fMo=
X-Received: by 2002:a05:6512:34cd:b0:4fd:d64f:c0a6 with SMTP id
 w13-20020a05651234cd00b004fdd64fc0a6mr4947234lfr.48.1695330259689; Thu, 21
 Sep 2023 14:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-5-kpsingh@kernel.org>
In-Reply-To: <20230918212459.1937798-5-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 14:04:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW41NBzB0JRj=TGuNwqAZDXcxeOLrJC0xHsJnayRfVuF-w@mail.gmail.com>
Message-ID: <CAPhsuW41NBzB0JRj=TGuNwqAZDXcxeOLrJC0xHsJnayRfVuF-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 2:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
[...]
>    0xffffffff818f0e89 <+89>:    mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:    mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:    mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:    pop    %rbx
>    0xffffffff818f0e92 <+98>:    pop    %r14
>    0xffffffff818f0e94 <+100>:   pop    %rbp
>    0xffffffff818f0e95 <+101>:   ret
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

