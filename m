Return-Path: <bpf+bounces-40346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A498730E
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E21B285F94
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD1717C9E7;
	Thu, 26 Sep 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KY61cOFO"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BF17BEBD;
	Thu, 26 Sep 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351182; cv=none; b=eALkcfNKWkW++kM7gREPv4PqlYInEQ5PT5Dfw7euCwcXR8iH2po40O/SKNbFpC3Sqt++K7LDwQ2LnxhAlbLmnMHQwV62RJg2+4CvQMMYhUvmWyY6T/6EeqWPfCoW7fmKREfV4NYbH1GEmh9nWgNTiXU5+SKoXnkkMZCfCGM4YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351182; c=relaxed/simple;
	bh=UmZ9Ip7A/TJg7BVUydvbWsc/Ryjqn+a7l0DCi7hkVa4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A2zyphPG5+uIaXBV7yNOR4pHpRsa/UZDKMYgZ8mFmT2ZmmMr3q3PH2b42o33Tlax3Gj6uvuA5jo6QamCj9U1ZnX5LaqpoOptojlgg1nB5OmojX/d73m2iFywAMJQDimzmKY34HdtzKmnh6d8iATusFyA3XvTcaOWjG0WuBp2JzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KY61cOFO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727351121; x=1727955921; i=markus.elfring@web.de;
	bh=0WriWlYUv5/uc9PXmsjfVr90I1kl1JDus5c3wCEcgcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KY61cOFOa/3fXrmnGiV5a3uwfoD44aogtDpF1et9K9ONhl2v2rZM1vN9j/9Wmmu2
	 XNcpeYjOpSZAa6s4rqJTLVY7ZAiKwkD4YFmF5ec/2Uju4jtkaas1WLxpmoSZl+x43
	 RjsRqjDFMNeE+XQbtceQcphqHRCPl/B4JgOOhI8LrzozkZcro8ObdN+tZMlJggivL
	 VgnE7YLU8LM3X8iqGe0F9woHSe5+fyP83yxSdoOveM4c8fXlHuuMqBOLVf9irov4O
	 DZ3HdXOqafiPaKTDmDzFsBT93GIX4NjahtKuo/cJiTQSd7NDUc6NoLkuE8vRmJA80
	 Mda8SPLQkSUatKNPuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1s3sdh3nCv-00se3Y; Thu, 26
 Sep 2024 13:45:20 +0200
Message-ID: <08987123-668c-40f3-a8ee-c3038d94f069@web.de>
Date: Thu, 26 Sep 2024 13:45:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Hou Tao <houtao1@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bpf: Call kfree(obj) only once in free_one()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMy/eZVFbxT56cxaOkV6q3GnYGtHkvXeGrP2QYBfyXCXsVyHwIT
 D/wU1ctL1bLgb0hwrCz14FL0k8aaKfGm884/NYnh3gARJmPUht+KO7HxYvCnj63UosAaI4+
 y3HC0a2fi51ZisGz9DU4902vh+B74/Uh+DlR2uiZ7aDESo4ZHx1kNui57JKfPoqBNsxkHq9
 GrFSPZpjuMHvFx12YK29Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+5iEdOTOxP0=;ZaD2bUfmzzkNuQwW1O9PAgcYIbY
 7nuWlsMBj1MOo3gA8Q/+obq0d3hCDvK2o3dGXssmDl2xsq9SgrtQjz/xHvBX295QRDBn2azrJ
 R158S1J3U6bF0MWF4VrmpK7T5bYiJEmrY2MRu7ikAo0LMN3DYHdNwPpg+SUfxx2lah6feNE4V
 oN08vQIjas4U++yykUTSm+gjiTz8lq28orjg2xpfB3qEZ7+JKSVl30iKC32AIE1dyrufSSOHc
 RqLXnwjfHrz7LFS5Unwv4AjY5tEBrOGFSzhiZkieLcT9ypXMj0l8gLSejD75BssSWRTFV7m21
 Iq6YRR2nv/1/a80HdN2RggrzjDn6UKuobxGACK7/kl7JewPaHpj2f8uyj4yPJ1Rj5Z8l93IL0
 AN0AOwZ85j8vn0PlaEIqZp/ABJFm7Agr6pnITRNvUt5YVPITMrw21nTyE5DXJt3EppCnb4EfU
 gMDTEc2eNiVkRfJxfL3Y59FHy4rgieoU657MfBziSSOMg7DCd0DyX4irrJZ3ebamzs9BIt1dS
 FDRRekgVHtaayvENgP1ZELExdLyRJ3+/7iwwpKlqrN+VyyJ+vxNoQnlQZCRhPjBLLY4Y0dPN2
 BPfeoH9pvQm2FWcsEXy4a+xyRqZMMklSk8wbwmCHAuxTva6SWoLK9gJscxylPbNRvV7voUPrV
 2XLEqfnNc4zD5/IS4dPGXgYVFCFMxyo+M+uTghkMfFAE249Da6A1LjbSJ+SDhyAzW/RFNee0Y
 vlpLnB31XNzKFZBP6PCog/jlzGaezqDkMPkYZMgGO+ATl+CSqTIIlCC5CAvfKrITBs9dfB/rP
 7ns9F3OgdlmfPG1gDGtkplCQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 13:30:42 +0200

A kfree() call is always used at the end of this function implementation.
Thus specify such a function call only once instead of duplicating it
in a previous if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/memalloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b3858a76e0b3..1a1b4458114c 100644
=2D-- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -252,11 +252,8 @@ static void alloc_bulk(struct bpf_mem_cache *c, int c=
nt, int node, bool atomic)

 static void free_one(void *obj, bool percpu)
 {
-	if (percpu) {
+	if (percpu)
 		free_percpu(((void __percpu **)obj)[1]);
-		kfree(obj);
-		return;
-	}

 	kfree(obj);
 }
=2D-
2.46.1


