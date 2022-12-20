Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E587065284A
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiLTVSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiLTVS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:18:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A849FC5
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:18:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r26so19338028edc.10
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yilwtSqSPRXIZKCKToWyaJfXV3ttakbrq3g2ApD4Zk=;
        b=dMDOrbehxhqqhgwq7rhqq8DBhSLFPnv8y1GzUbMNsuSP8iVzHkqX67HoBWqCviBxrU
         P9upmnRKLRzdZ47XUSaTpXYXrZJIsto36Eq04UKbb6HDI4EP4g1DL1WwMsuPUr/P4B9z
         mXZUGFQa/zchOG/8BLdE8Fe2C83zrWkShueDn67sr9+HkJFoDYPD0Rlwe1hl5chNs7hI
         jY0jwSP9gNB4DeOktfpLR1kQ2BTREdUstv2ktgkPHxG/D8gr9gtsYl5T4onVCeQu7fE/
         jU6cl8TCUA9Haa7Rlgqp26ev+jJz/Rke/DjXjy/7I9evKasrgEM6ps/XbkcsyjaFrViG
         7sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yilwtSqSPRXIZKCKToWyaJfXV3ttakbrq3g2ApD4Zk=;
        b=WsqOR6wX3hMay9jAZlPPfdmRprQxhePR67Q0z1noBeOgIaFOyTgIYjCeE3CWVuceCT
         Sb/HGIES14v4BhS4bh0kQmfI8IPw/2IrBSHOXRa0Az9JZV/F6/G3rGCuRytHp6nEpnIA
         MObgVcoSIfrAmBTV4YRgcsgTAI1d9R0T7GNPBkMOZEP4msqSNfgECfh+sYFr6TohyJca
         6SEeEpDNhOjvwy3V6uvahMT/7RjDcatB9hJ4p5KnjB4IseP7ENrM52WcU/XyRKpOAx/J
         FnBIRhZHU3C1ghjOyPMIov6GMG/lblscaA/CHlv/m2cwjy1LmrN7/e94a3a03gTI+BT3
         2zjQ==
X-Gm-Message-State: AFqh2krI/VWT1hM+Gg6DFdi+cQQ5pKaWcLIvq9Ix+2Y/waGroZFM3uAo
        crjIKhUPb9OT5l7CxKYnsrN9NOc79NN158cNWEU=
X-Google-Smtp-Source: AMrXdXson3/eusD0SFjzRItM+rNqaxxiHcRXF6+ygrX0iKOrraW4QtzlYhzPQMVOH3OIsC3ytrQ3bXBCO51Ba/RbrbU=
X-Received: by 2002:a50:d603:0:b0:47d:71a6:da61 with SMTP id
 x3-20020a50d603000000b0047d71a6da61mr118164edi.81.1671571107334; Tue, 20 Dec
 2022 13:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com> <20221217021711.172247-5-eddyz87@gmail.com>
In-Reply-To: <20221217021711.172247-5-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 13:18:14 -0800
Message-ID: <CAEf4Bzb0foB6PQsSZsXrGEJo7eQK8UDRh+Pkr5wg259-QeXwaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: check if verifier.c:check_ids()
 handles 64+5 ids
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A simple program that allocates a bunch of unique register ids than
> branches. The goal is to confirm that idmap used in verifier.c:check_ids()
> has sufficient capacity to verify that branches converge to a same state.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       | 12 +++
>  .../selftests/bpf/progs/check_ids_limits.c    | 77 +++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
>  create mode 100644 tools/testing/selftests/bpf/progs/check_ids_limits.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> new file mode 100644
> index 000000000000..3933141928a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <test_progs.h>
> +
> +#include "check_ids_limits.skel.h"
> +
> +#define TEST_SET(skel)                 \
> +       void test_##skel(void)          \
> +       {                               \
> +               RUN_TESTS(skel);        \
> +       }

Let's not use such trivial macros, please. It makes grepping for tests
much harder and saves 1 line of code only. Let's define funcs
explicitly?

I'm also surprised it works at all (it does, right?), because Makefile
is grepping explicitly for `void (serial_)test_xxx` pattern when
generating a list of tests. So this shouldn't have worked, unless I'm
missing something.

> +
> +TEST_SET(check_ids_limits)
> diff --git a/tools/testing/selftests/bpf/progs/check_ids_limits.c b/tools/testing/selftests/bpf/progs/check_ids_limits.c
> new file mode 100644
> index 000000000000..36c4a8bbe8ca
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/check_ids_limits.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct map_struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, int);
> +} map SEC(".maps");
> +
> +/* Make sure that verifier.c:check_ids() can handle (almost) maximal
> + * number of ids.
> + */
> +SEC("?raw_tp")
> +__naked __test_state_freq __log_level(2) __msg("43 to 45: safe")

it's not clear what's special about 43 -> 45 jump?

can we also validate that id=69 was somewhere in verifier output?
which would require multiple __msg support, of course.

> +int allocate_many_ids(void)
> +{
> +       /* Use bpf_map_lookup_elem() as a way to get a bunch of values
> +        * with unique ids.
> +        */
> +#define __lookup(dst)                          \
> +               "r1 = %[map] ll;"               \
> +               "r2 = r10;"                     \
> +               "r2 += -8;"                     \
> +               "call %[bpf_map_lookup_elem];"  \
> +               dst " = r0;"
> +       asm volatile(
> +               "r0 = 0;"
> +               "*(u64*)(r10 - 8) = r0;"
> +               "r7 = r10;"
> +               "r8 = 0;"
> +               /* Spill 64 bpf_map_lookup_elem() results to stack,
> +                * each lookup gets its own unique id.
> +                */
> +       "write_loop:"
> +               "r7 += -8;"
> +               "r8 += -8;"
> +               __lookup("*(u64*)(r7 + 0)")
> +               "if r8 != -512 goto write_loop;"
> +               /* No way to source unique ids for r1-r5 as these
> +                * would be clobbered by bpf_map_lookup_elem call,
> +                * so make do with 64+5 unique ids.
> +                */
> +               __lookup("r6")
> +               __lookup("r7")
> +               __lookup("r8")
> +               __lookup("r9")
> +               __lookup("r0")
> +               /* Create a branching point for states comparison. */
> +/* 43: */      "if r0 != 0 goto skip_one;"
> +               /* Read all registers and stack spills to make these
> +                * persist in the checkpoint state.
> +                */
> +               "r0 = r0;"
> +       "skip_one:"

where you trying to just create a checkpoint here? given
__test_state_freq the simplest way would be just

goto +0;

no?

> +/* 45: */      "r0 = r6;"
> +               "r0 = r7;"
> +               "r0 = r8;"
> +               "r0 = r9;"
> +               "r0 = r10;"
> +               "r1 = 0;"
> +       "read_loop:"
> +               "r0 += -8;"
> +               "r1 += -8;"
> +               "r2 = *(u64*)(r0 + 0);"
> +               "if r1 != -512 goto read_loop;"
> +               "r0 = 0;"
> +               "exit;"
> +               :
> +               : __imm(bpf_map_lookup_elem),
> +                 __imm_addr(map)
> +               : __clobber_all);
> +#undef __lookup
> +}
> --
> 2.38.2
>
