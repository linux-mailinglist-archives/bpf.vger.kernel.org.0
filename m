Return-Path: <bpf+bounces-70759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2FBCE14D
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79D9A346A8F
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFD221554;
	Fri, 10 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKuX7Hu1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19921A436
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117298; cv=none; b=tPQekl+bAmCfkoFqSO/hUWBvUonqPJRE8+Zp7EyfUc8i7XhsmhhjWf4pWQ4C7RqHMM3yLOCqNnPX8RRD18mLppcvntIXd3/DV/Rqg7Tb4Cw1VKF6jD9qKpLKVp5oXMh+hzYmwnxvVvGFr+D4ENFUHph73a5hYDq21THUKLZmfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117298; c=relaxed/simple;
	bh=xQ/4ZjsgUvY8WcxYNuYZausKRCyatnoDWOSpBljSiJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gp9G73TwjcsejHNH98asg8/m5cQAAnh/NQUPQAPvvP557i1Aahs9z4HWqxFsY4LPQnVkC5PxbF8YlMCF88Miu4j12YPzb6oj/rUpVmU76dP0uC1H+1YNAo2yYHaM7Wf4P0cGmy7AE5qPGAHAMK20Zx4mK+opgLQnIpI4b/qOCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKuX7Hu1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0308469a4so1414846f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760117295; x=1760722095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ/4ZjsgUvY8WcxYNuYZausKRCyatnoDWOSpBljSiJs=;
        b=eKuX7Hu18X8+Swe0vHNizALebVb7A1qeHAgHbrWgtT9ml9jdsKCuJ9SCXrK7jVZhtO
         qU2J5ydcFo2wutsSWal9HcKl1KyJTjDZ2O4NuwX3b6aO//7LxSbkIU6cnSeAofUm5v/P
         XYs3Os18hRVN2Pa8jq1Hcg//8P5/aYG5XDobZMJ87yfD3oF6ghHBki346v3RXdZFH3y2
         4roZFQodjQkIEO2x/251m3PNuvPW7SJC2qlWWunA4hIz4tvjIir+V1UHKn7JJwEvjNGK
         84gWV0ja3CmxFTrkgvf3UZlMHyWgkmbnp1guJQSd7M7HiitkYy/9/+IzBjjb9YXUW3ak
         HKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117295; x=1760722095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ/4ZjsgUvY8WcxYNuYZausKRCyatnoDWOSpBljSiJs=;
        b=tQjD78kfbU6XPUaQa4ejjHAYGc9cKHtifyLb7z7OZ/5+UUViN7HGcdrmACs8jbMgNh
         H2bCV05U2d77UW97MA9u9dhiC2dXnE/cFKty/wToi5sTWSA3HqlAOXGT026iXpDmhLeP
         6YTH1MBTqE9JvCpYfFFKPADbfgpThHryGsq18a2Q7am7tlwbmUFOGrmwrAbxemswJ0+3
         qNd8DgyClJ49FM6ckFiNHpcCUkzqOxJlIwul1L2QlBJG10qIA93iqsmWaHJQ1TfQuijo
         sRGyVUE5LeDXsGptbnfjY1GtNwnMY0uzunRvUkT5BCTp2REiLfF/y044sBHAiMCrJW9X
         n+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHKyYakeaXXn0EnDOuSU4VPQkJ/dASTXsvYXmF1U9F3U5vkMVpIII4Ga9XHAHnXz6aw5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YywySW1rY3j67J0pbCAJ8CTnpwaov2XS+kwma7Btzwa99wrE/8r
	JBANlqHtOjBYykzo3eIYIDxNQoflafPDZAGuYlU/qv3DJM/kyT4AtOESaoLmZROItGvZK2wdymo
	vnDsb1y3wOq084xtZvrms80nnS2YRF6c=
X-Gm-Gg: ASbGncs14pc50KT0xm5CBI2MhiwsCdayubC4pFvWFlyXqpRwYfFx9/fGWOPbjDIR7xa
	yvPrhi9i5ZRzcwviCebK224Ed+5l8f1MU99NXZl8aplq1PJyxtGTzCgWEXsPyLc61dqENg9tEcW
	NsnLrL19up3/NIJGcKpKVtYfti5NsNmCvwcL81lx3MNgM8VhHKLgoPfa4ILtKN6HKLU5gUy7Yqb
	10ZhQDXL/GXqUXTVrHKNrfwAybmRyMTEuCN4NFQHw==
X-Google-Smtp-Source: AGHT+IHyzdVdcBMxkbfQqwvmG1LizkGC6dUESASHO2F+kq1GlKTMPMNiemgjByqFJMXj7h+OF5xfA04kFxEYnI0ZEJU=
X-Received: by 2002:a05:6000:2082:b0:3e9:2fea:6795 with SMTP id
 ffacd0b85a97d-4266e8de1damr8952388f8f.53.1760117294929; Fri, 10 Oct 2025
 10:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008102628.808045-1-kafai.wan@linux.dev> <20251008102628.808045-3-kafai.wan@linux.dev>
In-Reply-To: <20251008102628.808045-3-kafai.wan@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Oct 2025 10:28:01 -0700
X-Gm-Features: AS18NWDFYX5lk-xcbV9YDbaG0hleAqPWTOgn0UbQgw6zcP_IMPBUk575iP2G9Vk
Message-ID: <CAADnVQJL0FuK1oodJrLOFrtEFyVbYV1PP9S5VZm-_imztkocgg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for unpinning htab
 with internal timer struct
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:27=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wrot=
e:
>
> Add test to verify that unpinning hash tables containing internal timer
> structures does not trigger context warnings.
>
> Each subtest (timer_prealloc and timer_no_prealloc) can trigger the
> context warning when unpinning, but the warning cannot be triggered
> twice within a short time interval (a HZ), which is expected behavior.

It was difficult to decipher the above paragraph.
I think you're referring to throttling logic in __might_resched().

I kept it as-is while applying, but in the future either skip
such low level implementation detail or expand it.
Here you could have said that the error is printed by __might_resched()
which prints it once a HZ.

