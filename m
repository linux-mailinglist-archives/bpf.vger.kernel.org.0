Return-Path: <bpf+bounces-42609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8A9A6787
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B111F226A2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF21EABDD;
	Mon, 21 Oct 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENifHDuC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66A1E7677;
	Mon, 21 Oct 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512297; cv=none; b=Lexoks2kj7AR+iJz+gRVCXr6JRNibIhE7oZa9GQR0R+xW2GeDTDwEQF+tbyfIrVID9cL+FyNMvUW9ghOUqPbvsZC8I1oHTBiBmCV6lq4c1GfYCDc6/0yP+DLQyMsittF97iCY5dhY4R5crsBAqwr2+lnNc33OjmCNC61ZeeQhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512297; c=relaxed/simple;
	bh=PW+3diJ4pRiPVR1qpZLntdXib++X/EHvjrDncNf4l00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9WAyyjncWRvZkUb8OG39sJki+OWlmWd+9g0noqaDv9lDhcNTDjvLgx1QMvwsh5RBski4l4KOTPp7yOy1tgROioEHxdsuYoZkg1xmb/nJYX7oXIcjwq0BJVKYmLuAuHe43Tdy2PwoM893z629OsMfRRqntKCUV/oeryryAM3d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENifHDuC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbce9e4598so26436856d6.2;
        Mon, 21 Oct 2024 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512295; x=1730117095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Trwc8ZxRfLUos5ROh0Aw8LjBkdhyf7Np4u6v5DWo6j4=;
        b=ENifHDuCtKWP/eeAkZj5muCNJHktQL8wxI593nkFTY+kXjJ4wsSJkHVuShCiT49v6J
         Z8rcD2Lo1LDlBB0bMnhxGL+j7XyhbGNiMW/+96bU2x04JFJ37g0dG9wZtP48lSy86xbY
         +C5ngBhjBPfCZ9YfQvndM3VW8bcCyHrPNaGDRZemBmVxsNvs8aAp1L594rnqVbrFQXus
         9KGQFIcfpdsrYMTqqIMsQu9pgV9e23w/rIKcpkGqz8TSnJkpOCkaLK/vg7y6I3HmY7lC
         URNjrnsUL4B1q2tT3HXZOJ2ZYDNTGwbect6xWFBuv8e3iDVO0+Qg4gwUoTnjwS0evwQl
         HAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512295; x=1730117095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Trwc8ZxRfLUos5ROh0Aw8LjBkdhyf7Np4u6v5DWo6j4=;
        b=EFMpcVMvrDlaZglNIuXZZgspZM48Ybhb6EjJL4Lkpf4hWyz9jy2QE1/SOOHlGf1JX7
         owQUKkvJ1gDxKcs5hbmBTe+GVrv4ts60V8akKOZOEwJwI4aI+6NdFuzOYosYrl1wJh8m
         2lnhxBwn+rojt357hG57b8v6Td98HhEsFqPlxx0K1Ok/slsowx39yhIZsekohQYi4rOb
         yoyd3rMitDUFR+z5LQJW6CJwxMUSG/CJwP77Sx2X8F4m4veeZ1bYEy0rb0RgAIKEzmwr
         6YCmCh3e3MCB+BzrzGTjivH6Uh6Wx7H993oYJLLVV4BQCEp5n7tdAMOe01FcO220Zqda
         HaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETkc9tnDuk+9EMbomyAc1jk0nG+27VF2yEYBTMJwUR3W6u5jOdzzG5zE2O3yG8h+czvX+pnt2@vger.kernel.org, AJvYcCX+mBw/U4gHTcDl4pYg69rlQ/vboaVuuPNfhQnzflGv8Mu2YpHzokZGP0cLCJlyOKpnFSyeyOxDcB50akpx@vger.kernel.org, AJvYcCX4undm8NoKxhVp9zsL6MtnCH1BX06FFqbCdKyjJTIiV57/LYggpQpwKCCm2oGVhJ+N0NREgVhcWa+2@vger.kernel.org, AJvYcCXsUrdCiSXL4B2cMaH1kIGo6gd0SiyFH9Ya3BtvWE0Zt9uRyMaIVVuMpw3cvkI9PHKZkdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvRxhL7OA2ME9TFw/CzIo2184j3ZMfouzBwBNszqfuz7nHPxJ
	q5aeMuzkCRHsWq7oeEDD4Me4YYQp6UEb79EtmV7eHixThDQXZhbTZzyvJDAjtqkumYMQet/th/9
	uPx9qeeooIJskNCRBV9R//qctc1I=
X-Google-Smtp-Source: AGHT+IE+2A+2GtLwpn5vTpkyyLklTLFCJaFPXBnb9GHSF70FZ1PogmV+ZpXiADUYMFP6yMXIDElgCBpPCnzunP/snnY=
X-Received: by 2002:a05:6214:33c2:b0:6cd:3a48:5767 with SMTP id
 6a1803df08f44-6cde151b8e9mr190999206d6.18.1729512294672; Mon, 21 Oct 2024
 05:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018091502.411513-1-tianmuyang@huawei.com>
 <ZxKPXdYjwPnpq95V@mini-arch> <67156d3447444_14e182944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <67156d3447444_14e182944b@willemb.c.googlers.com.notmuch>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 21 Oct 2024 14:04:43 +0200
Message-ID: <CAJ8uoz0FcDP_ox_sRbG7ZJ=F70uJsALF-fGzW6snTQPXez_PXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] XDP metadata: Rx checksum/GSO hint; Tx
 GSO offload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Muyang Tian <tianmuyang@huawei.com>, bpf@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yanan@huawei.com, 
	xiesongyang@huawei.com, wuchangye@huawei.com, liuxin350@huawei.com, 
	zhangmingyi5@huawei.com, liwei883@huawei.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Oct 2024 at 22:51, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Stanislav Fomichev wrote:
> > On 10/18, Muyang Tian wrote:
> > > This series introduce XDP metadata functionality, including Rx checksum/GSO hint
> > > and Tx GSO offload. This is aimed to transfer control fields when processing jumbo
> > > frames between VMs.
> >
> > Ideally, the series should also have the implementation of these hints
> > for a couple of devices and appropriate selftest updates to exercise
> > them.
>
> +1

Larysa had one implementation for ice [0]. Ask her if she can update
and contribute that one. Then add one yourself and there are two
implementations which would hopefully make the case.

[0] https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/

> > For GSO, CC Willem going forward (I don't think I understand why
> > we want to have gso_type in the TX hint; something like header_len
> > seems like a better fit).
>
> GSO on Tx makes sense. To be able to program hardware USO, say.
>
> GSO on Rx is less obvious. Is this for HW-GRO? In general, some usage
> context will be helpful.
>
> Two implementation questions:
>
> - why define an XDP specific type for checksum types, but reuse the
>   netdev type for gso_type?
> - why u32 gso_type, when it is a u8 in skb_shared_info?
>
> > Please also don't post v3 yet and allow at least a week for the initial
> > reviewers to catch up..
>
>
>

