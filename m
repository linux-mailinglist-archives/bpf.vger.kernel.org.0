Return-Path: <bpf+bounces-48371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A863FA06FE7
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636771884FF1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8503D215048;
	Thu,  9 Jan 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DZ5DN23s"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D0202F60;
	Thu,  9 Jan 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411075; cv=none; b=Y3d7LAwrRJrA0kCGr16uHMoo/MueugU2GJnbwq37+68Pz9Z6CiRRY2ySs0uWSx5j1yEd8yiGivR/KCR42V2MtuhHoPK6c+StnZFkSJqHQIyUSLki4Ccd3ntYinEgONbYxXwnQA7APhwoXFtYnK+VuqYWtwMt0nVlJtGfUoj3j5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411075; c=relaxed/simple;
	bh=URn/2Puae2LfTlsbS3DUiptq/qtN9sqt5InEFbP8Gk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSr8/KAH05kCx/23W5pmpO6ld9RKgnME3Kl8cg3N3netTTWyUqoxR4qt68hOTeZKlqeVJ5wGd7ohrmO0uS2wi6yKrgjLR79iinfPCmBctP8JuaPD753uoxHWPxcmSV+wUdupZ+u1DmF2lN3RsVYjuK3Z/1u9OLl/mLtkElKnmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DZ5DN23s; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=URn/2
	Puae2LfTlsbS3DUiptq/qtN9sqt5InEFbP8Gk4=; b=DZ5DN23syJOm3ZePu7iMC
	1zfYah5Id5yGsj8WG9JU4PxQB5J9uSmi5RPpWcyAm3A4D//3NDCDsB+xAMHuHnwV
	UHb5NHqELJLWEi42tes36rRktWjHwUkthYslr14ltK9Qzvde4baR6CSm7cepeHhl
	CvWkjuqW0iRnCGq/QcZk8A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3T+KDh39nGAbUEw--.14879S2;
	Thu, 09 Jan 2025 16:23:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
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
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	stfomichev@gmail.com,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: Replace (arg_type & MEM_RDONLY) with type_is_rdonly_mem
Date: Thu,  9 Jan 2025 16:23:31 +0800
Message-Id: <20250109082331.270120-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAADnVQLGhwzqkMiBSfsQWgz=BqWZRxXAL+MP_Q3hSzie_PQ+_Q@mail.gmail.com>
References: <CAADnVQLGhwzqkMiBSfsQWgz=BqWZRxXAL+MP_Q3hSzie_PQ+_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T+KDh39nGAbUEw--.14879S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfU5ApnDUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTQnPeGd-hjUh5QAAsc

> Yeah.
> If we do this let's change type_is_rdonly_mem(u32 type)
> to enum as well.

> pw-bot: cr

It needs to receive bpf_reg_type and bpf_arg_type, and base_type(u32 type) is also u32.


