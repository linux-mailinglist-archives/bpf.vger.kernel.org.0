Return-Path: <bpf+bounces-66604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D2B37509
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037F14E2154
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FAC28751C;
	Tue, 26 Aug 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ISXIXl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05030CDB4
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248654; cv=none; b=STkgTZKF1qtRDH7U/pd8CHnb06lnknfh40yJMgbpc5yzgqoDfh/TOochhPtWeUPVi+ZG4NA5VsxzMV+YjtzxrDyfNhOVAnmOIC5V93i0RMWxJk5LRTDlsqhJrMUbx3KRenVRW80XBrkBA+yaUgvNhmdWwCwqKlTvPHvvOkOoj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248654; c=relaxed/simple;
	bh=QpujRMJ1lNmRNxq7dMnmEltcf6GYz/S+etOxSsQ0eXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flt7GnZyF1WxYJm5OfdOzuAKmrJj6krY9c/pybLb5hkRdEueyKGWGXqiCHJT267ZxQi9ecM7aSSFRIpKa8MoDMJRScaKOI0kgUKCS5r+CGq5J9a4Q+Sf5Lk4H/7yVQ4sB3pGLwr/3haDR10tFnAC8CQ5AAQ1olBLkLYCgG3BuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1ISXIXl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244580523a0so61146415ad.1
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248652; x=1756853452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBc4Boc7be00YKAEkJ7QfqoJ/Z9cB58qGFvIFaUiJ0A=;
        b=P1ISXIXlJmz7H7PFk3H3XDehdqYbD43iTCQVXlaQs7BD/UyP4+TfDEnhCPebSkciTs
         Hb8I+OCrB7Bq/U7R356KzRk55H1mrMah8LbXU66R76lEhj/KLYwX4Cx9VnVbiYtb6vlK
         du51t8sEJacUn3Uf4W0aouaW8vl5B9BzNtRqQbBbgyMv5m3WUOgIGLmguw3HBgUCRlf+
         bAWVbAtoDnx2EhdbyJG1WBBH7unOYIKhGlGm5Mt9OCp2XLW77fn0D1lyAySbGeTdHnqd
         TK+3Isj4L/bQyynj2LRp7B9fJ15CQL1j8m2LH1Z2hXiQrM1KB8XVHOC7b1CLk+P3uka6
         +mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248652; x=1756853452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBc4Boc7be00YKAEkJ7QfqoJ/Z9cB58qGFvIFaUiJ0A=;
        b=JRD2HFbYr4tI1XZ8OR8ZS1x8ksBQi/oIgu379JqDzsP6rgUtXYHCyxSzWzv3QjzaAb
         03XoSz/ga2G7/bJfTV+BIAhZQbROqrHDzo5M5g0/nlSLfiTMCZbw5AX5JwjGTVJjniwy
         GJZKs8RMN7XPFnPNLllVHQ6ZDiCQgP7fV4J5UuAaO2MI8xAk4wGIy97zrPGbVF11vKXU
         uRrB2pOovzfaAFEys7Xp1aJIJVfqiiTRDtY1XTyS5p/JCibh0MifYiDoMyGG2hdGJ0O9
         beGzjO3UTFH8B2vsoGGCwsmBXHMrtm2LdmqcLHd1xnmpVABviLjQQ9dP/eeljfzLRaMd
         9QBw==
X-Gm-Message-State: AOJu0YxWAv7Sqwg+ttJDtJoPtE8TqOZOKsFqlwAIObkfIwrgYw3RGaJQ
	UXdkgOaYArLpG9dkZDMmm0x+Qi0XJbvLfWHQbOdx7uzkuBam7pnez5l1Y+BQRvjJQZ9+76TJUJp
	DsvVaEiJrxLSw0edWA/dJXk66MFg+GFw=
X-Gm-Gg: ASbGncvuPgVufq6rrIPv28SjqmvaTVktDn7w11+ctcgwlmJhTKsGYgJ5FFgSZwVTkpm
	fy8b5KG8eH57lM2d/CmfhDToNLgnyntIAjtarD6hJkUJwlO4iEmNgYaZktHOqHIyxRr2dHrEGk2
	HX3/Yw14FYb7voP6A/BnzVTBvPIQExuWgztA8AFrldQBDGk2yVhEC+euHf+oTT1x2hjvAbY84JZ
	67M7an1BGTJij0NQMqrRsQbUF8NKmwaBg==
