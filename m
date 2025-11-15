Return-Path: <bpf+bounces-74613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688FEC5FD6E
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD143BB1E0
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851A1A5B84;
	Sat, 15 Nov 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQw+BrUD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D362B9BA
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170571; cv=none; b=SsCPH10Q99Ak7K12f5EoMhO7ltunxFCF3z7c6SW7V/Rcg8x5Kn2lzpS5Jh44MsBg6QPixKU6gG+MPhcrJCNO4e78pj6wRJlqaVWLNvnTDhSvdUeEpIHw2Bw3B7jFbfRdZv57cDXeennk/Bvac11tlSxaJGO2cBwwbkJJed+7VEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170571; c=relaxed/simple;
	bh=A4HehiptE0ZVoNMejLAmiuqeLS+Sw9ksFtEuIYT4EVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4Z2z8bBj9WHmAok8UGcNyCCGi6cYxe8gIfCgUjsWVBWUKZrJcbjTtHA9OSD3CpfmMXSRN8KDEKQd5xmTMNBJq8HJCEKtRdEjLMYy8qZxJvEVIpFLAaqF3aR+LbsTxnbMZrMN/NEzO9AgaER97h0dhP9ap4lFSgAFi9r8aqxd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQw+BrUD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29845b06dd2so27932185ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763170570; x=1763775370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1LusS/i9fBFAPmHI+4OnSA97RCnLu4TmN4JqFCOgLDU=;
        b=SQw+BrUDHTzzW1Tsmnv87Ylk1r6vw9jCO+Hkq3zo1vfDDzXqs+2Di/60yPh7VwpTYT
         vkjVbsY+hdvyNfGflqZdmK6u8VoTBrNsjlG022zlGPKjkqqEgDUbO0bh0PSUkwb5wS2d
         CSodkt22KXNUX3i1wIhDH/S1TfY9QxLostrdAp0BIB2VE5fDgKUAurV6ZL3VxJU/zgQs
         s2ufArfxAl86ubNlvqVyMqswrwUaY5iPb2f6yhdP8TA9gu9pTXfCP4GweDLRNoPNVtkr
         PlrRzdmZ6wPqAI50dNqQBPn1Hso82Sr/GtqxILdNZ9WD8GoRhkM7+dd0mXajmpBJ6/12
         HhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170570; x=1763775370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LusS/i9fBFAPmHI+4OnSA97RCnLu4TmN4JqFCOgLDU=;
        b=t67sFJDcTSxz3dTlOZvckLtk6q457s6FENgjpKUWxiX9ePa5MSUkdtUZLLriYaDGUC
         uq7S63rjbVbbcnHp0DRw69NFzqSqk+u5ouyqkuuA1VAsDOWongnEUV3zyXJTKzw+F4mr
         U5aNjP67jBzuUnUabsyzDL9C022fmK2drc+aEI6n+VriWZv72QB9qHtRpp5sc06/0oVM
         BZa8zEdQc/p7nb/p+rUJAWcdZ/VY2po9RVEzy8/P0Wj8WW4SlzblI/xOD4hgM3Yamri2
         KlveKSv6o/PwvulWpUkS7be/ZZIbO205mCNH9WKdgrMOCPrW8j0jyCAky45QVxFq9EGz
         22xg==
X-Gm-Message-State: AOJu0YzzxYb/UPdkPidHSfkcsZxGcvrq9Phg9GLGZguCg1PqykEt+Q9h
	N7TrwI+nOcrgt/lBGpKQmPjhq2+fCE9duMs5V05cd1Ki/fojPJOK4/vE
