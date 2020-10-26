Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B272298A25
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 11:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769408AbgJZKO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 06:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730548AbgJZKO5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 06:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603707295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TUpiVrlACt9WCZo0YB4uPaj15COzxy5ObGXAKWGRFY=;
        b=T2WeJnWS3l3D+/VMMS+ZZV/HBwXulCiDdr7YYxz8a14vdNW16TblyWuQGv0kHEJanoNwPW
        BD028yRp7o8PxoMi9pmAHV+xsHRMGFz/8MfGtZU8CGZMXesQlFAOsKEPv4ssgSK7tT2bAk
        z8rCYIpcpmH7dkuMgOLSP4YTQuR5Dgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-sTJ4DGkzOKOuE58J4GI7Uw-1; Mon, 26 Oct 2020 06:14:51 -0400
X-MC-Unique: sTJ4DGkzOKOuE58J4GI7Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABDA685B683;
        Mon, 26 Oct 2020 10:14:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9C3160C13;
        Mon, 26 Oct 2020 10:14:42 +0000 (UTC)
Date:   Mon, 26 Oct 2020 11:14:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201026101441.GA2726983@krava>
References: <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava>
 <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 11:22:05AM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 22, 2020 at 11:58 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 07:36:57AM +0200, Jiri Olsa wrote:
> > > On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > >
> > > > > hi,
> > > > > FYI there's still no solution yet, so far the progress is:
> > > > >
> > > > > the proposed workaround was to use the negation -> we don't have
> > > > > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > > > > tags have attached code and skip them if they don't have any:
> > > > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> > > > >
> > > > > the attached patch is doing that, but the resulting BTF is missing
> > > > > several functions due to another bug in dwarf:
> > > > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> > > >
> > > > It seems fine if there are only few functions (especially if those are
> > > > unlikely to be traced). Do you have an estimate of how many functions
> > > > have this second DWARF bug?
> > >
> > > it wasn't that many, I'll recheck
> >
> > 127 functions missing if the workaround is applied, list attached
> >
> 
> some of those seem pretty useful... I guess the quick workaround in
> pahole would be to just remember function names that were emitted
> already. The problem with that is that we can pick a version without
> parameter names, which is not the end of the world, but certainly
> annoying.

with the change below I seem to get all argument names

the change assumes that we can skip dwarf functions with
no argument names, because if the function is defined in
the object, it needs to have argument names

so there will be eventualy dwarf definition of that function
with full argument names

I wonder we could use this code as a check that the function
is present in the object ;-) but I think we need to keep
the symbols check as well

I'll send that out together with the rest of the changes

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index 7e370eb48174..0c14ac210425 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -397,6 +397,19 @@ static int config(struct btf_elf *btfe, bool do_percpu_vars)
 	return 0;
 }
 
+static bool has_arg_names(struct cu *cu, struct ftype *ftype)
+{
+	struct parameter *param;
+	const char *name;
+
+	ftype__for_each_parameter(ftype, param) {
+		name = dwarves__active_loader->strings__ptr(cu, param->name);
+		if (name == NULL)
+			return false;
+	}
+	return true;
+}
+
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		   bool skip_encoding_vars)
 {
@@ -472,6 +485,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
+		if (!has_arg_names(cu, &fn->proto))
+			continue;
+
 		if (!generate_func(btfe, function__name(fn, cu)))
 			continue;
 

