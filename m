Return-Path: <bpf+bounces-35455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B006793AA1C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557FA1F22B0D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4201843;
	Wed, 24 Jul 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTbSCeK0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1074EC0;
	Wed, 24 Jul 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779753; cv=none; b=Fim5wgPcD8kJswlah2m2Ni4vtYJKHau49g1S3YBQ3QFBsofaszM9+nb8FQOKkA2ypTFgdCbke6ola7T7rsVVqu2yh0EBZdnSI1c1ljjurZZf+iHhe3Apwqbs/i6TWnJeOdud9Nk3jzGFTQOfp5yBw5HpFvxIugwUaVDRJJOF07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779753; c=relaxed/simple;
	bh=WRK2tAxC0sg7219jCx/LQ02L8s2eunxsmTrR7INJ6zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWzuK5DrXwA+jvQEJytxqWQa6T9/c2OwVEVBQEtpFur0CoUF+/t9I5dN+sHk0NJgKjyIqvSpQL1X9zcjx5YQaEaKJmp/0EIs4KKLx/JV/lStwryv6vkONrHOtSkw41Gra95BPo5LpGHVJF3SX9Eeb9kSjqUonwz0GbuATfgC3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTbSCeK0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0874f138aeso3283336276.2;
        Tue, 23 Jul 2024 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721779751; x=1722384551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIGQ1OwHQwd/+EmXpLEHXnkKGKuTxoIy8VtfTtcqDRU=;
        b=GTbSCeK0OkEzLgdFbXNxtZtRzBCce7eFR//B5F0lofE8tUpYfy/bte4Rr/xbJbTZo5
         C6o2CvL6ZBQyrMlbOAnkp29YQE2jJFgkfGZ5O0MY7VuK2MBjPfimZPxasp8KnUjjtzFw
         CTf9IPzi1ib7K7ACgmJsPAGBPlW8Jdu5W0rpQ0e1vG0o/eTgcdXRY+HP0gROOr4YiLb3
         3n8W1L4JMk8ftgzlnGTqtbzSyXyrlXVKRVHcbaQILxT1tglBKsIGlf6RFZBr+e7WRPu1
         Ym1UZXYd9L2O5HzDtFokxCCxCT6u4srXMt0aiC1TPVLI60RZtYMozjkrGWp2d9ZGnnB2
         Kd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779751; x=1722384551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIGQ1OwHQwd/+EmXpLEHXnkKGKuTxoIy8VtfTtcqDRU=;
        b=W0Do6MZfOitkXfEuz/fu0Jy+yNOxrYjReFj+0LRG1dCyj2SIWGChWGCIqrRUwaWqP+
         ZFp+ORUpfFOWxJ+Ssi0cSp7DjNH0Qjz4LmmT4Iu26zDO7WKt4lQIW4IDOWYjcEdqcKq7
         phYWSZCrLAzujHZm9j/v1vOijdnAsliScPFcFboEsQg3r23BPaoscCTHNXVs4xzdNFev
         UzPnrdlNDek3QuWSteIfzXowk3+b4+F5Bd6curJTrXnr7ImYEqP1nJkQbO//pAq6i1DE
         AClY69LR3IZY8DCN0BOQDniYVIkJzKAmJsq8SrMNFbZiaM6/5FWOhZ62obYVmSwF7C6y
         WjBA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0CGEOzpStoW2RsmX7wXtlLDpBIofG0CT0U/6oWYniQXyGuWbVSesvYdA1qQxhdDnfauu8Iotw/21qx4mYcUaX6lqxsLzoQEVOMapk73QvVlITalc6RZqjZFb
X-Gm-Message-State: AOJu0YwXA55vqsoara834vSNtjy1CweViwi62GQx4dSl6haGfGJWIM8U
	ml8m0Sl3PNnkgpL/r+U9nRdq6IP7iiOvOs/71ZDSIFEIkGjRS0AxQKCaZBTMmCH3PiZVU9JqAt+
	pdFztXjQTS+BMq8is5X+RfcomXYjuCz/3
X-Google-Smtp-Source: AGHT+IE697dkpzROsVgOIiXs9DoI+uQt52rvwub8QY5swVV1GenI5cFOYQn7Lw/OtZygFuL97+XxeOLltTOPkOEIVCo=
X-Received: by 2002:a05:6902:2403:b0:e08:7afb:d9a1 with SMTP id
 3f1490d57ef6-e0b0e3dbbd2mr757055276.21.1721779750607; Tue, 23 Jul 2024
 17:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240719172119.3199738-1-amery.hung@bytedance.com> <20240719172119.3199738-3-amery.hung@bytedance.com>
 <darbgv5izfcghfynr3efoo5w5slsa7kmwcsqpbrasa2u3u76bl@sm4zq2drkjai>
In-Reply-To: <darbgv5izfcghfynr3efoo5w5slsa7kmwcsqpbrasa2u3u76bl@sm4zq2drkjai>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jul 2024 17:08:59 -0700
Message-ID: <CAMB2axM_t_traLzMYJn+J1fKtfLygSRHw7VrsKsVrDaNwsgqPQ@mail.gmail.com>
Subject: Re: [OFFLIST RFC 3/4] bpf: Support bpf_kptr_xchg into local kptr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	jhs@mojatatu.com, jiri@resnulli.us, martin.lau@kernel.org, 
	netdev@vger.kernel.org, sdf@google.com, sinquersw@gmail.com, toke@redhat.com, 
	xiyou.wangcong@gmail.com, yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, 
	donald.hunter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 05:21:18PM +0000, Amery Hung wrote:
> > From: Dave Marchevsky <davemarchevsky@fb.com>
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>
> Amery,
> please add your SOB after Dave's when you're sending patches like this.
>
> Remove OFFLIST in subject... and resend cc-ing bpf@vger.
>
> Add proper commit log.

Got it.

>
> > -     if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type=
)) {
> > +     if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type=
) && regno > 1) {
>
> I don't understand the point of regno > 1. Pls explain/add comment.
>
> Patches 1 and 2 make sense.

I believe this patchset is incomplete, and it will trigger a refcount
bug when running local_kptr_stash/local_kptr_stash_simple. I will
finish and resend this individual series.

Thank you,
Amery

