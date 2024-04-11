Return-Path: <bpf+bounces-26501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E198A11BC
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7D6287778
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA0146D52;
	Thu, 11 Apr 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpo1liyP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE0624;
	Thu, 11 Apr 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832408; cv=none; b=JnueGkYGRc6g6qm0LQFwmsArf7Y9XkiI0rSY7kcNUz3goBcPFxUelLwBQbqARXTjmRS5DbhrPdp5W6uy4obS1yzP0yJNHBD+1bYG37W9Ri4WziZ5KOdJIxbOawjk+7+7FBxvvIzVhg/yfN2aOyM07boDBDNlJ/PQ3V+jRd0TMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832408; c=relaxed/simple;
	bh=rFDZVdrid6QjJXhQJFVnZjcR5UarpY2ipJjian6ZMaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbOFuPk6ew8GUBpKWDvXSItvshLzqrA9BpKZ9FNSo/6DM2LP6eChePJiL0tx/3hmZUwlj8pw78a8Dkla0HBY19DFNRVK4K+1vGPRcjEQ4RuBKhQRG5n/142tCzEFV+/fkrc9xSEDJDW544l1iBbndxKk9LKFNkJpxEzELHXMVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpo1liyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B8C433F1;
	Thu, 11 Apr 2024 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832408;
	bh=rFDZVdrid6QjJXhQJFVnZjcR5UarpY2ipJjian6ZMaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpo1liyPOQK+QPp5k0B4qBaGGVD8a+nAv0cHpQjs/t7mCvEJ3FHkfBoj0AgB/UuKw
	 g9nVJLiX3BuASR5FG1Fa4oeV11+ln9BEbdwms4oPuMF6EzN9nVA/f5B6Y14Hxp+Gpp
	 UkDeX5dLVF5EXPdL5McVfmcwHIwLvrMO3frPl8JLT7w6vabHmtehfdUjS0Nxi0C8x9
	 VFAqUV90Giin6gCVXHnI3LIS0OuePlx/YNudqjPbNR7q+i2JWS8FajTTNuawn1VEDQ
	 6gvvPJl4xynApjSQhglX5v87ozQegH5TH2lmIoxQOl33al84ley5zOyiZPkVbtY+Yh
	 sdP8WicMbkvgA==
Date: Thu, 11 Apr 2024 11:46:44 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH v2 3/3] leds: trigger: Add documentation for ledtrig-bpf
Message-ID: <20240411104644.GD1980182@google.com>
References: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
 <fd8c1022eda25ff80b27ff3bf7fa15dbd6947ebf.1711415233.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd8c1022eda25ff80b27ff3bf7fa15dbd6947ebf.1711415233.git.hodges.daniel.scott@gmail.com>

On Mon, 25 Mar 2024, Daniel Hodges wrote:

> Update the documentation for led triggers to include the BPF LED

LED throughout please.

Same in the previous commit please.

> trigger.
> 
> Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
> ---
>  Documentation/leds/index.rst       |  1 +
>  Documentation/leds/ledtrig-bpf.rst | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 Documentation/leds/ledtrig-bpf.rst
> 
> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> index 3ade16c18328..2af52a19d6bb 100644
> --- a/Documentation/leds/index.rst
> +++ b/Documentation/leds/index.rst
> @@ -10,6 +10,7 @@ LEDs
>     leds-class
>     leds-class-flash
>     leds-class-multicolor
> +   ledtrig-bpf
>     ledtrig-oneshot
>     ledtrig-transient
>     ledtrig-usbport
> diff --git a/Documentation/leds/ledtrig-bpf.rst b/Documentation/leds/ledtrig-bpf.rst
> new file mode 100644
> index 000000000000..391a305f69d1
> --- /dev/null
> +++ b/Documentation/leds/ledtrig-bpf.rst
> @@ -0,0 +1,13 @@
> +====================
> +BPF LED Trigger
> +====================
> +
> +This LED trigger is useful for triggering LEDs from the BPF subsystem.  This
> +trigger is designed to be used in combination with a BPF program that interacts
> +with the trigger via a kfunc.  The exported kfuncs will have BTF names that
> +start with "bpf_ledtrig_".
> +
> +The trigger can be activated from user space on led class devices as shown
> +below::
> +
> +  echo bpf > trigger
> -- 
> 2.43.2
> 

-- 
Lee Jones [李琼斯]

