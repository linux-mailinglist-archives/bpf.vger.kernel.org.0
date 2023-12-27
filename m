Return-Path: <bpf+bounces-18687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A981ED30
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57671C222C2
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E063B1;
	Wed, 27 Dec 2023 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WNJzKeGx"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5863A8;
	Wed, 27 Dec 2023 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703665181; x=1704269981; i=markus.elfring@web.de;
	bh=sFYtgUqx5/8rcJnSIVTUvLcv4KtPODMLVzVAeiTwlds=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WNJzKeGxXHHQRvaxrlLeNKs7d9lveaMaReCX6jcIn7YV4oec6G40Drl/LOAWvpeX
	 uOK8eoBBrcFtGqkyebStkwLZpu1I8thiD1YOzTNhAA01+UK+5QCKshVbns3y3Bf9G
	 3TfNDKaBJjOZPx0XFOzIO7CEImEYw8vt0vSpEnVYl8Q4NAUq7sDfXIkUwx/v0adpe
	 Fjho5UQB3xgaMpXL9JuKJ+6dwGi8E8MIS5yoHtRf67RxSEF59D2ZeLzHMN4fyKdNX
	 lLvI0rLB5ojEwLAtzXDKZC0VLfMBe7Yr5y6+gLZ8s7ZiXZNfsnBA1NmgtLZybVsvP
	 VSUUdLoCZdKJ6ow3Mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bYo-1rIwpv0ata-0024wc; Wed, 27
 Dec 2023 09:19:41 +0100
Message-ID: <b75d66cc-a507-432a-af60-655950671b8a@web.de>
Date: Wed, 27 Dec 2023 09:19:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: HID: bpf: One function call less in call_hid_bpf_rdesc_fixup()
 after error detection
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
 <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NNpJY3Chs/fDzSODGnjQi2SuOxapzbSnV9uYQXas/LJUzP3dHWM
 ZkCkRh1p01y9VGYRQEgXS9iB1Cyu4HDqwqITh9XPhAgwxmdLqjFqiWuVgJe8DJ3Q3hryMyb
 wQL7/8yUdZSBccjulsM6UYrmbViANudJBCtQMfl+FUkIgfxqojyayCUfXKDvfKQdiNKgcil
 6CLJnD6WnszV80CBMPTkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WkaRGhcrnBU=;d8sDLIBDrl2jkJ2jQNLzsFQzxRt
 yLPFiYbt2Mai7UAArrpAeKw1WwERVGzrztshO0YCvoD3Ar6TwsFcUra18qlFRy65tuHk1M3dF
 TQZfxAcfl5ZYGionVkIXVnZiguLLJXmUqbbdpVeviMJzenNYKdwAnqWjda5GlYZZp4NnJ6Beq
 5LQ1gQt5VGd1wvaCEUWa6YMpRpi6/TC79P6MX3KIf8OV/tvp1ICWVk7e3OB/J6sUXwjI2O12U
 iNKRGWlw8NTt+9mcsCwQ6gIYsnYPq//PytckavXBMurAq1xG+z30z138IYakOjR5JTjJdsssb
 yAMEG1/yGxRgW18irodWsQ3PdDbBG9YQKZE1/PmJCoIi/dIB7sI9sYoMLe3vC9PBDxw61wlz1
 IWtCCAmdhy01JvL36Jv4MIpw3yPCNMiias4RR3rkc9ZnVid/BHmjeXrq4z0Xy72WpUh1Rk5n3
 CosWNhXNw2W3ZAfoUa397W3FyrH4Iriw7M8wm3jbC3QenBdxdWscxmDVDZZObi9Ju9Q8v6q9b
 0rtjq0ewp99ReayD+Y0ROSv38giolAav6NL6FNsmLwPtXes/CuAgumSf9b56X3ZTk2Npz47oZ
 peMSbVt4/OCAO8CFCh95WRbov7Bj+EbF6OHKERKW9M9eVUmjPp5N6vSUHMj8j8aG17LiwJ0OX
 +9fsmef2G3lP2xUSxzHfyWGfFFM3quJz2r1LC1EtKiei+ZZYuXXLos6hKeBCcmBkiEXhzGPYc
 ndFEc5cfmkR5boSYuFQLJLf96erEbAKseT48RC72Xlh2PFzXc+QvXfGMHBHScVw9jA9Y55RG0
 jGd+Pphxo18wirT16aptYWR5HilJCTti+Bf3y/ciIFZDZBD2zwwbj1mjc4RVIVIsWlpb9bAT8
 uq3emOnFmtIamDo3BO7x9Pd2QNJSQHEa0Plp30OnCNd+jDMY5i612R3LKtw3M+7Q7O2OqHm1w
 XnduCuATJOAt7N0tufYTle62Eww=

>> The kfree() function was called in one case by the
>> call_hid_bpf_rdesc_fixup() function during error handling
>> even if the passed data structure member contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
> It is totally OK to free a null pointer through kfree() and the ENOMEM
> case is an unlikely case, so I don't think the patch is necessary.

Would you ever like to avoid redundant data processing a bit more?

Regards,
Markus

