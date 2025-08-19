Return-Path: <bpf+bounces-66051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E023B2D000
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 01:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387F41885C98
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453225A34F;
	Tue, 19 Aug 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LTRdl8Q8"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D11DDC2C
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646329; cv=none; b=DPwYZfo9XqBNvfCyMgqamKpS4HFyvA3T2J0tvi7n/plIh1eSwaF2YKJlQg9xQUOAjY6I+BlyFEvbc2cLw3oCw4Kw9h4j12ZfnydO1V1a59JVcSGOc9cqskMp3obY38+D3/xB4j590+46/5g9C4NSjHJEeJgS4oyj9y0ksQPvA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646329; c=relaxed/simple;
	bh=rA9wv+pWnx1zpBDWKfX6eyU3H5xcCfx6wo8nlwToeOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhCdb4QVbHgkxBvKnRWqq9QNiInLRWE+Wl9ipiN4wEy2uUhxqAGmCLYES0GZq9r5AJYOgCC+bKiSa6S13mRY4Ji5YUsceP1CeRosUZO3/lP5OSjQwgirCEN0NfT5852PU9sbzqPVk+hQgXHNTM+NtzSMeMXBCmkpAk9au9RUJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LTRdl8Q8; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755646315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTcaclbQ96B+bDuBdiEL8ARlJKH5hHL3AxN4AB69H20=;
	b=LTRdl8Q8BJzAwYcj49uLQDdPuiA4IbEhrwThhy3zCP+J/PfKqPZxPiKjiXbPvT1KZYtAZD
	ZHryLZDWX1GYdOQAh9ymUnZudKtpRCEv9aeYuUCTdc+SWe+Z90XJSSdbQK7kVmg8OPjtBz
	cLwcYOtaXcz9h0M0vfYrwMunlb4GRUQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling
 using bpf
In-Reply-To: <87tt23vt8u.fsf@linux.dev> (Roman Gushchin's message of "Tue, 19
	Aug 2025 15:31:13 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-13-roman.gushchin@linux.dev>
	<CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
	<87tt23vt8u.fsf@linux.dev>
Date: Tue, 19 Aug 2025 16:31:43 -0700
Message-ID: <87cy8qx50g.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Roman Gushchin <roman.gushchin@linux.dev> writes:

> Suren Baghdasaryan <surenb@google.com> writes:
>
>> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
>> <roman.gushchin@linux.dev> wrote:
>
>>
>>> +
>>> +       /* Cgroup Id */
>>> +       u64 cgroup_id;
>>
>> This cgroup_id field is weird. It's not initialized and not used here,
>> then it gets initialized in the next patch and used in the last patch
>> from a selftest. This is quite confusing. Also logically I don't think
>> a cgroup attribute really belongs to psi_trigger... Can we at least
>> move it into bpf_psi where it might fit a bit better?
>
> I can't move it to bpf_psi, because a single bpf_psi might own multiple
> triggers with different cgroup_id's.
> For sure I can move it to the next patch, if it's preferred.
>
> If you really don't like it here, other option is to replace it with
> a new bpf helper (kfunc) which calculates the cgroup_id by walking the
> trigger->group->cgroup->cgroup_id path each time.

Actually there is no easy path from psi_group to cgroup, so there is
no such option available, unfortunately. Or we need a back-link from
the psi_group to cgroup.

