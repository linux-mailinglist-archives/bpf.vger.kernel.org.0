Return-Path: <bpf+bounces-53662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2537A582BA
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B7718856D7
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19732C2FD;
	Sun,  9 Mar 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DXafd6GD"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0AC2C8;
	Sun,  9 Mar 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513125; cv=none; b=tbpLUue1ezlxvqV2nF57CXOPKtRNuYIKXfDqygy19KB1kgUHyjDVgqYamSFyiLxq38vmBD37Y7R0E3mY9ctXrZO97aKIRX43zW0KrMZSBtxu2hBT4QGduVG+qvwUH0uZim25of8NE69vh+LBEMInrQvrYQJ9XHqSO+hVExS05Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513125; c=relaxed/simple;
	bh=qSmwB1sdxs9Oc8+2jfP69kYazQsA4dTlEuWulBogzPc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Zsk31dQ8BX41azIDlSWQuJ7ky7JB98WSKc7gh6Ubks1T5nBubcUGDVQDlir20unh/fSea/jCQLg2tEAyB+tWbmQRPTZgPrNa7hoN6+q2EQxLWudqT2VqLj7I0sLj1BxBrbG8GfUNSFrsMYRjBpslhuHKB4/uMotxCWhOhuEzUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DXafd6GD; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741513093; x=1742117893; i=markus.elfring@web.de;
	bh=qSmwB1sdxs9Oc8+2jfP69kYazQsA4dTlEuWulBogzPc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DXafd6GDJ3xGD39lW0RGupKx9lgoCHYJObMA0wirdB0LigusxIviiKqliAXeO5aL
	 /GKNe4aRM2nS4IITbRx6CVNtZYrS0wiKbUIU3BtYzVfT9PvsyNN2ehJYgvbJR4P3K
	 1NVrhNS/L6zyHzVIRwfbu+v1usWuItepOQsNplRxmpKvr1zWsYjwMobaLJzsm4WL0
	 pfPfIFMEP+Rk0hE1NTlThe/ShJPYfQL3qrOksDlaLDgHQHYV7R1ZROsIn/kUfVQ0e
	 ZkB/g+zmH44yKfjPWP3Vbwn6SIHxLJ9Mf91j0PxlSgwbaSiAyAIKzMacB0IefD1wY
	 jA1nGu5vaT32zkAMyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.26]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3oyy-1t9FPJ1De4-00uvAK; Sun, 09
 Mar 2025 10:38:13 +0100
Message-ID: <54844369-238b-42e8-8fdb-6aa650c37134@web.de>
Date: Sun, 9 Mar 2025 10:38:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20250308215605.4774-1-qasdev00@gmail.com>
Subject: Re: [PATCH] bpf: add missing NULL check for __dev_get_by_index
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250308215605.4774-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w/s5CVCe40JbqXEwZN+yPWuhVD8GS/asS/zTbjza8EDJ2eUdRI+
 x8G783xitKhI9cRhRX4ZUfLMtA5sv3gpYJrMYMXB3gc9XsgrfB0SDZHjK2PBX453WPPLmt5
 US0Az9UfrMOQg101FN+fIIe+nKjw0CP1t9qKrQvqDtCO7iOSMtmPP5qfI9ncfKYmRArimeb
 eoBcI8LhDLD6pxm3Drvcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/pfvWaAT4o=;YNjp0KedE7pfA6E5Xb7Fe4MuPbC
 k1iauQjKuJRcCJh6JNfCmepGwefQy1NrfndcpsPGSmZVmTpZzI3KAY5eIU8u5sHTP0jWJ1IFF
 w/fiT31QfsTxUeB/Qbl2q2Z6PHppcx80N3N1CALtiFdAfVqsaS/Ry0hYw8rUWw38iEruqaeVt
 twcyc65vMe5+aBsxhl57nhrDRdx2EJ7Do+rPWE7+Pm4Zx8mx/x4IS8ejtY1225lZObwbwjfSJ
 e7xtIeWb03rHWnNqhkE7RqiKL41BkXFMSPqQu30jBXAoFkTsxrcN8FQ+JYePSB5/uhliWqq/Z
 Y2kbPKc1vx1HVGDM/xv6kL5En0iLI6q7/h4xRb9wT83WkRCVHkj/9QKULDW7vAkBJUWEDC7ip
 4fKjln0tuX2QBUBxZPVVXGIoqVifL27z7ohsYbufN15e7BJpjlj6W1iQzns6BKmiox0Fs2ZT0
 ps++13gAEW/lvT9E9ikZ/tKYGeIkzSyHJFCTUyvZEPePhsgNyfPWYIBMxZXJVwrTRG5sImuzC
 Ck/sitRqmiyf3sFhrrXWyAjtkWCfKnqvt3AaKf2d8I+Nf3p/Bfhvdh1PxXvpNBiFJUFlKNRdk
 fz0feoHfU3ANgfZRZMVT88FPd+cAJ/OS/SmbSHjNIDAE2N5uRmJDojuNMV5rUVxB4k8bUqn4b
 jDyg+U8O7yq0duX1vCARcOyJ7EHaFc4lfSBAgHgiUr86Xd+rss7t9byG3sXQEjYUXq44U9UdQ
 4ucYWF+IvQXNTBiembrrZ9sLFIFtFdxp7JTbACE39vVrl//NP+lqjclPxgsiAwmY2ftEasKcu
 C+TzxV2yE/0LW5q8PXKwO1vTwDBgGUrOHuwVaKL2BiLbXTXpSdC7xY9fZF2z/f8K767tL5ymA
 nmPzX29cggTFbjEyrSAgG63dmvEQWAPqTnE0D9LVcmvw8JWOCwjOKW7u9PRlUrplgZ+ofQ9Go
 RkSrVQZSlht07hRcKHYO3wlmFBNYGFw1CLKa/cHY6DfBKMu8pCisd4F9MzsgZlwVn/aneNvj7
 RCGNLL63yUxlvYB+OD023c6oMXfVxgirzowCl21WXp3u0bfsP+roP6sT0f4XWasiliOeWKT3E
 ydTbQ5L0AsQRPldcHDFPFobFdgfUOoRi8w871cQDF/bEoK7W6BRW7JyE4zHhfU6DLTx+xyLsV
 ZS2nvhdtBTWt7ZnMt4UXjeQOlkfnEJ5/zlM24xJC2C9teDPNo1V+7HBfwUpZ9K9l/5LqFIob6
 KeYelR3Nb7HiLRnGyLIs87plCIDEkpQdZqU659vlwj88TLfdBgxAC55vvmkeLpJQAmc42/gNq
 HUMlFzM6FQE+ZTRmTrsDSsAQP7OY7JS4WT4ruktPfB1x0QWRW15+OvSi3wnMh1W5dyLu4/C81
 hmAoQho2h0IZF+1RFgiex5EVhTZ6JQSnVPXOUeI7Jymm/9iuFjDTMuIjurftZ23FQwDHzso2N
 eViWZ8HJL+1wGJeQi8fC/17e3Xdk=

=E2=80=A6
> We should handle this case by adding a NULL check
> and cleaning up if it does happened.

Please improve such a change description another bit.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc5#n94

Regards,
Markus

