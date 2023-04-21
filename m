Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD06EA060
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 02:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjDUAAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDUAAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 20:00:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D83C05
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 17:00:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so9332191fa.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682035228; x=1684627228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqHuggZ6WWjhT/qKvYg63HjHDdhN4idE+KhFdfeTvYU=;
        b=Dqh175TVUpfoTz2VXkkLPbKyt5H7efhZc+abqp+A097bAL88R1ndXyePP2a3UAJCgf
         eTqeVDMKY8yjIuhV3iTXLTsVuJzFwrac7gC/f2a5FbN1B31spU7jevCAM/POIjIkYx61
         SUdOnpg5R8ShpSCJalzPy/0rbT7K1U/9UQklga6zMkilju/JdUs98E5qpnG0r17uBzyK
         L0DRdyatO+8IIAIBQKM6Z+TnDc2Yk8NcL0VV/NeaPfqdRQrAwcBABR9zWNTWVIf7KNCk
         z+1eHwFWpkKD0ysGM6+/G0XDHlYeToWIQ4NjT+9KGvyLWAOOjpovXqNT1QwHI+x6L6/d
         /tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035228; x=1684627228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqHuggZ6WWjhT/qKvYg63HjHDdhN4idE+KhFdfeTvYU=;
        b=ZylRDBLeGnAhTSRu5iaZfKhgFPsKgzEWXufDp6+2o7QhTPtrQKJ6ljpnPV2fkzYtfQ
         8d6K9qAUdKuIlk/iHrfLL0217lLLndy6n4qm74W3z4T1Lp7Q1pFptAnRXlfINVwHWr9D
         glfPGuHfTkBwSntt/wpQZSYBs//Q27Tf2Fp0z7ZD8gSWW7zkx/pC7+YP1VnAQ3osTgrZ
         oXdc1JSUK6VaVHSOby6O2oCUKx78T+SNhORptaPmQCD1360kHCw2PXuAg4cLRJH0wweh
         FH3Ag2cplv7wI8/haLoCjLbneUcQxCRaRpU/NFAYTjcrttIOKOK43buz2nrQAZoM0BYb
         LHYw==
X-Gm-Message-State: AAQBX9dEmqA2XxObPu820EyxgII3AVcopElcyODKEp14CyBVldue7URb
        KJAK7Fom558BwAggG0sc/La16oSWx4M=
X-Google-Smtp-Source: AKy350bw2BJRVZFvaSZgjXawiKb/X666wbKf1cXtK5sgzAIY6fhxeLYNvK0Hw5TrVGgHtFohpU9BLw==
X-Received: by 2002:a2e:9ac3:0:b0:2a7:a2cf:3c03 with SMTP id p3-20020a2e9ac3000000b002a7a2cf3c03mr133528ljj.25.1682035228028;
        Thu, 20 Apr 2023 17:00:28 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a2e2e07000000b002a8c8fa34bfsm423235lju.50.2023.04.20.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 17:00:26 -0700 (PDT)
Message-ID: <10bc6b3fa19e26c0b78718367cc45d7f021da868.camel@gmail.com>
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>,
        Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>
Date:   Fri, 21 Apr 2023 03:00:24 +0300
In-Reply-To: <3c239d87-5163-bc3f-cc2c-a963494f0971@meta.com>
References: <ZEEp+j22imoN6rn9@strlen.de>
         <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
         <20230420125252.GA12121@breakpoint.cc>
         <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
         <f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com>
         <167cbaa496d047803f3d7cf14e13abe2deffb147.camel@gmail.com>
         <3c239d87-5163-bc3f-cc2c-a963494f0971@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 19:54 -0400, Dave Marchevsky wrote:
> Hi Eduard and Florian, thanks for finding this issue. I am looking into t=
he
> bpf_refcount side of things, and IIUC Eduard just submitted a series fixi=
ng
> __retval / test infra.
>=20
> I'm having trouble reproducing the refcount-specific splats, would you mi=
nd
> sharing .config?

Here is what I use:
https://gist.github.com/eddyz87/6c13e1783b5ae4b11b2d9e29fbe5ee49
>=20
> On 4/20/23 7:22 PM, Eduard Zingerman wrote:
>=20
> [...]=20
> > Looking at the error and at the test source code, it appears to me
> > that there is an API misuse for the `refcount_t` type.
> >=20
> > The `bpf_refcount_acquire` invocation in the test expands as a call to
> > bpf_refcount_acquire_impl(), which treats passed pointer as a value of
> > `refcount_t`:
> >=20
> >   /* Description
> >    *	Increment the refcount on a refcounted local kptr, turning the
> >    *	non-owning reference input into an owning reference in the process=
.
> >    *
> >    *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> >    *	program to set it.
> >    * Returns
> >    *	An owning reference to the object pointed to by 'kptr'
> >    */
> >   extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym=
;
> >  =20
> >   __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr,=
 void *meta__ign)
> >   {
> >   	...
> >   	refcount_inc((refcount_t *)ref);
> >   	return (void *)p__refcounted_kptr;
> >   }
> >  =20
> > The comment for `refcount_inc` says:
> >=20
> >   /**
> >    * ...
> >    * Will WARN if the refcount is 0, as this represents a possible use-=
after-free
> >    * condition.
> >    */
> >   static inline void refcount_inc(refcount_t *r)
> >  =20
> > And looking at block/blk-core.c as an example, refcount_t is supposed
> > to be used as follows:
> > - upon object creation it's refcount is set to 1:
> >   refcount_set(&q->refs, 1);
> > - when reference is added the refcount is incremented:
> >   refcount_inc(&q->refs);
> > - when reference is removed the refcount is decremented and checked:
> >   if (refcount_dec_and_test(&q->refs))
> > 	  blk_free_queue(q);
> >=20
> > So, 0 is not actually a valid value for refcount_t instance. And I
> > don't see any calls to refcount_set() in kernel/bpf/helpers.c, which
> > implements bpf_refcount_acquire_impl().
> >=20
> > Dave, I see that bpf_refcount_acquire_impl() was recently added by you,
> > could you please take a look?
> >=20
>=20
> refcount_set is called from bpf_obj_init_field in include/linux/bpf.h .
> Maybe there is some scenario where the bpf_refcount doesn't pass through
> bpf_obj_init_field... Regardless, digging now.

Oh, sorry, missed that.
I should have added some printks before posting...

>=20
> > The TLDR: of a thread:
> > - __retval is currently ignored;
> > - to fix it apply the patch below;
> > - running the following command several times produces lot's
> >   of nasty errors in dmesg:
> >  =20
> >   $ for i in $(seq 1 4); do (./test_progs --allow=3Drefcounted_kptr &);=
 done
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/=
selftests/bpf/test_loader.c
> > index 47e9e076bc8f..e2a1bdc5a570 100644
> > --- a/tools/testing/selftests/bpf/test_loader.c
> > +++ b/tools/testing/selftests/bpf/test_loader.c
> > @@ -587,7 +587,7 @@ void run_subtest(struct test_loader *tester,
> >                 /* For some reason test_verifier executes programs
> >                  * with all capabilities restored. Do the same here.
> >                  */
> > -               if (!restore_capabilities(&caps))
> > +               if (restore_capabilities(&caps))
> >                         goto tobj_cleanup;
> >=20
> >                 do_prog_test_run(bpf_program__fd(tprog), &retval);
> >=20

