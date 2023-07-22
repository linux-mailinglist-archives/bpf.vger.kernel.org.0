Return-Path: <bpf+bounces-5662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D14775D8C3
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2526728256C
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24663A7;
	Sat, 22 Jul 2023 01:40:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B563A0;
	Sat, 22 Jul 2023 01:40:26 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18261721;
	Fri, 21 Jul 2023 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KGCz3k3j0W7Cszw6kwCTxj4iVLWHjppLTlpF7GEouY8=; b=pWgbnn++AvYxZPWzIJLDyfc7Vg
	X50QUzOhZbXeyV8k1coHmfe5iG6YXRRNPLEl/dD5/pJni4InRYfQXnD5qSayhCwpSEnj36Zd3HyK1
	C7y+YlQQJmfEwGABLBzOcfBujsA2ZTet3H6INacvw49uU8FKUkcArVj7IuhpLmFDX/zBBll1V5xpY
	XVgDQkzVKMwUi5Qyob3zwOSRkPszJ4AtUHt+L6wLGehJOnCwu5axcICGFZ63DuM/8T1/aUHc/gnub
	YqSqIuYmf4I6waPnp/kRMHKaIDoA/OztSdaUoyswWhbseOqHf0kAeZnuGHXaJYsETmSa+eJM/Tl8n
	4Y549cQQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qN1ba-0006nC-Fi; Sat, 22 Jul 2023 03:40:22 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qN1bZ-000QQa-QA; Sat, 22 Jul 2023 03:40:22 +0200
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
To: kuba@kernel.org
Cc: ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b77d09e1-8acb-48e5-5192-218e1bc948af@iogearbox.net>
Date: Sat, 22 Jul 2023 03:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230721233330.5678-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26976/Fri Jul 21 09:28:26 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/22/23 1:33 AM, Daniel Borkmann wrote:
> On qdisc destruction, the ingress_destroy() needs to update the correct
> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
> Therefore, fix the typo.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Additionally, syzbot also tested that all 3 reports are fixed with this:

Tested-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
Tested-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
Tested-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

