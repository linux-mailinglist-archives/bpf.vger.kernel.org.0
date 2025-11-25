Return-Path: <bpf+bounces-75466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B7C8565C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF5F24E9896
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E063254B8;
	Tue, 25 Nov 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QF8YmHXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95844320CC9
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080640; cv=none; b=CQa+tb9Y/eeel57f6YnwlHdGCRqewjkBFUe1v2cYfuVlDgSIhAYWjxVzrf6uXuJLRjfCCF7vlemWRRgw5xkkTDyIh1GGBzX7jliDVjcN6k3zmPWk5TQpVdi8AgURtrvOKG5Ss/1Xq6ev87aiPPdLP6H3/SOrbu4xzufrMSPiCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080640; c=relaxed/simple;
	bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KM3Dsuxnq/H2giIgvxb77hf/e3je3erQjr4UJiAGbt2sQRKVuV/HzizRyDVc7ORz9ZIiB6MAVRw84XfwscdcvdtPxQmsuCO0ysN4b6YWkhh/XCcYenhscW12cqef+nv4E6AF47jw6V5bLAlyhLDTLWn6Y9tRjwyMGsLDCgw+6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QF8YmHXR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324054so825869666b.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 06:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764080637; x=1764685437; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
        b=QF8YmHXRAWwk0dH6yrLCnzq0GFv49raJy1vcOv1Blu+pbbXsfK/mgDx5z2QWsgBl6k
         7nfVdrhbGI/gH0u7iXWIFqb/WiwIrnJb5vcqLtrMKmWc4m694J2scWRECp8hgtwdmIet
         HpfkMusoKmG109uW7Ftg00rMvp6ZQaKhO7ithytjblJClmjtLIL7KF3yfZfOltHOgPAd
         eGgHFiIIat2/xdCdv7nkW1b6+YcHjHrc5llZYzanDfQtWmJC/QzVoNsuaydkdt2xgMQD
         Q4PQ/Syg9HAwRpFEBsAhSOiy69SVJTbBhNDx2IN0pBy5ndDUEAeK5uk+eHgEMVbYLY17
         9PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080637; x=1764685437;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LqfH0zJp1SrXC9x7HOD/hDkEmKu/xLJPb3kSuBSxAE=;
        b=VYf3NcRMHiR3Wbrcum6FmHNr0H9M2FREZKyXLi5HjV7OGE/JTWBQL3CKzIRJLYtpQ5
         k6v07yDeGWwSSWCfOKBUjSFiobCzvyk9nZuirDFCf4ZCgeislkFogugfGmoeAOFc8TyF
         rr+TWuJNTxlH2fO6T/EnEBOsjE0IkyWm6Msp6CnACbwUsqmF2stlufohxnENhum+xuwc
         B9GvVtmAtysuxhN7YohQaWYmXJg1MxpX88rRTx92MOggpOpQij/wccQ1cljHkC7s/6CC
         8eeUE6onODiDjjB3L3qLO2nIEmMBQHlPCtHr6Lv4lb6j9kKnC4T0tKYNAl1DoAD4uuiy
         JqNg==
X-Gm-Message-State: AOJu0Yx/vvVLQJrV10/1zq+QtQ76KEf2Pn/OEVm8oOxhXv7R/Bbhg4wO
	ITtSrqJeyAIS6FrJd33rjRsHd+Lpowvnlx9AYm+pC36KkdCUgKITYDn5pvizsjOMlG4=
X-Gm-Gg: ASbGncsJ7VVnpOXacX5huTCqZYui6Ny3WDwh40cfZr79dymtDCnv5y4EH2UQwmEWYLt
	DbJJx2KhlUZKY3TeTnJaSyny3+j79BgfRSFfk2vaxDpawQ1Q57V6pV6SVA7RqJpFT3jx+C8S9n/
	5RW9d6VymCCl5P1QfUcA5RMF1xvlJ8t7vUD1lfL28FSvwdOU5Cg2wmJ/86nUBshEbxiINYMaPxU
	TvIwX/kZj9X7CSg/s3Hl3VghLpHM65+fZQoxOzGpr0Vofa3nExaDmswrjIZJaksaiiyUXzsF/IQ
	VJKmNxzgNH1rePxe3TptBSv0+F/nbHn+xXUSO+ZJKCl0nMJyRQjb6+DpIq4A50TGci09ZoZfDme
	U/G0LqgSUNpgDcTpDwJuMVJ+tEEskr1asjYPQRtsYYag3VVjcL9+QA6Zj6UXn9eX1Q/CQWbM2T3
	DVhaJNgDIChJDiqw==
X-Google-Smtp-Source: AGHT+IGsyvKHdORKwFth+3NCAwQtMjuvaLmVXYSXCUsqAqneazOk5U0n4dygLYxdjqbi1pYRvYvXyw==
X-Received: by 2002:a17:906:b4a:b0:b73:53ab:cfa1 with SMTP id a640c23a62f3a-b76715ab9ebmr1277500966b.17.1764080636819;
        Tue, 25 Nov 2025 06:23:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ce15e7sm1627635166b.8.2025.11.25.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:23:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,
 kernel-team@cloudflare.com, martin.lau@linux.dev, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH RFC bpf-next 15/15] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
	(bot's message of "Mon, 24 Nov 2025 16:58:04 +0000 (UTC)")
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
	<4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
Date: Tue, 25 Nov 2025 15:23:55 +0100
Message-ID: <87cy565gxw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 24, 2025 at 04:58 PM GMT, bot+bpf-ci@kernel.org wrote:
> This appears to fix the bug introduced by commit 016079023cef ("net:
> Track skb metadata end separately from MAC offset"). Should this include
> a Fixes: tag?
>
> The earlier commit message explicitly noted: "Note that this breaks BPF
> skb metadata access through skb->data_meta when there is a gap between
> meta_end and skb->data. Following BPF verifier changes address this."
>
> This commit is one of those follow-up changes that addresses the
> breakage.

False-positive feedback, naturally. Both breaking change and the fix
belong to the same patch series, so Fixes tagging rules don't apply.

