Return-Path: <bpf+bounces-33288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418F91AFFC
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F347528600D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005319D88F;
	Thu, 27 Jun 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hRdWXemL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103719B3EE;
	Thu, 27 Jun 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518379; cv=none; b=J+N3fUsec9S/iWjLNjHr2TGK5XsXaCsgOH0ZB8Wgip1JAYG7HH8bEYyUrBE+tIM1mf75Yq7RlDjYRheh8O+kxUjKMNiuLWnI+tozELKlR4JGjyNai1hXmkytL0g/fxjfxrCtZaNGucmUMx+PxexrPkjjID+ypNe8DlA3SoOTOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518379; c=relaxed/simple;
	bh=BTkSnG798VcY3591NDxrqAo3+/bxdIjWlRHmU8AX1UM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KLV6KCbr9Pxcedc4xWltezHpdGFCM5qc6utvH9mL9A4LodsyKrj/HAG7m9ABjoo24CxnEYYyGuGlAerugQmesUmOueAq9yk77mVTVeGFPs+Lo8NviwkjNe9Y2LgM4pGF3ALpDoJ0jGHb8ktdJOt2s2CuWAPTXIlniLgCAAxf1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hRdWXemL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A16C2BBFC;
	Thu, 27 Jun 2024 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719518379;
	bh=BTkSnG798VcY3591NDxrqAo3+/bxdIjWlRHmU8AX1UM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hRdWXemLn0GDgDIGfWPexmEWhfQjw3pVlMEk4qZFDNp9WwpAn3V89P+pX/8PutYyk
	 BpYGU+TZmNYtIttdwQhTccxzVl9x3p6s2kXPR9//qAZLfe4yTanDSBdjs9L3sgtS8s
	 wJJ/Pykb5goCxZjLabd8WWSVM37ffa6VLeXeuKQc=
Date: Thu, 27 Jun 2024 12:59:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com,
 surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-Id: <20240627125938.da3541c6babfe046f955df7a@linux-foundation.org>
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
References: <20240627170900.1672542-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 10:08:52 -0700 Andrii Nakryiko <andrii@kernel.org> wrote:

> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> applications to query VMA information more efficiently than reading *all* VMAs
> nonselectively through text-based interface of /proc/<pid>/maps file.

I appreciate the usefulness for monitoring large fleets, so I'll add
this version to mm-unstable.  As we're almost at -rc6 I'll await
further review before deciding on the next steps.

Is it possible/sensible to make this feature Kconfigurable so that people who
don't need it can omit it?

