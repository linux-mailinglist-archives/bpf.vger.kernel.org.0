Return-Path: <bpf+bounces-1682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D022E72039C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6B2818AD
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB761950A;
	Fri,  2 Jun 2023 13:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9874111B8
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50DC433EF;
	Fri,  2 Jun 2023 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685713334;
	bh=zaE02NfX7bLXKaa9G5ZoEsah1tr8ZNKmGq6A3lxAvX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB531SMPVv9XLbj2Zt8MOpxbF2nrf+cO7G5TedeQiX+tUWj9GnghN6NpMBfRCE+Md
	 mM4cu6y5T/gF+jAvcjnSDhQBoOPxODMdcLvKkrxto2p6sQsdrKFYJUg11xZJKQSZQG
	 gswWJhbl/d/cMcKZ6DBYDh7bTwukXa8TGjOOPFHNHw+TWdnlh+DHaKAQzj1XGZG+T4
	 amh0h2YzpJDJKRHlzvrP2OaMH1xdsiKazK+jRPHgWXqoETHkjsxgFF2JqOpUATQEQl
	 s/Xw8DVbvhdYgl6fpNdh9VpF9tycgW2XbLIS7Lm/0VipsBN8E7a9Teu/Axg2FJFg/V
	 GfmobGmR7xBjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 882E940692; Fri,  2 Jun 2023 10:42:11 -0300 (-03)
Date: Fri, 2 Jun 2023 10:42:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yhs@fb.com, mykolal@fb.com
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
Message-ID: <ZHnxsyjDaPQ7gGUP@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525235949.2978377-1-eddyz87@gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, May 26, 2023 at 02:59:49AM +0300, Eduard Zingerman escreveu:
> When pahole is executed in '-F dwarf --sort' mode there are two places
> where 'struct structure' instance could be added to the rb_tree:
> 
> The first is triggered from the following call stack:
> 
>   print_classes()
>     structures__add()
>       __structures__add()
>         (adds to global pahole.c:structures__tree)
> 
> The second is triggered from the following call stack:
> 
>   print_ordered_classes()
>     resort_classes()
>       resort_add()
>         (adds to local rb_tree instance)
> 
> Both places use the same 'struct structure::rb_node' field, so if both
> code pathes are executed the final state of the 'structures__tree'
> might be inconsistent.
> 
> For example, this could be observed when DEBUG_CHECK_LEAKS build flag
> is set. Here is the command line snippet that eventually leads to a
> segfault:
> 
>   $ for i in $(seq 1 100); do \
>       echo $i; \
>       pahole -F dwarf --flat_arrays --sort --jobs vmlinux > /dev/null \
>              || break; \
>     done
> 
> GDB shows the following stack trace:
> 
>   Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
>   0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
>   134			if (parent->rb_left == node)
>   (gdb) bt
>   #0  0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
>   #1  0x00007ffff7f82014 in rb_erase (node=0x7fff21ae5b80, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:275
>   #2  0x0000555555559c3d in __structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:440
>   #3  0x0000555555559c70 in structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:448
>   #4  0x0000555555560bb6 in main (argc=13, argv=0x7fffffffdcd8) at /home/eddy/work/dwarves-fork/pahole.c:3584
> 
> This commit modifies resort_classes() to re-use 'structures__tree' and
> to reset 'rb_node' fields before adding structure instances to the
> tree for a second time.
> 
> Lock/unlock structures_lock to be consistent with structures_add() and
> structures__delete() code.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  pahole.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/pahole.c b/pahole.c
> index 6fc4ed6..576733f 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -621,9 +621,9 @@ static void print_classes(struct cu *cu)
>  	}
>  }
>  
> -static void __print_ordered_classes(struct rb_root *root)
> +static void __print_ordered_classes(void)
>  {
> -	struct rb_node *next = rb_first(root);
> +	struct rb_node *next = rb_first(&structures__tree);
>  
>  	while (next) {
>  		struct structure *st = rb_entry(next, struct structure, rb_node);
> @@ -660,24 +660,39 @@ static void resort_add(struct rb_root *resorted, struct structure *str)
>  	rb_insert_color(&str->rb_node, resorted);
>  }
>  
> -static void resort_classes(struct rb_root *resorted, struct list_head *head)
> +static void resort_classes(void)
>  {
>  	struct structure *str;
>  
> -	list_for_each_entry(str, head, node)
> -		resort_add(resorted, str);
> +	pthread_mutex_lock(&structures_lock);
> +
> +	/* The need_resort flag is set by type__compare_members()
> +	 * within the following call stack:
> +	 *
> +	 *   print_classes()
> +	 *     structures__add()
> +	 *       __structures__add()
> +	 *         type__compare()
> +	 *
> +	 * The call to structures__add() registers 'struct structures'
> +	 * instances in both 'structures__tree' and 'structures__list'.
> +	 * In order to avoid adding same node to the tree twice reset
> +	 * both the 'structures__tree' and 'str->rb_node'.
> +	 */
> +	structures__tree = RB_ROOT;
> +	list_for_each_entry(str, &structures__list, node) {
> +		bzero(&str->rb_node, sizeof(str->rb_node));

Why is this bzero needed?

> +		resort_add(&structures__tree, str);

resort_add will call rb_link_node(&str->rb_node, parent, p); and it, in
turn:

static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
                                struct rb_node ** rb_link)
{
        node->rb_parent_color = (unsigned long )parent;
        node->rb_left = node->rb_right = NULL;

        *rb_link = node;
}

And:

struct rb_node
{
        unsigned long  rb_parent_color;
#define RB_RED          0
#define RB_BLACK        1
        struct rb_node *rb_right;
        struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))))

So all the fields are being initialized in the operation right after the
bzero(), no?

- Arnaldo

> +	}
> +
> +	pthread_mutex_unlock(&structures_lock);
>  }
>  
>  static void print_ordered_classes(void)
>  {
> -	if (!need_resort) {
> -		__print_ordered_classes(&structures__tree);
> -	} else {
> -		struct rb_root resorted = RB_ROOT;
> -
> -		resort_classes(&resorted, &structures__list);
> -		__print_ordered_classes(&resorted);
> -	}
> +	if (need_resort)
> +		resort_classes();
> +	__print_ordered_classes();
>  }
>  
>  
> -- 
> 2.40.1
> 

-- 

- Arnaldo

