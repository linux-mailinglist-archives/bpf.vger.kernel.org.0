Return-Path: <bpf+bounces-67371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0AB42EBA
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 03:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A26F7B8C0F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326661A23A6;
	Thu,  4 Sep 2025 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kfue+q4u"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DE18B12
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948393; cv=none; b=kEFSmhhbgPbCYZo+vJliY2tuoxfkGby6Nb/S4Qz0XVJL3NaVwSihDIK+Jnd4fUKbTLoNWjiuAq6T9nSNfvL4EC+/o3gB/vy1a+CVphSNXv8T7w7zdEWZsEpE0p4s9w+ORNheQm1UWUJCRu6bRE0cbXgy2eqYE/YC/19cdwrYmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948393; c=relaxed/simple;
	bh=EztcU3I2jQu/JANSrFiQs6YdssHNrEuZtzcIEgzOo50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWmjEkTj+r6sLJ5xTB0gTgylpgJgIcy6K09e1+/cl2SLhoyTTpb0Fg++wsS+a5E/+l9ExnIQyvr4FB0fldbQx6cQodFTWkBxQuwgR1wjbrXrOYJUXp8Qc4yQfXzljbTim07jf+h01lmUwkFkQmtVqKSOz0f5i/UrMhiF0Qe1mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kfue+q4u; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756948380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/YdEdpdY6Oro8d1rFM7+q7LaJ8Hyug3oWsbG3ERi6U=;
	b=Kfue+q4urULTY/Sv4Jusx10FkSy7wsftg2H7iFLQgu5BAnzsUwZKOliqNMWYet95ck94M1
	RFN69Bwv6howDbyF2Jy2bnhXr9ZmDxmRUSfzcPkuwxth+WHLLSi98e44xaggv9GmNITXtG
	KBMnAz1skKwEZTrZaKmvPE3kigtD/JI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 yikai.lin@vivo.com, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v3 0/3] selftests/bpf: benchmark all symbols for
 kprobe-multi
Date: Thu, 04 Sep 2025 09:12:18 +0800
Message-ID: <2797578.mvXUDI8C0e@7940hx>
In-Reply-To:
 <CAEf4BzZVTr26Uogf8uh=7HmgG6Qo_uVy3fX8bQgC+Xs63wZcCA@mail.gmail.com>
References:
 <20250901034252.26121-1-dongml2@chinatelecom.cn>
 <CAEf4BzZVTr26Uogf8uh=7HmgG6Qo_uVy3fX8bQgC+Xs63wZcCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/4 07:50 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sun, Aug 31, 2025 at 8:43=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add the benchmark testcase "kprobe-multi-all", which will hook all the
> > kernel functions during the testing.
> >
> > This series is separated out from [1].
> >
> > Changes since V2:
> > * add some comment to attach_ksyms_all, which notes that don't run the
> >   testing on a debug kernel
> >
> > Changes since V1:
> > * introduce trace_blacklist instead of copy-pasting strcmp in the 2nd
> >   patch
> > * use fprintf() instead of printf() in 3rd patch
> >
> > Link: https://lore.kernel.org/bpf/20250817024607.296117-1-dongml2@china=
telecom.cn/ [1]
> > Menglong Dong (3):
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >
>=20
> this doesn't apply cleanly over bpf-next, can you please rebase and
> resend to let CI run?

Yeah, I just notice that. I'll rebase and resend it now.

Thanks!
Menglong Dong

>=20
> >  tools/testing/selftests/bpf/bench.c           |   4 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  61 +++++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------------
> >  .../selftests/bpf/progs/trigger_bench.c       |  12 +
> >  tools/testing/selftests/bpf/trace_helpers.c   | 234 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  7 files changed, 319 insertions(+), 219 deletions(-)
> >
> > --
> > 2.51.0
> >
>=20
>=20





