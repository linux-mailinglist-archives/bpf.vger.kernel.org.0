Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88C610596
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiJ0WTG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiJ0WS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:18:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A5B18C7
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:18:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk15so4469483wrb.13
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vIg1gNlXg68xREITSH2xslvYnREtoNRgXjO++xJ/7g=;
        b=fmEt961m8wc9M8Lly5AfVmQHEjKTjVOTEhRoJSyZtvscxcLt8fC8rBoC+X21ACqNuu
         PRmYO4j8PyOZ0cHNyVEkn3+ZA7BuROkEx8N1sQiaNvybo1O+4Hsnpn2LqGdB0LUmSTwk
         pNA/OH9HYZesAHDUadYQacY53cS7uFq1WzwLOjYS3/nB9e7t3460uZfvN6pzwapnYpZu
         5D5fhrdgdr3LZSVBjmYYzMSw59/EqL3Mx02UqCgVnt695PanLFipf4PuLAM7IZVXJtKO
         AG6JRq7pu65YlN14A5ciy1snMsBQCii3xqRoDpagk+o/zJFPZOX8HK5ZsqabGv/dHyM0
         rfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vIg1gNlXg68xREITSH2xslvYnREtoNRgXjO++xJ/7g=;
        b=qi3bZOIyvqkV5/hKcwyyo8FC/PJMbxVSR3dI11ANrmT59Zoukia4tkEUme6MZUJ+zh
         7TcqtapugLohn4bK26WBpsw73/EKrKc29qZWgIgP+gXZFTrZK+reJeuu8JXCGHsVjEuy
         6KX53qVmygsR6qkQZjyN+rDMX0OK/ZKaqDEPjEC7fYVK6/ohNZxfjpoChT+ShZ1jqUX1
         hbVARlh0uQBw6r/1AZb2QAMmAyNLHdtoDoltLggdx8FAdVUk9kGu5Hopw+7f6snhyp45
         RNVpiaCL3nwF0R2A869h/BQHcuztjJ8WjtkPtknouWTjU63B+WXFi12742FbbTfIixN/
         drtA==
X-Gm-Message-State: ACrzQf3Z30mJrHDv43tTdcDyzJJlSD9IzNx7KcrmZ3kN9XnRyam5Pg1I
        y8/oiIBeEqRBjYIjOwPlRsWtnpeSm/hsoQZQ
X-Google-Smtp-Source: AMsMyM4DJ4mQivMk8hroGJ/w/Z63ks9WpdsJNppWF+Cc3k90CVgd6a7cZ8axGZp982uPSGPCtMPecA==
X-Received: by 2002:a5d:64a4:0:b0:22f:8ff1:e0d5 with SMTP id m4-20020a5d64a4000000b0022f8ff1e0d5mr33399239wrp.354.1666909122529;
        Thu, 27 Oct 2022 15:18:42 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003c7087f6c9asm6422958wmq.32.2022.10.27.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:18:41 -0700 (PDT)
Message-ID: <bad8be826d088e0d180232628160bf932006de89.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Date:   Fri, 28 Oct 2022 01:18:40 +0300
In-Reply-To: <YxB05NCEbNWVYslz@syu-laptop>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
         <20220826172915.1536914-2-eddyz87@gmail.com>
         <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
         <83b97d563cd3f2041288fcffad1e830aac3bc2da.camel@gmail.com>
         <YxBpoj/MYrBlUJ8h@syu-laptop> <YxB05NCEbNWVYslz@syu-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-09-01 at 17:01 +0800, Shung-Hsi Yu wrote:
> On Thu, Sep 01, 2022 at 04:13:22PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Aug 30, 2022 at 01:41:28PM +0300, Eduard Zingerman wrote:
> > > Hi Daniel,
> > >=20
> > > Thank you for commenting.
> > >=20
> > > > On Mon, 2022-08-29 at 16:23 +0200, Daniel Borkmann wrote:
> > > > [...]
> > > > >   kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++++++++++++++=
+++--
> > > > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 0194a36d0b36..7585288e035b 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> > > > >   	return type & PTR_MAYBE_NULL;
> > > > >   }
> > > > >  =20
> > > > > +static bool type_is_pointer(enum bpf_reg_type type)
> > > > > +{
> > > > > +	return type !=3D NOT_INIT && type !=3D SCALAR_VALUE;
> > > > > +}
> > > >=20
> > > > We also have is_pointer_value(), semantics there are a bit differen=
t (and mainly to
> > > > prevent leakage under unpriv), but I wonder if this can be refactor=
ed to accommodate
> > > > both. My worry is that if in future we extend one but not the other=
 bugs might slip
