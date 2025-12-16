Return-Path: <bpf+bounces-76748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC0BCC4F7F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37CAE3026AE3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2611324B1E;
	Tue, 16 Dec 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKt+o8KG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7112BE03B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911612; cv=none; b=kU71zsAHlYYy6BrKO8PSD8szGLoZpjnX2WVp5xY9xbS+7U20bEqJ76C86y6AkILF4eU8xFCZjduSAN60NNr4H2AMTcigL/hY33Ey2KQnGwM4uRuuQN1ptw5NhoX2cMk8Smy1zio6kYsOBcb7N2Hndg6KTx1k3slUIz5Lpsuxhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911612; c=relaxed/simple;
	bh=YqJppSM3N1lVs+dZVU90sAWaBAKivjSVKD4fLrgaJ1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMGjLwI0ok6e9+NjfjWRCiMflbHbgoLvWiGyMZ6oT7R68KzSXrB97fRRbuLyslYn5ajgHhmS/iJAhqMl8kHA9AH5cWyArauSbIQNjBJpI00HLQhCKzcKjLv8yjto/NMmMFW6PHhtEdji5UIIA9E0B9bakdZ8ZxfmWJA5j2WsdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKt+o8KG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a1022dda33so21497695ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765911610; x=1766516410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ErDbfMssRATXGxHjLxSzn3yFHh8SWcmqP+WDDCX6deA=;
        b=FKt+o8KGIUx2U4lbEi8Rsue2MZSPzz3I/qb0gfTCjmzAtuwJ3vZiAFbOj+yN/oW3KF
         t+g2deACaasDTSHbDzvIfmUry6Ret6NP8S4wZZ5A/0Yxogg4ElC3jtEHmMnEZUnxgNtE
         li8UjmQ5m6EamNEnOgSOzmKnuutcrgzxauqHtnbw2k3piXj4WejTzCbEKdBzoU5Soi0a
         5EFN0tPcJdGpkUXskXiRjVSRpxLmmAR+G/AE+0Q/UULLSGH0cbTtJ6s7ImLLFJoskvKw
         qSbf/g/cvGluMl6YM+GrnuTrkjFxJJalASPIhgIUcmrRl7MLV3YeZoxQ9+k1jxIAUc+c
         4FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765911610; x=1766516410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErDbfMssRATXGxHjLxSzn3yFHh8SWcmqP+WDDCX6deA=;
        b=g48JrHiI7x9rawWqYuyhcVWwW3wCmJE3M9uSvm9O8j98QuG2McmCVgEMkpiEmH+KnI
         0Wk3AYSEHtL7Uqku1jOafmDiqqE04Yvc5Ev5i0HlZDw3Aj/jqotrg93Ug1pUZkuz+dSH
         RtO9YcDYG60mdV6KOTPmWkx/AoN57v+j43nRNbTeS1ANS7+KtcKBm9FbqSIY5Ujb9l7S
         JJjhZT4hJKw8WrLsF9uuJfj4tIpIR3tJBzugh3JgH9nRi63KT8ZC4RezTUa9xhIKsaPw
         9F7LCrlwO7uQs4X9iZv/zdc85d0T7+rodUjdpektpp7K5oZPXQSQ8YdbRrgUsaNW5HMt
         iN0w==
X-Forwarded-Encrypted: i=1; AJvYcCXeGiGDQJsIY1tI1+YsfqtTSyt6/6ixMs/CpsdSBoZk2rRmgZTqIRsUn3TVeJiWTOad3c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgYYTqCzcFvh1rhdiJlPZ6Ub3CBq5f9o3/0KK27vsFIKmoBXh
	sS1BOa5m0wZzqG76t/xRdC+XSS0ZHGMKQSTYUvJzhdBfF+sx2zHGiT3k
X-Gm-Gg: AY/fxX5j6LGe7xKDrTZXA0k97SzFSTt1TQmsQbtB26hZZlnEDS3tunNu3uIsMxr2H6H
	YtrIrK7zz1D1ho8OD5IiZsUdE+iurLsUaCUAD+ecQpgfQng/RVSfI6daX9OPtkGVTG0Ga5xSZ8E
	liA+eBI/6JaVrI1a+h7vKYyRiEyk/ObRf/MLfReas2skvx8puVyVepjZ+MyvCIOpiOydvspA7cH
	hXfIMOr/+MrCWl/VFmcBlnvvfEgqi8TBq0uBq7TAweGSEdG/o/0KgyHlq+AstvwZORymjNjGYXz
	63kwc2sDSPqOA8tE9B+XWGtekfI/j8D5uWHusFw7K+ziQcchqyP14qfU+cB6AsWy/tSfWgd6eW0
	0/0+PaTFiUlOFLmdKmz/1m+Sa87mxbzs0DWZdGxi1mYLvqpd3L/71O2j6Gb82t25Nv0BLndsf46
	SfXlr/WtqvTGZf9qBn1C8=
X-Google-Smtp-Source: AGHT+IFs/FdElIPP4l5xRrG2PH6ypXBvqXazp0nTxSiUptMGxXZFrwdIuRJ8ZD/LL8rMzq81vad0gQ==
X-Received: by 2002:a17:903:1a2e:b0:2a0:b02b:2105 with SMTP id d9443c01a7336-2a0b02b228amr119674595ad.56.1765911610111;
        Tue, 16 Dec 2025 11:00:10 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0bb39db53sm89765315ad.11.2025.12.16.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:00:09 -0800 (PST)
Message-ID: <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	bpf@vger.kernel.org
Date: Tue, 16 Dec 2025 11:00:06 -0800
In-Reply-To: <20251216171854.2291424-2-alan.maguire@oracle.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
	 <20251216171854.2291424-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 17:18 +0000, Alan Maguire wrote:

[...]

> @@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct btf_d=
ump *d,
>  		case BTF_KIND_UNION:
>  			btf_dump_emit_mods(d, decls);
>  			/* inline anonymous struct/union */
> -			if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
> +			if (t->name_off =3D=3D 0 && !d->skip_anon_defs) {
>  				btf_dump_emit_struct_def(d, id, t, lvl);
> -			else
> +			} else if (decls->cnt =3D=3D 0 && !fname[0] && d->force_anon_struct_m=
embers) {
> +				/* anonymize nested struct and emit it */
> +				btf_dump_set_anon_type(d, id, true);
> +				btf_dump_emit_struct_def(d, id, t, lvl);
> +				btf_dump_set_anon_type(d, id, false);


Hi Alan,

I think this is a solid idea.

It seems to me that with current implementation there would be a
trouble in the following scenario:

  struct foo { struct foo *ptr; };
  struct bar {
    struct foo;
  }

Because state for 'foo' will be anonymize =3D=3D true at the moment when
'ptr' field is printed.

Maybe pass a direct parameter to btf_dump_emit_struct_def()?


> +			} else {
>  				btf_dump_emit_struct_fwd(d, id, t);
> +			}
>  			break;
>  		case BTF_KIND_ENUM:
>  		case BTF_KIND_ENUM64:

[...]

