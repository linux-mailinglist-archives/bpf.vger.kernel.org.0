Return-Path: <bpf+bounces-73553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D408AC339EE
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 040664E25C0
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ED222D4DC;
	Wed,  5 Nov 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQllY391"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D42AF1D
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305434; cv=none; b=qiGpGwcywAhKImIx8UvAbKJBXWxCu0SgmAMLWgnYThjAV9VcehoYP6CVv8PJQ42ExcmDK2eDP3yHJ87vC+2cIrwPOx884741xPW6E792LcIzog284w5dcwK6z272ieynVG2A9+anvXMVoEWoUdGjPSjdWvIhncMU+5FG3MQusfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305434; c=relaxed/simple;
	bh=otQJ5yMPZnoASOKC1J81k6B1oYB7Vl0UomFswCPjByI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPv+BVmF0Yx0zOFZZDop7/5e0+pnO49srojYT+VNmoE65NPd0TC2oFZ1fGfLyHlEwmiegW/5L9dvj+lYnuWor4r7UMDcgm2JgFjYpRMDkiTDDL0qG7CkJTBBzsilOm0Dq8k7BHv7+0uEj0gjH0HBAfSCDvN/X6dq/o0kTFGarEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQllY391; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so4248609b3a.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305432; x=1762910232; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmwaG142GAyLGy8hrUjFdJw0h9ZhJSd97NfM3z0OiJc=;
        b=BQllY391LSEMdgLvhMEa1UdB9CW80BIoyDVaCdEWuyt27wXnkBsNb+Vmw6iL5jXCqp
         lf+Oml31eMa8M7C1lsUw2lcY07rLTqPlgnWJHl9EH32h2PndbczUW8tQgJyxfT49Yc16
         YOChbSJ7v5606dQ4j/EMYYVcooomOQ1lzZ16yNPQn7CzqYMJBCRfch5wOmOHUE4CXxcR
         vcWWnuOp4jWShQ9c01+cxtJ3HNobxJZ3I341spOonIGgz5t3sB5g2ax/JMT+ld0396P0
         9Y91cCG0didi/pdGiX/aC8iWwLCIWxqaX8tTCbgLmYqiOhqUlTz2E4kzL+RJdi+fbDac
         5AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305432; x=1762910232;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmwaG142GAyLGy8hrUjFdJw0h9ZhJSd97NfM3z0OiJc=;
        b=TRRmKX5uYUjjk6JZ0hm6UiOKlJFgkPUacc2NTPJFYnta9GicikL+g8QWJ4dPCWdNqG
         FnzPYTUssW1jgoTh9CE+J36MIjAhxhNTSn9bs4dZTn7bI41TRNAVTzPY7d/PIavUMfjn
         vIM1yboGKmk943cLB+YiIouzzhoBtYx00lIdIL7kJQjklwBNpfR4hNI9bP2Y9Iplyo92
         wCu2kOoOlrez6uvqHktqANEHM7s2ciGtUBZGoWaBR+3Y0euBvyIPp4Ma0pgq4ucPcZ13
         GtIffVy3g/CcwCZvofdiQDEhnY7y9NSd+HYJ8XGRKW3rHgfKnrnoBDX82qbxSkbZkcTr
         nbcA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJiwqcTY9kIbZSVYcjjHfkL4t4XsK+HXB2LMgoTg5E9+nR0S99NcbAvEtpaNxX0g/iCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOJiifZG9ZhTYFWFK0TCknGjD7Zq4wZqFOZKH8sHZWRZgc5zd
	Ye/z97/WpBX7my1LJGf5Ui3c48yEYH6WkfcmdVCzvZnOXxAAIIxRHp7y
X-Gm-Gg: ASbGncuofV3od7CAj/jX8ZIUx3hzeNwxnIL+fV/hxiw/0humGQCrFhPuUO8uMiWe4Lh
	76VB/2qnPrLbbiqxehj0rVHmzlxpjYGSm/GpM3RxIWh+kId49zECJD+x8OEU/z2s3vI8ByVVA34
	uEAU4Sr4ex8GeUSg39dV7MsWIxJ+LDlHBRQjm/xBltxwUvY1eH+X9lUBhnVaDBl3E1JFjVtrxYP
	yxfPjrkL1iwjT9+twBJG1PrDH7aXclhNGCyNXPAUv4YZO6V28t1S76aMpxlIc+dWZUe/WX5bLWy
	v+bhFBGsTtwd/QaFgS2oabILqOGoXI8ClW4XBAE3xhVCj0su24jiWvYiknPlCRt95uOHB8hbNew
	r4WI/xtwgeZlzoCuJ4fbAwkljbPs2ZKypyQEjpM9jzs7FOg0iyJj3Vwaz1TK/DuAGE3bd1nWTHP
	z6oQ8ZpQWlMn3Z7oFrKGx165k=
X-Google-Smtp-Source: AGHT+IFRprAUGju1jNoCrThKfphIxtj9XBDktxmL9JibwH4lMh7Pp0howRHX8Hmib3n060SdiXW8xQ==
X-Received: by 2002:a05:6a00:1304:b0:7aa:d9e2:8175 with SMTP id d2e1a72fcca58-7ae1cd57d31mr1641380b3a.2.1762305431932;
        Tue, 04 Nov 2025 17:17:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586ccfcsm4425329b3a.41.2025.11.04.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:17:11 -0800 (PST)
Message-ID: <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 17:17:10 -0800
In-Reply-To: <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
	 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
	 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf,=
 __u32 type_id)
> > > >         return type_id;
> > > >  }
> > > >
> > > > -__s32 btf__find_by_name(const struct btf *btf, const char *type_na=
me)
> > > > +/*
> > > > + * Find BTF types with matching names within the [left, right] ind=
ex range.
> > > > + * On success, updates *left and *right to the boundaries of the m=
atching range
> > > > + * and returns the leftmost matching index.
> > > > + */
> > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, =
const char *name,
> > > > +                                               __s32 *left, __s32 =
*right)
> > >
> > > I thought we discussed this, why do you need "right"? Two binary
> > > searches where one would do just fine.
> >
> > I think the idea is that there would be less strcmp's if there is a
> > long sequence of items with identical names.
>
> Sure, it's a tradeoff. But how long is the set of duplicate name
> entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> with high likelihood will take more comparisons.

$ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sort | un=
iq -c | sort -k1nr | head
  51737 '(anon)'
    277 'bpf_kfunc'
      4 'long
      3 'perf_aux_event'
      3 'workspace'
      2 'ata_acpi_gtm'
      2 'avc_cache_stats'
      2 'bh_accounting'
      2 'bp_cpuinfo'
      2 'bpf_fastcall'

'bpf_kfunc' is probably for decl_tags.
So I agree with you regarding the second binary search, it is not
necessary.  But skipping all anonymous types (and thus having to
maintain nr_sorted_types) might be useful, on each search two
iterations would be wasted to skip those.

