Return-Path: <bpf+bounces-66802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D313B39473
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD997B76B9
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455062BE7C3;
	Thu, 28 Aug 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYsh3p7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128927A448;
	Thu, 28 Aug 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364262; cv=none; b=P3ZnspyRzLzlF3mq+oMTjtEnxl+mnsYybgVY8ueqMFJFhhSV/dWILfQd9M+Fp9cVtt1mKw75Rwf378vhxSxs+Q+77tCV2NK9d+lCGRB2cES7jCW+DlQvpTWdeyvkqBY7jEc2fP8Nkf6vb2/AAYxaWazDLZx8f0cgQvt3y2iPoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364262; c=relaxed/simple;
	bh=vjeZA3f7xR9YH9F/x0ROkGqBRadSv26f+FYmCkdNOTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXKSrLuBWNdFyl8KHrPUi1DjATCwpUyGjw8QWayxL2x2d7R/5QGh0mS7m+mSbWegVql7wRxxo1S498OtPbsoyEhHfPIyubUxu59diVyLOsw7CX8/4qvICSB8nfL51x2CfO4puU5fB3UZMadfzMDNLlDhKUq0Ie28DcOAOLYHA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYsh3p7x; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70ddadde494so6496506d6.1;
        Wed, 27 Aug 2025 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756364260; x=1756969060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNqgn+C2x+n8djesjxQXU7WZdkg9QWFo3iy0GNcvuv8=;
        b=jYsh3p7xbeDg9w20aE/ivMRTsewesqjhKATag1H4bTMohcvUBSao2q16JQ5YO55deM
         LhtTmID7FN8dx3IO259MewdPoD+Q/dO8ZvNG2yMLFv0IkTaoQ/DfmFfZepCIHXKBVr9c
         K4lwwv4gOq+4D65cmD4a/YSRhgT+Mt1tAA7FVY6LFHmU4A5ao2IQRks/rbLbOtKX6ivy
         xnu8St43M2fLXrVLyBc0ioMkwgSR6PASuIMMIihuQONTuBoZ1wy2yrrpecLt5LxSnjDu
         xHyh2rGjYZA7YKTypthMs3Gx516qtDpiFA0O2qE0FC8t4Pu0UTis8kFIy1/kmoVFCWfp
         pP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364260; x=1756969060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNqgn+C2x+n8djesjxQXU7WZdkg9QWFo3iy0GNcvuv8=;
        b=nDVMbtvUom6Kf667T6WhwGSlQ/Oe6NENnj6LoIelHchWeowt0yBh/SjQ5OickODknM
         aMthy2QgBmT01erysT436fRjbAP7Xs7fVLKhvwg9sRnYv3lFojlG6jtqElrCgktyuDqw
         l5bnJCzUiSLFJle4SaDoKmMIwMnIPpoB90v9cpaaG8oydLqvidBM2oun7U3ARpy0PbnD
         47PGNrFB95VEwmNdhXiN06MGvl5BTblsbAD+KP0FW/Qex57tcnoYKHQ+4j5SXj79pr8F
         QvTFdID9ii2SuWsnspbJoq0zcNhvILgPSXvSfqI4v3qEppw8HC4w5kK7OytKg7eiU2Qw
         9kdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0y6dYDkwCqTnJGF7DkgXjL+xw6vA3RuVRkAAYGiUeRJCIK0Vqu2W0H1o2PdIbOyXgICM=@vger.kernel.org, AJvYcCW2JRl+3K7aPkYDzsfGGHVzxmmomVVO0G4BVfGLdXSooi74or0XhfHXo5PrPVyx0va096T2eKsUx3Fm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvh2Hr/GXUXZ3eA8gPCznlVKDp73cCxfH6Nwu+MoHXRqC7j7gG
	+se7rnC0pSUpPWcWTSBUgYWLjPVnj7zy8FUN71XqLROB9BOGGS75cRMT6/DUK9ecA5wnOLR5wT0
	2PvlWQAyEQg87T1rYaJKIdZc7//wOwog=
X-Gm-Gg: ASbGncvG7CjLJGUJeoH6e7vM/IrobgLHyc+UsLbYqVZU2n9leFzLm9sbdQf7OyNiTew
	RtNy4GOFIyechyjdPAQ4R54ZujFWdFncJXS29/zm73YZGCwsvjNrYTHDmNtFQffnaKzKgBrMgs3
	lNjYvU1j9+WOix8qzdhPEyvS5gGN8+zceqtSipLTcZ6pL8oJ2t0EDeFWcNL4sO6bYqGOKVJCooJ
	KpD4tvCYdf491U60404H+NZ0w7Gx/V2qpiDACcstCnBc3oN/Q==
X-Google-Smtp-Source: AGHT+IEgzfyRzIDdVSfflhJR2fRudWG/oyg9t6JnrRbhCUhwPMrXZs7quUS9aKCLkTeL2HaPSd72LAiCFh0pxOebMdM=
X-Received: by 2002:a05:6214:ca9:b0:705:c148:26a0 with SMTP id
 6a1803df08f44-70d971e4c3cmr251105156d6.31.1756364260071; Wed, 27 Aug 2025
 23:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
In-Reply-To: <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:57:03 +0800
X-Gm-Features: Ac12FXygvU0PTDWHH1nV9Tdj3y453lXYUAzGekUvEJHvbRAb7PUlo_2hu--qJCI
Message-ID: <CALOAHbAwTZQViuZQZpor9iMHr8w8AvptQTb5TEHrekN6FSjLxw@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:34=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc cgroup people, please do include them on this stuff.

sure.

>
> BTW I see there is a BPF [STORAGE & CGROUPS] section in MAINTAINERS and
> kernel/bpf/cgroup.c etc. anything useful there for us?

BPF local storage can assist in implementing this feature. However, we
still need to introduce a new helper, bpf_mm_get_mem_cgroup(), to
retrieve the mem_cgroup from an mm_struct.

>
> On Tue, Aug 26, 2025 at 03:19:40PM +0800, Yafang Shao wrote:
> > We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
> > associated mem_cgroup from the given @mm. The obtained mem_cgroup must
> > be released by calling bpf_put_mem_cgroup() as a paired operation.
>
> What locking guarantees do we have that this is all fine?

As explained by Shakeel,  no locking is needed for this stuff.

>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>
> Also not to be nitty (but I'm going to be anyway :P) but I'm not in love =
with
> the filename here.
>
> So now we have
>
> - khugepaged.c
> - huge_memory.c
> - bpf_thp.c
>
> Let's maybe call it huge_memory_bpf.c for consistency?

makes sense.

> And obv as mentioned
> before, add it to the MAINTAINERS in the THP section plz.

will do it.


--=20
Regards
Yafang

