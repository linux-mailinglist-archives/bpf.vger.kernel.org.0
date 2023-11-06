Return-Path: <bpf+bounces-14279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CC7E1B95
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DF0B20D4D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD304F9ED;
	Mon,  6 Nov 2023 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="oj2lESHx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HF2h6FGm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15FEED7
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:01:17 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17660C0
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:01:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6FE53320092A;
	Mon,  6 Nov 2023 03:01:11 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 06 Nov 2023 03:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699257670; x=1699344070; bh=cA
	3BeK5xQcuzeHOAtzKugVzM8N5hqvgYVLMGrqG4+rc=; b=oj2lESHxOdtsOWBJAB
	3o/et8kTjRuomzr/j4JRzbGFYhV53ZpVupWFcyEwLOeWVycp4SHBnKrSKZGgU8Om
	Uie+BXuj8mUCscUaalM/TcwRvwQpFfbEHVo4dxVoUwxrmzoU6odoQwt/i93cy2zF
	75mOzxM4/LDXTbH9/6UsRmE+DCakKladAuITfcldvuBlITjqJKBYIHGVoRFURJbh
	GJtH0OA57wlS/Fl0ubcIEljGKJ971pTPRrDP24rgMi+m9pmPUMd4KYzO8QrHCyCZ
	Pwd6ecl8vAR4WbGO4jvDlVgptM38BBW2zzt1W7GFZsyTK8zSYnbAyt1j44yALNQj
	Hxyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699257670; x=1699344070; bh=cA3BeK5xQcuze
	HOAtzKugVzM8N5hqvgYVLMGrqG4+rc=; b=HF2h6FGma6q8UKlAnFmKtgkdgcupX
	Ow1bEb8hIRpd8yWYc2Kwt839vi4sor/i407Mr3AT/Ahbv6cXFqltsto7m/BSjVVU
	wRoSrpZSE5YekIFCyH6YFxCpIyDJRnUoo97e/ngiG+gAqWxJodWX3Dbz2um/SF6+
	OBc66O+WECOiSPUkmGe2j3ciwqd3V6U7aZN7/0oFYYtySNHgQ/7UFnnu17VsBTuM
	kvrmsw1TYX2sYiwd1QtNvVE7ueXqhGu0AQKe+mjRf2mvCGePGWgcULqehkyoHeTE
	3aF70uF0FJAK4wk1fT8+Qy3IFwTrJOnsmvatRX2j2X57SkjVL9rAZy8dw==
X-ME-Sender: <xms:Rp1IZWx4-41dEVHzTiU2DbCzcrqVGVZJAcCO7Bi9e884fZSA8a878A>
    <xme:Rp1IZSRqyVXlBOHM7S2fxManJBvzyR3rvjq7lj_rp9OaWctI7V4xLnAypJr2ivTwt
    Z3yBQwLTlXeI0SRMU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddufedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegu
    rghvihgusehrvggruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepfeelgeeuhe
    eihfeuleefleehtdektdeihffguddvheefiefhveelhedvvdfhueeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiugesrhgvrggurg
    hhvggrugdrvghu
X-ME-Proxy: <xmx:Rp1IZYXhroRR3rHRffMrzUElqjcyByt4j5QahvO7dNdDKYHGM_JLSw>
    <xmx:Rp1IZcjvkh5Vp-XmrlxrgGfyAt7pbIHUzE297HmP-bvlVdFHRSyVBQ>
    <xmx:Rp1IZYCMocAFhmkhSC8y_TDNv2K1-U7ip2Yc6b6oHDtnHT5-dlhGjg>
    <xmx:Rp1IZU6JuJZcCuj4FHVAVsMidlBd7HkMhqK4E7Q4DVrvBfENVmdW2A>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 29B131700089; Mon,  6 Nov 2023 03:01:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3da05324-9ab2-4e55-8856-4c2d01ff1337@app.fastmail.com>
In-Reply-To: <ZUf8Ld8pQu46dyTi@der-flo.net>
References: <20231105085801.3742-1-dev@der-flo.net>
 <1d237338-6341-45be-9f0e-f1f1a9bdc153@app.fastmail.com>
 <ZUf8Ld8pQu46dyTi@der-flo.net>
Date: Mon, 06 Nov 2023 09:00:45 +0100
From: "David Rheinsberg" <david@readahead.eu>
To: "Florian Lehner" <dev@der-flo.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 daniel@zonque.org
Subject: Re: [PATCH bpf-next] bpf, lpm: fix check prefixlen before walking trie
Content-Type: text/plain

Hi

On Sun, Nov 5, 2023, at 9:33 PM, Florian Lehner wrote:
> On Sun, Nov 05, 2023 at 08:08:43PM +0100, David Rheinsberg wrote:
>> On Sun, Nov 5, 2023, at 9:58 AM, Florian Lehner wrote:
>> > When looking up an element in LPM trie, the condition 'matchlen ==
>> > trie->max_prefixlen' will never return true, if key->prefixlen is larger
>> > than trie->max_prefixlen. Consequently all elements in the LPM trie will
>> > be visited and no element is returned in the end.
>> 
>> Am I understanding you right that this is an optimization to avoid walking the entire trie? Because the way I read your commit-message I assume the output has always been NULL? Or am I missing something.
>> 
>> Do you have a specific use-case where such lookups are common? Can you explain why it is important to optimize this case? Because you now add a condition for every lookup just to optimize for the lookup-miss of a special case. I don't think I understand your reasoning here, but I might be missing some context.
>
> Your understanding is correct. The return value currently and with this patch is
> in both cases the same for the case where key->prefixlen > trie->max_prefixlen.

Thanks for clarifying! I think using "fix" to describe the patch is misleading and confused me. Similarly, your "Fixes:" tag implies you repaired something that was broken.

> The optimization is to avoid the locking mechanism, walking the trie and
> checking its elements. It might not be the most common use case, so I see your
> point.

Can you elaborate on how you encountered this? Do you have an actual use-case where such lookups better be fast? Is it worth it slowing down every other lookup just to make this one faster?

The patch looks good, but I also don't see the benefit. I am not against it, though, if you insist you need it.

Thanks
David

