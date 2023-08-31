Return-Path: <bpf+bounces-9071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0078F057
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9558D1C20AC8
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D04212B96;
	Thu, 31 Aug 2023 15:30:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25069470
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 15:30:18 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C68F
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=W1giZaq0v3yTkYvDH3LSdMwJhA49Na1usuzf7h04k1g=; b=q3gasD4oNq65/YXOXaE0AMlzmF
	c14pbac9JQi7lkEh1kIrgPGIEeuXQ9yUtcuL8M/yUteERx1LvlrUl77dacfcq/9dytaT/rYOEKmVM
	w6/qgIyJGOn0Dwdt/o4Jo23uRsuoohNvkCmw3dg/xYn4aWZ5dZlnydCQ6hR4+AlsBZZsvpYAaJ9/F
	k0Iv+5um87qj+NBPfsVIEf4tgLGH4YOR5Y4AjOtsyaFWDXLdSYzrf2gtX0RfrZQ6a8+2t1IoFdTFz
	+NCph5RGuKa+eMPOyRBF3WIIwZT6LoaX4B4Ftg50kdn//uAvliILz37ECUYS6Nta2EXtlh/oieqdg
	wAd+eyyA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbjcZ-0000XS-CC; Thu, 31 Aug 2023 17:30:11 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbjcZ-00056k-9v; Thu, 31 Aug 2023 17:30:11 +0200
Subject: Re: [PATCH bpf-next 02/11] net: netfilter: Adjust timeouts of
 non-confirmed CTs in bpf_ct_insert_entry()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, fw@strlen.de
References: <20230830011128.1415752-1-iii@linux.ibm.com>
 <20230830011128.1415752-3-iii@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08f2e910-2bd8-8cf6-688b-4bdf0161c969@iogearbox.net>
Date: Thu, 31 Aug 2023 17:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230830011128.1415752-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ +Florian ]

On 8/30/23 3:07 AM, Ilya Leoshkevich wrote:
> bpf_nf testcase fails on s390x: bpf_skb_ct_lookup() cannot find the
> entry that was added by bpf_ct_insert_entry() within the same BPF
> function.
> 
> The reason is that this entry is deleted by nf_ct_gc_expired().
> 
> The CT timeout starts ticking after the CT confirmation; therefore
> nf_conn.timeout is initially set to the timeout value, and
> __nf_conntrack_confirm() sets it to the deadline value.
> bpf_ct_insert_entry() sets IPS_CONFIRMED_BIT, but does not adjust the
> timeout, making its value meaningless and causing false positives.
> 
> Fix the problem by making bpf_ct_insert_entry() adjust the timeout,
> like __nf_conntrack_confirm().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Should we route this fix via bpf tree instead? Also, could you reply with
a Fixes tag?

> ---
>   net/netfilter/nf_conntrack_bpf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index c7a6114091ae..b21799d468d2 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -381,6 +381,8 @@ __bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
>   	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
>   	int err;
>   
> +	if (!nf_ct_is_confirmed(nfct))
> +		nfct->timeout += nfct_time_stamp;
>   	nfct->status |= IPS_CONFIRMED;
>   	err = nf_conntrack_hash_check_insert(nfct);
>   	if (err < 0) {
> 

Thanks,
Daniel

