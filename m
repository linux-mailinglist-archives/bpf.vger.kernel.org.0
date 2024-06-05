Return-Path: <bpf+bounces-31442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877FD8FD105
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBBDB22A51
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9422EE8;
	Wed,  5 Jun 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="icH/CYo7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479610A01;
	Wed,  5 Jun 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598606; cv=none; b=M3uaHxKtq2kiwfT5tkzoDQZ1d5NMTmG2hdB2MyW3iA0CFFvIgU0RRbqQS08o5xJEKnBgXF8y8z2O35s8R/MoTR5gAdEhZigqceWaKXs4JaX4laoe/1iF6M/9WoCHz1a5P1b2ZlJXpackB/br7/HMUBy5aSSoarjaGLHzL+9eA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598606; c=relaxed/simple;
	bh=V7cJ8zOueD8Gi9a3nnrQi8QJbi3Mdglga2K1XlkHWSk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OuBOcL38pUVyQG1aslcd0NW32cok1qvQrj3eJt5FHmej7uzsoRRg7odB4uxSc1cThHqaSbkPKiwJzbjYyI7eY7eLzGGkY/PwXAwNZDbNQnKjBi3tLHA/4Zhx8h4ZKHHqpT1L+mS8fEZKlMGEAIRTxde+4RNayuXNdLOQhRvGiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=icH/CYo7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xyiEWUdZqzs9S8uO/LjVKLKJc0gX/bzVFQwHgrRet94=; b=icH/CYo7uWPH3qPIqDSmhGBXlo
	fM425noqnaOQBA+0ofN1t1kbAj8RvrKNFGGsqyR34nXcv+Y2Foclr7p6WiJGG1GflsFQxD2JNoOWd
	5IUKAFMzZrKi6NAKyaUtk/LGHdc2FBl4MMBMVCBG+udVsgzkc778hnaQYH2CXmkcJtigl5MYBVNe6
	+EbJmP6y2fQ48vqgp2w4gfH0cxYbo2hZukomSLulD4OHNgqaOLu5ZjX+CK6Judtml61HjtY6p7AhO
	LFHAQ8bxE3vN5WZSkHQRLJ154Vz5sxGL1+0LMvhzwPKaEw2gdj1U7Ds+XQOu32trhsr6iJ3DL2sTg
	owcYa67Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sErrD-000Nhu-6H; Wed, 05 Jun 2024 16:43:19 +0200
Received: from [178.197.248.29] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sErrD-0002Oc-11;
	Wed, 05 Jun 2024 16:43:18 +0200
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>
References: <20240527185928.1871649-1-vadfed@meta.com>
 <f7fe13a8-c379-495b-9e42-3a5ff50b50e3@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <05dfb8f6-4325-62c9-b0b0-1bc22f0f8d93@iogearbox.net>
Date: Wed, 5 Jun 2024 16:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7fe13a8-c379-495b-9e42-3a5ff50b50e3@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27297/Wed Jun  5 10:30:56 2024)

On 6/5/24 11:42 AM, Vadim Fedorenko wrote:
> On 27/05/2024 19:59, Vadim Fedorenko wrote:
>> Add special flag to validate that TC BPF program properly updates
>> checksum information in skb.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   include/uapi/linux/bpf.h       |  2 ++
>>   net/bpf/test_run.c             | 18 +++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |  2 ++
>>   3 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 90706a47f6ff..f7d458d88111 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1425,6 +1425,8 @@ enum {
>>   #define BPF_F_TEST_RUN_ON_CPU    (1U << 0)
>>   /* If set, XDP frames will be transmitted after processing */
>>   #define BPF_F_TEST_XDP_LIVE_FRAMES    (1U << 1)
>> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE    (1U << 2)
>>   /* type for BPF_ENABLE_STATS */
>>   enum bpf_stats_type {
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index f6aad4ed2ab2..4c21562ad526 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -977,7 +977,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>       void *data;
>>       int ret;
>> -    if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
>> +    if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
>> +        kattr->test.cpu || kattr->test.batch_size)
>>           return -EINVAL;
>>       data = bpf_test_init(kattr, kattr->test.data_size_in,
>> @@ -1025,6 +1026,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>       skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
>>       __skb_put(skb, size);
>> +
>> +    if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>> +        skb->csum = skb_checksum(skb, 0, skb->len, 0);
>> +        skb->ip_summed = CHECKSUM_COMPLETE;
>> +    }
>> +
>>       if (ctx && ctx->ifindex > 1) {
>>           dev = dev_get_by_index(net, ctx->ifindex);
>>           if (!dev) {
>> @@ -1079,6 +1086,15 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>       }
>>       convert_skb_to___skb(skb, ctx);
>> +    if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>> +        __wsum csum = skb_checksum(skb, 0, skb->len, 0);
>> +
>> +        if (skb->csum != csum) {
>> +            ret = -EBADMSG;
>> +            goto out;
>> +        }
>> +    }
>> +
>>       size = skb->len;
>>       /* bpf program can never convert linear skb to non-linear */
>>       if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 90706a47f6ff..f7d458d88111 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1425,6 +1425,8 @@ enum {
>>   #define BPF_F_TEST_RUN_ON_CPU    (1U << 0)
>>   /* If set, XDP frames will be transmitted after processing */
>>   #define BPF_F_TEST_XDP_LIVE_FRAMES    (1U << 1)
>> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE    (1U << 2)
>>   /* type for BPF_ENABLE_STATS */
>>   enum bpf_stats_type {
> 
> Hi Daniel!
> 
> Have you had a chance to look at v3 of this patch?
> I think I addressed all your comments form v2.

Looks good, but I think there is something off given the test on arm64 and s390x
fails in skb_pkt_end with EBADMSG. I wonder if we're missing a :

   skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);

right after the eth_type_trans()?

Thanks,
Daniel

