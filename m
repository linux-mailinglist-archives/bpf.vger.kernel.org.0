Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71CF6EC344
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 02:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDXASy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 20:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDXASy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 20:18:54 -0400
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98E10E7
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 17:18:52 -0700 (PDT)
Message-ID: <86732f12-a53d-7d3b-9b8f-a717fd3237e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682295530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2SxV+f0fJNo1aGnh+j4Ex6/q3QYbjoO0xUk/nJGvUY=;
        b=n/h6uk9DmseoImvW34yxV8JpI8BY2toSrV/Va6gul1VBCUNX8f5wcibytv5LvHLyM4G4C7
        gabNGiUF2AxI5oKpGDJzSqtCrUVmfoNSP6yuSqk0TI0L9NwmiTWaAJfgSXN72iiUPrsRkV
        Cim2k1VHjBrXxmZN54I8Ava59M2bmjY=
Date:   Sun, 23 Apr 2023 17:18:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] udp: seq_file: Remove bpf_seq_afinfo from
 udp_iter_state
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-3-aditi.ghag@isovalent.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230418153148.2231644-3-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 8:31 AM, Aditi Ghag wrote:
> This is a preparatory commit to remove the field. The field was
> previously shared between proc fs and BPF UDP socket iterators. As the
> follow-up commits will decouple the implementation for the iterators,
> remove the field. As for BPF socket iterator, filtering of sockets is
> exepected to be done in BPF programs.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   include/net/udp.h |  1 -
>   net/ipv4/udp.c    | 34 ++++------------------------------
>   2 files changed, 4 insertions(+), 31 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..5cad44318d71 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,7 +437,6 @@ struct udp_seq_afinfo {
>   struct udp_iter_state {
>   	struct seq_net_private  p;
>   	int			bucket;
> -	struct udp_seq_afinfo	*bpf_seq_afinfo;
>   };
>   
>   void *udp_seq_start(struct seq_file *seq, loff_t *pos);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c605d171eb2d..3c9eeee28678 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2997,10 +2997,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
>   	struct udp_table *udptable;
>   	struct sock *sk;
>   
> -	if (state->bpf_seq_afinfo)
> -		afinfo = state->bpf_seq_afinfo;
> -	else
> -		afinfo = pde_data(file_inode(seq->file));
> +	afinfo = pde_data(file_inode(seq->file));

I can see how this change will work after patch 4. However, this patch alone 
cannot work independently as is. The udp bpf iter still uses the 
udp_get_{first,next} and udp_seq_stop() up-to this patch.

First, patch 3 refactoring should be done before patch 2 here. The removal of 
'struct udp_seq_afinfo *bpf_seq_afinfo' in patch 2 should be done when all the 
necessary refactoring is in-place first.

Also, this afinfo is passed to udp_get_table_afinfo(). How about renaming 
udp_get_table_afinfo() to udp_get_table_seq() and having it take the "seq" as 
the arg instead. This probably will deserve another refactoring patch before 
finally removing bpf_seq_afinfo. Something like this (un-compiled code):

static struct udp_table *udp_get_table_seq(struct seq_file *seq,
                                            struct net *net)
{
  	const struct udp_seq_afinfo *afinfo;

         if (st->bpf_seq_afinfo)
                 return net->ipv4.udp_table;

	afinfo = pde_data(file_inode(seq->file));
         return afinfo->udp_table ? : net->ipv4.udp_table;
}

Of course, when the later patch finally removes the bpf_seq_afinfo, the 'if 
(st->bpf_seq_afinfo)' test should be replaced with the 'if (seq->op == 
&bpf_iter_udp_seq_ops)' test.

That will also make the afinfo dance in bpf_iter_udp_batch() in patch 4 goes away.

>   
>   	udptable = udp_get_table_afinfo(afinfo, net);
>   
> @@ -3033,10 +3030,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
>   	struct udp_seq_afinfo *afinfo;
>   	struct udp_table *udptable;
>   
> -	if (state->bpf_seq_afinfo)
> -		afinfo = state->bpf_seq_afinfo;
> -	else
> -		afinfo = pde_data(file_inode(seq->file));
> +	afinfo = pde_data(file_inode(seq->file));
>   
>   	do {
>   		sk = sk_next(sk);
> @@ -3094,10 +3088,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
>   	struct udp_seq_afinfo *afinfo;
>   	struct udp_table *udptable;
>   
> -	if (state->bpf_seq_afinfo)
> -		afinfo = state->bpf_seq_afinfo;
> -	else
> -		afinfo = pde_data(file_inode(seq->file));
> +	afinfo = pde_data(file_inode(seq->file));
>   
>   	udptable = udp_get_table_afinfo(afinfo, seq_file_net(seq));
>   
> @@ -3415,28 +3406,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
>   
>   static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   {
> -	struct udp_iter_state *st = priv_data;
> -	struct udp_seq_afinfo *afinfo;
> -	int ret;
> -
> -	afinfo = kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
> -	if (!afinfo)
> -		return -ENOMEM;
> -
> -	afinfo->family = AF_UNSPEC;
> -	afinfo->udp_table = NULL;
> -	st->bpf_seq_afinfo = afinfo;
> -	ret = bpf_iter_init_seq_net(priv_data, aux);
> -	if (ret)
> -		kfree(afinfo);
> -	return ret;
> +	return bpf_iter_init_seq_net(priv_data, aux);

Nice simplification with the bpf_seq_afinfo cleanup.

>   }
>   
>   static void bpf_iter_fini_udp(void *priv_data)
>   {
> -	struct udp_iter_state *st = priv_data;
> -
> -	kfree(st->bpf_seq_afinfo);
>   	bpf_iter_fini_seq_net(priv_data);
>   }
>   

