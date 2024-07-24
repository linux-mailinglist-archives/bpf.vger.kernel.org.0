Return-Path: <bpf+bounces-35526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20F93B4F7
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62508B20FB5
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59A15ECD1;
	Wed, 24 Jul 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bnhWfj/3"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1E15B541;
	Wed, 24 Jul 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838401; cv=none; b=XrZi3YsekuYwvVp9XV4vrk1r+ZYun4jCaJ7IiXot/BrvC57ItRg5h8vwr9seYX0LnDGUrh+yrPaPiTl4Zfv1kGV8mM5hrrFDA3V3f6kRiy/thsZ8/01Po2xgTuTuMRuuFXeSbtfnLCM++YQjl7fZG4MPlkGtClpzbAkMq3bxdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838401; c=relaxed/simple;
	bh=gw5eNTpYyICyV2ZAaR6ILrhPsmOiUD9keu+vfCnHVug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOKA7jbH5tJsdpDT8SVKTLBRzaRvLjOg6eolvIB7i9wU5WQHVAT8z2c8+fEkOyhpx3feeyyCX+mrjeQae1sc3Ha7Bqgcw+ZJ5N01n8J0uGRRZwZzbipcZlzwHqfmim5cSTi1mHZo+pj7EPogj0MaWyLjbVE7Z9uS9ki7mR8iQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bnhWfj/3; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721838373; x=1722443173; i=markus.elfring@web.de;
	bh=jv050NYEaUlTQ0MHuhRqFv2sefEFwbh0qOm4pfChTRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bnhWfj/3KVRbHR6niYHkHEvsErhLh7JPjiIkuRox3UwXmQNBA87C+o+L///7WADb
	 zrLZfhgi0XNUJTGJ6tgOu8TnIohotszL7SPYEn12LVMG6vLJ2Cfp4GJj+q8MS7rYJ
	 Insyh46U8YHrpXM5hLFcyX+7jXjc8lgRSaOlgctOHOrmR7JRY21huJxdr0D1QEAz3
	 w8RzChTo9cJUxSSZPoA/7dQwQQvfoDwT9IlRwV10MjeHItOGB0UzjzlsoJW7naNch
	 /rfHHsEgEZCVmKpQrHPApf686YSBewdPBA4SPUZDNOUUp+MuydCLPkKEqU/dcEahk
	 Hl1QKeBi5RbbmuFZ7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhjm-1rqPpr2PcU-00eQzD; Wed, 24
 Jul 2024 18:26:13 +0200
Message-ID: <09fe8c54-a936-4cf1-a252-211af58e6303@web.de>
Date: Wed, 24 Jul 2024 18:26:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] tools/bpf: Fix the wrong format specifier
To: Quentin Monnet <qmo@kernel.org>, Zhu Jun <zhujun2@cmss.chinamobile.com>,
 bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
