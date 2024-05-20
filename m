Return-Path: <bpf+bounces-30028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D266E8C9F24
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6752813FE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5A1369B4;
	Mon, 20 May 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsJahsin"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155891E878
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217157; cv=none; b=tSrE9NBxu/gu1zjpgfJxfMhwK5LUMIf+K/CaiDtMgINcCUHVlFEM7f+x7kn9edaS2fHAaGmhLKm9FxtgvRlLn3ED+CMcjdSm/379lhhm3Ri46WdHqkxl4rN9UGNgOkhCzd7StnKWZiQPmOgPaTwDoj8bKWVtNuL44z35ZtNiOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217157; c=relaxed/simple;
	bh=WyWrElNaUXVoHnbG6p+pKl5bxMQZjKGN9IShyMCviNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCuD8walTrX77DPukaqXTDk9hppmUs+kXwxkuaN64CNLw9QQgxrsm+5Axi6xx6N8RD+ttwDuMWmi2OCY3g11v+kt5QKlsqZhEZ9gz7QLF7ugRIKStOq7JhXcrO6NftbyKxO16Xjn+2VqkBCgObFRZQQ1suGC+9c+yUYGOoOfvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsJahsin; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-352129e3c8eso2398628f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716217154; x=1716821954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DpcBI+qfP2yjnEHD73CNplrNEsDfsJQEVymt3Vkg4A=;
        b=JsJahsinf5eA5oOy+69bvb9gJVHg8fAAVm1cPreMg5jE2vWvSxdEJPrFNunaLLsHH2
         F2dKkP9EeOCIdbsW+5mTslKt6/1tjh4xaeml6uSqL/tNLO6eOYcfzUtp2q+3kC3oV4vv
         hvXKQgU/JclboMwnZuhBLnj+yh7sOoanSHqZuA5cWwPN6gpOdW3vZCzgPrtosSwGDkrr
         EwSSxibtLahqUISORyssv/FU87AhDXuKbSmmroK33RIQiJcj3OTRVk5WQ7RuCrgcb/fV
         uJRcv/Wp9wU8Ef+a7E8KZPEJCoDrNLEFJhtRtTBC0B4KsXsXHs3QH5po+aJNruPEpzoc
         e6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217154; x=1716821954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DpcBI+qfP2yjnEHD73CNplrNEsDfsJQEVymt3Vkg4A=;
        b=YJ7WCW/zmW6YofvfxtT2ovz8z9CsMg+LCNQGUkUj3bdBEi8jYMSUQHjnj5f5vPTL2n
         OwoMdF+xpYG2/gTxkDsMulKlcYh6AUL5WsjF4ha7ZwBbyF+wluxACtDLGJKLLR/gWW3O
         ba4B/QpxEYSG/xUHOJzeGxwtImh3t98J5/wCaH2LU5rJ4+RG/TVAc88AkSwjD6RwEkUZ
         KgaBaHCXcDOWeCZf6KJETb6jgtFxV9eme0LzGCQErzT84Y7XFwPvuSXxvJ4Zb3cw5Eg3
         OFaHgNBzZ68J45x+JKp39lZI2v/XGBTA484bBvntWIYKie9OiMcw4+zxt1BKn2YgTF/e
         XK7w==
X-Gm-Message-State: AOJu0YyxGBwhL+Kb5EQwBZuXKduo67tL3xovH9XoFOZKRnXZ9bMA2WPc
	DHa4a/FVdPLYG4JSMeLgUQwyHE/psKW0Trf8uP0X4eBuU1ug6gBlsFrHYX7r2djx1MRGuTnAfbC
	nuEXYJMq6zOUHD6t7L3QpI0zxIVk=
X-Google-Smtp-Source: AGHT+IEPfy+NSI1tmQDoInXI7NTmnvV9z5QREE4EtTZcoufl9RNP3WhIVkF+xFiR97pYJiMKZLWym90i4pjO0YLA4TQ=
X-Received: by 2002:adf:b651:0:b0:351:c6bd:ee1d with SMTP id
 ffacd0b85a97d-351c6bdef5emr15446797f8f.32.1716217154058; Mon, 20 May 2024
 07:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520091424.2427762-1-ramasha@meta.com>
In-Reply-To: <20240520091424.2427762-1-ramasha@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 07:59:01 -0700
Message-ID: <CAADnVQKZcqddcAOWWZaqsTrSXm4LA09O1Sk3rr6DRnjzm0uxVw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/3] Fix and improvement for bpf_sysctl_set_new_value
To: Raman Shukhau <ramasha@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 2:14=E2=80=AFAM Raman Shukhau <ramasha@meta.com> wr=
ote:
>
> Changes v1 =3D> v2:
> 1. corrected copyright comments
> 2. unsigned int for sysctl name to prevent build test error:
>    "R2 min value is negative, either use unsigned or 'var &=3D const'"

CI disagrees. Same failure in test_progs-no_alu32

42: (18) r3 =3D 0xffffa5bd00dd5014 ;
R3_w=3Dmap_value(map=3Dcgrp_sys.rodata,ks=3D4,vs=3D152,off=3D20)
44: (85) call bpf_strncmp#182
R2 min value is negative, either use unsigned or 'var &=3D const'

pw-bot: cr

