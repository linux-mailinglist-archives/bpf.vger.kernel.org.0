Return-Path: <bpf+bounces-66255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21946B30322
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAA3AC71C3
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CD34DCD2;
	Thu, 21 Aug 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlRyniTp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5512E88B7;
	Thu, 21 Aug 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805445; cv=none; b=Xl+XRj9NNzWSzNn9H+FGavGVMmCDFzRn4osFxu5vDFBH7qyo6Fq433yZRwaFSQ6jJ7/AeC/qZ+sd1pxtp2AGvImaPnFrnleCxIF3jCzP4dmoORnL23nhgQTrpYgmOxZyeToKMNMkWmUyuUh91zde9SIqDZSKAyitmzK5nmvtPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805445; c=relaxed/simple;
	bh=dGzlF0h35RGwJDr1ToU3uBGON2WHeMWcWT56w0SdVrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAlTdT7xV4/49u5HpyTR4qSm8rvhrm1gqwzaI98fH9ZIHhLOq26QuL62ElMHjICBSywhEJdFAHEf+y2DAcEA8cXLwxzUdQu/hrdF58Lk6mqy35WxnW+l73BEm4l+ZODKTBvTvcN+LI68YYxZouxlrtOl0Ml36X+/CbzhlKZmhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlRyniTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF64CC4CEEB;
	Thu, 21 Aug 2025 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755805445;
	bh=dGzlF0h35RGwJDr1ToU3uBGON2WHeMWcWT56w0SdVrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlRyniTptyQu9dph2hgUTqNIYJUtFv/jJknp7B7FdbQ7rLmBDCZgmynGs60Dif1/0
	 2V1uNGkcCm7vMY1h+efn+sW0f02AZ9MX8COMDnk7AWE6dYc4jG90t0n3hvTtleYPT1
	 SQd4DEteGV4KEAqddwIl0vgEsfh/1VVaxI0qBKfQBZa2LPtGdJhLDX57Tvk6cuaBI5
	 +kJUxPtBa2uC6OeBZnvCg+UrSUeBgBmc8FTSGLNMzLT1WsY5c9rAvzT8ZL5frKmlLJ
	 hqZbjEEi9JvdsmVdEiJ7O2frE/GJ4Bbi0RqVSUcwBb/ZOZLQjrqGdz9Hy8fDPrR7QU
	 Ymeh2PKoCLTWA==
Date: Thu, 21 Aug 2025 21:43:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Fix PDF doc builds on major distros
Message-ID: <20250821214358.7a4d8c8f@foz.lan>
In-Reply-To: <87zfbs5vka.fsf@trenco.lwn.net>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
	<87zfbs5vka.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 13:22:29 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > Here it is the second version of the PDF series. I opted to split one of
> > the patches in 3, to have a clearer changelog and description.  
> 
> OK, in the hopes of pushing through some of this stuff, I have gone
> ahead and applied this set; if things need tweaking, we can tweak in the
> coming weeks.

Thanks, very much appreciated!
Mauro