X-Google-Smtp-Source: AGHT+IHyJ7WA5/g69v44n9P52rjRVTnqKEj8EIDZG+AsVu5w2SsTQe5m5KtLyXc5/OoDVTpmKMoqNObaI9k0M5nia6A=
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id
 d9443c01a7336-2462ee02b9bmr223694285ad.15.1756248652251; Tue, 26 Aug 2025
 15:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821160817.70285-1-leon.hwang@linux.dev> <20250821160817.70285-2-leon.hwang@linux.dev>
 <CAEf4Bzbku_8oNkB5VmrNPNnWg6h5YVPTP2WTMgYcrbfwpzSUoA@mail.gmail.com> <DCCGPAPLTR3C.2CXCTTKA7W0A0@linux.dev>
In-Reply-To: <DCCGPAPLTR3C.2CXCTTKA7W0A0@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Aug 2025 15:50:37 -0700
X-Gm-Features: Ac12FXwvpGsdM6nqezG4h_iHXtKORbcovOYVnebi0Tkad7wClv9l1Qej-wzByGc
Message-ID: <CAEf4BzYBw3MHT1jWz4JQnSW-8q7h1rHN_iwQET4whTCadb770A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Introduce internal check_map_flags
 helper function
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, olsajiri@gmail.com, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Sat Aug 23, 2025 at 6:14 AM +08, Andrii Nakryiko wrote:
> > On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> It is to unify map flags checking for lookup, update, lookup_batch and
> >> update_batch.
> >>
> >> Therefore, it will be convenient to check BPF_F_CPU flag in this helpe=
r
> >> function for them in next patch.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  kernel/bpf/syscall.c | 45 ++++++++++++++++++++++---------------------=
-
> >>  1 file changed, 22 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 0fbfa8532c392..19f7f5de5e7dc 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -1654,6 +1654,17 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64=
 key_size)
> >>         return NULL;
> >>  }
> >>
> >> +static int check_map_flags(struct bpf_map *map, u64 flags, bool check=
_flag)
> >
> > "check_map_flags" is super generically named... (and actually
> > misleading, it's not map flags you are checking), so I think it should
> > be something along the lines of "check_map_op_flag", i.e. map
> > *operation* flag?
> >
> > but also check_flag bool argument name for a function called "check
> > flags" is so confusing... The idea here is whether we should enforce
> > there is no *extra* flags beyond those common for all operations,
> > right? So maybe call it "allow_extra_flags" or alternatively
> > "strict_extra_flags", something suggesting that his is something in
> > addition to common flags
> >
> > alternatively, and perhaps best of all, I'd move that particular check
> > outside and just maintain something like ARRAY_CREATE_FLAG_MASK for
> > each operation, checking it explicitly where appropriate. WDYT?
> >
>
> Ack.
>
> Following this idea, the checking functions will be
>
> static inline bool bpf_map_check_op_flags(struct bpf_map *map, u64 flags,=
 bool strict_extra_flags,
>                                           u64 extra_flags_mask)
> {
>         if (strict_extra_flags && ((u32)flags & extra_flags_mask))
>                 return -EINVAL;

with this implementation strict_extra_flags argument is superficial,
you can just pass extra_flags_mask =3D=3D 0 to disable this check,
effectively

>
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
>                 return -EINVAL;
>
>         if (!(flags & BPF_F_CPU) && flags >> 32)
>                 return -EINVAL;
>
>         if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_supports_c=
pu_flags(map->map_type))
>                 return -EINVAL;
>
>         return 0;
> }
>
> #define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~(BPF_F_LOCK | BPF_F_CPU | =
BPF_F_ALL_CPUS))
>
> static inline bool bpf_map_check_update_flags(struct bpf_map *map, u64 fl=
ags)
> {
>         return bpf_map_check_op_flags(map, flags, false, 0);
> }
>
> static inline bool bpf_map_check_lookup_flags(struct bpf_map *map, u64 fl=
ags)
> {
>         return bpf_map_check_op_flags(map, flags, true, BPF_MAP_LOOKUP_EL=
EM_EXTRA_FLAGS_MASK);
> }
>
> static inline bool bpf_map_check_batch_flags(struct bpf_map *map, u64 fla=
gs)
> {
>         return bpf_map_check_op_flags(map, flags, true, BPF_MAP_LOOKUP_EL=
EM_EXTRA_FLAGS_MASK);
> }
>
> These functions are better than check_map_flags().
>
> Thanks,
> Leon
>
> > pw-bot: cr
> >
> > [...]

