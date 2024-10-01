Return-Path: <bpf+bounces-40705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D398C543
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF00C1C21149
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E91CCB3D;
	Tue,  1 Oct 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmMxflqa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B31CC8B0;
	Tue,  1 Oct 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807041; cv=none; b=W8dXU3mRCdtr2ovMN91Ix/VAwn56o7tvgxRZVLyhJUHMTbCHVzrsLJ37pd1n3SeNDn5JFKhQJRIbgma19y2ng6q3njmgLJ3mv1OSyI4Pz/Oglj6dfwKn4raqSfbkKbssyr5eJ6UUtSYKGFeoKmPFMD4gy5IruiCAXz+G66tHkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807041; c=relaxed/simple;
	bh=C5eocxoLUMK6PceD96lBkFRjuGLA+G9VjBRARW8yl5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIPFfJgWg44jbhavOZmiUpyCqtHjDzs9lNjkknlAru9zatQtxgZrwF67xaVIBeKbAzA4vkfzu7RTB7GfM+h6OULer7SQm5PA5cCfUU7Zk2U/MF3HJ0t9zbDvKoj0fmqsZo5DwTxrGIX2kGBsomgi8gjCJEdgp6FBKnH88MUc3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmMxflqa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so3118438f8f.0;
        Tue, 01 Oct 2024 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807038; x=1728411838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTJsC/jjbWXRTy4pFRi9rzEWRfHyfbOwWhON0f8hVj0=;
        b=VmMxflqa+mBl+JTiJvQJs8MfV4US74fayx/4ZOkRy3TaFN91AkSDzsnDsr32I6L77H
         FR54lWZUJb/9oGJJTmJ7igITw1M9k4LxfRgKqGyrC2u09WtdqtlESDKcXqqCHL4bDr4I
         jxCBTTxArQDnavg4POQ7haXXFRnorHHEdWWApaVJJj4yXBn9mAMW+KFzWw5FXYyXQtSU
         m1goVaF8W5xgKCZhp/JhgKhu+602XFBknQ4qs6HiRX+mDE2bbW89N3Yugi2amr6ATVkq
         8SzzJDuLeynrwHFa5hzCqhzfuQ1a0AorDMrZ9zHYkBKKLD718+GkbOk/ZHWSKA50hlf1
         4FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807038; x=1728411838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTJsC/jjbWXRTy4pFRi9rzEWRfHyfbOwWhON0f8hVj0=;
        b=e4JWjjKYjLvMKJRKh8eIH/RqEG6/tKCF/rBkim4Ey+T5TvhhiGPwAakcqz4TEN1YFK
         wx+vV2tZK/oEhPXgWULLX78rfgS5ZTi3V1FiQpp3hNtc9sS+6+ZeRopSsMwoXrB89mSs
         boRJcB8ClevgSkdJsyCRs9WVDMuBQxeXvpeOOmCfb7am7bWO/dhnTreH3u3nBqg2yaU0
         ZSxR74FD9gdl0Z+r8S4KgxnaKPuc5Sb/HE0k1GXzQX1kG6oNQaQAiHylDSVIixWjhxNf
         +L3j23yT6rA6P2WhrBuqEqASFqucXj/dax7cxcSCzWRjSq9p2//sWm+8MWpBzZ+HW7T3
         ssLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xlb1fJcpRag7LMnF9xi5OnNAV0TkEz6ZKDT/qdk70M7pJe16PK1aDYu+ezQkmNz/wvSLNxHnxzGOUOMx@vger.kernel.org, AJvYcCXpIo4lU2c2wOfyZr9uhTSbdhyeMGHV4sESZj914nzq7VgfOqAs/i1fjyvgkNtYA86r1Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/VEigXSoJlE6ds2ccRqxxpl/RGYurrOMva/qX7B3NvHZssYB
	yJDv4WAZNpYfpS9d/96vlJITiaLj/c4AT2rEJHvD95gBHk5EOHBl1j4Kwi7JQr26faNRwAGXR0D
	TcWKf2JPNLeUKGkeVxq4pQn9O4xE=
X-Google-Smtp-Source: AGHT+IES6bl8TMEHdHakiAr1aiBS/Qo6yFrZL6Y/S7x1GcCWBFK4WcFj4ZIEdTixP1udWTCGLDhFDmuqnbfmXhu5TIA=
X-Received: by 2002:adf:e450:0:b0:371:8ca4:1b76 with SMTP id
 ffacd0b85a97d-37cfb8c84d1mr266108f8f.32.1727807037618; Tue, 01 Oct 2024
 11:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org> <20240927184133.968283-2-namhyung@kernel.org>
 <CAADnVQJBKCHJKqjNe9AHEnSbvAZ5Jf_0ULw=v7v3BEW8Pv=_6w@mail.gmail.com> <ZvoIIoxQvL7sHy__@google.com>
In-Reply-To: <ZvoIIoxQvL7sHy__@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 11:23:46 -0700
Message-ID: <CAADnVQKXC_xA3UrqvckS9SSs=jtyHjfb50znOON98XqinkZ2VA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 7:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Sep 29, 2024 at 10:04:00AM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 27, 2024 at 11:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t =
*pos)
> > > +{
> > > +       loff_t cnt =3D 0;
> > > +       struct kmem_cache *s =3D NULL;
> > > +
> > > +       mutex_lock(&slab_mutex);
> >
> > It would be better to find a way to iterate slabs without holding
> > the mutex for the duration of the loop.
> > Maybe use refcnt to hold the kmem_cache while bpf prog is looking at it=
?
>
> Do you mean that you want to not hold slab_mutex while BPF program is
> running?

yes.

> Maybe we can allocates an arary of pointers to the slab cahe
> (with refcounts) at the beginning and iterate them instead.  And call
> kmem_cache_destroy() for each entry at the end.  Is it ok to you?

That doesn't sound efficient.
Just grab a refcnt on kmem_cache before running the prog ?
Drop refcnt, and grab a mutex again to do a next step.
kmem_cache_iter_seq_next() will be running with mutex held, of course.

