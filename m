Return-Path: <bpf+bounces-7730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E277BD44
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F8D2810F1
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74FC2E7;
	Mon, 14 Aug 2023 15:41:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCEC139
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 15:41:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C910D1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kf5XEZn83aSS7JoC9QxrJKMpPHdZR4cZ7qlxjglUzo0=; b=flEFITOXQBBOoAkYQ8vj+Nm9Yz
	xzJOSykIqwNbL/xYMIihVrMQvyX3NryfUePVBz6h9lwQCmNbaoUprQ5LZaWS+4vN8QrVfmFLVHpr2
	SIXQA5PEJ2XGFZ55JWgQeDk32RfcnNw8Tst0aMLAqbqIFPYoU4kpn6cUPjUorcw5yRBE20uqiOg5M
	C1bNugXdUSJySWzOsDhxWyGBfSABk5G+8XEO4w1ptekLtLwl4KykfBk2bCBS6tC/vucn6zyMjhbiA
	yNRAc8S8C3zCsU7/cUiBPuAL2QVnjxUlM0XGKKkIX3P8wPmeFXQdH1PlHdOigqrosjkXyMxlDgXH9
	KLPOG1pw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVZgf-000KQQ-76; Mon, 14 Aug 2023 17:40:57 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVZge-000W4h-VS; Mon, 14 Aug 2023 17:40:57 +0200
Subject: Re: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
To: Martin Kelly <martin.kelly@crowdstrike.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Marco Vedovati <marco.vedovati@crowdstrike.com>
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <86e24c5b-f27e-42ee-aab9-af5379c3cf79@iogearbox.net>
Date: Mon, 14 Aug 2023 17:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27000/Mon Aug 14 09:37:02 2023)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 11:43 PM, Martin Kelly wrote:
> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
> 
> Enable the close-on-exec flag when using gzopen
> 
> This is especially important for multithreaded programs making use of
> libbpf, where a fork + exec could race with libbpf library calls,
> potentially resulting in a file descriptor leaked to the new process.
> 
> Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>

Looks good, thanks for the fix, applied! Do we also need to convert the
fmemopen in bpf_object__read_kconfig_mem - if yes, could you also send a
patch?

Thanks,
Daniel

