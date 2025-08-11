Return-Path: <bpf+bounces-65362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B9B2124F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449A1189D9C1
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B2296BBF;
	Mon, 11 Aug 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="etmL1eJv"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E82472BD
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930082; cv=none; b=cAGjfrGzRj+DgLTG+kdfdA55Rx5MFOdvXwHq47O5fV5p7cZws4PjKNCKgSeS6KdH8R8Z8tqPwudLdFZlq0bJG2G4bWZMgJCNtVbU5DwcXb3pDn0F6n7MxSXTVva3I4+pFLBBmr4Xeype0blthXGaz9W+VveP5Fp1Ig4LaOHZ6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930082; c=relaxed/simple;
	bh=A0fQUFrh5CKZY2qb1RZMZpnR8CB+0gdEKlqL3rSdRfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=b+Tc8kmP7rwZAznYES9LFhPkqluZfhRGDjpJzhNPlQMQ6i75WIIBcz1NMubOW94ICiBafHf/dl5AcJHMk8MpvltugrvQXBGZ0+zPE40b8xNCpb909MNf3VEPGfDxsj7dzZY4ioYjzF+PZpUtraLyzuyqdJ/+HKIJ0TnZlenqfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=etmL1eJv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754930077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BVDNftn7hDQP+70b/7pwzBphYCpqICAbVF+DfJVGeg=;
	b=etmL1eJvnqp+9iTppDrznl5rvtCSJE6Pgt0yTSQm5IN35DvarXb7Kr2zZoNk6WPJCQAVUn
	fro1ZZBZz3o+GX9SlHIYdewCwXGlMcQdO/DJG6AS8zsKtQ/+f8esNd8QFirvd1EpG2K/fW
	5vmy9uxwSGScVkQWGV9f0Q+1q68Lq3A=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 00:34:23 +0800
Message-Id: <DBZQSD9VQH74.2QI9A7CK5GM3Z@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Yonghong Song" <yonghong.song@linux.dev>, "Song
 Liu" <song@kernel.org>, "Eduard" <eddyz87@gmail.com>, "Daniel Xu"
 <dxu@dxuuu.xyz>, =?utf-8?q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
 <20250805163017.17015-2-leon.hwang@linux.dev>
 <CAADnVQ+Mkmy+9WnepShLsQtMWceFUpfsV-Tw=dMaXP-B15R2yQ@mail.gmail.com>
 <DBX6F51OAZSO.3OKUPR14AGTSI@linux.dev>
 <CAADnVQK7N2HpHsbNgfot02zF0yak4F=gqcWw1cJqB7kRyK9yMg@mail.gmail.com>
In-Reply-To: <CAADnVQK7N2HpHsbNgfot02zF0yak4F=gqcWw1cJqB7kRyK9yMg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Aug 9, 2025 at 12:23 AM +08, Alexei Starovoitov wrote:
> On Fri, Aug 8, 2025 at 9:11=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>>
>> On Fri Aug 8, 2025 at 1:20 AM +08, Alexei Starovoitov wrote:
>> > On Tue, Aug 5, 2025 at 9:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
>> >>

[...]

>> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> >> index 233de8677382e..67bc35e4d6a8d 100644
>> >> --- a/include/uapi/linux/bpf.h
>> >> +++ b/include/uapi/linux/bpf.h
>> >> @@ -1372,6 +1372,12 @@ enum {
>> >>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exi=
st */
>> >>         BPF_EXIST       =3D 2, /* update existing element */
>> >>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update =
*/
>> >> +       BPF_F_CPU       =3D 8, /* map_update for percpu_array */
>> >
>> > only percpu_array?!
>> > Aren't you doing it for percpu_hash too?
>> >
>>
>> Only percpu_array in this patchset.
>>
>> I have no need to do it for percpu_hash.
>
> You're missing the point. If we're adding the flag it should
> work for all per-cpu maps. Both array and hash.
>
> Same issue as with your other patch with common_attr.
> We're not adding a feature that works for 1 out 10
> commands/map types/whatever and doesn't work for the rest.
> Flags/features have to be generic and consistent.

Get it. I'll do it for other percpu maps in next revision.

Thanks,
Leon

