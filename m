Return-Path: <bpf+bounces-5322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2B759824
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7761C20D3D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60B156D2;
	Wed, 19 Jul 2023 14:24:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDD14AA8;
	Wed, 19 Jul 2023 14:24:13 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F02682;
	Wed, 19 Jul 2023 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0LwW3IbA+kyV8FRpDed/5kqwRIg50FWN7xrrnC7GJ9E=; b=mHhTTYozlCscMUkd20WFAn0Ihi
	Lvc5DLmYET54it2QwS9lAuPkO0ar1nkvbQflHi4x/QucJ8C0stftAN5Wr0WRKsqrrXmSqAXePZW2X
	bojo/Z63cnMTYRfDt1Emp4hfYrWltQMp+13+Zi8h/Z/IsYkHhzfIPgvXleNfVX+dEtOptaBqmUNi3
	8aKRs451saX5wxtdcyW2m8e7uoVocD50akUxOrPFNDXbFNRC7j6k3m9kAsRjwfFi0JSXvKff/sD5f
	ppw0LiZdV8yyzjMjQQevVKO3CKZpglZ89HzRQdd4+7uQv4zhmAQ9pwB9GdLOZclVAqOaV60LK3vL3
	LfCJP+0w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qM85D-000BxX-DR; Wed, 19 Jul 2023 16:23:15 +0200
Received: from [124.148.184.141] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qM85B-000OTr-RI; Wed, 19 Jul 2023 16:23:15 +0200
Subject: Re: [PATCH bpf-next v5 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230714141545.26904-1-daniel@iogearbox.net>
 <20230714141545.26904-2-daniel@iogearbox.net> <ZLV29eeWRETGkE02@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fe0952af-e5b2-e0d3-5695-13405fc9b5a5@iogearbox.net>
Date: Wed, 19 Jul 2023 16:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZLV29eeWRETGkE02@google.com>
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

On 7/17/23 7:14 PM, Stanislav Fomichev wrote:
[...]
> Andrii was asking whether we need to explicitly reject zero in [0] and
> we've been chatting with Alexei about the same in [1]. So are we trying
> to be more flexible here on purpose or should we outright return -EINVAL
> for 0 id_or_fd? (or am I misreading this part?)

I was thinking if we can support it then why not, but fair enough, I changed
it in v6 into ...

   if (id)
     <resolve id>
   else if (id_or_fd)
     <resolve fd>

... format and rejecting 0 fd case with error. The !id_or_fd && !id case I
moved out of bpf_mprog_prog() and one layer up into bpf_mprog_tuple_relative()
with a comment to avoid confusion on why it is there. This is the case when we
have before/after with no object (and no id/link flag) for the prepend/append
case.

> The rest looks great, thanks for the docs indeed!

Thanks!

> 0: https://lore.kernel.org/bpf/CAEf4Bza_X30yLPm0Lhy2c-u1Qw1Ci9AVoy5jo_XXCaT9zz+3jg@mail.gmail.com/
> 1: https://lore.kernel.org/bpf/CAKH8qBsr5vYijQSVv0EO8TF7zfoAdAaWC8jpVKK_nGSgAoyiQg@mail.gmail.com/#t


