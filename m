Return-Path: <bpf+bounces-11742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358037BE70B
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2535C1C20BA4
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A291DA36;
	Mon,  9 Oct 2023 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL6H9Jke"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD910A1E;
	Mon,  9 Oct 2023 16:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651FEC433C7;
	Mon,  9 Oct 2023 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696870519;
	bh=uCPuZaKEt3NJzh5PJgyPXMrlMFoyhf8vOk6Yz5Gt7cI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VL6H9Jke1U64QcENUxuMFocLMSPSbvq3zFxANnsxuh7IWW7VqmLz7vlxYct5KqmbP
	 dwl94bXON6MWq/0t7sykpIyMr8Qj5yecUn0pn/u6l7nTYDh57oiYiYl6DUgI9mUhlr
	 8cLb9VDcasJ5VnmCh7DRMEQT0W+u3il6CAmEgIt9ZuP5MYqWdYndS4Q79LAO8Fk8tW
	 l8L84gkOYM5BzZKIJOA8XEYudBTFNG1MOgab3a/xyntxqOqEqtLt+LDhOuzOyirFat
	 V5PLNx98FcjTM0EV/TXJPWpngv8j/5YNcOcnpmHNezBS52k+8udOprlpejUOxssSsS
	 5kCzQQyC8zwyA==
Date: Mon, 9 Oct 2023 09:55:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@google.com,
 axboe@kernel.dk, asml.silence@gmail.com, martin.lau@linux.dev,
 krisman@suse.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4 00/10] io_uring: Initial support for {s,g}etsockopt
 commands
Message-ID: <20231009095518.288a5573@kernel.org>
In-Reply-To: <ZSP/4GVaQiFuDizz@gmail.com>
References: <20230904162504.1356068-1-leitao@debian.org>
	<20230905154951.0d0d3962@kernel.org>
	<ZSArfLaaGcfd8LH8@gmail.com>
	<CAF=yD-Lr3238obe-_omnPBvgdv2NLvdK5be-5F7YyV3H7BkhSg@mail.gmail.com>
	<ZSP/4GVaQiFuDizz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 06:28:00 -0700 Breno Leitao wrote:
> Correct. The current discussion is only related to optlen in the
> getsockopt() callbacks (invoked when level != SOL_SOCKET). Everything
> else (getsockopt(level=SOL_SOCKET..) and setsockopt) is using sockptr.
> 
> Is it bad if we review/merge this code as is (using sockptr), and start
> the iov_iter/getsockopt() refactor in a follow-up thread?

Sorry for the delay, I only looked at the code now :S
Agreed, that there's no need to worry about the sockptr spread
in this series. It looks good to go in.

