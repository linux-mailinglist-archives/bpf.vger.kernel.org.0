Return-Path: <bpf+bounces-21001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A9846883
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 07:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B598B1C2538A
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0417981;
	Fri,  2 Feb 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t9BJDGgW"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB81F4EA;
	Fri,  2 Feb 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856569; cv=none; b=tIrQG2U7xAZg0OqfFXBz/O3/xVWZ+Hv/b4snhuoUys64tG4ca79BJoTeTJWXpCxAZ8B82lNCDYZA49z841LJRRmlkiBmg8O8oxW1W2IEY1qXQlcyNu0HchrWs8ZfET/KL1wYNomRrzYv3wGFNoAPwxyk9A7RdmDXlQNHuHoi39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856569; c=relaxed/simple;
	bh=psDefbg/kF79ASsUkMz1eS3sAKLVErIE1EEhmYhufuA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYdWNvzqdL6za9U7CpSqhBrRw+famd8de4iPEyu0MUjVaPRRdx2s39eTwaTs1vt7M69vwbAIkrwTRCOyCAyqvvL+7PchYMy8G9h+7MnfI1wSN/lQmLPAVMhIXQRf2MmXlehbzoeZc31wqrjtnB/CKnK5ecKBmlRzw+2tG8yAoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t9BJDGgW; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706856523; x=1707461323; i=markus.elfring@web.de;
	bh=psDefbg/kF79ASsUkMz1eS3sAKLVErIE1EEhmYhufuA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=t9BJDGgWqQZpeFoMDHQfgB/19gTb7Ka7GBGci1F4B4+NY0oCAUhbFu02S9quGB5N
	 VU56dTABaPIQQfnCpIPZ2xsAkuqmbvmbHSTnLTpTNXWSgVpHmhp/QnnS0BlfchARv
	 UEmsAwZy8R4tZV4nx9y2NcVxPou+Idt+UdDQx9I/6VnXFYpr+5Mxacst8hQjNZlhC
	 xOYkBeOHfPkCKtBELx5vHDtPz0dZBS4sgoLMT6l340L/rT4xByQwgRhUb8f1ytgoS
	 LB/q9otFpW/Y5UeYEjtg23XWUnMuzlsJKseh7QNZ2Rq/FGhdDKb1Azk2VgRAogEiC
	 3bmO5CqVGOqpNgkldg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1qsazJ31Zi-00ea4g; Fri, 02
 Feb 2024 07:48:43 +0100
Message-ID: <daf2172a-8d54-4097-acf3-cc539fe281e5@web.de>
Date: Fri, 2 Feb 2024 07:48:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] perf: Reconsider an error code selection in
 bpf_map__fprintf()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Christy Lee <christylee@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Martin KaFai Lau <kafai@fb.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 YueHaibing <yuehaibing@huawei.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <f15f0df1-92be-4bc9-82a2-1d8fa3275dd7@web.de>
Content-Language: en-GB
In-Reply-To: <f15f0df1-92be-4bc9-82a2-1d8fa3275dd7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:guMMD0U0owRRTK/o4x0F68hE8U9JJPElbEE4i3GuJqzHWW1R2HT
 sH0Z4EGWRndq02j10zfeOmlFsuMWcTocY01WQzj55IfTx2GEaofd0UiNkmU5Hp8wE3DRUxA
 66EGuYd+WeO0W1n9MgablveKN3xDoAC58LZZzpDfV0+2DysblxvSm6H00vhzfZDimtVJV/z
 CwSuyAopcmm7tc3oD4wnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tyHFUlgJYw0=;dgrK/DspkpssIY/mInw6RaOj8L8
 zzTf2dKbygFIyNv1oeJDdblOrP8EvVmHFVb/iQ+pEefr1xabU/7uEb27OtwF4VSNs0vLi2jk8
 obLgtu7m3UCnrc9+Pluirh/Qin4j2TrTt/FlgXhWLcI0M2dmQaryGHZDcJJ59zolxXk3XTQuc
 bo1oBNAXbwcsXCjQ/RUburT/XB972gvl5v/EnKYR/mNlRc9OrQibc3bMp/CgbHKTtCx23hrs0
 E41dZKGXOjSL+RRFEVYGGe5HrWQzlzEtolFjP+aNR+1B/Zfi4kqdPENTbdJ3XHTqnSOvwpva3
 vZGUOCLhRj5wE80z2Jxhhzf6LRzDB7apmxyv+D6NphmrNUYLjPGcivWh1IlVPH1dYMsBsoBQ2
 SSO2KXlKVqKk1UEQP4wX6sU/cyKVHdapsY7Ljl71uyV4puxHx7l0nVSRJJilMkXs2iPvW89vX
 xg/r6zE2uX72n2+jmgHyrlaG2vgHfbwY8v5cytJQ2Df7TvHNgB94TRFDfp54mpkapKdEhg2ZA
 fhJ0JRzs4maXDk2sHPSNVx4by61OKVSGIRBPXA5aHTLxBCllAa2GGw5BQjEbYs6tmb4xVkGJK
 ISu3URZrlraZX+kFLKoSiovCKbEeYsSXkJNbLMkYrrFr+srhnT3IvD5ZW06zzXNQjmwctMc0t
 LoZdb9BY6Kw0C3nygGghSdp56duAB/QATwqfnxIVW9Nx7eYebs2h8pKTJnTMT+uMH8h7k11Eh
 a6Xx2JU42qVyh8Ornsp2Q13xHM0+huJJE98UY0cruVDOT/VG6RBjXVm0+IsMRSRorXAK7Wci7
 lQ7yquTHQffUVxsPE8zuRXAwbLnwE8zF0Xd44K6SiYsYg=

> A null pointer check is performed for the input parameter =E2=80=9Cmap=
=E2=80=9D.
> It looks suspicious that the function =E2=80=9CPTR_ERR=E2=80=9D is appli=
ed then for
> a corresponding return statement.

Are contributions also by YueHaibing still waiting on further development =
considerations?

[PATCH -next] perf: Fix pass 0 to PTR_ERR
https://lore.kernel.org/lkml/20220611040719.8160-1-yuehaibing@huawei.com/
https://lkml.org/lkml/2022/6/11/3


Regards,
Markus

