Return-Path: <bpf+bounces-5903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA560762922
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 05:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086E01C20318
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68A1FA2;
	Wed, 26 Jul 2023 03:11:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782A1101;
	Wed, 26 Jul 2023 03:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9968CC433C7;
	Wed, 26 Jul 2023 03:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341104;
	bh=9Upzi3S02vKTUvKJdNd22YEHdE2llnbz3XXAiMSuNQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OOjHtuoBNOKGC4Cyl5+apIy5ejwGjm9BJ7VcnFMgxtPGfvvNZJe/ZX/G/1B8Z4O2x
	 eQOAs2Kp/LYfxkavQsjHHjqeqmQMFBWaOSHZyF3g58ifceVEphQL0CWIbMJg5yix7O
	 sV3Nakdf8ebHoYjkgZL3xmQFkb0EYnxcj1xjjUKTsK+MdgcRbL7/iR+GDM6/maUP+N
	 uhqmu0yaUEv2hQEPKz5yM2akmGRqPFuGwwlrWCB2g4VUSNJ1CKrv237SPUKq2mLR5f
	 pdS2eVt5vTQGqGiuDApscRr5VzxEIat80QMf97lEdTGdpWeA/5zsZz9uLNlld8yhsa
	 t/+5LIi+hmeRw==
Date: Tue, 25 Jul 2023 20:11:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, void@manifault.com,
 andrii@kernel.org, houtao1@huawei.com, inwardvessel@gmail.com,
 kuniyu@amazon.com, songliubraving@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725201142.593ae606@kernel.org>
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 10:33:30 +0800 Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
> 
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Those who parse manually must do checks manually. It is what it is.

