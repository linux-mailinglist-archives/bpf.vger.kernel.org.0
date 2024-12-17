Return-Path: <bpf+bounces-47139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3F9F5886
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8151883303
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371C1F9EB4;
	Tue, 17 Dec 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="j7XQVB1W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233A1D5CCC
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469839; cv=none; b=twF7Ci3uL3LyDpAoua0tyKQHTJGwPjhSz0u2BM15f84D5cDlDdghmAgj0uKj8YJjtOogYOcm4uED3/WRDcg5ds6v/D5tH6N6hX6Vtvp3HWQDpK71App2Z8CWH+EMzqfzPMD1FmI4aih9Qx9HRrJEfkDxkw5JO5Qikkwv0MbTyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469839; c=relaxed/simple;
	bh=ngVJwXH4FieQeZ5OC29p3XwKCibHgIsxgwvaM27IwYQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=PeFHn/TBBbaHGuceMjN//LhwyymVs/abw8bLlQed8e4t0oe/2whbR/Ptmf3zC4BxVtEnir0/2bLoB3P9EHrk3pRC0tAkcwXXN1UPwyIh8rENsBgL1O6q5jHgoL+f2mdhuaYLPCt48BlANd5/z2ocdl9O9qSKTHqANFTcbRBNBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=j7XQVB1W; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734469836; x=1766005836;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=ngVJwXH4FieQeZ5OC29p3XwKCibHgIsxgwvaM27IwYQ=;
  b=j7XQVB1WYnY3l8D4fYFV1IDnxTTPGYJcPZCWSFmeVJFH4tAHv0LkP6BB
   WVg0WW/aAq6MhB6CVxAghQUIPaUUEEvW+SW8M0GYgubEr6rsXi8s3onnW
   kchlzQRIRVgQgCBXBEcuUIQnvyPogyIqDRTXsnmN9esWmgfwMUMrVMd4s
   A=;
X-CSE-ConnectionGUID: GGBlOcTPTRepnXiX6IRcUw==
X-CSE-MsgGUID: Psx5bZOjTtWJDPbUphpWjg==
X-IronPort-AV: E=Sophos;i="6.12,242,1728943200"; 
   d="scan'208";a="28224025"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 17 Dec 2024 22:10:27 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
Date: Tue, 17 Dec 2024 22:10:27 +0100
Cc: bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
To: "Ariel Otilibili" <ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a8a-6761e900-9a95-1d1363a0@43143619>
Subject: [PING] clear out Python syntax warnings
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hello,

Is there any news on the series? I got this warning from patchwork-ci:

https://github.com/kernel-patches/bpf/actions/runs/12379738694/job/3455=
5356286

I am looking forward your feedback,
Ariel

On Wednesday, December 11, 2024 22:57 CET, Ariel Otilibili <ariel.otili=
bili-anieli@eurecom.fr> wrote:

> Hello,
>=20
> This is my first patch to the list; your feedback is much appreciated=
.
>=20
> I have been using GNU/Linux for more than a decade, and discovered eB=
PF recently.
>=20
> Thank you
>=20
> Ariel Otilibili (1):
>   selftests/bpf: clear out Python syntax warnings
>=20
>  .../selftests/bpf/test=5Fbpftool=5Fsynctypes.py   | 28 +++++++++----=
------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.47.1
>


