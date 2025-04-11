Return-Path: <bpf+bounces-55787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59021A866C1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB134C2F0E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056328152A;
	Fri, 11 Apr 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mijS2O8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC721280A21;
	Fri, 11 Apr 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401794; cv=none; b=nbAcYa4plZ/Y99FqkI6+PSKsKdz5v/LlDcZyfy1hdxPxiP0L/ZX5j9ebjkYLEiaFdVz+IL27bPJBOtBbFSEAYTBO3VtR778Rwg3ZktP7FpuwkTGfxX5ggW00knnMx1tYN/lgaEtYy4PHSZ8fUJy9KvYAr568BL5/IfdRoIRNxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401794; c=relaxed/simple;
	bh=WrzflKNEW7LUuZ1yEyggMY9woYQSBwBr8weVr3lx7mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At88FvkmvO6Sv+LiUP5Ys27Pv/DG1SrRZOStw77zaMCU1P6Ap0GpLe2RjLGR2FV4VkLqJZH9WzIf/R8OQfEugl6/kmP+t5i8RtJFlKxJmH1ZkPNx0wOIPKJk8h0e988cxBjR+KhySJrfST/xxYE986SlJyLU5c4PG5IEfbZIc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mijS2O8e; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fecfae554bso21382697b3.0;
        Fri, 11 Apr 2025 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744401791; x=1745006591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrzflKNEW7LUuZ1yEyggMY9woYQSBwBr8weVr3lx7mk=;
        b=mijS2O8eklI0E9bAdujdkEAtPU4KA9Af70fRHoHRVuFvsLTxqskbuRPTYi4K/he55d
         MPLY1NYhzzcaR2B6GHrzIKlFuAgkkI/aeCT6Od7tBL5GZvF0AJgyp3GlsTnUU5/ldaom
         wVwAfyUoe6KpoN4EIl/JkeEPqjaz+lt16JUC5QmUPK73QtRJRSh3AlrDsPSSpd+xvPMT
         gd+VePLSV0pdKuBGXs4hGkJoZw+Q3gUfD2jrs6asAV7HAfIwYgoRuiobLETJnv3M9kfj
         a5oaoKA+8FTfacjfhSdnTr2U8Hu7EyGLGcY8qK7GfE6kOHTSbf/7hyaTX65c/nwBKAY+
         o9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744401791; x=1745006591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrzflKNEW7LUuZ1yEyggMY9woYQSBwBr8weVr3lx7mk=;
        b=fzbae7GlqMHP75eG7zZ/LRDbpCXD/PYF97ePHPBkbFNen+wtYNlmpTB6o/PdYTqd4N
         m3ongiBLheC6UfCVr1BZr4J9rMG/hrpwWHwl0cr/y/JTu0MTgNhASOGYQ1ZkyoeWCQBb
         RKSowA4c4KFchOkRQozDRiPEzIwYGxPCkg9HWuA4I37JDux704rWF3WwrbH9bxAooZ5r
         z9rtRcJcxh2E7slsrxDAp9XYElCf3CfVU36S0JpwkJ4P4vXatd3xWiZF6Er3n7Eor7Af
         oqyMhVLWwpSSz9DFv9XSB63mw82MrYfCODhiX2+3eHN65GFU8Zs9H0FuFsaswvt4nk3d
         2avg==
X-Forwarded-Encrypted: i=1; AJvYcCUcwdY1AJXHFTBr76BKSegeZp9Jlo6BKovOwEEsXf9WMeWvrCaSCurAqygLNi8Nuu48+sUoo1zH@vger.kernel.org, AJvYcCUvKXglAV/rElfc5mlpo1abqJXiFkzzSQ21MueQqWbpSwa2EKhUfZBrdVizwc0dnJlRUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyay059ZwgF/yS1rrK9iGgjxqmvNSToyT2oLl0a8ZR2WrYOLfcN
	yAucufto/SOfIR/qkSp0eeHtnp1GKF8pb02bhVAHvfTeg2xwlUjhlM6nyuPhgMEYgoXKAR96PZy
	fSKg4cNuXdwWBWbf4AofZiEHX93hqXrS7
X-Gm-Gg: ASbGnctmWKakAk/9LsOhwHeOztILevVhFCNl3p8L4duabF/QCrnS53bxxLICG4cJucr
	+ed0qHUEqyaA2EQ38AOf5uMaCiSwX27fNdszJVAzNIecCVpkMj+hv+evCqm5M212trhkl7jZfIU
	9FrHoTZfHb/UTLAPiypUL3NYnFsAI3fSeb
