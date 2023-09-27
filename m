Return-Path: <bpf+bounces-10977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07AB7B0852
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D61B6281F39
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8247357;
	Wed, 27 Sep 2023 15:33:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC938F90
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A7C433C7;
	Wed, 27 Sep 2023 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695828807;
	bh=JiQClH+wrT5+gpdkMYYCI4fuk08UiSBAjezXUD3crFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mssSikQWBmYELpuZ9obsEimc2JhsPBI7oC0bpkyGVowZ0lU3o7cLAi1WdE8+eMhtc
	 BKtgNaIcqX0PCpffM+euv1Z+f8HXclZ3V/qTSHCVEbj0geZyFHkZ2gYlOIKvWy8bE9
	 RzQAcm4LiV9nX1FB8WXA8LcssMCzofg3q30i5oI0=
Date: Wed, 27 Sep 2023 17:33:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
	bpf <bpf@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Message-ID: <2023092740-psychic-debating-da77@gregkh>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>

On Thu, Sep 28, 2023 at 12:08:47AM +0900, Tetsuo Handa wrote:
> +extern int register_loadable_lsm(struct security_hook_list *hooks, int count,
> +				 const char *lsm);

naming nit, this should be "noun_verb" where ever possible to make it
easier to handle global symbols.  So "lsm_register()" perhaps?

thanks,

greg k-h

