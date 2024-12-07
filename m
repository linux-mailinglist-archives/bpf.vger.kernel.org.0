Return-Path: <bpf+bounces-46363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BF9E82B3
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 00:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11988188412A
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244C15D5B7;
	Sat,  7 Dec 2024 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="T5xvrChB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kliv8WYM"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7906335C0;
	Sat,  7 Dec 2024 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733613359; cv=none; b=jTbaYIC6MdxtZOx6HnTQeMYEFac/ipbCq0CCkV+mHeSPLbdmpR3Rhim2GOn5HOhN+sKOBbLu/DELJOWNipZLpQaqCpp91klg5alJLrvvJrB1GuMEPZDDxPs6X/4nr7dtBXnUw8o/6IiWb4Plvgo1BrsBYuyUtN9aJbp52riuDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733613359; c=relaxed/simple;
	bh=93QMHm37WkezH+cncGqIf+PWHiEaJmdlvWMX66Qblvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nf44jD9hi7xKghetyy108PE/81X/wwlXx8sR+ujzOGPSe2cQp3Z4eBhtbDWSlJhIAGzG5rXli6zCVDi+E07tmqWRwoNkIXqyleXoJ1YmY44pejhLi+YUne5hRT+P78cucVNtXNe0Nid2LQfibBzGEBwaZCQXR6YDwOW7+BotDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=T5xvrChB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kliv8WYM; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id BCB1D2005E2;
	Sat,  7 Dec 2024 18:15:55 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Sat, 07 Dec 2024 18:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733613355;
	 x=1733620555; bh=GZeLGUQSlgrpcYlHaZgXjTJDLDoQgyOhF9e5lkHQDYk=; b=
	T5xvrChBb8PG/pBryugusd1QZjNWlywuoPFitoZRdE7IG7+CqyBVSNjUvstodnp6
	HsHS5ZpjOuYtEsh0sag7SO6z8Y1oF8voYBfvL67lmOn3FuyJJPuVk7DFDf5zRbSz
	qCaVVid9mNg/aRYid9AIIpFE1VQH16ydS4+joNcUNwjMThE89aDvVB+9j8DygGMa
	rT6UZf8Vrx4IapRpzXdcQ2oicmEybLy94VRvstULnNdvG7YlvROMH8NyCUgmo3e1
	JDpCLQ0sPUDhuXnVfv9SdiD1Tqy5Ogo1Xh433FGI6RUjwdduBcUVor2JREPAqcTD
	k/hR22apYeqMl0jhLvDz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733613355; x=
	1733620555; bh=GZeLGUQSlgrpcYlHaZgXjTJDLDoQgyOhF9e5lkHQDYk=; b=k
	liv8WYMKZbUh1FY0u7GKSx0yGyzaJOgoHmq29QTU4rb+gbOhdWnv970Wx0xPmvU/
	DwMLp5Gq+qfvRG9K//90HtTIlHlxvYfTyJXQypZH9U37vo0OdMpoh0Ful0DohXND
	MjUUYoZzr9Yvoj0cyK5OtfI2tQaJe0OVv6CtDrNmnNfOGeAoUoYcwfiUHzLdQ3mz
	61KuBTFBgBTkBXIzOEYTTlAOZAdftVBsEgsiS6GacJ7ZIJ9zSZGTrP5DIwyiOu+Z
	EcKoy0x6WoF0sQ4YS0XRW1FuYIXlrIeSqX6qqlchldsY8+wTkmuHqP0Yp01L8skR
	I/p5/N4Y70iy7vYx6bYgg==
X-ME-Sender: <xms:KtdUZ3Wd2cHW8TuX261JnGKHEUhLcHR8GcDuMgoyr92z5PDJy4dAkw>
    <xme:KtdUZ_lE8fJKOT_7iPFXWNVujSwlopKmqbn77akYpEBr_k7cQNivBR_MO2lrkH2iJ
    3peJWzHgEUtMbbgpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhm
    vgdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhl
    uhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsg
    hogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:KtdUZzZsnq93LWP5NqQhUkaW8BmBQXAYNSxHqUFVRSvxGapljDfVqw>
    <xmx:KtdUZyUDWPYx4RXfj7T6VKPWecr3BY5Llb8w0IGWwjmkPeG-FCYDuA>
    <xmx:KtdUZxlZrC7StRBQaRpnDzcBEuAelKXuXEqF662I2giG2xc8xHPzsQ>
    <xmx:KtdUZ_cBYQmWIwLrOkAXc9VbYVx-KfDX6VaA_qS3cR6FgkaspenNOA>
    <xmx:K9dUZ8pPW0TdUiazAXyHbJjUt6cvK7hcoYAUGg3lS3pt_quB8f0m_Y_a>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D5F9F18A0068; Sat,  7 Dec 2024 18:15:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 15:15:34 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, qmo@kernel.org,
 "John Fastabend" <john.fastabend@gmail.com>,
 "David Miller" <davem@davemloft.net>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "Antony Antony" <antony@phenome.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Message-Id: <7a5067a7-2a76-45d3-8995-87eff3e5996d@app.fastmail.com>
In-Reply-To: <8da87bf2-0084-4a47-b138-5dc380e7435e@linux.dev>
References: 
 <8ae2c1261be36f7594a7ba0ac2d1e0eeb10b457d.1733527691.git.dxu@dxuuu.xyz>
 <8da87bf2-0084-4a47-b138-5dc380e7435e@linux.dev>
Subject: Re: [PATCH bpf-next] bpftool: btf: Support dumping a single type from file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 6, 2024, at 5:50 PM, Martin KaFai Lau wrote:
> On 12/6/24 3:29 PM, Daniel Xu wrote:
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index d005e4fd6128..668ff0d10469 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -953,6 +953,7 @@ static int do_dump(int argc, char **argv)
>>   		NEXT_ARG();
>>   	} else if (is_prefix(src, "file")) {
>>   		const char sysfs_prefix[] = "/sys/kernel/btf/";
>> +		char *end;
>>   
>>   		if (!base_btf &&
>>   		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
>> @@ -967,6 +968,17 @@ static int do_dump(int argc, char **argv)
>>   			goto done;
>>   		}
>>   		NEXT_ARG();
>> +
>> +		if (argc && is_prefix(*argv, "root_id")) {
>> +			NEXT_ARG();
>> +			root_type_ids[root_type_cnt++] = strtoul(*argv, &end, 0);
>
> I only looked at the do_dump(). Other existing root_type_ids are from 
> the kernel 
> map_get_info and they should be valid. I haven't looked at the 
> dump_btf_*, so 
> ask a lazy question, is an invalid root_id handled properly?
>
> Others lgtm.

Good question. Passing an invalid btf ID results in half the
boilerplate being printed to terminal before an early exit and
an unclean return code.

Probably not be the best way to error. I'll send v2 with an
earlier error check.

Thanks,
Daniel

