Return-Path: <bpf+bounces-75438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E993BC8493C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42DB134EFFE
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A954313E3F;
	Tue, 25 Nov 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWEGupkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD32DAFDD
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068107; cv=none; b=H30HFODqkxx9fumFfVagDi8lvKsre68q3PtZmWSUcuGO7smkwoc+Ik08C70kfXSH8Tj9Ff1ewTDtZN8qejWrThyrcUfbmTCwg1Ec3ENzgAAudVu7ZmUNf2NdRhq38AWv/WapC/mmm22uZzJ+5XJfb1elBR7CIzIgb1iBCPoXhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068107; c=relaxed/simple;
	bh=WvqPbF620+xM9wVA25v8fRqvdA41+udqwS/iVF1Sn/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+24qsPiRS9lv+RVuTniYl70ZKNiW8dlEpSfNdreCFeFp182O7gzsyMglwBnLyQDEOMYbbbrp8cjrvP4vonCYbUmcAPSUlo7ItNtAJUChPozO7yx3ZH4MUQYO2BsdXaLP1iYzCArHodwgBOwgOKcSLEnOMYkGsMT/h3Lm+O7a0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWEGupkz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edaf8773c4so62259791cf.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764068105; x=1764672905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvqPbF620+xM9wVA25v8fRqvdA41+udqwS/iVF1Sn/c=;
        b=kWEGupkzUxye8GR6aLcUTAJIqQy8GhSTCB7O7QfhAX6HP2trwZqtSbbR22HUls+ZBq
         rVqgtV9/WqDiAt/XrtgXRoyaweDU07qyvScpdtpJY1t5u4D1aPNq+fsGzbTfDKhy8c5O
         CRTisi4oRTquHqrGMrpSJbABzedJ+wwUk4vlb2/2/mfrjWVF3vxoe8Oi+3Vg/j+ovMUy
         0FjEsfuoAt31EuYBfUoNK+grU1ht+j8isXQKWWN1SKq/dlnOT1vWYAm9De8ObhZ7949I
         Qn7rs2GdLQFDSuidqeImqZmvHythBeI2QLHn/cHdaWmOiD+IbAq0SCWTGYi0VC5oh/xO
         cyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764068105; x=1764672905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WvqPbF620+xM9wVA25v8fRqvdA41+udqwS/iVF1Sn/c=;
        b=v/hO/N4Z8WfQaTpmDuqvK6fDueL+/i2oiNzTiZ4Btng8qyl1LmlTBYGWBqxot8e0Fg
         H4J1xt6XQPPrmblExYg11asjZMpKXSkVLFR3vxfROTdezx5s5feS9/qGsycWL4g/judz
         3/x9S4YdHes4f1cV/pUQR9QmqC98PPyJsaPNNiCB9wMUxLAZxQ0L2fOe376ovBG6vNJ3
         57GVgl3XKnJhNwUBa/2daWnlx+8AfGvde+ZSuteNQZDcLSYvAD+zutFXdtmfj24DPJr7
         n3zo0k7d+0eFq3IMD2i+xNj5omvIlQS3k+j2vPrbb+vMcHc8sKIkkWYxsr8SP8H9BwTt
         Vbcw==
X-Forwarded-Encrypted: i=1; AJvYcCXt0S45/yCsD4UT/WQb8xim0Ccsa7UN2NgjwCDBIa8BM2hnkom7deKQb8nXPcoF9swVZEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsJNJA2EHJSy4t3xGkh/mk0XmdBY/Bm1DEi2fLIfFQzyF845U
	aYKnCHhEqwNBvQSCXliB2gpzx5C5DJwEm6FpebpKz5wltKNWajo+OeDsODdxoXuVQ/xyU0hgKcL
	pZyYlF5Vy781A1e3rf9MnDwxvd3yYwWo=
