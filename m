Return-Path: <bpf+bounces-21282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F584AE6A
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E8D287279
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1E41C84;
	Tue,  6 Feb 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dlgl0oyG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dlgl0oyG"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAA127B54
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201200; cv=none; b=HJvyCtAvWe/OWEHKS97byZ6D3g7dnS+/I7YJsfg0kvniY/3XeYpKVEIDA5IFQLeSWPorqbKHv1myrKu1TGyIeBv1+YfmRpIrTFXmUmhUekkicG65b0M3ZlMW6M3LRDvZcPJxl6aHQh8LjKMGrjOHOFIsnW+T1bFCWF0YRwDj4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201200; c=relaxed/simple;
	bh=DiAOObBVy9n3LWizctFaUfO+Nz3eJw6H7e1ENzuVkEU=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=sth2F5LDsPrSCR8rdk55iwUs9Uoe6xHJv6Bo2j/JQZUw5j+eHnJbELezOhC7uN/HoE2P14d+wrL14UmTkvSK7Wsa9bZdUl7qL+tx8ApObtp9bM+JfnchA2fvW2ww56WqBq1yhABHYVsslnsIjBrzdpgxOYpAGZutDAGlApX+fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=dlgl0oyG; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=dlgl0oyG; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B83CBC18DBB6
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707201197; bh=DiAOObBVy9n3LWizctFaUfO+Nz3eJw6H7e1ENzuVkEU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dlgl0oyG1oQf6jAvHaTs1rrRIXFz0wQoEZe6JI349UZP7IMQIH1NW8UXYRH5D3QPk
	 dQnzSXDxZuJ+45eYgUjWTZdDypeJ5TQAkfukcR291YCEQQvMY9iLDpufq58/5facYU
	 LGfgKv8gPSNs6Fm4L0w2R26G/JRl39ocppFi8eT4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb  5 22:33:17 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 700ADC18DB8B;
	Mon,  5 Feb 2024 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707201197; bh=DiAOObBVy9n3LWizctFaUfO+Nz3eJw6H7e1ENzuVkEU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dlgl0oyG1oQf6jAvHaTs1rrRIXFz0wQoEZe6JI349UZP7IMQIH1NW8UXYRH5D3QPk
	 dQnzSXDxZuJ+45eYgUjWTZdDypeJ5TQAkfukcR291YCEQQvMY9iLDpufq58/5facYU
	 LGfgKv8gPSNs6Fm4L0w2R26G/JRl39ocppFi8eT4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BBAD8C18DB8B
 for <bpf@ietfa.amsl.com>; Mon,  5 Feb 2024 22:33:16 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPUUcG459JOa for <bpf@ietfa.amsl.com>;
 Mon,  5 Feb 2024 22:33:15 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id ED24FC17C8A9
 for <bpf@ietf.org>; Mon,  5 Feb 2024 22:33:15 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-42c1a671d18so17993831cf.3
 for <bpf@ietf.org>; Mon, 05 Feb 2024 22:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707201195; x=1707805995;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ET0fyLHVJEsDuQ9gH+PgSGGLVCtzDZ/Qwsv8HecTvM=;
 b=blWz8b5XIqwqlHSWsBThEto9ajNH5Opuehml3iu+RLrytgxLPj7QtaVGGopGxDzS2B
 9ud3p43fWo1OXk4SLYl5d6rUMS7lbf16ASdjT6QSqpxbtp+Rrumy/IQt8InG9Sefovfl
 5tJHKA2Vn3RKkMuK8oLk2gPhQv1ZZMbJU/GPS1d9ov1DhXOBoqXkNQ14MjP+TX7OgxAi
 E26KK13UOXuvE2fIe8a5GGnPEKNM344tGOdt11ekAgcelC8qcGlJXQTEz2lcBK4qu279
 0yuG8ln8zp+U5g2d3rkU6Nb06nQ6h1i0D0d1QB4zewJhQvr54Q+1w1gKfv8oQjVTuSfH
 k9xw==
X-Gm-Message-State: AOJu0Yz6lk+tlvt5dpQup8kaWTtj5UiuwE1NfQ4xUxjNY8Y6liDp4d2O
 8s0dAOOqjqGB4MJamroVFJ9hciSTJSxBeGHWHf4wGswt/L8/OJNU
X-Google-Smtp-Source: AGHT+IHIRpR2kv+KQ945cd5bHIRJBmHF8XN8dyszKd/8chzZkMG0Hj6hmihDCixwYond2AIV0Y6orQ==
X-Received: by 2002:a05:6214:29e7:b0:68c:67aa:c071 with SMTP id
 jv7-20020a05621429e700b0068c67aac071mr1707656qvb.18.1707201194807; 
 Mon, 05 Feb 2024 22:33:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWPTUZ4n807PuML7vdqZPlmkUpyLyTSfKywlu6unlF/na/5RORbbXuuGOMZIo+GxzZlypnAlYydOX1JQSMNqSdMhW/kynkb0asocW0Ex24CfwjCVQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a0cf591000000b0068cabcec402sm752286qvm.134.2024.02.05.22.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 22:33:14 -0800 (PST)
Date: Tue, 6 Feb 2024 00:33:12 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240206063312.GA853677@maniforge.lan>
References: <20240206045146.4965-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240206045146.4965-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/qBOWo435sA25TUaBwfjZcftU_5U>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Fix typos in instructions-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8030130645159237347=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8030130645159237347==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5d2i3HwTslNSlo6"
Content-Disposition: inline


--c5d2i3HwTslNSlo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 08:51:46PM -0800, Dave Thaler wrote:
> * "imm32" should just be "imm"
> * Add blank line to fix formatting error reported by Stephen Rothwell [0]
>=20
> [0]: https://lore.kernel.org/bpf/20240206153301.4ead0bad@canb.auug.org.au=
/T/#u
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--c5d2i3HwTslNSlo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcHSpwAKCRBZ5LhpZcTz
ZHxeAP455nv23Xpw/MAANLnxpIjuwgPetqhgZ6AIxG+k43yZYQD+IPt+WEGEK+Bj
vgOFFNAgPBu0bC6jODdq1ytVizlX+Q4=
=FRCI
-----END PGP SIGNATURE-----

--c5d2i3HwTslNSlo6--


--===============8030130645159237347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8030130645159237347==--


