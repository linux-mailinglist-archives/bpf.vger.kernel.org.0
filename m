Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED153F861F
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbhHZLJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbhHZLJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 07:09:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A56C061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 04:09:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq28so5958902lfb.7
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eB84Bj8kMV+Hz1xsU+Cw0cgKwabRUO/46ts9dKySgeo=;
        b=khCiZqANztExzVJJO5z7HlW3BRHdbmEuOSp7rB9vt7SSo5ze1CqlzdUJ42skPQ1H0c
         PFEe/UF4sTV2h5/ZpoNKNQKcgqUDRyIkS+q7HElSbkeAGEUS32ZpfWhhh5lKq/+qLeRm
         mGPWzV2VY+jkfFooMWNzswqwztC1n/rJyhyrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eB84Bj8kMV+Hz1xsU+Cw0cgKwabRUO/46ts9dKySgeo=;
        b=LttFRTZaiy+Mzmxfi0NulxrjEy8b6OwXGksAlBvY5VbehnEH5Dfvg6k8zI+aimaHeG
         GMpQtro6vUreiqoAQLhO9gRpGwBTdAvpkhYf344nkejSDk4JX7/hCFcBnGUtonREZZWE
         4N79nRlFuN1YJiMIc/A0ZrE10ssW6VtZsVYP1TFOPN9JJ60JevXdhiz5GQziry30xa7y
         XmeT1IxD1qtB2Xh8cGKE6IjNmnRhFg19gvaU/I+/k0aAWzTRcTLDhG/dZSYEgRR9bCrl
         DtigKI4wxGjxzaaUeTaeBT1mQsbdjI0uv3IRYzCltMy4ckw22erlqT+p+GcDK555H/TR
         dwLA==
X-Gm-Message-State: AOAM5325mdE/qP1MCJfKXPVokaMp5qbE7bdNM1Ym9ChvKF5Pg4mOJ91D
        svqkOp7FuTckFOxxvXZQuoNg1TMxs6lTawHT+zYaGw==
X-Google-Smtp-Source: ABdhPJyURFX4YiZxVvCCIRyQzbZI16DeDzYh7gAmylvHw/K+DV4efsZC4K3b7UMRWAx5PGGOxtLTgq1Zh6ftGQViRwo=
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr2421336lft.34.1629976144097;
 Thu, 26 Aug 2021 04:09:04 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 26 Aug 2021 12:08:53 +0100
Message-ID: <CACAyw9_y4QumOW35qpgTbLsJ532uGq-kVW-VESJzGyiZkypnvw@mail.gmail.com>
Subject: Concurrent BPF_PROG_TEST_RUN for XDP contend on dispatcher mutex
To:     bjorn@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

One of the tests for our XDP-based load balancer has gotten quite
slow, so I dug in. Roughly, it simulates 1m distinct packets arriving
at the load balancer by calling BPF_PROG_TEST_RUN a million times.

    distribution_test.go:40: 1000000 iterations
    distribution_test.go:99: Coefficient of variation: 0.52%
--- PASS: TestLoadBalancerDistribution (0.00s)
    --- PASS: TestLoadBalancerDistribution/32_endpoints (22.04s)

You can see that the test takes 20s. Running the same test with slight
variations in three threads results in this:

    distribution_test.go:40: 1000000 iterations
=== CONT  TestLoadBalancerDistribution/32_endpoints
    distribution_test.go:99: Coefficient of variation: 0.60%
=== CONT  TestLoadBalancerDistribution/64_endpoints
    distribution_test.go:99: Coefficient of variation: 0.82%
=== CONT  TestLoadBalancerDistribution/128_endpoints
    distribution_test.go:99: Coefficient of variation: 1.24%
--- PASS: TestLoadBalancerDistribution (0.00s)
    --- PASS: TestLoadBalancerDistribution/32_endpoints (55.61s)
    --- PASS: TestLoadBalancerDistribution/64_endpoints (55.61s)
    --- PASS: TestLoadBalancerDistribution/128_endpoints (55.61s)

It's pretty clear that something is serialising the threads. Digging
around in perf reveals that the culprit is bpf_prog_change_xdp called
from bpf_prog_test_run_xdp. The call was added in f23c4b3924d2 ("bpf:
Start using the BPF dispatcher in BPF_TEST_RUN").

Is there something we can do about this? Maybe only call into the
dispatcher when repeat > 1?

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
