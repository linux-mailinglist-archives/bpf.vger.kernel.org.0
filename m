Return-Path: <bpf+bounces-4862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F536750DC8
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE55281769
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8A21500;
	Wed, 12 Jul 2023 16:15:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFA214E0
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 16:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BCFC433C8;
	Wed, 12 Jul 2023 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689178499;
	bh=sMcYzYHIIR+fa36ciqKvGQ/0b/Ephr+zwHgNiIm8Mf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ytxTLRmarph1asr9/Wlov29Yvq/X9jVJP0px3Y+0kQ595khT7V/Ko/8MoVA3kpMW9
	 1Z31xp8MMxtbwU3czikAwKEeCLrwEykPyXOJXQ/wEWln06mdqwAjjU0OlMml+35TGF
	 LUpYyBtbBU13hGJNb8Lr7Tu3GPDRWcXwRV9gVvak=
Date: Wed, 12 Jul 2023 18:14:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: emile.stephan@orange.com
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: subscribe
Message-ID: <2023071243-oaf-surpass-c4c9@gregkh>
References: <df54711a8f35476d91c01ad43bbbdc8b@orange.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df54711a8f35476d91c01ad43bbbdc8b@orange.com>

On Wed, Jul 12, 2023 at 04:08:38PM +0000, emile.stephan@orange.com wrote:
> ____________________________________________________________________________________________________________
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.
> 
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
> Thank you.

Now deleted.