X-Gm-Gg: ASbGncs6kr/UwJyK3ETCyfV/9N+TVcpxtPoosk2ggP7dCWGqkUHSURy6OpHC+Qd55Rl
	O4aNJ/BM03GLxRGE+wai3GoepdiCcYfUmrw+GzRemc7l+m5qMbeBjBhXAXqVJZl5RgLilpRjVRW
	lJK+ssq+/iF1oZn4byUby0rH+0Vgc9UGXzlYDL8W1NHjDhtra+OriV/zfrqL3MbpfD3DDM1La6g
	6eBpSswFktZlJ9ZtAKFo4KtftVMEbhg5CBebUYIAfJoFQTBixq3ySzTHrQUOqfb+oBFZaTU
X-Google-Smtp-Source: AGHT+IEEWYB6g7B8HT4spoEy8ZHr6dVhVWOuaHPxKGkLD9VEUc2G2Kvyn/hhjC4+dZJWXcy1/7FNAfvOUjoJk0GX7k8=
X-Received: by 2002:ac8:5749:0:b0:4eb:a07a:5fce with SMTP id
 d75a77b69052e-4ee58a446c8mr171803821cf.17.1764068104880; Tue, 25 Nov 2025
 02:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com> <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
 <CAErzpmvJ+D2c_3pLG-t5ZD2cj7kDJX=JDnJ0CxNUf5pYR24a+g@mail.gmail.com> <3a9bff10-7f55-45b1-a57c-08786a27f5ed@linux.dev>
In-Reply-To: <3a9bff10-7f55-45b1-a57c-08786a27f5ed@linux.dev>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 25 Nov 2025 18:54:51 +0800
X-Gm-Features: AWmQ_bkYmmdrUxRIHTODp6dNgWdG1jv9NOj2B6d9ZFdEyCgDMeZdyTDW7Km2NbM
Message-ID: <CAErzpmv-nRh701i6p8F5p=zgfOMoKzd8uXTwiqi9+nNVbaAj3w@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:35=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 11/21/25 7:36 AM, Donglin Peng wrote:
> > On Fri, Nov 21, 2025 at 5:34=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 11/18/25 7:15 PM, Donglin Peng wrote:
> >>> From: Donglin Peng <pengdonglin@xiaomi.com>
> >>>
> >>> This patch introduces a new --btf_sort option that leverages libbpf's
> >>> btf__permute interface to reorganize BTF layout. The implementation
> >>> sorts BTF types by name in ascending order, placing anonymous types a=
t
> >>> the end to enable efficient binary search lookup.
> >>
> >> [...]
> >>
> >> Hi Dongling.
> >>
> >> Thanks for working on this, it's a great optimization. Just want to
> >> give you a heads up that I am preparing a patchset changing
> >> resolve_btfids behavior.
> >
> > Thanks. I'm curious about the new behavior of resolve_btfids. Does it
> > replace pahole and generate the sorted .BTF data directly from the
> > DWARF data? Also, does its sorting method differ from the cmp_type_name=
s
> > approach mentioned above =E2=80=94 specifically, does it place named ty=
pes
> > before all anonymous types? I'm asking because the search method
> > needs to be compatible with this sorting approach.
>
> No, replacing pahole entirely isn't really feasible, and unnecessary.
>
> TL;DR is that resolve_btfids will also do kernel-specific btf2btf
> transformations. The sorting feature is independent, it's relevant
> only in that it is also a btf2btf transformation and will be included
> in the pipeline.
>
> I described the approach here:
> https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linu=
x.dev/

Thanks for the explanation.

>
>
> >
> >>
> >> In particular, instead of updating the .BTF_ids section (and now with
> >> your and upcoming changes the .BTF section) *in-place*, resolve_btfids
> >> will only emit the data for the sections. And then it'll be integrated
> >> into vmlinux with objcopy and linker. We already do a similar thing
> >> with .BTF for vmlinux [1].
> >>
> >> For your patchset it means that the parts handling ELF update will be
> >> unnecessary.
> >>
> >> Also I think the --btf_sort flag is unnecessary. We probably want
> >> kernel BTF to always be sorted in this way. And if resolve_btfids will
> >> be handling more btf2btf transformation, we should avoid adding a
> >> flags for every one of them.
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/t=
ree/scripts/link-vmlinux.sh#n110
> >>

