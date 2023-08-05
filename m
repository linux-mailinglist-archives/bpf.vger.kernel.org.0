Return-Path: <bpf+bounces-7073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7465770F83
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141D41C20AB5
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36DBE73;
	Sat,  5 Aug 2023 11:55:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422D8F6F;
	Sat,  5 Aug 2023 11:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7DBC433C8;
	Sat,  5 Aug 2023 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691236504;
	bh=vLkPBy/ztWqdz1e+6pY0ffzSA+IiKBFBGyFEHlp1ev8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvX+MTvuviVtsxRezzjTV9rqq1qo8AMiONAP2kmatxXVUHezc/UrjfRJXcQKicrI3
	 9+qNU3hPnpvDp8bx4whjDkpO4NymlHBRfeQRth9od6GdixmYlu2IfTEvyvi+MXHsWg
	 Qw7JvosTR8edFjvVQZgOd/G+cXmaDFrmt647UZxtrCPbM1chPkqOaDQKZUDTFYhFgM
	 vPYK6ka8vzfY62BWlTQM9q8pfDIJgQ9IDG6t+lV0CAq1nEsGOZKNWymoo24JRVZk2D
	 jdPto3X5ahB12kDVh6m+SvDEZHl7EJnSL5KXnV7DlAFVx7agYsUDN8yGfofeOwr3Ks
	 e2lM14S83Pvdg==
Date: Sat, 5 Aug 2023 13:55:00 +0200
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 0/6] team: do some cleanups in team driver
Message-ID: <ZM44lK+bu8/ng4cR@vergenet.net>
References: <20230804123116.2495908-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804123116.2495908-1-shaozhengchao@huawei.com>

On Fri, Aug 04, 2023 at 08:31:10PM +0800, Zhengchao Shao wrote:
> Do some cleanups in team driver.
> 
> Zhengchao Shao (6):
>   team: add __exit modifier to team_nl_fini()
>   team: remove unreferenced header in activebackup/broadcast/roundrobin
>     files
>   team: change the init function in the team_option structure to void
>   team: change the getter function in the team_option structure to void
>   team: get lb_priv from team directly in lb_htpm_select_tx_port
>   team: remove unused input parameters in lb_htpm_select_tx_port and
>     lb_hash_select_tx_port

Hi Zhengchao Shao,

Some of these patches appear to have been posted several times within
a few hours. Please follow the guidance that at least 24h must elapse
between posting the same patch. This is to allow time for review,
else things can get really confusing for the reviewers.

Link: https://docs.kernel.org/process/maintainer-netdev.html

