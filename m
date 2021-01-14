Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575762F6BBC
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 21:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhANUC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 15:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbhANUC7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 15:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610654492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6WLCSpTqHMk8dWcHZMUQNdGxWchRF8lVKGN2TPwAULk=;
        b=desctzjLFrmlDiYwBsjm472GbXpBL1+ETMxTNAGokVwlcdmK1yVg1b4FFCdBkZKhQ809aP
        JZ9i8WDCTjvAUnAzTOfoihX0u/LkqflTOlTfPacLDV9kCgyzkbyLWQltwzcm9NB/pUkSYs
        WGb7zCa4DMUHiKaaA1FvwzFF3rL6amo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-q3B-lAhSNWyEFOQOQ-JuSA-1; Thu, 14 Jan 2021 15:01:28 -0500
X-MC-Unique: q3B-lAhSNWyEFOQOQ-JuSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D80AF107ACF7;
        Thu, 14 Jan 2021 20:01:25 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 950BD5D9EF;
        Thu, 14 Jan 2021 20:01:21 +0000 (UTC)
Date:   Thu, 14 Jan 2021 21:01:20 +0100
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
Message-ID: <20210114200120.GF1416940@krava>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
> 
> 
> On 1/14/21 5:40 AM, Jiri Olsa wrote:
> > It's possible to have other build id types (other than default SHA1).
> > Currently there's also ld support for MD5 build id.
> 
> Currently, bpf build_id based stackmap does not returns the size of
> the build_id. Did you see an issue here? I guess user space can check
> the length of non-zero bits of the build id to decide what kind of
> type it is, right?

you can have zero bytes in the build id hash, so you need to get the size

I never saw MD5 being used in practise just SHA1, but we added the
size to be complete and make sure we'll fit with build id, because
there's only limited space in mmap2 event

jirka

> 
> > 
> > Adding size argument to build_id_parse function, that returns (if defined)
> > size of the parsed build id, so we can recognize the build id type.
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   include/linux/buildid.h |  3 ++-
> >   kernel/bpf/stackmap.c   |  2 +-
> >   lib/buildid.c           | 29 +++++++++++++++++++++--------
> >   3 files changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index 08028a212589..40232f90db6e 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -6,6 +6,7 @@
> >   #define BUILD_ID_SIZE_MAX 20
> > -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> > +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> > +		   __u32 *size);
> >   #endif
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 55d254a59f07..cabaf7db8efc 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -189,7 +189,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> >   	for (i = 0; i < trace_nr; i++) {
> >   		vma = find_vma(current->mm, ips[i]);
> > -		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
> > +		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> >   			/* per entry fall back to ips */
> >   			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> >   			id_offs[i].ip = ips[i];
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 4a4f520c0e29..6156997c3895 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -12,6 +12,7 @@
> >    */
> >   static inline int parse_build_id(void *page_addr,
> >   				 unsigned char *build_id,
> > +				 __u32 *size,
> >   				 void *note_start,
> >   				 Elf32_Word note_size)
> >   {
> > @@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
> >   			       nhdr->n_descsz);
> >   			memset(build_id + nhdr->n_descsz, 0,
> >   			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > +			if (size)
> > +				*size = nhdr->n_descsz;
> >   			return 0;
> >   		}
> >   		new_offs = note_offs + sizeof(Elf32_Nhdr) +
> > @@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
> >   }
> [...]
> 