> > > > in.
> > >=20
> > > John was concerned about this as well, guess I won't not dodging it :=
)
> > > Suppose I do the following modification:
> > >=20
> > >     static bool type_is_pointer(enum bpf_reg_type type)
> > >     {
> > >     	return type !=3D NOT_INIT && type !=3D SCALAR_VALUE;
> > >     }
> > >    =20
> > >     static bool __is_pointer_value(bool allow_ptr_leaks,
> > >     			       const struct bpf_reg_state *reg)
> > >     {
> > >     	if (allow_ptr_leaks)
> > >     		return false;
> > >=20
> > > -    	return reg->type !=3D SCALAR_VALUE;
> > > +    	return type_is_pointer(reg->type);
> > >     }
> >     =20
> > The verifier is using the wrapped is_pointer_value() to guard against
> > pointer leak.
> >=20
> >   static int check_mem_access(struct bpf_verifier_env *env, int insn_id=
x, u32 regno,
> >   			    int off, int bpf_size, enum bpf_access_type t,
> >   			    int value_regno, bool strict_alignment_once)
> >   {
> >       ...
> >   	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
> >   		...
> >   	} else if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
> >   		struct bpf_map_value_off_desc *kptr_off_desc =3D NULL;
> >  =20
> >   		if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
> >   		    is_pointer_value(env, value_regno)) {
> >   			verbose(env, "R%d leaks addr into map\n", value_regno);
> >   			return -EACCES;
> >           ...
> >   	}
> >       ...
> >   }
> >=20
> > In the check_mem_access() case the semantic of is_pointer_value() is ch=
eck
> > whether or not the value *might* be a pointer, and since NON_INIT can b=
e
> > potentially anything, it should not be excluded.
>=20
> I wasn't reading the threads carefully enough, apologies, just realized
> Daniel had already mention the above point further up.
>=20
> Also, after going back to the previous RFC thread I saw John mention that
> after making the is_pointer_value() changes to exclude NOT_INIT, the test=
s
> still passes.
>=20
> I guess that comes down to how the verifier rigorously check that the
> registers are not NOT_INIT using check_reg_arg(..., SRC_OP), before movin=
g
> on to more specific checks. So I'm a bit less sure about the split
> {maybe,is}_pointer_value() approach proposed below now.

Hi Shung-Hsi, Daniel,

Sorry for a long delay. I'd like to revive this small change.

Thank you for pointing out the part regarding rigorous checks and
check_reg_arg. I've examined all places where __is_pointer_value(...)
and is_pointer_value(...) are invoked in the verifier code and came to
the conclusion that NOT_INIT can never reach the __is_pointer_value.
I also double checked this by modifying __is_pointer_value as follows:

 static bool __is_pointer_value(bool allow_ptr_leaks,
			       const struct bpf_reg_state *reg)
 {
+	BUG_ON(reg->type =3D=3D NOT_INIT);
 	...
 }

And running the BPF selftests. None triggered the BUG_ON condition.

The place where I use type_is_pointer in check_cond_jmp_op is after
the check_reg_arg(..., SRC_OP) for both src and dst registers. Thus I
want to delete the type_is_pointer function from the patch and use
__is_pointer_value(false, ...) instead (as NOT_INIT check was
unnecessary from the beginning).

>=20
> > Since the use case seems different, perhaps we could split them up, e.g=
. a
> > maybe_pointer_value() and a is_pointer_value(), or something along that
> > line.
> >=20
> > The former is equivalent to type !=3D SCALAR_VALUE, and the latter equi=
valent
> > to type !=3D NOT_INIT && type !=3D SCALAR_VALUE. The latter can be used=
 here for
> > implementing nullness propogation.
> >=20
> > > And check if there are test cases that have to be added because of th=
e
> > > change in the __is_pointer_value behavior (it does not check for
> > > `NOT_INIT` right now). Does this sound like a plan?
> > >=20
> > > [...]
> > > > Could we consolidate the logic above with the one below which deals=
 with R =3D=3D 0 checks?
> > > > There are some similarities, e.g. !is_jmp32, both test for jeq/jne =
and while one is based
> > > > on K, the other one on X, though we could also add check X =3D=3D 0=
 for below. Anyway, just
> > > > a though that it may be nice to consolidate the handling.
> > >=20
> > > Ok, I will try to consolidate those.

After some contemplating I don't think that it would be good to
consolidate these two parts.

The part that I want to add merely propagates the nullness
information:

	if (!is_jmp32 && BPF_SRC(insn->code) =3D=3D BPF_X &&
	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_re=
g) &&
	    type_may_be_null(src_reg->type) !=3D type_may_be_null(dst_reg->type)) =
{
            // ... save non-null part for one of the regs ...
        }

However, the part that is already present is actually a pointer leak
check that exempts comparison with zero (and exemption for comparison
with zero is stated as goal of commit 1be7f75d1668 that added
is_pointer_value back in 2015):

	/* detect if R =3D=3D 0 where R is returned from bpf_map_lookup_elem()...
	 */
	if (!is_jmp32 && BPF_SRC(insn->code) =3D=3D BPF_K &&
	    insn->imm =3D=3D 0 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)=
 &&
	    type_may_be_null(dst_reg->type)) {
		/* Mark all identical registers in each branch as either
		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
		 */
                // ...
	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
					   this_branch, other_branch) &&
leak check -->	   is_pointer_value(env, insn->dst_reg)) {
		verbose(env, "R%d pointer comparison prohibited\n",
			insn->dst_reg);
		return -EACCES;
	}

Merging these conditionals would be confusing, imo.

If you don't have objections I will post the v2 removing
type_is_pointer from the patch.

Thanks,
Eduard

> > >=20
> > > Thanks,
> > > Eduard

