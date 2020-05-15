Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C911D4944
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEOJSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 05:18:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728005AbgEOJSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 05:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589534302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwuYVHRaixWyYSkHzvaK/+VuTDQ9PiI/7066NTYvPoM=;
        b=IyxcGUsepuk6fsdxfss7wJFwHL2tLElrLH0Jz3LBzaTGeyZzWTdafrTyumDNYWEPWfmm7z
        i5dXnAvQRlFKLqrwyjwNceED3zt8FXQgZzaIa47HltMGfQMH+OYwogenkeWYxZRrKTNJVG
        HUNEcRKGTjB7O9LpVh0XDgLe+WmNh5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-gA-uHkRkMT-AwjrK7pjdzQ-1; Fri, 15 May 2020 05:18:19 -0400
X-MC-Unique: gA-uHkRkMT-AwjrK7pjdzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 589B31005510;
        Fri, 15 May 2020 09:18:18 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E2C1001B2C;
        Fri, 15 May 2020 09:18:16 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Jiri Benc <jbenc@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC] selftests: do not use .ONESHELL
References: <20200515030051.60148-1-yauheni.kaliuta@redhat.com>
        <20200515102841.3fa15ff7@redhat.com>
Date:   Fri, 15 May 2020 12:18:14 +0300
In-Reply-To: <20200515102841.3fa15ff7@redhat.com> (Jiri Benc's message of
        "Fri, 15 May 2020 10:28:41 +0200")
Message-ID: <xuny4kshpne1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Jiri!

>>>>> On Fri, 15 May 2020 10:28:41 +0200, Jiri Benc  wrote:

 > On Fri, 15 May 2020 06:00:51 +0300, Yauheni Kaliuta wrote:
 >> 1) I'm wondering how commit c363eb48ada5 ("selftests: fix too long
 >> argument") worked without the patch.

 > I think it was because it reduced the list of files from three
 > replications to two. I did not notice the .ONESHELL; it also
 > explains the oddity that I saw with @ behavior.

 > With the .ONESHELL removed, we can further simplify
 > INSTALL_SINGLE_RULE by removing the @echo rsync and the
 > at-sign before rsync.

Yeah.

 >> 2) The code does not look working as expected for me:
 >> 2.1) "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" is
 >> always true sine the left part will be at least "X  " (spaces);
 >> 2.2) according to manual in .ONESHELL case gmake checks only first
 >> line for @, so @rsync is passed to the shell;

Actully, when I checked it in the `if` branch, @ worked as
expected, sounds strange for me. But well, without .ONESHELL it
will go away.

 >> 2.3) $(OUTPUT)/(TEST_PROGS) adds $(OUTPUT) only to the first prog;
 >> 
 >> Did I miss something?

 > I think you didn't miss anything and that you're right. Could
 > you submit a patch to remove the spaces? I can then submit a
 > patch to further simplify INSTALL_SINGLE_RULE if you don't
 > want to do that, too.

Just allow rsync command echoing, right? I can do it, no problem.

And RUN_TESTS' `@` does not work in the `if` branch, so the patch
should be fixed.

Also I noticed possible issue related to my previous patch:

lib.mk does TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
(Notice := ). But it's included (at least in the bpf/Makefile)
before TEST_GEN_FILES is constructed during rules generation so
basically it's skipped. BUT in the generated rules $(OUTPUT) is
taken into account. Sort of inconsistency. Did I miss something?

If any of the lists grows too much again the next modification in
my mind is to do $(foreach ...) on the lists and handle them
file-by-file.

Thanks for the review!

-- 
WBR,
Yauheni Kaliuta

