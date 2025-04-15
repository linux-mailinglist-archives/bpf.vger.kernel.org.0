Return-Path: <bpf+bounces-55994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C814A8A5C9
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529B21885025
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57122DFA58;
	Tue, 15 Apr 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PIMeBFBv"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B11B0F23;
	Tue, 15 Apr 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738680; cv=none; b=KSchpq/Z/cHDuJGKBAIk8HbdO34iwLJw2/z6wDqLHC1Wu3Zd3xLrCLNsp53OsDXo5wk7mgQZpOlSCM0PjuKRHQ7yQMZfGiqzb7dCN2SFVgiI1xHw08KVgDwH2WZTa7NnxPTrzuzPYqq31TQU04jG/8Sc6qIIULvAfr8kXMwnKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738680; c=relaxed/simple;
	bh=a7nkIDw2sGWmgsPXcXHwTsn7gVWA1RUyTzV3ZRc3sbM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fdXEyyjfcCtw5BjWwfYlyfE8CkamdmjgfQX8bKw382TyUc8NeblCLA4w/UfJsACQ28DEZBPtn37+YCex/eO564yFs5dRdBlAvBaZ/IdDdNcpWKi/cbL72kh9wxPo/GJ8WpmAXmgUSlyKmOZr4dYemWLgxqCT7VcAKzHQ9B2sem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PIMeBFBv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744738675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7nkIDw2sGWmgsPXcXHwTsn7gVWA1RUyTzV3ZRc3sbM=;
	b=PIMeBFBvruuq6R536asjJALCz0DhOcAGvJOrSiScQKChlcJ9qirHDtyXRkXVpRUAYdc6Mj
	rEFq8rXA22aRh2FCPkuExWg7+cHfEDJlHt+g+fFMBHiSeyRpsJtC92isMlek2SdQ5EoD4v
	fzdejm6kasEe/l2+0I8ULpHQTINUkCs=
Date: Tue, 15 Apr 2025 17:37:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <b787119e15a218cc10a850f2c774fd328d53ef55@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard" <eddyz87@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Network Development" <netdev@vger.kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Mykola Lysenko" <mykolal@fb.com>, "Kernel Team" <kernel-team@meta.com>
In-Reply-To: <CAADnVQ+5_mqEGnEs-RwBwh7+v2aeCotrbxKRC2qrzoo2hz_1Hw@mail.gmail.com>
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
 <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev>
 <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
 <CAADnVQ+5_mqEGnEs-RwBwh7+v2aeCotrbxKRC2qrzoo2hz_1Hw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 4/15/25 10:05 AM, Alexei Starovoitov wrote:
> On Tue, Apr 15, 2025 at 10:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
>>
>> On 4/15/25 9:53 AM, Jiayuan Chen wrote:
>>> April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev> wr=
ote:
>>>>
>>>> "sockmap_ktls disconnect_after_delete" test has been failing on BPF =
CI
>>>> after recent merges from netdev:
>>>> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
>>>> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
>>>> It happens because disconnect has been disabled for TLS [1], and it
>>>> renders the test case invalid. Remove it from the suite.
>>>> [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@ker=
nel.org/
>>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>
>>> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>
>>> The original selftest patch used disconnect to re-produce the endless
>>> loop caused by tcp_bpf_unhash, which has already been removed.
>>>
>>> I hope this doesn't conflict with bpf-next...
>>
>> I just tried applying to bpf-next, and it does indeed have a
>> conflict... Although kdiff3 merged it automatically.
>>
>> What's the right way to resolve this? Send for bpf-next?
>
> What commit in bpf-next does it conflict with ?
>
> In general, avoiding merge conflicts is preferred.

https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?id=3D05ebde1bcb50a71cd56d8edd3008f53a781146e9
https://lore.kernel.org/bpf/20250219052015.274405-1-jiayuan.chen@linux.de=
v/

It adds tests in the same file. The code to delete simply moved.

I think we can avoid conflict by applying 05ebde1bcb50 to bpf first,
if that's an option (it might depend on other changes, idk).
Then the version of the patch for bpf-next would apply to both trees.

If not, then apply only to bpf-next, and disable the test on CI?

