Return-Path: <bpf+bounces-4549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF874C656
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403241C20908
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984CAD38;
	Sun,  9 Jul 2023 15:52:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DB5C96
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:52:46 +0000 (UTC)
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 08:52:42 PDT
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD8E3
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 08:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688917012; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=fQcL45A+VOmjbvvXN812kez4xoComZ1FNJTZMGk0DBbXI2I0fG31vUg5X6H6xfhz+lW8Lrf2Xxd3TeWrC7m2PhFbdoUOVJzjyNmZ0ePdp+xkNIbJZvaBqlzEdM+DIn3TrDyra1HMqNPkp+lcieRzihM/NcASU848lPPi5DaqZ+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1688917012; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=3KiyNrREGpilhuXknlJzzQDPoX9feR3u2Ube6/79vVw=; 
	b=L3Eo5aJ9cqPYE6GazrNQt4zv2OdTwkMNF1rwQ6gdEUuAcHpQCsbTpenJNsNWMu6INWS37BPLyuRv/UxCbIpW3HPwPsVxFAQrRhlGHQfSAQ9I6Gk8xj2DqT4JC/RXtFTE7VgSzc7CwTn4vgQaFx650abiwTWZwBsrmv1mhZ8AB+E=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=sanganaka@siddh.me;
	dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688917012;
	s=zmail; d=siddh.me; i=sanganaka@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3KiyNrREGpilhuXknlJzzQDPoX9feR3u2Ube6/79vVw=;
	b=eXfoG3E7m3rvHP7ZV5dPdKUD/ZCw0Pri1LcIY16MrAagYZR8tcFdtROw0L/X6nqc
	cX2GcG3dtixBfmMxyWV4SZCUwvzH8ggNZ+8z7SH8G1kDXKVLHxdDRjjcmboiWRP3N3e
	OxcFQP9/3k1PM9oZ9U+NAuB9jOn0seNxQZbjO/20=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1688916981528744.8055241048502; Sun, 9 Jul 2023 21:06:21 +0530 (IST)
Date: Sun, 09 Jul 2023 21:06:21 +0530
From: Siddh Raman Pant <sanganaka@siddh.me>
To: "Khalid Masum" <khalid.masum.92@gmail.com>
Cc: "Anh Tuan Phan" <tuananhlfc@gmail.com>, "daniel" <daniel@iogearbox.net>,
	"linux-kernel-mentees" <linux-kernel-mentees@lists.linuxfoundation.org>,
	"andrii" <andrii@kernel.org>, "ast" <ast@kernel.org>,
	"Stanislav Fomichev" <sdf@google.com>, "bpf" <bpf@vger.kernel.org>,
	"martin.lau" <martin.lau@linux.dev>
Message-ID: <1893b4bf70a.2c44c261262941.883099013045252156@siddh.me>
In-Reply-To: <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com> <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com> <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com> <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 09 Jul 2023 20:51:15 +0530, Khalid Masum wrote:
> However, something to think about is: If future versions of clang, llvm etc
> do not support compiling our code as it is now, it may become misleading.

When that happens, the max version can be added in.

Though, it would be an indicator to problems in the code IMO,
which would need some updates and fixes.

So nothing to worry about now.

Anh should send v3 instead of replying though. I would also suggest
to shorten the commit title if possible.

Thanks,
Siddh


