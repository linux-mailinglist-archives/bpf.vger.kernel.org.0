Return-Path: <bpf+bounces-19722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A118830415
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 12:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15909B21558
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719781CD3C;
	Wed, 17 Jan 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHX9P1eM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD661CAB6;
	Wed, 17 Jan 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489348; cv=none; b=ed407viANYtDcpGawXdRa1PAhQekABAX7uuvKSv/eCe5UtD3eCU9WAy/baQkg/8i2r0HhQM0TLy1DAzMAQgh062QEA7pwc/D49j/Wh27cvTn9gerP8ZliN9cGeK2Js/K7MiVGdHDe83B2oIKMygL45UoeZD2X+SZoqUjJ8jnuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489348; c=relaxed/simple;
	bh=eGEmW4tUHZJ1HjeRMmXl4z/cl86YS0+V7AMi5ZbyfNk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=X0ORAh+UDPcAENBwuk2C66S8Bwl4zqmeotHERwxy3qSaKGOAnjgktGZTPDPvaqgRb+O7bhqk4ykzsfZKA8t8+ECONwHEVxu23KcISNxH2SCZ9QzhJeI+3sFscLdwu7cMRjCXkXFEMUpGrZovnGOYebfrsSDLqdYlk2NqPX6hl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHX9P1eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2C7C43394;
	Wed, 17 Jan 2024 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705489347;
	bh=eGEmW4tUHZJ1HjeRMmXl4z/cl86YS0+V7AMi5ZbyfNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHX9P1eM7QV9esAkZujn2jYrE2ELxZHH4ddCjnGAcvH+WCxV9CL9Wx/VxohBmVvqH
	 HQEzXEyocSrHu7nz/q9g62pFVfWbdl5VfyqddyRhb2NK0lpdSfGdkTshNW7E7nUt6W
	 54byHhmYyBpOp5fICJoLMVV64ocvRQ01n7apA2tY=
Date: Wed, 17 Jan 2024 12:02:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, Eric Curtin <ecurtin@redhat.com>,
	Neal Gompa <neal@gompa.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH stable 6.1 1/2] btf, scripts: Exclude Rust CUs with pahole
Message-ID: <2024011707-alarm-juniper-2bfd@gregkh>
References: <20240117094424.487462-1-jolsa@kernel.org>
 <20240117094424.487462-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117094424.487462-2-jolsa@kernel.org>

On Wed, Jan 17, 2024 at 10:44:23AM +0100, Jiri Olsa wrote:
> From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> commit c1177979af9c616661a126a80dd486ad0543b836 upstream.
> 
> Version 1.24 of pahole has the capability to exclude compilation units (CUs)
> of specific languages [1] [2]. Rust, as of writing, is not currently supported
> by pahole and if it's used with a build that has BTF debugging enabled it
> results in malformed kernel and module binaries [3]. So it's better for pahole
> to exclude Rust CUs until support for it arrives.
> 
> Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Eric Curtin <ecurtin@redhat.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
> Link: https://lore.kernel.org/bpf/20230111152050.559334-1-yakoyoku@gmail.com
> ---

You are forwarding this patch on, you also need to sign-off on it :(

thanks,

greg k-h

