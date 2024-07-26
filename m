Return-Path: <bpf+bounces-35722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC993D293
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3992AB2137E
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618017A5A1;
	Fri, 26 Jul 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJboymkP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EA36D
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994791; cv=none; b=S9RDsTKc5HX+8IpsWZ7lrStKndbFUlnu8OcyDoUcP0afIYe3dJNsMbUFULzpuIrNzaqDte2wIkN/BT/XU/BrPWGXgApoXVi7w1Elj10OSlyYOrd+SCpTboBcWePXkelrQ92+/WbwfY4FT4mWvonWG/j7RcurgKpJ89NrLfXlng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994791; c=relaxed/simple;
	bh=NqauyIiD9frFU2q2dow92NTKRN2xp9jQA1kClDRcZ+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0sh6mjxYlVb8qGJAhIAPHEk9/CUUy39zt8dcQCo6p3ZMOq59qdeWAE8XI1+RvmaT/h9wU4eYuIkUCga0bCdyxUK6y7vR1bsTHAOrXaWcuvU/XKM+lWjAeyEKTGnPifoncKrOeXX6OgQzZ3QmkEew0j3107cd1jJaEaSN5UmmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJboymkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721994788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMoKDeEDNON1uZt1hZJRvGgJhtJ4e5vo5vofm84NcgU=;
	b=VJboymkPjj71J20CBoGmnvvVAVg6ucvpUQC03VkEMOwc0u6e7miHOb84SVZwm8GH0yxeiS
	xLf8dgdHRUKeGZlGumBIF3kYrprXCIHjiQDqfgN+ywGUIvtdqyCrGiL2VHqgdhs50FqyXi
	kGdaar3wtbwZVGqXxW+hWURdEX76T8E=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-VG0T3atKNOCih0PUsYZAbQ-1; Fri, 26 Jul 2024 07:53:07 -0400
X-MC-Unique: VG0T3atKNOCih0PUsYZAbQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4f52c0c90eeso14872e0c.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 04:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721994787; x=1722599587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMoKDeEDNON1uZt1hZJRvGgJhtJ4e5vo5vofm84NcgU=;
        b=KQs0tdu/1F8vvlWKE/dNvg2KgqStDLWCsOXaULz1Q5T5wtIbzvAwlwZC+pMkMoC7/y
         25/2w3lZsgZ57X6rB91aJ9DwAxXRxtnyfFqv5L5nKgz4f3ikIUJ9WckggeSLOXZRURzi
         ZDUd2iCujCFCkOMsZzXb9HnUMnw00r6/UH/mEa0i+UJ9iBgf7xJNA1SdKNfPnHYMcfRg
         hHgvBoRC5XUtpRBRFM8WI9zvxLDFE7LOtNnHXaYBg6uYOlkv9abqxLQFxlmULX2RP5+j
         9o7ioovnzP+BWAE3smkdolQTCl5swNM50pU9hyJBWMnZreXJJ9+FLNTuEsjs8231n8eO
         wWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA3Kf57bMH7i8xjVolMLiHDjmrD+j1bHuyTBr0etMMqvH1zJm8/zJklSK/Dg+tnr9BS0kgH0QOja0PHQxng+Wut0Fr
X-Gm-Message-State: AOJu0YwrnK7e3X6dUC3yuR8yf7Nq3R3DlW+KFSdu3lDQdZeyyMHkA4R7
	6KJgui0X8rsB2WiJ8eBm01OFa4/AL5ymNWJIWJwNOc5b3d+FZlsUxxyLvsGe/+GEQ/Pd4watZ/X
	9cVogCeXgf1o/Af3VbDPW9/vAbieXrmghowPM34B7Q32iSR8lILoTuu/D+ADm15fJa5N/tjEyg3
	bIE7UZPN51njXueO8tuDGJPxxm
X-Received: by 2002:a05:6122:1805:b0:4f6:c493:b911 with SMTP id 71dfb90a1353d-4f6c815ed33mr3828271e0c.0.1721994786796;
        Fri, 26 Jul 2024 04:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/rUnrJiyIyZS7wJ4MUGY5C00FEdWeyaXTHFlhMai0SJoXCOqgPOXik+Mhog52SEqJ8PmbjOc7ipcPczZ1Nw=
X-Received: by 2002:a05:6122:1805:b0:4f6:c493:b911 with SMTP id
 71dfb90a1353d-4f6c815ed33mr3828262e0c.0.1721994786440; Fri, 26 Jul 2024
 04:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724031930.2606568-1-ming.lei@redhat.com> <5be6678d-d310-4961-a57c-45b311879017@gmail.com>
 <ZqDFzmDfHN1igZVp@fedora> <887f510b-161f-401c-8744-2504a4c135c3@linux.dev>
 <CAFj5m9KMvObO1KP+TdxBdE5psnDKv4RaAUOCjOAXJ0gSpB22Hg@mail.gmail.com> <a529d615-1cb5-4d5a-a78e-06e71676fc5f@linux.dev>
In-Reply-To: <a529d615-1cb5-4d5a-a78e-06e71676fc5f@linux.dev>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 26 Jul 2024 19:52:55 +0800
Message-ID: <CAFj5m9LE3eg01WrxR08mB7N9bcCxvKS3e_hWETkkKYsVyafNUA@mail.gmail.com>
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com, 
	kuifeng@meta.com, thinker.li@gmail.com, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:40=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 7/25/24 8:45 PM, Ming Lei wrote:
> > On Fri, Jul 26, 2024 at 11:21=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> On 7/24/24 2:13 AM, Ming Lei wrote:
> >>> On Tue, Jul 23, 2024 at 09:43:12PM -0700, Kui-Feng Lee wrote:
> >>>> On 7/23/24 20:19, Ming Lei wrote:
> >>>>> Export btf_find_by_name_kind and bpf_base_func_proto, so that kerne=
l
> >>>>> module can use them.
> >>>>>
> >>>>> Almost all existed struct_ops users(hid, sched_ext, ...) need the t=
wo APIs.
> >>>>>
> >>>>> Without this change, hid-bpf can't be built as module.
> >>>> Could you give me more context?
> >>>> Give me a link of an example code or something?
> >>>> Or explain the use case?
> >>> The merged patchset "Registrating struct_ops types from modules" is
> >>> trying to allow module to register struct_ops, which often needs
> >>> bpf_base_func_proto()(for allowing generic helpers available in
> >>> prog) and btf_find_by_name_kind() (for implementing .btf_struct_acces=
s).
> >>>
> >>> One example is hid-bpf, which is a driver and supposed to build as mo=
dule,
> >>> but it can't be done because the two APIs aren't exported.
> >> Could you give more specific examples about where these two APIs are
> >> used in hid-bpf?
> > Sure, hid-bpf struct_ops has been merged to linus tree already.
> >
> > However, it can't be built as module because the two APIs aren't export=
ed:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/hid/bpf/hid_bpf_struct_ops.c
>
> Okay, From the above hid_bpf_struct_ops.c, I do see bpf_base_func_proto()=
 and
> btf_find_by_name_kind() are used.
>
> Your change looks good to me. Please add more details in the commit messa=
ge and resubmit.
> Your subject
>     [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
> please change to
>     [PATCH bpf-next] bpf: export btf_find_by_name_kind and bpf_base_func_=
proto
>
> The above 'bpf-next' ensures CI to test your patch.

OK, I will follow the above and post v2, and  thanks for the review!


