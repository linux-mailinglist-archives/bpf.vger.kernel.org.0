Return-Path: <bpf+bounces-9093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EED78F42A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 22:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CD5281732
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEE19BDD;
	Thu, 31 Aug 2023 20:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1B18C26;
	Thu, 31 Aug 2023 20:36:26 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C41E7A;
	Thu, 31 Aug 2023 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IRy+jY3LYBzy+1khXTmPoKs3NhI+qRJ1PfaTp9S4xeg=; b=O5d5mNvRLgwJlq7sYmWWTzFDSX
	59I43cnXZ+NNfkuKlbB445ItTWxtGhXbx/2foj4AyW3iUwJJle5lGQnXiVwgJLFYNcPAegU2u8JLJ
	wjn1ZtttAE/FdlooGRxJDtb2nrhZ64nFEY100mUkXvzasYURv60hOtvA0xUkXYX7Oliere8BshZ4Q
	mI5Z5qOipqk2+HTkYZ99u59W9V+0uduaHnQHaCu951LFua9MPr0mPf1T7zqL9JPjP3AxWdAo2t07k
	EI6YtigZMm2ZqnbSnfoArlooyDYhtB5yGviUch6pgjsPBmQncD2a7scB0/eZj5qvBlhEDOb7Ywg23
	xaEIcRBw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qboOi-0006jM-MW; Thu, 31 Aug 2023 22:36:13 +0200
Received: from [178.197.249.54] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qboOi-000Rwp-KF; Thu, 31 Aug 2023 22:36:12 +0200
Subject: Re: [PATCH bpf v2] selftests/bpf: Include build flavors for install
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230831162954.111485-1-bjorn@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8351f451-43a4-86cf-562b-c0433ee38c50@iogearbox.net>
Date: Thu, 31 Aug 2023 22:36:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230831162954.111485-1-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 6:29 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When using the "install" or targets depending on install,
> e.g. "gen_tar", the BPF machine flavors weren't included.
> 
> A command like:
>    | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
>    |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
>    |    -C tools/testing/selftests gen_tar
> would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.
> 
> Include the BPF machine flavors for "install" make target.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Lgtm, applied, thanks!

