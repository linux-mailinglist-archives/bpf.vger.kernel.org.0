Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C69290D57
	for <lists+bpf@lfdr.de>; Fri, 16 Oct 2020 23:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJPVio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Oct 2020 17:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgJPVio (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Oct 2020 17:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602884322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpWr+C27QX4TWR+UFi06SIzaMkcPpSBOQnCk2e+Xak8=;
        b=dAvoWF6kC2pIipJUPKQLj9BK4FfWYzN+Tb1s6wwRauELXTA2f+f7mkdU1jk+VuoCZ3Dyvo
        9L0suNLbdDsReuQTvE48mMq4qifJKDVT8pbyyww8ZxIVP0MNHItml+Y8oiM61vML5IPzZN
        me7oQ9X38N8mIojhOuA5+7FXb56aeWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-2pH5hrUAMmK5jGbc6BGR5g-1; Fri, 16 Oct 2020 17:38:38 -0400
X-MC-Unique: 2pH5hrUAMmK5jGbc6BGR5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96C141074660;
        Fri, 16 Oct 2020 21:38:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 03ADC5C1D0;
        Fri, 16 Oct 2020 21:38:35 +0000 (UTC)
Date:   Fri, 16 Oct 2020 23:38:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201016213835.GJ1461394@krava>
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava>
 <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916090624.GD2301783@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 16, 2020 at 11:06:27AM +0200, Jiri Olsa wrote:
> On Tue, Sep 15, 2020 at 02:17:46PM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
> > 	 <2><140d7aa>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > 	    <140d7ab>   DW_AT_type        : <0x140cfb6>
> > 	 <2><140d7af>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > 	    <140d7b0>   DW_AT_type        : <0x1406176>
> > 	 <2><140d7b4>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > 	    <140d7b5>   DW_AT_type        : <0x14060c9>
> > 	 <2><140d7b9>: Abbrev Number: 0
> > 
> > the latter is just declaration.. but it's missing the
> >     <365d69d>   DW_AT_declaration : 1
> > 
> > so it goes through pahole's function processing:
> > 
> > 	cu__encode_btf:
> > 	...
> >         cu__for_each_function(cu, core_id, fn) {
> >                 int btf_fnproto_id, btf_fn_id;
> > 
> >                 if (fn->declaration || !fn->external)
> >                         continue;
> > 	...
> > 
> > 
> > CC-ing Frank.. any idea why is the DW_AT_declaration : 1 missing?
> 
> looks like gcc issue:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> 
> let's see ;-)

so this gcc bug did not disappear and the fix might be delayed,
as I was told it's real complex and difficult to fix

and it's no longer just rawhide issue, because I just started to
see it in Fedora 32 after updating to gcc (GCC) 10.2.1 20201005
(Red Hat 10.2.1-5)

I'm checking on pahole's workaround, but so far I can't see dwarf
based solution for that.. any thoughts/ideas? ;-)

thanks,
jirka

