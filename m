Return-Path: <bpf+bounces-68026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B7B51B59
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33123175D5F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652B255F5E;
	Wed, 10 Sep 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMCYO9e5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87107242D90;
	Wed, 10 Sep 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517486; cv=none; b=NJL8cSGi83j7HrhqKIVQ0EKTIa+kXhxSLzIgJ39wy2V7RlvBAPFdY9ERdoBHfSovSBY9O3SSYJfQvQSl3FsXL87wFI8Pnc2nv/V28OaPeHppqcAlsZ0onaDvaYu5W5k2dYJSp1Qo6MtOc3jfXGQ4QJxZBNzFlYZrtHX4DHB8RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517486; c=relaxed/simple;
	bh=n99NKkGTyEVeHAKSsHfQQz5coCbmYxeKuDsw+hhBKeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq9EOZP0kyJpewGOEj1KWQGxFtenfcQyRLXmgDlFTD8iix59e7RSObfz0/b9tDRITvYWgxXkuD+rz1SCuyTwnbw7iKqWaRCajgJhrXGDUA7lYdYrtCUWwvFF1GFkb/JvbgTUxhHJ9XksBDM9cwqGi3JcjmqQGaVNAlVsjjArhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMCYO9e5; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso730905276.1;
        Wed, 10 Sep 2025 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757517483; x=1758122283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo1yWEdATZVFTADz4excqEyjl+zDvTHVv7mv+uaLl38=;
        b=HMCYO9e5QiKzK2R1HnObOz4WOdaxbMinm49xMwB6vsQt+eaP1K0gAtgAHRuUX4vKF/
         0fwzWIg21kle4HEmFvfRKWgC2UgvKEy35+3lHAkbyiFtAoC9p/DiVP9xtQ4vDdGEZwLz
         hU/UQQjo8KiMW5WXPTHB16Se0JuVr8GJm6zGF96ZpP4vmuNSmYLne8YSL+/QNaoSGPvD
         zkWdyPKHL4PtTQlAMibfHp3GuXY1HyLegoc8ahk1ueZlHwJ4XMLof7hmldOtSNbO6wog
         XRBuVNMe6VPRfriBIKXDwhG1IgYbA9DNv/DpnLVKpLwHJPooa0KXXUwseihF1gHN/Nlg
         wnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517483; x=1758122283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo1yWEdATZVFTADz4excqEyjl+zDvTHVv7mv+uaLl38=;
        b=cjtZ/zArKuf96MTSRLgaTRABzPL4DYkM2fxD1wGsJ0TycNTc7/Qs3kziFsJsdZ3tJt
         lJXA/vw5whBSdB5om1dPAFBcBdNehwWi6QoM9qvKdwrEoR2qlXa3q6wDu1RAzzq8SCaR
         2DxM6NnXEuSFn7jtU4jQ9nLS4q3XnCoMZqlDQPNBHRCRzYJ+MZiJtLakup96qd/595HI
         cZIfFCt7wIZA4YT0e5ahUF8VoBHkfBaEaqHkFu/rtNMUYOYJ+XgKbrw5rFE3F38uqZwa
         1iV4Gb8MxDEC6HfT+Or4ZYa9FmwPSeez/raQsKbsT0OldDBm6bG5aoROWQWVBBTst9nR
         g9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+SrXiScE7YV2wBw7cAnjSlrrTgBPMkTkKLhHwPYlx4AdSTyvChAEh86lHP+Qz4H3lbUp8N14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvAzahxobTgl50GIWCAMDOpm0TBgXsE+vyTDQYsdzre1IjveK
	Y4xKWH0Hr8K9cZdTSWNP5XJF+nxsiFJKgdhjwS0ZJity/K7pyhSvxdcSDKekfMJ5hqdy1J68yUm
	y2qVjWgg+bLJnRkiywtZp2Szep6xWifw=
X-Gm-Gg: ASbGncvxPQCqWD8CM/anh9o4xOY9J8Jvk04lZCpyam6Myid2eLaILxmYmuWQq+eHHY3
	AifG25tZmdBJp443KRa7j+Edx7Rj4qTZyXNxKo8Xd4t/0OSEqnjNXr23fwr93oDVwPum/MXvJC1
	0oGjFwApgeB2NdtYYgM6ddcuQnHYrKhIYNMUP54qS+1ekrEojgKEwVe/Ctq+M7y/kqRMN0skcwQ
	EAGAcaM6kkGB9anOj5L
X-Google-Smtp-Source: AGHT+IGRXpMfmwAthuGy12r1VMqQT5ZinA1PNrct1mT496MNCGM2QaFfJVnePJuzyhV/DBGM0zT1ChqnR8khbbFFHN0=
X-Received: by 2002:a05:690e:1596:10b0:614:1efe:db2c with SMTP id
 956f58d0204a3-6141efedda6mr10155140d50.11.1757517483075; Wed, 10 Sep 2025
 08:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905173352.3759457-1-ameryhung@gmail.com> <20250905173352.3759457-4-ameryhung@gmail.com>
 <20250908185447.233963c5@kernel.org>
In-Reply-To: <20250908185447.233963c5@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 10 Sep 2025 11:17:52 -0400
X-Gm-Features: Ac12FXyWABZLW4U92OpBSZvyNrzlIm9ZsRB52UCQENiK4ZBc3FauiVlbPjdo4rs
Message-ID: <CAMB2axPLuQ75_JSqkR43-UVBUi9Yj7juHFLCkDvSLPL445SZew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, stfomichev@gmail.com, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com, 
	dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  5 Sep 2025 10:33:47 -0700 Amery Hung wrote:
> > + * Direct packet access allows reading and writing linear XDP data thr=
ough
> > + * packet pointers (i.e., &xdp_md->data + offsets).
>
> Add:
>  The amount of data which ends up in the linear part of the xdp_buf
>  depends on the NIC and its configuration.

[...]

>
> > When an eBPF program wants
> > + * to directly access data that may be in the non-linear area, call th=
is kfunc
>                          ^^^^
>           maybe s/data/headers
>
> > + * to make sure the data is available in the linear area.
>
> Should we add a mention here of the copy helpers and dynptr for
> accessing data without pulling?

[...]

>
> > + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsula=
te
> > + * headers in the non-linear data area.
> > + *
> > + * A call to this kfunc is susceptible to change the underlying packet=
 buffer.
>
> Maybe:
>  A call to this kfunc will modify the buffer geometry.

Will improve the comment based on the suggestions. Thanks!

>
> > + * Therefore, at load time, all checks on pointers previously done by =
the
> > + * verifier are invalidated and must be performed again, if the kfunc =
is used
> > + * in combination with direct packet access.
>
> >       void *data_end =3D xdp->data + len;
>
> nit: I think the code would be easier to follow if we renamed this
> to "new_end"?

I was following the common pattern in other XDP kfuncs, but can change
it for readability.

>
>
> Larger note: I wonder if we should support "shifting the buffer down"
> if there's insufficient tailroom. XDP has rather copious headroom,
> but tailroom may be pretty tight, and it may depend on the length of
> the headers. So if there's not enough tailroom but there's enough
> headroom -- should we try to memmove the existing headers?

I think it should. If users want to reserve space for metadata, they
can check the headroom before pulling data.

If the kfunc does not do memmove(), users are still able to do so in
XDP programs through bpf_xdp_adjust_head() and memmove(), but it feels
less easy to use IMO.

