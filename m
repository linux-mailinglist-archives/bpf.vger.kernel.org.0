Return-Path: <bpf+bounces-37756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97795A487
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E711F22C53
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B651B3B1A;
	Wed, 21 Aug 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL9V7P6l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EA13A895
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264001; cv=none; b=OffxUOvn5k1aemrdhsDrIv+rP81KKI5Q+TflMV8sDz88COV2QynRvctZYvfONgOynUAbjkYup+IzbA8wy2/aeIDAhs8N8Tx8+0Bvb1Fx7tuKZr0t9Pz+iu5Zp54VDyt2975m7zGPxmkYP4eJ0Qo+njYCtzyUPpDOPHUhpaG4BWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264001; c=relaxed/simple;
	bh=MbDTLwk3H2k4Z2OdEucTM1inaW0AtvbtoCVplP70tFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKE512sARI5neOqb5O4xS0Cs7evj1TC8FloeS9jjRP/LCLtbXioly2quQlHTyI8j/ukjVAA1018qFF3j9tSDyykwj6dY/ky6NWUArNEr+vqhJpM4bJ5Bed2+JLlYbFB7NWricyz7ln4QXm26Azho5GQhNuEOGNUudgr0mpd/GCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL9V7P6l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso4313606a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263999; x=1724868799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50o4z+tQPbl/MMIMtaHXHwWCx6PtHMmISZgPMccsV40=;
        b=HL9V7P6le7YxMvzBraVpItRXpkk9aSbNd0QxdZWJayJ3bC0ZyPPBKoXIdqlCF3YcAh
         VgkhB9ReS2caTZGxMVdXW+QdhOc/j6AAHxcnufrNMC2cVcKB7bzTDxXyG2Sd9gjjLwkV
         uggErsQkdpXWkNXL/hMFYsDZQIdG8erPVJ+/X2rm+u6XHoQYCgrGWjdqpnorVkmJ2VGP
         GW+/cgFWIYNXWSTo/KmjQjUodhsXxnNewAu6tnL6bML/WHowXwtoQ7XrfDtjn/KT8FvO
         K7hMUQsPqNTWqgRa4Bva6aFptpujbw3a6vPS2ZY37L7XBKYccuOBQZT3FsrydmBHxvMj
         8d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263999; x=1724868799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50o4z+tQPbl/MMIMtaHXHwWCx6PtHMmISZgPMccsV40=;
        b=daWERpjeaAiZdijjsWLu30fd8jL+dqf7od2Vpva4f7w5lkLJCtMhmxQlCdrvDyTbCR
         KKPtZ7JADDUjobXN7sMx43BIi8ZENSxJAu97OeT/Qn6eA/y3Q/3ZOe71Xl7dqMrhb4eo
         MfoRhs1iCrbFpaa8S8IMZ/VPsWggvJjD7I4ud+Hfv76PaMitmEbvRxTfrxpAfmfgwuka
         2O47OoG9UwVr2I2j5oyxNP/wcwpL/R2Ud/NZh3ZWchgOS2Wa0cIKBHoKSyrfdgW9Ma3J
         IDud/CZtSKiejlRAjZLLg4a0tpqmOzPWBgFXGJM4Liaf+mMQxvWN9BuY/GPVY5F2G7hO
         KeQQ==
X-Gm-Message-State: AOJu0YziGoXYUMdb5ePISU2BRBopLlEYvLocUGuEWrVZvFAh7us1Bd73
	HjXVPoAAW/yCsfS0CCOq+5w+VrE/c/nRKMCfNRP22OGKfVSgkTRrEenwkbEZ
X-Google-Smtp-Source: AGHT+IHYRAsU6iVZRd29mzluuVMOa7ufKfEe2HvJgu7Co1WszXYvrutMCaeHVfXwoKSIPhu3X7Uzvw==
X-Received: by 2002:a17:90a:a40e:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2d5e99e0383mr3293905a91.4.1724263999185;
        Wed, 21 Aug 2024 11:13:19 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebb4d565sm2200512a91.35.2024.08.21.11.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:13:18 -0700 (PDT)
Message-ID: <47a5267b4cd1395dfc9893f1826888a7ee39966f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/8] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <hffilwlqm@gmail.com>
Date: Wed, 21 Aug 2024 11:13:13 -0700
In-Reply-To: <CAADnVQLJNDB9XKVAiMMTdB+YPrb8FO-CbHp4cx_Pd_Nk9ri0JQ@mail.gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
	 <20240820102357.3372779-6-eddyz87@gmail.com>
	 <CAADnVQLJNDB9XKVAiMMTdB+YPrb8FO-CbHp4cx_Pd_Nk9ri0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 11:07 -0700, Alexei Starovoitov wrote:

[...]

> > +static const char *lookup_symbol(void *data, uint64_t ref_value, uint6=
4_t *ref_type,
> > +                                uint64_t ref_pc, const char **ref_name=
)
> > +{
> > +       struct local_labels *labels =3D data;
> > +       uint64_t type =3D *ref_type;
> > +       int i;
> > +
> > +       *ref_type =3D LLVMDisassembler_ReferenceType_InOut_None;
> > +       *ref_name =3D NULL;
> > +       if (type !=3D LLVMDisassembler_ReferenceType_In_Branch)
> > +               return NULL;
> > +       /* Depending on labels->print_phase either discover local label=
s or
> > +        * return a name assigned with local jump target:
> > +        * - if print_phase is true and ref_value is in labels->pcs,
> > +        *   return corresponding labels->name.
> > +        * - if print_phase is false, save program-local jump targets
> > +        *   in labels->pcs;
> > +        */
> > +       if (labels->print_phase) {
> > +               for (i =3D 0; i < labels->cnt; ++i)
> > +                       if (labels->pcs[i] =3D=3D ref_value)
> > +                               return labels->names[i];
> > +       } else {
> > +               if (labels->cnt < MAX_LOCAL_LABELS && ref_value < label=
s->prog_len)
> > +                       labels->pcs[labels->cnt++] =3D ref_value;
> > +       }
> > +       return NULL;
> > +}
>=20
> bpftool should probably adopt similar logic
> just to be consistent?

Makes sense, will prepare patch for bpftool.

[...]

> > +       qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
> > +       for (i =3D 0; i < labels.cnt; ++i)
> > +               /* use (i % 100) to avoid format truncation warning */
> > +               snprintf(labels.names[i], sizeof(labels.names[i]), "L%d=
", i % 100);
>=20
> 100 here and names[..][4] are a bit of magic.
> Pls add some #define and comments to clarify in the follow up.

Will do.

> Overall it looks to be a great improvement to selftests.
> Applied.
>=20
> Pls add necessary packages to bpf CI.

Thank you!


