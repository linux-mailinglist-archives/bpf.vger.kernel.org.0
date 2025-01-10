Return-Path: <bpf+bounces-48608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E6A09EC7
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04CB168FFA
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86E222587;
	Fri, 10 Jan 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4unY5TT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF920764C;
	Fri, 10 Jan 2025 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552314; cv=none; b=NHqaWuvD8Vj7so7JO3VrjjqrcYwWiitMESHW54h8R3Ns0O8ZUi54V266F/H4em5bNsrNzW5QaGKo5Pvy1xkV7SyUvkVdfiecmbyt544Adt7XmLddhtK96mErz08ccooEib+FtpMkgKQ6QYcSlOlH1iEm7rt8Al+zYOoi+mVEp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552314; c=relaxed/simple;
	bh=3NKoZhNOgr5iFSLiZ4xbSgnRTMH5vHQGH8A8hKAH1pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilXglLzrMEEPSgPYntvhVmcmBBI96tLM1KSi0r0Rzp0TR8/sZKk0AEYpONPYW4xky61QzbNjVEa7SPCxtsSmTBPbYAtQzxvJ+NOvl8xdNprOlkt2QexwUvekySqGc0MrlpGog9F9CsJuWUhwYEpCgDOTU3L9dPHMxt9SU9nHGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4unY5TT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso3393871a91.2;
        Fri, 10 Jan 2025 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736552312; x=1737157112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2+Uo0uj2M05vhwWgf9+wkXJ00BoAN2Uo3Mf7BisOr8=;
        b=L4unY5TTZUn4UiFceRffMMP1YFzdnsk6jpc0gC72wsC7xAAXDHvLtpC5t7nbcx3QK0
         0IULU+FLV4HI3yGUNYwqwjPG+fLFst802Mp73v0Zui+enm2AJCGxKE4VFSewzcDyEvUA
         OE/VNRMiQK2w8TcVXQI7vS57VYSsiX3kf/Q7U/bgHlZOWvkrkIG3FV1N6Rm50WnL9keD
         0S+sVHiY63gqnKxmXQc3TrHOYjZTIPF7CcebVTl3UB21UvFs8vQXU/3ASvFD7lUqtLVY
         e3MWZ+c+V/6bO8so5L3hAxtoZqIH/KsRpyReeuDEP9XfrLk8R832XNiq/fIIcqN9hiuy
         6Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736552312; x=1737157112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2+Uo0uj2M05vhwWgf9+wkXJ00BoAN2Uo3Mf7BisOr8=;
        b=PA86ljPxK0VuSR7/me84RjWJsYsWntyKSN6hSTROmt9F0XjPYiGoUddXYD0vp+/pHG
         EqFPoPCJ/DwiavT+4VcTbebaMDg109GOWjCY/mIKodkj3zAw/Jc8ZF0vxwmReKXqo28X
         1001vF32h65a0nDqQjPfheXg2ZvL6IQ8lEwrhgsbhgTU0qoqkea/V5QAwEcJXfhqxlkF
         jhVycG5NHPXFbK6MmT2LehnzxDmNKzEkdzNhNTI7KfBEjSfEtW61q6SB/obexvRg8qwD
         AX37UI092bybRHic8VBZzZPVrBcwh/6EDrwhHHfj7iit0d5tXKJNSY1nwYsIb6OXPUYR
         HMaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdNKrNhXMtQwLbTycEqnYd99Ln7dZYI7pXAeXtyn9G3Is7QTk+1EcJhsFy1laQcI3CqGGzQ8xdt6Mnyw==@vger.kernel.org, AJvYcCVnO2h4FSC3HHmHmhgTtSJ+mwn41aieeoBazO0ExjnZW8SpjSIl+3s5pq+s09GnUZwtSYSojRAI7P3ctw==@vger.kernel.org, AJvYcCXRtp6Hk6aj8IOF6MBkCUL7c/2OzND/8XV7guudVWk9Qw1UFk9u/MdCsenzXdv4MhSkEzrduOcr@vger.kernel.org, AJvYcCXrT/yAvbBwef25ul5TP4O0bzZnClhVf7iEutbrjKktd3Rp15EAv1JLf/ovSU6KZUtihV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpqcYufmiyTzQ3VOVX5vpWGLXMYD4vnDpwlCpWvczoXbLvKM8
	hsx4NNBQZRXg+7H+zAMR3r5sieXxyRDd354pVTnfBMuYJ2u2PdEzWFS1SAP8RytcgjfAYQncHAV
	KShJUa7C05mNYPRHtl6sQmoH+OEc=
X-Gm-Gg: ASbGncspR36xiJ3w79Co10DlS9iS83caACHe+8FPcJRdtdq3wSygNimJZVEdo/MocLh
	jMKNDEDHGUJWIxaEX5Pr2le9M8ufRpkOx23o1zCKy+QREEL2t00NxMQ==
