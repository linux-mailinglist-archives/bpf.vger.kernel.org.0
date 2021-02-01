Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72330AA49
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 15:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBAOxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 09:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhBAOwU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Feb 2021 09:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612191030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoKYJW6+yEyK1BBgOtaAwPcaGYoV02+DXvf9bVAZVPo=;
        b=Bamg26D4t8VUbL1td3mUd5MbUs4AbbvrLcysaoVqPFBJJ0U7WKvUFsGMEuiVxmTIXeztWn
        UhFTl57wA44jiNGmKcTkR4q6yU3Vgl+i7yWxEf+Oi656qUQByyNo7z56tfzgI0LBoVZboT
        ROzXtVZdtWJdsDqiYubpLGRjWftObiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-0wmkledzNFqnexgGamviXA-1; Mon, 01 Feb 2021 09:50:26 -0500
X-MC-Unique: 0wmkledzNFqnexgGamviXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20552801ADA;
        Mon,  1 Feb 2021 14:50:25 +0000 (UTC)
Received: from krava (unknown [10.40.195.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F9B719CB6;
        Mon,  1 Feb 2021 14:50:23 +0000 (UTC)
Date:   Mon, 1 Feb 2021 15:50:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Moore <paul@paul-moore.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
Message-ID: <YBgVLqNxL++zVkdK@krava>
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava>
 <YBci6Y8bNZd6KRdw@krava>
 <20210201122532.GE794568@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201122532.GE794568@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 01, 2021 at 09:25:32AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2021 at 10:36:41PM +0100, Jiri Olsa escreveu:
> > On Sat, Jan 30, 2021 at 09:48:13PM +0100, Jiri Olsa wrote:
> > 
> > SNIP
> > 
> > > > > > > % uname -r
> > > > > > > 5.11.0-0.rc5.134.fc34.x86_64
> > > > > > > % pwd
> > > > > > > /.../linux/tools/testing/selftests/bpf
> > > > > > > % git log --oneline | head -n 1
> > > > > > > 6ee1d745b7c9 Linux 5.11-rc5
> > > > > > > % make test_verifier_log
> > > > > > >   ...
> > > > > > >   BINARY   test_verifier_log
> > > > > > > % ./test_verifier_log
> > > > > > > Test log_level 0...
> > > > > > > Test log_size < 128...
> > > > > > > Test log_buff = NULL...
> > > > > > > Test oversized buffer...
> > > > > > > ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13
> > > > > >
> > > > > > Thanks for reporting.
> > > > > > bpf and bpf-next don't have this issue. Not sure what changed.
> > > > >
> > > > > I haven't had a chance to look into this any further, but Ondrej
> > > > > Mosnacek (CC'd) found the following today:
> > > > >
> > > > > "So I was trying to debug this further and I think I've identified what
> > > > > triggers the problem. It seems that the BTF debuginfo generation
> > > > > became broken with CONFIG_DEBUG_INFO_DWARF4=n somewhere between -rc4
> > > > > and -rc5. It also seems to depend on a recent (Fedora Rawhide) version
> > > > > of some component of the build system (GCC, probably), because the
> > > > > problem disappeared when I tried to build the "bad" kernel in F33
> > > > > buildroot instead of Rawhide."
> > > > 
> > > > I see. There were fixes for dwarf and btf, but I lost the track.
> > > > I believe it was a combination of gcc bug that was worked around in pahole.
> > > > Arnaldo, Jiri, Andrii,
> > > > what is the status? Did all fixes land in pahole?
> > > 
> > > I checked on rawhide and besides many pahole warnings,
> > > the resulted BTF data have many duplications in core structs
> > > 
> > > 	  BTFIDS  vmlinux
> > > 	WARN: multiple IDs found for 'task_struct': 132, 1247 - using 132
> > > 	WARN: multiple IDs found for 'file': 440, 1349 - using 440
> > > 	WARN: multiple IDs found for 'inode': 698, 1645 - using 698
> > > 	WARN: multiple IDs found for 'path': 729, 1672 - using 729
> > > 	WARN: multiple IDs found for 'task_struct': 132, 2984 - using 132
> > > 	WARN: multiple IDs found for 'task_struct': 132, 3043 - using 132
> > > 	WARN: multiple IDs found for 'file': 440, 3085 - using 440
> > > 	WARN: multiple IDs found for 'seq_file': 1469, 3125 - using 1469
> > > 	WARN: multiple IDs found for 'inode': 698, 3336 - using 698
> > > 	WARN: multiple IDs found for 'path': 729, 3366 - using 729
> > > 	WARN: multiple IDs found for 'task_struct': 132, 5337 - using 132
> > > 	WARN: multiple IDs found for 'inode': 698, 5360 - using 698
> > > 	WARN: multiple IDs found for 'path': 729, 5388 - using 729
> > > 	WARN: multiple IDs found for 'file': 440, 5412 - using 440
> > > 	WARN: multiple IDs found for 'seq_file': 1469, 5639 - using 1469
> > > 	WARN: multiple IDs found for 'task_struct': 132, 6243 - using 132
> > > 	...
> > > 
> > > 	# gcc --version
> > > 	gcc (GCC) 11.0.0 20210123 (Red Hat 11.0.0-0)
> > > 
> > > I'm guessing there are some DWARF changes that screwed BTF
> > > generation.. I'll check
> > > 
> > > it's not covered by the fix I posted recently, but I think
> > > Arnaldo is now fixing some related stuff.. Arnaldo, maybe
> > > you are seeing same errors?
> > 
> > with Arnaldo's fixes I see less struct duplications,
> > but still there's some
> > 
> > > 
> > > I uploaded the build log from linking part to:
> > >   http://people.redhat.com/~jolsa/build.out.gz
> > 
> > however looks like we don't handle DW_FORM_implicit_const
> > when counting the byte offset.. it was used for some struct
> > members in my vmlinux, so we got zero for byte offset and
> > that created another unique struct
> > 
> > with patch below I no longer see any struct duplication,
> > also test_verifier_log is working for me, but I could
> > not reproduce the error before
> > 
> > I'll post full dwarves patch after some more testing
> > 
> > also I wonder we could somehow use btf_check_all_metas
> > from kernel after we build BTF data, that'd help to catch
> > this earlier/easier ;-) I'll check on this
> 
> Seems like a good idea indeed :-)
> 
> I'm applying the patch below with your Signed-off-by, etc, ok?

ok, thanks

jirka

