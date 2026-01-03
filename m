Return-Path: <bpf+bounces-77731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E417CCEFCE1
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9510B300769F
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C62F49E3;
	Sat,  3 Jan 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IfY9C+5O"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18629A312
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767429703; cv=none; b=Nx0NT01K+lzYGPOYU15VGNAE4DSCfEnIzfPSYuEijDt8FwQZrP3yZyVhg4Vr6xSXSTEwxHpwkuqMOnXz2MsUfwqLtWWe5aJYs6JGXIlpRLiDrDve7OG9G6aiEYGSUhYlDaVPiREM4Do/1QTAvc1L49mZcRZo7de/vvOoqoajnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767429703; c=relaxed/simple;
	bh=Kh7HIYVnBBHR5fpLTnsbuxs3DjsfEn3Teg+ayAl3V3k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R+5o66QJ4bRvjW4Ix+rniwjDFnyp1pCrANzBgX7TG3gZxTdFNT8FOSG5TgSwjgDROnh58uaBGI4uZkj5sFlfNA8wbdcPxZWkkHNvnvhWr1Cy5UZigXybs4Ne9p/tL20TDmMDB6iPCECsYU96PEDXZWIkAPq8FtLh7Obu4/imfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IfY9C+5O; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1767429690;
	bh=Kh7HIYVnBBHR5fpLTnsbuxs3DjsfEn3Teg+ayAl3V3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfY9C+5OKnMd+Rcpf4l7XFxDBztQDyTRtijExhZKMRA1ROOZEMexG0s3cuzHnRgu7
	 3CW3a5CKHb/tpnWiW8+9vOQG/yjy95xNnXDbRqomO2q0vlq1lc0erGLzpg2QMwENc4
	 Uks4uQNnqNgD2hC/E6+xunHKPAHYrdlk0bu59qs4=
Received: from wolframium.tail477849.ts.net ([183.131.27.141])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A088108F; Sat, 03 Jan 2026 16:40:08 +0800
X-QQ-mid: xmsmtpt1767429608txjcril5h
Message-ID: <tencent_3941034B98F2EDAA0DD04902CEA715B23509@qq.com>
X-QQ-XMAILINFO: OAope3s6+8XpjX7oSWhji7R4yge1mS4Dqq5Oh2xRrWqWfKT9jQgaOvuzhxGyLV
	 CnzNSlUJva7z/cBAQiNBielJogeo+UpsWk59WeCSCM13yu6aD8RwKtXVIaD4Mo0xN+zogaqLcvBs
	 qabkKgmR3rIXGIIw3UawwCC8eLLWAabTGE/rNEKaOH7WGwa6ms1CFIlPvBlfRZrSVHwHDhr6aMDp
	 eyY/4V93rlSVMAVrOKS3Jjxs/0Vhv55K38Ig70ZjNGw5aEGjHaZymI0sNaYWaik/ImV+lagGgViY
	 DVB4Us4NhVGwBzF/iZv5n+ngvzJkRD4gMZIYPW/vUoMk+Ep85EBHTe6nLLdm7MOnF1C3ninXVjYw
	 ncHnqLABcbxE0AL+YtJ8OTFV2piC9EkMTJKM0svbliRbTWniyJQ1SW9iFINDbvlTPy3NU1SALzIj
	 WvxAubG4SHWYhxZ3KwOtKyOqbhbD7T6+ip4Y8jwceKg4vNawqLNfxVHZtoRsv8hRQlZ628ENXu46
	 2QFIYojeYJvMWU61jcpihmHLcMfz9v6wbTJMdhxYQ4wyiiNVUYiUlauLayhgPL5+GrX0YF4vDZJF
	 vJIdb3Lh4hfB2hjHHPnOAmwca2O3O5ggfX7kQz6cJQxIKuahxdiAjg5nlRisGbQog+iWRdfgokrn
	 E0r6OO+CUbkd0Qsj9cYvPVWw4RJCxWfZ8kFe2bW3rZAloPQnH61/e3WBjTQD80MEFOnVYMXuLoDp
	 lp2UNv9ocZ9wvX97lNd2FqgSL3rsQVoXV7A8u5qWlN3p/Tw9/FwBu6jc2kaG9gA4wYIopKLW/YO7
	 iY7fmI4HGk79ERqsoY8aJpP4Ao1ZZaqEnUBTeQbWaxi9FSR6NIMJfOrzsyOw5h1SUM6HHbg+mZfI
	 792Lsg0DWFRJ7UjeoJIK9oqQqvCD/n30Mi8A3RqguUUeSZxCHGSZRp1koCoC6GZQz2emTwtpgVRt
	 C0fxZHAWuOHcN45oqYLO8PoTRsVvfI74gX/mHA5FOnqMrjb1wd6v36OmRnz/fDHPNUixSF/lfsda
	 E0MHy6LkAYhL5JMcIs03Z3dBbuY9TzPhD8J/2diZvOC0N1gz8i1pTswblCk6sR8NVircxuAniZIU
	 Z5s2lBYe95rhBUiXU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yazhou Tang <yazhoutang@foxmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	tangyazhou@zju.edu.cn,
	yonghong.song@linux.dev,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
Date: Sat,  3 Jan 2026 16:40:08 +0800
X-OQ-MSGID: <20260103084008.341841-1-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAADnVQKfo4tM01PnsZE8mVpztumqAvHvvvmJrO6nxf66y8w+kQ@mail.gmail.com>
References: <CAADnVQKfo4tM01PnsZE8mVpztumqAvHvvvmJrO6nxf66y8w+kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the review.

> No. Drop all the tnum complexity and only support a single case where
> divisor is a constant.
> "Completeness" is not a goal for the verifier. It aims to track
> real world cases where precision is important.
> So far I seen only one case where compiler couldn't optimize modulo
> operation into shifts and muls and that caused verification issues.
> The code was something like: array[idx % sizeof()].
> The verifier can be improved for such specific case,
> but not for "completeness".

Understood. I will drop the general tnum complexity.

In v3, I will restrict the analysis to constant divisors only. And I will
also include support for BPF_MOD alongside BPF_DIV in this update, as
they share similar logic and use cases.

Best,

Yazhou


