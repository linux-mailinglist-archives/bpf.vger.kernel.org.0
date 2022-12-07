Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF64645325
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 05:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGEn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 23:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGEnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 23:43:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B656EC1
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 20:43:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso397634pjh.1
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 20:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP4gNmyGxPLZfFR2Gn9BMrTI0MJsC//JYIgGHoihpg0=;
        b=aK/kHru5vkl2JXQnRpsNY5+4YENt/Xk9z3IZchkrdMK/0wxbdyXl8yiqQ2xSeI7AEz
         k84zKHpKlzz75a7c6cpJVbl6UwOoiit42+Wh2ZVTfXndZqQXqFL3+U9pwb2+UJnFn6zY
         UH5biAsW0d9RGBrUaHEsLtxzBgtSZzPDBqxNGQkm6fn/EgOM13bGSdcMdYWeCvwaGhkV
         yXI0RYZCgd5puRZnU/wqQ17d2vk3S/3tDIxivSgz4ZOOafxmbvlFqJgZk5hISfeB0hTE
         Of9dx3itYp8Qsw0w/3tKJVvF+JNv1jwSJf2siGXM1b/s0u7lVK8d4j2TUAcDaVr5lzhz
         FTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP4gNmyGxPLZfFR2Gn9BMrTI0MJsC//JYIgGHoihpg0=;
        b=il1fXTvOP4YchAu3aUhIhsK6nyCOommiizxiNsZHdVl7y6JYtCw3q/03tpmcUS3riF
         5gX/G+Hzty6Nq7bZxWKqk7c19wFqhLSjxf7z20doJPpx+Bd3SkUinZJkIXF8fWbK4dzx
         pjpjXgDHfD53LuUoNu+fwnJq+rECMPPm/6UTMdhrnZGJXizGGujD5MKrJkFr2ePzjUK1
         4FC7iV2zGXOJkdWj/DoeW2VURiPHQNTPeUkzQScbX5BMtta+IQaadcyEegaz8zQjmNsk
         wPJaZwN6KtZKxLzml4ujtBobww4FYNZPxbGXRcqf3zITg4NzHNkz9GXB0+dI5jfFnLuM
         PZfA==
X-Gm-Message-State: ANoB5pkkVlxfoWROk5qsyH73H3iDMJAYm/CnGrQsy/NUJkiVINnReEU4
        TiLbYz05IfcqoqYhuhNHBHtG3I7lwBg=
X-Google-Smtp-Source: AA0mqf4VSVjqqRsB8TrB1pnDvootIq8/OMdQfAV+dLUH3Vg5YHp7y81D8XqjAm3XCHIpPMtu0a7/jw==
X-Received: by 2002:a17:90a:a781:b0:21a:15cf:fcdc with SMTP id f1-20020a17090aa78100b0021a15cffcdcmr69827pjq.39.1670388202767;
        Tue, 06 Dec 2022 20:43:22 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id m17-20020a656a11000000b00478a3079b7esm5620466pgu.19.2022.12.06.20.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:43:22 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:43:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add generic BPF program
 verification tester
Message-ID: <Y5AZ5hpE/66KJzUS@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206011159.1208452-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206011159.1208452-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 05:11:58PM -0800, Andrii Nakryiko wrote:
> +
> +
> +typedef const void *(*skel_elf_bytes_fn)(size_t *sz);
> +
> +extern void verification_tester__run_subtests(struct verification_tester *tester,
> +					      const char *skel_name,
> +					      skel_elf_bytes_fn elf_bytes_factory);
> +
> +extern void tester_fini(struct verification_tester *tester);
> +
> +#define RUN_VERIFICATION_TESTS(skel) ({					       \
> +	struct verification_tester tester = {};				       \
> +									       \
> +	verification_tester__run_subtests(&tester, #skel, skel##__elf_bytes);  \
> +	tester_fini(&tester);						       \
> +})

Looking great, but couldn't resist to bikeshed a bit here.
It looks like generic testing facility. Maybe called RUN_TESTS ?

> +
> +#endif /* __TEST_PROGS_H */
> diff --git a/tools/testing/selftests/bpf/verifier_tester.c b/tools/testing/selftests/bpf/verifier_tester.c

verifier_tester name also doesn't quite fit imo.
These tests not necessarily trying to test just the verifier.
They test BTF, kfuncs and everything that kernel has to check during the loading.

In other words they test this:
> +		err = bpf_object__load(tobj);
> +		if (spec.expect_failure) {
> +			if (!ASSERT_ERR(err, "unexpected_load_success")) {
> +				emit_verifier_log(tester->log_buf, false /*force*/);
> +				goto tobj_cleanup;
> +			}
> +		} else {
> +			if (!ASSERT_OK(err, "unexpected_load_failure")) {
> +				emit_verifier_log(tester->log_buf, true /*force*/);
> +				goto tobj_cleanup;
> +			}
> +		}

maybe call it 
 +struct test_loader {
 +	char *log_buf;
 +	size_t log_buf_sz;
 +
 +	struct bpf_object *obj;
 +};
?
and the file test_loader.c ?
Nicely shorter than verification_tester__ prefix...
