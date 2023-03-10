Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741436B3AB6
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCJJhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCJJge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:36:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C5E20D7
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 01:33:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi9so5824698lfb.2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678440828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dml4eOiOQPfwpK1W2NVACa86Jm2ZkQwtbfolJm7kXGI=;
        b=oy9/TTkN0utSjhfDi0p6R299rCuZuFkE1jfAmjerdOSs7+kL6PpQOCT+9HltMLl1bL
         Ef/FefNYalE3fhdQs3HCg/vBJXV8r6v2veNwOxHz1ASCnSyl60hGumvSIiPTETagPJBG
         Xf/XJWza52vXq08rNirh4xEeJLDv5wEN/YaL1xMUxKEOMtwO73/q4ywX07cte2RNgh4a
         ojJ5DhqzEnOWhLmUGGwvRapouI2mYCnjAbJqK7HOxAq0jm74A4H0QU9aQAwoAXG8MRys
         X2nrtdBsetsLLOf8EOj6rKTInUCim6wgXwrAkRe8JVARhd74rU2tV3m234Tfmal6Jp4n
         jJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dml4eOiOQPfwpK1W2NVACa86Jm2ZkQwtbfolJm7kXGI=;
        b=ndS32LxX15x9qfPfHOol/w2bfWgNswCX6r0MHLioPzvM+C3GEzXmHQGCzu60zZ849X
         4GQnJXitejt8Jd9F0p6+bk7vtN4tQgjzJb50nFjsidTZTtMdSTnE1fk7DENO8tKxmRub
         5JPy4TFU7Vmo94DP4Y2M0oOY3GkuMJKswwAVhQuw4mwRGvrzrH1679OqRf5mWsiKmGAx
         oZGm8AHX2+V5EK2dkACCci6PMsm5hU5EH/BWnsXYbP5OOT+1Xr0lw0eTFIfW1bhx3cK0
         6tJ7FT4B6ii8OXyXRk8exmTTSK/hostcmECq2rnO8GosqfEv79MKDOqd1tUU1zaBqAcu
         gFhg==
X-Gm-Message-State: AO0yUKWg3bfQbRHrGyjsGu9Yk/0psgZf/vRiku3quudPii4tbQU/gJOj
        n4JS2kOAlhIr0X2s+LuFl4wabxpa9IaxKBEA1AY=
X-Google-Smtp-Source: AK7set8OIiKLUaIwkPNh8CTA4RhWOJGzROgCZY6eiXVUZOI1eW90zDSzpX17hIDsFt7Wj5363adt4V6cZPUq6+HjCCQ=
X-Received: by 2002:ac2:4884:0:b0:4db:4604:6328 with SMTP id
 x4-20020ac24884000000b004db46046328mr7572904lfc.11.1678440827754; Fri, 10 Mar
 2023 01:33:47 -0800 (PST)
MIME-Version: 1.0
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 10 Mar 2023 10:33:35 +0100
Message-ID: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
Subject: [RFC] Implementing the BPF dispatcher on ARM64
To:     bjorn@rivosinc.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        daniel@iogearbox.net
Cc:     bjorn@kernel.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
I am starting this thread to know if someone is implementing the BPF
dispatcher for ARM64 and if not, what would be needed to make this
happen.

The basic infra + x86 specific code was introduced in [1] by Bj=C3=B6rn T=
=C3=B6pel.

To make BPF dispatcher work on ARM64, the
arch_prepare_bpf_dispatcher() has to be implemented in
arch/arm64/net/bpf_jit_comp.c.

As I am not well versed with XDP and the JIT, I have a few questions
regarding this.

1. What is the best way to test this? Is there a selftest that will
fail now and will pass once the dispatcher is implemented?
2. As there is no CONFIG_RETPOLINE in ARM64, will the dispatcher be useful.

[1] https://github.com/torvalds/linux/commit/75ccbef6369e94ecac696a152a998a=
978d41376b

--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
