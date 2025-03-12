Return-Path: <bpf+bounces-53919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A3A5E3E0
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEF1189B161
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22D256C9E;
	Wed, 12 Mar 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPWhkcKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACF1DE3AF
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805437; cv=none; b=PHNTFmhQMqkG8CB8CqZejhmJKpX9+N/Uz/kSG5zJQ/S7ceDuGGAE73F6KnOGMSBEY6cKcXHTOK+0jJyECEP3M40V/Q+oQgnUiy10xdLWiy2qilh0LXkvcdcSrZB1Y/7XO52dJ90rc7zqQg4a2e2f11/GZTya3v0OLHP5LaqHmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805437; c=relaxed/simple;
	bh=d5kKma3HOL680/KQ8bAp5Dlz/Bzprt5f5zmmK/0+MXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYQdTYoRSNAix9dntOuISy55hhai2Ung3CLU8T65JdP79ZVd1lBQ+yycHBMCuVhvhkF7Ln41nP/gzgbv9tGyqVsTkBXjIZHEuDV7kqiD8bjz+BKz8Bofvp1K89GvXqc0n0tIPT4kS6YZstMP7coF/kbcYTAd5ot4cwEUaDfv+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPWhkcKf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so3782785ad.2
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741805435; x=1742410235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mt/h3c2Nr5UXGxTlYjORnZnJ0ij7xWlLvEblNJhY1E=;
        b=nPWhkcKfZvqRIuqzbkEaXMiWd6eqgXSYGY7gHfoEt+6Xs3yhmVWnr2/1AQ0awDeB0r
         s9FLHbf315x/rN0A5/r8DglpmQ2RY9+KWDACAThxwkPmyJuWgSU62jmswzR8YhUK7GDB
         qWETJ/P7SOJHjSgQXg4ejFAnSv/xSHnapOiBiQpozSOyk4d8ymbftjhZeCCgACPk2PwS
         CK83Ox4R+2Pba9wPPZVYvTDXefrp9gzPL8n05QFWdJefQOqqhzc780ZPQlVeoJeKAYjV
         E6sLtuXb8SZGp2KuNnNzDrnq82NVJX8dzLAVIs1LDvG+UhpegBtQ046TMsR8TlNKeUJM
         GOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805435; x=1742410235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mt/h3c2Nr5UXGxTlYjORnZnJ0ij7xWlLvEblNJhY1E=;
        b=HL27FgGg7pRudi+XKZ/Iymb86lNK3c4ERn5neN4qf4qKM+V2sfirahYpZte1s1q/YS
         FZPPzvVYdMLndwNByRLBRNen8jCgY2kXVdcRA5BtG0jFg1J6KvMru/vz7MqaH8bvXe+q
         mZQlJ8qXmho4mKjU+gljkdo4irhoIP7dC/fEioO4DN1BPTLuXYVUH8bVnV1Bg+mIFk0H
         7EdmHJxyGlcav567LjF9RIFcKCexukxASWdAugV7LQ0+ggg4f4CErWC1onhiSsw9cMyE
         cWu1YPw7EKDWf7X4Uk9LOeCpBzb9ADBxtKJEZrzd49M/4JerTGtFisrli37hGWEekThy
         a60A==
X-Gm-Message-State: AOJu0Yxb2ZIgwc3e29LSsumogGZtc5N7tqG3fFs+F/dxdnSVNFw1Bb6Q
	yoE5jh539hFAzu8+nj1q7Qw1ks+YiWEf6PYxF3WMv1ciiP3cQH1t1U8VDIiR67p7WCiHFqGOmb6
	RbAvRAtJ37/N960oFGfavqQ5AluY=
X-Gm-Gg: ASbGncsx5YZzM0nvbTQ77AUg0G34NS/PYaalbw4mm23Ts74xdYs/yPoR1V7MdsKsoNv
	SbPBlDCq9d9mh7doSOalyQYVSa3dYk2VDQl6AoKrlRxxhBZJyWzoeu/4xJPzRabB/W4VXIH/pqx
	wzbZ6hzgUNbZ9dZxqiEwvdPZIK7nyRt5fvTHIK7sp/gQ==
X-Google-Smtp-Source: AGHT+IGERiTC1KZRcAP3nhhWswNA7nXGHVt0T59/CritzJr0iM1rxEDENe93knJ49K21puXJHQEUGYiPSugovK1hDsU=
X-Received: by 2002:a05:6a00:928b:b0:736:5dc6:a14b with SMTP id
 d2e1a72fcca58-736aaa1ace3mr33066084b3a.13.1741805435230; Wed, 12 Mar 2025
 11:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
 <20250310001319.41393-2-mykyta.yatsenko5@gmail.com> <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
 <9bffe513-9c0b-4d9a-9876-1d8620753b56@gmail.com>
