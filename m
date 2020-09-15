Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEF26A4E7
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIOMSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 08:18:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgIOMRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 08:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600172268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9oOgxpngHTB1FtU/CXAt4u7kW8ArCGsX+y8YuT6JY4w=;
        b=JWwd+9aA4eEXLkNgyTbMBiCEamLXp7Jglo+NyMrMBPKZbJ6QCugQMEoKw4nmzzkt3pafei
        7+qDCONT1BabLxhKokRp8zBRlgCS4jxFMHp998KIU99s2mFCz7u3XfiXb4kwHiVINHg59o
        lX0mT4kRTvS83sBWkaeUDd1QM3uqnBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-mt6TTkJOMoCZCpYsv2KNAQ-1; Tue, 15 Sep 2020 08:17:47 -0400
X-MC-Unique: mt6TTkJOMoCZCpYsv2KNAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D64BB1882FA0;
        Tue, 15 Sep 2020 12:17:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 086195DDB8;
        Tue, 15 Sep 2020 12:17:43 +0000 (UTC)
Date:   Tue, 15 Sep 2020 14:17:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20200915121743.GA2199675@krava>
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava>
 <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915073030.GE1714160@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 09:30:33AM +0200, Jiri Olsa wrote:
> On Mon, Sep 14, 2020 at 03:26:33PM -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 14, 2020 at 11:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Sep 14, 2020 at 10:48:36AM -0400, Veronika Kabatova wrote:
> > > >
> > > > Hello,
> > > >
> > > > we tested the bpf-next tree with CKI and ran across build failures. The
> > > > important part of the build log is:
> > > >
> > > > 00:18:05   GEN     .version
> > > > 00:18:05   CHK     include/generated/compile.h
> > > > 00:18:05   LD      vmlinux.o
> > > > 00:18:27   MODPOST vmlinux.symvers
> > > > 00:18:27   MODINFO modules.builtin.modinfo
> > > > 00:18:27   GEN     modules.builtin
> > > > 00:18:27   LD      .tmp_vmlinux.btf
> > > > 00:18:42   BTF     .btf.vmlinux.bin.o
> > > > 00:19:13   LD      .tmp_vmlinux.kallsyms1
> > > > 00:19:19   KSYM    .tmp_vmlinux.kallsyms1.o
> > > > 00:19:22   LD      .tmp_vmlinux.kallsyms2
> > > > 00:19:25   KSYM    .tmp_vmlinux.kallsyms2.o
> > > > 00:19:28   LD      vmlinux
> > > > 00:19:40   BTFIDS  vmlinux
> > > > 00:19:40 FAILED unresolved symbol vfs_getattr
> > > > 00:19:40 make[2]: *** [Makefile:1167: vmlinux] Error 255
> > > > 00:19:40 make[1]: *** [scripts/Makefile.package:109: targz-pkg] Error 2
> > > > 00:19:40 make: *** [Makefile:1528: targz-pkg] Error 2
> > >
> > > hi,
> > > it looks like broken BTF data to me, I checked that build
> > > and found we have multiple records for functions, like
> > > for filp_close:
> > >
> > >         [23381] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
> > >                 '(anon)' type_id=464
> > >                 'id' type_id=960
> > >         [23382] FUNC 'filp_close' type_id=23381 linkage=static
> > >
> > >
> > >         [33073] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
> > >                 'filp' type_id=464
> > >                 'id' type_id=960
> > >         [33074] FUNC 'filp_close' type_id=33073 linkage=static
> > >
> > >
> > > or vfs_getattr:
> > >
> > >         [33513] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
> > >                 'path' type_id=741
> > >                 'stat' type_id=1095
> > >                 'request_mask' type_id=29
> > >                 'query_flags' type_id=8
> > >
> > >         [33514] FUNC 'vfs_getattr' type_id=33513 linkage=static
> > >
> > >         [1094] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
> > >                 '(anon)' type_id=741
> > >                 '(anon)' type_id=1095
> > >                 '(anon)' type_id=29
> > >                 '(anon)' type_id=8
> > >
> > >         [35099] FUNC 'vfs_getattr' type_id=1094 linkage=static
> > >
> > >
> > > and because we go through all BTF data until we resolve all we have,
> > > the doubled funcs will screw our internal counter and we skip a function
> > >
> > > the change below will workaround that, but I think we should fail in
> > > this case.. if I'm not missing something 2 FUNC records for one function
> > > in BTF data
> > >
> > > $ pahole --version
> > > v1.17
> > >
> > > HEAD is 2bab48c5b Merge branch 'improve-bpf-tcp-cc-init'
> > >
> > > thoughts? thanks
> > 
> > Can't repro this locally. It must be some bad compiler +  DWARF +
> > pahole interaction. Can you try building pahole from latest sources
> > and try again? Also, what compiler did you use? What Kconfig?
> 
> sorry I cut the original message, there's following container that
> reproduces the issue:
> 
> 	The failure is easily reproduced with our container image that already
> 	has all the needed dependencies installed:
> 	registry.gitlab.com/cki-project/containers/builder-rawhide:latest
> 
> 	Steps to reproduce after starting the image:
> 
> 	git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git --depth 1
> 	curl https://gitlab.com/-/snippets/2014934/raw -o bpf-next/.config
> 	cd bpf-next/
> 	make -j 10 INSTALL_MOD_STRIP=1 targz-pkg
> 
> 
> [root@30a9be783e4e /]# gcc --version
> gcc (GCC) 10.2.1 20200826 (Red Hat 10.2.1-3)
> 
> I built the latest pahole in that container and still see the issue,
> I also tried with v1.16 version and it's still there
> 
> I don't see the issue when I build kernel with another .config
> so I'll try to check on that now

