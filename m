Return-Path: <bpf+bounces-77922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB5CF6A7F
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 05:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD499301D9E1
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 04:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0172027FB1B;
	Tue,  6 Jan 2026 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HbQwQ5/f"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57A19E992;
	Tue,  6 Jan 2026 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767673426; cv=none; b=G8uSmulhu8seCpuPP0o+vxPjwCWLV/fricId4QeFR5QX7bTZSbioyt53wlsXSu7nPLutjgSvtpHxGnoayXikUxtWqY8dv3+qV1vcauoRk5LauF1va6rYGUooVShbSgLLhWt7+CW1SkS2d+Wdh1zXqb/msyYqyyyN/nWdDSKOKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767673426; c=relaxed/simple;
	bh=+d4UTObG7B3vOsU1/V0pE2H1v4KtoxUIH1wzVajM3Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kn2zSuKWqTo+eKitKgyMqE77c3D39+iM8Nxm8JRPkmaVMdPnB7xiP3OW2kLlPtzIoAtYVMDHnwuC4Vct5JtXFnxlOMlJxNKsybtViIcq1qQCWKBk+s+84zEd1y/WuYGQaEy3znm3FrmFwX6FH/MaIUPth9Przkz8eYieW15nOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HbQwQ5/f; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767673422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+k8T1vKeT4IzIJ2n16Je/FXzJ2D05qm2B0DoklLkj8=;
	b=HbQwQ5/f/Z1Q7Sfsn4UxMPXLMNQtoViGFO6QxFS/i7Yjo3jYIsx/ciU06seRX+4oy98gEn
	TunszrP+davaaNKM8vKWxTuqsca7npXWTdHtg4N7BcXS82F0nSm/eIWGuNEy3SlT4myJ3f
	xOK28E6XziNn5Gv1vgXcDXilsH6xuYw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  bpf <bpf@vger.kernel.org>,  Networking <netdev@vger.kernel.org>,  Chen
 Ridong <chenridong@huawei.com>,  JP Kobryn <inwardvessel@gmail.com>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-unstable tree
In-Reply-To: <CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 5 Jan 2026 18:15:36 -0800")
References: <20260105130413.273ee0ee@canb.auug.org.au>
	<CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
Date: Mon, 05 Jan 2026 20:23:36 -0800
Message-ID: <87tswz74jb.fsf@linux.dev>
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

> On Sun, Jan 4, 2026 at 6:04=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the bpf-next tree got a semantic conflict in:
>>
>>   include/linux/memcontrol.h
>>   mm/memcontrol-v1.c
>>   mm/memcontrol.c
>>
>> between commit:
>>
>>   eb557e10dcac ("memcg: move mem_cgroup_usage memcontrol-v1.c")
>>
>> from the mm-unstable tree and commit:
>>
>>   99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and=
 events")
>>
>> from the bpf-next tree producing this build failure:
>>
>> mm/memcontrol-v1.c:430:22: error: static declaration of 'mem_cgroup_usag=
e' follows non-static declaration
>>   430 | static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, =
bool swap)
>>       |                      ^~~~~~~~~~~~~~~~
>> In file included from mm/memcontrol-v1.c:3:
>> include/linux/memcontrol.h:953:15: note: previous declaration of
>> 'mem_cgroup_usage' with type 'long unsigned int(struct mem_cgroup *,
>> bool)' {aka 'long unsigned int(struct mem_cgroup *, _Bool)'}
>>   953 | unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool sw=
ap);
>>       |               ^~~~~~~~~~~~~~~~
>>
>> I fixed it up (I reverted the mm-unstable tree commit) and can carry the
>> fix as necessary. This is now fixed as far as linux-next is concerned,
>> but any non trivial conflicts should be mentioned to your upstream
>> maintainer when your tree is submitted for merging.  You may also want
>> to consider cooperating with the maintainer of the conflicting tree to
>> minimise any particularly complex conflicts.
>
> Hey All,
>
> what's the proper fix here?
>
> Roman,
>
> looks like adding mem_cgroup_usage() to include/linux/memcontrol.h
> wasn't really necessary, since kfuncs don't use it anyway?
> Should we just remove that line in bpf-next?

Yep. It was used in the previous version, but not in the latest one.

Just sent an official fix.

Thanks!

