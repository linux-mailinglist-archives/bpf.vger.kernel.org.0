Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E803B2B4F21
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgKPSVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 13:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731856AbgKPSVx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 13:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605550912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfZJEYm3X4zb2Jg3mFqG+K5JtECCUDZ3Cwwk1q3jAmc=;
        b=AEl8z8cqPaQxg8fUeoeQM74wCu2vmRbfXv3PDboCVL3d4NRpdmHSaeWnJGZf/A/J0SGJuN
        nKRRjEsPE5REoMhrZmV5hkVE06e2UCJ/i/mtl6wGP8TJmRUu9GIr6TXbcYOPq3QZOAi4uC
        ozUN9nvlwJfLiHfwTs7w+4o17mv2FPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-K9JiwShaMiqX2XTu0bnBcA-1; Mon, 16 Nov 2020 13:21:50 -0500
X-MC-Unique: K9JiwShaMiqX2XTu0bnBcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C74B10866A1;
        Mon, 16 Nov 2020 18:21:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id B19305D9CC;
        Mon, 16 Nov 2020 18:21:46 +0000 (UTC)
Date:   Mon, 16 Nov 2020 19:21:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201116182145.GF1081385@krava>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
 <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
 <20201113212907.GD842058@krava>
 <CAEf4BzZY9SF2rVNXpUUN=rYJ_jvBy1eq+fcQi+iRdv8dV2OVFQ@mail.gmail.com>
 <20201116135016.GA509215@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116135016.GA509215@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 10:50:16AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 13, 2020 at 01:43:47PM -0800, Andrii Nakryiko escreveu:
> > On Fri, Nov 13, 2020 at 1:29 PM Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > On Fri, Nov 13, 2020 at 12:56:40PM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > > > > Current conditions for picking up function records break
> > > > > BTF data on some gcc versions.
> 
> > > > > Some function records can appear with no arguments but with
> > > > > declaration tag set, so moving the 'fn->declaration' in front
> > > > > of other checks.
> 
> > > > > Then checking if argument names are present and finally checking
> > > > > ftrace filter if it's present. If ftrace filter is not available,
> > > > > using the external tag to filter out non external functions.
> 
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> > > > I tested locally, all seems to work fine. Left few suggestions below,
> > > > but those could be done in follow ups (or argued to not be done).
> 
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > > > BTW, for some stats.
> 
> > > > BEFORE allowing static funcs:
> 
> 
> Nowhere in the last patchkit comments is some explanation for the
> inclusion of static functions :-\ After the first patch in the last
> series I get:
> 
>   $ llvm-objcopy --remove-section=.BTF vmlinux
>   $ readelf -SW vmlinux  | grep BTF
>   $ pahole -J vmlinux
>   $ bpftool btf dump file ./vmlinux | grep 'FUNC '| cut -d\' -f2 | sort > before.bpftool
>   $ cp vmlinux vmlinux.before.all
>   $ wc -l before.bpftool
>   28829 before.bpftool

I think you see the original number of functions, because without
the 'not merged' kernel patch, that added the special init section,
pahole will fail to detect vmlinux and fall back to checking dwarf
declarations

there's a verbose message for the fall back, but it is not displayed
at the moment ;-) with the fix below you should see it:

  $ LLVM_OBJCOPY=objcopy ./pahole -V -J vmlinux >out
  $ cat out | grep 'vmlinux not detected'
  vmlinux not detected, falling back to dwarf data

I'll check on the verbose setup and send full patch,
I did not expect it would not get printed, sry

so the new numebr ~41k functions is together static functions
and init functions

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index 9b93e9963727..7efd26de5815 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -584,6 +584,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	struct tag *pos;
 	int err = 0;
 
+	btf_elf__verbose = verbose;
+
 	if (btfe && strcmp(btfe->filename, cu->filename)) {
 		err = btf_encoder__encode();
 		if (err)
@@ -623,7 +625,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		}
 	}
 
-	btf_elf__verbose = verbose;
 	btf_elf__force = force;
 	type_id_off = btf__get_nr_types(btfe->btf);
 
diff --git a/lib/bpf b/lib/bpf
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f
+Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f-dirty

