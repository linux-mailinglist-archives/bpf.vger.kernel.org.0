Return-Path: <bpf+bounces-45297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C32DA9D414D
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD74B347B7
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F41AA794;
	Wed, 20 Nov 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHC+v0FI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202CB1474B8;
	Wed, 20 Nov 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123431; cv=none; b=YdaS+Io2f+SDxZVfjN5KgQcLiyZBYvBSuZA4kowE4+OBxLPZor+eUYdKayTiXcIHCTDRaAZYSGDTi+VXlMadgcVlEzOBKlz5Bd+OaCzIFS2LyaOxUC8aMpKizsjK/vTQL7sZ6cK1zf0FUOLKyszqEf4Rsq3WHWUI2wDTPIAkz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123431; c=relaxed/simple;
	bh=Kr1oHrqtIKoCUGV5y50uMqeEZwQSfQmDYF1WYiyJCak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D329VC7saAMs/MJyQNGP352i4Lv6rJ3leITpB9vHxACvuNGf/dmoJuQJ/4KI/L9zW+LNV6DG5+TXumSiad94e2skyvmgLw/8C9Kpcc7GnTa1Cf/j/1udQUAmAKYb4/ZBJwhXreSfZGOy/Q9W25zsqK3u5oDTA3IyxSZp58tQtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHC+v0FI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso875252a12.0;
        Wed, 20 Nov 2024 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732123429; x=1732728229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K82r1s3WallUAKq8xTbVEjB6g6JIYaNpg7uvLlAPkQw=;
        b=JHC+v0FIB/hGvxLmjnQVEACvFJNz5+LHYt8brPtDWEt2+zwCTwxwAps3vp3jx7TVfI
         le0NmKf6oFvkJjJ2oyQW/pBP9f26C3Us67PnuwoRFp6TpMzBy5R+RQYfJek3T2ZWktmf
         8PTw43Sq7omY7M6LnB5Nzw2KDI/txUApStWf6qTIJQHZYp59XxmEv5y10MEyuDQ3Igzv
         54MmOPq83eMC2f3LYYUvZUKovjEJ+9gnYOCHK3AXEuKutgP9pqnoQly1kQDnP3yZecKg
         cK7RdYn8+Ukn4yXqMESqB7DYC3WyDLs/9od3VEMXprhs1DTQf7GMjNjH1twV7rQBxmL9
         JUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123429; x=1732728229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K82r1s3WallUAKq8xTbVEjB6g6JIYaNpg7uvLlAPkQw=;
        b=FsUXI7htADYmn/4fJCEy3w8RhLn5EpdJfvmhNfl4NzqDpz3gM+nflUpb+3NbLL18Ou
         AiJkuyANsWRz/nbuIF2H/ejX8UsfT2j/y1DN6O0HzKW24qC9rDdWwj4dko092B3EZhr1
         tpaWhJTVz9gGP7cEXYWZGGmiQNgJ2lYJkaiADWNA8NZQD3rs2CwM1GCtbhT6cvcrmZCb
         gCRAPYrUSbMkFP5BmxmIKyL477l0eCX0QALKR6gEVR9DPPkQ66iT+p7mwGQp+9XVHrDT
         DiEwr2QRdDIH0zdKCU0beHDo3wZw0Ywol5CAGR0lWHmETC0RQNU2oO4/+4Mo+KhoP4om
         xCYA==
X-Forwarded-Encrypted: i=1; AJvYcCVfKcTm+nrBQhm2IvjxRIEfdxiltg7LNVGO1lBdZ/ke1sgKvAh0k/y3Rs7F7/00gIyEAy0=@vger.kernel.org, AJvYcCXFONyAUMXWyrSeYuWWhH7dHrOcfBBV1g2IqZXbpnBldUMYiGO9VFXpZDVMuK0ueosFSW0BGQCWD6LQCgu3@vger.kernel.org, AJvYcCXy3Hs4zOvBzzawjBTG9RnA4knFDrTMiUha37famoGoSozWOtNV0UzQkrhXN2J8KD+rrMJMSR1mvDRvjUjz7kmlrzMy@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhYPFmjf+otUEUf150Fk02M4iJcs7+eIKxad4xiVu/xvIzuMa
	sz2UYwtUXo/nPfR+rnxbIAYSsijsw0b9ts78g1s0JMyzoQ5KktL8jv42lBxNwwxnzBIPyNc8wzw
	A6mLyArWnADsIbJ2NiyiYmpuPIq0=
