Return-Path: <bpf+bounces-63263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901CB049BE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0FB167A22
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11223BD0B;
	Mon, 14 Jul 2025 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xC6TWPEo"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445961A0BFD
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529828; cv=none; b=MWVHdozDh2Q9pDBXI70dzGJUNwVi/VJx8qBdtbz4p2kSfHJFwriBlJRoNCtE4Hkx3vEh94xGZJ6Xn2q0sxH+9U/D2M1TCKzLiwLSntuEbAUEwR42FY4Ar650S4NsDx9mkNaqjNutAMikfM6LA15o+sqOhliAC/m38OfzrhnTP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529828; c=relaxed/simple;
	bh=iM0bLDr0wjEfompnEdKiLWQmyHdzCRZYdk03xCWbjnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1a74iHItsyRmXwVu4ow12V6H5gXTH+EeU+MhalvgcEWm+Lp0opKTX7jZLVcXME4YUWG8HK1t3e81JFdvZTFRLqrxFS67zF4D4E0n5VeiVB7T/KXe+vfkIK62TcbFenERFZP8njy9/Ol33BdW0N5TgFYSHZWtn/tdSw3NUz0cNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xC6TWPEo; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752529815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhuocBLqA3gzBc4uu2GGr+rR7kPr/v7HEImY11Vzz0E=;
	b=xC6TWPEoJvNnTQcLv2Qk9thEImxEEpeJqn7+RCxAi0mkv9//Ag4ZtRq8vJz0UUdBGuwd7v
	ya6xCN5GomrCWpqJwJ/ACd97T4mTIq7jDgepOUQaraIQkLKYwBto6SRCXYlZyUKg7r6row
	hkfLasBNcNLb2hVSMr/blgIx8JVP0oo=
Date: Tue, 15 Jul 2025 05:50:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/7/15 03:52, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 12:10 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>                          } else {
>> -                               addr = kallsyms_lookup_name(tname);
>> +                               ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>>                          }
> Not sure why your benchmarking doesn't show the difference,
> but above is a big regression.
> kallsyms_lookup_name() is a binary search whereas your
> bpf_lookup_attach_addr() is linear.
> You should see a massive degradation in multi-kprobe attach speeds.


Hi, Alexei. Like I said above, the benchmarking does have
a difference for the symbol in the modules, which makes
the attachment time increased from 0.135543s to 0.176904s
for 8631 symbols. As the symbols in the modules
is not plentiful, which makes the overhead slight(or not?).

But for the symbol in vmlinux, bpf_lookup_attach_addr() will
call kallsyms_on_each_match_symbol(), which is also
a binary search, so the benchmarking has no difference,
which makes sense.

I thought we don't need this patch after the pahole fixes this
problem. Should I send a V4?

Thanks!
Menglong Dong


>
> --
> pw-bot: cr
>

