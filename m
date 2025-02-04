Return-Path: <bpf+bounces-50390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D0A26F0E
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CBF164264
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844E208990;
	Tue,  4 Feb 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKmQfGxA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB62080CD;
	Tue,  4 Feb 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663802; cv=none; b=cktfRVdq+OHVJhRqA6ZnwKAFu2k0Mma4A0/G2eVV61Ugb4XUI3Nlvz9wFkS8e6hxtyHcmYGnd+j1nGvKmAdVnknmCuMD7p7OMR1NvFl28kww0fe16gU+8Ny8ZW0W6rvZiG23RNy+K5asQOPbCWdjWEj8KUQnmKo1ULrzcXRqpQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663802; c=relaxed/simple;
	bh=rBD6XvBcwU9G+k9eOn/8m9HwrS+kD/a34QkLf5k9O8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ThyK9pa1owk/Ia/QFy36aA9/cczki5/9UR5q/WtTdjJyeOXOZQBfZMlK1v4yqhqIFmqGxZbcxEP52HfKNU5Z+1O30wQzpH4Uw3SAkzlxNFJSlbziLIvkWo9F9j/OI5WOo+mNY8umkIfbgnUvLDMYzeW+6nP6j/JqOWI8aK5XoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKmQfGxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09606C4CEDF;
	Tue,  4 Feb 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738663801;
	bh=rBD6XvBcwU9G+k9eOn/8m9HwrS+kD/a34QkLf5k9O8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HKmQfGxA//AQj/eB24vzx75IyRWKplvh7oxO8QT4VEgid0vRSpRc4k9vWZfsQU/jx
	 7ijVvr3R5ft7iNrRWXMzXSIcIN51Jr+CiFRJ3P0NCk1Cc1aL5CiPBpAKUP7/NBxzC3
	 cUDK+5H93oOpbN2PuUc+kwUE/GAxRSxxn4GGitiRsYlUzR9aK4Xp8LDlPAmT3uWy10
	 a9SjBGVRpSUBUB0H6vayYr/pQ5AcYnLdHlnJnw3SlNJNki7Vz/W4uloEatibVJS782
	 EaVuagL6uQMxQsr8pNsvwTlGk3o9UnUlf414MsuAGlyEfiUHdA2i3nQO/cQtDpbcKn
	 i1StoSCoUwaZw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <n.schier@avm.de>, 
 Ruowen Qin <ruqin@redhat.com>, Jinghao Jia <jinghao7@illinois.edu>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org
In-Reply-To: <20250203085506.220297-1-jinghao7@illinois.edu>
References: <20250203085506.220297-1-jinghao7@illinois.edu>
Subject: Re: (subset) [PATCH v3 0/3] Makefile fixes for samples/{bpf,hid}
Message-Id: <173866379778.4143329.12324618347215472533.b4-ty@kernel.org>
Date: Tue, 04 Feb 2025 11:09:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Mon, 03 Feb 2025 02:55:03 -0600, Jinghao Jia wrote:
> Following commit 13b25489b6f8 ("kbuild: change working directory to
> external module directory with M="), the Makefiles for both bpf and hid
> samples are broken due to the use of the relative vmlinux path (i.e.,
> ./vmlinux) when generating vmlinux.h. Additionally, samples/hid experience
> the same problem that was fixed for samples/bpf in commit 5a6ea7022ff4
> ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS").
> 
> [...]

Applied to hid/hid.git (for-6.14/upstream-fixes), thanks!

[1/3] samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
      https://git.kernel.org/hid/hid/c/1739cafdb8de
[3/3] samples/hid: fix broken vmlinux path for VMLINUX_BTF
      https://git.kernel.org/hid/hid/c/8b125949df58

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