X-Google-Smtp-Source: AGHT+IFtHpBdPLTlZy2DY8+8yKjBHjKkYtXcgK0E2nrEpBVZQw6DG/5H01WSLSQ7wROgGzTkYg2hhfzBlxF6Bi4C91U=
X-Received: by 2002:a05:690c:640f:b0:702:46a3:4721 with SMTP id
 00721157ae682-705599cdeb9mr74513207b3.15.1744401791526; Fri, 11 Apr 2025
 13:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
 <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
 <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com> <08811dd9-2449-42c9-8028-8a4dfec20afd@linux.dev>
In-Reply-To: <08811dd9-2449-42c9-8028-8a4dfec20afd@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Apr 2025 13:03:00 -0700
X-Gm-Features: ATxdqUFH7t81tOD218wbwMclN6XIWa7IqFaLFAVSaaySjBg_kj2iSt5q7Oo6SM0
Message-ID: <CAMB2axNeb-UzO8AOkdXPcqrwnw2J6vKVLSRVM_R+oN=SJEsx9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, xiyou.wangcong@gmail.com, 
	jhs@mojatatu.com, martin.lau@kernel.org, jiri@resnulli.us, 
	stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:37=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 4/11/25 10:08 AM, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 11 Apr 2025 at 18:59, Amery Hung <ameryhung@gmail.com> wrote:
> >>
> >> On Fri, Apr 11, 2025 at 6:32=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> <memxor@gmail.com> wrote:
> >>>
> >>> On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
> >>>>
> >>>> From: Amery Hung <amery.hung@bytedance.com>
> >>>>
> >>>> Add basic kfuncs for working on skb in qdisc.
> >>>>
> >>>> Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> >>>> a reference to an skb. However, bpf_qdisc_skb_drop() can only be cal=
led
> >>>> in .enqueue where a to_free skb list is available from kernel to def=
er
> >>>> the release. bpf_kfree_skb() should be used elsewhere. It is also us=
ed
> >>>> in bpf_obj_free_fields() when cleaning up skb in maps and collection=
s.
> >>>>
> >>>> bpf_skb_get_hash() returns the flow hash of an skb, which can be use=
d
> >>>> to build flow-based queueing algorithms.
> >>>>
> >>>> Finally, allow users to create read-only dynptr via bpf_dynptr_from_=
skb().
> >>>>
> >>>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >>>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>>> ---
> >>>
> >>> How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
> >>>
> >>
> >> Good question...
> >>
> >> Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
> >> the ref_obj_id of the object underlying a dynptr?
> >>
> >> Then, in release_reference(), in addition to finding ref_obj_id in
> >> registers, verifier will also search stack slots and invalidate all
> >> dynptrs with the ref_obj_id.
> >>
> >> Does this sound like a feasible solution?
> >
> > Yes, though I talked with Andrii and he has better ideas for doing
> > this generically, but for now I think we can make this fix as a
> > stopgap.
>
> In case the better fix will take longer, just want to mention that an opt=
ion is
> to remove the bpf_dynptr_from_skb() from bpf qdisc. I don't see an urgent=
 need
> for the bpf qdisc to be able to directly access the skb->data. btw, I don=
't
> think bpf qdisc should write to the skb->data.
>
> The same goes for the bpf_kfree_skb(). I was thinking if it is useful at =
all
> considering there is already a bpf_qdisc_skb_drop(). I kept it there beca=
use it
> is a little more intuitive in case the .reset/.destroy wanted to do a "sk=
b =3D
> bpf_kptr_xchg(&skbn->skb, NULL);" and then explicitly free the
> bpf_kfree_skb(skb). However, the bpf prog can also directly do the
> bpf_obj_drop(skbn) and then bpf_kfree_skb() is not needed, right?
>
>

My rationale for keeping two skb releasing kfuncs: bpf_kfree_skb() is
the dtor and since dtor can only have one argument, so
bpf_qdisc_skb_drop() can not replace it. Since bpf_kfree_skb() is here
to stay, I allow users to call it directly for convenience. Only
exposing bpf_qdisc_skb_drop() and calling kfree_skb() in
bpf_qdisc_skb_drop() when to_free is NULL will also do. I don=E2=80=99t hav=
e a
strong opinion.

Yes, bpf_kfree_skb() will not be needed if doing bpf_obj_drop(skbn).
bpf_obj_drop() internally will call the dtor of a kptr (i.e., in this
case, bpf_kfree_skb()) in an allocated object.

