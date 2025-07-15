Return-Path: <bpf+bounces-63303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D7B0540A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5423B176E5B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FD26E70B;
	Tue, 15 Jul 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nWF33BhM"
X-Original-To: bpf@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332172615;
	Tue, 15 Jul 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566704; cv=none; b=RtEXglRVSE/Rga9qcFlIXxl7kTUkLnFXeLbc3KEXako2i+PdTbe8RpdgLrIzBfBNQcXr5W1wxXqAuAAjNQ8GovmYrNU/OSOpyquMdLCg6sFUL4/gezBJISHiKGKRlA9khzRlDT5yufSJJPaDscGvwBGADr6yYgsk0Ta990TtgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566704; c=relaxed/simple;
	bh=3FczV4+V77qB1tJUH4mWYXvQ+RrjfmHzqEimI9fCMsI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=qydsflRONVP3gTvExl8ysDO/mBgyFvJl1gqeI8r6f8cPSh8z28lebD11pDypiBI8g3m+hsefKSx7hu1d4+5dQPa98J4q9zlOrEunH3aQACs8WBA9JXBueE+5s5ZJ6SZW/8a4bRGh9pfI1E/6o9ptwBrpxe1U6inb+4BlRb68u/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nWF33BhM; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C1BF4421D;
	Tue, 15 Jul 2025 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752566700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FczV4+V77qB1tJUH4mWYXvQ+RrjfmHzqEimI9fCMsI=;
	b=nWF33BhMwPcK+Y4o3NquqExF/41owAYOE1SrNBv6ipTnKM7/ELoPgl3lYWJhlZf9qojjWE
	ei3s+U/AsAmeqaucwjEimI3OMGC6VttaX71QgettBpKBSozhf3dH3P4NIJyExdHt3TK/Or
	xltnyV4kPtX9TZUB37Maz8PSaHqg2GqGxHDdptmXOuxRWhDsktF+JaPDNCG/D0fsX1NNdd
	qHdBrBqclbTEG0XmmSU+rwXRG0/ewvnM5kSMubbnNxTIE35tMe+CpbpzoZs3dq0Fs8njuD
	kkFCN5xVCtd+MbvDe7ZAqZMhUJZK19DPwtoueWmGILtLC1meMt+7ac7Iwz0fVw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:04:59 +0200
Message-Id: <DBCH1MVGI5EV.JODF0DE5B063@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped
 functions due to uncertain arg location
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@fb.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com> <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com> <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com> <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev> <680c6507-af5f-41be-8823-c8c9dfceaf5f@oracle.com>
In-Reply-To: <680c6507-af5f-41be-8823-c8c9dfceaf5f@oracle.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvefofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueevvdehkeduffefffejiedtteegkeehteehudeufeekudeitdekhfeihfehtdffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesv
 hhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm

On Wed Jul 9, 2025 at 6:21 PM CEST, Alan Maguire wrote:
> On 07/07/2025 20:36, Ihor Solodrai wrote:
>> On 7/7/25 7:14 AM, Alexis Lothor=C3=83=C2=A9 wrote:
>>> On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
>>> wrote:

[...]

>> I think a proper fix for this is differentiating two variants of
>> LSK__STOP_LOADING: stop because of an error, and stop because there is
>> nothing else to do. That would require a bit of refactoring.
>>=20
>> Alan, Arnaldo, what do you think?
>>
>
> Would it suffice to treat LSK__STOP_LOADING as an error in the BTF
> encoding case, and not otherwise? That's a bit of hack; ideally I
> suppose we'd introduce LSK__ABORT (like DWARF_CB_ABORT) and use it for
> all the failure modes, reserving LSK__STOP_LOADING for cases where we
> are done processing rather than we met an error.

Ihor, Alan, is anyone one of you planning to work on it ? If not, do you
want me take a look and implement one of the solution suggested above ? I
guess it's best to aim for Alan's second suggestion first (introducing a
new LSK enum to represent a failure), otherwise the simpler solution
distinguishing reasons for LSK__STOP_LOADING.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


