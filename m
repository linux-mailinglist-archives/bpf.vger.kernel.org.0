Return-Path: <bpf+bounces-73768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D5C38C92
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C931888002
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9C21C9FD;
	Thu,  6 Nov 2025 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbR0LTd5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FC191
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394616; cv=none; b=J5orIOPENzCOiJ059VzFUF3b2f5fmMP+Ho+bkc5loS8ywCXKWNrRR1TnyqvPCp8mv2TgPqrc70gGVwajB9ZhSG2ht/d26kF8qVfoHa0vtDuLpWsCRh7WrZRtnTCJmGhIi0Y+QDYlQt8tkSpBY/PiM2ouUtYxCl4STTpf9JmjH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394616; c=relaxed/simple;
	bh=aEcd+gzSijM5BCC7CzNQPs/J9iXoHYudB+tc0nmvGqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTjdZ0hm6UVhziJv2xqKnFx2mLH/UOebh8X1uHKXuc5zjuZMiv6FGT/klOlOy3mQT+aLztlxFK4dT4Q+Wkn5yE+XnP+/Ts7wFiHqcEwxx15dBs16kp16ekG5RPeroC9sy3BJl97rFlKTKi0+2RfqtrAypBbqXYW2ii9tdtLGzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbR0LTd5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7ba208eso276275f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 18:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762394613; x=1762999413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rirEDLhxVUl/hEltccKtuX1aWYYN3c/LsdEMKxUms2M=;
        b=NbR0LTd5wpmSWksFnFNh2rnExzItL2zBCq/PaaBTWXY5hJ7OPGsMIuvLngIkyURZ2a
         hmjsXHsO7EgqJsXezbgHjBgpMQ1Q/UQjg67k1ZIzn1YXHw7k15PQN6mJZogUb6k4jFP5
         11y/Y+scvL91LeWY+9ErdkyQ5z0dYZZ+5ScplwGyStqx5XO+6g4G9/hCAbRnreKK30vB
         2xr3bgC/3EBCuRfCPa5O7guRP00k4gxa/OQqSi1Ef8rTPwDS6dreWBO1eD1xVqi/1gOG
         RyvAWUuo/GmGbJlZVNsso1TxIm8X9T9/S+hI+kmyhvyZsOSC9Ky4VIt8p6YrCItfrQon
         jtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762394613; x=1762999413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rirEDLhxVUl/hEltccKtuX1aWYYN3c/LsdEMKxUms2M=;
        b=P6wx1ygYhoNXD4uloECvjxAP7Cg0U80KMHBYHYrVqnpLswvLaDkx2ID+eq5WTsfVEc
         NYlZTsMGQEs7+9/dMYnHr8qXmdmXGK0vPn0dHhBskEuKzr0mG/zFDI/QgBdBTF8NlvfP
         rDhD39Oj35WOP75A9LGrxgUdmQxoOtRId7NIl5SJ6eFEn9aVRaqcbuc/l+tTThij9mub
         IHg6AM3El+mNnzQ+zJk2lkB2vtxrdtEOsR0fXDasNmQY0Kc24Uj4ARbiEksMvsOU3rVW
         RkkaL2WJLYnTeMgZVFOxYONCm8X41fz35tBJS408SFvt/GBZh0xB7aaQA7AGaqrbCJNA
         EIxw==
X-Gm-Message-State: AOJu0Yx69VtqGC985ZzXipDErx97Mr6uCA+ja+ZjkRndLWhQeqX1NvGz
	uBw0CDEau/XJgBtaLczf5E/3SkjcMgmiQGUoGYCt43G5wOYoEt1dzalrO4O/3cl/uV1pHPujL9C
	cJBXaW95B1lhWRbQfMQylKNUFrqd4TXGbAohQ
X-Gm-Gg: ASbGnctibgpJc65VxfDWFuch/Iu1to8/ciaeDh900ntqajIIlTaheYxpMIuXoJkoKxA
	qy9iXGxZZiKGPa701kzGUNsGZNslfhaAG/x7NVD/2V+LBFP6Kfy6SBNm1MyA578EEcvjq0qNixb
	3k4gOQEAnjbKmNXYKyeB6bfoJ5c+v3np7N/CM0iiPCTlmvmzTEHtwcY4RupclG0joX34iruSw9Z
	TpYcDwd1rFTf+ZTQMA5Q+1yEf/CD3Ldnd0WDNBCy8aMvdBb8o5lRK5Ssx1KcfleuSWn/LkqZDC5
	heXhJwNFrnIIx9LoUQ==
X-Google-Smtp-Source: AGHT+IH3XdvOaHiMoulQX58bHpH4lJe8OkwK/KpB6d62nUjxRW9+dbsd6V/yrFtsXo4eN8JDlb3xfsTsoGLnSdmOwEg=
X-Received: by 2002:a05:6000:4304:b0:428:55c3:ced4 with SMTP id
 ffacd0b85a97d-429e32e3678mr4077403f8f.18.1762394613078; Wed, 05 Nov 2025
 18:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com> <20251105090410.1250500-2-a.s.protopopov@gmail.com>
In-Reply-To: <20251105090410.1250500-2-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:03:21 -0800
X-Gm-Features: AWmQ_bkJypmng-QtuMVrH5-x2QpiJs9WOX8ZaMu3ZKrDrwvmuTJpA4bTep9JDOE
Message-ID: <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:58=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                 func[i]->aux->jited_linfo =3D prog->aux->jited_linfo;
>                 func[i]->aux->linfo_idx =3D env->subprog_info[i].linfo_id=
x;
>                 func[i]->aux->arena =3D prog->aux->arena;
> +               func[i]->aux->used_maps =3D env->used_maps;
> +               func[i]->aux->used_map_cnt =3D env->used_map_cnt;

...

> It might be called before the used_maps are copied into aux...

wat?

on top of the set:
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 61ce52882632..97fcde6d7f07 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -278,8 +278,8 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog
*prog, u32 *offsets, void *image)
        if (!offsets || !image)
                return;

-       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
-               map =3D prog->aux->used_maps[i];
+       for (i =3D 0; i < prog->aux->main_prog_aux->used_map_cnt; i++) {
+               map =3D prog->aux->main_prog_aux->used_maps[i];
                if (!is_insn_array(map))
                        continue;

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..53b9a6cee156 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22096,8 +22096,6 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
                func[i]->aux->jited_linfo =3D prog->aux->jited_linfo;
                func[i]->aux->linfo_idx =3D env->subprog_info[i].linfo_idx;
                func[i]->aux->arena =3D prog->aux->arena;
-               func[i]->aux->used_maps =3D env->used_maps;
-               func[i]->aux->used_map_cnt =3D env->used_map_cnt;
                num_exentries =3D 0;
                insn =3D func[i]->insnsi;
                for (j =3D 0; j < func[i]->len; j++, insn++) {


all tests still pass.

If I'm not missing anything, please send a follow up.

The plan is to split prog_aux into main and subprog,
and subprog will be a fraction of main.
Right now we copy more and more fields for no good reason.
Let's avoid this.

