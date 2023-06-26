Return-Path: <bpf+bounces-3442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238A73E087
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503D6280D57
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696E946F;
	Mon, 26 Jun 2023 13:22:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617D8F70
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:22:46 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15E13D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1F5V+tAhtFXE3Nrld/EhowGF6d47PsWQwOj2ibbQ3Dw=; b=EetL7g0AsOTZzUSB75jDwRiPKK
	MXahT/jPjjGsYrhQJ8+Y1Nml1EopXSnW4YDAZN7nIZFqdVeomhqWoHfLNO0B8hf3mXxDKPm8GIQ6N
	B1EwQBgAJdQWpYpCWyyx6eSOotXMkuKRVTdg6rjmEtu+S2NqPNSNxpYyvPXlM/QkZVxnYq3HUANMr
	4ieDgI661xwfMgAjrTjQXoFuRT+EAFCrqL7LySzZL8nRbNJO9UhB2uk6L5YpD1Y6tG37vYu7AR2u+
	QKzrgfwHynr9uy5gTNaGpyrfExWq1TmD2j9AbdJFiSGkC2wXXe4jjcC18gBy2OwMlWyLPGk3zjT5O
	XjwbgapQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDmB1-000OLU-Ul; Mon, 26 Jun 2023 15:22:43 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDmB1-000UsH-Mn; Mon, 26 Jun 2023 15:22:43 +0200
Subject: Re: selftests/bpf bpf_nf is failing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <CAADnVQ+0dnDq_v_vH1EfkacbfGnHANaon7zsw10pMb-D9FS0Pw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f01a9cc0-7dc9-ed47-aef1-778c3240de1e@iogearbox.net>
Date: Mon, 26 Jun 2023 15:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+0dnDq_v_vH1EfkacbfGnHANaon7zsw10pMb-D9FS0Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26951/Mon Jun 26 09:29:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/25/23 8:57 PM, Alexei Starovoitov wrote:
> Hi,
> 
> after fast forwarding bpf-next today bpf_nf test started to fail
> when run twice:
> 
> $ ./test_progs -t bpf_nf
> #17      bpf_nf:OK
> Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> 
> 
> $ ./test_progs -t bpf_nf
> ll error logs:
> test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
> test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
> --set-mark 42/0 0 nsec
> (network_helpers.c:102: errno: Address already in use) Failed to bind socket
> test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
> #17/1    bpf_nf/xdp-ct:FAIL
> test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
> test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
> --set-mark 42/0 0 nsec
> (network_helpers.c:102: errno: Address already in use) Failed to bind socket
> test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
> #17/2    bpf_nf/tc-bpf-ct:FAIL
> #17      bpf_nf:FAIL
> Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED
> 
> Some kind of clean up issue.
> Don't see anything obvious that might have caused it.
> Ideas?

Was able to repro as well, fixed here:

https://lore.kernel.org/bpf/20230626131942.5100-1-daniel@iogearbox.net/

Thanks,
Daniel

