Return-Path: <bpf+bounces-44714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F509C6724
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8D9281A38
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8BC86AE3;
	Wed, 13 Nov 2024 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrscnCer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1C3C00
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464154; cv=none; b=QvJ8FskBmKpZ1d90T7IYrclx6NX1vbnyk5cuUY/hVNk0Ux78xaizToge5/ZNxeWQitUzEhfYSszWz5VgYM6R6Il3yK2fWv6sajqIMu/0UdzZb4OzpGR8B0q3CFB9zBMZVaMJKuBni/vp4rux0k9M71LctbuZxUDhP9CcjMeVd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464154; c=relaxed/simple;
	bh=zdobcRLU3zpNgAVd0UtiBu7VZ2yIv7a7lmJIcwzrM8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQOK3tERiy0l+GkgcvYTnJI7T53+mdVkSBTZDH5gZ/jza5674GwIoTw0WGO5xgh5TJiaZRzvS26K17sxhpbSoOoDITz2kQ6yAiTO5e21txFajdqmCFmDbaZo1xleZYWCWf76H9mdG5MYMhDYGXLKG1lCV2zHl5wXuSpncxBt4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrscnCer; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d518f9abcso4571705f8f.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731464151; x=1732068951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdobcRLU3zpNgAVd0UtiBu7VZ2yIv7a7lmJIcwzrM8o=;
        b=MrscnCerr/hrp5UInC94W7rc3OfEQQ6TA+EMTq1/kmVvH3JU66ZL55mAcTDZt60wT3
         V5d4Dymq1sTisyhpvkunIXZAr34XOywWraURgYb9YMHG+9Blx1CZf4pvEiBet+veEY1b
         aSnR55AFvrjjgsHwNDEol2NRj84di0J0Mgzec9JDCLgUVgqpKgVyErdnQvPSf2qJwp0P
         lpTr8Py+dfTbpRRIY8H+lEMsSXn5YM7mG/KNaPzGv6Ab4ngX3YmxgzXQ9je+21xSV0XG
         zoUxeWBDZb99sdWjMZsI49TEuYgf9Sx82knSSkrp0XmegqysgAEvN4aD7jxHN8Bl8VCV
         XpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464151; x=1732068951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdobcRLU3zpNgAVd0UtiBu7VZ2yIv7a7lmJIcwzrM8o=;
        b=J993PWRkc8JbpjTtwJhoyh/R6RvOfU9Uso2Y+EUppHAaXt6wv9FhmwtryMPxjSjKx+
         ZPrmX+Pkj4VhAt9UJ5RUYzApn10Of7qiJ4S8ZoLD8CmTLp5E/5trZ0sPfOlNKwqaecnd
         nPBl2VpZpRcRaBCKmg5J0pPaTgXBLmf0Lr8JK0FwiPZ8J7xLdwh5GSmbKKO5gNn66/HZ
         E12xosLCRvQSNpSJ/olv2CIFnKDeBia7mBtLtutV0Rzt0ipm2j1M9xAGRILn2/waYFuL
         Xvp94TsZpQ/2XQQ6EX8wruwod7yGz8dZCogeZLPQrI5y1T6xXhy3q6Oh6wdUnNYgCBFA
         +88Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4KveTm8kPNhGqP/a4+ukOBlEsfVIAE4+IqszF2ucwIwcOs2Bjpu+EzkOLtyFkYCp7gq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5T2o9ivFpCxHyuA3dN2r0S1rkQoo9r1x8+k+z1+/AKfId8WQC
	HUi3K7J0gbFYCgmN1GM988neYmaYg7E2+bKn7leesXXYWWv5ZzQSvQzKsK8gKxkHFOuf8yb53yJ
	PF1YbCp2oKaT9r/SkYfRKdiHFji4=
X-Google-Smtp-Source: AGHT+IEtUHluEM/+WdxCPCbnDIG+k4V/F8s5di/2CEgIh5psLYhbxxs3s+MQRNE3m2qLD+SoFMJ/5WETwjIaCIS49II=
X-Received: by 2002:a05:6000:20c3:b0:382:51f:60a7 with SMTP id
 ffacd0b85a97d-382051f616cmr4831231f8f.33.1731464151028; Tue, 12 Nov 2024
 18:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107134529.8602-1-leon.hwang@linux.dev> <20241107134529.8602-2-leon.hwang@linux.dev>
 <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com> <ZzQLkD02BA/FQMeB@eis>
In-Reply-To: <ZzQLkD02BA/FQMeB@eis>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 18:15:40 -0800
Message-ID: <CAADnVQL=J9oaJ=c-h8HNgD_86-MuUuYKCtpHXCRZOsLv-b7KYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, x64: Propagate tailcall info only
 for subprogs
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eddy Z <eddyz87@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:11=E2=80=AFPM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Actually, I am still on it. I will start sending patches this week.

Ohh. Great. Cannot wait.

