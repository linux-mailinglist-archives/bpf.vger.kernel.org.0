Return-Path: <bpf+bounces-78808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E0D1C147
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD4D3058547
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC8311971;
	Wed, 14 Jan 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNadgCjg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357D31196A
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356058; cv=none; b=jLQ4ihWF3NC2MfccAiQYqK0f+P40BohNQNbIzOIxx/oDZSfJ1cyOHEIvaPJ/Kt8ClQtSboTe9ORZxlw8WgZW4fi00I7/hViwiipzRKlGXvBH7n661KPOffiOXRcR6RqJOyUXiL+8kxxJpJ+OoDxLL/8VErx5XNaaSo1uGEFlhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356058; c=relaxed/simple;
	bh=ifGJfxKm/m9WOpFttgceliv++u3MY8+pL/vI4DzqE9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM6Wh0vF4s1J6j4lBuZwVAcOjA6/Th5H0moGqUwiZYrKPgL7r+OPjYUB1ThFQ4Zr6dRMrFHbJ8zHW/nayTSzeTMlh4J5bd0KegGxXKNSg4nsy2cwuvRNGtnFLkTI/gJRJ51U8z4U+h4DWGMPCKZpazPnrM7YmF4zFJvXuzmI1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNadgCjg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8712507269so403994766b.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768356055; x=1768960855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgT1lVRmTH4/cZ46GLj7XUUC63WejBDnqQe5A4qepw8=;
        b=CNadgCjg0Uktzz0ZndVnR2Sd2+lFfQIvwXLWBq83jNN/BVdelFKjXtTeCAYpBOnopQ
         gkd3gvD9ETa0QMxCFH0LClte4i26PYYVHvdq6ixq0f5BT5RFH9B9jj02fOGvlGDAhqmU
         adl0M3CSvJZHd8lFSsE2Ej19QAVBUfImXh3gt9OMe1TD64cBpiZj5O+jm3C+1U6OFhqp
         /378k60Bhvr4Z6x3yzcVEN6ZTwlkVMAYTIJ/TdoOoJ2/3Niskm3wCJ7y2n3VAxNlfk3+
         Ugz/iLG2ZQwrJPjxhkww+KscHOL4fTn1VFTJyrsRvUqKS8ILA6zcqH62ew+14tAPgUxn
         uKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768356055; x=1768960855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgT1lVRmTH4/cZ46GLj7XUUC63WejBDnqQe5A4qepw8=;
        b=gfXUkcfLhRPbTb8fIHI0692JcNZfiGwfgIFYPbSchevKyeDu1kLhWopjoYCXuAbl88
         ZpsiTi9WI9QvvrjPhCaz7gsHIQk/AuicN2m1hPqGq2S7x+yByNPcpamov+1ObhKep5Do
         AW0ueCnIc9Xsb1h7mee72yJMSDBCZCZ87VIwOhMmGHtTe/vbCOraiNa2dKNVkP5+5X28
         oUFLV3pHyH+lbklDjHaLzfZNx34faN5VLcXdIr9wxjRI/3qQEq4oV6QDglm31cTbadq4
         tYIsMLpOEv5ATsmas0/503xqiuzk5nsc4DlmsNeP5/MYva6/157IOP+Dmsdx59lJK85i
         x+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1FPFyDLr/JHEuXRlwFs1ZDf9VM86dnvKgSEaK1d3ixkUmRqjjk+PqS9/YqvOGXtuhoVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmNXgYKkwAdltuI8ngnojS7lYq3qSDffTHtzBxPMyKFMWXiXJ
	BPwRyJ6c5vwqokSIf4p3UNUkxhPPsLlTRuGZfZC6zxl+jR/sdwG/xEdIPJ02JukJGHomc+4WnrM
	0cKICHN+ZrFouiXVPjBbkW3Nc3l0I9SU=
X-Gm-Gg: AY/fxX5jA6NdhmNNhoZj3Ae6iyF6t87TG6lWcTfmB+jm9YSayx75J9JXyIgd5zU437J
	ZpraObvM384b7pfy5gyQVagRoXQejyLDwVXTbJ6YcAoYdXFDY6JGa3uPyHLbl8sP28FnUCvwCmZ
	Z3RAy2BKodplyuFP03AeGK/f4loQcz6RaO3SwE8kkMNvmMaAT/++24czoZvDuazRD2lFgCrCRj6
	0o9sbyPOQCCWa0Io8nirnH5vMQOfNtLQwVHPEkhaoIwnjX4kXbVg6fwG6WIq4we7luU1m+u
X-Received: by 2002:a17:907:da15:b0:b87:117f:b6f0 with SMTP id
 a640c23a62f3a-b87612a5987mr93317666b.30.1768356055171; Tue, 13 Jan 2026
 18:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-11-dolinux.peng@gmail.com> <CAEf4BzYYQzeuqVF95YZobvQAU8uhmgUSLE+ov5zUds+eH5Efwg@mail.gmail.com>
In-Reply-To: <CAEf4BzYYQzeuqVF95YZobvQAU8uhmgUSLE+ov5zUds+eH5Efwg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 10:00:44 +0800
X-Gm-Features: AZwV_QgNS2i3vMxc0oR21_6xZi8lBVD085YPykYMT98-hu_E6HRqgOGMxDNOagQ
Message-ID: <CAErzpmsn5v3QMCdRjE0f-dqUSRXE-XMKccF-wMauNOXOoPehxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 10/11] libbpf: Optimize the performance of determine_ptr_size
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:30=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > Leverage the performance improvement of btf__find_by_name_kind() when
> > BTF is sorted. For sorted BTF, the function uses binary search with
> > O(log n) complexity instead of linear search, providing significant
> > performance benefits, especially for large BTF like vmlinux.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
>
> This change will be beneficial only if btf is sorted, otherwise the
> previous approach is generally faster. So on older kernels this will
> be significantly slower.

Yes, I agree.

>
> If we want to optimize determine_ptr_size() at all, I think we will
> have to take into account whether BTF is sorted or not.
>
> Or just not bother at all with this optimization.
>
> I'll drop this patch.

Yes, that's correct. The actual lookup executes only once, so the
optimization provides limited value.

>
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9a864de59597..918d9fa6ec36 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *b=
tf)
> >                 "int long unsigned",
> >         };
> >         const struct btf_type *t;
> > -       const char *name;
> > -       int i, j, n;
> > +       int i, id;
> >
> >         if (btf->base_btf && btf->base_btf->ptr_sz > 0)
> >                 return btf->base_btf->ptr_sz;
> >
> > -       n =3D btf__type_cnt(btf);
> > -       for (i =3D 1; i < n; i++) {
> > -               t =3D btf__type_by_id(btf, i);
> > -               if (!btf_is_int(t))
> > +       for (i =3D 0; i < ARRAY_SIZE(long_aliases); i++) {
> > +               id =3D btf__find_by_name_kind(btf, long_aliases[i], BTF=
_KIND_INT);
> > +               if (id < 0)
> >                         continue;
> >
> > +               t =3D btf__type_by_id(btf, id);
> >                 if (t->size !=3D 4 && t->size !=3D 8)
> >                         continue;
> >
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (!name)
> > -                       continue;
> > -
> > -               for (j =3D 0; j < ARRAY_SIZE(long_aliases); j++) {
> > -                       if (strcmp(name, long_aliases[j]) =3D=3D 0)
> > -                               return t->size;
> > -               }
> > +               return t->size;
> >         }
> >
> >         return -1;
> > --
> > 2.34.1
> >

