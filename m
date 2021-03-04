Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43A532D1BF
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhCDL1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhCDL06 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 06:26:58 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC8C061756
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 03:26:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id e7so42626339lft.2
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E3QXDKkBzI9XbvOXIS+1X2Z8u1Ai0UNeL7P3X3biSAc=;
        b=ZBmOrjFEj5KAfWYHiLrBixiiS4Hr2h87XIZfjiWCsNLe1SsWmw5n1vzFvqw9K11fvt
         Qggnb1BhxsYeYrdBz2zMB4Ybc67UwWPQR2niwRznxQB5tYcb4XwuRzu0mOmR6i9F67HR
         RexV32mrtRTt+REKOUnpdB9xC0RlrFci98lUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E3QXDKkBzI9XbvOXIS+1X2Z8u1Ai0UNeL7P3X3biSAc=;
        b=paGqg3vVsoSGSZGqnvIkdXigjtkFrHrBeKfOLcJHX5Y0C+kqVta4idb7SRaZ2h/tDy
         gxuApy0jM/faO39x7yE5kA8F0M811Z5fA/CkpQZxSSi9iZKkQfd6COeNumGw/xKBzfA3
         YSALevQdYhLEYMtrb7QpHTdqZVhQQ8eAe/MPeob5kQ3Kq/+RvvpTKdpi8pTLf03c7sur
         c9uXlsfiberv4YJl3nvkraXr+kPWL8ynFAfmJAgIfp1WCsa/Dm7O/NeDhviqCLyp82bI
         8kciEQlx5RoTBoTS5K5Sd+Cbm4+JiFxs5lCD0pUvW+Tdwig0BR4bfWPhBPtxXPtsTpL0
         EatQ==
X-Gm-Message-State: AOAM5339qYnw5lotNET8cLB3+/GsveOB730ZiJt6QlEBCQnCyyroOQ5g
        D/Vt/BQcMxSnEzyk6xWtN0olZUrZwa3xPUJAwC/Iqw==
X-Google-Smtp-Source: ABdhPJwrW1WBE5kuk29xs+CacLIAGtImNwXMoU+Ia1k81RRxSP6BbSUU0s2/GW7sGn8i3ch/osKs+Cbkre5v7t5gxao=
X-Received: by 2002:ac2:41ce:: with SMTP id d14mr1945725lfi.451.1614857166986;
 Thu, 04 Mar 2021 03:26:06 -0800 (PST)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 4 Mar 2021 11:25:56 +0000
Message-ID: <CACAyw9_P-Zk+hrOwgenLz4hCc7Cae9=qV86Td2CkGVUPAzWQ8A@mail.gmail.com>
Subject: bpf_core_type_id_kernel with qualifier aborts clang compilation
To:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong, Andrii,

Some more poking at CO-RE. The code below leads to a compiler error:

struct s {
    int _1;
    char _2;
};

__section("socket_filter/type_ids") int type_ids() {
    return bpf_core_type_id_kernel(const struct s);
}

Truncated output:
fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
PLEASE submit a bug report to https://bugs.llvm.org/ and include the
crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.    Program arguments: clang-12 -target bpf -O2 -g -Wall -Werror
-mlittle-endian -c internal/btf/testdata/relocs.c -o
internal/btf/testdata/relocs-el.elf
1.    <eof> parser at end of file
2.    Per-function optimization
3.    Running pass 'BPF Preserve Debuginfo Type' on function '@type_ids'
...
clang: error: clang frontend command failed with exit code 70 (use -v
to see invocation)
Ubuntu clang version
12.0.0-++20210126113614+510b3d4b3e02-1~exp1~20210126104320.178
Target: bpf

"volatile" has the same problem. Interestingly, the same code works
for bpf_core_type_id_local. Is this expected?

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
