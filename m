Return-Path: <bpf+bounces-35275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF49939594
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09C21C218D6
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F63BBE3;
	Mon, 22 Jul 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I2XpA0Y7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFC3D551
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684117; cv=none; b=mZhk7Dj2yfQXbJv/NqGr0chBlb6T7y6MFNqxQEIK4oT3ZXjdnTWixCXz/HkwejCzMLGoOb+GG7o0jqLFmO08uVIJSbKI97O+2lDWZjEM2CkPfhmO+L0OvfRrpysW7PXG8xiDF+6AHrX6ViAhC1NUZrg4U0I+wYhSvyeLsf7ANeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684117; c=relaxed/simple;
	bh=QkalD80DqvTDCz2PN2W94IIv1RWLqf+OXseqlPlrVLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjnk4f3isag4NlqWh15FB3Ue7k5hDwjd+diZy5XNNnFs4ihQdKytJ4eZfjxRSarXnkLbFSDeoEpcCfmlsVjlywNalXBU3sIraTA00KG2oYq6dj3qC42rGw1I3IZ+pN+GuGmGjSBJTrEutQrkh8888Atw4LMSJ7avb9NI4WkIG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I2XpA0Y7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6518f8bc182so37146677b3.0
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721684114; x=1722288914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTsqn/83ZPeaLCYHapIif4YXESvQF8i3Q92iI0P3qBc=;
        b=I2XpA0Y7yXAFbooqbBs+mjE3d7rVzVMzufMptvTU5Z82mSMfvyIj0LuQlz0IiMFDdg
         HbiaGPc9EaV541ig95M98Xjh+czaV6bLTP4sXWGojDMA2JjK6XqPe/WHqrh4hVXqKsBj
         Hdpj6JcJx0WIxXm7hAjJyfpA/RJy7liY4gg2ddBHDgixp2oxEViG67gpUOA1YsR9KyNg
         lUYd5ryYaNXenrdAHrSubWSl6nls5+Z59e96rTvj8gSu+v8a/wElUHPDkW45LH5/4UoJ
         Qv0Nuk4DPZ7D+fbaITp7S5STrx30NNvpmifQ0ZPmYpBAESsoL5r9xwz4Vm+zWKkL4MhX
         wQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684114; x=1722288914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTsqn/83ZPeaLCYHapIif4YXESvQF8i3Q92iI0P3qBc=;
        b=EOH1e6kVQ6kQ+J/tKA6AxRf0Dt4Zlp+4ssxABL+Ks7MjC+yJtkKX6s8VnRoubQVgu8
         eV4SWoSS37zBFYZLD6OiPn170YXA9roiXwSGl0zCaj0IK5T93WHrmk16t78PJm6JDmxz
         eo+7Va3IzD9QNQ2KE+nw3mVoAiPHbxnBIQofxj2EFwPmLNYB3gxF1HfvDLvUUsXrC42O
         YDCZbqrDGHulaF5gAjtQPtqxHIRsF1f1ko6KkuE7eZeDGyDmHNL84uFMbZ0aQALOsJi1
         KTgut908jQZ04S6un1aHJ3XIKBBZzJ/fQcgIuqISvYbH4mGPsFKR0MWIZ3xJoScWcBjf
         jKrg==
X-Gm-Message-State: AOJu0YxMvAzwJS4WfLr3Mfl1xC4G5StAy0Wboe6iyjCBqiyWHn56P0sV
	6rIFvpXqRHWiJAKQO7JLqyNgdADLEzC04F7RBLTL+Np34J4QKdPDBddrehcdb1mnEPfnVGkdfah
	xoLnkiDjKDTaWy2q2U+cq9mn9pbRqTKnd3S+o
X-Google-Smtp-Source: AGHT+IFxvRdTpM9J/N/0hPOw4WP6B7wxQLoIxE+F11e00K/b5jjFnXSxfC/5KNaKiSnG10O3MfvJ02z+6becK/m+/x8=
X-Received: by 2002:a5b:d03:0:b0:e05:e4a6:3f1b with SMTP id
 3f1490d57ef6-e08b95ce4d8mr146419276.7.1721684113783; Mon, 22 Jul 2024
 14:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-10-xukuohai@huaweicloud.com>
 <94a3b82a1e3e1fec77d676fa382105d4@paul-moore.com> <7711bdba-9fbd-406c-8b81-adf91074d0b7@huaweicloud.com>
