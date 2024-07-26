Return-Path: <bpf+bounces-35702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2E93CD10
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ADE1F21F5F
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D1B23775;
	Fri, 26 Jul 2024 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsM1bJQ5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE2582
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965534; cv=none; b=NVIOuf763OlAF4g44SirRlLBl8T3nVDITa8CL3PNKiRpeogzBZj9e9lBfWNGe7G5cslsbHoSqFKZDEWEHbiC+FpiUox+meu/3m4bFNWhf3OExvXxlZLrJxUVuep7FsmG36RqH5Xlm2ihyJz1h8XxYnSLSoTBqbPUvyJRWFS1Z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965534; c=relaxed/simple;
	bh=aDEzSW3QEdCjq+w+Ddq2oi2m+6lqCUR40jvA81oYmRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBz/ME82WarXD3QZavwGCoYTNORWFRCwJ9Kvy9wZlL3xVHDGKVY0iQfflS12IuNSL4S298wn68eiVvX/fOrdHvX0z8YfVYGQ+UGqo8g7L/ShqCii/xNTqpuGTVzfQ3dt4wdVD8ShqHgyuu+pCqHMeh2Ox2KPN3wuIkVlZQMTors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsM1bJQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721965531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDEzSW3QEdCjq+w+Ddq2oi2m+6lqCUR40jvA81oYmRk=;
	b=FsM1bJQ5ep/GmKXff9pYGxwq7Byp2nkBgvcDe90MkoTKRozhc31lQQ3pTyiHnerbyTHe/7
	a6DjHWuEyQe9s/O8PEPtS3KIhIt6suBq0yZ8Pa76arOiBORfWJ0eoYbxgv8pRTD05AcnLr
	HGNyM0IThjf6Q2LrEe8QhpSX2U7opHQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Dwc3XSK5NFSEI_vrcT0EhA-1; Thu, 25 Jul 2024 23:45:30 -0400
X-MC-Unique: Dwc3XSK5NFSEI_vrcT0EhA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-492a80ad67cso124844137.1
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721965529; x=1722570329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDEzSW3QEdCjq+w+Ddq2oi2m+6lqCUR40jvA81oYmRk=;
        b=Ogg0JlL3kAlsEJguCe3pJbjp/3rFX0lizdu+dWxm4WHnAe5RFzBJ4ww0MtnIZF9yoY
         1Qjn10yMlbbTeXh+V6bpmFDib9mSrkxC3UvCuyQ7UwORoz+EWk4TCr8UdZVISKlVsQ2e
         t+mtO9UgcpDayQ43+Gn4zEUd8iFbVjN3SdHaG0ApJhZOvhYw3cGj+CFHL5BvxMYsHw9v
         Pg6k7sO8XOXb553aa0Ns8+fNxaZq95we/5DxT74sTBAx4DBOzqzFhPv+C5sd6tuDnSPA
         PDyGCZ1XOqTiCaxptPQxedFpiZ5TTG+vC3xP5AI8eHNPiqE313/P33m4WVYA1YgIBjaA
         vvcw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Xx9zglhUuWwMGq8Efgf7X4K9touA44B/yV5Ew4YASCzoE8WH0l/GsXuoht68jP+6UBEhRXn9BpPWywQDZqhW5G7f
X-Gm-Message-State: AOJu0Ywn5qNwTlaFYVP1VunC/nu/0MVyJBJUHgd0EL4YOKC3d2vk2zx4
	kDuuZB+/GSComanyDpNrLjAGPUP3HOPcdqD9syzIzU5RGiIuhT7dO7g2YpcH2eOW7f49GhKv+1u
	K2IF+8/L61WeRzRp6ED3J9KHd6bXgTN0rapyam5D+b3VZ6VrtAvzoydFFGB1P8tQXet5+Pzkgrl
	cH3Q1XTi87ax0Wz5xX6CHxdCtG
X-Received: by 2002:a05:6122:29cc:b0:4f5:2cae:5121 with SMTP id 71dfb90a1353d-4f6c8120851mr3108534e0c.0.1721965529371;
        Thu, 25 Jul 2024 20:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG70EJga8mfCbDkxrIzL+dM89LemJwyi8xOUoJkc76a6lrpE4xXdIsfCLa0IY5whwJYf951/rR9AkKjVFhJwq8=
X-Received: by 2002:a05:6122:29cc:b0:4f5:2cae:5121 with SMTP id
 71dfb90a1353d-4f6c8120851mr3108515e0c.0.1721965528901; Thu, 25 Jul 2024
 20:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724031930.2606568-1-ming.lei@redhat.com> <5be6678d-d310-4961-a57c-45b311879017@gmail.com>
 <ZqDFzmDfHN1igZVp@fedora> <887f510b-161f-401c-8744-2504a4c135c3@linux.dev>
In-Reply-To: <887f510b-161f-401c-8744-2504a4c135c3@linux.dev>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 26 Jul 2024 11:45:17 +0800
Message-ID: <CAFj5m9KMvObO1KP+TdxBdE5psnDKv4RaAUOCjOAXJ0gSpB22Hg@mail.gmail.com>
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com, 
	kuifeng@meta.com, thinker.li@gmail.com, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 11:21=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 7/24/24 2:13 AM, Ming Lei wrote:
> > On Tue, Jul 23, 2024 at 09:43:12PM -0700, Kui-Feng Lee wrote:
> >>
> >> On 7/23/24 20:19, Ming Lei wrote:
> >>> Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
> >>> module can use them.
> >>>
> >>> Almost all existed struct_ops users(hid, sched_ext, ...) need the two=
 APIs.
> >>>
> >>> Without this change, hid-bpf can't be built as module.
> >> Could you give me more context?
> >> Give me a link of an example code or something?
> >> Or explain the use case?
> > The merged patchset "Registrating struct_ops types from modules" is
> > trying to allow module to register struct_ops, which often needs
> > bpf_base_func_proto()(for allowing generic helpers available in
> > prog) and btf_find_by_name_kind() (for implementing .btf_struct_access)=
.
> >
> > One example is hid-bpf, which is a driver and supposed to build as modu=
le,
> > but it can't be done because the two APIs aren't exported.
>
> Could you give more specific examples about where these two APIs are
> used in hid-bpf?

Sure, hid-bpf struct_ops has been merged to linus tree already.

However, it can't be built as module because the two APIs aren't exported:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/hid/bpf/hid_bpf_struct_ops.c

Thanks,
Ming


