Return-Path: <bpf+bounces-5989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB8763E40
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5751C21209
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860F18057;
	Wed, 26 Jul 2023 18:16:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D861804D
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 18:16:34 +0000 (UTC)
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82485E78
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:16:32 -0700 (PDT)
Message-ID: <896cbaf8-c23d-e51a-6f5e-1e6d0383aed0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690395390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPEwfOCRbnMBgzOD350ywUVV+S/+4plDOcrL1fOck6o=;
	b=u7TTINrL0DskF3YYfvOoWKUHJ1f9hxgLrTn2Et6ECWUav5//+y8i/cc/p8qujOxUB3M6ea
	ssvyTfpD8sZKwfX54BJfnEpFlXRXYgaPsRA6/Inbte9mUZRk6z5Jf91Wh0PLKPDKrMO7sZ
	zaVgGzJbO7UUZXMrxAixFjL9w+UU7XM=
Date: Wed, 26 Jul 2023 11:16:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
To: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
 Gal Pressman <gal@nvidia.com>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
 <20230726071254.GA1380402@unreal> <20230726082312.1600053e@kernel.org>
 <20230726170133.GX11388@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230726170133.GX11388@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23 10:01 AM, Leon Romanovsky wrote:
> On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
>> On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
>>>> Thanks, I'll take a look this evening.
>>>
>>> Did anybody post a fix for that?
>>>
>>> We are experiencing the following kernel panic in netdev commit
>>> b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
>>
>> Not that I know, looks like this is with Daniel's previous fix already
>> present, and syzbot is hitting it, too :(
> 
> My naive workaround which restored our regression runs is:
> 
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 69a272712b29..10c9ab830702 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
>                          bpf_prog_put(tuple.prog);
>                  tcx_skeys_dec(ingress);
>          }
> -       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
> +       tcx_miniq_set_active(entry, false);

Thanks for the report. I will look into it.

>          tcx_entry_free(entry);
>   }
> 


