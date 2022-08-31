Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE65A87B0
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiHaUqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHaUqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 16:46:19 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62842F23E9
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 13:46:18 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTUbI-000FqZ-HK; Wed, 31 Aug 2022 22:46:16 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTUbI-000CYx-Au; Wed, 31 Aug 2022 22:46:16 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: Support getting tunnel flags
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
References: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3b4e74bb-5ede-e773-69e6-6c272ffa2459@iogearbox.net>
Date:   Wed, 31 Aug 2022 22:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26644/Wed Aug 31 09:53:02 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/22 4:40 PM, Shmulik Ladkani wrote:
> Existing 'bpf_skb_get_tunnel_key' extracts various tunnel parameters
> (id, ttl, tos, local and remote) but does not expose ip_tunnel_info's
> tun_flags to the bpf program.
> 
> It makes sense to expose tun_flags to the bpf program.
> 
> Assume for example multiple GRE tunnels maintained on a single GRE
> interface in collect_md mode. The program expects origins to initiate
> over GRE, however different origins use different GRE characteristics
> (e.g. some prefer to use GRE checksum, some do not; some pass a GRE key,
> some do not, etc..).
> 
> A bpf program getting tun_flags can therefore remember the relevant
> flags (e.g. TUNNEL_CSUM, TUNNEL_SEQ...) for each initiating remote.
> In the reply path, the program can use 'bpf_skb_set_tunnel_key' in order
> to correctly reply to the remote, using similar characteristics, based on
> the stored tunnel flags.
> 
> Introduce BPF_F_TUNINFO_FLAGS flag for bpf_skb_get_tunnel_key.
> If specified, 'bpf_tunnel_key->tunnel_flags' is set with the tun_flags.
> 
> Decided to use the existing unused 'tunnel_ext' as the storage for the
> 'tunnel_flags' in order to avoid changing bpf_tunnel_key's layout.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>

The set looks good to me, one comment below..

> ---
>   include/uapi/linux/bpf.h       | 10 +++++++++-
>   net/core/filter.c              |  8 ++++++--
>   tools/include/uapi/linux/bpf.h | 10 +++++++++-
>   3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 962960a98835..837c0f9b7fdd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5659,6 +5659,11 @@ enum {
>   	BPF_F_SEQ_NUMBER		= (1ULL << 3),
>   };
>   
> +/* BPF_FUNC_skb_get_tunnel_key flags. */
> +enum {
> +	BPF_F_TUNINFO_FLAGS		= (1ULL << 4),
> +};
> +
>   /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
>    * BPF_FUNC_perf_event_read_value flags.
>    */
> @@ -5848,7 +5853,10 @@ struct bpf_tunnel_key {
>   	};
>   	__u8 tunnel_tos;
>   	__u8 tunnel_ttl;
> -	__u16 tunnel_ext;	/* Padding, future use. */
> +	union {
> +		__u16 tunnel_ext;	/* compat */
> +		__be16 tunnel_flags;
> +	};
>   	__u32 tunnel_label;
>   	union {
>   		__u32 local_ipv4;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 63e25d8ce501..74e2a4a0d747 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4488,7 +4488,8 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
>   	void *to_orig = to;
>   	int err;
>   
> -	if (unlikely(!info || (flags & ~(BPF_F_TUNINFO_IPV6)))) {
> +	if (unlikely(!info || (flags & ~(BPF_F_TUNINFO_IPV6 |
> +					 BPF_F_TUNINFO_FLAGS)))) {
>   		err = -EINVAL;
>   		goto err_clear;
>   	}
> @@ -4520,7 +4521,10 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
>   	to->tunnel_id = be64_to_cpu(info->key.tun_id);
>   	to->tunnel_tos = info->key.tos;
>   	to->tunnel_ttl = info->key.ttl;
> -	to->tunnel_ext = 0;
> +	if (flags & BPF_F_TUNINFO_FLAGS)
> +		to->tunnel_flags = info->key.tun_flags;
> +	else
> +		to->tunnel_ext = 0;

The bpf_skb_set_tunnel_key() helper has a number of flags we pass in, e.g.
BPF_F_ZERO_CSUM_TX, BPF_F_DONT_FRAGMENT, BPF_F_SEQ_NUMBER, and then based on
those flags we set:

   [...]
   info->key.tun_flags = TUNNEL_KEY | TUNNEL_CSUM | TUNNEL_NOCACHE;
   if (flags & BPF_F_DONT_FRAGMENT)
           info->key.tun_flags |= TUNNEL_DONT_FRAGMENT;
   if (flags & BPF_F_ZERO_CSUM_TX)
           info->key.tun_flags &= ~TUNNEL_CSUM;
   if (flags & BPF_F_SEQ_NUMBER)
           info->key.tun_flags |= TUNNEL_SEQ;
   [...]

Should we similarly only expose those which are interesting/relevant to BPF
program authors as a __u16 tunnel_flags and not the whole set? Which ones
do you have a need for? TUNNEL_SEQ, TUNNEL_CSUM, TUNNEL_KEY, and then the
TUNNEL_OPTIONS_PRESENT?

Thanks,
Daniel
