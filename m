Return-Path: <bpf+bounces-56378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B17A9607B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FE7189AB8D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D82528E9;
	Tue, 22 Apr 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="enGmkuWH"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8677149C7D;
	Tue, 22 Apr 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309090; cv=none; b=vBJUSWM8hs/iRXHDlP2fp5k4gv0AugQFoIOHfFwvI0n5JSlhduBvB+8ChKjTPu0kTfFyc46lNwqL3hhymUO4oG03sHi24YtuFrtqgJ9ZGiUnO3YRBvnEE55Vv7VxM7RJdYoAvva7oL2+qEP21X1Q7q7RopOod6pvyJJAJClwsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309090; c=relaxed/simple;
	bh=dKg2iMASpZKlpSKiCHccH+FM4Cc+jvpjBNHcnykSyl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cq5DtR9FpytH2os2GN9aO8J0FTVUgyOHx0RSHfykiDFB8K/v4aRyNWmwq5kZ5NW3GnNCoYSUqEbEBvCHX8FMZJWNDOyW6vouszxxjbg8KtYoRZDxlp91Pl4NUWWlAfxcFPc+bOvBg4bieUKTC9ZRtU+c+CEpfq83aqjE50b3Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=enGmkuWH; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jhwxs
	X7bT2boAjm5LCgWVLRdP11jribrR6xBUttHT2I=; b=enGmkuWHo4kn5hs42kTQo
	RXk0rfNiJPybF1+3puHxHV6tKuyZhXVBJOFgaizbheuToAlnjR/f9e3If7KTZxnB
	4q8aDBpZ705wabm6FBz5fKhjR864aN0lcUHkrqVxPMuYCMSayp9tYzHXOZ4cLclf
	C7VZxQT8f94ZFDzMU0Ljck=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAHGGuDTQdoB12hAg--.4613S2;
	Tue, 22 Apr 2025 16:04:21 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	song@kernel.org,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn,
	yonghong.song@linux.dev
Subject: 
Date: Tue, 22 Apr 2025 16:04:19 +0800
Message-Id: <20250422080419.322136-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAADnVQLnij-d3Hif1x8ocoYD=8sZG67qACXPZhK78cpYKczwkw@mail.gmail.com>
References: <CAADnVQLnij-d3Hif1x8ocoYD=8sZG67qACXPZhK78cpYKczwkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAHGGuDTQdoB12hAg--.4613S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xurW8ZFyxAF4xZr1xuFg_yoW5tw1fpa
	15AFy3Cr4kJF4aqwnrGr40vFW5Gw4Uu3yxCasrK34agr4qvF9rXr1UJr1S9F9Yvry2k34f
	AayvqrZ8KrW0qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVKZAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRM3eGgG8cnG3QABsd

Subject: Re: [PATCH bpf-next] bpf: Remove bpf_get_smp_processor_id_proto

On Mon, 21 Apr 2025 18:53:07 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Apr 17, 2025 at 8:41 PM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > All BPF programs either disable CPU preemption or CPU migration,
> > so the bpf_get_smp_processor_id_proto can be safely removed,
> > and the bpf_get_raw_smp_processor_id_proto in bpf_base_func_proto works perfectly.
> >
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  include/linux/bpf.h      |  1 -
> >  kernel/bpf/core.c        |  1 -
> >  kernel/bpf/helpers.c     | 12 ------------
> >  kernel/trace/bpf_trace.c |  2 --
> >  net/core/filter.c        |  6 ------
> >  5 files changed, 22 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 3f0cc89c0622..36e525141556 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3316,7 +3316,6 @@ extern const struct bpf_func_proto bpf_map_peek_elem_proto;
> >  extern const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto;
> >
> >  extern const struct bpf_func_proto bpf_get_prandom_u32_proto;
> > -extern const struct bpf_func_proto bpf_get_smp_processor_id_proto;
> >  extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
> >  extern const struct bpf_func_proto bpf_tail_call_proto;
> >  extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf50..1ad41a16b86e 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2943,7 +2943,6 @@ const struct bpf_func_proto bpf_spin_unlock_proto __weak;
> >  const struct bpf_func_proto bpf_jiffies64_proto __weak;
> >
> >  const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
> > -const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
> >  const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
> >  const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
> >  const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e3a2662f4e33..2d2bfb2911f8 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -149,18 +149,6 @@ const struct bpf_func_proto bpf_get_prandom_u32_proto = {
> >         .ret_type       = RET_INTEGER,
> >  };
> >
> > -BPF_CALL_0(bpf_get_smp_processor_id)
> > -{
> > -       return smp_processor_id();
> > -}
> > -
> > -const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
> > -       .func           = bpf_get_smp_processor_id,
> > -       .gpl_only       = false,
> > -       .ret_type       = RET_INTEGER,
> > -       .allow_fastcall = true,
> > -};
> > -
> 
> bpf_get_raw_smp_processor_id_proto doesn't have
> allow_fastcall = true
> 
> so this breaks tests.
> 
> Instead of removing BPF_CALL_0(bpf_get_smp_processor_id)
> we should probably remove BPF_CALL_0(bpf_get_raw_cpu_id)
> and adjust SKF_AD_OFF + SKF_AD_CPU case.
> I don't recall why raw_ version was used back in 2014.
> 

The following two seem to explain the reason:
https://lore.kernel.org/all/7103e2085afa29c006cd5b94a6e4a2ac83efc30d.1467106475.git.daniel@iogearbox.net/
https://lore.kernel.org/all/02fa71ebe1c560cad489967aa29c653b48932596.1474586162.git.daniel@iogearbox.net/


