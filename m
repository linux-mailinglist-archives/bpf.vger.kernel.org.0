Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28135EDCB2
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiI1Mbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiI1MbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 08:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44329551B
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664368279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUgn5vL7ARQHKQrvPTX+ukLORkYug6WzUmsN3XyxN9s=;
        b=eEgG812BLHL4JvaWn2qskcb3FJOY3QZGAqAPwRLgk41jRsJb3E8JtRpQfrMxLbrUOY8gi3
        fwrHK0zk2EYSD8n7tuWfw6F0lUo8BR7WscnURsfBX5vf2+wMxpF1YdffU6VIyEBwgMonhh
        7DRFac76vE66kX5XZOW+pMW6ANrWUGY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-awz6rSoYPziP08EN6poQrg-1; Wed, 28 Sep 2022 08:31:18 -0400
X-MC-Unique: awz6rSoYPziP08EN6poQrg-1
Received: by mail-qt1-f197.google.com with SMTP id s21-20020a05622a1a9500b0035bb9e79172so8898603qtc.20
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 05:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YUgn5vL7ARQHKQrvPTX+ukLORkYug6WzUmsN3XyxN9s=;
        b=VdV7b54PJLglK76yYwsvjfW62cYKbRWQkXtkkzDeB914ZFqSxPzmpVZgrsCNYOjEql
         8AhPz6x1DDJ12sFNQlf5HTFQwcOJ1luzTsk0yT4QerI/DfkgsqVvGJSwTtvPvZ8pdvGc
         wuJG5VnCjx4l/B3HeKrAy4jIbK+lD5feuB2+64TBxhTBXl5xXSyoSXqek8l2lm3cY50X
         LdTdKY4T9O5HJwCMeSUtLv2YWetVFyIB1Wunlb/tcNlpIrXkGT1xwiYNrYH2Odi5ySVm
         TY99/5fccilt8ETOxuilKst/5bduuQbG9YGH9nfLo4Y8mT2tDrzaRTjFU79CB3+Dwpg9
         9R5Q==
X-Gm-Message-State: ACrzQf0j6xxpwIgDfUaIIcnZqjpIERCfllGAAk37k4s50H7QeAAC6rs1
        W2yek/BuvzZs2UEtOe/dh4km0rWSkFUmGmZt+G57GojKvqtwXGniozvBDrw8ZoXFk1FcZ7nmAiD
        SxoleCuMOgf1q
X-Received: by 2002:a05:6214:5e89:b0:4ad:77be:92d2 with SMTP id mm9-20020a0562145e8900b004ad77be92d2mr25511726qvb.44.1664368278183;
        Wed, 28 Sep 2022 05:31:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4PbQJ+vfyVVc91q7d0EPN4uYeYNDQGfG5xsGwekNg222gOjWfUKFbh7oqTnjs/VG8qTacggA==
X-Received: by 2002:a05:6214:5e89:b0:4ad:77be:92d2 with SMTP id mm9-20020a0562145e8900b004ad77be92d2mr25511702qvb.44.1664368277917;
        Wed, 28 Sep 2022 05:31:17 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a2-20020ac81082000000b0035d1f846b91sm2748482qtj.64.2022.09.28.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:31:16 -0700 (PDT)
Date:   Wed, 28 Sep 2022 08:31:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
Message-ID: <YzQ+ke3JIx69Plld@bfoster>
References: <20220926231822.994383-1-drosen@google.com>
 <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 11:41:50PM -0700, Martin KaFai Lau wrote:
