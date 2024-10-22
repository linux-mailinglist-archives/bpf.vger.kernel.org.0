Return-Path: <bpf+bounces-42822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BC9AB78D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321B31C23003
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD91CB302;
	Tue, 22 Oct 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBK4y0nM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4713E41A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628413; cv=none; b=GTrT2s4qRB5rI70H7Is8XpUyDnq/hRC4bNXwDXjX/jNev3pDxXfp1rmFpwjNBQPKU9ATcWS5xySXoNceJMxz44WvA2+RYMXUz/9u/1v4fNhBxoR53MDUl/0/m5N+zxgPmDuHWdxi6G/vILj6tAvDw/poZYNPFwNhFqJz/ZWQk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628413; c=relaxed/simple;
	bh=UxRj7DCvdFSOD2z/6zMkC/YPE5GC5mbvmwezpfMbY6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiB8emzkFt56AN9nSVG7lV/xxGdJ7woezxB1cIYEl5mtNQklr3X+Ne+oH8RuyYCIAa32mloCKKjYysrNPrA8lySp4tQTm7ryDU606DskuMWyE4fkH1+DAlZWoi//XDSOs+XbgNjJa+z66ehnQMPH3/Ed51DdjKrntbubs2wOPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBK4y0nM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5778644f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628410; x=1730233210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jfQZaVdIYnaYyct1hX2cLfgijuJxFkGrzsOwHQwU8g=;
        b=NBK4y0nMmR8FpUbHCs1/0a2p7AQx/i8N8Xy8uA3dkzSMAvbvLQw8mbBXLhLp2BLAZx
         biECqTrlryu59Ea6y6xPmPJxMT0vrHNZgJ/eZLTaZInUh0S4MrQqUEZu8Z8kgKCYJhb+
         qxqGOnIhI+3Y3T1xE+O830pcc90BPOzaSkh6KezAeXr8Glvu2zEaTeeNHTj1wRPuF7Wi
         vdkZiRVkszpaI2bqkGWeIxdOPqyHoNC/g3bmW2Dr3sEfulcMN+1nlY2cFQasnssh7wBG
         wjttX03oOBobrSMzm5v3DWr3aGH+TPmwEBsVmW32naB04cC6WZbaQgkTvbxe4cUNnKeE
         OA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628410; x=1730233210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jfQZaVdIYnaYyct1hX2cLfgijuJxFkGrzsOwHQwU8g=;
        b=BB/WxGNXReXUGLUjAHc2pBYro+ju9p957ZR98ovEoYoaKvj0EqP5DBKRcfEMjP9Pl/
         MhDYhzoR9oD3RC33s30topy0wKf/oG3YDexWDe3u8jJ7BdI5vogtv9ChekNhgbQ4J1nJ
         jVIttaQL8YuYB6d7sl2x8+PJXQGD3UKfhUhc5ptozB9G6j8ARCENmi4YSA+/jNgOe0AE
         wbKXqms4eoyhxUJ15q/iqmr5mHF7CoxwvHb/qawswe6E62QRfkQdcrxCNnCtMuVRZPIl
         3krOQs0+xNoy050wxYsYrpFE0VS3zYUHGu+GuU7Lu118dd0GZs2OKfX6y0lNhJUq/euQ
         U0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBI03HOH5LvlRrQXg/I4RZGpLOni7sYmnrNmg3gwWefAe9luPta09Cn3A2u1H4i26h198=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUsv+VsRTC9JtbmeXdklY5N9ijZ9bPDKZpAMXHLPY/uACMDIg
	6r46McdWd+PxubV7OcjogXE0UuUbNM3bjUTBUkP77j1Br8qBoOXh0W+0JDcaePkmpl8Ua9fzD7D
	Yddth1fKjs/UVxvodI1mQ1bevetM=
X-Google-Smtp-Source: AGHT+IGQ1El3yU7/4TP4aEXcoMaCNFyKM8qzVvI1ztp8JAJUANY4grXVM91uBhHZJQ6z0CEo5fEOIWiX58SelDAc6KU=
X-Received: by 2002:adf:e2cb:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-37efcf199ebmr154787f8f.32.1729628409820; Tue, 22 Oct 2024
 13:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191400.2105605-1-yonghong.song@linux.dev> <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
 <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev>
