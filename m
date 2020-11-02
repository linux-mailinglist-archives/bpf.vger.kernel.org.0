Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78D2A36D3
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgKBW5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 17:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgKBW5M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Nov 2020 17:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604357831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAfRhWimI1jHGTVmCKQhK61uXzAn1vDaUQsK5qSZb3s=;
        b=XliRkOaeBBHVBIgnnqPeKgtHMp16q736G5RNsa89ogEIhZBLfqc9/YQvJss3GJFUpySy3+
        QJpKdvlR7MjPJa+WHrceGAWbM46ZMpiaQ+awsVijJw9z+UhNypvInB23RKPEMVWpNsZ7DU
        H7t+H6YZXDRlAjdo0wWxQliryPRyT90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-2KIihxFDPW636vKdPMkKRg-1; Mon, 02 Nov 2020 17:57:08 -0500
X-MC-Unique: 2KIihxFDPW636vKdPMkKRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6454801F9A;
        Mon,  2 Nov 2020 22:57:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7160960CCC;
        Mon,  2 Nov 2020 22:56:59 +0000 (UTC)
Date:   Mon, 2 Nov 2020 23:56:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201102225658.GD3597846@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102215908.GC3597846@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 02, 2020 at 10:59:08PM +0100, Jiri Olsa wrote:
> On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
> > We need to generate just single BTF instance for the
> > function, while DWARF data contains multiple instances
> > of DW_TAG_subprogram tag.
> > 
> > Unfortunately we can no longer rely on DW_AT_declaration
> > tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> > 
> > Instead we apply following checks:
> >   - argument names are defined for the function
> >   - there's symbol and address defined for the function
> >   - function is generated only once
> > 
> > Also because we want to follow kernel's ftrace traceable
> > functions, this patchset is adding extra check that the
> > function is one of the ftrace's functions.
> > 
> > All ftrace functions addresses are stored in vmlinux
> > binary within symbols:
> >   __start_mcount_loc
> >   __stop_mcount_loc
> 
> hum, for some reason this does not pass through bpf internal
> functions like bpf_iter_bpf_map.. I learned it hard way ;-)
> will check

so it gets filtered out because it's __init function
I'll check if the fix below catches all internal functions,
but I guess we should do something more robust

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index 0a378aa92142..3cd94280c35b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -143,7 +143,8 @@ static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
 		/* Do not enable .init section functions. */
 		if (init_filter &&
 		    func->addr >= ms->init_begin &&
-		    func->addr <  ms->init_end)
+		    func->addr <  ms->init_end &&
+		    strncmp("bpf_", func->name, 4))
 			continue;
 
 		/* Make sure function is within mcount addresses. */

