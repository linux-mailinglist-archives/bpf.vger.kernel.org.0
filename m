Return-Path: <bpf+bounces-1685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E37203C6
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F77A1C20ECD
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989419527;
	Fri,  2 Jun 2023 13:52:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5519509
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:52:47 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA4E42;
	Fri,  2 Jun 2023 06:52:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b084620dso7220651fa.0;
        Fri, 02 Jun 2023 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685713962; x=1688305962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTx9pnxCGS6AhG5h6zegwWEZV0SrnyOhpPwKANTp1Gc=;
        b=QqU4Oy3T2YzGhi54wfUJiLAtmThS8MMWdoWBDROdOz7CfWHWF3FEJnlX+gBfaPfX0R
         7F9hSl4oIZlQYsQiu8EHfUVLu/0YF+S67ayDoeMYYM6DJ2EOYBABAHwCI45e/4laqnHe
         zfEJDg7aVLo1czlngKCYA1PJcGV90PlQwXta6002Qgb98t+nP408vzArwzbiWUHjf+F3
         1/jAURURIILXZir7fhvk6ESn6pQCVchIBWSWurm13zeoKvTbkS0FHi7XOhWCrIbeQo2o
         H2WJ60wwVbFKGm2Lu82VXUZmn6vIyTE5xCc0+4zn8Re/6dgioAQ3DI1RZOpQJR2Tzx7+
         jdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713962; x=1688305962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTx9pnxCGS6AhG5h6zegwWEZV0SrnyOhpPwKANTp1Gc=;
        b=X0m0LOx68VLHD4Rm3aVmJzSCW3AJ640Wk/aFhs6actYFDGEKSlC8C66vD6hZhOhfSz
         DIbcNpJ3zXOCe4XHKsxK5aKd3IvI041gd1xWKPgkRrHbiUnv1Ke52M5VSQDCRlcS3dSH
         7cmuz300VG7J3KYSzvb19t0T+cSlgHEWez8oA5qLRVCpEXvMI/1WHVCOOkIJqwCUSHsw
         zV7GQub02v1am1pq3BB0zqQOg6JDvKyxXR/jqBJehcy1OTl1OaWBFqq3QJnxiGdHWl75
         wOQUCzNuAIaxHvAFaeHEib9cYsKAKNL0jLncSe+TG+Qj9MFYjYhI87TjLbNrvuoBwh4a
         lYLQ==
X-Gm-Message-State: AC+VfDxwOFBTow7z5G6pnGCURGF3aBYLBRNmPauGINGLxDnac7oFUOob
	6MXWo8OhI3WXLYd81BLPbRvz6iWw6Fn4SA==
X-Google-Smtp-Source: ACHHUZ7fNVzNGOZBgVKWsuLnvr7kDARFoGzQRES7mjUTEMM9ygs92Xhm97LV9GrTpLZUZ30VcE4+mw==
X-Received: by 2002:a2e:7a0e:0:b0:2a7:748c:1eef with SMTP id v14-20020a2e7a0e000000b002a7748c1eefmr28727ljc.38.1685713962004;
        Fri, 02 Jun 2023 06:52:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b2-20020a2e9882000000b002ad98ec6b10sm231480ljj.52.2023.06.02.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:52:41 -0700 (PDT)
Message-ID: <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
 mykolal@fb.com
Date: Fri, 02 Jun 2023 16:52:40 +0300
In-Reply-To: <ZHnxsyjDaPQ7gGUP@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
	 <ZHnxsyjDaPQ7gGUP@kernel.org>
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

