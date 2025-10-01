Return-Path: <bpf+bounces-70143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82EBB19BF
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616574C4391
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0676214A6A;
	Wed,  1 Oct 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpqMHRpQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15134238D32
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347212; cv=none; b=BHFA5mACdjswUn9zs7k6T/UL+NXCboZl0fMM6oHSPwgkEe2LmK3gJ4Rdi6BDQu5g6K6K15H0vRCTwi5xwNwtw46XJfFq1guzEeJsiv9GFMlse1zjRsxH4vnSLKOYMCRGSldOLCjd6IXUsxE/qD7d6gI86H8XBHHyr83HpCEXErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347212; c=relaxed/simple;
	bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHlly23YN0B3+tF1eEiB90IfLC5KV8d2k5URAquhm1q2esGdanV86WYE/B3t37ARHHRS2xi/xyKDzVzZ9GyOB3XB91VuPRKQOBDy/J9xMDAHzGg3PEK+sarHA3K0pS0arZ0Mmc2JEmLZrbKQ25zd+B35JSWSVT1LDDy5V+MjOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpqMHRpQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso287917a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759347210; x=1759952010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
        b=cpqMHRpQp8qI98EjSgSqjL6D9P/xTXUasKSvjmv7IM1JHtgb6Mwh3v75/EGgjdEyER
         FKozlgPn1sjFxen/U48y6X9u7cU8ih+I4eQFMELHv6fHP7F5I4oqvZpQoWE5pY1h+VAY
         E40K5zdmfGOHDy7N0+Zt4pFz5VOlPz21EVz+12Xp6oQpcuidjy24vSr4U7I8BaQ780OB
         1j5cuImELiRU8IWqd/2T9LaKBaQVuYWKXN3or1W22DajRu4j5xlqfzcIfj5f/uKINFlf
         PJRX/N5trxqpxDAMRYnzZ3uZ/Zlnn6VYuIS154CsUpFcJYWGXAJ6ACLM0RUAp6ZAp0Vy
         SMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347210; x=1759952010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
        b=Phzkkz8IaMcTEXdBPJiSXIv7irrMuGtRTlHFRxGHDbyWbXCUEhhwOIY1eF6rKJ2NA3
         i0aw8x7Er2psxb9T6ZZmfzTF2GgZ3UGmNK59FeuXthN+vpu1BZxwRc3Ahdq+A75/nkZP
         u59UfCmun2QyL81dCEflJvShJKitCNXi4E1NYpQ3M2Pp9I9zdOA8WGxQG7kHjd+n9CDP
         7ruobxK8etBIP16zdIx0Y6i/6duwUSa/YCHxppYuB+KtGwVVRzwSVoVZalScWb/p6+CD
         Ni5pU7QUivnRcLkLDOlz6MrQgt+H1j9niB5XMPBXyRkLSN8tk7K/zhBXRYAiJ+oHBXLw
         2sdA==
X-Forwarded-Encrypted: i=1; AJvYcCXiA87YuHr3jDSi3m3F+v0KMGAZijVnTrZp3ljpKCRAsyIGaVlnanN2ul2mm/1h/VFYQA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUOfBdHs3PJpJvqkllKfj//AzSV6rFRyG42KdTRvIcNZ/9hZ+
	S1BrEz0+hfOieto86a11xHsAqrjPqk4D13hak2E3AkNhVu9M4JdsPWa8
X-Gm-Gg: ASbGncvtS40QZhqz0qaB8NM8aJMzM/e2pO8rqiftkyAms4w6ESTvBEr4giLeqPePS5b
	/UxZ+/3dOO7zibBW36dIys5w9IgbG9zAM5BddZDKhWxp4teT/Obbdy8CkwEWDa0AszQtlwLwHrl
	Cryp38qTXGPpirFd189XC0OrJeD5lgmCMOMJp9+brn3vmYMWo/B6egWXzDKRmyTZzc1KlgPUWax
	uB0yd4NcxmnUqA9FekqDETcmlHs0UmQCXYr7Qc5zfhMT6FEFDX5m0aHSObe/WIhRyuh7AIhqIHl
	ynj2nj0ckstquYzjhE2JOYqFAU5q/VbB3HQMFsk64vvxzDL/V+NDC2ycxGaGBfClPDaV8TqudJA
	ZQrm1yoJpInwXKwMCs6CECNbtappiW+XNh5GvujzRVp3zScxUyptsa+hmb6aKpFMqtQuFdQpCcY
	IFXDpRgA==
X-Google-Smtp-Source: AGHT+IGW1s1nX4XZtXh3VMWVQiZ66bwBTZg0K8xNP35DfDfQbjhhuXZa6BE+hp6HT4WQWLtr+GfrWQ==
X-Received: by 2002:a17:90b:3b90:b0:330:604a:1009 with SMTP id 98e67ed59e1d1-339a6f38562mr5471335a91.23.1759347210327;
        Wed, 01 Oct 2025 12:33:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399ce47d7csm2255668a91.10.2025.10.01.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:33:29 -0700 (PDT)
Message-ID: <a9bfe698df684f2a78e49913a0e39b02fa52088d.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add test for BPF_NEG alu on
 CONST_PTR_TO_MAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, KaFai Wan	
 <kafai.wan@linux.dev>
Date: Wed, 01 Oct 2025 12:33:27 -0700
In-Reply-To: <20251001191739.2323644-3-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
	 <20251001191739.2323644-1-listout@listout.xyz>
	 <20251001191739.2323644-3-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 00:47 +0530, Brahmajit Das wrote:
> From: KaFai Wan <kafai.wan@linux.dev>
>=20
> Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
> BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
> scalar value and do not trigger Oops in privileged mode.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(in the future, once you have an Ack, please copy it to the next
 revision, unless there are some dramatic changes to the code).

