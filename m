Return-Path: <bpf+bounces-31542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CD8FF711
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005D81F22F6C
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229613B583;
	Thu,  6 Jun 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RajqOgPB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CE4594A
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710809; cv=none; b=dGIdrXYjrmuSwYIiaTJQ9SqqOB4l40DbWzWxqNgBisA+mXMA/j79q1niuUH9UUr2KBlCH5o7BO5ANFgHlC555ep7f2XEFx4UcsBeAMHixDirgnT8JzPNjSfFP0O+TY3F5Obva1NlNtNaaMRk8ihwa0VuhNi4g+xCTeyBdPIeAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710809; c=relaxed/simple;
	bh=+FpI6vYpR5bbyxTEbYr9rtFq5rhJFeJhBlUYUqcnlgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nERJIV+3heB5FbZ8ky4KPSYXiGLcKdGYnfxhEBP++MwnR6AK9UAttMBayNToM+KutEHRQ0ScVpj9EWY8Foo7sB521ssCbISNZ4sfNB59Dk4l73lQLUd7k/60c8drtxetomRMwX6MzBvwnXv7OrR21tiuJrArsmRJm8qLLpdWCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RajqOgPB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a08092c4dso14758417b3.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717710807; x=1718315607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=RajqOgPBwv8XJAwhXWZXlVonrRF/YPPRy9ozsRER3hLSkk6xn5+2NkLmVUpYWo4z24
         vkdDuC+8GAi+qh9w4Q8U8gJqytgI1tFDxKjmY07/kt30zRk4SsHMnidS0/j80kJsZYJZ
         e9uYsPru6kO6APku6GR8PEw+6fLvfsvBKhdW7NkohU3AbJ9ua2xvtoDbuMaFPC00pb5y
         4aDAvy4mPm25RQfwi7BHcBrjo2H1pAYX0OFVEOYbCs/fmyHVX4I6gpN5bfjuRB1O1Ov+
         87VlPFsC7ESewPLRCFIkMsnBlfW3xXJB4C9PpcBVxvg+1WLVZzfVBQGLcqG+xHyCgNS7
         2gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710807; x=1718315607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=mOlKq3CPn6CR0n7fT/ZklvT9Pgn+3VG7BqJGJ/e2ejma4WHSqk6IW8AiprZIJ9pXce
         Xuqo1VxQZAYH2iPJROWZzknrPvb1A6tkdBDNwdnBbCP8LMKX5Y6OmiiFawYNq4nNVcnB
         kY+pcTiOjR658oHD45peXn6gQVt1Byk10Ki5y4xRc8XAe2fTgjiipx06cRxEdR3SSCkW
         2Yda5Q1Ap5DX9uf9tjuV24X6U7QBa/ZLCz3L+yMgQ72QqEfWbxzp1qWajL7h4HBQ6yOX
         oto2T3hQEZ4uJyZFjE8HgT2qXKZR9PtWdywNBKPU3aOUrmmhPxeumwrILUSMZvmFK4NP
         xMSg==
X-Gm-Message-State: AOJu0YwmMefgnnVdJkAbMpjvMnuxgoCc7PRXIW/totwe/5Gm8Al10Sg0
	fEILOa4B/mUACm2a728FW11CaZ3anhxPrVpFSj7filkrdt+vIJknnYFDU4IJh2tyrRBfd66OS3t
	75UbYvbTpUq0kc3Gk2nYTPbbFQY2xpbWDyj40
X-Google-Smtp-Source: AGHT+IHr+vEgrNOTl351kbnQRCFUgvkUIF6Lp0SFJ0/CR+WTO6ePRrwS52Q8I6+bzc57ubSMFu7oFmRulMZYl2piscY=
X-Received: by 2002:a81:7b57:0:b0:622:df58:2cf6 with SMTP id
 00721157ae682-62cd568be78mr5356547b3.50.1717710807083; Thu, 06 Jun 2024
 14:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com> <20240411122752.2873562-2-xukuohai@huaweicloud.com>
In-Reply-To: <20240411122752.2873562-2-xukuohai@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Jun 2024 17:53:16 -0400
Message-ID: <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
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
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
> default return value, and the expected return range.
>
> The LSM_RET_INT is declared as:
>
> LSM_RET_INT(defval, min, max)
>
> where
>
> - defval is the default return value
>
> - min and max indicate the expected return range is [min, max]
>
> The return value range for each lsm hook is taken from the description
> in security/security.c.
>
> The expanded result of LSM_RET_INT is not changed, and the compiled
> product is not changed.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>  include/linux/lsm_hooks.h     |   6 -
>  kernel/bpf/bpf_lsm.c          |  10 +
>  security/security.c           |   1 +
>  4 files changed, 313 insertions(+), 295 deletions(-)

...

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 334e00efbde4..708f515ffbf3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -18,435 +18,448 @@
>   * The macro LSM_HOOK is used to define the data structures required by
>   * the LSM framework using the pattern:
>   *
> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args..=
.)
>   *
>   * struct security_hook_heads {
> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAM=
E;
>   *   #include <linux/lsm_hook_defs.h>
>   *   #undef LSM_HOOK
>   * };
>   */
> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, con=
st struct cred *mgr)
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const s=
truct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, con=
st struct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const=
 struct cred *from,
>          const struct cred *to, const struct file *file)

I'm not overly excited about injecting these additional return value
range annotations into the LSM hook definitions, especially since the
vast majority of the hooks "returns 0 on success, negative values on
error".  I'd rather see some effort put into looking at the
feasibility of converting some (all?) of the LSM hook return value
exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
I haven't had the time to look into that myself, but if you wanted to
do that I think it would be a good thing.

--=20
paul-moore.com

