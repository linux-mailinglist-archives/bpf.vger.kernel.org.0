Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4793A20C9E3
	for <lists+bpf@lfdr.de>; Sun, 28 Jun 2020 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgF1TfY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 15:35:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbgF1TfX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Jun 2020 15:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593372922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rGc0nAm1XQYgfgrB8nGrq9OeAZv/fkC07sQUDjEMJk=;
        b=iRGHsPxnBvJCF8pi5n+flr/57Ekpxuyc1WTonoPovLZ4wCtXMhngx/kUnbpP9b95Hr/zVU
        4F2N9uovEDjlukI5l97uWRAi31GSKjwdwlNH94e91ST2Gn/Xb+YxR6WMmIKTXB468a6/+2
        q7XTIx8XrfELr6ATDxK3Rp9+GhF7k9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-ZJXyYfBNMaiNJBV5MrUvvw-1; Sun, 28 Jun 2020 15:35:20 -0400
X-MC-Unique: ZJXyYfBNMaiNJBV5MrUvvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 149C7804001;
        Sun, 28 Jun 2020 19:35:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 70C1810001B9;
        Sun, 28 Jun 2020 19:35:14 +0000 (UTC)
Date:   Sun, 28 Jun 2020 21:35:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 bpf-next 01/14] bpf: Add resolve_btfids tool to
 resolve BTF IDs in ELF object
Message-ID: <20200628193513.GA2988321@krava>
References: <20200625221304.2817194-1-jolsa@kernel.org>
 <20200625221304.2817194-2-jolsa@kernel.org>
 <d521c351-2bcd-2510-7266-0194ade5ca64@fb.com>
 <20200628190927.43vvzapcxpo7wxrq@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628190927.43vvzapcxpo7wxrq@ast-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 28, 2020 at 12:09:27PM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 26, 2020 at 02:09:53PM -0700, Yonghong Song wrote:
> > 
> > After applying the whole patch set to my bpf-next tree locally, I cannot
> > build:
> > 
> > -bash-4.4$ make -j100 && make vmlinux
> >   GEN     Makefile
> >   DESCEND  objtool
> >   DESCEND  bpf/resolve_btfids
> > make[4]: *** No rule to make target
> > `/data/users/yhs/work/net-next/tools/bpf/resolve_btfids/fixdep'.  Stop.
> > make[3]: *** [fixdep] Error 2
> > make[2]: *** [bpf/resolve_btfids] Error 2
> > make[1]: *** [tools/bpf/resolve_btfids] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make[1]: *** wait: No child processes.  Stop.
> > make: *** [__sub-make] Error 2
> > -bash-4.4$
> > 
> > Any clue what is the possible issue here?
> 
> Same here. After applying patch 1 and 2 it doesn't build for me 
> with the same error as above.
> 
> But if I do:
> cd tools/bpf/resolve_btfids; make; cd -; make
> it works.

I already got this error from 0-day bot.. I tested on fresh
Fedora installs on x86/ppx/arm/s390 archs and all's good

what distros are you guys on? I'm installing debian and
perhaps I'll try some other

thanks,
jirka