In-Reply-To: <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 13:19:58 -0700
Message-ID: <CAADnVQLEy+VXVeP96DK=U8wTL7Yj_=bTuxz5FBcVgDT346-2qA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct ops programs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:27=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 10/21/24 6:34 PM, Alexei Starovoitov wrote:
> > On Sun, Oct 20, 2024 at 12:16=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> To identify whether a st_ops program requests private stack or not,
> >> the st_ops stub function is checked. If the stub function has the
> >> following name
> >>     <st_ops_name>__<member_name>__priv_stack
> >> then the corresponding st_ops member func requests to use private
> >> stack. The information that the private stack is requested or not
> >> is encoded in struct bpf_struct_ops_func_info which will later be
> >> used by verifier.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf.h         |  2 ++
> >>   kernel/bpf/bpf_struct_ops.c | 35 +++++++++++++++++++++++++----------
> >>   kernel/bpf/verifier.c       |  8 +++++++-
> >>   3 files changed, 34 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index f3884ce2603d..376e43fc72b9 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1491,6 +1491,7 @@ struct bpf_prog_aux {
> >>          bool exception_boundary;
> >>          bool is_extended; /* true if extended by freplace program */
> >>          bool priv_stack_eligible;
> >> +       bool priv_stack_always;
> >>          u64 prog_array_member_cnt; /* counts how many times as member=
 of prog_array */
> >>          struct mutex ext_mutex; /* mutex for is_extended and prog_arr=
ay_member_cnt */
> >>          struct bpf_arena *arena;
> >> @@ -1776,6 +1777,7 @@ struct bpf_struct_ops {
> >>   struct bpf_struct_ops_func_info {
> >>          struct bpf_ctx_arg_aux *info;
> >>          u32 cnt;
> >> +       bool priv_stack_always;
> >>   };
> >>
> >>   struct bpf_struct_ops_desc {
> >> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> >> index 8279b5a57798..2cd4bd086c7a 100644
> >> --- a/kernel/bpf/bpf_struct_ops.c
> >> +++ b/kernel/bpf/bpf_struct_ops.c
> >> @@ -145,33 +145,44 @@ void bpf_struct_ops_image_free(void *image)
> >>   }
> >>
> >>   #define MAYBE_NULL_SUFFIX "__nullable"
> >> -#define MAX_STUB_NAME 128
> >> +#define MAX_STUB_NAME 140
> >>
> >>   /* Return the type info of a stub function, if it exists.
> >>    *
> >> - * The name of a stub function is made up of the name of the struct_o=
ps and
> >> - * the name of the function pointer member, separated by "__". For ex=
ample,
> >> - * if the struct_ops type is named "foo_ops" and the function pointer
> >> - * member is named "bar", the stub function name would be "foo_ops__b=
ar".
> >> + * The name of a stub function is made up of the name of the struct_o=
ps,
> >> + * the name of the function pointer member and optionally "priv_stack=
"
> >> + * suffix, separated by "__". For example, if the struct_ops type is =
named
> >> + * "foo_ops" and the function pointer  member is named "bar", the stu=
b
> >> + * function name would be "foo_ops__bar". If a suffix "priv_stack" ex=
ists,
> >> + * the stub function name would be "foo_ops__bar__priv_stack".
> >>    */
> >>   static const struct btf_type *
> >>   find_stub_func_proto(const struct btf *btf, const char *st_op_name,
> >> -                    const char *member_name)
> >> +                    const char *member_name, bool *priv_stack_always)
> >>   {
> >>          char stub_func_name[MAX_STUB_NAME];
> >>          const struct btf_type *func_type;
> >>          s32 btf_id;
> >>          int cp;
> >>
> >> -       cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
> >> +       cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s__priv_s=
tack",
> >>                        st_op_name, member_name);
> >
> > I don't think this approach fits.
> > pw-bot: cr
> >
> > Also looking at original
> > commit 1611603537a4 ("bpf: Create argument information for nullable arg=
uments.")
> > that added this %s__%s notation I'm not sure why we went
> > with that approach.
> >
> > Just to avoid adding __nullable suffix in the actual callback
> > and using cfi stub callback names with such suffixes as
> > a "proxy" for the real callback?
> >
> > Did we ever use this functionality for anything other than
> > bpf_testmod_ops__test_maybe_null selftest ?
> >
> > Martin ?
>
> The __nullable is to tag an argument of an ops. The member in the struct =
(e.g.
> tcp_congestion_ops) is a pointer to FUNC_PROTO and its argument does not =
have an
> argument name to tag. Hence, we went with tagging the actual FUNC in the =
cfi object.

Ahh. Right. That makes sense.

> The __nullable argument tagging request was originally from sched_ext but=
 I also
> don't see its usage in-tree for now.

ok. Let's sync up with Tejun whether they have plans to use it.

> For the priv_stack tagging, I also don't think it is a good way of doing =
it. It
> is like adding __nullable to flag the ops may return NULL pointer which I=
 also
> tried to avoid in the bpf-qdisc patch set.

