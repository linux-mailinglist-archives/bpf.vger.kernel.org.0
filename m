Return-Path: <bpf+bounces-70527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9ABC27E4
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105174EE704
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123120E31C;
	Tue,  7 Oct 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJh0G7kM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB551C8621
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864913; cv=none; b=ChHD2/Gxm9upOAb8EG0nMfmUQF/ZMflzSUZAfJT2+UK4eOt0Fktyu9T5fIBtZHNxjqBpLYLMI7LK5Pz2l05KbnNWsWbMkNXFRK9653MH3mL95wXebmBDU3+oGm2CaLSWqKdwd0Y71LYoZdcAmxthDbZ2bS8lbPALZyiVJhct4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864913; c=relaxed/simple;
	bh=Vo7XQbXXbqbqV/3Jci9jOS/ZxYR9aNRlWbvj5zgqmsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bf47Aas/OpUJqylM0zQ1YP2QAxIrYZAynRiIMCn4MbVOEV4Jje2oaPjovFl9K1sGer//WiAZ8M36E2mxUPGph8gjcH9wNNuusd1XshBgxStq4Tr5wq93K/KC2t5fX39yz8DDuroL1JcQ6VMOUl0hgw6WfIZHBsU79nECUH3pvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJh0G7kM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so8527739b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864911; x=1760469711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SJ3k2Y92yK49xPkMzN/aE9lviZe0R4Li/JZ0Mqr2hSc=;
        b=RJh0G7kMGd+4ZX1x/iZ8gq3WtSnv0ZASYGZ+3FeHlUcJ8XQakZ9WNqLmEJM19D5RKf
         HSaViKTySZ+S3WrTXLDDwz5RQyTA/NhkN+BlFksa1UlXfZ8fhn0FLHChY+qGOAauwjV4
         JtRC718NYHgacf7+7h2XMMpPAClPLIDiSG72ZcBG/xTDkeKR+5a4O6Qi88mGNExgnKPu
         gmgIIdQL8GPDUwSck9od1NYpUf7vJe+xofT7agYxYTAihzz9nEmU4hgLlrfRibMFQ7Nn
         cHW+E5ARtXMWHg8YqXLRZKhdZ6PRWmlGfa8wBf1aAzglprHUyaMJTPPzXcLGG140NeGC
         TFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864911; x=1760469711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3k2Y92yK49xPkMzN/aE9lviZe0R4Li/JZ0Mqr2hSc=;
        b=W8W7XkfOlFtybp6JWU8mF5+vEW5ukp81SRl4XbHvAynuINhozThgHpKkeOkQKQrRlB
         LGs3F6bvGZltmedIyc/nJlfALhMR83RC1qYz8z0wbO6szGsmkfFoe+SICDd8BxrFktlP
         ikOnfAW7hz7qUT1KxWdtNljW2n8jtjtbaRwt5y/3m+qzwbx0wdjiaxjGSMSd5ezYT7Px
         3zgaRdKroghb0k78ucAmLvAGERJe3SUSouy/3Ccje45jLqf5MTbQrxUacQbT6dIv6dy1
         wXuSWbdval0Bqd6iY/PqA43SG+TtD1I5IZOzxt5Y024M+zfQevWRtQgd1FrZ+t5FVYSn
         mCoQ==
X-Gm-Message-State: AOJu0YxwqGMssJTahixteCxbZj0tcMpz2XOUirz5j0k6sVk8ezWAOKUL
	ofioy6cShGqf/Xr0y2UJV1+NP2tmK8MAIENWzCXwbW7kv0IwNFjKd56u
X-Gm-Gg: ASbGncskDMKSQFPwUC+29xfne330k6Sng9zgWAXi9oNjszltKRr9iVrdUrH1VQB7Igb
	/PMk+sURI77WfHY54xl6eg9WHPuJihUHz/D7g9fbcvCUjBUpcmMiq9/C8AY/dOOoz6jpfJ1cBwA
	wr7Im357x2aTaJlXdZfZHlELBQNQNQ+VfHXBGtxicTgJ2XA87YeTI3eKgNJto9Z0iMJZCOIo8il
	CObmzWwIJzAhOMaCT0eFZFs9t2H1hX2BMetdSZlDNLf80VCLaS+F/yuUFSNUBRjCVtoGym5wtWR
	hGtJF/emKwKwo9jmwzCGe9vNXOk11jkRGCg0aMq58uQjO3PlUJMxwzTbl09mf3rEo4F6bhb77/a
	wufCULWD/P1hiZdOb1LGH/e3//mrQdS3C+qE59/ExjoDzCA4tgozFe+7hTTef73SHPFONPeZI
X-Google-Smtp-Source: AGHT+IGwdmm26jvVo00h5CReLU6pQbISgPX307v3tC6fHb2Ep0rnTOyfT4gLcEUhIHmJL+9/cVsjpg==
X-Received: by 2002:a05:6a00:3ccb:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-79386e4f82fmr896706b3a.18.1759864911228;
        Tue, 07 Oct 2025 12:21:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0208e6ecsm16245571b3a.84.2025.10.07.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:21:50 -0700 (PDT)
Message-ID: <12692a9d8dfce6317025949515b9e057823b70c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Date: Tue, 07 Oct 2025 12:21:49 -0700
In-Reply-To: <CAP01T75XqJZa5PCtWm29W3+G5y04ok5F7zM4Q-ge_z2kORuJ0Q@mail.gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-2-memxor@gmail.com>
	 <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
	 <CAP01T75XqJZa5PCtWm29W3+G5y04ok5F7zM4Q-ge_z2kORuJ0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 21:14 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > > @@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> > >               }
> > >=20
> > >               if (is_storage_get_function(insn->imm)) {
> > > -                     if (!in_sleepable(env) ||
> > > +                     if (!env->prog->sleepable ||
> >=20
> > This is not exactly correct.
> > I think that this and the second patch need to be squashed.
>=20
> I was mostly trying to reduce it to what it would evaluate to.
> env->cur_state is always false, so the only check that matters is this on=
e.
> And we fix it separately in the next one. Unless I missed something.

Well, yes, but that is not a complete fix, you need a second patch in
any case, right?

> >=20
> > >                           env->insn_aux_data[i + delta].storage_get_f=
unc_atomic)
> > >                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5=
, (__force __s32)GFP_ATOMIC);
> > >                       else
> >=20
> > [...]

