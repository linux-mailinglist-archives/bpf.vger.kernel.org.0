Return-Path: <bpf+bounces-68416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F369EB5847C
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520E17AE8CA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A592C15B3;
	Mon, 15 Sep 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va42zt0U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B382773F2
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960514; cv=none; b=FWUbbt1KQQbnpBo8S3tyxPXSYMff+fzQ+cGndCg3+DLtHPToefF1SAPGoXA+zzmftUC9EL3VZ4yjuS+nErAx4jW3OisDEbgBkTkNC+LeBpl+mVgC8p8KUMPNbQzYWwW4Ypd1iPLow6u2VFN9wSGP6Nb9SLSqmRJ4dEpvltl7KO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960514; c=relaxed/simple;
	bh=a9g39sFuiujVl72igjUzIjGDjYyg3gvWt8oNViaips8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0HRJ/X3xoUJ1MoDNOl++NO69i6U4JVHJ2kzoY24tJZV2zYZJ04yWZOyvwaLk7NDRx4WF7scnpQLLZQDtoBlilK8I40hqQSMwwY29g4ka6s6c6O874SkGSW+KorIM3tkIbcv+hnaHZJJsFZbckLiv97ZtEoYK2lG4SgIf9FG24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va42zt0U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3799370a12.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757960511; x=1758565311; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vK0v4zJsD+lWcOquvBbw4ZDATYzcIy3oRQvb6rgaNdE=;
        b=Va42zt0UY2Uwjz+uDT1+taAVEPzPaBonhwDOJio4iXic9uzT+DD0UxHdmvsl6ckzJ2
         uy0uhz64re6Y0xKk4sIMaVE6Y44XLEVK9OVaKdUGJc497Xkum4OKhnzTXRYAYAYYDd7b
         LziAvon0bVQYc6YgR8BGWGEwTGzEgpf10BcsdT6TwFYoqZSUQCf6dnlV1Sw4nH+EL3El
         gy/vOzreVv6H6r3wWLPvSWYQhB3hwHyzmaPRnRKThRupcTu4qzgT9KEtkp3W9WGZJIIF
         Gs+VTReqGcYogsUrOSqr3x1O0ZVgnxbtjCmaVB6KmjeC40FOtDmRhoW9FtHwv1SsZBlu
         zR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960511; x=1758565311;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK0v4zJsD+lWcOquvBbw4ZDATYzcIy3oRQvb6rgaNdE=;
        b=OJMpduHA2bHayJS1H2GKEmJZSDGtOi05E/90PXbmE0tEyfRs/UhHVaRN600kLqVISN
         gtp67B6hRN0CK3KCkB5Vy6qRTQs9IIeG+n0FBWLfL+j8FS5KsL/X+BPOodtGw2u800gA
         vriPzO8wQl8hPcF04icNArLVx+Y85BEWbA5yHFsVq8859GsLX7iJLTDwmW1FZjqhw339
         ojW5xpaS30dclznJD+5drUw3IqRsNd4QlOzz0HFEfAaCjzcBZDUup+Yy35nl8bXqOxVO
         OiyFkAHLhqqBVcyDu56ASW7bDc3tPCHeksfYfFJGjN88/fH/JEXXve5QpM8yqkl1HrtV
         vPLA==
X-Forwarded-Encrypted: i=1; AJvYcCVRn00yUNJ5Z8QVy982KfCsshlxpBJnRV8vO+rOglafdcd0yB1h6EhCNExyawIPAy1U+Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9nvyPF9TkGoCbxfVoh0U27xOZS/ZZwe7mJyCSxL5vRlGwXQC
	ItXoLG3/fJwlVncYdV8xV/h4lR9ErJd9kBRKVpe/zu2djTl8ApzP+9ao
X-Gm-Gg: ASbGnctzSsJ6a0mc+C4Gg0HsDXt/LmW7oC32X1hAK82LhX6fdpLo8TY/w0KSgOqQBH3
	XejZIeWU9dOrKXmI4zldpp9XfOCGWh9lTEik4Jg7xdRZ32Tds866Le+e0fUe9Rgd39M1rpTHH5K
	J584MxQF5R3YYE+bnypIj49VxuZOIsFz2Hxuo8KVNfiNFk8S/68bcK0a/T6BPZw5ysoAjKt60ui
	dcCaHHyInVUjyb4tiyz8uhERbwJTXyMe6hYnyBHPVOILcR1VXVS7y2yS/m6stBalJyuNqFEFTuD
	bW2R3vXVpcjbjWmLAyKnWuY1L4X/KCsBENIMqkSbe6Xyr5hH5Kh/RakIr7nI+MRbX7gz9Mo2L+N
	RmynmwdbIe+IOI/3HFbsgqZBRERvK5e/hKv6J99LzfsFXcSgohyWKvQ5cE24=
X-Google-Smtp-Source: AGHT+IHD4X1F7PqnZbgRig3ECt7MKp6xm9DsZHBjrtlUCKzDguX3gfdU6FSCnnUAjT16c60hqt9RCA==
X-Received: by 2002:a17:903:286:b0:24b:1d30:5b09 with SMTP id d9443c01a7336-25d24bb2603mr129607555ad.13.1757960511209;
        Mon, 15 Sep 2025 11:21:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267c5e5dfb6sm612295ad.125.2025.09.15.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:21:50 -0700 (PDT)
Message-ID: <f8337cf1b17b9bf2ee31ebbb5f79ab7290ca4263.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: potential double-free of env->insn_aux_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org, 	andrii@kernel.org
Cc: martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev, Chris
 Mason <clm@meta.com>
Date: Mon, 15 Sep 2025 11:21:49 -0700
In-Reply-To: <fdc291d2-ec13-4a54-9fad-bc905edf4ff8@iogearbox.net>
References: 
	<20250912-patch-insn-data-double-free-v1-1-af05bd85a21a@gmail.com>
	 <fdc291d2-ec13-4a54-9fad-bc905edf4ff8@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 13:42 +0200, Daniel Borkmann wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9fb1f957a09374e4d148402572b872bec930f34c..92eb0f4e87a4ec3a7e303c6=
949cb415e3fd0b4ac 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20781,7 +20781,6 @@ static struct bpf_prog *bpf_patch_insn_data(str=
uct bpf_verifier_env *env, u32 of
> >   			verbose(env,
> >   				"insn %d cannot be patched due to 16-bit range\n",
> >   				env->insn_aux_data[off].orig_idx);
> > -		vfree(new_data);
>=20
> I presume you mean bpf-next tree, otherwise we'd be adding a memory leak =
into bpf tree?

Hi Daniel,

Yes, the tag should be bpf-next.
Will resend with the correct tag.
I apologize, this was sloppy on my side.

[...]

