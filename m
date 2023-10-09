Return-Path: <bpf+bounces-11712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE007BDF3F
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94DF2818CE
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE042250E0;
	Mon,  9 Oct 2023 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mXBfR6M9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2E1A5BA;
	Mon,  9 Oct 2023 13:27:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F615A3;
	Mon,  9 Oct 2023 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Upzz23gM7CFVJCcFBQEZrdbmDiHFsFQK+Y+xE1IddiY=; b=mXBfR6M937X0CooRhB5p1qQeET
	EpoVcaViV4YWfVL4jbUHqF4GhcQybjC4HJhD34LkZsM/yhGwaWaKbfOZ6/le5fvdVo1xE8YC9o0lN
	isHZXwpnl11W+AbBQ4JHPX7BTHDpvBlEqj8XbXBvmVuI3x9q6uO1Vaq/Oqx37EfbV//TEL5BjhTki
	s1Xe7UAYUBOn+gTzC9ey4jUNUJtRQfYMbN8EgnR5UZm/h7649fzmaHwqTl+BsO15nrB7aSzb/rP+w
	pW1UdujmrRQ+q04MI4kLxftupV3zerRcQEzU3qBAS6Z0SQOIoIsfWPjZ8e72g5nE7kT044vtqAi0F
	6njg/gUQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qpqIa-000PVk-3i; Mon, 09 Oct 2023 15:27:52 +0200
Received: from [178.197.249.27] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qpqIZ-000SIq-Ka; Mon, 09 Oct 2023 15:27:51 +0200
Subject: Re: [PATCH bpf 0/2] riscv, bpf: Properly sign-extend return values
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, linux-riscv@lists.infradead.org
References: <20231004120706.52848-1-bjorn@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6dbba8a3-b07c-5247-f2c1-c6b484e9a16e@iogearbox.net>
Date: Mon, 9 Oct 2023 15:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27056/Mon Oct  9 09:40:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/23 2:07 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
[...]
> The following test_progs now pass, which were previously broken:
> 
>    | 13      bpf_cookie
>    | 19      bpf_mod_race
>    | 68      deny_namespace
>    | 119     libbpf_get_fd_by_id_opts
>    | 135     lookup_key
>    | 137     lsm_cgroup
>    | 284     test_lsm

Thanks for the fixes, took them into bpf tree. I was wondering whether this could be
backed by specific tests, but looks like the above list already takes care of it.

Thanks,
Daniel