On Fri, 2023-06-02 at 10:42 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 26, 2023 at 02:59:49AM +0300, Eduard Zingerman escreveu:
> > When pahole is executed in '-F dwarf --sort' mode there are two places
> > where 'struct structure' instance could be added to the rb_tree:
> >=20
> > The first is triggered from the following call stack:
> >=20
> >   print_classes()
> >     structures__add()
> >       __structures__add()
> >         (adds to global pahole.c:structures__tree)
> >=20
> > The second is triggered from the following call stack:
> >=20
> >   print_ordered_classes()
> >     resort_classes()
> >       resort_add()
> >         (adds to local rb_tree instance)
> >=20
> > Both places use the same 'struct structure::rb_node' field, so if both
> > code pathes are executed the final state of the 'structures__tree'
> > might be inconsistent.
> >=20
> > For example, this could be observed when DEBUG_CHECK_LEAKS build flag
> > is set. Here is the command line snippet that eventually leads to a
> > segfault:
> >=20
> >   $ for i in $(seq 1 100); do \
> >       echo $i; \
> >       pahole -F dwarf --flat_arrays --sort --jobs vmlinux > /dev/null \
> >              || break; \
> >     done
> >=20
> > GDB shows the following stack trace:
> >=20
> >   Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
> >   0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830, parent=
=3D0x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves=
-fork/rbtree.c:134
> >   134			if (parent->rb_left =3D=3D node)
> >   (gdb) bt
> >   #0  0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830, pa=
rent=3D0x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwa=
rves-fork/rbtree.c:134
> >   #1  0x00007ffff7f82014 in rb_erase (node=3D0x7fff21ae5b80, root=3D0x5=
555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:275
> >   #2  0x0000555555559c3d in __structures__delete () at /home/eddy/work/=
dwarves-fork/pahole.c:440
> >   #3  0x0000555555559c70 in structures__delete () at /home/eddy/work/dw=
arves-fork/pahole.c:448
> >   #4  0x0000555555560bb6 in main (argc=3D13, argv=3D0x7fffffffdcd8) at =
/home/eddy/work/dwarves-fork/pahole.c:3584
> >=20
> > This commit modifies resort_classes() to re-use 'structures__tree' and
> > to reset 'rb_node' fields before adding structure instances to the
> > tree for a second time.
> >=20
> > Lock/unlock structures_lock to be consistent with structures_add() and
> > structures__delete() code.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  pahole.c | 41 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/pahole.c b/pahole.c
> > index 6fc4ed6..576733f 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -621,9 +621,9 @@ static void print_classes(struct cu *cu)
> >  	}
> >  }
> > =20
> > -static void __print_ordered_classes(struct rb_root *root)
> > +static void __print_ordered_classes(void)
> >  {
> > -	struct rb_node *next =3D rb_first(root);
> > +	struct rb_node *next =3D rb_first(&structures__tree);
> > =20
> >  	while (next) {
> >  		struct structure *st =3D rb_entry(next, struct structure, rb_node);
> > @@ -660,24 +660,39 @@ static void resort_add(struct rb_root *resorted, =
struct structure *str)
> >  	rb_insert_color(&str->rb_node, resorted);
> >  }
> > =20
> > -static void resort_classes(struct rb_root *resorted, struct list_head =
*head)
> > +static void resort_classes(void)
> >  {
> >  	struct structure *str;
> > =20
> > -	list_for_each_entry(str, head, node)
> > -		resort_add(resorted, str);
> > +	pthread_mutex_lock(&structures_lock);
> > +
> > +	/* The need_resort flag is set by type__compare_members()
> > +	 * within the following call stack:
> > +	 *
> > +	 *   print_classes()
> > +	 *     structures__add()
> > +	 *       __structures__add()
> > +	 *         type__compare()
> > +	 *
> > +	 * The call to structures__add() registers 'struct structures'
> > +	 * instances in both 'structures__tree' and 'structures__list'.
> > +	 * In order to avoid adding same node to the tree twice reset
> > +	 * both the 'structures__tree' and 'str->rb_node'.
> > +	 */
> > +	structures__tree =3D RB_ROOT;
> > +	list_for_each_entry(str, &structures__list, node) {
> > +		bzero(&str->rb_node, sizeof(str->rb_node));
>=20
> Why is this bzero needed?
>=20
> > +		resort_add(&structures__tree, str);
>=20
> resort_add will call rb_link_node(&str->rb_node, parent, p); and it, in
> turn:
>=20
> static inline void rb_link_node(struct rb_node * node, struct rb_node * p=
arent,
>                                 struct rb_node ** rb_link)
> {
>         node->rb_parent_color =3D (unsigned long )parent;
>         node->rb_left =3D node->rb_right =3D NULL;
>=20
>         *rb_link =3D node;
> }
>=20
> And:
>=20
> struct rb_node
> {
>         unsigned long  rb_parent_color;
> #define RB_RED          0
> #define RB_BLACK        1
>         struct rb_node *rb_right;
>         struct rb_node *rb_left;
> } __attribute__((aligned(sizeof(long))))
>=20
> So all the fields are being initialized in the operation right after the
> bzero(), no?

Right, you are correct.
The 'structures__tree =3D RB_ROOT' part is still necessary, though.
If you are ok with overall structure of the patch I can resend it w/o bzero=
().

>=20
> - Arnaldo
>=20
> > +	}
> > +
> > +	pthread_mutex_unlock(&structures_lock);
> >  }
> > =20
> >  static void print_ordered_classes(void)
> >  {
> > -	if (!need_resort) {
> > -		__print_ordered_classes(&structures__tree);
> > -	} else {
> > -		struct rb_root resorted =3D RB_ROOT;
> > -
> > -		resort_classes(&resorted, &structures__list);
> > -		__print_ordered_classes(&resorted);
> > -	}
> > +	if (need_resort)
> > +		resort_classes();
> > +	__print_ordered_classes();
> >  }
> > =20
> > =20
> > --=20
> > 2.40.1
> >=20
>=20