> On 9/26/22 4:17 PM, Daniel Rosenberg wrote:
> > These patches extend FUSE to be able to act as a stacked filesystem. This
> > allows pure passthrough, where the fuse file system simply reflects the lower
> > filesystem, and also allows optional pre and post filtering in BPF and/or the
> > userspace daemon as needed. This can dramatically reduce or even eliminate
> > transitions to and from userspace.
> > 
> > Currently, we either set the backing file/bpf at mount time at the root level,
> > or at lookup time, via an optional block added at the end of the lookup return
> > call. The added lookup block contains an fd for the backing file/folder and bpf
> > if necessary, or a signal to clear or inherit the parent values. We're looking
> > into two options for extending this to mkdir/mknod/etc, as we currently only
> > support setting the backing to a pre-existing file, although naturally you can
> > create new ones. When we're doing a lookup for create, we could pass an
> > fd for the parent dir and the name of the backing file we're creating. This has
> > the benefit of avoiding an additional call to userspace, but requires hanging
> > on to some data in a negative dentry where there is no elegant place to store it.
> > Another option is adding the same block we added to lookup to the create type
> > op codes. This keeps that code more uniform, but means userspace must implement
> > that logic in more areas.
> > 
> > As is, the patches definitely need some work before they're ready. We still
> > need to go through and ensure we respect changed filter values/disallow changes
> > that don't make sense. We aren't currently calling mnt_want_write for the lower
> > calls where appropriate, and we don't have an override_creds layer either. We
> > also plan to add to our read/write iter filters to allow for more interesting
> > use cases. There are also probably some node id inconsistencies. For nodes that
> > will be completely passthrough, we give an id of 0.
> > 
> > For the BPF verification side, we have currently set things set up in the old
> > style, with a new bpf program type and helper functions. From LPC, my
> > understanding is that newer bpf additions are done in a new style, so I imagine
> > much of that will need to be redone as well, but hopefully these patches get
> > across what our needs there are.
> > 
> > For testing, we've provided the selftest code we have been using. We also have
> > a mode to run with no userspace daemon in a pure passthrough mode that I have
> > been running xfstests over to get some coverage on the backing operation code.
> > I had to modify mounts/unmounts to get that running, along with some other
> > small touch ups. The most notable failure I currently see there is in
> > generic/126, which I suspect is likely related to override_creds.
> > 
> 
> Interesting idea.
> 
> Some comments on review logistics:
> - The set is too long and some of the individual patches are way too long
> for one single patch to review.  Keep in mind that not all of us here are
> experts in both fuse and bpf.  Making it easier to review first will help at
> the beginning.  Some ideas:
> 
>   - Only implement a few ops in the initial revision. From quickly browsing
> the set, it is implementing the 'struct file_operations
> fuse_file_operations'? Maybe the first few revisions can start with a few of
> the ops first.
> 

I had a similar thought when poking through this. A related question I
had is how much of a functional dependency does the core passthrough
mechanism have on bpf? If bpf is optional for filtering purposes and
isn't absolutely necessary to set up a basic form of passthrough, I
think review would be made easier by splitting off those core bits from
the bpf components so each part is easier to review by people who know
them best. For example, introduce all the fuse enhancements, hooks and
cleanups to set up a passthrough to start the series, then plumb in the
bpf filtering magic on top. Hm?

FWIW, if this is an RFC/prototype and you want more efficient review
cycles, another idea to take that a step further could be to start with
read-only support (or maybe even just directory walking?).

BTW if the bpf bits are optional, how might one mount a fuse/no
daemon/passthrough filesystem from userspace? Is that possible with this
series as is?

Something more on the fuse side.. it looks like we introduce a pattern
where bits of generic request completion processing can end up
duplicated between the shortcut (i.e.  _backing()/_finalize()) handlers
and the traditional post request code, because the shortcuts basically
bypass the entire rest of the codepath. For example, something like
create_new_entry() is currently reused for several inode creation
operations. With passthrough mode, it looks like some of that code (i.e.
vfs dentry fixups) is split off from create_new_entry() into each
individual backing mode handler.

It looks like much of the lower level request processing code was
refactored into the fuse_iqueue to support things like virtiofs. Have
you looked into whether that abstraction can be reused or enhanced to
support bpf filtering, direct passthrough calls, etc.? Or perhaps
whether more of the higher level code could be refactored in a similar
way to encourage more reuse and avoid branching off every fs operation
into a special passthrough codepath?

Brian

>   - Please make the patches that can be applied to the bpf-next tree
> cleanly. For example, in patch 3, where is 18e2ec5bf453 coming from? I
> cannot find it in bpf-next and linux-next tree.
>   - Without applying it to an upstream tree cleanly, in a big set like this,
> I have no idea when bpf_prog_run() is called in patch 24 because the diff
> context is in fuse_bpf_cleanup and apparently it is not where the bpf prog
> is run.
> 
> Some high level comments on the set:
> - Instead of adding bpf helpers, you should consider kfunc instead. You can
> take a look at the recent HID patchset v10 or the recent nf conntrack bpf
> set.
> 
> - Instead of expressing as packet data, using the recent dynptr is a better
> way to go for handling a mem blob.
> 
> - iiuc, the idea is to allow bpf prog to optionally handle the 'struct
> file_operations' without going back to the user daemon? Have you looked at
> struct_ops which seems to be a better fit here?  If the bpf prog does not
> know how to handle an operation (or file?), it can call fuse_file_llseek
> (for example) as a kfunc to handle the request.
> 
> - The test SEC("test_trace") seems mostly a synthetic test for checking
> correctness.  Does it have a test that shows a more real life use case? or I
> have missed things in patch 26?
> 
> - Please use the skel to load the program.  It is pretty hard to read the
> loader in patch 26.
> 
> - I assume the main objective is for performance by not going back to the
> user daemon?  Do you have performance number?
> 

