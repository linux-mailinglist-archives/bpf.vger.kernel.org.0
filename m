Return-Path: <bpf+bounces-26224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE789CE5B
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD241C223A1
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F1149C62;
	Mon,  8 Apr 2024 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOvCCFAa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126B7E8
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614554; cv=none; b=DY5UavUsbJl1m0yOmt7mTsnJqJMFOd/G+0DzP9JDV76VOvvxlI1j3uv0fGxGzcnqDi4i0bxi58M56LZknc+l49jJfoH4YGA7szUCegj/cBJo0NzWg72tpTTqEM+mlMK/V6/bZ/c2Z6AZdA9lN2HXe80lWFAOSm3ryEMkU9fGeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614554; c=relaxed/simple;
	bh=Sm0CI8d8ofMMEJJngWMvSW50SATfUX4RV5tlnRrJ1Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHj+f26FiTqcIZ4TX5GbGjw+rmotBfaEoKzNu95boHHBBLRiL3kzpRcwAdKLIrpbSzHAjBUTx8tlEkxLe4GTVrqkU5aWu9+g/yxut+WzX6ke1rhjy+0bCCMguiWmcHvQj8J5xjQiJACiBNxNCOGN54hl1cqEi9Gou5JW05fzz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOvCCFAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F941C43143
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 22:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712614554;
	bh=Sm0CI8d8ofMMEJJngWMvSW50SATfUX4RV5tlnRrJ1Xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOvCCFAaddhJghLfcVzoB1768Zww8Cxs7rg01CWFZcc8gOS79j5wZMFlbZea7REBs
	 +WV0QkLTRhWBJNQJWbhZKmNdWExrwzU5SpJI4+CswSHYw5nA8R63yx+pgyGF+9hdoC
	 BOwpa+SBCjE7l5PKJ0e/KLugN9po4ikZUPmPYTIIGCm+pSaKjHfFATZQ1Ey0qntjhx
	 oh+slN3JLyCsf2x8LtpYN5dwov+kiYjPuMYjXSsd2bjzIBjROF2L8zh19+SHOwdrqD
	 GD7FtrOFhF9SyjJnuTv5QXyM2rOPMP/GRufsHDE1MTdQzuO/fm0mQGBQ/MgD8kP9eM
	 vEkY4a3JnEkEw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso6777891a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 15:15:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpjZlBcdMdfIOvju2gqfIuhUFBAWUIPihtKQWlI19RmGG1/JCk
	Cr+qgGfeyXFeg3ia2b0ysxhiVg25ZDeJptTYFWvhcm4X94b8jU5h1IrJeBsUubv9//3NZ6Zfcjo
	9mVDZcP1yojqlKBnVn01uVWlox03YND9t/J3o
X-Google-Smtp-Source: AGHT+IEOOc+J/0isFo4Jb/ZQjYpFYW6Cfwf9mKCm/bSDnhQop8ESJCUYzMvaJxwdiaswtf4qphyqgjv3fvB4K29NdGQ=
X-Received: by 2002:a50:a44f:0:b0:56d:c4eb:6328 with SMTP id
 v15-20020a50a44f000000b0056dc4eb6328mr6755951edb.29.1712614552500; Mon, 08
 Apr 2024 15:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
 <20240325095653.1720123-3-xukuohai@huaweicloud.com> <7FAC6C1E-B0C2-4743-AFF0-0DCC2B331D0A@kernel.org>
In-Reply-To: <7FAC6C1E-B0C2-4743-AFF0-0DCC2B331D0A@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 9 Apr 2024 00:15:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5wExNrQYKckVrnbFbFXP8S6oWqG8GU8iaMJTMNbFTDSg@mail.gmail.com>
Message-ID: <CACYkzJ5wExNrQYKckVrnbFbFXP8S6oWqG8GU8iaMJTMNbFTDSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf, lsm: Add return value range
 description for lsm hook
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Florent Revest <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
>
>
> > On 25 Mar 2024, at 10:56, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> >
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > Add return value descriptions for lsm hook.
> >
> > Two integer ranges are added:
> >
> > 1. ERRNO: Integer between -MAX_ERRNO and 0, including -MAX_ERRNO and 0.

I also don't really like these special macros that imply a range. Why
not do something like?

  LSM_RET_INT(default, min, max)

You seemed to have missed the values returned by these hooks:

security_inode_need_killpriv
security_inode_getsecurity
security_inode_listsecurity
security_inode_copy_up_xattr
security_task_prctl

security_getprocattr
securitty_setprocattr
^^these two we should just disable in BPF LSM

security_ismaclabel
^^probably even this

There seem to be only a handful of these. Can we just manage it with a
BTF set on the BPF side?

- KP
> > 2. ANY: Any integer
>
>
> I think you should merge this patch and the first patch. It's not clear t=
hat the first value in this macro is actually used as the default value unt=
il one reads the code. I think you also need to make it clear that there is=
 no logical change on the LSM side in the this patch.
>
> - KP

