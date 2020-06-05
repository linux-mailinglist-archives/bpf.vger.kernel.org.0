Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697F31EFC68
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFEPWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 11:22:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:54748 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgFEPWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 11:22:53 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jhEBF-0001dt-4T; Fri, 05 Jun 2020 17:22:49 +0200
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jhEBE-000ElW-SX; Fri, 05 Jun 2020 17:22:48 +0200
Subject: Re: [PATCH] bpf: export the net namespace for bpf_sock_ops
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Wang Li <wangli8850@gmail.com>
Cc:     bpf@vger.kernel.org, Wang Li <wangli09@kuaishou.com>,
        huangxuesen <huangxuesen@kuaishou.com>,
        yangxingwu <yangxingwu@kuaishou.com>
References: <20200605124011.71043-1-wangli09@kuaishou.com>
 <875zc536o1.fsf@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d24c64f3-ed56-213d-028a-4f8168be6f33@iogearbox.net>
Date:   Fri, 5 Jun 2020 17:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <875zc536o1.fsf@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25834/Fri Jun  5 14:46:05 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/5/20 4:53 PM, Jakub Sitnicki wrote:
> On Fri, Jun 05, 2020 at 02:40 PM CEST, Wang Li wrote:
>> Sometimes we need net namespace as part of the key for BPF_MAP_TYPE_SOCKHASH to
>> distinguish the connections with same five-tuples, for example when we do the
>> sock_map acceleration for the proxy that uses 127.0.0.1 to 127.0.0.1 connections
>> in different containers on same node.
>> And we export the netns inum instead of the real pointer of struct net to avoid
>> the potential security issue.
>>
>> Signed-off-by: Wang Li <wangli09@kuaishou.com>
>> Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
>> Signed-off-by: yangxingwu <yangxingwu@kuaishou.com>
>> ---
>>   include/uapi/linux/bpf.h       |  2 ++
>>   net/core/filter.c              | 17 +++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  2 ++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c65b374a5090..0fe7e459f023 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
>>   				 * there is a full socket. If not, the
>>   				 * fields read as zero.
>>   				 */
>> +	__u32 netns_inum;	/* The net namespace this sock belongs to */
>> +
> 
> In uapi/linux/bpf.h we have a field `netns_ino` for storing net
> namespace inode number in a couple structs (bpf_prog_info,
> bpf_map_info). Would be nice to keep the naming constent.

Adding in the middle will break programs. Also, currently we have the
merge window open and as such bpf-next is closed. Check status here [0].

Regarding above, we recently added bpf_get_netns_cookie() helper, have
you tried to enable this one instead?

   [0] http://vger.kernel.org/~davem/net-next.html

>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index d01a244b5087..bfe448ace25f 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -8450,6 +8450,23 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>>   					       is_fullsock));
>>   		break;
>>
>> +	case offsetof(struct bpf_sock_ops, netns_inum):
>> +#ifdef CONFIG_NET_NS
>> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
>> +						struct bpf_sock_ops_kern, sk),
>> +				      si->dst_reg, si->src_reg,
>> +				      offsetof(struct bpf_sock_ops_kern, sk));
>> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
>> +						struct sock_common, skc_net),
>> +				      si->dst_reg, si->dst_reg,
>> +				      offsetof(struct sock_common, skc_net));
>> +		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
>> +				      offsetof(struct net, ns.inum));
>> +#else
>> +		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
>> +#endif
>> +		break;
>> +
>>   	case offsetof(struct bpf_sock_ops, state):
>>   		BUILD_BUG_ON(sizeof_field(struct sock_common, skc_state) != 1);
>>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index c65b374a5090..0fe7e459f023 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
>>   				 * there is a full socket. If not, the
>>   				 * fields read as zero.
>>   				 */
>> +	__u32 netns_inum;	/* The net namespace this sock belongs to */
>> +
>>   	__u32 snd_cwnd;
>>   	__u32 srtt_us;		/* Averaged RTT << 3 in usecs */
>>   	__u32 bpf_sock_ops_cb_flags; /* flags defined in uapi/linux/tcp.h */

