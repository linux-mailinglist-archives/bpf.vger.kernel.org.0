Return-Path: <bpf+bounces-49413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E7A185C7
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419B716673A
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6C1F55E5;
	Tue, 21 Jan 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QNRUbwxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BA1F2364
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488516; cv=none; b=jux0G9l2JisjyXkUz5HASF9Fv5EEfrV2fGg0WXFkBQNNTG61mCI/zbdUyy84jV16u07ZPi2135QcyhU7Kr24vyKG0ZVYlaJywjnUBN8p9RCTE0dmNtS6or8L73oHgIpZ6pd57H18oc/2gxrxFdnrIVsm9hYfiiB7+p6wJGfMF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488516; c=relaxed/simple;
	bh=Dr6IfYvLVlaup19PQNUCNRKaVraSY1Mj3PpxHcAOIcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNbXftJZVOIQDuD3jPGSYqnYFtnAem79f5JLol9WS3K9qQMM4jWW0ROAUrwvNyUoo/3FGAhPnHdGw8ClXZU0iE5NNuBXotNDmLecSi+QR4o0YWjMMr6cWwzhU26fyUwTqA8OTIMh1T9TRrJKypotiVN+96iA5hV0mPykQJeco+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QNRUbwxO; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737488500; x=1737747700;
	bh=Dr6IfYvLVlaup19PQNUCNRKaVraSY1Mj3PpxHcAOIcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QNRUbwxOCBeV3r3/daIybztBmyniuR9PSWNKI1vOsaSix7xAz4HVHOJn5L+7sN+ql
	 Db63FHYTOQMrpeg/Hx0D9Pmya6JvVVhqs+CiKpx51i+j2F+ae/505hr/Q2FOTsvtKy
	 aEuXIdQS87pSVJ3xQrqw1ktSIukNY5QAJ7B0uYeoSFPmzZ4+1NuqyJVDPfSBlh7/fR
	 I/BPL263hHj0N0XcTpp4g/TbkZweVcOuGObsRHNHzMQnWIzL+wgmonS9GUMlnU7Lch
	 aNyjAERuW4+UJzkAGRxE3VFB79a0tsyYG6FfXTY7+P0hH1YCaabFzelzvZ3jfPn0ad
	 s20Nl1HWR8Zig==
Date: Tue, 21 Jan 2025 19:41:36 +0000
To: David CARLIER <devnexen@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1]
Message-ID: <NPoDIv4F7FJEyF6Y6XKDKL13OUOd1oiHa9oVCjBPdYwVlCnqlz-WdDvxXXvrJCacuJNtkV0H6yzCxarzQHxATg0sMpj4VZ3U_b_6Tn1RNf4=@pm.me>
In-Reply-To: <CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
References: <CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5c03a93fd57f73bcf01e08afb2304edf2e7a5f8d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the patch.

Please take a look at "submitting patches" page on kernel docs and resubmit=
.
https://docs.kernel.org/process/submitting-patches.html


On Tuesday, January 21st, 2025 at 8:50 AM, David CARLIER <devnexen@gmail.co=
m> wrote:

> libbpf.c memory leaks fixes proposal.

