Return-Path: <bpf+bounces-27215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D450A8AAD6D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE65283275
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD58121F;
	Fri, 19 Apr 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCRo1+5w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF47C0AA;
	Fri, 19 Apr 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524962; cv=none; b=Yw//DwZRwQorusYXHIZJ5a7xRL2k2oG+cH/MW7143m4geJZMz3UeCEbFxg8neTMu6oaGWSd+lUUD70QirRKu8iToqxfwKnZEGtWnNx7QVEwetIkQKq9hZ/SvRDWyBfj32CDTV3C/BhuAsYE/GZTRce/a8jfcsTbrqfHKCAdmC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524962; c=relaxed/simple;
	bh=YI3P7Rva9xSglnlAVV6zSk/NWyRNlLlz//CcwKpcCTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyYY+1qZ2C6epHKZZlfw5957gsbdbgovJwfVJM3hmuhn810/1zPRNg709QxEGfLPXz/Gp1W/tVR3KM/zGVSkyQHwO0+GMTHb7aNhzcfW9diGsckv+8cOXY8oKWR3zPRi90YcXb6H6PAV7dxTwdY1JrvB+FssUMfPD5jhuKTw8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCRo1+5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C77AC072AA;
	Fri, 19 Apr 2024 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713524962;
	bh=YI3P7Rva9xSglnlAVV6zSk/NWyRNlLlz//CcwKpcCTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCRo1+5wIIs/WfccSt8i6DyJQUPvAeWr2EZfcnhwoVTmbhYtoa/62LWc2fzZIvfwP
	 +vKHTazBB8EomoJZqaiKlwhSdjFizANNVizJ0haWw+QJXlmKms4SQfZlGGEjBjJQir
	 VO3MlMRlGksncnidd/u6GFpm/keHk/Ou6zhe2gP4=
Date: Fri, 19 Apr 2024 13:09:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, kernel-team@android.com,
	Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y v3 0/5] Backport bounds checks for bpf
Message-ID: <2024041958-devourer-shanty-bdba@gregkh>
References: <16430256912363@kroah.com>
 <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>

On Thu, Apr 18, 2024 at 11:19:46PM +0000, Edward Liaw wrote:
> These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.
> 
> This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
> due to out of bounds access into reg2btf_ids.") which was cherry-picked
> previously.
> Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/
> 
> They were tested on 5.15.156 to pass LTP test bpf_prog06 with no
> regressions in test_verifier in bpf selftests.

All now applied, thanks.

greg k-h