References: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
 <8c33ec2d-0a92-4409-96b0-f492a57a77ce@web.de>
 <db58f8bd-1ac6-45fc-a402-065d234d5161@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <db58f8bd-1ac6-45fc-a402-065d234d5161@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8QSY7VF+lj2VXhyO489fuNPCcy3Oo8CM+bAmUg7vWDN/SGxbv9
 hYInnJic08rO0DKY98OPxQqiGuifi2+OLcUH33j3kbFHxzkZfC8WVKJ6KIuHCPkq1+Vu3TJ
 iyCavUqnMv8TgmYLogr8Lw45BuAvvEdd3Lod0tNJLMvFDV9jxPJ+6a+LqOED5VK7Wiv6YFM
 8WOwVflwH7jizrksIk81g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OWEhhC0IJ3Q=;kpdOQIYRSSUbsAvFSO5Mj/LIs6u
 G2I+hNhuPvwq9dCWw+spdVkkN5NIh/HaVw21UCXxu5BlSpgsxs2u3sSnwg7TNG1fX1UHh+Wd7
 GgdulsnYChGKWyY8EAa9Gh8Jl56nDMvFaZMBsN4+MZjJWETgW+e3rnzJsIb7C/5mzEw+93c1f
 7pIko2bDGG0ETys54AF/dCaZ5+X0g23XVHGZUyI7V1sL+XFG9oyzRtbIyMjTfUF5dvG+ODHKm
 HQvezG9EfL7HgNZdkGLCs9si7zkiEFjVUjlbxjR8InFMdM9witQ6Pcsc9CW08cego+zVO/Jee
 8FtzEWKuEb+YUdRRlQX7d3yRqjjO1j0MX7JUiEN+JhuHK5VWUOtbX8J0PdK8TXZPBcNDF/WCo
 7kyB4JFY4Qvhv1zKjh5Coo3dHEaoY5+dDhTS2TJj2XYe6H7EY2eGgwT116KB1+MKl6FzGeX5H
 KgeZuxGfoXLadt7z//p7SuQe3ISth3qswCTFz+QFes6cY1UKT1lKC5KXkbOdYmj/PEn3LJnNO
 IkEGZln4Kbjyzp6B5p36faWkgqFaKljPiYmxpp/HHJM8MKfqAJYWNk2NaICZQQjs6tLjnT5bb
 VlfIUdzuYEyyrHA67MrZfw9CEA3wouegGcuZQ+srWK2r/diBp9wmADp0YqyOkEDaIPT7dWrkv
 eYNBXSYhyx5PrwUp4ZN7kAjgaoVEL1vODrfwKDZ4X9VT9JIl7NJ7X467NVFuEi+mPt3QXLpEG
 FrYVGRdtR9sWj9GQVWGfealuWf8GMB0lqgvy2LvLoWms3EXR7Gqz2SjtvyFW7p2X10E/hPfeH
 +OF7mphXWeTji8R+mSVbyrzw==

>>> The format specifier of "unsigned int" in printf() should be "%u", not
>>> "%d".
>>
>> * Please improve the change description with imperative wordings.
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.10#n94
>
> The wording is fine.

I find it improvable.


> The commit subject does use imperative.

Yes.

The requirement for =E2=80=9Cimperative mood=E2=80=9D affects mostly the c=
ommit message,
doesn't it?


>> =E2=80=A6
>>> ---
>>> Changes:
>> =E2=80=A6
>>> v4:
>>> Thanks! But unsigned seems relevant here, =E2=80=A6
>>
>> Please adjust the representation of information from a patch review by =
Quentin Monnet.
>> https://lore.kernel.org/linux-kernel/2d6875dd-6050-4f57-9a6d-9168634aa6=
c4@kernel.org/
>> https://lkml.org/lkml/2024/7/24/378
>
>
> I'm not sure what you mean here.

Should quoted information be marked better anyhow in version descriptions?



> I'm not sure what you mean here. This part won't be kept in the commit
> description anyway.
>
> Zhu, for future patches I'd recommend keeping the history above the
> comment delimiter (so that it makes it into the final patch description)=
,
=E2=80=A6

Please reconsider such a suggestion once more.


>> =E2=80=A6
>>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>>> @@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void =
*buf, unsigned int len,
>>>
>>>  		double_insn =3D insn[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
>>>
>>> -		printf("% 4d: ", i);
>>> +		printf("%4u: ", i);
>>>  		print_bpf_insn(&cbs, insn + i, true);
>> =E2=80=A6
>>
>> How do you think about to care more also for the return value from such=
 a function call?
>> https://wiki.sei.cmu.edu/confluence/display/c/ERR33-C.+Detect+and+handl=
e+standard+library+errors
>
> Apologies, I'm afraid I don't understand what you're asking here, can
> you please rephrase?

Various source code analysis tools can point further programming concerns =
out
for some implementation details.
https://cwe.mitre.org/data/definitions/252.html

How will development interests evolve further?

Regards,
Markus

