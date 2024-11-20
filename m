Return-Path: <bpf+bounces-45279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265659D4021
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C8B387F3
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31414F9E7;
	Wed, 20 Nov 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jr9LaOxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwSIPPLe"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC213BAEE;
	Wed, 20 Nov 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118130; cv=none; b=JgGUI1fEJ6hUUEj2FuQgwM1fQUzvP8av/JPgCg4eWA0tFy0JRW3zN8KeZycKNdmgfkqz5mA5PIIMg03M1vmrd/m1NnoBZwifOcvdxErV9oqUtS0srFexu7Duy+o3ezU2I8F46ADl5jg+Qmr0bHZi/unLlBbVkD3PzWJdRiq2Z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118130; c=relaxed/simple;
	bh=00WpXFIMxEyV2iKHvNFZB4Op5fXY92mlcVDIdzmXXUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uBccIJm6Y8kJcR6SyCEcT8R9qGEs+GueW8AZZ/BOLFZFJBT4uivOqDP5KKMC6udSbTvvu67e0PebxmFKhz2MGcpJQCWi91Zz8ADCTHTR0dROkZed9OEXs6k7UhOwlRoUdbPkT43ODM6yzUCVy/2cLGJ7eDoy0hKVOefCNuW4lPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jr9LaOxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwSIPPLe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E64D92540111;
	Wed, 20 Nov 2024 10:55:26 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 10:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732118126;
	 x=1732204526; bh=00WpXFIMxEyV2iKHvNFZB4Op5fXY92mlcVDIdzmXXUs=; b=
	jr9LaOxA5vlDDEzLGjvcCIyFUhYn5q/5Chcxk3YLTZeJ35MJrHEK58P3lWA727jp
	fZa1GvH//VgM7pr8n4Ucl1c0iFMaLBDlUkZNl50KxrDRMnvgELQUIyJ6yLwzfgzD
	t5VzS+l/ARVEabQYW0q2buVyeyTa1PtmacMJ//hHI/ebCk/6iMJPFJuYR78N3vuD
	h29KzMkzaC4qtW2kpyPq4FgyAvWELB2G7gdc45mJtjrcBSrnSD2KtkvQnk9ZT4y/
	j1bEsPk2T99HLl5gX+WH6Ae/hCp9WeyHQIGoYzYqN/YZ6TAr7Bo4v/pRIDd+JFVK
	9fH8qBovQwFygbrFgxIaUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732118126; x=
	1732204526; bh=00WpXFIMxEyV2iKHvNFZB4Op5fXY92mlcVDIdzmXXUs=; b=M
	wSIPPLeXyHPu/cnsvcAv5vxk7SkbhtWjM1FCuz7G5CYMqBEkEMpHBlTK4fJ9V7ID
	0ayzIeyQwAXgNYPQOIJ5ymRg9z2T9E1Gs6PLRYs+ky77Kt5wMPye6cQkoVPYRo9A
	6h8j2FDSbON/aDLoAhcFO6vZuJNHxzTqVX5msH3Zc2v99PWd8rC4I3OT5nsUUWlD
	LAiL6cLJ7nj+D+vCkv4JU1JhYPj4CQijMvi/ovr9c5yR3Mst/vZ1oKVq9h5TILvH
	hYblwscKvZn6ydKShXJXaGZ0+2tEpbVa/pdmU0thVEm4GSdXPUtjomWbgh1RVQQp
	C+EhL2Zcuvho4lVEPOQZA==
X-ME-Sender: <xms:bgY-Z6HspSshKaOnkxvwNhLiYc2dGb6Tg2ZDneEj3aAkB4gIlZHc_A>
    <xme:bgY-Z7WCoLIyCM34HlsNquutAtLkoYM9ecmYzqh0joPYfmO9kntnR3uuQF8Lj0RTb
    exyse4Q8rgGiCCUxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfelieetgfevffefudefhfff
    tdeiteegteeggeehueefueefkefgfeeuffevhfffnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghird
    hsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghl
    sehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:bgY-Z0KdArCNM1k7TJoGYfbBWpqDymIh-rF0jEpIwVRCD3YVKl_bgw>
    <xmx:bgY-Z0GtIcSwVOdD9anoyhTnbZasE-JK8nsDlfs7EOHD7ICeB0b6pQ>
    <xmx:bgY-ZwXvLhbDGVjraFipbcVek-tamS41bC5kYAWnUDVuwyKkSc3hWw>
    <xmx:bgY-Z3PfPMyHAh74gzw7FW5xDqgdxMXw9ZopRInzc0a8lSGxLcMdyw>
    <xmx:bgY-Z-wouH4_dYoaXaDcff3imo91pmM2IYs_JgKvHr_oEn3spmoU-_zA>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2236018A0068; Wed, 20 Nov 2024 10:55:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 07:55:03 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Network Development" <netdev@vger.kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>
Message-Id: <7ec1a922-30c5-4899-a23f-11e3ef9d6fef@app.fastmail.com>
In-Reply-To: 
 <CAADnVQ+T2nSCA8Tcddh8eD27CnvD1E3vPK0zutDt8Boz7MURQA@mail.gmail.com>
References: <cover.1692748902.git.dxu@dxuuu.xyz>
 <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
 <CAADnVQ+T2nSCA8Tcddh8eD27CnvD1E3vPK0zutDt8Boz7MURQA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Nov 16, 2024, at 2:17 PM, Alexei Starovoitov wrote:
> On Tue, Oct 29, 2024 at 11:36=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wro=
te:
>>
>> Hey Daniel,
>>
>> On Wed, Aug 23, 2023, at 9:08 AM, Daniel Xu wrote:
>> > This patchset changes the behavior of TC and XDP hooks during attac=
hment
>> > such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an ext=
ra
>> > uref taken.
>> >
>> > The goal behind this change is to try and prevent confusion for the
>> > majority of use cases. The current behavior where when the last ure=
f is
>> > dropped the prog array map is emptied is quite confusing. Confusing
>> > enough for there to be multiple references to it in ebpf-go [0][1].
>> >
>> > Completely solving the problem is difficult. As stated in c9da161c6=
517
>> > ("bpf: fix clearing on persistent program array maps"), it is
>> > difficult-to-impossible to walk the full dependency graph b/c it is=
 too
>> > dynamic.
>> >
>> > However in practice, I've found that all progs in a tailcall chain
>> > share the same prog array map. Knowing that, if we take a uref on a=
ny
>> > used prog array map when the program is attached, we can simplify t=
he
>> > majority use case and make it more ergonomic.
>
> Are you proposing to inc map uref when prog is attached?
>
> But that re-adds the circular dependency that uref concept is solving.
> When prog is inserted into prog array prog refcnt is incremented.
> So if prog also incremented uref. The user space can exit
> but prog array and progs will stay there though nothing is using them.
> I guess I'm missing the idea.

IIRC the old-style tc/xdp attachment is the one incrementing the uref. O=
nce
whatever program there is detached the uref is dropped. So I don't think
any circular refs can happen unless a prog can somehow prevent its own
detachment.

Could be mis-remembering though.

Thanks,
Daniel