In-Reply-To: <9bffe513-9c0b-4d9a-9876-1d8620753b56@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 11:50:22 -0700
X-Gm-Features: AQ5f1JoioERjAz5Z6JH7MZsVi2B7Hf3JWxX0kT1OJsncLPyswToe8GUY42_6mnc
Message-ID: <CAEf4Bza_oL9rPR-585P9-9R00k=nAuCzuL-0=RN+_9FhO5PWuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	olsajiri@gmail.com, yonghong.song@linux.dev, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:59=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 10/03/2025 15:57, Andrii Nakryiko wrote:
> > On Sun, Mar 9, 2025 at 5:13=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> >> allow running it from user namespace. This creates a problem when
> >> freplace program running from user namespace needs to query target
> >> program BTF.
> >> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and add=
s
> >> support for BPF token that can be passed in attributes to syscall.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   include/uapi/linux/bpf.h                      |  1 +
> >>   kernel/bpf/syscall.c                          | 21 ++++++++++++++++-=
--
> >>   tools/include/uapi/linux/bpf.h                |  1 +
> >>   .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
> >>   4 files changed, 21 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index bb37897c0393..73c23daacabf 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1652,6 +1652,7 @@ union bpf_attr {
> >>                  };
> >>                  __u32           next_id;
> >>                  __u32           open_flags;
> >> +               __s32           token_fd;
> >>          };
> >>
> >>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD *=
/
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 57a438706215..eb3a31aefa70 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -5137,17 +5137,32 @@ static int bpf_btf_load(const union bpf_attr *=
attr, bpfptr_t uattr, __u32 uattr_
> >>          return btf_new_fd(attr, uattr, uattr_size);
> >>   }
> >>
> >> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> >> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
> >>
> >>   static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
> >>   {
> >> +       struct bpf_token *token =3D NULL;
> >> +
> >>          if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
> >>                  return -EINVAL;
> >>
> >> -       if (!capable(CAP_SYS_ADMIN))
> >> -               return -EPERM;
> >> +       if (attr->open_flags & BPF_F_TOKEN_FD) {
> >> +               token =3D bpf_token_get_from_fd(attr->token_fd);
> >> +               if (IS_ERR(token))
> >> +                       return PTR_ERR(token);
> >> +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID))
> >> +                       goto out;
> > Look at map_create() and its handling of BPF token. If
> > bpf_token_allow_cmd() returns false, we still perform
> > bpf_token_capable(token, <cap>) check (where token will be NULL, so
> > it's effectively just capable() check). While here you will just
> > return -EPERM *even if the process actually has real CAP_SYS_ADMIN*
> > capability.
> >
> > Instead, do:
> >
> > bpf_token_put(token);
> > token =3D NULL;
> >
> > and carry on the rest of the logic
> Got it, thanks.
> > pw-bot: cr
> >
> >
> >> +       }
> >> +
> >> +       if (!bpf_token_capable(token, CAP_SYS_ADMIN))
> >> +               goto out;
> >> +
> >> +       bpf_token_put(token);
> >>
> >>          return btf_get_fd_by_id(attr->btf_id);
> >> +out:
> >> +       bpf_token_put(token);
> >> +       return -EPERM;
> >>   }
> >>
> >>   static int bpf_task_fd_query_copy(const union bpf_attr *attr,
> >> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux=
/bpf.h
> >> index bb37897c0393..73c23daacabf 100644
> >> --- a/tools/include/uapi/linux/bpf.h
> >> +++ b/tools/include/uapi/linux/bpf.h
> >> @@ -1652,6 +1652,7 @@ union bpf_attr {
> >>                  };
> >>                  __u32           next_id;
> >>                  __u32           open_flags;
> >> +               __s32           token_fd;
> >>          };
> >>
> >>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD *=
/
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_i=
d_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.=
c
> >> index a3f238f51d05..976ff38a6d43 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.=
c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.=
c
> >> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
> >>          if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
> >>                  goto close_prog;
> >>
> >> -       /* BTF get fd with opts set should not work (no kernel support=
). */
> >>          ret =3D bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
> >> -       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
> >> +       ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
> > Why would your patch change this behavior? and if it does, should it?
> > This looks fishy.
> I agree this does not look right, I think the test itself is not ideal.
> The behavior this test checked for has changed,
>   `btf_get_fd_by_id` was returning EINVAL from here:
> ```
> if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>          return -EINVAL;
>
> ```
>
> That no longer fails because I added new field (token_fd) to the attr
> structure.
> Function now fails further down the road.//I'm on the fence whether
> delete this check at all or change to new error code.

Ah, ok, so I did spot a problem then. You need to add validation of
valid flags and reject any unknown flag (test provides "unsupported"
BPF_F_RDONLY). But let me look at the latest version first, before
submitting a new version.

> >>   close_prog:
> >>          if (fd >=3D 0)
> >> --
> >> 2.48.1
> >>
>

