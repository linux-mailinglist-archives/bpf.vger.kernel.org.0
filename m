Return-Path: <bpf+bounces-41938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A199DBE4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4CFB21180
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE8157A48;
	Tue, 15 Oct 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTdChXZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE71E4A9;
	Tue, 15 Oct 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957065; cv=none; b=WAoYBHKd3EHd2O1SNWV+iAs+DGAyIVxSBZLL6TC63R4ohrhieEqNG/SwIUFU7Kimk5YT2nu2xWKmf+u8uo6UiH6kJXI6RRJ1egIJLcJGvmbE9yO82Rf7PN0yPdwzePfCED34eucBDmsK1peO5q4vebCKQ8VAi/KG2LLtDvSUkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957065; c=relaxed/simple;
	bh=JptUsGQn1X96pZba2aePmXLC1DvNWSwXDivN30vMMQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDtpdy5LoUA6DxprdQr4UVxdQM5x/eCF5+ZQHvYsKoTcolcRtJGEXeHriGza7kalhDOPKEKrhCyXK6BMnIY+TSxd+TN3nrnLeCDAMGqsluyPnLOZMD0UmxFKiogaLDlhZip2wNdOo3DNwdpNpbunwoEuA6g0WIdr0u32OjLWXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTdChXZY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3593068e87.2;
        Mon, 14 Oct 2024 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957062; x=1729561862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Gfy097cBATSbI9NhMC35aEt2ved6+GUP+8QGcOcPM=;
        b=mTdChXZY7qbcRCtNdE4Blhii1Jx/jpyLzKpkZGzeFTjsyr2+vbbxR4FEm5015fgVrs
         6aktp+DJD2hgXZIB1Kjn/451HABqNygR4x5jASaxTgpg6HaASves37og2sI0SQLNnZuZ
         BdU8APfolP+ZwIOX/ZzsKdmoXP41wdGh8JU792OaWW91ofFY20s96fXgfrexngZ7HbZG
         yfBQ+3jBb4abSW8riVxjGldormdX/TiDVSKRyZ8znb0LVll9pPWo3gzEk3s+0snQQSgN
         CgrUqcASSkKNSDfH8cjuuWATPGZxWIR49asnTDudwAlvz0AhansI9UFp5n8GZQIjhkn8
         l13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957062; x=1729561862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02Gfy097cBATSbI9NhMC35aEt2ved6+GUP+8QGcOcPM=;
        b=S0B7BYStGtzFwAS7O+vL0GW/OH5glHEC25lqKk/K7WsOx/mwsPEXLH5rt14t5WRf4m
         rjMCeS5pirJiOIQyBoMbnP9p8QJCOjtWUMbYQwvwQ5MT3kvoPXuRwgT25R1pCl1YHAeX
         1UxZ/alspKS/EnibVfumQDrxly0ak+RmCYoELQ7kz0E0D6lJcFT7KSWfJPANEW7tZFFs
         7D1Me3poNlEMd3MktmmCLWEJaM8LyKgcaQax0GcsS9QHf7LdiZ61lhPMeL5imW8bH9Xd
         SfqUD8HP75m3Vzv7A3Utrs+eQHqSw6az/emWZQ08YoK6dumzlJ3uDQc76ZpJ54+BC5c5
         9vSg==
X-Forwarded-Encrypted: i=1; AJvYcCX6MBi5JlR9tf/lSiZiYIQW2FAVsAPDdQTiJ5yAhmUT3eTMpAojUKLJkJBNBfe/1iujmKs=@vger.kernel.org, AJvYcCX9GT3XNR/7mGEv89VSF2pRDOGOTqihhAMX/jW1w6hBLnnT2xUR8mbtJH7bvoi6vZEN9ZIu9IGvHPqMR+Mo@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeIcx3VmZqF0kk6V3xPgT6qZXth8zV82KWYrOIoWh4260t4xb
	MMGZ3VR82cXdGKThf8ZGkUuZR4oR18OWdfqXDv8Q3816rn4qp7thyybkoC9fSPPQtnn+y+kp57C
	ENRon/he4ugcK6KjUXuAHtCEs2bjJOg==
X-Google-Smtp-Source: AGHT+IFNXDz7XtpoW0u02EyF1k2FMQR2obG+2kYi5v28p6msYznYvNymTlqU8wsKSjpTOIbKtZSnIrHv60wbcmMsBEI=
X-Received: by 2002:ac2:4e10:0:b0:536:9ef0:d829 with SMTP id
 2adb3069b0e04-539da565caamr6568571e87.44.1728957061435; Mon, 14 Oct 2024
 18:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
 <Zwl5BkB-SawgQ9KY@google.com> <Zw1fN1WqjvoCeT_s@google.com>
In-Reply-To: <Zw1fN1WqjvoCeT_s@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Oct 2024 18:50:49 -0700
Message-ID: <CAADnVQJ2M953da8_gnGgWR9x6_-ztqFO8xvRU=bKcwmsH4ewvg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
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
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:13=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Alexei,
>
> On Fri, Oct 11, 2024 at 12:14:14PM -0700, Namhyung Kim wrote:
> > On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > virtual address like virt_to_cache().  If the address is a pointer
> > > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > NULL is returned.
> > > >
> > > > It doesn't grab a reference count of the kmem_cache so the caller i=
s
> > > > responsible to manage the access.  The returned point is marked as
> > > > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab obje=
ct
> > > > might be protected by RCU.
> > >
> > > ...
> > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> > >
> > > This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any m=
emory.
> > > In this case it likely points to a valid kmem_cache, but
> > > the verifier will guard all accesses with probe_read anyway.
> > >
> > > I can remove this flag while applying.
> >
> > Ok, I'd be happy if you would remove it.
>
> You will need to update the bpf_rcu_read_lock/unlock() in the test code
> (patch 3).  I can send v6 with that and Vlastimil's Ack if you want.

Fixed all that while applying.

Could you please follow up with an open-coded iterator version
of the same slab iterator ?
So that progs can iterate slabs as a normal for/while loop ?

