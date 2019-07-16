Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F16B025
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2019 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfGPTzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jul 2019 15:55:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44852 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPTzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jul 2019 15:55:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so9602593pfe.11
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2019 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1Azkzib+8xqVPZDnLUrm8VJ9XsxX7J/EJPH6cpkkiQ=;
        b=i8u0mJZ3MHHlIeEPYVqmIDXnyJUJDAuVU+IND305z0YyuzpuhVC9f3TSWMmFA6F8qQ
         1sQnH87W0LKTtVmUyzGq73KF4FmF0JAVun1FDoTjVye/vQxJT4ZbYeSKQzFjw9HbfchC
         iJUI0J8lELYarHgp390HWcCEd4VphNqRoVGDgdpuyZvos7OX+a0KmAeAJ/lAG4aXtfSf
         W+/cbYZiTf717s+hxbZGnSGVSMIZdgP4Uj92PplslEdqFJdOP52Y09u3oxaj/OgaShS4
         1o1CcFz5qg2nDghPRg9YgQgovT/AHCTjYrfh2+vldPrWxaKCh+UqUrti9yd7fHRcwTaR
         v9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1Azkzib+8xqVPZDnLUrm8VJ9XsxX7J/EJPH6cpkkiQ=;
        b=jVnooOmHfW0mKdQRIYpQtw/8XOi7gsAiofi8BAKQxo6sXm6xOLnuoxat6dbaoRA7oz
         orCfb00vWkBDyLZOR20Xp23PK1o04r4+xHEbDgq5fG/K48vzaS9P/VHDofiFefumThD/
         ntW/eXu5CzgFD7bz/Su4hP0cN5mzIhllxfGs/bx7o9nD87g+QzBFoGtSoGR6k+Q+4vWI
         GCuNnadD84KYqBqu4nqBV99IvCykcKiJZrgCStAacJHhSEdbVYi6KdJ5TDiFHQflXaay
         dq+mxWtlmm5N4vN1h/+oIh24Q1ju1WBWAmDk/aYQ79hPjIqEkxrLzDCc88pgHBuH+QBH
         twdQ==
X-Gm-Message-State: APjAAAVN77o14C1+8tUQVRvBhhyA2/vpxw2IIZOfnUzLZJyAE4jiyfr9
        f1+TKoQFa2n4Mz5/7ZJEM6I=
X-Google-Smtp-Source: APXvYqzirQAAitbL7qs3tIm4MUCn3DWG9qDpP7wIIEXcZYovXa8t0DHyUTIPyePKS91fq+MseucnFQ==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr36608368pgc.14.1563306945971;
        Tue, 16 Jul 2019 12:55:45 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id x22sm26357830pff.5.2019.07.16.12.55.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 12:55:44 -0700 (PDT)
Date:   Tue, 16 Jul 2019 12:55:44 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@fb.com, andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf 1/2] selftests/bpf: fix test_verifier/test_maps make
 dependencies
Message-ID: <20190716195544.GB14834@mini-arch>
References: <20190716193837.2808971-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716193837.2808971-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/16, Andrii Nakryiko wrote:
> e46fc22e60a4 ("selftests/bpf: make directory prerequisites order-only")
> exposed existing problem in Makefile for test_verifier and test_maps tests:
> their dependency on auto-generated header file with a list of all tests wasn't
> recorded explicitly. This patch fixes these issues.
Why adding it explicitly fixes it? At least for test_verifier, we have
the following rule:

	test_verifier.c: $(VERIFIER_TESTS_H)

And there should be implicit/builtin test_verifier -> test_verifier.c
dependency rule.

Same for maps, I guess:

	$(OUTPUT)/test_maps: map_tests/*.c
	test_maps.c: $(MAP_TESTS_H)

So why is it not working as is? What I'm I missing?
