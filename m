Return-Path: <bpf+bounces-1722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA567208C6
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EB91C210C5
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD11B903;
	Fri,  2 Jun 2023 18:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D91332EE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA8FC433D2;
	Fri,  2 Jun 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685729096;
	bh=M+5llrhwKyu7PjYehzsNRytC3b/pPcYfrwZvhsJPhIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRTs/OfPFtBtLbzPqt+n6SZSOPXV8prXJbvCnWmo3kN5i7WFc/ONd8Nl+HLMKFZfk
	 cPTKh8yPOZ7OQwjOGXumcSq6CbroisPdUrH4TxfYlCo8/nAJ+WTik8J41eneR+h2xd
	 B5q4QDVjBGjvHISawU8YVFZT76oDaoQ7QaD5kSYTm71cZGU8aBY8jBwfu0k/UDynWX
	 KApxD1L8TC3N78QtdaHG6QG1oK7io2f9hPRTSpuARfgWQYiitC5WM6atCMuCeyBCPO
	 Y/oiAbUxG/zoWCNh+rMEItovGmqBANqNZYMhY9XC3QJkTLB5XChNawAbED7qau5d4g
	 mLLyjgITosf+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 312CB40692; Fri,  2 Jun 2023 15:04:53 -0300 (-03)
Date: Fri, 2 Jun 2023 15:04:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
	mykolal@fb.com
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
Message-ID: <ZHovRW1G0QZwBSOW@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
 <ZHnxsyjDaPQ7gGUP@kernel.org>
 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> On Fri, 2023-06-02 at 10:42 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, May 26, 2023 at 02:59:49AM +0300, Eduard Zingerman escreveu:
> > > When pahole is executed in '-F dwarf --sort' mode there are two places
> > > where 'struct structure' instance could be added to the rb_tree:
> > > 
> > > The first is triggered from the following call stack:
> > > 
> > >   print_classes()
> > >     structures__add()
> > >       __structures__add()
> > >         (adds to global pahole.c:structures__tree)
> > > 
> > > The second is triggered from the following call stack:
> > > 
> > >   print_ordered_classes()
> > >     resort_classes()
> > >       resort_add()
> > >         (adds to local rb_tree instance)
> > > 
> > > Both places use the same 'struct structure::rb_node' field, so if both
> > > code pathes are executed the final state of the 'structures__tree'
> > > might be inconsistent.
> > > 
> > > For example, this could be observed when DEBUG_CHECK_LEAKS build flag
> > > is set. Here is the command line snippet that eventually leads to a
> > > segfault:
> > > 
> > >   $ for i in $(seq 1 100); do \
> > >       echo $i; \
> > >       pahole -F dwarf --flat_arrays --sort --jobs vmlinux > /dev/null \
> > >              || break; \
> > >     done
> > > 
> > > GDB shows the following stack trace:
> > > 
> > >   Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
> > >   0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
> > >   134			if (parent->rb_left == node)
> > >   (gdb) bt
> > >   #0  0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
> > >   #1  0x00007ffff7f82014 in rb_erase (node=0x7fff21ae5b80, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:275
> > >   #2  0x0000555555559c3d in __structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:440
> > >   #3  0x0000555555559c70 in structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:448
> > >   #4  0x0000555555560bb6 in main (argc=13, argv=0x7fffffffdcd8) at /home/eddy/work/dwarves-fork/pahole.c:3584
> > > 
> > > This commit modifies resort_classes() to re-use 'structures__tree' and
> > > to reset 'rb_node' fields before adding structure instances to the
> > > tree for a second time.
> > > 
> > > Lock/unlock structures_lock to be consistent with structures_add() and
> > > structures__delete() code.
> > > 
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  pahole.c | 41 ++++++++++++++++++++++++++++-------------
> > >  1 file changed, 28 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/pahole.c b/pahole.c
> > > index 6fc4ed6..576733f 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -621,9 +621,9 @@ static void print_classes(struct cu *cu)
> > >  	}
> > >  }
> > >  
> > > -static void __print_ordered_classes(struct rb_root *root)
> > > +static void __print_ordered_classes(void)
> > >  {
> > > -	struct rb_node *next = rb_first(root);
> > > +	struct rb_node *next = rb_first(&structures__tree);
> > >  
> > >  	while (next) {
> > >  		struct structure *st = rb_entry(next, struct structure, rb_node);
> > > @@ -660,24 +660,39 @@ static void resort_add(struct rb_root *resorted, struct structure *str)
> > >  	rb_insert_color(&str->rb_node, resorted);
> > >  }
> > >  
> > > -static void resort_classes(struct rb_root *resorted, struct list_head *head)
> > > +static void resort_classes(void)
> > >  {
> > >  	struct structure *str;
> > >  
> > > -	list_for_each_entry(str, head, node)
> > > -		resort_add(resorted, str);
> > > +	pthread_mutex_lock(&structures_lock);
> > > +
> > > +	/* The need_resort flag is set by type__compare_members()
> > > +	 * within the following call stack:
> > > +	 *
> > > +	 *   print_classes()
> > > +	 *     structures__add()
> > > +	 *       __structures__add()
> > > +	 *         type__compare()
> > > +	 *
> > > +	 * The call to structures__add() registers 'struct structures'
> > > +	 * instances in both 'structures__tree' and 'structures__list'.
> > > +	 * In order to avoid adding same node to the tree twice reset
> > > +	 * both the 'structures__tree' and 'str->rb_node'.
> > > +	 */
> > > +	structures__tree = RB_ROOT;
> > > +	list_for_each_entry(str, &structures__list, node) {
> > > +		bzero(&str->rb_node, sizeof(str->rb_node));
> > 
> > Why is this bzero needed?
> > 
> > > +		resort_add(&structures__tree, str);
> > 
> > resort_add will call rb_link_node(&str->rb_node, parent, p); and it, in
> > turn:
> > 
> > static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
> >                                 struct rb_node ** rb_link)
> > {
> >         node->rb_parent_color = (unsigned long )parent;
> >         node->rb_left = node->rb_right = NULL;
> > 
> >         *rb_link = node;
> > }
> > 
> > And:
> > 
> > struct rb_node
> > {
> >         unsigned long  rb_parent_color;
> > #define RB_RED          0
> > #define RB_BLACK        1
> >         struct rb_node *rb_right;
> >         struct rb_node *rb_left;
> > } __attribute__((aligned(sizeof(long))))
> > 
> > So all the fields are being initialized in the operation right after the
> > bzero(), no?
> 
> Right, you are correct.
> The 'structures__tree = RB_ROOT' part is still necessary, though.
> If you are ok with overall structure of the patch I can resend it w/o bzero().

Humm, so basically this boils down to the following patch?

- Arnaldo

diff --git a/pahole.c b/pahole.c
index 6fc4ed6a721b97ab..7f7aa0a5db05837d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -674,7 +674,12 @@ static void print_ordered_classes(void)
 		__print_ordered_classes(&structures__tree);
 	} else {
 		struct rb_root resorted = RB_ROOT;
-
+#ifdef DEBUG_CHECK_LEAKS
+		// We'll delete structures from structures__tree, since we're
+		// adding them to ther resorted list, better not keep
+		// references there.
+		structures__tree = RB_ROOT;
+#endif
 		resort_classes(&resorted, &structures__list);
 		__print_ordered_classes(&resorted);
 	}

