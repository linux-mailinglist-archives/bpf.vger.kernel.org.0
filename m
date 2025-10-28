Return-Path: <bpf+bounces-72602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9854BC162D1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B3400109
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B134BA5A;
	Tue, 28 Oct 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L73CMJGd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0634B431
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672670; cv=none; b=KjJzFoXvYj4yl1qvEOlCY0g98qG91HTn6iPZwy9uNwNt8EVNKYiFs+epmWDBhQ1u63Su8vGPhZ5E+CWPgSRgwHJa2beqs3fk5cDVBqQuKwjQ8dPQl30VD0hYejbFeT+DZpwvN0JN3BCA4NeNuOYHwxLEHG8zLXRyVD5KwTbfJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672670; c=relaxed/simple;
	bh=Y/HraECilJ6AC28sJfuKJUG/ZZQHHv7RJd84ADtEYwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIRWk5vzpnxe4jjH3EPsQ8OoHhog/wWfyx7Y2sVWAahpPWk7Xuee1sGtZfYWymfhZHKmq+ZRCY/eK0LBCab+h3NjFzcR+uyQ+ZkuuusQ2/V/YRX6Hid4ik/IdJ9oJ6Xpb5iVaHOzOSn1ZNJkpFbQbPaZjYRxyta04e2r2DoQ+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L73CMJGd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso80152f8f.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672664; x=1762277464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSwI/dovbxHZsefyXJPKSjPbHaJhS6KhhKTTIMoQyd8=;
        b=L73CMJGdPMLoHlam960O2IrklWCFAkzn8odieEGnKZ4aH1earhZPjK7lGDhqE5C16l
         yBRZTZQtcXb0sA7cRMbPqhsHau6WqqqVhOiwx/3ZY8Ym8HbX9ZXsCG3tg3C7Anyeqndk
         oTK2lYvKgazg1Zrc/7E35FNOISzGbEIro916pr1wERgZRmS9EGGXWFgeUJDja1yGmHhZ
         ry3PVt8AFsEj7WOqYQueLXAq508VrvjflxMj9obEQ9WRqEv1mIHvS1mFzUuhk3wPA0oJ
         XDd3o5sSXv8dYfkmEaprV5fbzJ5xjxxE2sQuP2I/f6IxnCdCc0rTC7SHwhFLqHZvkOBq
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672664; x=1762277464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSwI/dovbxHZsefyXJPKSjPbHaJhS6KhhKTTIMoQyd8=;
        b=vnzVXsdfqjcEW0vhplCgTGaGsCkCrdbzEZ8OnfqJN+OR/bUvmQc+2HYfgn9Zzs6rQg
         KrXiRCbfw1RaGboxdRVHfq7i4dmCkHBGji5XMMc7dyepNRe1p8+AdbGEmKHqumzG4oko
         Uqocf6HRulVYudZRdmf5qUMdF2nMAQgDQ3CIeFpac/l+ZDTonbLdo/aZ4kUAB6vqL1a9
         eUWBeyLoYhtkm0Euakz0GH82YiCPU8LWp985nuoWxC1d3haGP3haoEu8yoO5p3eg+bda
         DkxWWISHi7N59S+r9c0dLWH2iAzP1ZWe9aVJ89VdeVWsinC92gWj0DZdiiB1CatcAjZW
         uMLw==
X-Forwarded-Encrypted: i=1; AJvYcCXDwCH0teKbZ45ktVRVCIeqWTUFPA8uWBwkutEC8nn//YB9F3OIDEdk+CrMLRBELDSa7U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxta6I4czglkeyU7XCb/lHvAUc7vFKwZJ2an4qlyg8eTEnFxR
	uxIe29dcyRtZw4pRjbvcAmvjrbO7Wb772eVWVpeKfF2k4ptJDdU6yKwh/mnWCdUJWZNq9axuTiW
	G5iyHKAnejDmJ/HlM4LBcahenxegRQdc=
X-Gm-Gg: ASbGnctX7hCif9AavEh8xSvWxFFBGZHHGG6GmuDrIEooOSEJWcQJzpOYfMHiPL39mZn
	ElEYFC2GqFRXat3uWQiGCRQ/1AT5lA9omLGmP0AsExOmqETYwLssUF9NRZfpg9Tw2kq/FVa4vL6
	dAvvyt9+RgVq194RnyNlt59/e7bsv6YhQPKeJftwIpS0khLEHClpEhOGLfg9Rb9nDfef9kw4cG+
	vxJayEDWGSNmVomZS60XXk8O/XmyRnNce9/sGcBel9Bh0LpblOIOnKukosZq6VPVLFwZZpiTRkr
X-Google-Smtp-Source: AGHT+IHTdDJ7W91+X0Lit2Jf9Ol9397LLqUf9gynWpswTVO1GNQdk1TYiUTC6R125faMYDU49nZxa0ZLkOYh93L+Thc=
X-Received: by 2002:a5d:5888:0:b0:426:dbed:28c1 with SMTP id
 ffacd0b85a97d-429aeb04dbfmr49732f8f.14.1761672664362; Tue, 28 Oct 2025
 10:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027232206.473085-13-roman.gushchin@linux.dev>
 <ab8c7bf2f312e150c22d83e5ebe91e17f3c4be42b3ff0825623caf3aac4086af@mail.kernel.org>
 <87ikfzuezd.fsf@linux.dev>
In-Reply-To: <87ikfzuezd.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 10:30:50 -0700
X-Gm-Features: AWmQ_bmmzQlUp9ca5HlQPxn2I7vrph6AvsljwavTyuNEOnR6T4XT912-2Ipx8hs
Message-ID: <CAADnVQLcmJ3X7X6oW_v0KgQCPtgjmYNtgfqXqH5tFrQ+Q+5v+A@mail.gmail.com>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, inwardvessel <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
> >> +
> >> +/* cgroup which will be deleted */
> >> +u64 deleted_cgroup_id;
> >> +
> >> +/* cgroup which will be created */
> >> +u64 new_cgroup_id;
> >> +
> >> +/* cgroup which was deleted */
> >> +u64 deleted_cgroup_id;
> >>    ^^^^^^^^^^^^^^^^^^
> >
> > Is deleted_cgroup_id intentionally declared twice here? This appears
> > to be a duplicate global variable declaration - the same variable is
> > declared at line 13 with comment "cgroup which will be deleted" and
> > again at line 19 with comment "cgroup which was deleted".
>
> Correct, fixed.

wow. TIL.

I didn't know that C allows such double variable definition
outside of function bodies.
Even with -Wall gcc/clang don't warn about it.

