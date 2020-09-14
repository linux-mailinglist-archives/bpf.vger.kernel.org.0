Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF212694C3
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINSZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 14:25:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgINSZT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Sep 2020 14:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600107918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eu76mxcdPgWTFbGMoALVoUP1PuSwsvQfq2LhcgVkz24=;
        b=MvV/1HvmHJG9IstKJ5nSu8P+zwrsno3FxtvLH1ZIfk24Jeh5fwC9Wfzt6ImJxNLGeiN04G
        5aBza4pf47O4HuLpRCRIaV4BIbCbuxCyK3TO6JsqHkHk2Iz9wbfvG3xCWjg0qRC0rxwmAu
        GsZXjuALDncfeX7SZMpyVL6lWexDRIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-K6EYyWUiOgOihwS9tZ2vUQ-1; Mon, 14 Sep 2020 14:25:16 -0400
X-MC-Unique: K6EYyWUiOgOihwS9tZ2vUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EE3F873115;
        Mon, 14 Sep 2020 18:25:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14AB37B7AC;
        Mon, 14 Sep 2020 18:25:13 +0000 (UTC)
Date:   Mon, 14 Sep 2020 20:25:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20200914182513.GK1714160@krava>
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 10:48:36AM -0400, Veronika Kabatova wrote:
> 
> Hello,
> 
> we tested the bpf-next tree with CKI and ran across build failures. The
> important part of the build log is:
> 
> 00:18:05   GEN     .version
> 00:18:05   CHK     include/generated/compile.h
> 00:18:05   LD      vmlinux.o
> 00:18:27   MODPOST vmlinux.symvers
> 00:18:27   MODINFO modules.builtin.modinfo
> 00:18:27   GEN     modules.builtin
> 00:18:27   LD      .tmp_vmlinux.btf
> 00:18:42   BTF     .btf.vmlinux.bin.o
> 00:19:13   LD      .tmp_vmlinux.kallsyms1
> 00:19:19   KSYM    .tmp_vmlinux.kallsyms1.o
> 00:19:22   LD      .tmp_vmlinux.kallsyms2
> 00:19:25   KSYM    .tmp_vmlinux.kallsyms2.o
> 00:19:28   LD      vmlinux
> 00:19:40   BTFIDS  vmlinux
> 00:19:40 FAILED unresolved symbol vfs_getattr
> 00:19:40 make[2]: *** [Makefile:1167: vmlinux] Error 255
> 00:19:40 make[1]: *** [scripts/Makefile.package:109: targz-pkg] Error 2
> 00:19:40 make: *** [Makefile:1528: targz-pkg] Error 2

hi,
it looks like broken BTF data to me, I checked that build
and found we have multiple records for functions, like
for filp_close:

	[23381] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
		'(anon)' type_id=464
		'id' type_id=960
	[23382] FUNC 'filp_close' type_id=23381 linkage=static


	[33073] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
		'filp' type_id=464
		'id' type_id=960
	[33074] FUNC 'filp_close' type_id=33073 linkage=static


or vfs_getattr:

	[33513] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
		'path' type_id=741
		'stat' type_id=1095
		'request_mask' type_id=29
		'query_flags' type_id=8

	[33514] FUNC 'vfs_getattr' type_id=33513 linkage=static

	[1094] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
		'(anon)' type_id=741
		'(anon)' type_id=1095
		'(anon)' type_id=29
		'(anon)' type_id=8

	[35099] FUNC 'vfs_getattr' type_id=1094 linkage=static


and because we go through all BTF data until we resolve all we have,
the doubled funcs will screw our internal counter and we skip a function

the change below will workaround that, but I think we should fail in
this case.. if I'm not missing something 2 FUNC records for one function
in BTF data

$ pahole --version
v1.17

HEAD is 2bab48c5b Merge branch 'improve-bpf-tcp-cc-init'

thoughts? thanks
jirka


---
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index dfa540d8a02d..a33e56553e52 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -525,7 +525,7 @@ static int symbols_resolve(struct object *obj)
 		}
 
 		id = btf_id__find(root, str);
-		if (id) {
+		if (id && !id->id) {
 			id->id = type_id;
 			(*nr)--;
 		}

