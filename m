Return-Path: <bpf+bounces-63128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D601B02EDF
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 08:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06547AF50D
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ABB1A08BC;
	Sun, 13 Jul 2025 06:21:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BC1531C8;
	Sun, 13 Jul 2025 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752387683; cv=none; b=AbDdvKIJSGwpkCWuRZmW6vvf/cBSleAlc3pvS9frA52fjeFJmZX5RcXenNvPxnYXDgXtNtR32FxN1wSKDBfwmMclpVqqky5UiXXR9518ClWgTqs2HmQbMyVc4tOXOljbyU+pbTyI+H0+f30uUCgQ0FjXl/1y/Q0lyuW2OvU8WmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752387683; c=relaxed/simple;
	bh=Non3GV7vq46Wtu0cQULHNQEC46muVy9LiPi2ABnzLYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpMhARkFtJY+lSHoV0nkpFA4wMezvDgKacU1B4tpEZtOMiJ/DJyq79DiCW0LiL+wPonysNCdKDukoYPOIVYiuAxC+Ed9cvHhrJOj/deNc3YL5ywWTry6tGaT+iKbqz1RV3/B6KW4k5+BBkLTbnleD9Errk97eTZzFrCwn6NwB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4EF57341EFE;
	Sun, 13 Jul 2025 06:21:19 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,  bpf@vger.kernel.org,  Andrii
 Nakryiko <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/libbpf: add WERROR option
In-Reply-To: <1017a5b4-478a-48ee-805d-363a4c0ca220@kernel.org>
Organization: Gentoo
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
	<c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
	<1017a5b4-478a-48ee-805d-363a4c0ca220@kernel.org>
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Sun, 13 Jul 2025 07:21:16 +0100
Message-ID: <87ikjwobkz.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Quentin Monnet <qmo@kernel.org> writes:

> 2025-07-07 15:18 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
>> On 7/5/25 12:43 PM, Sam James wrote:
>>> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=0.
>>>
>>> This mirrors what tools/perf and other directories in tools do to handle
>>> -Werror rather than adding it unconditionally.
>> 
>> Could you also add to the commit desc why you need it? Are there particular
>> warnings you specifically need to suppress when building under gentoo?
>
>
> And if you need to disable the flag on a particular target, have you
> considered using the existing variables and pass EXTRA_CFLAGS=-Wno-error
> rather than adding another flag?

I think inconsistency with other tools/ is unfortunate, but yes, I guess
we could.

>
> Quentin

