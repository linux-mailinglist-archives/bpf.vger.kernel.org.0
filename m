Return-Path: <bpf+bounces-78613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E9D14E3E
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7F44301076F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B77261B8D;
	Mon, 12 Jan 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="3QBC3Wc8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5A31329D
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245547; cv=none; b=kvYZIc/g6clcFtPKXCmBGmHMISi997uVRay/jM+0ceZmmBRwGJaAzfQa2h5vJx7RdH6WgB8Pj4m2dPOVoZPLhEs+DyY8aGbgKzB9jDdAoJp7+L2dxChnGNQF71S93d1YLiGpjPF5nsadeKCGUEoxGk0cwbMkqBpU0aYosFPzGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245547; c=relaxed/simple;
	bh=w8D//szDXyvm4rB6QYremhtvZxvRtbLptlukveNsBkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=gai6WXzQRFM27YIosdltAVsSp3qwcL4cp9J3US/+CXnMKxF30rDAfuy3IW1fxzWyS6B6HKhee4zLO9DMt3pF+1PAMt3oI01yiYrt45TtnzfA+qt5+tGR4woQx5+eHw3qogA1MsKBQL9q4CNBqcjblmouJxoajaoicRNcHK7jNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=3QBC3Wc8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed9c19248bso64234111cf.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768245540; x=1768850340; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47KxNg95AS6oSYSyTDTaGJCTHej65b7tf9n7trwRh4s=;
        b=3QBC3Wc8Xkf5kg3SlGgMidj6HtfCfJN7GYUhzrk86cQo8xOnN/7+joHTkH8n4Iucy8
         AcY/69fu9MV+7DcvuLf6ZqtsyxP7szK8Ti1FdP+iWbpuim73XnhUNG72UFWlSnboVnbf
         bVUrn9AiuL+RaJ2iafPxTmXBT5KC9cY/4h+TR0plyYam7oBPWUSHGWncbk9HAzea7ZqH
         rj098kUt2uaf68UdNmUYN61F0CUUKNHSYURBE5DxBXV5q7LDDkP5NOEraWZRAKvJKElo
         KPyukCSJEAlEMqVpLlFX2K6JcyJYMI/GJiQUbXKqgrPfQJnx6wDyyf9eLb7XScZ0B6Y9
         wALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768245540; x=1768850340;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47KxNg95AS6oSYSyTDTaGJCTHej65b7tf9n7trwRh4s=;
        b=EiukyKuHXeeuwMka/T5fnTC9ne6VJIfQGUE1TBiwEfnDFszNAP35eQCHKZKV2hlh61
         6zOUs92BzMWzegjZuIAExe6GUe9QEAruqLYQG9217NdzhX0Gnr7OWudEXi/Ts9Wo1b1k
         OoUdzriAjGIlO+Us5aWbLtrK5iDbX/DXjd+ab8VzAA5ZQgfMguYu6kKck/0smPLjHxAP
         lCiLCRLMQci+K2AyWalrjUg60wH8oZUOYdsUC0eOzWv1Kk+b164t/kRauvriyLDKCJPN
         yXYA1vxy7ktwX8b9SL5mTHBhX/mUddae39z4w0jqKI8orBw5mm0i7JcEUIyddS3SD7ty
         lN7w==
X-Gm-Message-State: AOJu0YyRJ0IuirzpnuG61D/cIDGUjei/YRxkJoA1NJfdgSm5TGanoZOW
	JPN5hE+ELh115ZoCr6POZXKsBVhK0E4rNzPs+wVGCzcdn2q1BnpDa2qvM3iv6HhDlbA=
