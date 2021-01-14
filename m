Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6633D2F6DA4
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhANWEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 17:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbhANWEM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 17:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610661766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMwPX+DDLgd8G3X//6EUSPXEB+1/G7CVebPJVxT8KLc=;
        b=Lgfirvh/321uz2eYcai6sdGk05qqsevzZrPOUOR7c57WkShxDYfMFhwHDylz3JbwQEZ8jZ
        Q554iBuAHbhnCWBL1tK+3JVtSvTHw/Bp9rp1qZm2CwmlJW6RdeABsMJOWboOBtdiNUZjKC
        w0KYAp1lEpqePBtc1si6DVHuupY7tKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-JNKb26mrOfWSg4KP1xCjRw-1; Thu, 14 Jan 2021 17:02:42 -0500
X-MC-Unique: JNKb26mrOfWSg4KP1xCjRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFA18066E0;
        Thu, 14 Jan 2021 22:02:39 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C39E5D739;
        Thu, 14 Jan 2021 22:02:35 +0000 (UTC)
Date:   Thu, 14 Jan 2021 23:02:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
Message-ID: <20210114220234.GA1456269@krava>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
 <20210114200120.GF1416940@krava>
 <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 01:05:33PM -0800, Yonghong Song wrote:
> 
> 
> On 1/14/21 12:01 PM, Jiri Olsa wrote:
> > On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 1/14/21 5:40 AM, Jiri Olsa wrote:
> > > > It's possible to have other build id types (other than default SHA1).
> > > > Currently there's also ld support for MD5 build id.
> > > 
> > > Currently, bpf build_id based stackmap does not returns the size of
> > > the build_id. Did you see an issue here? I guess user space can check
> > > the length of non-zero bits of the build id to decide what kind of
> > > type it is, right?
> > 
> > you can have zero bytes in the build id hash, so you need to get the size
> > 
> > I never saw MD5 being used in practise just SHA1, but we added the
> > size to be complete and make sure we'll fit with build id, because
> > there's only limited space in mmap2 event
> 
> I am asking to check whether we should extend uapi struct
> bpf_stack_build_id to include build_id_size as well. I guess
> we can delay this until a real use case.

right, we can try make some MD5 build id binaries and check if it
explodes with some bcc tools, but I don't expect that.. I'll try
to find some time for that

perf tool uses build ids in .debug cache as file links, and we had
few isues there

jirka

