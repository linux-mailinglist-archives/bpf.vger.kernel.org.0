Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2645177353
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGZVVz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jul 2019 17:21:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35125 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jul 2019 17:21:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so25102428pfn.2
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2019 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kb9Bf9cvR9vWVFncI2VMEduWynQpZ2xkwaYakCLK6Uw=;
        b=2LLhQVv2jeFr2ObYIL9xyDcxF0EnLl6erAGMeV4GoF5L+ddkAkKyTaIJjELyOjNuca
         do9fOFGNdEo2vleQZJ+AWofKwMi00kZdppsQAWy/hMY2k51nQ4lQloMsPKFIB6WJS9Mk
         kG3p2sNzs1kxdWHbNoVYIrDAftPaS6PM5aT8eZotIftmPkaILEQ18qctu6z/dv/acOVw
         rbTfQwgiCNY6fymZKd2vjkHjGXNbqP1A7/NZ3rZoZT2whbtaj9sQFZ4JlZaQm2Mhn6WH
         O0n8VSV2P5rmCiUOeWXB5YLG0h0bmuJP4WXTeX7bgk7XcnQtI/68uZ+BYvyCfdX406Gj
         Xygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kb9Bf9cvR9vWVFncI2VMEduWynQpZ2xkwaYakCLK6Uw=;
        b=BpF253xA6GIrdeDPn2FiC0FugZEuav9+g57JDvqkrmXL+0X938pF9E+i8xd62kyCsw
         nH5oY6TfFXQGWD4PEI6QxPdnLypilLGLREtqSW+RTNyp43NlQ1oT96qOZzlv4cGXCRpo
         rO6sV4CS1UpalJQrYe27gjIivs1d7ipyVFWzNXjb7NcMP0dgTFsTFSBN4NDaUspB1x6k
         GhDYXV/gkhr56rsZDv+L7ngK1bSFHiLaGJ7JnUR+GsH78voVCqnBg/F8Xxv90iJ0cQWZ
         rOEOG0bpbvpGLn5pbC3H0oFZSWzApQcr7Vq4L0vfPiBQdZZXoNcb3Ygc88ajDPk2H1Ag
         zeFw==
X-Gm-Message-State: APjAAAWOOHsaNRNYnRJV5j8X5BVbXNXKvkWEub457+mOFnIWvOlHcW5b
        103gaazxwQCu2DEOsfv4BRU=
X-Google-Smtp-Source: APXvYqxYylXPgAEQyeDxVkup1UjVg9j0JigdtuRptJ/wF+S8rYT9cd8PdAqfbx9YK/hM2mgk0LHxCw==
X-Received: by 2002:a62:3c3:: with SMTP id 186mr24291819pfd.21.1564176114736;
        Fri, 26 Jul 2019 14:21:54 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z20sm87465439pfk.72.2019.07.26.14.21.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:21:53 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:21:52 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/9] selftests/bpf: prevent headers to be
 compiled as C code
Message-ID: <20190726212152.GA24397@mini-arch>
References: <20190726203747.1124677-1-andriin@fb.com>
 <20190726203747.1124677-2-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726203747.1124677-2-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/26, Andrii Nakryiko wrote:
> Apprently listing header as a normal dependency for a binary output
> makes it go through compilation as if it was C code. This currently
> works without a problem, but in subsequent commits causes problems for
> differently generated test.h for test_progs. Marking those headers as
> order-only dependency solves the issue.
Are you sure it will not result in a situation where
test_progs/test_maps is not regenerated if tests.h is updated.

If I read the following doc correctly, order deps make sense for
directories only:
https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html

Can you maybe double check it with:
* make
* add new prog_tests/test_something.c
* make
to see if the binary is regenerated with test_something.c?

Maybe fix the problem of header compilation by having '#ifndef
DECLARE_TEST #define DECLARE_TEST() #endif' in tests.h instead?

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 11c9c62c3362..bb66cc4a7f34 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -235,7 +235,7 @@ PROG_TESTS_H := $(PROG_TESTS_DIR)/tests.h
>  PROG_TESTS_FILES := $(wildcard prog_tests/*.c)
>  test_progs.c: $(PROG_TESTS_H)
>  $(OUTPUT)/test_progs: CFLAGS += $(TEST_PROGS_CFLAGS)
> -$(OUTPUT)/test_progs: test_progs.c $(PROG_TESTS_H) $(PROG_TESTS_FILES)
> +$(OUTPUT)/test_progs: test_progs.c $(PROG_TESTS_FILES) | $(PROG_TESTS_H)
>  $(PROG_TESTS_H): $(PROG_TESTS_FILES) | $(PROG_TESTS_DIR)
>  	$(shell ( cd prog_tests/; \
>  		  echo '/* Generated header, do not edit */'; \
> @@ -256,7 +256,7 @@ MAP_TESTS_H := $(MAP_TESTS_DIR)/tests.h
>  MAP_TESTS_FILES := $(wildcard map_tests/*.c)
>  test_maps.c: $(MAP_TESTS_H)
>  $(OUTPUT)/test_maps: CFLAGS += $(TEST_MAPS_CFLAGS)
> -$(OUTPUT)/test_maps: test_maps.c $(MAP_TESTS_H) $(MAP_TESTS_FILES)
> +$(OUTPUT)/test_maps: test_maps.c $(MAP_TESTS_FILES) | $(MAP_TESTS_H)
>  $(MAP_TESTS_H): $(MAP_TESTS_FILES) | $(MAP_TESTS_DIR)
>  	$(shell ( cd map_tests/; \
>  		  echo '/* Generated header, do not edit */'; \
> @@ -277,7 +277,7 @@ VERIFIER_TESTS_H := $(VERIFIER_TESTS_DIR)/tests.h
>  VERIFIER_TEST_FILES := $(wildcard verifier/*.c)
>  test_verifier.c: $(VERIFIER_TESTS_H)
>  $(OUTPUT)/test_verifier: CFLAGS += $(TEST_VERIFIER_CFLAGS)
> -$(OUTPUT)/test_verifier: test_verifier.c $(VERIFIER_TESTS_H)
> +$(OUTPUT)/test_verifier: test_verifier.c | $(VERIFIER_TEST_FILES) $(VERIFIER_TESTS_H)
>  $(VERIFIER_TESTS_H): $(VERIFIER_TEST_FILES) | $(VERIFIER_TESTS_DIR)
>  	$(shell ( cd verifier/; \
>  		  echo '/* Generated header, do not edit */'; \
> -- 
> 2.17.1
> 
