Return-Path: <bpf+bounces-35863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFE93F013
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB24D1C216B6
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A813D2A9;
	Mon, 29 Jul 2024 08:45:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151C13DB8D
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242727; cv=none; b=f3iSXs2Mc/2+ioVBbx7t0mJjrrMMAn2PSPgPZvzIukPMn/JoFwrYzqy3I8H51KYR7rA5EAxXLCT6RNdwgkgyEcJycfvQmd6lHMD0+W30Ibjh/TrDgk6yfvWdyxDaRY8rCqVn5slMygJY/oLz7f/jt4/MLLXTPXuueFB8JPykGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242727; c=relaxed/simple;
	bh=B+GJP+0OdGW/a9kyCu9Ae5gTIvGkw2ZGtPvAlDfgQS8=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=rHnUN8SwA8HqLGYpFsxxV0QxaJNzMQ61ied5CKF94wftWT2VdKjb1ADKWxdW++1NB19zBz5FB1TTkBf3yc4gWyZ4/USUNWcv8SrS+oOd0WQVsX5cOS50zbeLhRLmlriiGUeEEzLXg5MNTT/ANMq2zMiOElQiQA57pRYaRrqgMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lobanov.in; spf=pass smtp.mailfrom=lobanov.in; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lobanov.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lobanov.in
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a0a:0:640:67dc:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 84F8560E4B
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 11:45:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DjPjtVP5OiE0-W5dTiW94;
	Mon, 29 Jul 2024 11:45:14 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass
From: "Sergey V. Lobanov" <sergey@lobanov.in>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH bpf-next 1/1] libbpf: add an ability to delete qdisc via
 bpf_tc_hook_destroy from C++
Date: Mon, 29 Jul 2024 10:45:03 +0200
References: <20240728192620.79073-1-sergey@lobanov.in>
To: bpf@vger.kernel.org
In-Reply-To: <20240728192620.79073-1-sergey@lobanov.in>
Message-Id: <7835463C-15B2-4268-8618-00101203A9A7@lobanov.in>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Please ignore this patch. The solution is: hook.attach_point =3D =
bpf_tc_attach_point(BPF_TC_INGRESS | BPF_TC_EGRESS)=

