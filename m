Return-Path: <bpf+bounces-56117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF62A91864
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE52447973
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE42226527;
	Thu, 17 Apr 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a0dzhG81"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AB22A1CB;
	Thu, 17 Apr 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883673; cv=none; b=GMqrAEMM1i6JN/9ueaCzFJ/C/orbbiOOl8tOU9ZmU/fCdzHSDhIasJJIaTp2fEgUS/7g0Bd9Q8sPtOq83di6P9O/2G8jOzOVzdchFOPmoIH6OP8S/KpinDX2PsWUZzkzpV6vycGUTjKuXwnboLJ1fO2ngjJZLi6HWOCUn8vAAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883673; c=relaxed/simple;
	bh=Qfe/CBGkmZbL6EmYdCa433SjCrHvAu5pxnjtFrFLdkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+fXhJSgBPm1So8n8NCKj3VzNvy23pmnV/8WD2BeLlNe+zZU8HlFKv7K7Df8Roh4GDkePSamHlovgZUF+8TaPmI6EPheAcZVQ8FuM98yQYnQoj1/K6WKPzfzUrLrFtf4j1Pxuc+JU6qILN3cZiql8fNABk5l6Da5LYyYFe0mkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a0dzhG81; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=brCIu
	T7WOka4QsCGcvoP2O2amwg+o0P7EpSsxEuWZgs=; b=a0dzhG81c0zNMx5DKhCLf
	0Ek45TfufCikzbBLn8u6S28Z4hrwb1mrQQja0/8SN952ruJkGL5TIoHHgQPrSOHk
	AQ3yX/4n8ybG6b9rkw3M2o6VxIb3VIJrW/mH5Z+Vm0ce5YraRZgprxQA3LO4caiv
	gwWtgBge3Lqp7LBRwP8kxA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXH0hxzwBoI3LbAQ--.843S2;
	Thu, 17 Apr 2025 17:52:51 +0800 (CST)
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
Date: Thu, 17 Apr 2025 17:52:45 +0800
Message-Id: <20250417095245.388120-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
References: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH0hxzwBoI3LbAQ--.843S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr45tw4fWr1xAFWfKr48JFb_yoW8WFWfp3
	W7Ar15Ar4kGa4Ut3sxJrs5ZFyrur13X3yxJwnakas09FsrZFyUJry3ta12vF95Zr95Ga4x
	ZanFqrW5tFyIqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUoOJnUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgUyeGgAyKnWlwAAsF

On Wed, 16 Apr 2025 14:55:43 -0700, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

[......]
> I'm surprised these two are not part of bpf_base_func_proto, tbh...
> maybe let's move them there while we are cleaning all this up?
> 
> pw-bot: cr
> 
> > -       case BPF_FUNC_trace_printk:
> > -               return bpf_get_trace_printk_proto();
> >         case BPF_FUNC_get_smp_processor_id:
> >                 return &bpf_get_smp_processor_id_proto;
> 
> this one should be cleaned up as well and
> bpf_get_smp_processor_id_proto removed. All BPF programs either
> disable CPU preemption or CPU migration, so bpf_base_func_proto's
> implementation should work just fine (but please do it as a separate
> patch)
> 

BPF_CALL_0(bpf_get_smp_processor_id)
{
	return smp_processor_id();
}
const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
	.func		= bpf_get_smp_processor_id,
	.gpl_only	= false,
	.ret_type	= RET_INTEGER,
	.allow_fastcall	= true,
};
When attempting to remove bpf_get_smp_processor_id_proto,
it was observed that bpf_get_smp_processor_id is extensively used.
Should we also replace all instances of bpf_get_smp_processor_id with bpf_get_raw_cpu_id in these cases?

For example:
#define ___BPF_FUNC_MAPPER(FN, ctx...)			\
        ......
	FN(get_smp_processor_id, 8, ##ctx)		\

samples/bpf/sockex3_kern.c:
static struct globals *this_cpu_globals(void)
{
        u32 key = bpf_get_smp_processor_id();
        return bpf_map_lookup_elem(&percpu_map, &key);
}
and so on......
Thanks.
> > -       case BPF_FUNC_get_numa_node_id:
> > -               return &bpf_get_numa_node_id_proto;
> >         case BPF_FUNC_perf_event_read:
> >                 return &bpf_perf_event_read_proto;


