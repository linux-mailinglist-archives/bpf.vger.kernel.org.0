Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BA2AFA06
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKKUtn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgKKUtm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 15:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605127781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5gSkztK637nAyE3GfLnnkOXBFv/j+u6ph2hmYGdOqc=;
        b=G12+NWQuzDCvsPA5sLp7M+O+NmyLSskWS9Iyj2gpC0i1+u4wRI9txFSLenxy7dOBRWHGF1
        MBxyyexWvc8e1Nd94FQvQfE1vQcyROlRxllh4z/k71T5A2wc2owNgL8ZBvzOduvqV9u31t
        G0zhUBfRkGcL1Ii6kXkr8ZSY8hA7mHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ceEPUErXOL2CpoF_VK0aWA-1; Wed, 11 Nov 2020 15:49:38 -0500
X-MC-Unique: ceEPUErXOL2CpoF_VK0aWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2DB0D3E80;
        Wed, 11 Nov 2020 20:49:36 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3638210013D0;
        Wed, 11 Nov 2020 20:49:31 +0000 (UTC)
Date:   Wed, 11 Nov 2020 21:49:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201111204930.GD619201@krava>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
 <20201111201929.GB619201@krava>
 <CAEf4BzZe1owmhqjGCjShYwf892hA0tzp0BEAZ2TR41aFx4eKUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZe1owmhqjGCjShYwf892hA0tzp0BEAZ2TR41aFx4eKUw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 12:26:23PM -0800, Andrii Nakryiko wrote:

SNIP

> > perhaps your gcc generates DWARF that breaks the way you described
> > above, but I'd expect to see function with argument without name,
> > not function without arguments at all
> >
> > what gcc version are you on?
> 
> 10.2.0, built from sources
> 
> >
> > when you dump debug information, do you see security_inode_getattr
> > record with no arguments?
> 
> Yeah, I think so:
> 
> 21158467- <1><2b7e168>: Abbrev Number: 93 (DW_TAG_subprogram)
> 21158468-    <2b7e169>   DW_AT_external    : 1
> 21158469-    <2b7e169>   DW_AT_declaration : 1
> 
>   ..  BTW, we should probably still ignore DW_AT_declaration: 1, if it's set.
> 
> 21158470:    <2b7e169>   DW_AT_linkage_name: (indirect string, offset:
> 0x120a0a): security_inode_getattr
> 21158471:    <2b7e16d>   DW_AT_name        : (indirect string, offset:
> 0x120a0a): security_inode_getattr
> 21158472-    <2b7e171>   DW_AT_decl_file   : 141
> 21158473-    <2b7e172>   DW_AT_decl_line   : 346
> 21158474-    <2b7e174>   DW_AT_decl_column : 5

nice.. so how about making extra loop through cu functions
and collect all distinct functions and for each collect
most detailed arguments and use this set for final func
generation

will try to think of some way without extra loop, but can't
think of any now

jirka

