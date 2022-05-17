Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170552A712
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350266AbiEQPj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiEQPj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 11:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C6A19B;
        Tue, 17 May 2022 08:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 609A4B819D2;
        Tue, 17 May 2022 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2354C34116;
        Tue, 17 May 2022 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652801992;
        bh=blnuPm+xDVANBqdOzb9CbPF25QESuuLZnhzceKMLgGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCVJ/HIwwbw6XdxB0/X8gM7W2DOn7BXmytLZCEcZ/ADOuLGFdxtYmfKWY/+KXjjyV
         8l+SRugYUqvyvcUKTpCDFNW3DvOCP2/Orq3pcl29ADDUGD/SzOhMGdrZidwYf6C+YG
         Tw2NykPIN6QNyKhYoB74X8xdg5MytsNdslpa5btmPmLLJ52WdRT543P93Jyb1ZO3z7
         VeTTru4CFKoRWPQpOdtUJ4k90WLnBBBWxADeyjiMkwEnKRR1t24yUcz1yhJV2MZJPx
         JsiGIwY2lToUe2vkBlgxkTBK/67KTicKkNQ5xXWGYZwqxLXH+JIOEZ5rjWkbbgFs9c
         kagyj6y23A7yQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBDB9400B1; Tue, 17 May 2022 12:39:48 -0300 (-03)
Date:   Tue, 17 May 2022 12:39:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: Normalize array index type
 for parallel dwarf loading case
Message-ID: <YoPBxEscJTw2YPTC@kernel.org>
References: <20220512051759.2652236-1-yhs@fb.com>
 <20220512051804.2653507-1-yhs@fb.com>
 <CAEf4Bzbr1M-WZLk1CRbSy5Ai8CCAH6JJH_=hGJ0rgQtriV8Ndg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbr1M-WZLk1CRbSy5Ai8CCAH6JJH_=hGJ0rgQtriV8Ndg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, May 12, 2022 at 03:55:14PM -0700, Andrii Nakryiko escreveu:
> On Wed, May 11, 2022 at 10:18 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > With latest llvm15 built kernel (make -j LLVM=1), I hit the following
> > error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=1):
> >   In file included from skeleton/pid_iter.bpf.c:3:
> >   .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
> >        '__builtin_va_list___2'; did you mean '__builtin_va_list'?
> >   typedef __builtin_va_list___2 va_list___2;
> >           ^~~~~~~~~~~~~~~~~~~~~
> >           __builtin_va_list
> >   note: '__builtin_va_list' declared here
> >   In file included from skeleton/profiler.bpf.c:3:
> >   .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
> >        '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
> >   typedef __builtin_va_list___2 va_list___2;
> >           ^~~~~~~~~~~~~~~~~~~~~
> >           __builtin_va_list
> >   note: '__builtin_va_list' declared here
> >
> > The error can be easily explained with after-dedup vmlinux btf:
> >   [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >   [2300] STRUCT '__va_list_tag' size=24 vlen=4
> >         'gp_offset' type_id=2 bits_offset=0
> >         'fp_offset' type_id=2 bits_offset=32
> >         'overflow_arg_area' type_id=32 bits_offset=64
> >         'reg_save_area' type_id=32 bits_offset=128
> >   [2308] TYPEDEF 'va_list' type_id=2309
> >   [2309] TYPEDEF '__builtin_va_list' type_id=2310
> >   [2310] ARRAY '(anon)' type_id=2300 index_type_id=21 nr_elems=1
> >
> >   [5289] PTR '(anon)' type_id=2308
> >   [158520] STRUCT 'warn_args' size=32 vlen=2
> >         'fmt' type_id=14 bits_offset=0
> >         'args' type_id=2308 bits_offset=64
> >   [27299] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> >   [34590] TYPEDEF '__builtin_va_list' type_id=34591
> >   [34591] ARRAY '(anon)' type_id=2300 index_type_id=27299 nr_elems=1
> >
> > Note that two array index_type_id's are different so the va_list and __builtin_va_list
> > will have two versions in the BTF. With this, vmlinux.h contains the following code,
> >   typedef __builtin_va_list va_list;
> >   typedef __builtin_va_list___2 va_list___2;
> > Since __builtin_va_list is a builtin type for the compiler,
> > libbpf does not generate
> >   typedef <...> __builtin_va_list
> > and this caused __builtin_va_list___2 is not defined and hence compilation error.
> > This happened when pahole is running with more than one jobs when parsing dwarf
> > and generating btfs.
> >
> > Function btf_encoder__encode_cu() is used to do btf encoding for
> > each cu. The function will try to find an "int" type for the cu
> > if it is available, otherwise, it will create a special type
> > with name __ARRAY_SIZE_TYPE__. For example,
> >   file1: yes 'int' type
> >   file2: no 'int' type
> >
> > In serial mode, file1 is processed first, followed by file2.
> > both will have 'int' type as the array index type since file2
> > will inherit the index type from file1.
> >
> > In parallel mode though, arrays in file1 will have index type 'int',
> > and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
> > This will prevent some legitimate dedup and may have generated
> > vmlinux.h having compilation error.
> >
> > This patch fixed the issue by creating an 'int' type as the
> > array index type, so all array index type should be the same
> > for all cu's even in parallel mode.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  btf_encoder.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> 
> LGTM, it should work reliably.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Applied and testing.

- Arnaldo
 
> > Changelog:
> >   v1 -> v2:
> >    - change creation of array index type to be 'int' type,
> >      the same as the type encoder tries to search in the current
> >      types.
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 1a42094..9e708e4 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1460,7 +1460,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
> >
> >                 bt.name = 0;
> >                 bt.bit_size = 32;
> > -               btf_encoder__add_base_type(encoder, &bt, "__ARRAY_SIZE_TYPE__");
> > +               bt.is_signed = true;
> > +               btf_encoder__add_base_type(encoder, &bt, "int");
> >                 encoder->has_index_type = true;
> >         }
> >
> > --
> > 2.30.2
> >

-- 

- Arnaldo
