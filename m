Return-Path: <bpf+bounces-5321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B400E7597E8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9852818C4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25374154A1;
	Wed, 19 Jul 2023 14:15:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9314008;
	Wed, 19 Jul 2023 14:15:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2F1722;
	Wed, 19 Jul 2023 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AhhvPKL15Njp8ql/nNcgeKlt/Q5zwJ+eEpKyUjaMZkM=; b=nnF4tz+QvQ9syCL5aBlALdUw6q
	LB5Jb/RddevX91br7W+/B/lbbHMR4omQEHQl6bV8JVO3BS9VKkWeLLu//mUBb4hOonGrgEK/uLz3K
	TaLROpb5wmNUr8sJ7yskFpDhxr8z3gKny6SC5CBjmMKlohQouDnt+20BbrbgEOSksozkBIiZxvSXd
	Q+XfOZlHyPVruTBjMByyomzUSUGxNi34TjJGycwQV7eXLvTyls8SsOz4yDmdgAmVx7/AU0IdUNG1a
	wa7Gc4Vy9A9K3H7WIOfSQkNArHj8RaY4Uf0emL2vn3F74R+/bGNA1Hr/4d5VmhqeNPe9iUc3D8/Pn
	LqrE6gaw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qM7xc-0009qU-4y; Wed, 19 Jul 2023 16:15:24 +0200
Received: from [124.148.184.141] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qM7xb-000PIm-Cl; Wed, 19 Jul 2023 16:15:23 +0200
Subject: Re: [PATCH bpf-next v5 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Jakub Kicinski <kuba@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230714141545.26904-1-daniel@iogearbox.net>
 <20230714141545.26904-3-daniel@iogearbox.net>
 <20230718172531.67b639fc@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d96b725d-6a7f-9b80-04f2-27872b1b3ca4@iogearbox.net>
Date: Wed, 19 Jul 2023 16:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230718172531.67b639fc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26974/Wed Jul 19 09:28:18 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/19/23 2:25 AM, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 16:15:39 +0200 Daniel Borkmann wrote:
>> +void tcx_inc(void)
>> +{
>> +	static_branch_inc(&tcx_needed_key);
>> +}
>> +EXPORT_SYMBOL_GPL(tcx_inc);
>> +
>> +void tcx_dec(void)
>> +{
>> +	static_branch_dec(&tcx_needed_key);
>> +}
>> +EXPORT_SYMBOL_GPL(tcx_dec);
> 
> Do these need to be exported? Otherwise:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks! Indeed not, I removed them for v6.

