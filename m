Return-Path: <bpf+bounces-13314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52F7D8255
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11962B21435
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED9E2DF7E;
	Thu, 26 Oct 2023 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VDfLdD2x"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007F2D7B5;
	Thu, 26 Oct 2023 12:13:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AE111;
	Thu, 26 Oct 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wteKJASm6dXbxWE+jHSUsiJPkIx4CYo584rqpyv37ww=; b=VDfLdD2xlnp+X7kmYfHF99nxx2
	kwnYHEvQFhPmcuybbDsbzWxzKRrm59wHhp0UGJr8fumn+ViOPvbROim+abz8IC14aCetH+qHcB0+a
	2YPSrx2yg0Zoyip+GDJ3TaBx7OuXnFmiQI6CnQ8Rjvhzs/OST1iYFfif8uxDzkANN9dAW2evbYaHT
	yCMI8oxd4os4jxBFvilajg9CeK8X6Ik8lS9GNnA5w4D0ufRtytp9iC71LewpOWidEVvjsA4GDKTwI
	7rZ12Fp57Q7oLPAKwGc/Bqv4kiK+C4WEzJyJ3mXI6WSf85r8RplSa97qYHAbIdgm0Pocqv2O/WjJe
	6SQMKmtA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzEi-000OFI-NA; Thu, 26 Oct 2023 14:13:16 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzEh-000GdT-QN; Thu, 26 Oct 2023 14:13:15 +0200
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
To: Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
Cc: jiri@resnulli.us, netdev@vger.kernel.org, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
 sdf@google.com
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f14eda0f-b045-6563-7b18-bbc5bfb009ca@iogearbox.net>
Date: Thu, 26 Oct 2023 14:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231026094106.1505892-3-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 11:41 AM, Nikolay Aleksandrov wrote:
> Use netlink's NLA_POLICY_VALIDATE_FN() type for mode and primary/peer
> policy with custom validation functions to return better errors. This
> simplifies the logic a bit and relies on netlink's policy validation.
> We don't have to specify len because the type is NLA_U32 and attribute
> length is enforced by netlink.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

> ---
>   drivers/net/netkit.c | 66 +++++++++++++++-----------------------------
>   1 file changed, 22 insertions(+), 44 deletions(-)

Looks better indeed, shrinks code a bit, and passes the selftests, thanks
for the suggestion!

Thanks,
Daniel