In-Reply-To: <7711bdba-9fbd-406c-8b81-adf91074d0b7@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Jul 2024 17:35:02 -0400
Message-ID: <CAHC9VhSsCuJzJ3ReUTyTXfWqRd+_TfShJBnRugZtX6OrMYJkOQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/20] lsm: Refactor return value of LSM hook key_getsecurity
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 5:31=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
> On 7/19/2024 10:08 AM, Paul Moore wrote:
> > On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> >>
> >> To be consistent with most LSM hooks, convert the return value of
> >> hook key_getsecurity to 0 or a negative error code.
> >>
> >> Before:
> >> - Hook key_getsecurity returns length of value on success or a
> >>    negative error code on failure.
> >>
> >> After:
> >> - Hook key_getsecurity returns 0 on success or a negative error
> >>    code on failure. An output parameter @len is introduced to hold
> >>    the length of value on success.
> >>
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >>   include/linux/lsm_hook_defs.h |  3 ++-
> >>   include/linux/security.h      |  6 ++++--
> >>   security/keys/keyctl.c        | 11 ++++++++---
> >>   security/security.c           | 26 +++++++++++++++++++++-----
> >>   security/selinux/hooks.c      | 11 +++++------
> >>   security/smack/smack_lsm.c    | 21 +++++++++++----------
> >>   6 files changed, 51 insertions(+), 27 deletions(-)

...

> >> diff --git a/security/security.c b/security/security.c
> >> index 9dd2ae6cf763..2c161101074d 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -5338,19 +5338,35 @@ int security_key_permission(key_ref_t key_ref,=
 const struct cred *cred,
> >>    * security_key_getsecurity() - Get the key's security label
> >>    * @key: key
> >>    * @buffer: security label buffer
> >> + * @len: the length of @buffer (including terminating NULL) on succes=
s
> >>    *
> >>    * Get a textual representation of the security context attached to =
a key for
> >>    * the purposes of honouring KEYCTL_GETSECURITY.  This function allo=
cates the
> >>    * storage for the NUL-terminated string and the caller should free =
it.
> >>    *
> >> - * Return: Returns the length of @buffer (including terminating NUL) =
or -ve if
> >> - *         an error occurs.  May also return 0 (and a NULL buffer poi=
nter) if
> >> - *         there is no security label assigned to the key.
> >> + * Return: Returns 0 on success or -ve if an error occurs. May also r=
eturn 0
> >> + *         (and a NULL buffer pointer) if there is no security label =
assigned
> >> + *         to the key.
> >>    */
> >> -int security_key_getsecurity(struct key *key, char **buffer)
> >> +int security_key_getsecurity(struct key *key, char **buffer, size_t *=
len)
> >>   {
> >> +    int rc;
> >> +    size_t n =3D 0;
> >> +    struct security_hook_list *hp;
> >> +
> >>      *buffer =3D NULL;
> >> -    return call_int_hook(key_getsecurity, key, buffer);
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.key_getsecurity, li=
st) {
> >> +            rc =3D hp->hook.key_getsecurity(key, buffer, &n);
> >> +            if (rc < 0)
> >> +                    return rc;
> >> +            if (n)
> >> +                    break;
> >> +    }
> >> +
> >> +    *len =3D n;
> >> +
> >> +    return 0;
> >>   }
> >
> > Help me understand why we can't continue to use the call_int_hook()
> > macro here?
> >
>
> Before this patch, the hook may return +ve, 0, or -ve, and call_int_hook
> breaks the loop when the hook return value is not 0.
>
> After this patch, the +ve is stored in @n, so @n and return value should
> both be checked to determine whether to break the loop. This is not
> feasible with call_int_hook.

Yes, gotcha.  I was focused on the error condition and wasn't thinking
about the length getting zero'd out by a trailing callback.
Unfortunately, we *really* want to stick with the
call_{int,void}_hook() macros so I think we either need to find a way
to work within that constraint for existing macro callers, or we have
to leave this hook as-is for the moment.

--=20
paul-moore.com

