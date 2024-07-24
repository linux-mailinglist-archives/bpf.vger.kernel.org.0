Return-Path: <bpf+bounces-35520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857893B413
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393F21C23AA9
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC815B992;
	Wed, 24 Jul 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aYTt3aXP"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602A14D293;
	Wed, 24 Jul 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835852; cv=none; b=NMRd4g5yIha0Zo4bhOzpSlefB0FkvO4AyXD8nmIhxNEGe9BQDCVsiZnD0ZTFkbzak1++lnK/zyEpdjQepJxo/+GSkNZ0rT0C/5+HE0tY/vcMqA08NkUfifQjjvfckp2Ff7k/ck/qQszXGYVq5YhViRtb/byKEaSXKSc4BKA8WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835852; c=relaxed/simple;
	bh=tHZM9xDRn9QxuuRbCi79Nd7TIdcdZzq29BmffUOsRGI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tCHZ3t4rQeIOYsKSvchqdVhe7q5j5HXGOhlCU69D9zhdb64e1eQ69ypedACzhhR3wWfKnKKYeDORGqxzUhC9zmG6zAUbeWm7w8HKGLG4Iv/wzfNWaO+BSSh/uiI7VOHG5ZiAUBI2bfcz7LN8iFwM3j7YuLxc7LKfiH76dRzj4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aYTt3aXP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721835808; x=1722440608; i=markus.elfring@web.de;
	bh=wclAnnnRIbQZq/INzgqgyUqDvhscd2fAxbit0hgFL4U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aYTt3aXPJJ0ksHeQtVzH42YjaUdx125tdZSAMFydoOiAwNHskEKGqoH0w5iPVTj6
	 +/uiL5X59olqT9iArH9ICVLXvcGtq7VPnelF6RrzB5H82smtdV2MUVr/fLB7YADR+
	 TE5g7f6Emf63TK7M84tRtNS7ZuywK3pwNhTrU/XuKk0DZ8H4XXX8PrvaxRprC6MKf
	 6KP4dXNar9eELf1aStbwSXOrrY0pgim4ixXuvBRrs9QQO3V0mCE89BXKz6cjyWmOf
	 GRATGl/DSI90fBvNLMijjFp0ramQLoCEy49uwAE2h2GbhsptNDeVJbltkXDBqa45n
	 i7eLopAbEyVHj9GQsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1s3eze2WwQ-00bOYX; Wed, 24
 Jul 2024 17:43:28 +0200
Message-ID: <8c33ec2d-0a92-4409-96b0-f492a57a77ce@web.de>
Date: Wed, 24 Jul 2024 17:43:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, bpf@vger.kernel.org,
 Quentin Monnet <qmo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
References: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v4] tools/bpf: Fix the wrong format specifier
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dajtUilI/4w+MplDp/WdO2l1V7DTsFuZxceZMALAmJjSUTAgHGu
 COXLP1qyVvJaA4N21/3yUakMnErdzhrntimA/z6MXw6xRaOkEUS9DjiOmJuMnX5pVkOA3Gl
 diHSO+gGraKX9t39YUvgumV9JyO4hZCiKRShevqZkYJ/XYU7Se4gZGZU/JQueGSuRsA65QA
 AZMjv1fLe5pq+eZ3tkMgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iXQI3Pc+1lE=;bpNHnDibFXJ9pypA6PxruiYqjmy
 gdQgCV2y9uglst64FSrdF7pNv7VhB8cynxJ+ezAdq1qKE0Ejc4mXy6ZsQiPOcyqPmxvL6atC2
 CHtVyPXQYB78Todhd8XXsXlZ9gCMoqeCdIN1o4TYxyG8Ok3zpq78PyAFvKdc/X0OJa+hUPw2O
 zwPViKEBbE1P9zrgUcmuuh1w8RdtNyyKw4KVe6awjXU4HKjOBylMmJeyjvrdwY55DRvQBo/OR
 L8yMt8SNmHX2LC3wxFj51/CMPunWhB67P5dP5R+mvXHFvzJMGXgL+fHcHKqnmrWhrX3ezoFDB
 QsfJsTtFUp0wXl2H+Nb0zzgT1WR/1Te6BQbDtUPsYyzmAgFa6W4s5uR+E20/gSOE7NJsK65fs
 +9X9NpSHUDTYPfLPQXeLgfw2IAvhEtzEJbc9zyESBhBr4zymnxOQFgqr2DMQ0eczOyXCdhPaN
 BRvPzGi20tRK5qKOzOJCL5S0f6WSMK6AbL96xfxSw8bs1Z6oB+70WakVJyXgW9HybHeEtXoHE
 +pjqiQlhVTZg082TLHPsA39yzvm9KnlF3p6WheB9CRbDfbF2r8aOHNH3a0tJQHAGmcYVt/N+t
 SJspplNSqj7b4U/5d9ua0Co2Ziy+fPk/BM0kMp8CAhUzq56raoMONTNCrnEHjCr19mgyO0MZS
 7VSr65SfuX4ZzbZfI3DYD6T1+czuBFM2CwjSlgp8aKgb0iRq/mclkonXij+gDO4+BUfxB9lp1
 Db0Sj5EhtEXuS49+04S+9AnQgWR4HlZviJ7+gNiRW7U52W7PQ76gIKBwIuwviFp2PUnI23DXO
 /Nqq0Y7GMcjEC1yGU4u/w30g==

> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".

* Please improve the change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10#n145


=E2=80=A6
> ---
> Changes:
=E2=80=A6
v4:
Thanks! But unsigned seems relevant here, =E2=80=A6

Please adjust the representation of information from a patch review by Que=
ntin Monnet.
https://lore.kernel.org/linux-kernel/2d6875dd-6050-4f57-9a6d-9168634aa6c4@=
kernel.org/
https://lkml.org/lkml/2024/7/24/378


=E2=80=A6
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *b=
uf, unsigned int len,
>
>  		double_insn =3D insn[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
>
> -		printf("% 4d: ", i);
> +		printf("%4u: ", i);
>  		print_bpf_insn(&cbs, insn + i, true);
=E2=80=A6

How do you think about to care more also for the return value from such a =
function call?
https://wiki.sei.cmu.edu/confluence/display/c/ERR33-C.+Detect+and+handle+s=
tandard+library+errors

Regards,
Markus

