Return-Path: <bpf+bounces-62969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE289B00B88
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06451CA6C4A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF92FCFC3;
	Thu, 10 Jul 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfyuGTVv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F92FC3B2
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172813; cv=none; b=fYL+w95gVTPWWvf8q3wsyx8+cNC+OhP/rNoebt/eMTR8FQKzmL7yelMxkSPH7e4VByZhvAvJ+S4eu5lNLYtnGsF/dUYAyf8zXv2hyqjlQ7Wezsf7H2/wpMFECTdn+0vlYE5OzfdSMDSpW7nP2MEJ3/aO4nmIBTptbqqspq/vB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172813; c=relaxed/simple;
	bh=AaDMFBbgjubWVIWgK/UKeV4KwL9gRrhGJXUdtqcu47k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlG9NPAgzCNZHCT+c8ZwiQlPvqfZXZzyggAzmQW+FD4D5q327Y+GI4J4cWVsydg0272Mitp76i0N6mphjYwUm5UZClRDUmPK+Anyx1N9lIpYssC5raIOuhYUt8FrQdC2d2/dOMO2fx3aKJTRICBeYQWYX4YkdQR/HS0BK0xI3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfyuGTVv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e4043c5b7so12455067b3.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752172810; x=1752777610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWYyh8XGu99Qh1uTrPgmklW3BumGEX7QcT4HdPIGQCM=;
        b=XfyuGTVvYLkBk3yoaLFM8krD89t6phWfCBqSbmsmVAnXy4duM2yGId142b2rJdt14z
         faBTs7/QDw+DNxpYBx9byDt3me7Hq/S0ffNlG+9VjqLN55kqOefsa1Cr9ovKq+IZEcWu
         J9xXCowBlDGLrqQmbeiET7ERU0oBFnM05Yo76ptGsOembp59jFzMhG50VQt9LNz/V02j
         k8Tdtvi61sYF7cl4+pQaj97ZX6I/gAwo6YJE9LuadnNO2ivr6kWbER9krZVum6etY5nB
         6rqAzHFSQFYu5k9Rwr2uHX23ZKAULslI+TsJ7KjZo5EH+rZZpUk4Vf12fA96M7NU3F0d
         ji7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172810; x=1752777610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWYyh8XGu99Qh1uTrPgmklW3BumGEX7QcT4HdPIGQCM=;
        b=TMSqGyRLDl54D9Ws+yYZV3FTbzTkhDauoRzlAfBkCD3Ou4ZKxNWOn+qqcKXXYKDd1e
         5kXEROwMGbD7RI9agJduPDZMChBhaIObwbvYLW74vHSoOuwfFWyhVWbdkYnMRzNMPYiv
         RHrCbajRC8NZCrWc1JmYJq4FMIUe+c7M6aNp83G3UohsoyXllhW7K4uGbSA2PkkZnAPq
         SE+iJPpynJDmRlgUVfRvr8z/mdu0aCRqtcWTYotxj8icE11gka519RWU0hGiKMOJxuwu
         6Y8f5P5sPK0dDJAQzy0m4V9b+449Ft9Sb42Y+O4THkeb7sM7ilXyM2O3YkWtnamhY7An
         kC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV245m5ay0kbD1TQIqmSyKg8aliNM5XIDZHyEqNQ4gHI0w0r6l+YheC2DCb+i30IdK+W1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhRqc3xjVYMYy9DDlash0TT+PEVb2YOHBvejh1pBGifUqQbQy
	jyxDc2ue5FsUxLWcHl7KqhaxrSBRKN9ZBug0e6iv5rnvb0kL/zPHz9f4ke52MZK4ecosYS8U78h
	ptP/anB9+NPwgzYVBajUKGYq5GTZeMho=
X-Gm-Gg: ASbGncvG7N/pmGvHZvlIXPmj62RfcVEybTrATHc02gYBHrX7Gsc1qECxXelWe0rnmsz
	TvdDyEv3y+k1T+ZBWWoEpg6R/w4OWq9bExtqHINbCjBt6XuF51Qi1T7jQG8u1I1Val1EzVvmisR
	5ngRmgjop48xiv86QRpNcwc4nR40+3s5DddTESDtyMFRr85AJTHs2JWPTqNk8=
X-Google-Smtp-Source: AGHT+IHzhs5FeSFXioBVndV0A375iY+gyhAlFnaIIcrBEu2QeutNwKh9gkj1wLmmm4odqx4qLkxtr7HWfV0lbSs3sz4=
X-Received: by 2002:a05:690c:3682:b0:70d:f338:8333 with SMTP id
 00721157ae682-717d7a0f604mr2229447b3.22.1752172809626; Thu, 10 Jul 2025
 11:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
In-Reply-To: <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Jul 2025 11:39:56 -0700
X-Gm-Features: Ac12FXwkcB9BzELUG1mN5BWYoOPcAmwkX87utvIy1Hv28Hbqope1nEnpxTbkSRI
Message-ID: <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 7/8/25 4:08 PM, Amery Hung wrote:
> > @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> >               goto unlock;
> >       }
> >
> > +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
>
> A follow-up on the "using the map->id as the cookie" comment in the cover
> letter. I meant to use the map->id here instead of 0. If the cookie is in=
tended
> to identify a particular struct_ops instance (i.e., the struct_ops map), =
then
> map->id should be a good fit, and it is automatically generated by the ke=
rnel
> during the map creation. As a result, I suspect that most of the changes =
in
> patch 1 and patch 2 will not be needed.
>

Do you mean keep using cookie as the mechanism to associate programs,
but for struct_ops the cookie will be map->id (i.e.,
bpf_get_attah_cookie() in struct_ops will return map->id)?

> If I understand correctly, the kfunc implementation needs to look up the =
scx_ops
> instance (i.e., the struct_ops map) from the map->id/cookie. There is a s=
imilar
> map->id lookup in bpf_map_get_fd_by_id(), which requires acquiring a spin=
_lock.
> If performance is a concern, we can investigate whether it can be rcu-ifi=
ed.
>  From a quick glance, bpf_map_free_id() is called before call_rcu(). Note=
 that
> bpf_struct_ops_map_free() will wait for an RCU grace period.
>

