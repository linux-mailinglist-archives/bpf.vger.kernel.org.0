Return-Path: <bpf+bounces-18851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C3822842
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 07:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165741C22F4D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3878179A2;
	Wed,  3 Jan 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lUOhxGPX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAB18021;
	Wed,  3 Jan 2024 06:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E3C433C7;
	Wed,  3 Jan 2024 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704262281;
	bh=mXoFmy8Y3AJ12pj/BfIyrgsROCK4abHRBJp59HxUUFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUOhxGPXiOv9qvzIoMUWK00D4AYNMMYZDBoMM+Zm9gCNZJrogT77GIGV1lIqdhMhD
	 4WwIBnmbsu6baNu+iBlY3zd9PYZ238EfbwF0oWjUiZradz5sAWmDhBivgSg6PlR2t4
	 qorkqxEq0FjXsSLM18dcdyUq4rdTkXWl1/JXrGr4=
Date: Wed, 3 Jan 2024 07:11:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: proposal to refine capability checks when _rlimit_overlimit() is
 true
Message-ID: <2024010353-legwarmer-flap-869d@gregkh>
References: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>

On Wed, Jan 03, 2024 at 11:12:28AM +0800, 孟敬姿 wrote:
> Hi!
> 
> We observed a potential refinement in the kernel/fork.c line 2368.
> Currently, both CAP_SYS_ADMIN and CAP_SYS_RESOURCE are checked when
> the limit is over system limit. We suggest considering an adjustment
> to utilize CAP_SYS_RESOURCE exclusively. Here's our rationale for this
> suggestion:

As I said when you proposed changing CAP permissions on the tty ioctls,
have you tried this and seen what actually breaks by doing so?  Please
audit the userspace code out there to ensure that what you are
attempting to propose actually would work, and then, if so, submit a
patch to do so.  Attempts of "wouldn't it be nice", don't go very far as
it shows that the work to do so hasn't actually been done.

thanks,

greg k-h

