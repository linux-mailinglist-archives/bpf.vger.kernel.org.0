Return-Path: <bpf+bounces-60821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC046ADD10D
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801371642B6
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12D2E8890;
	Tue, 17 Jun 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alVnK/PX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3634A1CDA2E
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173014; cv=none; b=u+4w7puTCIHNNHBuXIidRAgTfxWSJS3fWZxaxztPnv1yhEbicIBHmzLrdVVbiZe+AVgMgdTkhxRvqOvW73a3ECcnGSC7QkLnqmPzzi/2GJrJ+z++5MjsRX/ERirJOW4S/dyzytGjIYfcWoInYffeDfEyle51O37OWsyR37RmZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173014; c=relaxed/simple;
	bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIADzUwDHC6mK5VtpJ410G/ddWJLBAAEIcFBg4U0mf04npLztp9IO8NgYZn/1VTIWr+ntw9huNkiUzEW6mZipqPL6W1E+GEsahLss8hjNeIeHuSHm8ufvL/sqESQzNcVnCWVWd08W/j3NU6gmh4ufbZTjBOAXAhtN/r4T+EC9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alVnK/PX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
	b=alVnK/PXn8ufbdCRMilY26AI9OCRh94BaCt+1o+aS4WEefsJoTyXr3lYzU1wX2Z5BbyVEX
	cLzW7/4mbqPpInD3J7O7x2c5Bzy2cGAV26WP5IlkTFTOBz0N7XH4kJ/EM+8Gc/as2c3Q1A
	gtQckuwgJ3h2Hym31zGdhJ1u+Hqsj6o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-1xETEmaSMZGWWwYyoSLlHA-1; Tue, 17 Jun 2025 11:10:09 -0400
X-MC-Unique: 1xETEmaSMZGWWwYyoSLlHA-1
X-Mimecast-MFC-AGG-ID: 1xETEmaSMZGWWwYyoSLlHA_1750173008
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade32b5771bso73108866b.0
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 08:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173008; x=1750777808;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
        b=rz1mEH+G8X4NmMsfKSrTHWqyJOpFqA0nGaD7Gu8ED3dwp6W0t1CelVI94GNOG1nQt6
         PezpIfALBpbZ5DNZLCUoB3+dSdZaoQYYeApVotCbkyj4a9Pd7z+lKP5EBKDWBemhb/92
         g8Z1otd8DiVh5OOh5r8lgDFyuQLq35xv2dIWV8ru+XHDOIpNJrJVPjcaBrSTgGEj90oh
         50XO9T8sqQ6OyOFItv6+dOdZf0oj+o41d1qjtQ1rGA+c4bfFgs7wD5U/4RVbbTZyWxrm
         hU6TNgONivzQl3rigTMZoaXECrGrs5l6u9QLS2aQ0/tOEAVHYvMK4FS27ZrFFsXIT1XH
         oYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXk95pe4lJNwBwmDcFsGn5yNUmVJblJBunA5UlrbYHBw8WtyOc2B9dKSJ5gqJ3elSbEbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vBRxYg8GB7Jo2n+nFcv6yEMtFzZ6jSpqfHB/6UoXgCuYM5r3
	0gQdKfk29HgZj1oZGY6ipk4dZkaj8zq5lukrdmfDh/BQPqzT3zLiLw+c7D/ZuQh4MGvhb40JWkW
	ckwTcJKhvw8T2jCn1pG+4cwdFepXkvmytoKc2ww7Fibjk2bQx+gGoLw==
X-Gm-Gg: ASbGncsTLdWijYhFZA0sSPbbx/IALWNQRKgaOvprDi9zp0ou9ye8ruRxFgs3J7LpUkm
	1sSXLGRzdvO6HZaXeETiY4u0SGIXcdNy470QGLhDqYL8OIZbonIB9Ow6azwhrS0QcFgIirrQNfR
	CzGywF4PbGn0Inds+9cB0xPgBluYC2+yiWdIY0rAeEnDud0ZzmQ42Y6BWevbaNL0yPp5ApkNSyL
	HpbjOtyaERsy0dKTlM07ey9Tgybo/7w0kjcL36DPYh+xVLBHjWfO95wdhIswdkl6K6Zxg3c3Uv0
	wImn4RsTJ7dikeGk+mo=
X-Received: by 2002:a17:907:2da9:b0:ad9:16c8:9ff4 with SMTP id a640c23a62f3a-adfad2773b1mr1287012666b.11.1750173007747;
        Tue, 17 Jun 2025 08:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHum6NSFVGaMZlyajlBzCyusq5rsMbr/f1X+qSV8BcuCBxgvXcCVTF1LKybETNjy2yXeASF3A==
X-Received: by 2002:a17:907:2da9:b0:ad9:16c8:9ff4 with SMTP id a640c23a62f3a-adfad2773b1mr1287007966b.11.1750173007348;
        Tue, 17 Jun 2025 08:10:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe907sm888000966b.93.2025.06.17.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:10:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 717EE1AF7182; Tue, 17 Jun 2025 17:10:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Performance impact of disabling VLAN offload [was: Re: [PATCH
 bpf-next V1 7/7] net: xdp: update documentation for xdp-rx-metadata.rst]
In-Reply-To: <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
 <87h60e4meo.fsf@toke.dk> <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 17 Jun 2025 17:10:05 +0200
Message-ID: <875xgu4d6a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> Later we will look at using the vlan tag. Today we have disabled HW
> vlan-offloading, because XDP originally didn't support accessing HW vlan
> tags.

Side note (with changed subject to disambiguate): Do you have any data
on the performance impact of disabling VLAN offload that you can share?
I've been sort of wondering whether saving those couple of bytes has any
measurable impact on real workloads (where you end up looking at the
headers anyway, so saving the cache miss doesn't matter so much)?

-Toke


