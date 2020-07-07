Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA102172CA
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgGGPoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 11:44:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726911AbgGGPoR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Jul 2020 11:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594136656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wbCc8tE8PD7GcmBP8ojS1OSq6nWEEZktf/F0MVDpwU=;
        b=d+0+9nygjW6qTYNbnaBpNWCfJfSs59HXy9dpfqyGjYG5RpGiE+QtPXAqloZ8kFSi/hqf6X
        1+xMgfyF3uJYIkyY9r6LAzdxfisocn6f1B+S+zmVNQEBhCnSuAM1zTVX4dM81ffI3S8VR6
        U+POnNDRCpwy8y9dFMsKcaQX321TgdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-TPzP1GrXOcyhh8CweiGd6w-1; Tue, 07 Jul 2020 11:44:14 -0400
X-MC-Unique: TPzP1GrXOcyhh8CweiGd6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E383091164;
        Tue,  7 Jul 2020 15:44:11 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8987DB3A7E;
        Tue,  7 Jul 2020 15:44:08 +0000 (UTC)
Date:   Tue, 7 Jul 2020 17:44:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 bpf-next 8/9] tools headers: Adopt verbatim copy of
 btf_ids.h from kernel sources
Message-ID: <20200707154407.GH3424581@krava>
References: <20200703095111.3268961-1-jolsa@kernel.org>
 <20200703095111.3268961-9-jolsa@kernel.org>
 <CAEf4Bza9Mcu4d9BCbmPGw8EepRYdM-sTAoctdQX_ZCpdxfyCjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza9Mcu4d9BCbmPGw8EepRYdM-sTAoctdQX_ZCpdxfyCjg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 06, 2020 at 05:56:09PM -0700, Andrii Nakryiko wrote:
> On Fri, Jul 3, 2020 at 2:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > It will be needed by bpf selftest for resolve_btfids tool.
> >
> > Also adding __PASTE macro as btf_ids.h dependency, which is
> > defined in:
> >
> >   include/linux/compiler_types.h
> >
> > but because tools/include do not have this header, I'm putting
> > the macro into linux/compiler.h header.
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/include/linux/btf_ids.h  | 87 ++++++++++++++++++++++++++++++++++
> >  tools/include/linux/compiler.h |  4 ++
> >  2 files changed, 91 insertions(+)
> >  create mode 100644 tools/include/linux/btf_ids.h
> >
> > diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> > new file mode 100644
> > index 000000000000..d317150bc9e3
> > --- /dev/null
> > +++ b/tools/include/linux/btf_ids.h
> > @@ -0,0 +1,87 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_BTF_IDS_H
> > +#define _LINUX_BTF_IDS_H
> > +
> > +#include <linux/compiler.h> /* for __PASTE */
> > +
> > +/*
> > + * Following macros help to define lists of BTF IDs placed
> > + * in .BTF_ids section. They are initially filled with zeros
> 
> One more inconsistency with .BTF_ids vs .BTF.ids (probably same in the
> original header, which I missed).

ok

> 
> > + * (during compilation) and resolved later during the
> > + * linking phase by btfid tool.
> 
> typo: resolve_btfids tool

will fix

thanks,
jirka

> 
> > + *
> > + * Any change in list layout must be reflected in btfid
> > + * tool logic.
> > + */
> > +
> 
> [...]
> 

