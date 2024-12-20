Return-Path: <bpf+bounces-47440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD879F9699
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD78163F63
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FF21A421;
	Fri, 20 Dec 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="tc4metBu"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2E21A422
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712228; cv=none; b=TiTQSH41rYP9+matcF0ZhIHacEsWQ7hOZiBAUlBTvuhB5ehP7IqI/zihtodRCRk3uASYe+pnwiwkKE+8LyXjr74V2EMwc0GG2BPHvOxw+f/a876WrP+8dP1XKwIPW7kH9mcKuz7RWSdBJDiHxe5Y7TX5tO5ImJtgR4kmGgtky2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712228; c=relaxed/simple;
	bh=PtzNnkyAshIW/NuP+j7v4sKNWhNMFcZjKLUkITq9I4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPrv5ierkGCnpDmA/oqzU7m9wT3h65xPoWaTSLpuOyTfz05WC6g0BWdjdyxYbbrR05UBAVkHqggwfmJ7GSw3Sgymje1OY4T29vi2AyEtLazW6c9Zu4LErBj2BCM6BtH+kSFBLMTwVPUERJlMj35f5IBvwOcv77T124b7JK6DUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=tc4metBu; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov01.int.sover.in [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4YFCRj4l6lz5W;
	Fri, 20 Dec 2024 16:24:33 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4YFCRj0Qc0z7g;
	Fri, 20 Dec 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=tc4metBu;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1734711873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pu90mrkymPQjbUcZIeu588GxLJBiMM1st3A/eSubJvM=;
	b=tc4metBuwZXT9zH8aON6Dtc6tRL5C5F2VfFWkxt77SVIonccC/irHdzSBRDIxATNOk9QA2
	kb09gl8PM4KhpqRtF5huXcSroJ/m1f32thAFc8kHXOI4k07t1JHVH1mj2ZRhpG4ztktQYI
	dpKGXAIERUuScYc9Fnjc3oKORF1AL0QG2RakQausLCx3LqqeqeQUux+wWplr9pIkcWwHX7
	MBhExLICjYbE+6XdtoW6/Qx9HBXaeyPG/ptdbJJDkxgthV7E5SjC/2KluV8XTIHZIlWYvX
	ztLKlSHbiBOkRfMlGSZjSJE1gRD1so2BHCNAiaTbAXm/I9FEXYNX/5r858xlGw==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=WMmFXmsR c=1 sm=1 tr=0 ts=67659a41 a=IkcTkHD0fZMA:10 a=8AHkEIZyAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=e2U0C865cM52ObQbgCsA:9 a=QEXdDO2ut3YA:10 a=2GJFMtwbh24A:10 a=fX4k_0L6AFcA:10 a=X1AoViHaI6kA:10 a=KCsI-UfzjElwHeZNREa_:22
Message-ID: <26180f2e-1ef7-45de-8e9e-f08a4e6a6d36@qmon.net>
Date: Fri, 20 Dec 2024 16:24:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] selftests/bpf: clear out Python syntax warnings
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
 <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-12-11 22:57 UTC+0100 ~ Ariel Otilibili
<ariel.otilibili-anieli@eurecom.fr>
> Invalid escape sequences are used, and produced syntax warnings:
> 
> ```
> $ test_bpftool_synctypes.py
> test_bpftool_synctypes.py:69: SyntaxWarning: invalid escape sequence '\['
>   self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
> test_bpftool_synctypes.py:83: SyntaxWarning: invalid escape sequence '\['
>   pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
> test_bpftool_synctypes.py:181: SyntaxWarning: invalid escape sequence '\s'
>   pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
> test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence '\*'
>   start_marker = re.compile(f'\*{block_name}\* := {{')
> test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence '\*'
>   start_marker = re.compile(f'\*{block_name}\* := {{')
> test_bpftool_synctypes.py:230: SyntaxWarning: invalid escape sequence '\*'
>   pattern = re.compile('\*\*([\w/-]+)\*\*')
> test_bpftool_synctypes.py:248: SyntaxWarning: invalid escape sequence '\s'
>   start_marker = re.compile(f'"\s*{block_name} := {{')
> test_bpftool_synctypes.py:249: SyntaxWarning: invalid escape sequence '\w'
>   pattern = re.compile('([\w/]+) [|}]')
> test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence '\s'
>   start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
> test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence '\s'
>   start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
> test_bpftool_synctypes.py:268: SyntaxWarning: invalid escape sequence '\w'
>   pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
> test_bpftool_synctypes.py:287: SyntaxWarning: invalid escape sequence '\w'
>   pattern = re.compile('(?:.*=\')?([\w/]+)')
> test_bpftool_synctypes.py:319: SyntaxWarning: invalid escape sequence '\w'
>   pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
> test_bpftool_synctypes.py:341: SyntaxWarning: invalid escape sequence '\|'
>   start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
> test_bpftool_synctypes.py:342: SyntaxWarning: invalid escape sequence '\*'
>   pattern = re.compile('\*\*([\w/-]+)\*\*')
> ```
> 
> Escaping them clears out the warnings.
> 
> ```
> $ tools/testing/selftests/bpf/test_bpftool_synctypes.py; echo $?
> 0
> ```
> 
> Link: https://docs.python.org/fr/3/library/re.html


En version anglaise : https://docs.python.org/3/library/re.html


> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: Andrii Nakryiko <andrii@kernel.org>
> CC: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>

Right, this seems to be a change in Python 3.12 [0][1]:

'A backslash-character pair that is not a valid escape sequence now
generates a SyntaxWarning, instead of DeprecationWarning. For example,
re.compile("\d+\.\d+") now emits a SyntaxWarning ("\d" is an invalid
escape sequence, use raw strings for regular expression:
re.compile(r"\d+\.\d+")).'

although I can't remember seeing any DeprecationWarning before.

Anyway, the fix makes sense, and does address the warnings. Thank you
for this!

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>


[0] https://docs.python.org/3.12/whatsnew/3.12.html#other-language-changes
[1] https://github.com/python/cpython/issues/98401

