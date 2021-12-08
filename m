Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C092C46DB3B
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhLHSlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhLHSlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1371C0617A1;
        Wed,  8 Dec 2021 10:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49B0ECE22BB;
        Wed,  8 Dec 2021 18:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51130C341C7;
        Wed,  8 Dec 2021 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988655;
        bh=UGWKwIof9E7u8P/fyoJ9qbfGRCATWRY0m4gOhnlvIVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diQo/slfiXVshACWv4UZWz/62VRLuRmjOp5pgJaJnTJzKqvrNjbkF/OHsjVFHt2Ps
         1H+FFRQVs+nPsCeAW+rftHZC2v8QRATrSxJmv9YLmn1mFp38WWu5rF0yy1c2/qmZEC
         DA/4pDsrkErmuxb9ZeMItalM+vbQYrIQJXsIWMxOc1cgXBKxhRVOoTMy7bJLAAa8FR
         NuRIbrbUDa6WcDj+VTFNmv/tCM47uC1sMHjssgooSJ/hshcxd7+Wk4jXmOcHKlHjqZ
         7MzuxACZ7tIEx8rlWujFTf+WAyw8ys0GtShPdvz157cBnDsK6bR9MzNCOQPLa5zvYV
         m26WlpO1WGVnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D2E5406C1; Wed,  8 Dec 2021 15:37:33 -0300 (-03)
Date:   Wed, 8 Dec 2021 15:37:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jan Engelhardt <jengelh@inai.de>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Message-ID: <YbD7bTb3gYOlOoo3@kernel.org>
References: <YSQSZQnnlIWAQ06v@kernel.org>
 <YbC5MC+h+PkDZten@kernel.org>
 <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr>
 <YbD696GWcp+KeMyg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbD696GWcp+KeMyg@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 08, 2021 at 03:35:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 08, 2021 at 03:26:31PM +0100, Jan Engelhardt escreveu:
> > On Wednesday 2021-12-08 14:54, Arnaldo Carvalho de Melo wrote:
> > >	The v1.23 release of pahole and its friends is out, this time
> > >the main new features are the ability to encode BTF tags, to carry
> > 
> > [    7s] /home/abuild/rpmbuild/BUILD/dwarves-1.23/btf_encoder.c:145:10: error: 'BTF_KIND_DECL_TAG' undeclared here (not in a function); did you mean 'BTF_KIND_FLOAT'?
 
> > libbpf-0.5.0 is present, since CMakeLists.txt checked for >= 0.4.0.
 
> My fault, knowing the flux that libbpf is in getting to 1.0 I should
> have retested with the perf tools container based tests.
 
> Can you think about some fix for that? Lemme see if BTF_KIND_DECL_TAG is
> a define or an enum...

enum {
        BTF_KIND_UNKN           = 0,    /* Unknown      */
        BTF_KIND_INT            = 1,    /* Integer      */
        BTF_KIND_PTR            = 2,    /* Pointer      */
        BTF_KIND_ARRAY          = 3,    /* Array        */
        BTF_KIND_STRUCT         = 4,    /* Struct       */
        BTF_KIND_UNION          = 5,    /* Union        */
        BTF_KIND_ENUM           = 6,    /* Enumeration  */
        BTF_KIND_FWD            = 7,    /* Forward      */
        BTF_KIND_TYPEDEF        = 8,    /* Typedef      */
        BTF_KIND_VOLATILE       = 9,    /* Volatile     */
        BTF_KIND_CONST          = 10,   /* Const        */
        BTF_KIND_RESTRICT       = 11,   /* Restrict     */
        BTF_KIND_FUNC           = 12,   /* Function     */
        BTF_KIND_FUNC_PROTO     = 13,   /* Function Proto       */
        BTF_KIND_VAR            = 14,   /* Variable     */
        BTF_KIND_DATASEC        = 15,   /* Section      */
        BTF_KIND_FLOAT          = 16,   /* Floating point       */
        BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
        BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */

        NR_BTF_KINDS,
        BTF_KIND_MAX            = NR_BTF_KINDS - 1,
};

Do you guys have any plans on updating libbpf?

- Arnaldo
