Return-Path: <bpf+bounces-36123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD219942904
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 10:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E69B2833ED
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3111A76DB;
	Wed, 31 Jul 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR++dTOp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3E1A76CA
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413906; cv=none; b=C6PoOO+hA0anWbFfzTEwkIWW5Ehq77rIvNYFdDFxSqvXabHNm+UFiQflBWp/y6QoUx6vaDB3dUJOZUpOYHELj52Vjc1DTDAcuA+zLCEd7+oPVo5LGh1jGFmbJ6RWCMn6jKeflLDzlnjYT8vQ4zgX3kDIlKbYFcrqQ5WAZ9mEBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413906; c=relaxed/simple;
	bh=jjt8RW1C3zttXZb/agapc67rimJnOXPOyl1TUnocd5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLIESZCntaruThXBYAl0PbXZnX5RBu2yyY96FUf0MdDL4CUjnuu482V08rMQwFKkUMU83OgeCqXmYYBky4p7isk8g80SmD956HdxPFWCJwEw2+mgNi+p9Y1n+eNZmFhQWKfIhc80GbwfTrYfJaKmElMe/AP4VVvXx+RkiKkwvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR++dTOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722413904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjt8RW1C3zttXZb/agapc67rimJnOXPOyl1TUnocd5c=;
	b=UR++dTOp0+tA33NCTW90zUaRBJL0SJLFcVTrboJRYeWoDNHOEZB04s/KZ20ydrdF6dGmUA
	zeLsYlJHb+u/hV6xnUl8k2UtpLi4qnei9oOvwLPNhgllBIeWsUgOEpYFrGWnj/cMI92ECR
	QZ9HQBefcJSHSOzWUXJ+RGqX39jot8c=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VQtOa1yVPzuxPlrrKLb50g-1; Wed, 31 Jul 2024 04:18:21 -0400
X-MC-Unique: VQtOa1yVPzuxPlrrKLb50g-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-839d660d069so11379241.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 01:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413901; x=1723018701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjt8RW1C3zttXZb/agapc67rimJnOXPOyl1TUnocd5c=;
        b=rNQMn5VuunotuTnQy8k0dVLkWsin44v54lu809IRL8n26nn/cUOEcQOzNE2Rt5T9iT
         E4LfcE+o6WBJ7LivDls+1lul0agYWP9LN/lohXXktcahDztJw/2nqdV41dvYdnwY9vN/
         VUTBpDRmCu319bfyBEnEvCob1go+D7R3YEbIs7UbEyyIbkRzhp5mS9varQLRMNUvH1nz
         vPqBnA1Nlyyk0LzSPBEZ5J0OPqVva2pTuI4smuWpKEToqk4uZzYMIpBdyq6N5c1PxW4g
         GNJKRcZhbVKEBvD5QZLy9uAjCiejrWIv8Y9mOOWJJOE/CPfdyMcLhAuVF9N0b0zPib8/
         gdzQ==
X-Gm-Message-State: AOJu0Yxh1cKSBSwXNUYsPS1OkPqpYhtn5+DKctnc69FxOqKArxwakz1u
	9HQeggETHCgB26y6Ky7/2xdaFgwZnb7Rsobc+FCVi9+TsBpjksgvX7LuMh81S7bLYUEIhBeCMZi
	Mtz3ot0yUQrKp3hhdf+Kx9feSZOvUB9LczMZtIKaHUdLE4CjWoDTNIfdmTSAEjV+k2v56RpsTT6
	W0HFKsammrc+umMNfpAq3HR9SN
X-Received: by 2002:a05:6102:160c:b0:492:a4f3:34c2 with SMTP id ada2fe7eead31-493d867ab91mr10465376137.5.1722413901337;
        Wed, 31 Jul 2024 01:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUHtdWMkNxVSi+SS4h7rkoUw136eKiROgkUQXRU5My+SazNjmzeBTw/JWPSF6KAB2G5gpaE5jEHSVI5kRi5Rw=
X-Received: by 2002:a05:6102:160c:b0:492:a4f3:34c2 with SMTP id
 ada2fe7eead31-493d867ab91mr10465352137.5.1722413901022; Wed, 31 Jul 2024
 01:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726125958.2853508-1-ming.lei@redhat.com> <d08f9080-3818-4869-8b5f-9292d772963f@linux.dev>
In-Reply-To: <d08f9080-3818-4869-8b5f-9292d772963f@linux.dev>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 31 Jul 2024 16:18:09 +0800
Message-ID: <CAFj5m9KvXQa8VOJ_K2ZF0V2J2-wiwaJb4Df7dzE3ZC3jAGOg8g@mail.gmail.com>
Subject: Re: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and bpf_base_func_proto
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, andrii@kernel.org, 
	drosen@google.com, kuifeng@meta.com, sinquersw@gmail.com, 
	thinker.li@gmail.com, Yonghong Song <yonghong.song@linux.dev>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:07=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/26/24 5:59 AM, Ming Lei wrote:
> > Almost all existed struct_ops users(hid, sched_ext, ...) need the two A=
PIs.
> >
> > In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be bui=
lt
> > as module because the two APIs aren't exported.
>
> The patch looks fine. I don't see "config HID_BPF" can be built as a modu=
le now
> though that could expose this issue. Did I miss something?

Yeah, this patch doesn't try to change HID_BPF yet, and it can be thought
as one struct_ops module prep patch.

The issue itself is observed when I write ublk-bpf since ublk is one module
and struct_ops is allowed to be registered in the module.

Thanks,
Ming