X-Gm-Gg: AY/fxX6QirT2e3OonRZ+rE4Ap2srjgAnToM84Q8m84fqy2AIRjlP/42ilhsPWR9NqjS
	2f4CfRYxAGsY1TUYDb7BD8mzrwdWw6LBJXaIViFIzBWSWv561BI3UqNTU1kaDUzSjrKowkB8NJ+
	GwEC27Bw0sCzjtfzsKO0Yy/NgpczOQDwFxUQccu4NFrmIvHKthmeE84oMtmJC2pAObf479BUlzt
	zclKiGrMsXw37d49xequJA/aTrSyLfuBwiQqqvgDMYvZDgRKx/lisgW3HxuvpKxIffcyHdY+/X4
	NOGCE5SpprvZ6WMG+Qub2FXpS4S1zifKRq5hnM0pI83Rz/CE6gq6WQ4MbZnsDD2o6WQpd3BkJdu
	Y0H9ZEAlNKi2hpO9Sj8t+Nki+m7kRcZuMDvFhuw0FXKMZ2UIm2CVbjEPlh77mCoSe/Vhk0jnrKQ
	T3vPPlpsguixw=
X-Google-Smtp-Source: AGHT+IGeuU0puycVTmSLMOn7qhvwQqPuyOKUOU0x1nprVbV7sP93atDsfbXE42Sqk12c1PYCa17I7g==
X-Received: by 2002:ac8:7c4e:0:b0:4f3:530f:d752 with SMTP id d75a77b69052e-4ffb4b5ca99mr283139661cf.81.1768245540416;
        Mon, 12 Jan 2026 11:19:00 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb9e97ef2sm105384931cf.10.2026.01.12.11.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 11:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Jan 2026 14:18:58 -0500
Message-Id: <DFMUQAD7HQJ9.1Q6JOLM3X3RMH@etsalapatis.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: insn array: return EACCES for
 incorrect map access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
 <20260111153047.8388-3-a.s.protopopov@gmail.com>
 <DFMS1OCR2VM0.30PBICO8ECI9O@etsalapatis.com>
 <CAGn_itxu+pCwxBZ4rmXqEjzynmObD8gnbFrQC_Xn5Z_uxYgJ3Q@mail.gmail.com>
In-Reply-To: <CAGn_itxu+pCwxBZ4rmXqEjzynmObD8gnbFrQC_Xn5Z_uxYgJ3Q@mail.gmail.com>

On Mon Jan 12, 2026 at 1:45 PM EST, Anton Protopopov wrote:
> On Mon, Jan 12, 2026 at 6:12=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> On Sun Jan 11, 2026 at 10:30 AM EST, Anton Protopopov wrote:
>> > The insn_array_map_direct_value_addr() function currently returns
>> > -EINVAL when the offset within the map is invalid. Change this to
>> > return -EACCES, so that it is consistent with similar boundary access
>> > checks in the verifier.
>> >
>> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
>> > ---
>> >  kernel/bpf/bpf_insn_array.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
>> > index 37b43102953e..c0286f25ca3c 100644
>> > --- a/kernel/bpf/bpf_insn_array.c
>> > +++ b/kernel/bpf/bpf_insn_array.c
>> > @@ -123,7 +123,7 @@ static int insn_array_map_direct_value_addr(const =
struct bpf_map *map, u64 *imm,
>> >
>> >       if ((off % sizeof(long)) !=3D 0 ||
>> >           (off / sizeof(long)) >=3D map->max_entries)
>> > -             return -EINVAL;
>> > +             return -EACCES;
>>
>> -EACCES is reasonable but the other .direct_valud_addr() methods use
>> -EINVAL (array) and -ERANGE (arena). If we're going for consistency
>> can we change them all to the same error code?
>
> Would be nice, but I doubt this is possible, as this should break
> plenty of existing user space progs (for insn array userspace code
> with off !=3D 0 actually don't exist afaik).
>

Makes sense.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> (I am also pretty fine with not doing s/EINVAL/EACCESS for insn array,
> but without this change selftests in the third patch look kinda
> weird.)
>
>> >
>> >       /* from BPF's point of view, this map is a jump table */
>> >       *imm =3D (unsigned long)insn_array->ips;
>>


