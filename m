Return-Path: <bpf+bounces-32519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F190F082
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50AC1F2349C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8641BF37;
	Wed, 19 Jun 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItVtshbH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAA18029;
	Wed, 19 Jun 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807371; cv=none; b=EZLc/WE3Cl4HVG5pjEEHCQXeraRKCVXsKaCtjCjCBxh2qXTIZpJ/M3r8xTBD/JzIQ0b3XqZ1jPt3DFKzBfdmgut/00TQbRHHZVJlLRfTaHn5oOo6FCyyQtE2X7Y+CBIJM8XiyEmRKAScZXuuk6dGBNNA0v75dN/NlenzYco9Sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807371; c=relaxed/simple;
	bh=LY0WnLp+W/1ARBwbKbyLgeTCAST9Fx+qA+xH79e35zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8SeEgOh2lxRnMNQaAXwEJR1VLDDFGjzt0TEQNHJjlemD2IGSSni0gUUliEMXEJdyl8SmCh4OcRHU0wJJDs35FHlgsn0ymtOyO8tPNaSve1YW1dsJ/92Kb83JAz3ZQe4RIBqAA7bDtBi5VbixCj4hL8ReS899Ty2Iftvim35mZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItVtshbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DD7C32781;
	Wed, 19 Jun 2024 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807370;
	bh=LY0WnLp+W/1ARBwbKbyLgeTCAST9Fx+qA+xH79e35zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItVtshbHcoOexpDp5RGraVN4BcxbYtPdgo2JqhUXOCioZVxFnbrNOyqkIDJbXDX5J
	 jO4Ar9PsrbYnmnvAsIuaeQlCmUAYVL6ELEglRqCSadn2irCOQQ5MorSG2tdXUPH4Py
	 rQDXcdrLKxigbm7CKBX74wcWeh5+Y+wg++GPmpWPHjq2/cy+3Z8baRghJdxTtyspl/
	 6TMOSLUusvZ+TI+rdtsbv7nyl5b4Qt6lQTDYZy4Z86JbInkRaK1I8K7ysLl0Y20Mav
	 VOzjE/zgOSYPG/iYzHo56681mv6hfWiJK0SEuPXzfUlrW021m6scMCd/4wzwPgWyK1
	 ki+04RD4kLj4w==
Date: Wed, 19 Jun 2024 10:29:28 -0400
From: Sasha Levin <sashal@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>, jikos@kernel.org,
	linux-input@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 31/35] HID: bpf: add in-tree HID-BPF fix for
 the HP Elite Presenter Mouse
Message-ID: <ZnLrSNTUjy73J9o9@sashalap>
References: <20240527141214.3844331-1-sashal@kernel.org>
 <20240527141214.3844331-31-sashal@kernel.org>
 <k4j2pjxg23i6tggjc7beodock2q7pbjbgzombidzlowb7rpr37@ziaqvisevijj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <k4j2pjxg23i6tggjc7beodock2q7pbjbgzombidzlowb7rpr37@ziaqvisevijj>

On Mon, May 27, 2024 at 04:50:02PM +0200, Benjamin Tissoires wrote:
>On May 27 2024, Sasha Levin wrote:
>> From: Benjamin Tissoires <bentiss@kernel.org>
>>
>> [ Upstream commit 4e6d2a297dd5be26ad409b7a05b20bd033d1c95e ]
>>
>> Duplicate of commit 0db117359e47 ("HID: add quirk for 03f0:464a HP Elite
>> Presenter Mouse"), but in a slightly better way.
>>
>> This time we actually change the application collection, making clearer
>> for userspace what the second mouse is.
>>
>> Note that having both hid-quirks fix and this HID-BPF fix is not a
>> problem at all.
>
>Please drop this patch in all backports (and FWIW, any fix in drivers/hid/bpf/progs/).
>
>HID-BPF is only available since kernel v6.3, and the compilation output
>of the in-tree file is not used directly, but shipped from udev-hid-bpf.
>
>TL;DR: this just adds noise to those stable kernel trees.

I'll drop it, thanks!

-- 
Thanks,
Sasha

