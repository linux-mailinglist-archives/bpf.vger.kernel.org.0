Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BE1D481D
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEOI3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 04:29:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgEOI3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 04:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589531349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=320TULVpXy4LDI+cfJjU9DKbHZcEcjNlm91yWc7effw=;
        b=DF78CKcQtuoSrEkDg0yrWfOLyOkLUJ2FN4sL2LfgK12HvAVscbEHNdbcnh63Vt/c49hwXy
        sYFdCNH/2Kgqsr4GGgfbQW2F6FlDdaPiyjuRYTe3RMavd+l00ul36GlfTv0safMMbWMCG2
        LTyCRKM++jzHpQwmW61K25vWcBvxKpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-qeDgXTogPnOX2Hk9JqzUUw-1; Fri, 15 May 2020 04:29:05 -0400
X-MC-Unique: qeDgXTogPnOX2Hk9JqzUUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1772018A983B;
        Fri, 15 May 2020 08:28:45 +0000 (UTC)
Received: from localhost (unknown [10.40.194.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E706D83857;
        Fri, 15 May 2020 08:28:43 +0000 (UTC)
Date:   Fri, 15 May 2020 10:28:41 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC] selftests: do not use .ONESHELL
Message-ID: <20200515102841.3fa15ff7@redhat.com>
In-Reply-To: <20200515030051.60148-1-yauheni.kaliuta@redhat.com>
References: <20200515030051.60148-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 May 2020 06:00:51 +0300, Yauheni Kaliuta wrote:
> 1) I'm wondering how commit c363eb48ada5 ("selftests: fix too long
> argument") worked without the patch.

I think it was because it reduced the list of files from three
replications to two. I did not notice the .ONESHELL; it also explains
the oddity that I saw with @ behavior.

With the .ONESHELL removed, we can further simplify INSTALL_SINGLE_RULE
by removing the @echo rsync and the at-sign before rsync.

> 2) The code does not look working as expected for me:
> 2.1) "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" is
> always true sine the left part will be at least "X  " (spaces);
> 2.2) according to manual in .ONESHELL case gmake checks only first
> line for @, so @rsync is passed to the shell;
> 2.3) $(OUTPUT)/(TEST_PROGS) adds $(OUTPUT) only to the first prog;
> 
> Did I miss something?

I think you didn't miss anything and that you're right. Could you
submit a patch to remove the spaces? I can then submit a patch to
further simplify INSTALL_SINGLE_RULE if you don't want to do that, too.

Thanks!

 Jiri

