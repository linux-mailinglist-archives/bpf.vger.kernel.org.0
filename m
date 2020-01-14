Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB213AAB1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 14:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgANNWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 08:22:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44852 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgANNWS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 08:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579008138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMr4t19r9FDBxMiNqZ17ABTwdjTXfkzRestAINYUs2o=;
        b=e1VlJtm4ceba32t3NE4bQ53Iuc0QPnDvph+S8g/2acLX7jwsQihK9pUwDvc0KTArA+XWHk
        pjUNf0Jru3ztc0eJ8vtD1EiBKdN5nhY83LN4c6dkLX+uURXfDWd93lLd1qNCeOLto3G5Tf
        PhzxtN/L6fXT78uC+7RutJXrJTa/vyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-hY50GWhqMJyc0ARApPk7RQ-1; Tue, 14 Jan 2020 08:22:14 -0500
X-MC-Unique: hY50GWhqMJyc0ARApPk7RQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D0F8DC401;
        Tue, 14 Jan 2020 13:22:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B18E350A8F;
        Tue, 14 Jan 2020 13:22:10 +0000 (UTC)
Date:   Tue, 14 Jan 2020 14:22:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 5/6] tools/bpf: add runqslower tool to
 tools/bpf
Message-ID: <20200114132208.GC170376@krava>
References: <20200113073143.1779940-1-andriin@fb.com>
 <20200113073143.1779940-6-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113073143.1779940-6-andriin@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 12, 2020 at 11:31:42PM -0800, Andrii Nakryiko wrote:

SNIP

> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> new file mode 100644
> index 000000000000..f1363ae8e473
> --- /dev/null
> +++ b/tools/bpf/runqslower/Makefile
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +OUTPUT := .output
> +CLANG := clang
> +LLC := llc
> +LLVM_STRIP := llvm-strip
> +DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
> +BPFTOOL ?= $(DEFAULT_BPFTOOL)
> +LIBBPF_SRC := $(abspath ../../lib/bpf)
> +CFLAGS := -g -Wall
> +
> +# Try to detect best kernel BTF source
> +KERNEL_REL := $(shell uname -r)
> +ifneq ("$(wildcard /sys/kenerl/btf/vmlinux)","")

s/kenerl/kernel/

jirka

