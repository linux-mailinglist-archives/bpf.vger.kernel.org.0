Return-Path: <bpf+bounces-58619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF5ABE5DA
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A01E7A5AD0
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00725CC49;
	Tue, 20 May 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtAk8tY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9889259CAA
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775687; cv=none; b=Ob9luUDRMTUvKqSMZJP8BFNrjKj8QoUDm3fZ5c9pwhwvApq0LWnkI+yI+unVUo1Xr9uwRZ7m4uWArdBTgD1GSyd7LwC4EaOayctVP10uvPAMq//h+qq+s4SiCSsBFHok95ome9yMsoupxMBg+E2QHifguQNhy/uSieFpb7klivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775687; c=relaxed/simple;
	bh=ADqo1PDr5u7SLayryYNCHMMcPKyagpdp7T6194Wbk/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIOHIBiLwImnMAmUgwFZe4mIaPrDQQbOwmVxerty9DJ8fN7SLkbGfGgR4NM7r2LmH8nO/wG+5XfdfD7+YMuAxUIkdB0oMwfxfaMIN3kfJCWfLPGGinkf4RN1wxcjO5feogOmLK6UR7aRAkkQ75KaSdPwYQtDfFcNACzQ+XHOxcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtAk8tY1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a37ed01aa0so106364f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747775684; x=1748380484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqmLReVbEP+YEZSDQUN7iJfpSWMv+FBNGCJ8AuGnaUw=;
        b=MtAk8tY1Z6T1MumZaktisiIe82I7Q/fhK0sOq/PKwMu7t/yPEHjoVVLPDI3ernBqo3
         tplDVHSNEKXxbNsjh30aaaiswfzNeQwWihvDiblq25G/jOextbQT8JEUZEvs77ROQxhT
         7yw+YwQRPZNRyusn9taLWF9vdyNJDNjhHVsr3ur0caFk/F7wmvvZ5cQo85LjkEHcFug1
         YAhz9Dit5pAw4iyr3O/i6XBUblrmRLDr7UTDMaJv5m2LwT4cJ4CtCp5ldjn1L3PRGGch
         bor3Fh9usCThClzYKRkl+71Sx2NkKBEqqWwR2IBncgC9mb6HJrhc5gViGEabGuOgN5lI
         wsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775684; x=1748380484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqmLReVbEP+YEZSDQUN7iJfpSWMv+FBNGCJ8AuGnaUw=;
        b=gi3Af1ESitYFCL5y3hqdmqEW5LVWqh3RXetGTjPHrosgqre5LUyucNrhSNsudxq0RE
         BO+nLsQUl/5Jx0NHPme2lYZ9A/Gyt5yjbsONwCdLEuuuAg7/sVxzjkDv6HYZQcJukvUQ
         EKUWjsNfDXlzTp508dXq2KgpqKo7FFvA6gMWaf2m/41QiXUbXsXJhmMCJVGxvmN/T+Ud
         MeWRhFi83QB1XqK3YF3tIU11mOqGAm5JUEZBRYWJVEJ1vAarRPjfFOHR/tC64tTER1pm
         nXQTeMoaxF0r8Ytu8q27Y3MmEmIgN9+uGOxsiCIc5z9RiSbGjFkAo6YSo++hMojIBZ6r
         DqvA==
X-Forwarded-Encrypted: i=1; AJvYcCWTXBnYootatALXyHvRfGXy0jDQe88p1MY3tuBN/w+Su/G1+0Pa8D9Fk9nyxZUE+NWRyXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyphet+waW1G1toTKC0VhGrnwrptw8ypxzcbRcPszjAf+Ck5tqS
	Ebn3kXLu/XpHoKHsgsMvNIyhMNsRNozHlXri/MG3wHmwMDB1laR7G/4Z+Gy+cuewv6OmM5I4upR
	zY8dY2M50s0LVVTty31Y2GYAX24GokcQ=
X-Gm-Gg: ASbGncuZEriRJ09KFkPkwFVSG3k5UPpmXIafZNCc1l6vQbHpcR3Y9msSNTJgOv7o46q
	2N7ErCA/9VFOfC3+2MMDU2ef5S8O+87o1RroKEW+kZCdLwhozAE/UT6xKMQ+QrgLnmamtg1S9Ok
	gmZjxtLgRMAcBLKMREPCuSee6tBtl6dN9DhJIQ1vDbf82k+vwW+g6Lqtc4K2AwJw==
X-Google-Smtp-Source: AGHT+IFoQHjp5Pktz82PNAp2V7AT02wesy01xWl5wclKUYJA3pUpkj/NJ7HMNOFxgq/ocvkwuKJvUhrcDxacB1d8nZg=
X-Received: by 2002:a5d:4ec8:0:b0:3a3:62fa:fb85 with SMTP id
 ffacd0b85a97d-3a362fafcb2mr11947343f8f.28.1747775684034; Tue, 20 May 2025
 14:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519203339.2060080-1-yonghong.song@linux.dev>
 <20250519203344.2060544-1-yonghong.song@linux.dev> <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
 <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev> <CAADnVQLvN-TshyvkY3u9MYc7h_og=LWz7Ldf2k_33VRDqKsUZw@mail.gmail.com>
 <1330496e-5dda-4b42-9524-4bfcfeb50ba7@linux.dev> <CAADnVQKipc=mML1ZjcMjKgKrP_L+wUPhAo0feFf6=DVqdWpCPQ@mail.gmail.com>
 <c9972e17-1a8a-4178-be33-9c18b2d39d57@linux.dev>
In-Reply-To: <c9972e17-1a8a-4178-be33-9c18b2d39d57@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 14:14:33 -0700
X-Gm-Features: AX0GCFtHql69HGob-RqJEWYElZa5PqOfxn36piVM98a5a-Bt8uHB1BVmgxM6l0o
Message-ID: <CAADnVQL1ZFL3F9cOq6C=TSgBOdHDUbozJRLOC+SihMzN6TO1uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:59=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> The option 2 probably better as we can avoid redundant check like kfunc_i=
d_allowed().
> Also we can have
>      bool is_meta_btf_vmlinux =3D meta.btf =3D=3D btf_vmlinux;
> and use is_meta_btf_vmlinux instead of meta.btf =3D=3D btf_vmlinux

How about option 3:
factor out the whole chunk of
meta.func_id =3D=3D special_kfunc_list[..]
into its own helper function
int check_special_kfunc(env, meta, regs)
{
  if (meta.btf !=3D btf_vmlinux)
    return 0;
  if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ...
    regs[BPF_REG_0] =3D ...
    return 0;
  }
  return 0;
}

and here it will be:

err =3D check_special_kfunc(env, meta, regs);
if (err)
   return err;

if (btf_type_is_void(ptr_type)) {

or something like this?

