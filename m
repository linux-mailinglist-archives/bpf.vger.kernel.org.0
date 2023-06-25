Return-Path: <bpf+bounces-3382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148CA73CDC5
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491521C2086E
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969C62C;
	Sun, 25 Jun 2023 01:19:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EF7F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:19:06 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6807EA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3110ab7110aso2394972f8f.3
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655943; x=1690247943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiQ4JgXnGFrOeyQ/KeQJ4um2D002IQlYsTC872Wv00U=;
        b=YXIFh3PIqZXjY8zsQe/IZwZo84cqfcxBJ6iYPqEcHUgQk1LSCFRy6rIfqAWtIzpNmE
         uqYt99nJ5Z9utycxSYNNgads/hi5rDJil9C2RjjI4n74o4SNkMF0c8J7VuAViMVZVHcM
         t6ydD2c1IKd+HdzdQfq15U2CkoUULmrn2UI3F8ic5dVDg+ixtGHZDuDOw4bGTxXYBw67
         GrZ9DZUs1DGc/JAPmHtVEKU0icXbIXelSxcZwJURKljRkcy0Mev8UL/mtmsbkSIFv1+3
         gpLb/SVC6E6HL9ISkrv74468dVTzxT+RFZHASfGftqd/MHp+F8OFSSpC3XqOhFtD3US6
         tiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655943; x=1690247943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiQ4JgXnGFrOeyQ/KeQJ4um2D002IQlYsTC872Wv00U=;
        b=TARZqp3PUXCCKoivJgWCwDra4tvgOOcwJmgFmNcFyDepSJZI0BI6eDernWR1H+2uEt
         aamcYGlXoENLsi4n/z59QLKDuR3RYliXpcVnEha7GGB1YigS1PTXh//qkC6Z4hjdtIae
         wwdfOJBZZp+firgi3hMSFI5yVZRI1eY+tKGkf2sinhO2Yv9L9ZiV7mRE5XxJgJU954e+
         uDMYvVjab3+t+mo1nZbbZhC4oJl6uMYKLs7euZiGZKv1SvODuXa76t9hMv+msLiZngl2
         aZT6hEty90djmGp/WVSwbJRMyJkeBTTVU40e3xiPX6BngX27IF9oZtBO2dfIi6YwOqjR
         7KSA==
X-Gm-Message-State: AC+VfDy7lEEjKcPLR4ELJWWXaew+P3S9QYAczsrTxZHKruW4KDydXm3d
	+GZpBWkWoW9IeJPVbLhLCc8=
X-Google-Smtp-Source: ACHHUZ6Y3nHf8Bgi5NdLID9UDaT1HdNvZNMyhNM5lQqUTv5sCVZWgShn1xivK/9rAFto6WzLKawGKA==
X-Received: by 2002:adf:f611:0:b0:30a:e369:5acb with SMTP id t17-20020adff611000000b0030ae3695acbmr22021484wrp.68.1687655943040;
        Sat, 24 Jun 2023 18:19:03 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b003063db8f45bsm3344223wru.23.2023.06.24.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:19:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:18:58 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <ZJeWAiW5qxQPghGm@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava>
 <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 09:24:22AM -0700, Andrii Nakryiko wrote:

SNIP

> > > > +
> > > > +       if (!uprobes || !ref_ctr_offsets || !link)
> > > > +               goto error_free;
> > > > +
> > > > +       for (i = 0; i < cnt; i++) {
> > > > +               if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
> > > > +                       err = -EFAULT;
> > > > +                       goto error_free;
> > > > +               }
> > > > +               if (__get_user(offset, uoffsets + i)) {
> > > > +                       err = -EFAULT;
> > > > +                       goto error_free;
> > > > +               }
> > > > +
> > > > +               uprobes[i].offset = offset;
> > > > +               uprobes[i].link = link;
> > > > +
> > > > +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > > > +                       uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
> > > > +               else
> > > > +                       uprobes[i].consumer.handler = uprobe_multi_link_handler;
> > > > +
> > > > +               ref_ctr_offsets[i] = ref_ctr_offset;
> > > > +       }
> > > > +
> > > > +       link->cnt = cnt;
> > > > +       link->uprobes = uprobes;
> > > > +       link->path = path;
> > > > +
> > > > +       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > > > +                     &bpf_uprobe_multi_link_lops, prog);
> > > > +
> > > > +       err = bpf_link_prime(&link->link, &link_primer);
> > > > +       if (err)
> > > > +               goto error_free;
> > > > +
> > > > +       for (i = 0; i < cnt; i++) {
> > > > +               err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> > > > +                                            uprobes[i].offset, ref_ctr_offsets[i],
> > > > +                                            &uprobes[i].consumer);
> > > > +               if (err) {
> > > > +                       bpf_uprobe_unregister(&path, uprobes, i);
> > >
> > > bpf_link_cleanup() will do this through
> > > bpf_uprobe_multi_link_release(), no? So you are double unregistering?
> > > Either drop cnt to zero, or just don't do this here? Latter is better,
> > > IMO.
> >
> > bpf_link_cleanup path won't call release callback so we have to do that
> 
> bpf_link_cleanup() does fput(primer->file); which eventually calls
> release callback, no? I'd add printk and simulate failure just to be
> sure

I recall we had similar discussion for kprobe_multi link ;-)

I'll double check that but I think bpf_link_cleanup calls just
dealloc callback not release

jirka

> 
> >
> > I think I can add simple selftest to have this path covered
> >
> > thanks,
> > jirka

SNIP

