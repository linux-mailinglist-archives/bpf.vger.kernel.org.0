Return-Path: <bpf+bounces-29783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0908C6B0D
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD98B22CE2
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C9364A0;
	Wed, 15 May 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf6LTHIw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDE12B6C;
	Wed, 15 May 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792152; cv=none; b=feNc+pdM59ohHBLQk8pcUUJJferPTO0JUSevJx/bY1YytjrvGnMRqS5S6DeoHW9+O0AZNiVnCF4JaiDMoKKa6rxvcAJpUCtrxIObhyyfyPAkZ8w8VNpYXyxL4SfUgIVI5H6z04nLjqSVV8V8Ypzh9JoVq9iPs9BsxL5VZ/31nsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792152; c=relaxed/simple;
	bh=MZshctqx6xM45b+tkX0cDNyL7J8LzYDeaWLENgouLDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXFw8scukVG31bzJuyq3th33INMjpbP1KgpSNCZEwqY0Qu1kdUWzomnrINlCPLWavhJSQ4adpS6ht7IkP67XIGKUc7U5WendCiqGPQM4tY/lUA9I4qL0GQ3Rtn4+A5j4PmK1CCOukKPmkeWRbtWNMnJ7jKswj7j+WM1ywihdwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf6LTHIw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so5836001f8f.1;
        Wed, 15 May 2024 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792149; x=1716396949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn71j5PCDcdMbECQ7d4+bOhBU+DyfxybRg35BEWpRjk=;
        b=gf6LTHIw1ABxl5TEaBWMFBgNgJysuo8iw85wnGo5s7XjCxsIctlGjDBbTZB7/92u7J
         4oYPmNMqJIDQfuY464yR+HF6Wpe1p0ynWFxe1z9K4tZHjIojbLo+RDb4ONtCpgWE1n0d
         QzHhEbNwyiSZkN+vNgDtGtiRmSynjCAoQCAMIahDfP/Baif0UWW5YZVbDU0QITW3wtqt
         5UbXZAAKNH4BGPTlRGVvdQjFjchzDjGW1Voy0MDjlHsJiZybchf/wRudWVVwbO75yJil
         tG1NVKSBv3XtT9hDjpQCeMP4yv664dhdZoXGGmonkGvkIR5ov3C3V8Ke0xxMbrVFcIXt
         O0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792149; x=1716396949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn71j5PCDcdMbECQ7d4+bOhBU+DyfxybRg35BEWpRjk=;
        b=OYZLMDZAHmyPqgD4J5KODzz1+EpH6eNPtYr3HAeLtLqwc0ln4Jc2kD5/2WAoeS3GB5
         qaKdgduNMi3rIaIkqt5if4A5TvUaH//cFQXAUswN7e3KGC7vZwq4wvJTPKTB1bMCAeMs
         no+U/ERRTC2UDMkfZtzmdj5dhdy32W7q1MhHsW4z18JN4U8AtfEpmt05y/6fIljUIf3W
         LKQeBOOwhmJ3de6KDa7xv2w55CnrN1esEg1bRoJp8ujTYL4oVr3zG+TTkpw0fFipf3pb
         OINHI3DGsWTXRGA5iSyAx+MY7aqHvkENT0VdfjIAZkNNF8FKjJFak92X+FwdYKjitqU0
         YnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX14yaBv/SV3RUvckK5d9Wc4UFsduLpwqxmulAmTwd6UKN3jhOXTIf6SjMc1LiF3WFyQRtwLhpCCKM931rE3eFxQ2fB
X-Gm-Message-State: AOJu0YxjuTxLNlSNQy00qBwR35Rd6pYbl26v/ZQuh3GaZsY+JvxOrN9F
	IkrdXltFKLE96CFq4oGNwffWjU0mciKwVL3bJHNO3f4aXHehyE0B0h+Z15gpl8nrfz52KAjhMDW
	nYsomDcWQRKgOJ6zbPu35CuYbbqg=
X-Google-Smtp-Source: AGHT+IG5vRNg0MCDMX50ze0WgRNZOel7HD3ZgSa/j3WNzn6FCm4JV8E429RhjFr7HAOrBrcooJXl8ikIqyzcnZymTTc=
X-Received: by 2002:a5d:4801:0:b0:34d:a5fd:977b with SMTP id
 ffacd0b85a97d-3504a969ffcmr11308913f8f.60.1715792149046; Wed, 15 May 2024
 09:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515062440.846086-1-andrii@kernel.org>
In-Reply-To: <20240515062440.846086-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 May 2024 09:55:37 -0700
Message-ID: <CAADnVQLg4zcS99=bCLgczZWCTbUwRXyyoTFC+_LU08rQ1_EbZQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bpf: save extended inner map info for percpu
 array maps as well
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:24=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> ARRAY_OF_MAPS and HASH_OF_MAPS map types have special logic to save
> a few extra fields required for correct operations of ARRAY maps, when
> they are used as inner maps. PERCPU_ARRAY maps have similar
> requirements as they now support generating inline element lookup
> logic. So make sure that both classes of maps are handled correctly.
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY =
maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/map_in_map.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 8ef269e66ba5..b4f18c85d7bc 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -32,7 +32,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>
>         inner_map_meta_size =3D sizeof(*inner_map_meta);
>         /* In some cases verifier needs to access beyond just base map. *=
/
> -       if (inner_map->ops =3D=3D &array_map_ops)
> +       if (inner_map->ops =3D=3D &array_map_ops || inner_map->ops =3D=3D=
 &percpu_array_map_ops)
>                 inner_map_meta_size =3D sizeof(struct bpf_array);

Applied the fix to stop the bleeding,
but we need to fix this fragility long term.

