Return-Path: <bpf+bounces-3597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441397403AF
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C1E1C20A35
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46424A26;
	Tue, 27 Jun 2023 18:59:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310821FB1;
	Tue, 27 Jun 2023 18:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C81CC433C8;
	Tue, 27 Jun 2023 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687892366;
	bh=jrWpCrzpq9YG0+S/IRAGmEuhe4lIZLpzAlVkc1cLz7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcKXcba4+0jmSpEQOldnayk5/DNFBwkWx+lPEW/Qi41+DufsY7n9ZLEyOlljTskcW
	 K9kqXwDwJjNZhuM/Km8xXnMjjsP4c78rZi0D5e9W1daLNQnKgfxrEg+Jh5SFZZBl23
	 iJUNkIrYemmLMVYMI2eH9iPnOxR7AeH5EnjLYBIyffVv3qYugqoL+ev+5g1AGtIfjn
	 YEQcBk1DEFOeLtF6O1kG3fhW9KK+zqhFIKW9qpQfFpERAoKoEgnOj8A6zbaUX1dQbt
	 WBzzo8tCWStyCEY34lQ/SGyczqQqfeaeyiXQNghOS3Sbz4UbK/WFWJ+G/ZCXsSfqJo
	 2nxMyjgCfIJAA==
Date: Tue, 27 Jun 2023 11:59:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.5
Message-ID: <20230627115925.4e55f199@kernel.org>
In-Reply-To: <20230627184830.1205815-1-kuba@kernel.org>
References: <20230627184830.1205815-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 11:48:30 -0700 Jakub Kicinski wrote:
> WiFi 7 and sendpage changes are the biggest pieces of work for
> this release. The latter will definitely require fixes but
> I think that we got it to a reasonable point.

I forgot to mention a conflict, there's a trivial one because of
adjacent changes in fs/splice.c. Stephen has the resolution:
https://lore.kernel.org/all/20230613125939.595e50b8@canb.auug.org.au/

