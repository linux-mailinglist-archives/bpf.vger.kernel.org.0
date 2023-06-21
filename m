Return-Path: <bpf+bounces-3069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F288573909E
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388C21C20FAB
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC91C75D;
	Wed, 21 Jun 2023 20:14:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A7F9D6;
	Wed, 21 Jun 2023 20:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C9C433C8;
	Wed, 21 Jun 2023 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687378452;
	bh=dCDy3A/rSNHdhp/mXd4huyXQOqZFkZsHTIPIxDQhj1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbsWLd827a+PxMQHbt38u8IpyWB5Z0MoDwCAqH7tAxr6C8D2NtuYuQ7jWmhUegU0C
	 32AXpzlJNA53IP9fqpkriSMSrSnVgZ1h7Bx85DFPLNXyEFBKWWXz+e0g+c9H3RM8Py
	 OLr5T1WjcA2ofwM3UmTxVfnFhbjZiXZrkW2+IVnCBhm+otwXbeGqzyMuRAqG6CEGhK
	 0/WQFLgOJyMV66NNAC64hLUKF+bz9JaJqA4e/DCf47l88Vaj90fzb/eSsyHo/qz523
	 CFBP5/2/cWggjNwYt9LRZ4PIVdbSLnCqtG55uEC9tqd2eXBtQUBcAFFWbUbFjbaoIP
	 mbPmVg3jJ3s5w==
Date: Wed, 21 Jun 2023 13:14:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>, Johannes
 Berg <johannes@sipsolutions.net>, bpf@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in netlink_set_err
Message-ID: <20230621131411.6be73cc6@kernel.org>
In-Reply-To: <CANn89i+2Ex=guwKkmuyJUE5gLmnoGSd-8m_V4xmJhCkcUcn=AQ@mail.gmail.com>
References: <000000000000e38d1605fea5747e@google.com>
	<20230621124246.07f9833c@kernel.org>
	<CANn89i+2Ex=guwKkmuyJUE5gLmnoGSd-8m_V4xmJhCkcUcn=AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 22:05:13 +0200 Eric Dumazet wrote:
> > Doesn't seem like netlink_set_err() wants to be called from just any
> > context. Should we convert nl_table_lock to alwasy be _bh ?
> >  
> 
> Jakub I already sent a fix :
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20230621154337.1668594-1-edumazet@google.com/

Ah, I didn't spot it, LG!

