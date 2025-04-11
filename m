Return-Path: <bpf+bounces-55760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC8A86485
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D306B4A7142
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4F22539E;
	Fri, 11 Apr 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNs6XKYk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C66221FB4;
	Fri, 11 Apr 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391888; cv=none; b=rchqkazLXPaXmSZv1OjGJf749HGjs/8e+v7uIdn04wMmOCb7AqFpuZ0JlLf4dwqywjrEZR+yMCMhKw/auFNoeYPOUhUVmqQ4SKhHNqTX/gUOfORucUIoOXBsg4XkrvTZAdKekFEmPLJoIr83E8zo2A4SNSIfq2FuZuHn+BuCLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391888; c=relaxed/simple;
	bh=6UlRDRJrlP7vv27UhAeTzCJHn8CS/choQVGXWsIwd7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3dtfGQrsfSWGn0DWRGSMgoh2FBQc9trTTbuZuNEUdavHY+/iwZysNZubZW86kuzyizzwiJC9eaD8yA7L9bI1UKrDnm4vjRMhKJbgBViccV1gWL6y3fNqfr8Ca64sIss0htX2M49pj+3sal5hgk/wWiD0EO3nDD42IuvY2oTSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNs6XKYk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff27ad48beso22475127b3.0;
        Fri, 11 Apr 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391884; x=1744996684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWE8uSph/hLyagXN4EmgehNAvxhiUm0W5BjpuuXlpU8=;
        b=aNs6XKYkcPMxY6pAIiOvdKgKrL3PDyUJxtBJro9QfAlHCBq+IpihZIDJh0EhBsrh3N
         OLE9ok9IJFo3dYAeXu0gDBbo4kYN2Nhqtj+BzRRsZ7wWNp40ZgovYYoAwl/tiXhqQyns
         oBaCQp/BmUfhUYUaNo/SpiS4QeGAmHpNtcR4o1sYwJdU8omip4soROaJjy0tu+9JfNSt
         JNQjkNyA0WktrwhjCfqknWjdvpK8bm+3aHzMbplgCS7Qr6VjuQ4hvzgIVQED5owaHRRf
         DzvYIkwJ9CUsPkJlhQZHLQG+119XOI1c6Lh1Z0okTwQTht7VDoc7LDai2jLQ8B3p586r
         LHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391884; x=1744996684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWE8uSph/hLyagXN4EmgehNAvxhiUm0W5BjpuuXlpU8=;
        b=E/KGtYvvorOsfcUASxs2VmBqD2osWQ0cT3xVR/UwxSIvfAvXnoY7NnFG7bCa8KwC3T
         +HMF//QXAbtKlol/zU2ZpGvxx5a1aI24+0Oy6k3Ohx2mS2Jd2OzBf8g+q4zEExZvkaD0
         P1ob9T16g4hvWmeRCGZoOZ/TBHy7GUDR0e6uKsWD89po5IdEIcbgUZw5SViMCPPWUFu6
         GXd6XS7V4TY17LhZg8kKUHdY4UNwUadGwmZABozAY/vMDUyiIxhlAXnL3wJZAlR9b8e9
         /LS+JWvu7ox+EkbKuI3TGwhGS1Chc5lPgOfS1BJ3dJvVb4jQSpc/P1OSukW+mHwhZxHA
         GZXA==
X-Forwarded-Encrypted: i=1; AJvYcCURwRFrsV7v+mYQKhyCULxC/03+w4Nnpx21bpYsVdz9/fWbK+bS5+xB+TqFYKWWrJEI3L+i5zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oijOVcAKhehUmxiZfCZzS+430gAD55s2FlgTYkP6Tlt3G8O4
	2pg2hDiucy0oRDu8HOQ55zyrqKulzdZqxbd8JJvqZcyBPesIxqdZDFakIOrvXZLZyeUiYrKt6Cf
	zRA9gK2W65+WsOJrNlL4V7u5CuKA=
X-Gm-Gg: ASbGncsjBoWzIGfppl8NnQh61z09qMer1qgOXcg7cs7y7YKPXu3YdQQSY8+OwIkH2ac
	DL7D+LNVI+qi+r+fZPTzfwD4/DIoQq8wSyb/0a+SaqRm9F5CPQZMKmC07qh+YyG1bQfaxM9+DN/
	zPQm9N0UD9s9SpdLKvQZYP8av0lu6ybEpF
X-Google-Smtp-Source: AGHT+IE4DfiNHfz00aOTTIHxB9ELS+9+HBNrF0Ba/9hwmQkwAo5GFC0x0nwenX7YASeZrfwnOLUquS4tLasEtDRGnUk=
X-Received: by 2002:a05:690c:4b04:b0:703:ac44:d37e with SMTP id
 00721157ae682-70559ab7119mr62430697b3.37.1744391884173; Fri, 11 Apr 2025
 10:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
 <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com> <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
In-Reply-To: <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Apr 2025 10:17:52 -0700
X-Gm-Features: ATxdqUEtlz0BT6QtACimtlSHZ_8J2ilVs0mOrmkc8o6ripKedK91met1gDiG17I
Message-ID: <CAMB2axNbnOoHu6jdkt-59W6p59NjmO580kUw_g45rWG2TAH5mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:08=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 11 Apr 2025 at 18:59, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Fri, Apr 11, 2025 at 6:32=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
> > > >
> > > > From: Amery Hung <amery.hung@bytedance.com>
> > > >
> > > > Add basic kfuncs for working on skb in qdisc.
> > > >
> > > > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to releas=
e
> > > > a reference to an skb. However, bpf_qdisc_skb_drop() can only be ca=
lled
> > > > in .enqueue where a to_free skb list is available from kernel to de=
fer
> > > > the release. bpf_kfree_skb() should be used elsewhere. It is also u=
sed
> > > > in bpf_obj_free_fields() when cleaning up skb in maps and collectio=
ns.
> > > >
> > > > bpf_skb_get_hash() returns the flow hash of an skb, which can be us=
ed
> > > > to build flow-based queueing algorithms.
> > > >
> > > > Finally, allow users to create read-only dynptr via bpf_dynptr_from=
_skb().
> > > >
> > > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > > ---
> > >
> > > How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
> > >
> >
> > Good question...
> >
> > Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
> > the ref_obj_id of the object underlying a dynptr?
> >
> > Then, in release_reference(), in addition to finding ref_obj_id in
> > registers, verifier will also search stack slots and invalidate all
> > dynptrs with the ref_obj_id.
> >
> > Does this sound like a feasible solution?
>
> Yes, though I talked with Andrii and he has better ideas for doing
> this generically, but for now I think we can make this fix as a
> stopgap.

Sounds good. Just making sure I am not doing redundant work, you will
send the fix you made, right?

Thanks,
Amery

> I will add a fixes tag, asked the question because I had the same
> question when implementing a similar pattern for my patch, and was
> wondering how you solved it.
>
> I made a similar fix to what you described for now.
>
> >
> > > >  [...]

