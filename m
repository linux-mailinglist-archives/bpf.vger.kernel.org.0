Return-Path: <bpf+bounces-1723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A47208D5
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F3D1C2120B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905E1D2D1;
	Fri,  2 Jun 2023 18:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540101D2C7
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:08:58 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31D123;
	Fri,  2 Jun 2023 11:08:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so33193311fa.1;
        Fri, 02 Jun 2023 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685729334; x=1688321334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GcSDtlGqxHecpP64RzCzjyCFpGIvS7MomuU0OixZLsU=;
        b=p/uWWe8W9SCIY7ZkjVE6CZQ0izmOb5oH5NPNOsqUNzJB5/gMEcSEhoyMwiuEVVC71o
         fjFNbG40MGgwsfs4rdoRhumNaiR7lxxJSNjRzZbWheiMaiNJdWbe4DnG6F05STo+2bQa
         SCQT4DtowC7kfuGxotSBf9xDinBPflMf/nqM0mcd9iqeRfmMAVbom3QInpOGosfLLh4J
         IAng76yN6cfOOEEE3iXwsiJRrLytbvh57o13f10eH97Qf9WjwME+TfNvcEdrM1cpZsdP
         5S7tU7rFISLvG0fM1m6LaIB7SqdxNzwcdsc7eBRATCyCRAzr6hvYOounKtXO3ZTqdZEb
         aweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685729334; x=1688321334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcSDtlGqxHecpP64RzCzjyCFpGIvS7MomuU0OixZLsU=;
        b=ANVq7Z09xyzsJJn0FPyfZ65kDru8n+QS0m3cLiI33MqMNuNFdBkxrTi9hSlT0AmsLq
         e6zjFGljKMX3gdndfNXrFH7RF7bEiN+iqqywdz8laLaPy7mgGH+FNc8Y2H3uGVNAAzDY
         YMMmZntbLCvouKm9tl087z/IolKD76TGXmhTER5ZDRP3FYTIh9zUFUGttaX4N10IfCMg
         lueLSUaSt+jRg5mniSbSo3Lb5hzrMJCvnQrwJl0ELf6QLDnTz+SgH8pfNaVKxgiPC3vW
         h1iNmgqFp6RDKtMaBhhLFOgeSXEV0mdPfcuBooLh3x3Xpp81zxjCLtxXCVY4FkApX7Pf
         iNsA==
X-Gm-Message-State: AC+VfDyS2oNFRib8qqR0mLKxX07+6Xn03/lUZ9u6dcU9rX+k0SBTYwvn
	dwJC4/D9gfn/y5tYE+31/W0=
X-Google-Smtp-Source: ACHHUZ7I9fbYIDJANtsS81TCWybmCPxxQk68dkX89VVAOw67Pe8t4y0mozOYgsdrwB3pMA1utK44jw==
X-Received: by 2002:a2e:894e:0:b0:2b1:a872:ed17 with SMTP id b14-20020a2e894e000000b002b1a872ed17mr528883ljk.5.1685729333596;
        Fri, 02 Jun 2023 11:08:53 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e9147000000b002aa42d728d9sm300379ljg.36.2023.06.02.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 11:08:53 -0700 (PDT)
Message-ID: <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
 mykolal@fb.com
Date: Fri, 02 Jun 2023 21:08:51 +0300
In-Reply-To: <ZHovRW1G0QZwBSOW@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
	 <ZHnxsyjDaPQ7gGUP@kernel.org>
	 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
	 <ZHovRW1G0QZwBSOW@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> > On Fri, 2023-06-02 at 10:42 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, May 26, 2023 at 02:59:49AM +0300, Eduard Zingerman escreveu:
> > > > When pahole is executed in '-F dwarf --sort' mode there are two pla=
ces
> > > > where 'struct structure' instance could be added to the rb_tree:
> > > >=20
> > > > The first is triggered from the following call stack:
> > > >=20
> > > >   print_classes()
> > > >     structures__add()
> > > >       __structures__add()
> > > >         (adds to global pahole.c:structures__tree)
> > > >=20
> > > > The second is triggered from the following call stack:
> > > >=20
> > > >   print_ordered_classes()
> > > >     resort_classes()
> > > >       resort_add()
> > > >         (adds to local rb_tree instance)
> > > >=20
> > > > Both places use the same 'struct structure::rb_node' field, so if b=
oth
> > > > code pathes are executed the final state of the 'structures__tree'
> > > > might be inconsistent.
> > > >=20
> > > > For example, this could be observed when DEBUG_CHECK_LEAKS build fl=
ag
> > > > is set. Here is the command line snippet that eventually leads to a
> > > > segfault:
> > > >=20
> > > >   $ for i in $(seq 1 100); do \
> > > >       echo $i; \
> > > >       pahole -F dwarf --flat_arrays --sort --jobs vmlinux > /dev/nu=
ll \
> > > >              || break; \
> > > >     done
> > > >=20
> > > > GDB shows the following stack trace:
> > > >=20
> > > >   Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
> > > >   0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830, pa=
rent=3D0x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwa=
rves-fork/rbtree.c:134
> > > >   134			if (parent->rb_left =3D=3D node)
> > > >   (gdb) bt
> > > >   #0  0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830=
, parent=3D0x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work=
/dwarves-fork/rbtree.c:134
> > > >   #1  0x00007ffff7f82014 in rb_erase (node=3D0x7fff21ae5b80, root=
=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree=
.c:275
> > > >   #2  0x0000555555559c3d in __structures__delete () at /home/eddy/w=
ork/dwarves-fork/pahole.c:440
> > > >   #3  0x0000555555559c70 in structures__delete () at /home/eddy/wor=
k/dwarves-fork/pahole.c:448
> > > >   #4  0x0000555555560bb6 in main (argc=3D13, argv=3D0x7fffffffdcd8)=
 at /home/eddy/work/dwarves-fork/pahole.c:3584
