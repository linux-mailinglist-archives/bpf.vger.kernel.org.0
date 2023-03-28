Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54686CC19F
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 16:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjC1OBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 10:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjC1OBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C6D330;
        Tue, 28 Mar 2023 06:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1662617EF;
        Tue, 28 Mar 2023 13:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01537C4339B;
        Tue, 28 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680011989;
        bh=TIaiJGqVwYcsGIVyEy9gmWNG6jN0YbCOiRZYge17MZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ro376/MrBC3LOm/tILoXK7dS9K9FQYXBjcHjYEh2e1OihRFqhpFIKgpoxL8dEW652
         dI3Tore6wa2HNs5DN81XAruye/dpJpMGp5oEmeUTlqNt8CZZVpwzMVgkvoJ80ij0CG
         19euS0Z2kyhpDeAgVJCcN2xurLzALH/9XvbyJBOn7DPclF5Q3ZE//QvcnLMrH94Rx6
         e54RDmsewS6ytyN9iGhrrvOawd5tsQq9pwDAXPzcwDJrVvfKzqDNksLjqftef4++f4
         kq6mIMNw1D9yUEZ9Myj35WUbp4w1YdPrvTFLadMIbtHzxFFJpsMrfH6EEAhV+OFDtB
         LDwHv5k0WJrFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3025B4052D; Tue, 28 Mar 2023 10:59:46 -0300 (-03)
Date:   Tue, 28 Mar 2023 10:59:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCLy0hjyR3KuYy3e@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314230417.1507266-2-eddyz87@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
> The following example contains a structure field annotated with
> btf_type_tag attribute:
> 
>     #define __tag1 __attribute__((btf_type_tag("tag1")))
> 
>     struct st {
>       int __tag1 *a;
>     } g;
> 
> It is not printed correctly by `pahole -F dwarf` command:
> 
>     $ clang -g -c test.c -o test.o
>     pahole -F dwarf test.o
>     struct st {
>     	tag1 *                     a;                    /*     0     8 */
>     	...
>     };
> 
> Note the type for variable `a`: `tag1` is printed instead of `int`.
> This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
> `DW_TAG_LLVM_annotation` objects that are used to encode type tags.

I noticed this:

⬢[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-clang-pahole-1.25+rust > /tmp/clang
⬢[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-gcc-pahole-1.25+rust > /tmp/gcc


--- /tmp/gcc    2023-03-28 10:55:37.075999474 -0300
+++ /tmp/clang  2023-03-28 10:55:53.324436319 -0300
@@ -70,21 +70,21 @@
 struct Qdisc {
        int                        (*enqueue)(struct sk_buff *, struct Qdisc *, struct sk_buff * *); /*     0     8 */
        struct sk_buff *           (*dequeue)(struct Qdisc *); /*     8     8 */
        unsigned int               flags;                /*    16     4 */
        u32                        limit;                /*    20     4 */
        const struct Qdisc_ops  *  ops;                  /*    24     8 */
-       struct qdisc_size_table *  stab;                 /*    32     8 */
+       struct qdisc_size_table    stab;                 /*    32     8 */
        struct hlist_node          hash;                 /*    40    16 */
        u32                        handle;               /*    56     4 */
        u32                        parent;               /*    60     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct netdev_queue *      dev_queue;            /*    64     8 */
-       struct net_rate_estimator * rate_est;            /*    72     8 */
-       struct gnet_stats_basic_sync * cpu_bstats;       /*    80     8 */
-       struct gnet_stats_queue *  cpu_qstats;           /*    88     8 */
+       struct net_rate_estimator  rate_est;             /*    72     8 */
+       struct gnet_stats_basic_sync cpu_bstats;         /*    80     8 */
+       struct gnet_stats_queue    cpu_qstats;           /*    88     8 */
        int                        pad;                  /*    96     4 */
        refcount_t                 refcnt;               /*   100     4 */

        /* XXX 24 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */

And:

struct Qdisc {
        int                     (*enqueue)(struct sk_buff *skb,
                                           struct Qdisc *sch,
                                           struct sk_buff **to_free);
        struct sk_buff *        (*dequeue)(struct Qdisc *sch);
        unsigned int            flags;
#define TCQ_F_BUILTIN           1
#define TCQ_F_INGRESS           2
#define TCQ_F_CAN_BYPASS        4
#define TCQ_F_MQROOT            8
#define TCQ_F_ONETXQUEUE        0x10 /* dequeue_skb() can assume all skbs are for
                                      * q->dev_queue : It can test
                                      * netif_xmit_frozen_or_stopped() before
                                      * dequeueing next packet.
                                      * Its true for MQ/MQPRIO slaves, or non
                                      * multiqueue device.
                                      */
#define TCQ_F_WARN_NONWC        (1 << 16)
#define TCQ_F_CPUSTATS          0x20 /* run using percpu statistics */
#define TCQ_F_NOPARENT          0x40 /* root of its hierarchy :
                                      * qdisc_tree_decrease_qlen() should stop.
                                      */
#define TCQ_F_INVISIBLE         0x80 /* invisible by default in dump */
#define TCQ_F_NOLOCK            0x100 /* qdisc does not require locking */
#define TCQ_F_OFFLOADED         0x200 /* qdisc is offloaded to HW */
        u32                     limit;
        const struct Qdisc_ops  *ops;
        struct qdisc_size_table __rcu *stab;
        struct hlist_node       hash;
        u32                     handle;
        u32                     parent;

        struct netdev_queue     *dev_queue;

        struct net_rate_estimator __rcu *rate_est;
        struct gnet_stats_basic_sync __percpu *cpu_bstats;
        struct gnet_stats_queue __percpu *cpu_qstats;
        int                     pad;
        refcount_t              refcnt;


I'll try to fix now.

- Arnaldo

 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  dwarves_fprintf.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index e8399e7..1e6147a 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -572,6 +572,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  	case DW_TAG_restrict_type:
>  	case DW_TAG_atomic_type:
>  	case DW_TAG_unspecified_type:
> +	case DW_TAG_LLVM_annotation:
>  		type = cu__type(cu, tag->type);
>  		if (type == NULL && tag->type != 0)
>  			tag__id_not_found_snprintf(bf, len, tag->type);
> @@ -786,6 +787,10 @@ next_type:
>  			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
>  			if (n)
>  				return printed + n;
> +			if (ptype->tag == DW_TAG_LLVM_annotation) {
> +				type = ptype;
> +				goto next_type;
> +			}
>  			if (ptype->tag == DW_TAG_subroutine_type) {
>  				printed += ftype__fprintf(tag__ftype(ptype),
>  							  cu, name, 0, 1,
> @@ -880,6 +885,14 @@ print_modifier: {
>  		else
>  			printed += enumeration__fprintf(type, &tconf, fp);
>  		break;
> +	case DW_TAG_LLVM_annotation: {
> +		struct tag *ttype = cu__type(cu, type->type);
> +		if (ttype) {
> +			type = ttype;
> +			goto next_type;
> +		}
> +		goto out_type_not_found;
> +	}
>  	}
>  out:
>  	if (type_expanded)
> -- 
> 2.39.1
> 

-- 

- Arnaldo
