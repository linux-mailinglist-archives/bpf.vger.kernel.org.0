Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92965419783
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhI0PQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 11:16:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:37792 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhI0PQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 11:16:01 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUsKk-000E2b-93; Mon, 27 Sep 2021 17:14:22 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUsKk-000Odg-4C; Mon, 27 Sep 2021 17:14:22 +0200
Subject: Re: [PATCH v3 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com
References: <20210922234113.1965663-1-andrii@kernel.org>
 <20210922234113.1965663-3-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <270e27b1-e5be-5b1c-b343-51bd644d0747@iogearbox.net>
Date:   Mon, 27 Sep 2021 17:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210922234113.1965663-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26305/Mon Sep 27 11:04:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/23/21 1:41 AM, Andrii Nakryiko wrote:
> Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> extra characters. In reference_tracking selftests also drop the usage of
> broken bpf_program__load(). Along the way switch from ambiguous searching by
> program title (section name) to non-ambiguous searching by name in some
> selftests, getting closer to completely removing
> bpf_object__find_program_by_title().
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> index fe818cd5f010..7d0256d7db82 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> @@ -16,31 +16,31 @@ volatile const __u32 IFINDEX_DST;
>   static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
>   static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
>   
> -SEC("classifier/chk_egress")
> +SEC("classifier")

Can be a follow-up, but lets just deprecate the whole "classifier" terminology
for libbpf since tc BPF programs do significantly more than just that since long
time and it's otherwise just a confusing UX. The whole "classifier" / "action"
terminology is just remains from legacy tc. See also libbpf.h's 'TC related API'
where there is no notion of "classifier". Given you have SEC("xdp"), lets name
all these in here SEC("tc"), and for compat we can keep the old "classifier" name
as a hidden option in libbpf if we have to.

>   int tc_chk(struct __sk_buff *skb)
>   {
>   	return TC_ACT_SHOT;
>   }
>   
> -SEC("classifier/dst_ingress")
> +SEC("classifier")
>   int tc_dst(struct __sk_buff *skb)
>   {
>   	return bpf_redirect_peer(IFINDEX_SRC, 0);
>   }
>   
> -SEC("classifier/src_ingress")
> +SEC("classifier")
>   int tc_src(struct __sk_buff *skb)
>   {
>   	return bpf_redirect_peer(IFINDEX_DST, 0);
>   }
>   
> -SEC("classifier/dst_ingress_l3")
> +SEC("classifier")
>   int tc_dst_l3(struct __sk_buff *skb)
>   {
>   	return bpf_redirect(IFINDEX_SRC, 0);
>   }
>   
> -SEC("classifier/src_ingress_l3")
> +SEC("classifier")
>   int tc_src_l3(struct __sk_buff *skb)
>   {
>   	__u16 proto = skb->protocol;
> 

