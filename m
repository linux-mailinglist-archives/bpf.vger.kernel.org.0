Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CAF560ACA
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiF2UAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiF2UAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 16:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C7647C;
        Wed, 29 Jun 2022 13:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34BD620CE;
        Wed, 29 Jun 2022 20:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197DCC34114;
        Wed, 29 Jun 2022 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656532835;
        bh=u23t306HkozwMNEu7DKxfvaxMabsbXvH7Mg7T49T4U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tr2IQgOP7x1jI8Rt9l9piZOUqOIu6518+p+08GWxBnQ07VDI5GilUb+yac6KwUAcd
         bPXVjYD84GSrA2pcJfsXmIkBiG/5fMc5SXLJJuR3qM+eQnY+1yKN+DYVtPsM+6wb4D
         ZpbhEkC2b38VLTFtAbJ9HzlVebaeILpqS+hdYmeJzjDRuib3RjSaVB5sb3yiEZbB2T
         uc56wDIys50eoiz8nnctL5+XNdWdW0EEYuK7o46EvaYNjElTThmkUHUcoX+RCXydzD
         xY3ODqz78X/+XKEBHs7HY0kbTZoSoCqZJtAF6jceaRXEt/9/3F/DRWix3LFCwYxt9R
         4gSE0GN6W3hJg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 577644096F; Wed, 29 Jun 2022 17:00:32 -0300 (-03)
Date:   Wed, 29 Jun 2022 17:00:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 2/2] btf: Support BTF_KIND_ENUM64
Message-ID: <YryvYNjbDFWDHtvY@kernel.org>
References: <20220629071213.3178592-1-yhs@fb.com>
 <20220629071224.3180594-1-yhs@fb.com>
 <YrykE1zgKXvKaAgx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrykE1zgKXvKaAgx@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 29, 2022 at 04:12:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jun 29, 2022 at 12:12:24AM -0700, Yonghong Song escreveu:
> > BTF_KIND_ENUM64 is supported with latest libbpf, which
> > supports 64-bit enum values. Latest libbpf also supports
> > signedness for enum values. Add enum64 support in
> > dwarf-to-btf conversion.
> > 
> > The following is an example of new encoding which covers
> > signed/unsigned enum64/enum variations.
> 
> So, testing this with torvalds/master I'm getting:
> 
> FAILED: load BTF from vmlinux: Invalid argument
> make[1]: *** [/var/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> make[1]: *** Deleting file 'vmlinux'
> make[1]: Leaving directory '/var/home/acme/git/build/v5.19-rc4+'
> make: *** [Makefile:219: __sub-make] Error 2
> 
> real	8m12.396s
> user	183m18.009s
> sys	44m27.085s
> ⬢[acme@toolbox linux]$ find . -name "*.c" | xargs grep "load BTF from vmlinux"
> ⬢[acme@toolbox linux]$ find . -name "*.c" | xargs grep "load BTF from"
> ./tools/bpf/bpftool/btf.c:			p_err("failed to load BTF from %s: %s",
> ./tools/bpf/resolve_btfids/main.c:		pr_err("FAILED: load BTF from %s: %s\n",
> ./tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:		  "Failed to load BTF from btf_data.o\n"))
> ⬢[acme@toolbox linux]$ vim ./tools/bpf/resolve_btfids/main.c
> 
> Which is:
> 
>         btf = btf__parse_split(obj->btf ?: obj->path, base_btf);
>         err = libbpf_get_error(btf);
>         if (err) {
>                 pr_err("FAILED: load BTF from %s: %s\n",
>                         obj->btf ?: obj->path, strerror(-err));
>                 goto out;
>         }
> 
> I.e. tools/lib/bpf in torvalds/master doesn´t support BTF_KIND_ENUM64,
> right? So to build it with a new pahole one needs to ask for
> --skip_encoding_btf_enum64? How to do this automagically? I.e. its a
> matter of checking if the in-kernel libbpf has support for it and if not
> use --skip_encoding_btf_enum64?
> 
> I'm now going to try with bpf-next/master

Yeah, works with bpf-next:

⬢[acme@toolbox bpf-next]$ pdwtags -F btf ../build/bpf-next/vmlinux | grep -A5 -B5 BPF_F_CTXLEN_MASK

/* 28548 */
enum {
	BPF_F_INDEX_MASK  = 4294967295,
	BPF_F_CURRENT_CPU = 4294967295,
	BPF_F_CTXLEN_MASK = 4503595332403200,
} __attribute__((__packed__)); /* size: 8 */

/* 28549 */
enum {
	BPF_F_GET_BRANCH_RECORDS_SIZE = 1,
⬢[acme@toolbox bpf-next]$
