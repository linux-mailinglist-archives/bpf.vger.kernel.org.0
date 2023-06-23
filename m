Return-Path: <bpf+bounces-3251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE973B5BA
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FD81C210FA
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAF1FCF;
	Fri, 23 Jun 2023 10:51:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6515A2
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:51:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23BE6D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uLLQLrsnWHwVZLaK3hn9mldZ0h1G4OW4xAx9lT6pycQ=; b=im2E+IulJBy++GaciBixgw/BNM
	9eiUKCp7r79bP27chWIR2Ycdu2BEIO3CB1DE4xyZu73RpJkOhMRHc4XCYk0o6rRmqXI8ub0J46opj
	Qw3crsO+OFTyb5rV43j3veXYlYoXoghczSbKx4Y+mMo/gXXGttZHQ8IJFGRNCrANaQlcdlCoxiJgT
	LESiGNY64ztq/o1217FKeu1/pelb9nlsMQ21i7jH+A09WpKFrLq7o1mXD8X4Xm+Yi+X/n64LBegAL
	A2IYWrObR5fXEfN51fCIAV97+MDTkXoeUG8BBxf7rGHKhaxxjlgczVISGuEwJW8fwMBLIJjr1S6Ya
	UIi4Kicg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCeNu-000JmS-HM; Fri, 23 Jun 2023 12:51:22 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCeNu-000DqF-3G; Fri, 23 Jun 2023 12:51:22 +0200
Subject: Re: [RFC v2 PATCH bpf-next 1/4] bpf: add percpu stats for bpf_map
 elements insertions/deletions
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095330.1023453-2-aspsk@isovalent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8e18e99d-afca-8afd-6777-c9d0b728baf5@iogearbox.net>
Date: Fri, 23 Jun 2023 12:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230622095330.1023453-2-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/22/23 11:53 AM, Anton Protopopov wrote:
> Add a generic percpu stats for bpf_map elements insertions/deletions in order
> to keep track of both, the current (approximate) number of elements in a map
> and per-cpu statistics on update/delete operations.
> 
> To expose these stats a particular map implementation should initialize the
> counter and adjust it as needed using the 'bpf_map_*_elements_counter' helpers
> provided by this commit. The counter can be read by an iterator program.
> 
> A bpf_map_sum_elements_counter kfunc was added to simplify getting the sum of
> the per-cpu values. If a map doesn't implement the counter, then it will always
> return 0.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>   include/linux/bpf.h   | 30 +++++++++++++++++++++++++++
>   kernel/bpf/map_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..20292a096188 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -275,6 +275,7 @@ struct bpf_map {
>   	} owner;
>   	bool bypass_spec_v1;
>   	bool frozen; /* write-once; write-protected by freeze_mutex */
> +	s64 __percpu *elements_count;

To avoid corruption on 32 bit archs, should we convert this into local64_t here?

