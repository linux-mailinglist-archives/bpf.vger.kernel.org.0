Return-Path: <bpf+bounces-79010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95FD23355
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8765E307514E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DA33A9E2;
	Thu, 15 Jan 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJkXYCV9"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9133A6F1
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466053; cv=none; b=InHHNFRewg0GGBCh3VrkMzJxmh3R9GpKYRsIH0waJ2jbXu5Uk76gdL+8p/FBHwAjpyMssBssodBttiXmS1J7okqarEb58qoV/eOUjXl1OYBpdwng0+NpaFfQ9XnF32z5/svaLyjc8L0oKFo1BGJ8DDO6R/gkiowBVlckWO+2fBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466053; c=relaxed/simple;
	bh=2EKJYAPuzH7oKPGpx9c+rZgCTn1LKzT+k+fkIG/FR1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONnQWlwCbVQt9kyuLhZoBOccGgzKDvuHBARBRFml3pZOo8XOI82WzGjGR9CAnhqCws9MNDl1lPsZETTZZxu1HpYdqnAw5mD++jWPJpMBtRum6sddsI6qRrTdqR4qEdQMWu/w92KG5aIZuBPmn0rlaiaR6kM7rxTk6b8Cn7gnzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJkXYCV9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768466038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw7DDQX/ZM5AiYqMY7G1eGZ2tEpOcpxd1X3KkINTp4I=;
	b=KJkXYCV9H069dK/Agq+oqiQrHE888vQDRueMyeNIq9PRKUxqnsXOUvrMqbw5MZCTgcjfPv
	kLEAXhMG9+veX1lIfiSTDNvys1HnOONq4STvTmhkB3SJrGi6Hq69odDTTKLcavlA/6oDHF
	SbZqZgFbRCcXspUuANHLVlXNmW6JcWQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 01/11] bpf: add fsession support
Date: Thu, 15 Jan 2026 16:33:42 +0800
Message-ID: <13928754.uLZWGnKmhe@7940hx>
In-Reply-To:
 <CAEf4Bza84H=FL-KxJEFAn6pFpVBQVnvrpif6_gtf_SWHH4pRJQ@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn> <3026834.e9J7NaK4W3@7940hx>
 <CAEf4Bza84H=FL-KxJEFAn6pFpVBQVnvrpif6_gtf_SWHH4pRJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/15 02:56 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Tue, Jan 13, 2026 at 6:11=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > The fsession is something that similar to kprobe session. It allow =
to
> > > > attach a single BPF program to both the entry and the exit of the t=
arget
> > > > functions.
> > > >
> > [...]
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct =
bpf_verifier_log *log, const struct
> > > >                 case BPF_TRACE_FENTRY:
> > > >                 case BPF_TRACE_FEXIT:
> > > >                 case BPF_MODIFY_RETURN:
> > > > +               case BPF_TRACE_FSESSION:
> > > >                         /* allow u64* as ctx */
> > > >                         if (btf_is_int(t) && t->size =3D=3D 8)
> > > >                                 return 0;
> > > > @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >                         fallthrough;
> > > >                 case BPF_LSM_CGROUP:
> > > >                 case BPF_TRACE_FEXIT:
> > > > +               case BPF_TRACE_FSESSION:
> > >
> > > According to the comment below we make this exception due to LSM.
> > > FSESSION won't be using FSESSION programs, no? So this is not
> > > necessary?
> >
> > The comment describe the LSM case here, but the code
> > here is not only for LSM. It is also for FEXIT, which makes
> > sure that we can get the return value with "ctx[nr_args]".
> > So I think we still need it here, as we need to access the
> > return value with "ctx[nr_args]" too.
>=20
> please update the comment then as well

Hi, Andrii. After deeper analysis, I think the comment is explaining
why LSM doesn't need to check the return value type of the target
kernel function in this code patch, as the target for LSM always
return void or int. So I think the comment has nothing to do with
fsession or fexit, right?

Its position may cause some misunderstanding, and if it is placed
after "cast BPF_LSM_MAC", it maybe more clear. (But it's another thing,
and let's keep it still now)

Thanks!
Menglong Dong

>=20
> >
[...]
> >
> >
> >
> >





