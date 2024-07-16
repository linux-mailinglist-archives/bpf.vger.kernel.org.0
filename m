Return-Path: <bpf+bounces-34908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EA932387
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26ECDB23355
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58548195B3B;
	Tue, 16 Jul 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/gAHmQb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E7225D4
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124243; cv=none; b=ie7oidIlwILc/x5TqeTbJQFJr2fTIjRKQsRLumMdgGf6uqQw7FG7ENhoqwzoY8xyGWoG56LskztNYBx0avIkjFbUogFx43cKrsyNCinr8N3pO6aBEe4n4YSMzg1/h5e2ca1rUFLjgMA7Sg1H71Spr/HoI/BqgcDQYhuVAfi0qB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124243; c=relaxed/simple;
	bh=bkmXHwKWUoOGiTljSJP8nvdTiRAmAYJtotjECqm92vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XM6p88lZPh8ceZBVcjpg905+i9/TL5pEOLRus5u7Em21vDqsehifl4aE09LblxtMEbKA+yhBB71W1e+iKmn6vdL7tiam8xVosjwIdFjNXJsK/GyWopsAtXZymzUefTgKsnHxEfjA8jyxW6EqstlocLrtzio46MAEWWuN/aQKUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/gAHmQb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so25069205ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721124242; x=1721729042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fstaakyR9uTLpSwd5Z8rXvcBJQf8s0EwpBgj9tjtU9I=;
        b=L/gAHmQbpDNfL0y0q7fuyoZFEiHKCesz+4mnOwC6IKwvJdNensXrsakNX0YuXze8Ct
         Pre4QKmyMTeYaC3uHiISkKLIZkQAiedNtKu95c1nPfaG4gEOoJ8x2CCG043rq1YgW2N3
         tp8jvRrJz22MH7Mgg6ZI4QxSyGISq2CwyTzV6PdpmrLSFCwaSMxJabdRBj90J6CkPBSS
         AsiIsSH4nXU8p/Z8YVitZEH448UjRICwZrwZc0sJzxjpq/YZW1qUDs0jbDiTB2cgfBZ4
         5+mQXJFnpVlaK8yr2YQfwKKQmfdamwsrtGIhJlFzRZ68+sDdBBR6Y8UNnDRi4ThVbPtg
         JKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721124242; x=1721729042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fstaakyR9uTLpSwd5Z8rXvcBJQf8s0EwpBgj9tjtU9I=;
        b=PSFL7EQcp6qAX+k5nz1ZXPuOLEGnkYLqkZXLfdWUPnemAc/pbuepgGDNTUvKFeokAx
         NtCEiizSXEpH92/9OQmw+zENQL7vnPRlHCGSRNooAxYWIHNuQMqCzcUNBjYhNyNMbx2+
         PMbRWpMtlIYvpo1f16hINh4aJpfLJbrBtAnkiuKcffeiEbMq2HItpQiqSS2OQdgTBBAE
         d2bZTNSb/DNPt5JklggUWLPIe4m+LO/adYEvCUhfCBOmT/vZLHk5CDKQXFj9Y0shYFJR
         m0WLlrNmy+kbo3v+bdLYiQKlMqIfaZjUS7uuWIz94Zc9Z92Z5XYxVr6EQYa58Ky7Kv1k
         HUbQ==
X-Gm-Message-State: AOJu0YxtxGTp+/iJB73IthV/tkISdmO6lfSO/BC4b7VjvsnmS+fXMKIb
	NNjCBoHxAdlUIs4BQQGCWZ/1892O20ngkItpk2RK30Jl9czO7Kbu
X-Google-Smtp-Source: AGHT+IExKGqPHBxRWtYsem9hWWCldzpHrX4/jKyqxIIpDfM1JipZ616jY2ipJq5w/PzCf3p8zKrOXQ==
X-Received: by 2002:a17:902:e888:b0:1fb:696a:47b3 with SMTP id d9443c01a7336-1fc3d92d172mr13014125ad.7.1721124241659;
        Tue, 16 Jul 2024 03:04:01 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5372dsm54621115ad.295.2024.07.16.03.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:04:01 -0700 (PDT)
Message-ID: <86c8004aab94e0e833b438ef2fba25f0835a9aa8.camel@gmail.com>
Subject: Re: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for
 ARG_ANYTHING helper params
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Date: Tue, 16 Jul 2024 03:03:56 -0700
In-Reply-To: <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
	 <20240715230201.3901423-12-eddyz87@gmail.com>
	 <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 19:00 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

[...]

> > This might lead to a surprising behavior in combination with nocsr
> > rewrites, e.g. consider the program below:
> >=20
> >      1: r1 =3D 1;
> >         /* nocsr pattern with stack offset -16 */
> >      2: *(u64 *)(r10 - 16) =3D r1;
> >      3: call %[bpf_get_smp_processor_id];
> >      4: r1 =3D *(u64 *)(r10 - 16);
> >      5: r1 =3D r10;
> >      6: r1 +=3D -8;
> >      7: r2 =3D 1;
> >      8: r3 =3D r10;
> >      9: r3 +=3D -16;
> >         /* bpf_probe_read_kernel(dst: &fp[-8], size: 1, src: &fp[-16]) =
*/
> >     10: call %[bpf_probe_read_kernel];
> >     11: exit;
> >=20
> > Here nocsr rewrite logic would remove instructions (2) and (4).
> > However, (2) writes a value that is later read by a call at (10).
>=20
> This makes no sense to me.
> This bpf prog is broken.
> If probe_read is used to read stack it will read garbage.
> JITs and the verifier are allowed to do any transformation
> that keeps the program semantics and safety.

I tried to run the following program
(should have run it earlier):

SEC("raw_tp")
__retval(42)
__success
int bpf_probe_read_kernel_stack_ptr(void *ctx)
{
	unsigned long a =3D 17;
	unsigned long b =3D 42;
	int err;

	err =3D bpf_probe_read_kernel(&a, 8, &b);
	if (err)
		return -1;
	return a;
}

And indeed, it does not produce expected result,
the retval varies around 22079.
However, I don't really understand why this program is broken.
E.g. from C compiler pov pointer &b escapes, and compiler is not
really allowed to replace object at that offset with garbage.
Is it a limitation of the bpf_probe_read_kernel() that it cannot read
BPF program stack?