> > > >=20
> > > > This commit modifies resort_classes() to re-use 'structures__tree' =
and
> > > > to reset 'rb_node' fields before adding structure instances to the
> > > > tree for a second time.
> > > >=20
> > > > Lock/unlock structures_lock to be consistent with structures_add() =
and
> > > > structures__delete() code.
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  pahole.c | 41 ++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 28 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/pahole.c b/pahole.c
> > > > index 6fc4ed6..576733f 100644
> > > > --- a/pahole.c
> > > > +++ b/pahole.c
> > > > @@ -621,9 +621,9 @@ static void print_classes(struct cu *cu)
> > > >  	}
> > > >  }
> > > > =20
> > > > -static void __print_ordered_classes(struct rb_root *root)
> > > > +static void __print_ordered_classes(void)
> > > >  {
> > > > -	struct rb_node *next =3D rb_first(root);
> > > > +	struct rb_node *next =3D rb_first(&structures__tree);
> > > > =20
> > > >  	while (next) {
> > > >  		struct structure *st =3D rb_entry(next, struct structure, rb_nod=
e);
> > > > @@ -660,24 +660,39 @@ static void resort_add(struct rb_root *resort=
ed, struct structure *str)
> > > >  	rb_insert_color(&str->rb_node, resorted);
> > > >  }
> > > > =20
> > > > -static void resort_classes(struct rb_root *resorted, struct list_h=
ead *head)
> > > > +static void resort_classes(void)
> > > >  {
> > > >  	struct structure *str;
> > > > =20
> > > > -	list_for_each_entry(str, head, node)
> > > > -		resort_add(resorted, str);
> > > > +	pthread_mutex_lock(&structures_lock);
> > > > +
> > > > +	/* The need_resort flag is set by type__compare_members()
> > > > +	 * within the following call stack:
> > > > +	 *
> > > > +	 *   print_classes()
> > > > +	 *     structures__add()
> > > > +	 *       __structures__add()
> > > > +	 *         type__compare()
> > > > +	 *
> > > > +	 * The call to structures__add() registers 'struct structures'
> > > > +	 * instances in both 'structures__tree' and 'structures__list'.
> > > > +	 * In order to avoid adding same node to the tree twice reset
> > > > +	 * both the 'structures__tree' and 'str->rb_node'.
> > > > +	 */
> > > > +	structures__tree =3D RB_ROOT;
> > > > +	list_for_each_entry(str, &structures__list, node) {
> > > > +		bzero(&str->rb_node, sizeof(str->rb_node));
> > >=20
> > > Why is this bzero needed?
> > >=20
> > > > +		resort_add(&structures__tree, str);
> > >=20
> > > resort_add will call rb_link_node(&str->rb_node, parent, p); and it, =
in
> > > turn:
> > >=20
> > > static inline void rb_link_node(struct rb_node * node, struct rb_node=
 * parent,
> > >                                 struct rb_node ** rb_link)
> > > {
> > >         node->rb_parent_color =3D (unsigned long )parent;
> > >         node->rb_left =3D node->rb_right =3D NULL;
> > >=20
> > >         *rb_link =3D node;
> > > }
> > >=20
> > > And:
> > >=20
> > > struct rb_node
> > > {
> > >         unsigned long  rb_parent_color;
> > > #define RB_RED          0
> > > #define RB_BLACK        1
> > >         struct rb_node *rb_right;
> > >         struct rb_node *rb_left;
> > > } __attribute__((aligned(sizeof(long))))
> > >=20
> > > So all the fields are being initialized in the operation right after =
the
> > > bzero(), no?
> >=20
> > Right, you are correct.
> > The 'structures__tree =3D RB_ROOT' part is still necessary, though.
> > If you are ok with overall structure of the patch I can resend it w/o b=
zero().
>=20
> Humm, so basically this boils down to the following patch?
>=20
> - Arnaldo
>=20
> diff --git a/pahole.c b/pahole.c
> index 6fc4ed6a721b97ab..7f7aa0a5db05837d 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
>  		__print_ordered_classes(&structures__tree);
>  	} else {
>  		struct rb_root resorted =3D RB_ROOT;
> -
> +#ifdef DEBUG_CHECK_LEAKS
> +		// We'll delete structures from structures__tree, since we're
> +		// adding them to ther resorted list, better not keep
> +		// references there.
> +		structures__tree =3D RB_ROOT;
> +#endif

But __structures__delete iterates over structures__tree,
so it won't delete anything if code like this, right?

>  		resort_classes(&resorted, &structures__list);
>  		__print_ordered_classes(&resorted);
>  	}


