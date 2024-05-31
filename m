Return-Path: <bpf+bounces-31064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39D8D695F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DBC28709D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CDB7F7FC;
	Fri, 31 May 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dspue9k4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F484653C
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182307; cv=none; b=FPSFw28YniWPyi2v5DnW1F/BmmVq9JVkX+B1e8k+uy6wqN09TPPoaPK00OT8H9b+FIxCGngsruo5XB4aTetAuAeU0upHB+I7AhyahegkSHn3uO4lwto8oi119xtwlc/CalmzngEs/ao96sL9yx/jTZ5kms4ZAFjZtK0ioN3cFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182307; c=relaxed/simple;
	bh=aSS5NfYlmOCzU2xc7yd49k//RN6K03Rm2+CptPS4G0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXcP/yoWJKdRHLZkgeQ0MKA4rRtgKJkfnGFpVMP07keYs+HPIQv0goz6qL5duFfIGbxoh3VKTuGrJwWnMRj1FouC1YjMFBbNsX0V2cI3RKG0u1yJmsEil8KdLV4oUE8OdCM8FXn6bZ7dAF7L4FPPxO2Z1j17H1QeTT9LC6F7Hr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dspue9k4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so1840838a12.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717182305; x=1717787105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfBPeBkQGCVHW4Y6+Pguw5Z5pdjtdLzHJVPs7W7ViOk=;
        b=Dspue9k46pC63n/WRStwsx2bBfi39DiVQRxnlHLw8PpRtJ9LOx/ywrXhML8V98ZOzM
         AXJuIXARjHKciCjtJuME1/j3IS1teOVYPmDWeSeIfw8mGlSAsLNcmH56E+uSL/BSdYgA
         NdxX8RmatFJo4QVALdXTkJ6618EvQIpAK7U9JD+dTtgdQ14lNe/KLodx7cM08IGOE9gN
         tPnTLXvUEiPPXkjBsKL8HRDWJnIJlKJQ2XAUHf9v3/G3rYMFbVsyinxesoORN54llwvU
         heHn7PruEFIAK0EQkToc45Wvc6213iGX4SiML86RkA1Yz06N/6OBRTgaHPhUhmWV7apM
         zk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182305; x=1717787105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfBPeBkQGCVHW4Y6+Pguw5Z5pdjtdLzHJVPs7W7ViOk=;
        b=s1uKwp9pDtzV5LUR18lKVz95mqOlhl7aLoI8Ll8Z5fYyEZ29FiP0gv9NR1/u5hB84+
         RvTPP9JkGkPqLA14+aYf+XsIzfp+mQLsdU6prWTchOHV247pFkw4ssiNsDb/j2TyyOC4
         rYftCDkXu5fW2TqIwrIdNdipGnDtw6wsvA2U3KBprlJfWrs03yWFuM4g5xZB3+vpSkMj
         wuJc/670dehvc4HtB2ksDtWZcPtmGSETzNIoaWMml68eLPWTIU7AtpuXMWobHb8BiO3e
         j1WzVhg648+et4QM05uOS741q2oM5ntfrrlGCToCLr0jds7peJHCq+50V1YRjsrA71Fx
         VOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGdvUhOyOqIJfFU2p/ULsWlqpnywVbxyZwii0felgY4xDIeqw6q2TYvqdRKb5jNoWMaO441BMLrrBBC2C0ViBpFZCH
X-Gm-Message-State: AOJu0YzmTnnUIHv+hRaN12DctOBzvmZeQjZ3en1GLlmEdDTy9L/3GD83
	TI9zGffRfqXQREhRH6VicUdUBoQ2Kojw6RsLIqdTxyyEJNhlQLiSN6I9S7G9Vl6fAL+zz5KhZVq
	NEvZnQgQHVTplz/hdc2UJ0FKBM9E=
X-Google-Smtp-Source: AGHT+IFsg2OVRiyVgFvCk8Wrb0ONQ9Z/ExtCiOOKlQh6/L3B53IE7o8K/xcdiKi56Fd5yY7dMT11FPgIEYiO96t/WWs=
X-Received: by 2002:a17:90a:dc15:b0:2c1:9e98:70bb with SMTP id
 98e67ed59e1d1-2c1dc56c1e8mr2722538a91.10.1717182305553; Fri, 31 May 2024
 12:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com> <20240528122408.3154936-9-alan.maguire@oracle.com>
In-Reply-To: <20240528122408.3154936-9-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 12:04:52 -0700
Message-ID: <CAEf4BzaJQAyHmSOTyQaLCx29zFQZEZnHR+gaTNt-Ae5nvi7G6g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Share relocation implementation with the kernel.  As part of this,
> we also need the type/string visitation functions so add them to a
> btf_common.c file that also gets shared with the kernel. Relocation
> code in kernel and userspace is identical save for the impementation
> of the reparenting of split BTF to the relocated base BTF and
> retrieval of BTF header from "struct btf"; these small functions
> need separate user-space and kernel implementations.
>
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_relocate() optionally returns an array mapping from old BTF
> ids to relocated ids, so we use that to fix up these references where
> needed for kfuncs.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h          |  45 ++++++++++
>  kernel/bpf/Makefile          |  10 ++-
>  kernel/bpf/btf.c             | 168 +++++++++++++++++++++++++----------
>  tools/lib/bpf/Build          |   2 +-
>  tools/lib/bpf/btf.c          | 130 ---------------------------
>  tools/lib/bpf/btf_iter.c     | 143 +++++++++++++++++++++++++++++
>  tools/lib/bpf/btf_relocate.c |  23 +++++
>  7 files changed, 344 insertions(+), 177 deletions(-)
>  create mode 100644 tools/lib/bpf/btf_iter.c
>

[...]

> +static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t=
)
> +{
> +       return (struct btf_decl_tag *)(t + 1);
> +}
> +
>  static inline int btf_id_cmp_func(const void *a, const void *b)
>  {
>         const int *pa =3D a, *pb =3D b;
> @@ -515,9 +528,17 @@ static inline const struct bpf_struct_ops_desc *bpf_=
struct_ops_find(struct btf *
>  }
>  #endif
>
> +typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
> +typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
> +

let me take a quick stab at implementing type/str field iterator in
libbpf. If I don't get stuck anywhere, maybe you can just rebase on
that and avoid the callback hell and the need for this
callback-vs-iter churn in the kernel code as well

>  #ifdef CONFIG_BPF_SYSCALL
>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id=
);
> +void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **ma=
p_ids);
> +int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, =
void *ctx);
> +int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, =
void *ctx);
>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
> +const char *btf_str_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
>  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
>  u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,

[...]

