Return-Path: <bpf+bounces-77939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE506CF86F0
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B7E3038189
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D632F751;
	Tue,  6 Jan 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cmD2ttOr"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA332ED27;
	Tue,  6 Jan 2026 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705140; cv=none; b=S8Q7eHs6oe2U4wmF2VW/vZoxYOaoTN3MYLCrXeTOXhoBA5Dyc9LcejYg/Djt2bEGk+zr3rkyVjuwN2h8uDxwkioX0r1bFASuTxqz5Zk3VBBvaBnLRPMycUtwKQXMYv1Tav5K5PnD2tHCf1IUf+kIIQ5dzCE75Id1azcIynKoe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705140; c=relaxed/simple;
	bh=Bdv/9Apil9GsQrz9Iyd7SQghRPpsyfcb/tFA8K+sz+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv2vPFB9/6wbSf19O/5LSRlxoWt07wi9VzxGcHtZvYLNqBThAjEQuSR4/kHkdqW3SbiMwsRe8S2e6SI5KUn+hjhGRaxBhNeIAcPQU6C+s7cdaChbay5OztI6YzmAdpi97bjksIY9koi4QAb2UC8mYq01pMkCKYf44yaa1bq+RhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cmD2ttOr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jtPJL4ueN+NLUJL1/EIAuRCHXAci0f2p2ksqNzuXF/Y=; b=cmD2ttOrmjUI0wOuG/vL8jIx8b
	+axfpKvjrUxojLQwP1+0rKJtqa6LLNCUpz/KGT78cADU2wVu+uIhH3LIL6LB+UV3jqiSZD+iolkws
	SwNRjO8g+qNiwllTW2G6n2dc5R9AhA4JFXEBuyWvhGJtd3RRADkUNranKMHsjmaoCoKihinhKyMDC
	zZd+uYpURPT2w/IjY15LpwuNZ+/Owe8xug2wL8bO9tDGkrI6bmOpWBZC9t/RmwpXiV5gpxqgYUvuh
	aQyQcuFJOhs5ufqPWQFhlFB0UyTZmXS6482TrRBnipb2UANCB1nBnCY06o6XUDTttFeqtT59NW1SD
	MZuuwgFg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vd6qm-000Esp-06;
	Tue, 06 Jan 2026 14:11:52 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vd6qk-000Fm9-1l;
	Tue, 06 Jan 2026 14:11:50 +0100
Message-ID: <545a9978-41fb-485b-8ad8-fe759322d4a4@iogearbox.net>
Date: Tue, 6 Jan 2026 14:11:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: Add 'prepend' option for tcx attach to insert
 at chain start
To: gyutae.opensource@navercorp.com, Quentin Monnet <qmo@kernel.org>,
 bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Gyutae Bae <gyutae.bae@navercorp.com>,
 Siwan Kim <siwan.kim@navercorp.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
 <20260106085527.4774-1-gyutae.opensource@navercorp.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260106085527.4774-1-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27872/Tue Jan  6 08:24:33 2026)

Hi Gyutae,

On 1/6/26 9:55 AM, gyutae.opensource@navercorp.com wrote:
> From: Gyutae Bae <gyutae.bae@navercorp.com>
> 
> Add support for the 'prepend' option when attaching tcx_ingress and
> tcx_egress programs. This option allows inserting a BPF program at
> the beginning of the TCX chain instead of appending it at the end.
> 
> The implementation queries the first program ID in the chain and uses
> BPF_F_BEFORE flag with the relative_id to insert the new program before
> the existing first program. If the chain is empty, the program is simply
> attached normally.
> 
> This change includes:
> - Add get_first_tcx_prog_id() helper to retrieve the first program ID
> - Modify do_attach_tcx() to support prepend insertion using BPF_F_BEFORE
> - Update documentation to describe the new 'prepend' option
> - Add bash completion support for the 'prepend' option on tcx attach types
> - Add example usage in the documentation
> 
> The 'prepend' option is only valid for tcx_ingress and tcx_egress attach
> types. For XDP attach types, the existing 'overwrite' option remains
> available.
> 
> Example usage:
>    # bpftool net attach tcx_ingress name tc_prog dev lo prepend
> 
> This feature is useful when the order of program execution in the TCX
> chain matters and users need to ensure certain programs run first.

Could we make this a bit more generic? The internal API has BPF_F_BEFORE
and BPF_F_AFTER flags, so we could also support relative ids. Alternatively
"prepend" / "append" is imho also ok and the "before" / "after" could be
added at a later point to bpftool.

BPF_F_BEFORE as a standalone flag (and BPF_F_AFTER as a standalone) flag
will have prepend and append behavior, so your approach of adding
get_first_tcx_prog_id() helper to retrieve the first program id is not
necessary, see also tcx BPF selftests [0].

Thanks,
Daniel

   [0] tools/testing/selftests/bpf/prog_tests/tc_links.c