X-Google-Smtp-Source: AGHT+IHP7MwwbUafLVgAIa430YYzk55icxxelHryoONobsnY3WSgX4XWdMcnoyaJxl1EXEi6b8slsuO4SxdmbK2qy18=
X-Received: by 2002:a17:90a:ae0e:b0:2ea:9f3a:7d9 with SMTP id
 98e67ed59e1d1-2eaebd1a85emr235585a91.3.1732123429227; Wed, 20 Nov 2024
 09:23:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>
 <20241120154323.GA24774@noisy.programming.kicks-ass.net> <Zz4IQaF9CCfjS28S@gmail.com>
In-Reply-To: <Zz4IQaF9CCfjS28S@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Nov 2024 09:23:36 -0800
Message-ID: <CAEf4BzYR44BgfAjKAvppmyG_hjojBL7XZe75C0qBTPoE7WXzHg@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com, 
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, viro@zeniv.linux.org.uk, 
	hca@linux.ibm.com, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:03=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Wed, Nov 20, 2024 at 07:40:15AM -0800, Andrii Nakryiko wrote:
> > > Linus,
> > >
> > > I'm not sure what's going on here, this patch set seems to be in some
> > > sort of "ignore list" on Peter's side with no indication on its
> > > destiny.
> >
> > *sigh* it is not, but my inbox is like drinking from a firehose :/
>
> And I've been considering that particular series WIP for two reasons:
>
>  1) Oleg was still unconvinced about patch 5/5 in the v2 discussion.
>     Upon re-reading it I think he might have come around and has agreed
>     to the current approach - but sending a v3 & not seeing Oleg object
>     would ascertain that.

Is this about Liao's siglock patch set? We are at v4 (!) already (see
[0]) with Oleg's Acked-by added.

>
>  2) There was a build failure reported against -v2 at:
>
>        https://lore.kernel.org/all/202410050745.2Nuvusy4-lkp@intel.com/t.=
mbox.gz
>
>     We cannot and will not merge patches with build failures.

This one is about this patch set (speculative uprobe lookup), right?
It is already at v4 ([1]), while you are mentioning v2 as the reason
for this to not yet be applied. Those build failures were fixed *a
long time ago*, v4 itself has been sitting idle for almost a month
(since Oct 27). If there are any other problems, do bring them up,
don't wait for weeks.

>
> Andrii did get some other uprobes scalability work merged in v6.13:
>
>     - Switch to RCU Tasks Trace flavor for better performance (Andrii Nak=
ryiko)
>
>     - Massively increase uretprobe SMP scalability by SRCU-protecting
>       the uretprobe lifetime (Andrii Nakryiko)
>
> So we've certainly not been ignoring his patches, to the contrary ...

Yes, and as I mentioned, this one is a) ready, reviewed, tested and b)
complements the other work you mention. It removes mmap_lock which
limits scalability of the rest of the work. Is there some rule that I
get to land only two patch sets in a single release?

>
> Thanks,
>
>         Ingo


[0] https://lore.kernel.org/linux-trace-kernel/20241022073141.3291245-1-lia=
ochang1@huawei.com/
[1] https://lore.kernel.org/linux-trace-kernel/20241028010818.2487581-1-and=
rii@kernel.org/
[2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzYPajbgyvcvm7z1EiPgkee=
1D1r=3Da8gaqxzd7k13gh9Uzw@mail.gmail.com/
[3] https://lore.kernel.org/linux-trace-kernel/CAEf4Bza=3DpwrZvd+3dz-a7eiAQ=
Mk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com/

