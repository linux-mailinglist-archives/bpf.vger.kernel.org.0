Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E596BA764
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 06:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCOFx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 01:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCOFxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 01:53:55 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF12056B;
        Tue, 14 Mar 2023 22:53:53 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 97so2058206qvb.6;
        Tue, 14 Mar 2023 22:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678859632;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnn/CH2i7CTOBYyJrY4lH8ItaqeSkDLa2BwvsslQGCE=;
        b=G3jeV2BgfD5Q1eYgGmE3xyaXsaeVM5qJ0PIyorIsxh+EkCFKDGlMDC79Td+Ae1LVy6
         OFiCHbpAeYgZsWgx/GbzvmO9cI5fW1pry1cD7+KZoiupunz6XbPqOAme4JnDShDSECrA
         InjuZb6kXmSc06J3sKd9jYWuAnVRYz7UGqM35sLypHJJ0Hr5LltVfeu0vZOKT7IQeXW5
         tLFRHqw1+G6xuHfuCpggg0Z9/2u0hVPXjQ7H8aHfQJ0H8qI1otTVjgZEANfZaerKa7wC
         4MfRuCkPQ9mvc9AGcRLFJGCzw7KFRtY0eX3pSibr47kBnUho9ejIkTCli500LQWq7SYa
         3JmA==
X-Gm-Message-State: AO0yUKUZAlvbWjqKHpxtsaia6BWGWjUiUQGedfg9MumTHZD0vXSfHXAm
        A0vobSoOV22iMjnjy3EcmIs=
X-Google-Smtp-Source: AK7set/IPEK+n9TxIOrM43Lbc+HCtmaJY04DaMiJsqM/ISI9nDcP1RZbF9BhBWbpLV5RwTSwMcA3Eg==
X-Received: by 2002:a05:622a:15c6:b0:3bf:e39f:a9aa with SMTP id d6-20020a05622a15c600b003bfe39fa9aamr76407388qty.27.1678859632173;
        Tue, 14 Mar 2023 22:53:52 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:7ef3])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a29d100b007423c122457sm3283708qkp.63.2023.03.14.22.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 22:53:51 -0700 (PDT)
Date:   Wed, 15 Mar 2023 00:53:49 -0500
From:   David Vernet <void@manifault.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sreevani Sreejith <ssreevani@meta.com>, psreep@gmail.com,
        bpf@vger.kernel.org, Linux-kernel@vger.kernel.org,
        andrii@kernel.org, mykola@meta.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <20230315055349.GA20638@maniforge>
References: <20230310180928.2462527-1-ssreevani@meta.com>
 <ZA7wm8scokV+XPav@debian.me>
 <20230313125947.GB2392@maniforge>
 <ZBE7eMsAifEQgRQv@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBE7eMsAifEQgRQv@debian.me>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 10:28:56AM +0700, Bagas Sanjaya wrote:
> On Mon, Mar 13, 2023 at 07:59:47AM -0500, David Vernet wrote:
> > On Mon, Mar 13, 2023 at 04:44:59PM +0700, Bagas Sanjaya wrote:
> > > On Fri, Mar 10, 2023 at 10:09:28AM -0800, Sreevani Sreejith wrote:
> > > > From: Sreevani <ssreevani@meta.com>
> > > > 
> > > > Summary: Document that provides an overview of libbpf features for BPF
> > > > application development.
> > > 
> > > It seems like you ignore some of my reviews at [1]. Anyway, I
> > > repeat them here, augmenting my new comments.
> > 
> > Sreevani, please be sure to reply to and address all reviewers'
> > comments. I've also requested that we not use these internal Meta tags
> > on more than one occasion, so please be mindful of it for future
> > patches, and take a bit of extra time to double check that you've
> > addressed all reviewers' concerns. I also suggest reading over [0],
> > which specifies that new versions of patches should include descriptions
> > of what's changed from prior versions. Please see Joanne's patch set in
> > [1] which serves as a very nice example.
> > 
> > [0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> > [1]: https://lore.kernel.org/all/20230301154953.641654-1-joannelkoong@gmail.com/
> > 
> > Bagas -- just FYI, a quick git log would have shown that this is only
> > Sreevani's second patch. I don't think she intentionally ignored
> > anything. It's likely just an artifact of getting used to the kernel
> > review process.
> 
> Oops, you mean this v3 is actually v2, right?

Oh, I just meant that this is her second patch submission to the Linux
kernel in general, (the first was [0]), so she likely just accidentally
forgot to address your comments rather than intentionally ignoring them.
Of course, it's good that you highlighted them again here in v3, as they
certainly need to be addressed.

[0]: https://lore.kernel.org/all/20221202221710.320810-2-ssreevani@meta.com/

> 
> > > Why did you add heading overline and change the heading character marker?
> > 
> > I assume that Sreevani is following python documentation conventions [0], which
> > suggest that #### with overline refers to the highest-level heading in a page.
> > This is suggested in Sphinx documentation [1] as well.
> > 
> > [0]: https://devguide.python.org/documentation/markup/#sections
> > [1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> 
> OK.
> 
> > > You may want to also add :lineos: option or manually add line numbers
> > > if you add :emphasize-lines: so that readers can see the line number
> > > it refers to.
> > 
> > What is :lineos:? I don't see it anywhere else in Documentation/ and if
> > I add it, the docs build complains:
> > 
> > Documentation/bpf/libbpf/libbpf_overview.rst:177: WARNING: Error in "code-block" directive:
> > unknown option: "lineos".
> > 
> > .. code-block:: C
> >   :lineos:
> >   :emphasize-lines: 6
> 
> You forget to indent both options (see [1]).

The indentation was correct ;-) The option is actually ":linenos", not
":lineos:". That said, it's a neat option, so thank you for pointing it
out.

> > 
> >   //...
> >   struct task_struct *task = (void *)bpf_get_current_task();
> >   struct task_struct *parent_task;
> >   int err;
> > 
> >   err = bpf_core_read(&parent_task, sizeof(void *), &task->parent);
> >   if (err) {
> >     /* handle error */
> >   }
> > 
> >   /* parent_task contains the value of task->parent pointer */
> > 
> > I personally think adding line numbers is overkill. The highlighting is
> > already a nice touch, and gets the point across without the additional
> > visual cue of line numbers.
> 
> But if the snippet above is instead long, how can one looking for the
> emphasized line number when reading doc (especially in .rst source) other
> than manually counting from the first line of the snippet? See
> Documentation/RCU/rcubarrier.rst for example of manual line numbering
> (and [2] for the related patch).

Well, that's a bit of a hypothetical problem given that in this case
we're only talking about 6 lines ;-) In any case, I don't really mind
one way or the other, but given that none of the other example
codeblocks in the BPF docs have line numbers, I'd personally err on the
side of not adding them here.

> > > BPF apps are application that use BPF program, right? I thought that
> > > despite there is libbpf-rs, I still have to develop BPF apps in C.
> > 
> > It says that at the end of the paragraph?
> > 
> 
> I was confused between BPF apps and BPF programs, since I was accustomed
> that apps and programs refer to the same thing.

This is alluded to a bit earlier in this document:

> A BPF application consists of one or more BPF programs (either
> cooperating or completely independent), BPF maps, and global
> variables.

"Program" in the context of BPF has a very specific meaning. We need to
improve our documentation on them, but see [1] for a bit more detail.
The TL;DR is that the BPF program is the part that runs in kernel space.

[1]: https://www.kernel.org/doc/html/latest/bpf/libbpf/program_types.html#program-types-and-elf

Thanks,
David
