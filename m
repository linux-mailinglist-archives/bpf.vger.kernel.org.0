Return-Path: <bpf+bounces-71485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD0BF4356
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 02:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF5F18C4769
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86073246762;
	Tue, 21 Oct 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="awhjyFMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwQHcems"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEB20DD75
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008060; cv=none; b=DLBtd7NnJQYKNzrOkH5QUIzo1ASyE4DM28t0Hw2PYBV2Gg004VrK97ZpFV4EXxtANEu4j0nTcE0Rsd7lCCEg/6il4itdYbqu3Xcv9PKE6kXwyia0ATkO5akJnm7GfbyFS7sj01ww9aR2yW7cRsFaaJh+sT4cQGk52xvct/J4k5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008060; c=relaxed/simple;
	bh=EYkgt6B6y0OLHQt10mzU+cJYTfszrPGIHQQ1RT4RIQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIK5KkEDF5y3PRRo6vnK6/BjLEcfNhYzOalxXcBkaHWv+bqqZmq3NEWISeTHXe2Yr6TZLXAi1lefNSnsSdrkGVFItjACrCroHIpH9JBVgfeQimPxmqlHACArUq1Sk/yYxKS2NiEeriGI343nE4qTTZJggCird5nV52QqzdC7CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=awhjyFMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwQHcems; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 394641D00143;
	Mon, 20 Oct 2025 20:54:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Oct 2025 20:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761008056;
	 x=1761094456; bh=eJkYQ9/Nh/vMkb12XPWGOuILBCfHhVe8I7QJQCo4FrI=; b=
	awhjyFMnwfTd5jcuSXlZ8sZXpmZW785JY50n18rXirlZ6ABUQXTYBnwrxvi5q+jP
	/YxxO3afdcwEoK0TGf8Xk0qVj5Lnw1CDHeiEX/jA98L/+GzTPOUdhIfaiil9pRcu
	BCNcl6R/qlMvJriFJ8XuW6XCa0H3WhIh5dnKNryDBLFBP87X9rvpWXEgJHfQlzPK
	EP7wAu1kQAexo8v35zB+OGq38g587J7kSuESxC0L74rxwiPaxy2INgojiL3zRwxe
	O6L92xqLkOJRag4UcL+aWy4ayjbR255TgQyqDw6Sy7NEHIcpVZk0kMz+g0ZBAivB
	hbLKhNoLNv8QwF2g0oAFpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761008056; x=
	1761094456; bh=eJkYQ9/Nh/vMkb12XPWGOuILBCfHhVe8I7QJQCo4FrI=; b=D
	wQHcemsA7NeEbn7CCg3FR8vSyIPSVYbEDtsAmZXT5VXCaM6xqOFOrrnzOqmMU0AX
	wsgULBPx8MeAgvfZ3AdTu47dzx08dftD0UhPiT47OwKZPrz/KGooWKmchuqsotTQ
	DSD/3i390N6KNXtlWZt7XLnmwqzr80WeWohFYaD1nrfxwsAGLMHjnn3AhbFxEBaI
	cRZS0aqVuTSIrMuv3LmRvJtd/u8phH6pmHE0EH2rO/4HoZQQT1tqdqVxtkWgcidA
	DX8cS+i9+g1UnYOlQMzry5HfnSNeCRzrKhkmjC/hjor2AZfH41r3ax0VzUub7ePs
	bQM0iuwMttkPmrYdbnk9g==
X-ME-Sender: <xms:ttn2aH7RV8nh3SYRDqtT1lPQ-_kIZ_AyqD1WoqykGYMhiu5zOZpF4g>
    <xme:ttn2aG6ErHm45hojI1dc9SJ6TkvpMDspi1l0w2KgjJwxMl5IMkGYaIG9NO2LThZGs
    YJ86ytdhL_w25pk9Rl7e56UbmYjXtGmH8MmpSAbWqYAiZOLkIfFips>
