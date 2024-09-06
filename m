Return-Path: <bpf+bounces-39163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7296FCFC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F3289D86
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E0481DD;
	Fri,  6 Sep 2024 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdUl0hwP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B413D251
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656601; cv=none; b=AJ++/1YXn/V5DPinITDmABUEQsebZBt22Vczn/SDwDhDYK04dE4sz/zNDm8uMENKEBod1Zq+8X4hnzEm+VW1x1CCM1pbEJ4HXB+FXwh5QCMd6Ti3tOlXFHPoEmT8tCQYfhs8to/bbicqrIVL6JcF7Ewo8WaWFVDvvy/I71SYPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656601; c=relaxed/simple;
	bh=CiJrcOLUM7Zu/0n5Ebhzh+pdGnNYyUQB/iKqihyZNmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWVXPAgtKIV7TQ+FPffmy6M7/Go75eiZRMnkpoqcupZ7DmFlFbuobe5ea+JyH/YOhi33rlrxs9BDdL9EbMRW8tSu3khKoWWDQCHgJ9OGrB8bsnUPmgY3GDpsJgbvHWJdaadVpd5FpZMU+0/IaFeAejRvubHrW36szvgVVRpz05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdUl0hwP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1886615a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656599; x=1726261399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRg8pnNo4ylrs8ywVeAVY0cb760reocQ5nxJBHUOlAY=;
        b=EdUl0hwP3ul/mvt1wqY4UyVflsoat6VHVAue2QLOfZZDQ58XmbhDZ1Y20RIFphW8Uz
         Y/2VEmF2UgyH9JYzY5WTQXnN+1VyMCSIEbETb5SJxXrFaiZCGXWbfpXwpUXwS+8NFi4k
         xWS+CdUZuFf4vjIP9R4PdQ2op0oO5H4EudzABxtzfEfWeahSPwudaTIR4kGxYgbG/9Pt
         XBvCjJnlsRRF6tKRCXrgTF9HGDcuj2Cv/lUUJJHt7Ax/m9NtECyrp9SCatkfyTMHbNuz
         tVE32ce/AR9XpQ47nGarQ25QlQh30vLVrc5BFRVLpd/zPzatsBvOLzxoXJgYSkJeh17W
         cWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656599; x=1726261399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRg8pnNo4ylrs8ywVeAVY0cb760reocQ5nxJBHUOlAY=;
        b=NuFHXrIkpFFcJ2FjJuC1nT7mnJZvuIk2BmFxKBtsD/zEQaXH6eZb8J6/5bUh+AJaAW
         2EvXEuuT0msoCgWie4o9etALbBDsvdfZOPKKliDfMZJIY+16s6R2si3GQX6cnQHxqMf1
         SwVazPs1xoabLDPlAxeRGVSUDkRkjo6BH7GQAl0oNTnlfgymDvus7aplwFdQfDKpIKeV
         2qtkIP1bryrsRjB2iNADYKZlCRbAnoucOxKam9/1KojfoprHu/kM6/rDo3aM6t0gxfAY
         JFkg+/wHc+7w8u5aOIpTT7e2QhX+Tq4LboCXaPfSc+xcal0TS84MZ1LnqZBychJBcQDF
         gX0w==
X-Gm-Message-State: AOJu0YzmROOHgce+vZXfPK7bZxCN7VBR5c743p7VPdkkzcqbkORpIUCR
	CxzM3OOacmVtpoQb1qbASPd0kOrKvTbf/rpUBw6Vtj5C9GuTkCVcCQNXfvBlfVbHK53NaYTi2p8
	ID92i+R0Zvsf+2fMDY8cXqwq9NGY=
X-Google-Smtp-Source: AGHT+IHpMKKgCoGdFepGghHdhgxiOPiAYGziTJbPbctQIlEnblD0dyvbh70wQeJI/9aGqjyMmWq36O6h7qjJ9tQOhDM=
X-Received: by 2002:a17:90b:2707:b0:2d8:89ad:a67e with SMTP id
 98e67ed59e1d1-2dad4dde298mr5025196a91.1.1725656599172; Fri, 06 Sep 2024
 14:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-4-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-4-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:03:04 -0700
Message-ID: <CAEf4BzZoC+4ma_heXfcYrWGNM=qB8shU1-bJsMapA4PZWdZUzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: Improve check_raw_mode_ok test for
 MEM_UNINIT-tagged types
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> When checking malformed helper function signatures, also take other argum=
ent
> types into account aside from just ARG_PTR_TO_UNINIT_MEM.
>
> This concerns (formerly) ARG_PTR_TO_{INT,LONG} given uninitialized memory=
 can
> be passed there, too.
>
> The func proto sanity check goes back to commit 435faee1aae9 ("bpf, verif=
ier:
> add ARG_PTR_TO_RAW_STACK type"), and its purpose was to detect wrong func=
 protos
> which had more than just one MEM_UNINIT-tagged type as arguments.
>
> The reason more than one is currently not supported is as we mark stack s=
lots with
> STACK_MISC in check_helper_call() in case of raw mode based on meta.acces=
s_size to
> allow uninitialized stack memory to be passed to helpers when they just w=
rite into
> the buffer.
>
> Probing for base type as well as MEM_UNINIT tagging ensures that other ty=
pes do not
> get missed (as it used to be the case for ARG_PTR_TO_{INT,LONG}).
>
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>  - new patch (Shung-Hsi)
>  v2 -> v3:
>  - base_type(type) was needed also
>
>  kernel/bpf/verifier.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>

LGTM (though I like straight unwrapped lines ;))

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3a0801933a79..a1bbe4b401af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8291,6 +8291,12 @@ static bool arg_type_is_mem_size(enum bpf_arg_type=
 type)
>                type =3D=3D ARG_CONST_SIZE_OR_ZERO;
>  }
>
> +static bool arg_type_is_raw_mem(enum bpf_arg_type type)
> +{
> +       return base_type(type) =3D=3D ARG_PTR_TO_MEM &&
> +              type & MEM_UNINIT;
> +}
> +
>  static bool arg_type_is_release(enum bpf_arg_type type)
>  {
>         return type & OBJ_RELEASE;
> @@ -9343,15 +9349,15 @@ static bool check_raw_mode_ok(const struct bpf_fu=
nc_proto *fn)
>  {
>         int count =3D 0;
>
> -       if (fn->arg1_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
> +       if (arg_type_is_raw_mem(fn->arg1_type))
>                 count++;
> -       if (fn->arg2_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
> +       if (arg_type_is_raw_mem(fn->arg2_type))
>                 count++;
> -       if (fn->arg3_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
> +       if (arg_type_is_raw_mem(fn->arg3_type))
>                 count++;
> -       if (fn->arg4_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
> +       if (arg_type_is_raw_mem(fn->arg4_type))
>                 count++;
> -       if (fn->arg5_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
> +       if (arg_type_is_raw_mem(fn->arg5_type))
>                 count++;
>
>         /* We only support one arg being in raw mode at the moment,
> --
> 2.43.0
>

