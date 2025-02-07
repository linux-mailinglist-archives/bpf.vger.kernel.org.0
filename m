Return-Path: <bpf+bounces-50775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F411A2C68B
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0923A593C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4E1EB186;
	Fri,  7 Feb 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndfpILjW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3C238D29;
	Fri,  7 Feb 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940920; cv=none; b=noyQmFsBku3TYRLulIx+2m0kJHq9R/4qum57va4EpCWoKX6b8vOtk6YKdCjDNakPLFhb+F19KVfBHzMOYqqgzBrhQUB4n/DGNU0kTNqN99aK/HkTV2uOdemvofmg5myQTBRcIuBAQDlH8EoSRkwEtTGdJ5v8kmgvIs/kop1NnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940920; c=relaxed/simple;
	bh=BJL+WE5GSyGUbJ1NCpFYJEzEiOrG8nXkwRKjcCY7Qkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsSorRS2w2sefSlqXz4atbDEd7KPZZJ8xIKFgG6Xi/2LOomTfYZsHATq7bQGLTpx3WUuOU1wUjrv4Fz5U6HHbW/IYlW2GFLMqEa4i1AsyExbGlxwLIe8UxXmHDkAL4KbXGPxaO6f7OIufZ/lqMyg8y82z14tsIb8vUjHCvLjg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndfpILjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB86C4CED1;
	Fri,  7 Feb 2025 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738940920;
	bh=BJL+WE5GSyGUbJ1NCpFYJEzEiOrG8nXkwRKjcCY7Qkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ndfpILjWDgTHeUh4HLDDHDenxdPayZEM9oL2je5YpGMEFpuyMQeHLN8b26Rdd2KzY
	 v3iLQStFWgJDSzIXrLgj8BLPC5Uzv6llzk1/NADCmbySPRXYkxlH6kam3wfRwl0jU7
	 uFnwMkg7mEV2Pcv9tbg79nYCnt5kO/jXQdQcqMwmsKeD7n/VgU+ToYQPLH2c5OzQcn
	 k5/s67nM0WFBrRkMg3KOBGMYopBgsoDAhY7AjK5EH+KjcJfNg3cS/vayOdlx0ij7qL
	 CCaPQj9BM8Gu6F/rju99DLzLG1HF77MvH3OwSywmX0AyDXG7tnvGE6TQiieMiZ9/2b
	 tIHhjkl9HH4NA==
Message-ID: <502d76e9-6933-41ca-9b74-23e339f6244c@kernel.org>
Date: Fri, 7 Feb 2025 15:08:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/1] Using the right format specifiers for
 bpftool
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20250207123706.727928-1-mrpre@163.com>
 <88cb50b1-a0f2-4763-a340-e74bff9f9f8b@kernel.org>
 <7gpn4zamubd3j6d3wiywpfftbu7vxawrlwzjwse3lbv3ovejlu@2vfemcisx5pi>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <7gpn4zamubd3j6d3wiywpfftbu7vxawrlwzjwse3lbv3ovejlu@2vfemcisx5pi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-07 22:27 UTC+0800 ~ Jiayuan Chen <mrpre@163.com>
> On Fri, Feb 07, 2025 at 01:22:19PM +0000, Quentin Monnet wrote:
>> On 07/02/2025 12:37, Jiayuan Chen wrote:
>>> Fixed some incorrect formatting specifiers that were exposed when I added
>>> the "-Wformat" flag to the compiler options.
>>>
>>> This patch doesn't include "-Wformat" in the Makefile for now, as I've
>>> only addressed some obvious semantic issues with the compiler warnings.
>>> There are still other warnings that need to be tackled.
>>>
>>> For example, there's an ifindex that's sometimes defined as a signed type
>>> and sometimes as an unsigned type, which makes formatting a real pain
>>> - sometimes it needs %d and sometimes %u. This might require a more
>>> fundamental fix from the variable definition side.
>>>
>>> If the maintainer is okay with adding "-Wformat" to the
>>> tools/bpf/bpftool/Makefile, please let us know, and we can follow up with
>>> further fixes.
>>
>> No objection from the maintainer, thanks for looking into this. Did you
>> catch these issues with just "-Wformat"? I'm asking because I need to
>> use an additional flag, "-Wformat-signedness", to have my compiler
>> display the %d/%u reports.
>>
>> Thanks,
>> Quentin
> Yes, I previously added '-Wformat -Wformat-signedness', but I just tried
> again and it turns out that only '-Wformat-signedness' takes effect.


I rememeber now that -Wformat is already included in bpftool's Makefile
via tools/scripts/Makefile.include (variable $(EXTRA_WARNINGS)), so it
wouldn't make a difference anyway whether you add it again in bpftool's
Makefile or not.