X-Google-Smtp-Source: AGHT+IHu08nRpxiA1SlM2UtovuESnRCpZ0agU4YUHB3J/Xxa07EK0xE3pcpIGy9h9BnUqKJKuVCF0+Hw7csllIj8eko=
X-Received: by 2002:a17:90b:4a44:b0:2ea:61de:38f7 with SMTP id
 98e67ed59e1d1-2f548f1d420mr18769661a91.29.1736552312160; Fri, 10 Jan 2025
 15:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218024422.23423-1-alibuda@linux.alibaba.com> <20241218024422.23423-5-alibuda@linux.alibaba.com>
In-Reply-To: <20241218024422.23423-5-alibuda@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 15:38:19 -0800
X-Gm-Features: AbW1kvZfBu24fUaDzr3NwYyzCcTSSYsyF6zLHRqrIfmRcixRNKPuH2nvUx_OIKQ
Message-ID: <CAEf4Bzas7E4bSFnxiObJysf4hDv2AJVd4B4Q+me1wmGtdHVVbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com, 
	yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 6:44=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> When a struct_ops named xxx_ops was registered by a module, and
> it will be used in both built-in modules and the module itself,
> so that the btf_type of xxx_ops will be present in btf_vmlinux
> instead of in btf_mod, which means that the btf_type of
> bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
>
> Here are four possible case:
>
> +--------+-------------+-------------+---------------------------------+
> |        | st_opx_xxx  | xxx         |                                 |
> +--------+-------------+-------------+---------------------------------+
> | case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> +--------+-------------+-------------+---------------------------------+
> | case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> +--------+-------------+-------------+---------------------------------+
> | case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> |        |             |             | vmlinux and mod.                |
> +--------+-------------+-------------+---------------------------------+
> | case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> +--------+-------------+-------------+---------------------------------+
>
> At present, cases 0, 1, and 3 can be correctly identified, because
> st_ops_xxx is searched from the same btf with xxx. In order to
> handle case 2 correctly without affecting other cases, we cannot simply
> change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> to find_ksym_btf_id(), because in this way, case 1 will not be
> recognized anymore.
>
> To address this issue, if st_ops_xxx cannot be found in the btf with xxx
> and mod_btf does not exist, do find_ksym_btf_id() again to
> avoid such issue.
>
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  tools/lib/bpf/libbpf.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..56bf74894110 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1005,7 +1005,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, =
const char *tname_raw,
>         const struct btf_member *kern_data_member;
>         struct btf *btf =3D NULL;
>         __s32 kern_vtype_id, kern_type_id;
> -       char tname[256];
> +       char tname[256], stname[256];
> +       int ret;
>         __u32 i;
>
>         snprintf(tname, sizeof(tname), "%.*s",
> @@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj=
, const char *tname_raw,
>         }
>         kern_type =3D btf__type_by_id(btf, kern_type_id);
>
> +       ret =3D snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE=
_PREFIX, tname);
> +       if (ret < 0 || ret >=3D sizeof(stname))
> +               return -ENAMETOOLONG;
> +
>         /* Find the corresponding "map_value" type that will be used
>          * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
>          * find "struct bpf_struct_ops_tcp_congestion_ops" from the
>          * btf_vmlinux.
>          */
> -       kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_P=
REFIX,
> -                                               tname, BTF_KIND_STRUCT);
> +       kern_vtype_id =3D btf__find_by_name_kind(btf, stname, BTF_KIND_ST=
RUCT);
>         if (kern_vtype_id < 0) {
> -               pr_warn("struct_ops init_kern: struct %s%s is not found i=
n kernel BTF\n",
> -                       STRUCT_OPS_VALUE_PREFIX, tname);
> -               return kern_vtype_id;
> +               if (kern_vtype_id =3D=3D -ENOENT && !*mod_btf)
> +                       kern_vtype_id =3D find_ksym_btf_id(obj, stname, B=
TF_KIND_STRUCT,
> +                                                        &btf, mod_btf);
> +               if (kern_vtype_id < 0) {
> +                       pr_warn("struct_ops init_kern: struct %s is not f=
ound in kernel BTF\n",
> +                               stname);
> +                       return kern_vtype_id;
> +               }

purely from the coding perspective, this is unnecessarily nested and
convoluted. Wouldn't this work the same but be less nested:

kern_vtype_id =3D btf__find_by_name_kind(btf, stname, BTF_KIND_STRUCT);
if (kern_vtype_id =3D=3D -ENOENT && !*mod_btf)
    kern_vtype_id =3D find_ksym_btf_id(...);
if (kern_vtype_id < 0) {
    pr_warn(...);
    return kern_vtype_id;
}


>         }
>         kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
>
> @@ -1046,8 +1055,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, =
const char *tname_raw,
>                         break;
>         }
>         if (i =3D=3D btf_vlen(kern_vtype)) {
> -               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s%s\n",
> -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> +               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s\n",
> +                       tname, stname);
>                 return -EINVAL;
>         }
>
> --
> 2.45.0
>

