Return-Path: <bpf+bounces-53181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DAA4E241
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6351317CA44
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C527D793;
	Tue,  4 Mar 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HsBac2XW"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174720DD4C;
	Tue,  4 Mar 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100106; cv=none; b=A7YpTux/m9z2ePfWVY14hGIVKMHir1zKw8WrFZge+ZfAYVz8atXP6lfbvBnoQbuq7sptSN/EdypSUK1L6IFTMplWaDqErbqC5OCxPUginW1uE/yPDauNqBFtW+a54BvMw/TDxgrdTQczJ76zMBbTRrB2oq3GDnj8zH7b1glZvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100106; c=relaxed/simple;
	bh=6sXLqOGwJPjjQ1mrwjcKafFgt74IfGmcKaUYu1Vea1Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KpuRLzJFAPlZRIH3Nx2wc+6QXQPteO3vUu6lM7GqxkdQiItrqakn0C90Zca2p0nLTC6F6xiVuVpyfEzLig4XaN5jjwlk1UAML97D9zptJ74INCTQDYVPO0dRlntNYfuduEGCxmoSLvsUOvxekfhApOzzLW+e06afy7uXANb38X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HsBac2XW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524Eqsmu2303478
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 4 Mar 2025 06:52:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524Eqsmu2303478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741099977;
	bh=6sXLqOGwJPjjQ1mrwjcKafFgt74IfGmcKaUYu1Vea1Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HsBac2XWWG8JTb5veE6LuaAtOLLvQu+vBFWgoKJItDg2FR2nOr9Ue8lryfQJFNb5X
	 ojvI2P5MCIyrjDnZDpX41nGdlho2yRe4glo+hru+12GUQ7NBtdvcBedZZUsuJAWMmd
	 N1yfFPWJ9WTY4SudzJVAuXk+ooFW+J2KOOkX3rNtdkndtmyJKXCfOOPoNoEFrEvYyS
	 l+SyUMQ+mbWmrFpz4qKD1NBiUxnxzQF3eOYkhvJKEwllwoiSYqGIWHFHl+eS6oQqxV
	 mHa7p//gFjY/UXuPZ99CFf8KpquSyK6rWISD0Qpt03vNg4h+TUDKnvTetXzksGMPfD
	 /cUCOphcQnqWw==
Date: Tue, 04 Mar 2025 06:52:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Menglong Dong <menglong8.dong@gmail.com>
CC: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
        davem@davemloft.net, dsahern@kernel.org,
        mathieu.desnoyers@efficios.com, nathan@kernel.org,
        nick.desaulniers+lkml@gmail.com, morbo@google.com,
        samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
        akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
User-Agent: K-9 Mail for Android
In-Reply-To: <20250304094220.GC11590@noisy.programming.kicks-ass.net>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn> <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net> <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com> <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net> <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com> <20250304094220.GC11590@noisy.programming.kicks-ass.net>
Message-ID: <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 1:42:20 AM PST, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Tue, Mar 04, 2025 at 03:47:45PM +0800, Menglong Dong wrote:
>> We don't have to select FUNCTION_ALIGNMENT_32B, so the
>> worst case is to increase ~2=2E2%=2E
>>=20
>> What do you think?
>
>Well, since I don't understand what you need this for at all, I'm firmly
>on the side of not doing this=2E
>
>What actual problem is being solved with this meta data nonsense? Why is
>it worth blowing up our I$ footprint over=2E
>
>Also note, that if you're going to be explaining this, start from
>scratch, as I have absolutely 0 clues about BPF and such=2E

I would appreciate such information as well=2E The idea seems dubious on t=
he surface=2E

