Return-Path: <bpf+bounces-33209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F99919B98
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B94AB22DE6
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E94A50;
	Thu, 27 Jun 2024 00:09:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113F360;
	Thu, 27 Jun 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446951; cv=none; b=EyV/XUO/X8Kc/i+S1TwCHYS/B9qCUjkXmOpnGJ0K3b7fVWyPST24gBFNu+pSFVSOFgB4bIrvHjM8y0WjK11iAEEy7GljDRWcE5rHTqwj2Eyye5zhxE2kEqIxne0bYj3IwKd/7mehM2VwTKUg7VqlJF7mpYndL2V1ZpK25KdUUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446951; c=relaxed/simple;
	bh=hKOTBIUw+Fn6pRctY/GNTgAf6aULAkfzPy+AF408o7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMR72XNVTa59eT6q+WkDWo2PDKXS24E2+VuxJorC38tdIREn1IxLaXmM45AfW+vMT/KY1r+Slz5/d4VOLLs36K17Pfnvi7GbIGGmGNZMiHK7vpCGRUuGspSvrdSO6oTzsIWjwFWx1Z11CG6EFgZf0Y62WL9EiF5x9xIkwGW1GOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BCBC116B1;
	Thu, 27 Jun 2024 00:09:08 +0000 (UTC)
Date: Wed, 26 Jun 2024 20:09:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Ogness
 <john.ogness@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
Message-ID: <20240626200906.37326e17@rorschach.local.home>
In-Reply-To: <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
	<87ed8lxg1c.fsf@jogness.linutronix.de>
	<60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
	<87ikxxxbwd.fsf@jogness.linutronix.de>
	<ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
	<CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
	<7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
	<CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
	<744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
	<20240626122748.065a903b@rorschach.local.home>
	<f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
	<20240626183311.05eaf091@rorschach.local.home>
	<6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 08:08:57 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> How do you respond to Petr Mladek's comment
> 
>   Yeah, converting printk() into printk_deferred() or using
>   printk_deferred_enter() around particular code paths is a whac-a-mole
>   game.
> 
> at https://lkml.kernel.org/r/ZnvVQ5cs9F0b7paI@pathway.suse.cz ?

I agree with that. And your solution is no different than whack-a-mole.
It's just that you used a bigger hammer to wack the mole.

-- Steve

