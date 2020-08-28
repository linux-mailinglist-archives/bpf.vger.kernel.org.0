Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6925595B
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgH1L2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgH1L2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 07:28:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3016C061234
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 04:28:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so920432ljn.2
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kqrn9jGcOg5uP/dEw7hgHIrmIziR1mxRrb3HSOicSHE=;
        b=NC0K/HQ2ei7p8vwHg+osWUU5wedFAF78ahB+poxkIeYepE1kyaxAJZ1zlHrQS0Dvlg
         ZoNg8K+VphWDA8nBdn8P6kca+oajTmcY8r1f4UHGGmoZrjjdsmSBJR+tWl93vxqYmZBQ
         gQztZDJIxSOChm3NUZ3EiLjvhmgm2OFjR0DbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kqrn9jGcOg5uP/dEw7hgHIrmIziR1mxRrb3HSOicSHE=;
        b=FgrSWcJbUp9070y7FtK68HshNvSlJ9M6wYiRztZFuWoWR2+vptWo4y2JleOkrSfLks
         XgJlHNkx0YqxpkRBxJdINk6HLnkFW1WvARvEHaYYC4DnceBtmK9WbuU6Of4/apdqVZGC
         C45DetgZOTK7+bGHChyVGzGKIyREBbP3wBnsIQSUsQCSOmJ+9x53shRPns56A90WdOym
         uywOC3UUcM7eCtgDmoehcdtAQybQDyvrGiqOCK47PLo52JMXtdap+NHX9wSkKKm4pulo
         8zX0TGxwiod2XLgDZMfXg4NWKMx+4Czoze9+IZLtxbL5hFat1380oB6NKz9v2j8E3iN7
         9daw==
X-Gm-Message-State: AOAM532ouiTYBK9KLc3jg5qR9ULSYvyDtpynXtNuSRQPYMCyNdj6aiO2
        bzhUHDujG07umIsr++eGjMtzpw==
X-Google-Smtp-Source: ABdhPJzmpRrm/R/CqbHS/7UJopbkV/HcbRyjsFmOoOnA2ZfaCFn6GA4YM5/I3QPkXHvWx+RMtpBdlQ==
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr613923ljj.461.1598614114118;
        Fri, 28 Aug 2020 04:28:34 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id v7sm149444ljd.10.2020.08.28.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:28:33 -0700 (PDT)
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 2/3] selftests: bpf: Add helper to compare socket cookies
In-reply-to: <20200828094834.23290-3-lmb@cloudflare.com>
Date:   Fri, 28 Aug 2020 13:28:32 +0200
Message-ID: <87ft87rov3.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry for the fragmented review. I should have been more thorough during
the first pass.

On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> We compare socket cookies to ensure that insertion into a sockmap worked.
> Pull this out into a helper function for use in other tests.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 0b79d78b98db..b989f8760f1a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -47,6 +47,38 @@ static int connected_socket_v4(void)
>  	return -1;
>  }
>
> +static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
> +{
> +	__u32 i, max_entries = bpf_map__max_entries(src);
> +	int err, duration, src_fd, dst_fd;
> +
> +	src_fd = bpf_map__fd(src);
> +	dst_fd = bpf_map__fd(src);
> +
> +	for (i = 0; i < max_entries; i++) {
> +		__u64 src_cookie, dst_cookie;
> +
> +		err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
> +		if (err && errno == ENOENT) {
> +			err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> +			if (err && errno == ENOENT)
> +				continue;
> +
> +			CHECK(err, "map_lookup_elem(dst)", "element not deleted\n");
                              ^^^
Here we want to fail if there was no error, i.e. lookup in dst
succeeded, or in the unlikely case there was some other error than
ENOENT.

> +			continue;
> +		}
> +		if (CHECK(err, "lookup_elem(src, cookie)", "%s\n", strerror(errno)))

Nit: "lookup_elem(src)" as log tag would probably do. I don't see how
including the info that we're looking up a cookie helps.

> +			continue;
> +
> +		err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> +		if (CHECK(err, "lookup_elem(dst, cookie)", "%s\n", strerror(errno)))
> +			continue;
> +
> +		CHECK(dst_cookie != src_cookie, "cookie mismatch",
> +		      "%llu != %llu (pos %u)\n", dst_cookie, src_cookie, i);

Does it actually make sense to continue comparing the entries after the
first mismatch (or lookup error)? We could just fail-fast.

> +	}
> +}
> +

[...]
