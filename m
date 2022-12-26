Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB5656232
	for <lists+bpf@lfdr.de>; Mon, 26 Dec 2022 12:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLZLet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Dec 2022 06:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZLes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Dec 2022 06:34:48 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0342ACF
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1672054479;
        bh=bssYE+navTdDKqaa5Fhf34N4zNrWBI3BaI+MSLdoMsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yrqkXrQYvHAajU4ExSnp3tRs9Ot3KrQLqWubxpPhxNp/yuUPWsSbZcG6OrEQTo61q
         adCxsnrBcTQGvX3xnSB0b5xqmA0RQ5aeJPvREB4r/yPyXcMCAxGhM7fULBFvd2K5Rj
         a3Q03bAjyI5SpYwk47K75s7HpkGn2rQx+wBYgmwE=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 8A5A1C08; Mon, 26 Dec 2022 19:34:37 +0800
X-QQ-mid: xmsmtpt1672054477tbdkdd15w
Message-ID: <tencent_BB1AE2BEC1B8D07716D9E5AE0AEE2BDAE806@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBbVF7Qzu9d2vGRP6vSvlZfOcPOTBJJSycCXP8mJ9LHMl9vNyn4d3
         9ndZmrjvmpSZMEeGHRoWr5CFgJdOQ54PGknL8cRbO1CdvXjfyNZErcZ0OM4SatfyvuAImYskUwUM
         7qo/OHQWaVuEwOesq3x7hQfvnQHonQmPTgwLrV3TSYppPvBa3OdSkvYLZO614A4J+soD+P4hA5cX
         P6O3GKKPTAH4jDgRoVIYJBuzmuf4Ph1KFMpxLRlXzM1/MOkS7YTobj3X4mu238L1LMkDGuzkYAVI
         9x92mvUPg2KsHVAnYVsl/dKMD3YeTwtNoqLUo0rCi3tGnM1lT8MAW+JUkhCwSfLBW3ChJ/lzyacr
         bTuNb16sZWlHTq3+f99xsbGAuxM/LXWeWE+xYi5BnJjhEEunsCciv0EsoGZAGy6FbMsQIgfckvSl
         /U/azZzMNc+UmH/ClW6DQl7bxGfLJ7n760OLMyDDJ1guXYHHzBF61PKwhYxzIeYo84kAGGZtyRBn
         L/2zoWlTZ4miEmXx40MtyN+oVEinwIr4vFM0MpQ1qdEyt/h0axuBKp1TZoC4GMQzGfVgajgno3YX
         P99h6R3i3uj7YYQyv/QubfIlIu7XPM1yac8Re0yLBbB32tD/DfmwIjxoNwlTkcvCpI2jxOd2J9QR
         l/UnLQnccKAegl0gX4fQN2sndFE354IUFRYnr28npXScDE+g59hCqoQ91vOq9hTzQjxSw8eHT3sy
         Oa3zgx32eqp2fUh6peEac1TpjQfU5CdUyQI5CntsAvyv9WGVigIhxeQHySa74TtMBfOZj3Zq0C5L
         Od9uxJLPh3FRlYB3UIn7COOLxRCXRqaiW//lteacef4yeDR/+nHUeZpdLb1+HXI0U/Tval6ur+MV
         HBnCDpC5Vnky3NQEjPRu61R0cNYjlwOWPddjX/E922Vt5jmAAo2gmZFhBZrJOAra4IskJC2M4s/e
         hYSri/Qhli88EfY73vqw7kKQwz0T1t
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/9] libbpf: make __kptr and __kptr_ref
Date:   Mon, 26 Dec 2022 19:34:37 +0800
X-OQ-MSGID: <20221226113437.11997-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20220509004148.1801791-3-andrii@kernel.org>
References: <20220509004148.1801791-3-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii. It is much better to get an explicit compiler error than
to debug the BPF Verifier failure later. But should we let the other
selftests continue to compile?

I get the following compilation error, and the compilation is aborted:


$ make -C tools/testing/selftests/bpf/
  CLNG-BPF [test_maps] cgrp_ls_attach_cgroup.bpf.o
progs/cb_refs.c:7:29: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
        struct prog_test_ref_kfunc __kptr_ref *ptr;
                                   ^~~~~~~~~~
/home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cb_refs.bpf.o] Error 1
make: *** Waiting for unfinished jobs....
In file included from progs/cgrp_kfunc_failure.c:8:
progs/cgrp_kfunc_common.h:13:16: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
        struct cgroup __kptr_ref * cgrp;
                      ^~~~~~~~~~
/home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cgrp_kfunc_failure.bpf.o] Error 1
In file included from progs/cgrp_kfunc_success.c:8:
progs/cgrp_kfunc_common.h:13:16: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
        struct cgroup __kptr_ref * cgrp;
                      ^~~~~~~~~~
/home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cgrp_kfunc_success.bpf.o] Error 1
make: Leaving directory '/home/rongtao/Git/linux/tools/testing/selftests/bpf'

Best wishes.
Rong Tao
