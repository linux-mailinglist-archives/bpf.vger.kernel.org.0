Return-Path: <bpf+bounces-63135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1EB03356
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 00:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72A53B38F8
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7B1FDE39;
	Sun, 13 Jul 2025 22:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD261EF39E;
	Sun, 13 Jul 2025 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752447508; cv=none; b=tTj5bHw7z7RUhHciwwsD5jixd7nYM21IVAnFKg3caWez0KyQEoygNbaxFoUQdk9MVi3cdVBgaXuMT4Zc3/mupx4cT5hySNNPs72JuP24aP8VrScJzVkwSiiyj6y1j8nOh1ZwyEkLXPUBhF/dVy0k+yaNm49SSEW/WrMBWo4YIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752447508; c=relaxed/simple;
	bh=FAvGn4YMY1Z/V5VqsGc27Kf/FnfJb4iSSuObpIHHeJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tDrf/LLTN9U4CfQze5/kGgvZe/SYAtYrY37QJoX/G+xdKTEkktevmk0fMpGRKj9VdaEqIm+hOuMVcnweDVsXQ0MfFh4P+hkr8qNgfeZiw1QxGfKNWzNFrA2ZKapkagwk4cuz1HTjg5+wEpe8czdnxMfqtN0vM0a7qUEEcXg0Sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 163EA341E5D;
	Sun, 13 Jul 2025 22:58:22 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,  bpf <bpf@vger.kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Quentin Monnet
 <qmo@kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/libbpf: add WERROR option
In-Reply-To: <CAADnVQJTHnOVX9uBtTS_7bfiS2SoDL4uL7wJWd0CzbXf08_dyg@mail.gmail.com>
Organization: Gentoo
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
	<c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
	<87a558obgn.fsf@gentoo.org>
	<CAADnVQJTHnOVX9uBtTS_7bfiS2SoDL4uL7wJWd0CzbXf08_dyg@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Sun, 13 Jul 2025 23:58:20 +0100
Message-ID: <871pqjofzn.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jul 12, 2025 at 11:24=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>>
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>
>> > On 7/5/25 12:43 PM, Sam James wrote:
>> >> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=
=3D0.
>> >> This mirrors what tools/perf and other directories in tools do to
>> >> handle
>> >> -Werror rather than adding it unconditionally.
>> >
>> > Could you also add to the commit desc why you need it? Are there parti=
cular
>> > warnings you specifically need to suppress when building under gentoo?
>>
>> Sure. In this case, it was https://bugs.gentoo.org/959293 where I think
>
> I don't recall it was reported on bpf mailing list.
>
>> it's fixed by
>> https://github.com/libbpf/libbpf/commit/715808d3e2d8c54f3001ce3d7fcda084=
4f765969
>
> and looks like it was fixed by accident, so..

I'll note that I've sent patches that have been merged for these
before. It's just that they're sensitive to optimisation level and prone
to false positives. Especially with e.g. -Og.

>
>> (and the corresponding commit in the kernel tree proper). Backporting
>> that was a bit too big for our tastes.
>>
>> The real issue is just that -Werror when we have users who might be
>> testing with in-development compilers or with alternative options
>> results in a build failure when you didn't expect one.
>>
>> >
>> >> Signed-off-by: Sam James <sam@gentoo.org>
>> >> ---
>> >>   tools/lib/bpf/Makefile | 7 ++++++-
>> >>   1 file changed, 6 insertions(+), 1 deletion(-)
>> >> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> >> index 168140f8e646..9563d37265da 100644
>> >> --- a/tools/lib/bpf/Makefile
>> >> +++ b/tools/lib/bpf/Makefile
>> >> @@ -77,10 +77,15 @@ else
>> >>     CFLAGS :=3D -g -O2
>> >>   endif
>> >>   +# Treat warnings as errors unless directed not to
>> >> +ifneq ($(WERROR),0)
>> >> +  CFLAGS +=3D -Werror
>> >> +endif
>> >
>> > Should we also add sth similar to tools/bpf/bpftool/Makefile and by de=
fault
>> > enforce with -Werror with the option to disable?
>>
>> Yes, that sounds good to me, though I was nervous of stumbling onto a
>> philosophical debate about -Werror and wasn't sure what y'all preferred
>> :)
>>
>> I can send v2 with an updated commit message and this change. I'll wait
>> a bit for further comments based on my two replies here.
>
> No.
> We want Werror to be there by default and it shouldn't be trivial to turn=
 off,
> so that people report and fix issues with new compilers.
> Like in this case, looks like it was a legitimate error of
> in-development gcc-16.
> If it was reported to us and turned out to be not a libbpf issue than
> gentoo should have reported it back to gcc devs to make sure they don't
> add bogus warnings to the compiler. Win-win.
>
> You're right, in many ways it is a philosophical debate.
> We cleaned up libbpf and selftests/bpf from warnings and
> we don't want them to reappear. So we don't want an easy way
> to silence them. Report issues instead.

OK then.