X-ME-Received: <xmr:ttn2aFHFFW-1VJ0jT2qzlEXQoDoH_Zxg1m_l_Bn-zZOcBvURh9HcP69_EgLCJP705F-LR3B2-3FDS-QkgmMSoT46>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    fhhfegueejkeefhffffeetieejffevtedutefhhfejjeegleeuieejfffggedunecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgt
    phhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvrh
    hitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhv
    rdhnvghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomh
    dprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepsghpfhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ttn2aGXH7-AqYXsJDwlVtam_JS0xW0iXjXGwm1cSvjgfFx3PVWSQqA>
    <xmx:ttn2aJX0Gx0OfCH68cj9UvFp9r96TgPYZJDLjl4Zsl0H3rI823hFJQ>
    <xmx:ttn2aMLhtGRfXVZljAS2egSsAVNdTJbNLO9vZEQoVTI-KzfhAoMq5Q>
    <xmx:ttn2aJBAzkVW9caXacgHEA_KHWBYBTnwVozBxkRH1rjFmzM7hD50wg>
    <xmx:uNn2aPF7Br6pMBqzUkOPcf9qO94nx0tRzZk43MNoWuNF0thoMWZ2GCn8>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 20:54:13 -0400 (EDT)
Message-ID: <086bb120-22eb-43ff-a486-14e8eeb7dd80@maowtm.org>
Date: Tue, 21 Oct 2025 01:54:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
To: Song Liu <song@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 bpf <bpf@vger.kernel.org>
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
 <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
 <aPaqZpDtc_Thi6Pz@codewreck.org>
 <CAHzjS_uEhozUU-g62AkTfSMW58FphVO8udz8qsGzE33jqVpY+g@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAHzjS_uEhozUU-g62AkTfSMW58FphVO8udz8qsGzE33jqVpY+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/20/25 22:52, Song Liu wrote:
> Hi Dominique,
> 
> On Mon, Oct 20, 2025 at 2:32 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
>>
>> Song Liu wrote on Mon, Oct 20, 2025 at 12:40:23PM -0700:
>>> I am running qemu 9.2.0 and bpftrace v0.24.0. I don't think anything is
>>> very special here.
>>
>> I don't reproduce either (qemu 9.2.4 and bpftrace v0.24.1, I even went
>> and installed vmtest to make sure), trying both my branch and a pristine
>> v6.18-rc2 kernel -- what's the exact commit you're testing and could you
>> attach your .config ?
> 
> Attached, please find the config file.
> 
> I tried to debug this, and found that the issue disappears when I remove
> v9fs_lookup_revalidate from v9fs_dentry_operations. But I couldn't figure
> out why d_revalidate() is causing such an issue.

I've compiled qemu 9.2.0 and download the binary build of bpftrace v0.24.0
from GitHub [1], and compiled kernel with your config, but unfortunately I
still can't reproduce it...

I do now get this message sometimes (probably unrelated?):
bpftrace (148) used greatest stack depth: 11624 bytes left

I don't really know how to proceed right now but I will have it run in a
loop and see if I can hit it by chance.

If you can reproduce it frequently and can debug exactly what is returning
-EIO in v9fs_lookup_revalidate that would probably be very helpful, or if
you can enable 9p debug outputs and see what's happening around the time
of error (CONFIG_NET_9P_DEBUG=y and also debug=5 mount options - I'm not
sure how to get vmtest to use a custom mount option but if it's
reproducible in plain QEMU that's also an option) that might also be
informative I think?  I'm happy to take a deeper look (although I'm of
course less of an expert than Dominique so hopefully he can also give some
opinion).

I'm also curious if this can happen with just a usual `stat` or other
operations (not necessarily caused by dentry revalidation, and thus not
necessarily to do with my patch)

[1]: https://github.com/bpftrace/bpftrace/releases/tag/v0.24.0

> 
> Thanks,
> Song


