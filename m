Return-Path: <bpf+bounces-72610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E7C16628
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AE71A60D77
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69134DCE7;
	Tue, 28 Oct 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqTaHq9K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37F34C9A3
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674630; cv=none; b=jAfBAiUYuvg+gEqYDnheTrGuPQHcDJubGCOw1JnY3GL93FPeQhj93DBnQCg1WvFZJYI0mOlcnh7rEDlg6DOcVQR/Exztj3M80entMlSKxQQW22sFLOp75q9eUneWMVZC9bh5Qp0+2vMs1jsjwQv+ehrESE+eFCHT+DZbO79O3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674630; c=relaxed/simple;
	bh=Tj8ZvhTz97/8amvz01XKhun3eDCFY803CdI9bwOU1JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybu/f1LVM58eW55pXoydLrImpVXCbPTnnLrQkmO0ns32jDVohRFZ3AeoVZzHIbY+O1krxlUqIf07nFOSsbGzTBmoY2ig6zC70oFNZtepBGiQjwLcojseBIsVbjqqp28oJvfpEX6xQ+7upn3BWt71U37xFutixUwD0Abjk7Fu3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqTaHq9K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290d4d421f6so59254585ad.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674626; x=1762279426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF5TM62qsWY0KYgalRztsNCpOTJySBlQjc+dN+egIAg=;
        b=LqTaHq9KoWdTUKmE5KONE51B97dz5QEHczG9XHqmszZcF+9xP4akT9WWmj5y/sTYjA
         +74ddGJEsyd7EtI2dpKL0IUJXzITATPZWhfrHGtKUNTh7C6T2r76x7odTelhDvySVkFv
         UyWv+5NkltGfAWg6Srs9GrvfiPdAEdqY85Ai5RVmtJTprTV4ZH+dlVEQwMFcde6gK4rJ
         9MYk0FqJRF7kvXiJEjwnz8veym27xIuEAC0KU5fhkIjIJiS0DRf1c6hlzqV1e2BiFPuN
         aj3FFUaqLtPuJP+R2nNMGtQuG9ZMDiTPOhiHPGF0bNp7zg6tIOV+mHmvGzg+i0r1xagQ
         s6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674626; x=1762279426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF5TM62qsWY0KYgalRztsNCpOTJySBlQjc+dN+egIAg=;
        b=oHP+OjAXf+KdmRnb0gLH8Q0k+gdce9BEnoegmsi7V0FH9XPjCeayHT5JuDEgU+UyGt
         GeEncQGDHutPTrXQUUonqyWofUylDgQn43Hnq9nwjNg5PDshKKMmt9HdBD9WZiCPB+Jk
         zq7P2oh3G3qitolOiBFh+PnstXWP5Lo8xeoQWh592k43jATZsuYf+PeoVhfhfriSH+mS
         GQ9FcgiONF4OmqwTsY9nI8+oCScrw1y7OUmPyudKpYmpcg+pbzSf8XIpC50f4MnKeRwI
         Zfyd8MJp2XTT/aYuT3zD6S+ko4gQrAo7EEQNzroDQVMb3hZJyv/tKAVfjr5Tne2gBKc6
         SHbA==
X-Gm-Message-State: AOJu0Yw3qfuSkiz+LFuUH4aI7zVyhqAn7o/HoXs0Vv9Eh7JLOS2Q6u6o
	Zoc5RwGeG4p+DKa0N2Qr9ucjoc+9BtwmB3ekYfqvPrwWu0NxaC9Vz62KGo2dV6UmrsBJMRsdqkW
	+4P1YKr+IZkXRvx571Toi/Pr3cm8tNuY=
X-Gm-Gg: ASbGncv//K4eBtKPFrLxig/gnsLWgTBF6tsl7hdFNzKz1uiNRZHVI+wCFr/0AZwbXKz
	xXkp5m8EYFYfT8h/RKxlLYxbN72Cv4pYWpdKq8S5OgXOJlujZTTKddi7Kj81z0acE4YptvEom4A
	2vs6F11sSx2pdNeK2zzxnpFxzxTGrmVQ76efg2zY54HSGooLSB9HQlqKMwBiGv0VEOuAp1u2ZZb
	FnwLc8QPo1/IumWxYX8dnyBgBfzFjtQqVmsVsdAq6vZBbtFqQBa/2K960DznPTt8lWx5yLXpa9s
X-Google-Smtp-Source: AGHT+IFEBly4eLU2eMtrpHdWDwUWq3jIOQKd58DzgQ3u8neDEg4iOH++Ap+sBfMU/91tfTmuT/8gb217U8qyaHQbJ4U=
X-Received: by 2002:a17:903:24d:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-294deb25bc7mr1425415ad.0.1761674625931; Tue, 28 Oct 2025
 11:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-2-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:03:30 -0700
X-Gm-Features: AWmQ_blOGTMhHAR4mFgi-mzpm7Mwgmbx48rSRLx0IY5MkekEooV1tyvh3TpbvC0
Message-ID: <CAEf4BzZWzxkUvUc+3ufLahSsGi+BrAv7xQBGhZPCNuy-ZYji-w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/4] bpf: Free special fields when update
 [lru_,]percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
> calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' could cause the
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value[,_long]()' in 'pcpu_copy_value()'.
>
> Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU=
 hashmap")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/hashtab.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c2fcd0cd51e51..26308adc9ccb3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -950,12 +950,14 @@ static void pcpu_copy_value(struct bpf_htab *htab, =
void __percpu *pptr,
>         if (!onallcpus) {
>                 /* copy true value_size bytes */
>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
> +               bpf_obj_free_fields(htab->map.record, this_cpu_ptr(pptr))=
;

would make sense to assign this_cpu_ptr() result in a local variable
and reuse it between copy_map_value and bpf_obj_free_fields().
Consider that for a follow up.


>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
>                 int off =3D 0, cpu;
>
>                 for_each_possible_cpu(cpu) {
>                         copy_map_value_long(&htab->map, per_cpu_ptr(pptr,=
 cpu), value + off);
> +                       bpf_obj_free_fields(htab->map.record, per_cpu_ptr=
(pptr, cpu));
>                         off +=3D size;
>                 }
>         }
> --
> 2.51.0
>

