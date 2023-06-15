Return-Path: <bpf+bounces-2611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E8730D90
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36829281623
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E62639;
	Thu, 15 Jun 2023 03:32:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F736A
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 03:32:50 +0000 (UTC)
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FC2120;
	Wed, 14 Jun 2023 20:32:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 11AECC01C; Thu, 15 Jun 2023 05:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1686799964; bh=N6MSuSr/Z+c4Myf1l9nZ+6OfeRcjQCkkQvJttGYCi4E=;
	h=Date:From:To:Subject:From;
	b=YKQsdXKtCTJNHQlS9+KNz5hULLjP8qoiZdIUnHpNRFBbZwo4ZYT+3AnXtWsU/f0E3
	 stAGvPoy3KzlcoJvboa508zbCUGWikUiFUwj2Tye4ig1+0kS9y3f6D8lR+4wAUgun8
	 SuUe30yRo9z/Fx6StgQW0+4nOLiNW241P7QCJJ0WGNDn+jqqw1YG+4ssh2KLmJWuYE
	 vKrFjm2xbG9uEdn5+Ley9EwHozaSsI8Pz05g6ro/X3mEAA9pEBaS7eswzDGxZxxF/L
	 spbUCvt/bEXzhQEcP/XWzoBI2XEVH7U/x3vS3lJa1NV7lU1viFYya4ANLSZ688wX17
	 Zyy13/X/ozFjg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 99E67C01A;
	Thu, 15 Jun 2023 05:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1686799963; bh=N6MSuSr/Z+c4Myf1l9nZ+6OfeRcjQCkkQvJttGYCi4E=;
	h=Date:From:To:Subject:From;
	b=iy2h8xlQwaXiLXlHpjCSXGm0taP5J2xluPSy6vZHw9OgQDpyG/VlMVwvLln2oR62P
	 m0b4Bl7XbtdEyfttTrDnqGa/MytVUYOFPyed0DXZGrA+KoVz5sBLozG9xd1X1nW0+m
	 FqZiEBlODuQ/9AxrlHEAyADU1bZbvJpMAQayMQA1d4jVOxKxXq6IbyorTWlI1O8rsd
	 +pnoEVnG8+ud4oHzz1c2SEQgvicq1EczQpgkun2KRM+MWI51IpbJtIL2nCA+pjSj2v
	 mjaVWl/yaCTvEzzixrYQGI+mdee06Epc6wsvOr4aERblVOIV1k2kZKhKmOiYLe2Ozg
	 hG5IOxcbanJpA==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9d2c3fca;
	Thu, 15 Jun 2023 03:32:39 +0000 (UTC)
Date: Thu, 15 Jun 2023 12:32:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIqGSJDaZObKjLnN@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563

alice noticed the kernel packages got quite bigger, in particular for
ppc64le I've confirmed that the vmlinuz file size jump when building
with BTF:
currently released package with BTF:
https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.33-r0.apk
272M	boot/vmlinuz-lts

test build without BTF:
https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
44M	boot/vmlinuz-lts


Is that a known issue?
We'll probably just turn off BTF for the ppc64le build for now, but it
might be worth checking.


While I have your attention, even the x86_64 package grew much bigger
than I thought it would, the installed modules directory go from 90MB to
108MB gzipped); it's a 18% increase (including kernel: 103->122MB) which
is more than what I'd expect out of BTF.
Most users don't care about BTF so it'd be great if they could be built
and installed separately (debug package all over again..) or limiting
the growth a bit more if possible.
I haven't tried yet but at this point ikheaders is probably worth
considering instead..
Perhaps we're missing some stripping option or something?


Thanks!
-- 
Dominique Martinet | Asmadeus