readelf --debug has 2 records for vfs_getattr
fs/stat.c and include/linux/fs.h

fs/stat.c:
	 <1><11f9847>: Abbrev Number: 119 (DW_TAG_subprogram)
	    <11f9848>   DW_AT_external    : 1
	    <11f9848>   DW_AT_name        : (indirect string, offset: 0x9eaeb): vfs_getattr
	    <11f984c>   DW_AT_decl_file   : 1
	    <11f984d>   DW_AT_decl_line   : 116
	    <11f984e>   DW_AT_decl_column : 5
	    <11f984f>   DW_AT_prototyped  : 1
	    <11f984f>   DW_AT_type        : <0x11ebe32>
	    <11f9853>   DW_AT_inline      : 1   (inlined)
	    <11f9854>   DW_AT_sibling     : <0x11f9895>
	 <2><11f9858>: Abbrev Number: 35 (DW_TAG_formal_parameter)
	    <11f9859>   DW_AT_name        : (indirect string, offset: 0x70041): path
	    <11f985d>   DW_AT_decl_file   : 1
	    <11f985e>   DW_AT_decl_line   : 116
	    <11f985f>   DW_AT_decl_column : 36
	    <11f9860>   DW_AT_type        : <0x11f17ed>
	 <2><11f9864>: Abbrev Number: 35 (DW_TAG_formal_parameter)
	    <11f9865>   DW_AT_name        : (indirect string, offset: 0x5fa1): stat
	    <11f9869>   DW_AT_decl_file   : 1
	    <11f986a>   DW_AT_decl_line   : 116
	    <11f986b>   DW_AT_decl_column : 56
	    <11f986c>   DW_AT_type        : <0x11f41e0>
	 <2><11f9870>: Abbrev Number: 35 (DW_TAG_formal_parameter)
	    <11f9871>   DW_AT_name        : (indirect string, offset: 0x8e714): request_mask
	    <11f9875>   DW_AT_decl_file   : 1
	    <11f9876>   DW_AT_decl_line   : 117
	    <11f9877>   DW_AT_decl_column : 7
	    <11f9878>   DW_AT_type        : <0x11ebe93>
	 <2><11f987c>: Abbrev Number: 35 (DW_TAG_formal_parameter)
	    <11f987d>   DW_AT_name        : (indirect string, offset: 0xd789): query_flags
	    <11f9881>   DW_AT_decl_file   : 1
	    <11f9882>   DW_AT_decl_line   : 117
	    <11f9883>   DW_AT_decl_column : 34
	    <11f9884>   DW_AT_type        : <0x11ebde1>

include/linux/fs.h:
	 <1><140d794>: Abbrev Number: 43 (DW_TAG_subprogram)
	    <140d795>   DW_AT_external    : 1
	    <140d795>   DW_AT_name        : (indirect string, offset: 0x9eaeb): vfs_getattr
	    <140d799>   DW_AT_decl_file   : 7
	    <140d79a>   DW_AT_decl_line   : 3148
	    <140d79c>   DW_AT_decl_column : 12
	    <140d79d>   DW_AT_prototyped  : 1
	    <140d79d>   DW_AT_type        : <0x140611a>
	    <140d7a1>   DW_AT_sibling     : <0x140d7ba>
	 <2><140d7a5>: Abbrev Number: 3 (DW_TAG_formal_parameter)
	    <140d7a6>   DW_AT_type        : <0x14087aa>
	 <2><140d7aa>: Abbrev Number: 3 (DW_TAG_formal_parameter)
	    <140d7ab>   DW_AT_type        : <0x140cfb6>
	 <2><140d7af>: Abbrev Number: 3 (DW_TAG_formal_parameter)
	    <140d7b0>   DW_AT_type        : <0x1406176>
	 <2><140d7b4>: Abbrev Number: 3 (DW_TAG_formal_parameter)
	    <140d7b5>   DW_AT_type        : <0x14060c9>
	 <2><140d7b9>: Abbrev Number: 0

the latter is just declaration.. but it's missing the
    <365d69d>   DW_AT_declaration : 1

so it goes through pahole's function processing:

	cu__encode_btf:
	...
        cu__for_each_function(cu, core_id, fn) {
                int btf_fnproto_id, btf_fn_id;

                if (fn->declaration || !fn->external)
                        continue;
	...


CC-ing Frank.. any idea why is the DW_AT_declaration : 1 missing?

thanks,
jirka

