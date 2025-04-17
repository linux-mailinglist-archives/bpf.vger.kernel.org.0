Return-Path: <bpf+bounces-56135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C395A91E2D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 15:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7F3AEA24
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF624A042;
	Thu, 17 Apr 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OnbDYLeJ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184CB1991CB;
	Thu, 17 Apr 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897074; cv=none; b=VB9WXtKor2YJZET9SwVX2mDt75bpG/PElIceAUMEeRFwqLXwyOaFBlWnfO4EcTCZ4xD+bPMjDUnVA584DKg4LibqHU5MTX1x/lEc7Y8Pn/AQ8Bjx4v8Uhz1BswG/i0wTY0qW19JKC80X5F5MM6hs2swRJF2/Hzc5eHbtIIs1Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897074; c=relaxed/simple;
	bh=ZC40U240hhAWNxyIn3NOIXdPbYbB5fcBzN4P0heW1QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W9zo7ENSVNn4OpSUrunqhjlQl3vubw6AHuYScxleUZ6+6PgatJkjyhyUpipAFpH15WkE08TY7jnRg6wnfASc7dTbeo+BsK3sLAxslaFPLHSXzMa9kAiEi2/Cg0JmNP7uxOdhBUdOfGhN+/Leg16Qn6pjHBT0EIZm731xzNdoOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OnbDYLeJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=myXGD7KFeJluKxklak
	6/GQ6zhlUX7Drp205IpjUQHLY=; b=OnbDYLeJhOtPy0aKYApQ5mDA3zB+lnUPZq
	1I5FpKhQakIaubBTUe7dcn/NpuGh2eeeAPEVtaFshGYPRxDzzM6PlKVptvCZgu2n
	zS6r2P4SSVF2hau+fABUS90457ohFMFKJT3KRu0FQ+FxFcrCys+aa2wyc56WIFE8
	z+z30npE4=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCnFxfpAwFo6bIBAg--.1118S2;
	Thu, 17 Apr 2025 21:36:41 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Remove redundant checks
Date: Thu, 17 Apr 2025 21:36:41 +0800
Message-Id: <20250417133641.7518-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
References: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
X-CM-TRANSID:_____wCnFxfpAwFo6bIBAg--.1118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xJFW8Wr1kXF1DZFyrJFb_yoW8WrWDpF
	yjkr15urs5Ga4Dt3s7JrZ5ZFyfXr1fX3y7Jwn2k3909F4DAFy8Ary3tw42vFZ5ZryFk3W8
	Xa9rXrW5Ka4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUOTm-UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgEyeGgA+-zRrwABsZ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 17 Apr 2025 17:52:45 +0800 Feng Yang wrote:
> > >         case BPF_FUNC_get_smp_processor_id:
> > >                 return &bpf_get_smp_processor_id_proto;
> >
> > this one should be cleaned up as well and
> > bpf_get_smp_processor_id_proto removed. All BPF programs either
> > disable CPU preemption or CPU migration, so bpf_base_func_proto's
> > implementation should work just fine (but please do it as a separate
> > patch)
> > 

> BPF_CALL_0(bpf_get_smp_processor_id)
> {
>	return smp_processor_id();
> }
> const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
>	.func		= bpf_get_smp_processor_id,
>	.gpl_only	= false,
>	.ret_type	= RET_INTEGER,
>	.allow_fastcall	= true,
> };
> When attempting to remove bpf_get_smp_processor_id_proto,
> it was observed that bpf_get_smp_processor_id is extensively used.
> Should we also replace all instances of bpf_get_smp_processor_id with bpf_get_raw_cpu_id in these cases?
>
> For example:
> #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>        ......
>	FN(get_smp_processor_id, 8, ##ctx)		\

> samples/bpf/sockex3_kern.c:
> static struct globals *this_cpu_globals(void)
> {
>        u32 key = bpf_get_smp_processor_id();
>        return bpf_map_lookup_elem(&percpu_map, &key);
> }
> and so on......
> Thanks.

I think I understand the issue now: removing this bpf_get_smp_processor_id has no impact.

For the code:
 case BPF_FUNC_get_smp_processor_id:
    return &bpf_get_raw_smp_processor_id_proto;

This configuration allows bpf_get_smp_processor_id to actually invoke the bpf_get_raw_smp_processor_id_proto function implementation.
Thanks.