X-Gm-Gg: ASbGncs3mFv0J31rIOriE+c1rm8fGfqw0eYf1gvZ11gV+eIK9tz5RG21zO7tpWXuOB6
	R7aU2tj3elX4y90xauP9jD5Gb0hVG0b08WI9P3A2vS+dVYjyyiiosLSWoEj63JaPx6H4uilqHtw
	IpJkiZWwlz/7285Qvl7UJFnEwlrwiQ/xEpZelw3daLqMPCg8PO8PJvUQdP5W4n97JbdeDy17d1B
	Lxo/G26OTqH4D73AJZT7olKRPZb9dF5bO82bmc7ZVOYZbyUQb0oJQblOQnqdAAB1uGACo7pCZqF
	2fMI0CaWUx7GpcIKdcaU+e4jwhSIrJoD3hBLni+0PTcsNiP2FxysX8vGzpTs/KEQcN5BXcyUl13
	rytoMVE1cGwG3P6QajgQHtrrCPV/XM28fec3LdKsWJBvMRHSeCSrnjMLpXrKr6LUOjzZ0z4PrH2
	K1/arJ6ADz
X-Google-Smtp-Source: AGHT+IEHvztIEPa6sBJGN0J2qcqiXvbyvd7idLUpIoGYmpXFxVs58aVFdMhRU7dyh6IzZL5nqeNdMw==
X-Received: by 2002:a17:902:cf43:b0:248:ff5a:b768 with SMTP id d9443c01a7336-2986a6abcb9mr56655835ad.10.1763170569587;
        Fri, 14 Nov 2025 17:36:09 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm67630375ad.98.2025.11.14.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 17:36:09 -0800 (PST)
Message-ID: <a99a127ad59926581ad8e12194b644bad59c37ad.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and
 s>>=63
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>,  Kernel Team
 <kernel-team@fb.com>
Date: Fri, 14 Nov 2025 17:36:06 -0800
In-Reply-To: <CAADnVQJB3BbspTWzqi=D7WqkwwuCiQL+es=LVhr=i-uYfJaBdQ@mail.gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
	 <20251114031039.63852-2-alexei.starovoitov@gmail.com>
	 <55fb1a1f8d976e30dbaceff6f07b9e661cdc77f1.camel@gmail.com>
	 <CAADnVQJB3BbspTWzqi=D7WqkwwuCiQL+es=LVhr=i-uYfJaBdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 17:32 -0800, Alexei Starovoitov wrote:
> On Fri, Nov 14, 2025 at 5:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > +SEC("socket")
> > > +__description("s>>=3D31")
> > > +__success __success_unpriv __retval(0)
> > > +__naked void arsh_31(void)
> > > +{
> > > +     asm volatile ("                                 \
> > > +     call %[bpf_get_prandom_u32];                    \
> > > +     w2 =3D w0;                                        \
> > > +     w2 s>>=3D 31;                                     \
> > > +     w2 &=3D -134;                                     \
> > > +     if w2 s> -1 goto +2;                            \
> > > +     if w2 !=3D 0xffffff78 goto +1;                    \
> > > +     w0 /=3D 0;                                        \
> > > +     w0 =3D 0;                                         \
> > > +     exit;                                           \
> > > +"    :
> > > +     : __imm(bpf_get_prandom_u32)
> > > +     : __clobber_all);
> > > +}
> >=20
> > Tbh, I find this test case a bit more convoluted then necessary.
> > I'd use smaller constants, removed the 'if ... s> ...' and added some
> > commentary, e.g. as below:
> >=20
> > SEC("socket")
> > __success
> > __naked void arsh_31(void)
> > {
> >         asm volatile ("                                 \
> >         call %[bpf_get_prandom_u32];                    \
> >         w2 =3D w0;                                        \
> >         w2 s>>=3D 31;     /* w2 is in range [-1,0] here */\
> >         w2 &=3D -2;       /* w2 is either -2 or 0 here  */\
> >         if w2 !=3D -4 goto +1;                            \
> >         w0 /=3D 0;                                        \
> >         exit;                                           \
> > "       :
> >         : __imm(bpf_get_prandom_u32)
> >         : __clobber_all);
> > }
>=20
> Come on :) Now you're nitpicking on constants and extra 'if' ?
> I'll keep the original, since that's what it was in the code,
> and will keep __retval(0), since yours doesn't clear w0.

I did the same for other test cases. My mind breaks when I try to
figure out what's going on with -134 and 0xffffff78 and why s> -1 is
important.  At-least please add some comments.

