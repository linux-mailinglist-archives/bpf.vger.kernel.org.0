Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E069962C63A
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKPRUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiKPRUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:20:35 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC555B870
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 09:20:27 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id F1FE0240101
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1668619226; bh=igHRVTkN17BSGhnrJrrTAcBs1WPYuwXyLMqiSZyBTk0=;
        h=Date:From:To:Cc:Subject:From;
        b=pY1ecd946qFDQEjP2F26PKxXMhPk1NlPc4KMY9u5FhujzVnmxzq5ZRexk7zgP3ZvX
         tCn1IVTzEqPKS6nJzcTu4Mw6oSLOB+ZX+9r5v81IBj41n3Oq0mGe9ZNyh/XvQSse/H
         2LwJafxBpiNW6AuAXILMR96PW9OWgyoRUEvgkazYFMMIbU6KA0/kqQ9BfHQaF2Tnom
         cY4i+ltO3F3ho6wa5EFvBexFuAAy+vEWkfih6h9P3hVuyWxJ+H4r26RDuEJpDppSIV
         vXmfMbotKe3bDRWa3m/bWlHDdEzG+/YA7upzhwaSZeDROPklKy7WevS6mUihTZs51L
         NwhxrU0qR3sWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NC8vB2bt3z6tmG;
        Wed, 16 Nov 2022 18:20:22 +0100 (CET)
Date:   Wed, 16 Nov 2022 17:20:19 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, kafai@fb.com,
        kernel-team@fb.com, quentin@isovalent.com
Subject: Re: [PATCH bpf-next] docs/bpf: Document how to run CI without patch
 submission
Message-ID: <20221116172019.mmoocxhkhan6kuhx@muellerd-fedora-MJ0AC3F3>
References: <20221114211501.2068684-1-deso@posteo.net>
 <52151d09-92c5-f6cb-c426-f36ee0c44282@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52151d09-92c5-f6cb-c426-f36ee0c44282@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Akira,

On Wed, Nov 16, 2022 at 07:01:17PM +0900, Akira Yokosawa wrote:
> I know this has already been applied, but am seeing new warning msgs
> from "make htmldocs" due to this change. Please see inline comment
> below.
> 
> On Mon, 14 Nov 2022 21:15:01 +0000, Daniel Müller wrote:
> > This change documents the process for running the BPF CI before
> > submitting a patch to the upstream mailing list, similar to what happens
> > if a patch is send to bpf@vger.kernel.org: it builds kernel and
> > selftests and runs the latter on different architecture (but it notably
> > does not cover stylistic checks such as cover letter verification).
> > Running BPF CI this way can help achieve better test coverage ahead of
> > patch submission than merely running locally (say, using
> > tools/testing/selftests/bpf/vmtest.sh), as additional architectures may
> > be covered as well.
> > 
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  Documentation/bpf/bpf_devel_QA.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> > index 761474..08572c7 100644
> > --- a/Documentation/bpf/bpf_devel_QA.rst
> > +++ b/Documentation/bpf/bpf_devel_QA.rst
> > @@ -44,6 +44,30 @@ is a guarantee that the reported issue will be overlooked.**
> >  Submitting patches
> >  ==================
> >  
> > +Q: How do I run BPF CI on my changes before sending them out for review?
> > +------------------------------------------------------------------------
> > +A: BPF CI is GitHub based and hosted at https://github.com/kernel-patches/bpf.
> > +While GitHub also provides a CLI that can be used to accomplish the same
> > +results, here we focus on the UI based workflow.
> > +
> > +The following steps lay out how to start a CI run for your patches:
> 
> Lack of a blank line here results in warning msgs from "make htmldocs":
> 
> /linux/Documentation/bpf/bpf_devel_QA.rst:55: ERROR: Unexpected indentation.
> /linux/Documentation/bpf/bpf_devel_QA.rst:56: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Can you please fix it?
> 
> For your reference, here is a link to reST documentation on bullet lists:
> 
>     https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bullet-lists
> 
>         Thanks, Akira

Thanks for pointing that out. I had not found any references to this rst file
being included in automated doc generation. Will fix it up.

Daniel
