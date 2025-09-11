Return-Path: <bpf+bounces-68177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E9B53A7E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932F4AA6FD0
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155F35A2B9;
	Thu, 11 Sep 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISrHmnsm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2913EFE3
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612399; cv=none; b=IiKXlsONA+ur7a8+ey33O6QjKKazVt5lWcK71rNYB3WOh6JCwG3+I+vjhRr8DqJzq9H2IC39pyVDt0wcX/Ah33v94uLshpmkeyNAB+O8mqP4hg4/Pesed3zeMM4zxctBd8C4xwOsF2zt0srIMA2tKjTPQCsSK6VxdjdXjkvrRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612399; c=relaxed/simple;
	bh=i7vZX2LHHjhvdIbaBsWr3+QKjTH6JY2MqQNdHiabUvw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pk+Z8JkWiVxZcnMaPq0vIQzC8Ru4js2srQHGFG2CMNA9lHusXYmQAZXMQXQgZ7XP8fXcygqJJv/GBiiL/FF7CuSS33R4M1Iy9bujPI84l8M/HrxEONXMScsElYSTH6wvKyTfv7wkfeaGg+GjG5srxwx3gdj2iuCZUnghg6WqnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISrHmnsm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7724cacc32bso838574b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757612396; x=1758217196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7vZX2LHHjhvdIbaBsWr3+QKjTH6JY2MqQNdHiabUvw=;
        b=ISrHmnsmLZ/2KueQyKWC8TqgBYzfIUSuXrQTjYApRi5VcSToxPgw8YUcbSfHloQ79M
         izr8zACXBQmAiIjRf5hh134+LNsUUFRLgAp/kcndrWL/rsC+RlDmXHM6BkxuatAl8x5H
         Qw4YJmLJnPbaLrE4qbYklfzNtnfqE+ez2mXZo+FcgbEwxY5rDmqeiH2L1UQ42y8nFdB5
         hUPAbK9/muoQ379LcgRCU6xFz3Bnv2/CRvy6VfSV6abOhb0i516C3U8v6i+1UhyNW/RV
         BIyWz0hae+CkxzwehWDPVz2TxSL7oPu1T6UjFUFjpLIgxvAnqP8RA8CXuGh/LL5/M7tm
         Ffdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612396; x=1758217196;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7vZX2LHHjhvdIbaBsWr3+QKjTH6JY2MqQNdHiabUvw=;
        b=crTkiz2J2I5+UFzMZBHoKW4nTvuxtV0CfBUFj6rC4piFPPlHgFV07BsW3NSA8eziJR
         +I9VTRl825oLkvjDCXUGZbc+Bm1aEz8QFijiMLRHBqQ1C4U1BX0gDBcbz9lElFnkmCBh
         xedjO2ZAq4/xBz3Wyo5z3KnrymBSWykdnEcXuQOqQOtiLvxRnZnuL2jiOm6kIHHJXgcH
         eAbnNp/NjUY5rVIMqit7rqxfvwFHcgWCCEP65IjgFTjrkthapj6thyBJSm7+kRc120tg
         SArxlpACEdeXCpTM+zdT6hqvvzJKs9yaAZ1vuYTbwIUEeb6VYl3wgsMKxSgRBAf3tuHZ
         /HfA==
X-Forwarded-Encrypted: i=1; AJvYcCUIuPkEeeShqUMPXYL9UwnqSQleuSBDuConAc03cFp8dVCRTY4zlwtHqTdTT0aaj8ML3yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVjuQX/3zFjyigoY2W3PZ3dzVm6OMLPG+roW+BSYeGGQGP0fz
	9KS87ixER4F22OfjeMAMp2yPXcE8Pv7wISY+HDSq/ctgaXuSJQRvZ85B
X-Gm-Gg: ASbGncvDmtZo6bcbuUuTqnUHnosqOUpyLBxJTzWqvcoC4XpjLK/tvr/lB38itzdoX1m
	MWLJd8nzqMtvkGA42MXx4uAS1T+AZ7Z4DdtNe1CUcFSpzx6WYdUvH5b2R7H3MK11+dcN9L1A92x
	2QBnoozGR+1F/031x92y98nqNlIx58DYNgdHYxt/vzV4vLH88a3GLYGLeVlZGlmBNdyzokUwDXW
	kdXbzvqiSAW07cMXorB0iWvpOX/nNSOwL/QGcrRy4hDpOmIB53oCWlhSeJ5twKRMUVludCkahBZ
	/GDtbt6Kux5w49NAdl3dH4zqhj2ZRB2H6LUKqFIBjcynFCYx/rI0O5uutm+tyyPSux2q5MDcqdz
	f6MqnOeGM/huMFKoQV5E=
X-Google-Smtp-Source: AGHT+IG2zLYdZHBL4MZB7Ejdwc+tW7dVeqvu7WemMW2XRtiwFpQvOip5jYuYYBQRBo1p1goM9aANfg==
X-Received: by 2002:a17:902:c406:b0:246:bcf4:c82d with SMTP id d9443c01a7336-25d2703a593mr2326705ad.52.1757612396473;
        Thu, 11 Sep 2025 10:39:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6c59sm24903475ad.12.2025.09.11.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:39:56 -0700 (PDT)
Message-ID: <4f539e7057e68fd17572aaad3af9edb235f38557.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests: bpf: introduce __stderr and
 __stdout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Thu, 11 Sep 2025 10:39:53 -0700
In-Reply-To: <20250911145808.58042-5-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
	 <20250911145808.58042-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 14:58 +0000, Puranjay Mohan wrote:
> Add __stderr and __stdout to validate the output of BPF streams for bpf
> selftests. Similar to __xlated, __jited, etc., __stderr/out can be used
> in the BPF progs to compare a string (regex supported) to the output in
> the bpf streams.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

