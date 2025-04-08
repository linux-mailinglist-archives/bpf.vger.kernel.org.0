Return-Path: <bpf+bounces-55465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE638A80F4A
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CDF188F758
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EC22A7E0;
	Tue,  8 Apr 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajr51IDP"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766282288D2
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124649; cv=none; b=i14nVUY8yhNxDjnAp+ZoL6OFW79qywZOOP/jwzJPu4IyGkXFed3SP1PzKGtlA1ixQUzTMO0OVGdJjjDcHRS40JehSfmh6qUAH9jJ4lQLJepkotSmGZMzgUfgMilK72s/dRklt9sRhyLULYKxkpCc4toMUg+quxyoA7UdVdkFJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124649; c=relaxed/simple;
	bh=IViRsE1IygSezan3jXTN3lc9+dSZBRI0+yyCs4L8GxU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=NhkvaxeyRVC3lbOGL2RL/AAF68Rx9pLq+a9p361ubSLSzFfRuKjF0LIVcv+/+0uvO+mOA1noNygLvJVSK2TAvRF8oPxvtPrktCxP8X+H/CWilfhs3lISQ3J09BJe6dQ2V6E4aFjzfMEBe7qMPTHkVV8eg2kdQFJfWdNzRNvF+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajr51IDP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744124645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IViRsE1IygSezan3jXTN3lc9+dSZBRI0+yyCs4L8GxU=;
	b=ajr51IDP5U8b1b4sGKzqd2OO0rkMzZYYyw6WgfQRxpFrh7qOouDwoOLnXKJfxYnfNVOyAq
	fOefmgTiQfDfTW8HN+PrMcPMbWmRDKhFxy7A9L/nPd7DlgbHvWpXBcsbIxRwpU9dMoIQfB
	hzVq2qcf+mwApBzM0yF7uC3wI98vEh4=
Date: Tue, 08 Apr 2025 15:04:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <bf967b32b696ee00ad865d5e4ed247386c332960@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix ktls panic with sockmap
To: "John Fastabend" <john.fastabend@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20250402231548.5d242cty2r4msj52@gmail.com>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
 <20250219052015.274405-2-jiayuan.chen@linux.dev>
 <20250402231548.5d242cty2r4msj52@gmail.com>
X-Migadu-Flow: FLOW_OUT

April 3, 2025 at 07:15, "John Fastabend" <john.fastabend@gmail.com> wrote=
:


>=20
>=20I tend to agree this is not a good situation. Returning 0 is probably
>=20
>=20suspect as well and likely breaks some applications. But considering
>=20
>=20we already have this behavior I think its best not to change here
>=20
>=20if its not causing trouble.
>=20
>=20And not panic'ing is clearly better. So...
>=20
>=20Acked-by: John Fastabend <john.fastabend@gmail.com>
>

Thank you, John, for your review, we're glad to have finally
resolved this issue!

Thank.

