Return-Path: <bpf+bounces-67209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0EB40C1B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D790F3B6420
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24003324B2D;
	Tue,  2 Sep 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqON5YJR"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E0231827
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834306; cv=none; b=aX5wFCqMdv9Gpff/Ab4g9qxjQHLwktWOz9g3JN5+pKe/DCAvHIkVHH/9AeO/SYekid7ZABG22LYKdaZD1CNppSDiJnCTsc0Oo1nKZPRyELjTOy7F/HanEpL4H64f7Qr5t08q3pJ3ICwOsZ/0IcfvnbvM4vuuGS/vhigAT2pPIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834306; c=relaxed/simple;
	bh=Xsrqc2vC8VESUbe3k7UKRQ6yvLNYP0SL9eBgq0WXcbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDMEku+CcTBDHBQ3dM5O2/lsZrKzVwS1Et8ZinAE+RNLGfbdCCPTp/Vvh7iXYJdsRTIFPHPrM+fT+HU+cbFpbnwbc0nnF7MEGYvGKx4fMXbw08VTCpUEbiUqByGNfqQ5B24DL7oP+/Ro0I03aF+RZ9AW2LqPT1xmSz+8wSmY3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqON5YJR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756834301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xsrqc2vC8VESUbe3k7UKRQ6yvLNYP0SL9eBgq0WXcbI=;
	b=fqON5YJR9E0oOY9zChFa3RECMh+tJpKRTxbIJKC6PYarEHIcZ/QfF00nZEOrSZSvDKTvdc
	MVRKu4TLEfaFng6AOs31aFvFMefbLXePeDkmFJCO51pU+Pfe55/BscBU4Z5BnfwRfKFyrx
	9dZhuK6N4gU7tY2IGHXHeeJenShmVZA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 26 Aug 2025 12:52:26 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
Date: Tue, 02 Sep 2025 10:31:33 -0700
Message-ID: <87iki0n4lm.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Aug 26, 2025 at 11:01=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
>>
>> On 8/25/25 10:00 AM, Roman Gushchin wrote:
>> > Martin KaFai Lau <martin.lau@linux.dev> writes:
>> >
>> >> On 8/20/25 5:24 PM, Roman Gushchin wrote:
>> >>>> How is it decided who gets to run before the other? Is it based on
>> >>>> order of attachment (which can be non-deterministic)?
>> >>> Yeah, now it's the order of attachment.
>> >>>
>> >>>> There was a lot of discussion on something similar for tc progs, and
>> >>>> we went with specific flags that capture partial ordering constrain=
ts
>> >>>> (instead of priorities that may collide).
>> >>>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox=
.net
>> >>>> It would be nice if we can find a way of making this consistent.
>> >>
>> >> +1
>> >>
>> >> The cgroup bpf prog has recently added the mprog api support also. If
>> >> the simple order of attachment is not enough and needs to have
>> >> specific ordering, we should make the bpf struct_ops support the same
>> >> mprog api instead of asking each subsystem creating its own.
>> >>
>> >> fyi, another need for struct_ops ordering is to upgrade the
>> >> BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the
>> >> future. Slide 13 in
>> >> https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view
>> >
>> > Does it mean it's better now to keep it simple in the context of oom
>> > patches with the plan to later reuse the generic struct_ops
>> > infrastructure?
>> >
>> > Honestly, I believe that the simple order of attachment should be
>> > good enough for quite a while, so I'd not over-complicate this,
>> > unless it's not fixable later.
>>
>> I think the simple attachment ordering is fine. Presumably the current l=
ink list
>> in patch 1 can be replaced by the mprog in the future. Other experts can=
 chime
>> in if I have missed things.
>
> I don't think the proposed approach of:
> list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
> is extensible without breaking things.
> Sooner or later people will want bpf-oom handlers to be per
> container, so we have to think upfront how to do it.
> I would start with one bpf-oom prog per memcg and extend with mprog later.
> Effectively placing 'struct bpf_oom_ops *' into oc->memcg,
> and having one global bpf_oom_ops when oc->memcg =3D=3D NULL.
> I'm sure other designs are possible, but lets make sure container scope
> is designed from the beginning.
> mprog-like multi prog behavior per container can be added later.

Btw, what's the right way to attach struct ops to a cgroup, if there is
one? Add a cgroup_id field to the struct and use it in the .reg()
callback? Or there is something better?

Thanks

