Return-Path: <bpf+bounces-21776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E51F851F7A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96FAB21DEA
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC64CB3D;
	Mon, 12 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Anmhk++f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rWgxuJN/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC971DDC5
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772913; cv=none; b=XYnQiqqeBnc3cLPkZG3XllxZQ46+BDKPjAcLzZCr2txOvMak8l50tPVS4xlHGo5vD7qv/AsT4F9DBpwFYQJJL3kyXgAkBUMfX8EJVmC5Hb3i34WyQRj3DptZ5IxERYnKBgXQIReaVndlBVFhrMksyia2Shn3tLL2onnKxXNKLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772913; c=relaxed/simple;
	bh=NZhyJUNCwUZPs9KxPteeT6h6R29e1END2Asmgsw5hYk=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=jFnai0Vl8DPLDmS0HW24DsQSKDEfelsdEZG8JRiVho55/TTZ/d5D8tLTWbd94e4kfwyZtiW0sRHhWGGF1/d/LPNewJy/FfLoXGJjgMweI7NwEio39kggyflsDIm00aVsVLC5ftEEFWnzXZRV1DWQPizpVOn4I3C0g1LatXBoMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Anmhk++f; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rWgxuJN/; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31256C151985
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707772911; bh=NZhyJUNCwUZPs9KxPteeT6h6R29e1END2Asmgsw5hYk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Anmhk++fnBAp5/m3BWxTRyDw8to/xLzNmY3Lci8+qRIb3VuX8Y9ty2h7f05qTMOZ3
	 /8O/IM8uKoxuNDtzB1vao4misBt8+/NVteM3I/9QRHU+fPC2XEY4B8fnMxx02FYvbB
	 DVB/IiRAdQwxqk9ruSqwOAOwLsvCi4gXo1g/9DIo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb 12 13:21:51 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 95D2CC14F71D;
	Mon, 12 Feb 2024 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707772910; bh=NZhyJUNCwUZPs9KxPteeT6h6R29e1END2Asmgsw5hYk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=rWgxuJN/pYUvhWoKHXwkBg9OCLoTx+TxyKdkqJmkZIPuk00JBuwBWIiPj/r9hg/WP
	 XMCGg7ES0rJ/jXi7bk2W6K/jrx+g/tR3PH/zQQSbkFXwHYxsPnU8QGCZxK9ytQ4fGs
	 8sLeJhTAgPqFYnsB0uBCt3Q7NCj+F/eUXDTcBR3M=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C2923C14F605
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 13:21:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.408
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPJeka6b9aDI for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 13:21:49 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 062F0C14F5FF
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:21:49 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-783e22a16d4so351259085a.0
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707772908; x=1708377708;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyOmD5MRLJiE99owVfs0cfaVHBcrrwfJePTj+xZRfkM=;
 b=sILpNHy2uzGbH2ydS4BYN8t+ZQCd8BkLEWuzV8/Nth/z5A1SOWYUBOlf95Ic0ac8Gz
 pmdYF6sI1RgYi3LlG4XQwOL6n6YDI4zaMAFsx7sq3PT3bVhb2yTbXCKg8D+2OG+VCwIt
 0+WmzEHJQhGEgRNJ/Qn2Ezu1dxn4Kf+Xbreuwnu6BplKcG/i9EXOjUlqYvCR3Kyz5MYK
 86JD0cIlHHmaCzPHli9/Qy/gA10oFiHUW9/0whgwoGT1Adl+iOMkJCI9YKhzWsUiDwID
 8IQO62L+ft+vU2ZSpHnFxQ2fyfnmMNjGYxzGKfiRA8C1I/heV55TzZ0utG/GWrJJsDUq
 cQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBIZ/vhdK4gbNCYIh3swDZO+z/xoDqjCrv3AQlbZwwXGRm5Xfm9LiU5j3ysCk7XjySwL5YOuPBSflX/aY=
X-Gm-Message-State: AOJu0YzJeKi/fOG3phZ7jjhPaMYby1bvR/GXM61eB8cWekJL9hzk8bLZ
 D8akXNZIrkEbP/Yc/agD+2nFl85IK46/FDmI0SDKn+rTDCT67ag1
X-Google-Smtp-Source: AGHT+IGkuFKPq01mbOkW4904RVvSqdqXT08moZFhSB0VWx//X3N4wwvF9IT1RVvjsceCiUvIHREgbA==
X-Received: by 2002:a05:6214:5903:b0:68c:7946:2cb8 with SMTP id
 qo3-20020a056214590300b0068c79462cb8mr1605356qvb.7.1707772908003; 
 Mon, 12 Feb 2024 13:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXaBa6jSpvRAq1UqnJeCG+/Su0cIKLXG1tuK9eztDRnvnGi7dAO9uajGx8yUn/klQzX1xm6QJgLG7N2sG8KZvSY5GgYZjI3EfG6hrzWTl+jZTu2DQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 nw2-20020a0562143a0200b0068c89d8eb53sm564968qvb.81.2024.02.12.13.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 13:21:47 -0800 (PST)
Date: Mon, 12 Feb 2024 15:21:45 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240212212145.GA2260582@maniforge.lan>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240212211310.8282-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/bXh03nT0S7VMlx2XMIiHRpVX-80>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============2794591961354684747=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============2794591961354684747==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPY8TMn2oz/tjieD"
Content-Disposition: inline


--GPY8TMn2oz/tjieD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 01:13:10PM -0800, Dave Thaler wrote:
> * Add a "callx" conformance group
> * Add callx rows to table
> * Update helper function to section to be agnostic between BPF_K vs
>   BPF_X
> * Rename "legacy" conformance group to "packet"
>=20
> Based on mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/
>=20
> v1->v2: Incorporated feedback from Will Hawkins
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--GPY8TMn2oz/tjieD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcqL6QAKCRBZ5LhpZcTz
ZGGFAP9+v64+4ya0JpcJnPiNwIDo3+VV+oW4+5lSsXyGpXwWaAD+OZ67RECVlD0h
0NfGm+5rHi0Ym/vwSzX5piaeOVuBaQE=
=rmwZ
-----END PGP SIGNATURE-----

--GPY8TMn2oz/tjieD--


--===============2794591961354684747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2794591961354684747==--


