Return-Path: <bpf+bounces-63643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936DB092D7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E959E1654B9
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF52FE397;
	Thu, 17 Jul 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i96kezw3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F94192580;
	Thu, 17 Jul 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772169; cv=none; b=o8KWKI1OqesfT3QEwPc4B5dV3h6ddH3eWQo4SZMwPfwFd2sIu+PovbCCLtZwnT/kcSivCGb8Pld0qMCHCE9f6mr7fPyRBOzvMCBik4j+Kf488eVuLR13bwAGEN5vDH3l/pZiekl4tVfud8iQnai/JQrzo9KFsci0/N4UEHZO9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772169; c=relaxed/simple;
	bh=u6la9tDTJ5T/duEum+F8U3W49+M9cN7pHyMCo1XksV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOZCkDehH/wLxYUscKAiRHBzBrKNLe8cuCJtfs7Y1TbD9Hc+Fr2NEsng3HlwJqX8G33eR5AkzaLYhCcsvnXSaAoSkmUbeJ4cdKsg9ROKlSlgXzMzTJAW6t8b/2QloNN2b5Q373186CfO/OYInmwVMEBBTGRn9WbgLFQzbQfMYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i96kezw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D16AC4CEE3;
	Thu, 17 Jul 2025 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752772169;
	bh=u6la9tDTJ5T/duEum+F8U3W49+M9cN7pHyMCo1XksV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i96kezw3do0YCiSM+7DTmqWoLhSqwjZd+MTNRGyKzDEizNEc0IIuj+I0TIqiWc0d8
	 7DAEI6bcpYdyNncFiwKelt1D0bTc7OeISB1OkeG7JiuY0f7qYaWRDiPdbrjiQQC2+z
	 P/QjuUnWgw04R+l+/KQIzbSNLybAUwIAhTlwoYms=
Date: Thu, 17 Jul 2025 19:09:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in
 bpf_object__new()
Message-ID: <2025071756-motor-slackness-ef0d@gregkh>
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
 <f6c4944d-c6c2-4a7e-8dd3-791d0c29022b@linux.dev>
 <CAO9wTFjEJOfF7krFuV=DkZFzRU3FpRXtnq93UaX8=_Y=wnwbHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9wTFjEJOfF7krFuV=DkZFzRU3FpRXtnq93UaX8=_Y=wnwbHw@mail.gmail.com>

On Thu, Jul 17, 2025 at 10:29:50PM +0530, Suchit K wrote:
> On Thu, 17 Jul 2025 at 22:19, Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> > On 7/17/25 4:59 AM, Suchit Karunakaran wrote:
> > > Replace the unsafe strcpy() call with memcpy() when copying the path
> > > into the bpf_object structure. Since the memory is pre-allocated to
> > > exactly strlen(path) + 1 bytes and the length is already known, memcpy()
> > > is safer than strcpy().
> >
> > I don't understand in this particular context why strcpy()
> > is less safer than memcpy(). Both of them will achieve the
> > exactly same goal.
> >
> 
> Sorry, I meant that strcpy() is generally considered unsafe because it
> doesn't perform bounds checking. Its use is deprecated and
> discouraged, as noted in Documentation/process/deprecated.rst. I made
> this change with that in mind, although I'm not entirely certain
> whether it's actually unsafe in this specific context.
> 

Your change also did not do any bounds checking at all, so how is this
now safer?

confused,

greg k-h

