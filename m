Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA352AB5F
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbiEQS7P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349950AbiEQS7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 14:59:14 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34E50054
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 11:59:13 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5D98A24002B
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 20:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652813952; bh=RbZrBvS0/1rSshWYVKteCKaXLW3Tai1TF13wNttlPn4=;
        h=Date:From:To:Cc:Subject:From;
        b=Dw+NcfkGSU87PagVS9OF6ocpX/mlRE3wGUN90yWMDBF8ITvgKjVRvF1euIa71N5u6
         5koilr5RenGyzdDIdNMVB7DU/kc8CvCpddpdsKoERtmpx2Y5VfmFzJS019GwZ7KqHv
         byyYfrrsIcIfePJIUA/KdLLv9oDf4R7hwJ+HMXFEqV4ne+XCQDqZshrlu40xJ5i+6m
         5Fyg9iD2zNfjpGg2cSMAWpzempIyswskJWxHDMqamokH3fsNT2/mMj8rW+slCPIHc4
         nzLNW05yLj2vT1nwxWu1hi7DFG1+0ArZorVaU/xmsmNlVgLih4X8mAM8ejAFDYovPx
         sw6oq7vxXo1aw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L2llf53HHz9rxG;
        Tue, 17 May 2022 20:59:10 +0200 (CEST)
Date:   Tue, 17 May 2022 18:59:08 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 00/12] libbpf: Textual representation of enums
Message-ID: <20220517185908.5sa2ohdqsduwo5yh@devvm5318.vll0.facebook.com>
References: <20220516173540.3520665-1-deso@posteo.net>
 <CAEf4BzYg24WGidanbqQHQnUUeWS0JFKze08cGCPtD+EX94LrFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYg24WGidanbqQHQnUUeWS0JFKze08cGCPtD+EX94LrFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 04:43:42PM -0700, Andrii Nakryiko wrote:
> On Mon, May 16, 2022 at 10:35 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > This patch set introduces the means for querying a textual representation of
> > the following BPF related enum types:
> > - enum bpf_map_type
> > - enum bpf_prog_type
> > - enum bpf_attach_type
> > - enum bpf_link_type
> >
> > To make that possible, we introduce a new public function for each of the types:
> > libbpf_bpf_<type>_type_str.
> >
> > Having a way to query a textual representation has been asked for in the past
> > (by systemd, among others). Such representations can generally be useful in
> > tracing and logging contexts, among others. At this point, at least one client,
> > bpftool, maintains such a mapping manually, which is prone to get out of date as
> > new enum variants are introduced. libbpf is arguably best situated to keep this
> > list complete and up-to-date. This patch series adds BTF based tests to ensure
> > that exhaustiveness is upheld moving forward.
> >
> > The libbpf provided textual representation can be inferred from the
> > corresponding enum variant name by removing the prefix and lowercasing the
> > remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
> > bpftool does not use such a programmatic approach for some of the
> > bpf_attach_type variants. We propose a work around keeping the existing behavior
> > for the time being in the patch titled "bpftool: Use
> > libbpf_bpf_attach_type_str".
> >
> > The patch series is structured as follows:
> > - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
> >   bpf_link_type}:
> >   - we first introduce the corresponding public libbpf API function
> >   - we then add BTF based self-tests
> >   - we lastly adjust bpftool to use the libbpf provided functionality
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> >
> > Daniel Müller (12):
> >   libbpf: Introduce libbpf_bpf_prog_type_str
> >   selftests/bpf: Add test for libbpf_bpf_prog_type_str
> >   bpftool: Use libbpf_bpf_prog_type_str
> >   libbpf: Introduce libbpf_bpf_map_type_str
> >   selftests/bpf: Add test for libbpf_bpf_map_type_str
> >   bpftool: Use libbpf_bpf_map_type_str
> >   libbpf: Introduce libbpf_bpf_attach_type_str
> >   selftests/bpf: Add test for libbpf_bpf_attach_type_str
> >   bpftool: Use libbpf_bpf_attach_type_str
> >   libbpf: Introduce libbpf_bpf_link_type_str
> >   selftests/bpf: Add test for libbpf_bpf_link_type_str
> >   bpftool: Use libbpf_bpf_link_type_str
> >
> 
> Looks good to me overall. But keep in mind that libbpf v0.8 was just
> released, so these new APIs will have to go into 1.0 section in
> libbpf.map. It can't inherit from 0.8, btw, so this is a bit new
> procedure, I'll try to get to it in next few days. Meanwhile I'd like
> to get some feedback at least from Quentin on bpftool changes.

Thanks for the heads up (and the review)! I am happy to rebase once we have
figured out the procedure.

[...]

Daniel
