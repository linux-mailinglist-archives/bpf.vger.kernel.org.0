Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0556B7845
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 14:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCMNAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCMNA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 09:00:29 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7E265B0;
        Mon, 13 Mar 2023 05:59:57 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d7so12882903qtr.12;
        Mon, 13 Mar 2023 05:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712391;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyhoiIprON3e9d/iMrrXklhEgytlrwbdZ2FyKWhZiIU=;
        b=Q5E2Mz69pFw2G55Xvm+gqrXMtylpbOXblHSj1C8gW1rTZwqMPZuZlYgoKSHF2Rr97i
         fDdZZdJb4KGNaXc/3sLGk57hg9GI0AELVQf/TMlNVxT+ABTPeME3v0vjCIRWLsKY0o6v
         +p0NSZ179/sxB+DYxG5/d46tmtVSbOprPxu45UsRXSBT68csfn/IzcNCAdxmqGEGXztF
         39V3qLYFAn2YcNqOpWz+oZx5WMmUBMHrS2h9X27MCSmfiOb9u0QlIuEGzN2zAkqhSMR0
         h7B+A2KytFRyFGtW1B2zPHGLB0pyorSKYvSV6z87Kkx6PnTcBXZGmwrVzVCAvon0lUkn
         /JAA==
X-Gm-Message-State: AO0yUKXWImwNA/ra1HwaHGcTkWpWlY6gjwQPKjPTBBve42hZPh4eNHF7
        fG/sXI8IQezqb9vy0DDgHtiK2uC4lIReckrr
X-Google-Smtp-Source: AK7set/jl6yTWlk41zFY0gcge1frQ0tWiRIVBpPSVJzHlzExg12wPnM3dIBXdj4o5GepfOjlUonmFg==
X-Received: by 2002:ac8:5b8c:0:b0:3b8:67cb:7928 with SMTP id a12-20020ac85b8c000000b003b867cb7928mr58098528qta.31.1678712390251;
        Mon, 13 Mar 2023 05:59:50 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id o24-20020ac86998000000b003b86a6449b8sm5452921qtq.85.2023.03.13.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 05:59:49 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:59:47 -0500
From:   David Vernet <void@manifault.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sreevani Sreejith <ssreevani@meta.com>, psreep@gmail.com,
        bpf@vger.kernel.org, Linux-kernel@vger.kernel.org,
        andrii@kernel.org, mykola@meta.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <20230313125947.GB2392@maniforge>
References: <20230310180928.2462527-1-ssreevani@meta.com>
 <ZA7wm8scokV+XPav@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA7wm8scokV+XPav@debian.me>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 04:44:59PM +0700, Bagas Sanjaya wrote:
> On Fri, Mar 10, 2023 at 10:09:28AM -0800, Sreevani Sreejith wrote:
> > From: Sreevani <ssreevani@meta.com>
> > 
> > Summary: Document that provides an overview of libbpf features for BPF
> > application development.
> 
> It seems like you ignore some of my reviews at [1]. Anyway, I repeat
> them here, augmenting my new comments.

Sreevani, please be sure to reply to and address all reviewers'
comments. I've also requested that we not use these internal Meta tags
on more than one occasion, so please be mindful of it for future
patches, and take a bit of extra time to double check that you've
addressed all reviewers' concerns. I also suggest reading over [0],
which specifies that new versions of patches should include descriptions
of what's changed from prior versions. Please see Joanne's patch set in
[1] which serves as a very nice example.

[0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
[1]: https://lore.kernel.org/all/20230301154953.641654-1-joannelkoong@gmail.com/

Bagas -- just FYI, a quick git log would have shown that this is only
Sreevani's second patch. I don't think she intentionally ignored
anything. It's likely just an artifact of getting used to the kernel
review process.

> 
> The patch description should have been "Document overview of libbpf,
> including its features for developing BPF programs.".
> 
> > +######
> >  libbpf
> > -======
> > +######
> 
> Why did you add heading overline and change the heading character marker?

I assume that Sreevani is following python documentation conventions [0], which
suggest that #### with overline refers to the highest-level heading in a page.
This is suggested in Sphinx documentation [1] as well.

[0]: https://devguide.python.org/documentation/markup/#sections
[1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections

> 
> > +The following code snippet shows how to read the parent field of a kernel
> > +``task_struct`` using BPF CO-RE and libbf. The basic helper to read a field in a
> > +CO-RE relocatable manner is ``bpf_core_read(dst, sz, src)``, which will read
> > +``sz`` bytes from the field referenced by ``src`` into the memory pointed to by
> > +``dst``.
> > +
> > +  .. code-block:: C
> > +    :emphasize-lines: 6
> > +
> > +    //...
> > +    struct task_struct *task = (void *)bpf_get_current_task();
> > +    struct task_struct *parent_task;
> > +    int err;
> > +
> > +    err = bpf_core_read(&parent_task, sizeof(void *), &task->parent);
> > +    if (err) {
> > +      /* handle error */
> > +    }
> > +
> > +    /* parent_task contains the value of task->parent pointer */
> 
> You may want to also add :lineos: option or manually add line numbers
> if you add :emphasize-lines: so that readers can see the line number
> it refers to.

What is :lineos:? I don't see it anywhere else in Documentation/ and if
I add it, the docs build complains:

Documentation/bpf/libbpf/libbpf_overview.rst:177: WARNING: Error in "code-block" directive:
unknown option: "lineos".

.. code-block:: C
  :lineos:
  :emphasize-lines: 6

  //...
  struct task_struct *task = (void *)bpf_get_current_task();
  struct task_struct *parent_task;
  int err;

  err = bpf_core_read(&parent_task, sizeof(void *), &task->parent);
  if (err) {
    /* handle error */
  }

  /* parent_task contains the value of task->parent pointer */

I personally think adding line numbers is overkill. The highlighting is
already a nice touch, and gets the point across without the additional
visual cue of line numbers.

> 
> > +Also, find the libbpf API documentation `here
> > +<https://libbpf.readthedocs.io/en/latest/api.html>`_
> 
> "See also `libbpf API documentation <link>`_".
> 
> > +
> > +libbpf and Rust
> > +===============
> > +
> > +If you are building BPF applications in Rust, it is recommended to use the
> > +`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_ library instead of bindgen
> > +bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
> > +Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF code
> > +compilation and skeleton generation. Using Libbpf-rs will make building user
> > +space part of the BPF application easier. Note that the BPF program themselves
> > +must still be written in plain C.
> 
> BPF apps are application that use BPF program, right? I thought that
> despite there is libbpf-rs, I still have to develop BPF apps in C.

It says that at the end of the paragraph?

> 
> Thanks.
> 
> [1]: https://lore.kernel.org/linux-doc/ZAqzeQZLNMyaZOck@debian.me/
> 
> -- 
> An old man doll... just what I always wanted! - Clara


