Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB91D9141
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 09:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgESHol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 03:44:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbgESHol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 03:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589874279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzJdHMXF+IgXxHmGtDonS1noBe6znWoesHMljViOvf0=;
        b=GzFU8COoVpV77XsfHC2eCEGL050mjp+jUq/OAXVNaLaLM/ZfbYozeChxtA4m4ZLTDAqoTq
        420ZI9krwsHqK4QY3A7k6btJGDYNL4GN5jQz5weB70NdGxqJhzvRZxq3zJaTBCRBlVgQe9
        w1Ty3kxzKolQkjkjGw74DKb13n+nExg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-W7b8aEHaMJ2DvIIxppd1-g-1; Tue, 19 May 2020 03:44:37 -0400
X-MC-Unique: W7b8aEHaMJ2DvIIxppd1-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EBE1800D42;
        Tue, 19 May 2020 07:44:36 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-234.ams2.redhat.com [10.36.114.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2D262BFCC;
        Tue, 19 May 2020 07:44:34 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 1/3] selftests: do not use .ONESHELL
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
        <20200515120026.113278-2-yauheni.kaliuta@redhat.com>
Date:   Tue, 19 May 2020 10:44:32 +0300
In-Reply-To: <20200515120026.113278-2-yauheni.kaliuta@redhat.com> (Yauheni
        Kaliuta's message of "Fri, 15 May 2020 15:00:24 +0300")
Message-ID: <xunyftbwnzbz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Shuah!

Any comment on that? The patch is ACKes by Jiri already.

>>>>> On Fri, 15 May 2020 15:00:24 +0300, Yauheni Kaliuta  wrote:

 > Using one shell for the whole recipe with long lists can cause
 > make[1]: execvp: /bin/sh: Argument list too long

 > with some shells. Triggered by commit 309b81f0fdc4 ("selftests/bpf:
 > Install generated test progs")

 > It requires to change the rule which rely on the one shell
 > behaviour (run_tests).

 > Simplify also INSTALL_SINGLE_RULE, remove extra echo, required to
 > workaround .ONESHELL.

 > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 > Cc: Jiri Benc <jbenc@redhat.com>
 > Cc: Shuah Khan <shuah@kernel.org>
 > ---
 >  tools/testing/selftests/lib.mk | 20 +++++++++-----------
 >  1 file changed, 9 insertions(+), 11 deletions(-)

 > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
 > index b0556c752443..5b82433d88e3 100644
 > --- a/tools/testing/selftests/lib.mk
 > +++ b/tools/testing/selftests/lib.mk
 > @@ -59,9 +59,8 @@ else
 >  all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 >  endif
 
 > -.ONESHELL:
 >  define RUN_TESTS
 > -	@BASE_DIR="$(selfdir)";			\
 > +	BASE_DIR="$(selfdir)";			\
 >  	. $(selfdir)/kselftest/runner.sh;	\
 >  	if [ "X$(summary)" != "X" ]; then       \
 >  		per_test_logging=1;		\
 > @@ -71,22 +70,21 @@ endef
 
 >  run_tests: all
 >  ifdef building_out_of_srctree
 > -	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then
 > -		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
 > +	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then \
 > +		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 >  	fi
 > -	@if [ "X$(TEST_PROGS)" != "X" ]; then
 > -		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
 > -	else
 > -		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
 > +	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 > +		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
 > +	else \
 > +		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 >  	fi
 >  else
 > -	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 > +	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 >  endif
 
 >  define INSTALL_SINGLE_RULE
 >  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
 > -	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 > -	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 > +	$(if $(INSTALL_LIST),rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 >  endef
 
 >  define INSTALL_RULE
 > -- 
 > 2.26.2


-- 
WBR,
Yauheni Kaliuta

