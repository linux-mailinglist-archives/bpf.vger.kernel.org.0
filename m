Return-Path: <bpf+bounces-50598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A72A29F17
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BA61889065
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420108634E;
	Thu,  6 Feb 2025 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YRD6vyZa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB169A32
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810919; cv=none; b=RsKIk9ZWmHwUmp/JpqytEc1USqWU6IueMZEx0kGSQa9Zuu7nfxwX3QHxoXZr1nm/HE1GBSFKOfRYdMkrJqLFIvGCaKBsi5DJwCTMewx64a4Om+3Y3zk7dupb4lLe+k2EYGJNfDgH3vCcEENMdhS3jVgbJ8aahAdGJ8rh6x4n6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810919; c=relaxed/simple;
	bh=0qe0J0MvfRuiBq43af8K4K5I0WGUIHhXEr/5RP3eLGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gX3Z5yvJxvdTZ19BsvIH1G31sW0FWQ3BPnJ9MRSLRKTv3uCIPEKdBpsmQTuwk/ttLqBT0ddEXvNpmfMkSUKHpPe8w6u27WRDR4XllcjzxYfU36AzAn0sR0SKnGu4paZ96rGsX7E/N7lLXLBK04h395j+SyjYNrTQwK5NO6nGw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YRD6vyZa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so796583a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 19:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738810916; x=1739415716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qe0J0MvfRuiBq43af8K4K5I0WGUIHhXEr/5RP3eLGA=;
        b=YRD6vyZacbqJ6T45zw+lYyAhE2+VQW7/ixeA3qmva06qLKw2tYowcdj+Dfi7TADzOy
         aLWxwIGEGySM0ZqdJPUp0gytrgVqIfHP5fVlbSW6Ksfh17Hwpy0DVmNyiwV51P9UG6go
         rEnu61x0n4fex7p8zzFJ7gD92AyRtCxkZPDJZSCqrXIcu90GJwJzBk+35fqC2dNta9eb
         hnWyW3UsSB11dCIfVQj1myn7pQzK1p9ERgz/5GkwYyO/zzeF9XgFOKD3c+rrdWlUlWE8
         tqFJEVw3XYG6YYyHEltupIEZsB1cTTfTAu+cbg2jWO/RYxpVKHsVjvlAH23lLWmcUQgs
         9kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738810916; x=1739415716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qe0J0MvfRuiBq43af8K4K5I0WGUIHhXEr/5RP3eLGA=;
        b=Unw1ltYKZPdQflGAnFoMNkB+SntLq0zczBkx2ph7I5yI71yeteMZm0HVayQQJeRzhq
         1zuYjgV5v3Uiv10CsbDj9NjyNOfw03QxtEVqtOXx5z7AGDsOJ6e0A5GPSDZ51AfXg5ad
         D78w2eOvaNlv9VXikh4AHg/OSczvyLYQILSeAZyz+HU/PfmYoRaH+J2pZMCsLuQkpkkq
         uCmz1QcZ29ud8qmS9c21Q/Gf5Pw5WicOqraoMM5b89GzcqtuQ+LBX7Mz3BqBuxKM1jkm
         dhMJSP95zi/nAHp/GTZqrGapcse6yk+E3rzA1OgdRx7EbRUfOj+Lf3/XEz/u/3NZKLZ4
         Ig8A==
X-Forwarded-Encrypted: i=1; AJvYcCUdwpc3Msxy5JPW3lNLkbKwPjeEl7xHEdzKb3h29MpBLAJmxnENoKf54S6k4+6ZDuuxPNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWSCUZNRr/CKPMVhp+JIAxO85iV0yi8OTWzbMlM/a2NTuf4/e
	yfRRiq5GVwD3UEa9lBo5EgW/aPFL4n+7q5nYxJKOXRua62SIApV4K7FbGjt8e0ur7QfgqUXsLs0
	XbKa7QhcxQGNwoH1bT62tKam701iYfgBZYbWdKg==
X-Gm-Gg: ASbGnctr9JcdDeIrdEK/zwhNMIsRVCl3Y7ZAnJNLXkjg5Kt4AISCj/ABQJ/aVPlVd76
	0T/Zx1GXe19kZtBrbzkTtC7syWA1p/YuJwC2wa8Ef55rhPXQog6RPXgaBG4uFndK8sTQAXjRXfs
	FzsVVKGqyiBHrkZDQ=
X-Google-Smtp-Source: AGHT+IGcwjBOFGcJT4/PqALwT5RrqHxENcOyMlc4eq+xsw7MaIYM/bSv4JycOK44JNsSH2BT4hp6mIjaQV4zE0TY4NY=
X-Received: by 2002:a05:6402:234f:b0:5d0:d84c:abb3 with SMTP id
 4fb4d7f45d1cf-5dcdb775239mr5144007a12.26.1738810916220; Wed, 05 Feb 2025
 19:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6JXtA1M5jAZx8xD@debian.debian> <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
 <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com> <3d906727-1872-ca7e-759c-65c16b0f339f@huaweicloud.com>
In-Reply-To: <3d906727-1872-ca7e-759c-65c16b0f339f@huaweicloud.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 5 Feb 2025 21:01:45 -0600
X-Gm-Features: AWEUYZk2dyAEdJx5ao2KY8IvjYRyIaEC62FP3iHVcMD59WAkB0xwiGW6KFxn1Yg
Message-ID: <CAO3-PbrNgZ-SDSCwNfKqeLK_ZSiq2zCXBQq7dM+PawRY9=xA_A@mail.gmail.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 6:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
>
> Hi,
>
> On 2/6/2025 12:27 AM, Yan Zhai wrote:
> > On Wed, Feb 5, 2025 at 3:56=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> Let's not invent new magic return values.
> >>
> >> But stepping back... why do we have this EINTR case at all?
> >> Can we always goto next_key for all map types?
> >> The command returns and a set of (key, value) pairs.
> >> It's always better to skip then get stuck in EINTR,
> >> since EINTR implies that the user space should retry and it
> >> might be successful next time.
> >> While here it's not the case.
> >> I don't see any selftests for EINTR, so I suspect it was added
> >> as escape path in case retry count exceeds 3 and author assumed
> >> that it should never happen in practice, so EINTR was expected
> >> to be 'never happens'. Clearly that's not the case.
> > It makes more sense to me if we just goto the next key for all types.
> > At least for current users of generic batch lookup, arrays and
> > lpm_trie, I didn't notice in any case retry would help.
>
> I think it will break lpm_trie. In lpm_trie, if tries to find the next
> key of a non-existent key, it will restart from the left-mode node.

I am not sure how lpm trie would break if we always skip to the next
key. Current retry logic does not change prev_key, so the lookup key
will always be the same. It would make sense if searching with the
same key could temporarily fail, but it does not seem so for both
lpm_tire and array based maps.

Yan

> >
> > best
> > Yan
>

