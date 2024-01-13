Return-Path: <bpf+bounces-19513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A0382CF0A
	for <lists+bpf@lfdr.de>; Sun, 14 Jan 2024 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7501C210ED
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96545168C6;
	Sat, 13 Jan 2024 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmdddede"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF402D297
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso5393294f8f.0
        for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705186789; x=1705791589; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwW7pAb8oI+Zo7yULci7GTMKUJ7KyoOW7yBAdV1m6XA=;
        b=Tmdddedeit9sMRSsjyf26BnT2dwbbh+XfbaWStQcgZCIgyXVwADtPbmGrMp94qE/+j
         5TVcsMGmdd0P4yy7Q7NA/JozR7iiz7bOmnyXjCgTcytKVj8qAt+GssgZ66V6J52/Qgkp
         vgwcB3l72xAMPT0lei4vXsIBEHM0VH/tXOhaBnH/cnwu85MAtrguN9n7eSkkpSYsmVls
         2Y4oxnVTWUeAHCDN+Ly4iiJPjmIFDeklsylQunymEctL0eTtm9xQpEuPo6u9eUs3qgIk
         aR8/slCVRY4fx2t3IL10RGQnzzw+mXd1nJJIKQfF21/JUfaBR5SmDY9qe4R/gwzlp49I
         uKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186789; x=1705791589;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwW7pAb8oI+Zo7yULci7GTMKUJ7KyoOW7yBAdV1m6XA=;
        b=KX32jK42GNBAW7Kb6ke+BNpIg3/rvz6kFWAuZaV+NbWRQQzsaeshTa58ew8DqE2z2O
         /c0U4Y2JUIvKZkKGxdZnILQqHNu3zojcqSBznDQ1DqzBAsczeyjqEmnmaVuhPvWMdyRP
         xeHqOl0lONKTO/fe8SP8ffF+UcgKVD4ZHeOGbfO/pxcnX4FBAUn/H+aO6rUR24mufwaQ
         0++rYM2BB1bokusVrm/GAcR9Xoqwahzovyr4Tjv8c38hgZWs2LOpaljzPhfX/XMsP4s1
         P+I1I1RZOZtTcCei8QbEWsGc6NnQdB44k6oqF5+d6LnUkLdDt37iCxuf6FtNPwUD7PQ7
         nIeA==
X-Gm-Message-State: AOJu0Yxvf7Ypc2zQO56boPL3mPREuI/mf6NY9Vj60LqFcqwQqKURPv3Z
	Kjs9DSypgUu6mMJi6T76nfI=
X-Google-Smtp-Source: AGHT+IEFZc7tY0mfBxcI4qXEVrBgxZ6NO3cBSDB0UYH/wZ6h2FJvv6dn7kubkvmTCUrHl1pQtHOK7w==
X-Received: by 2002:a5d:540e:0:b0:337:4bab:dd68 with SMTP id g14-20020a5d540e000000b003374babdd68mr1988462wrv.82.1705186788419;
        Sat, 13 Jan 2024 14:59:48 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j9-20020a508a89000000b00554930be765sm3552087edj.97.2024.01.13.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:59:47 -0800 (PST)
Message-ID: <97ba6ff9e3573b391f79ae19cda529b9f4d1883c.camel@gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Fix an incorrect statement in
 verifier.rst
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau <martin.lau@kernel.org>
Date: Sun, 14 Jan 2024 00:59:46 +0200
In-Reply-To: <CAADnVQL9djzwkJ9k053ZA6Ck_K47eKsfAgmtEU-d9r-OBtG=Zg@mail.gmail.com>
References: <20240111052136.3440417-1-yonghong.song@linux.dev>
	 <CAADnVQL9djzwkJ9k053ZA6Ck_K47eKsfAgmtEU-d9r-OBtG=Zg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-13 at 14:39 -0800, Alexei Starovoitov wrote:
[...]
> > diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifie=
r.rst
> > index f0ec19db301c..356894399fbf 100644
> > --- a/Documentation/bpf/verifier.rst
> > +++ b/Documentation/bpf/verifier.rst
> > @@ -562,7 +562,7 @@ works::
> >    * ``checkpoint[0].r1`` is marked as read;
> >=20
> >  * At instruction #5 exit is reached and ``checkpoint[0]`` can now be p=
rocessed
> > -  by ``clean_live_states()``. After this processing ``checkpoint[0].r0=
`` has a
> > +  by ``clean_live_states()``. After this processing ``checkpoint[0].r1=
`` has a
> >    read mark and all other registers and stack slots are marked as ``NO=
T_INIT``
> >    or ``STACK_INVALID``
>=20
> The typo fix looks correct to me.
>=20
> Eduard,
> since you're the author of this line. Pls double check.

Right, it should be r1, my mistake.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

