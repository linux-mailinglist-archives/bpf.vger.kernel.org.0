Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D194365A5F
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDTNnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhDTNnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 09:43:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A300C06174A
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 06:42:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g8so61590676lfv.12
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=cJs+y6GFszhbi+6DK/cYEwMv4Va3/avDkjdCxeqSUVU=;
        b=v301bcCb+OFOMB+YVSWT6sGT0oei6ZuPNAkDzbM1lNtWWTNpm7iMgonJ9kQMT1epCw
         nu6w4Jiq1/5e5pysUcIGn2hy8qhg3miq25LzzBeFqsG3Mf74htsQo/eppkEH6thHO1gs
         QtAbpX9gAcUtMnimqGHkO1CZmMP4RbwQiT9/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cJs+y6GFszhbi+6DK/cYEwMv4Va3/avDkjdCxeqSUVU=;
        b=q4PGoAXXu8UfhOG2lF8gMK9qm4N23Ih/vbLM5MqBtbTIxk6DtTtvLywDymqDOfZsp0
         35jyDSzWp+Z0cJHMda13NABhZVaDTkH/XzyK2DnGht6cqGvtjTOotqs4DhwJHW4FJA8e
         ic1KaqnYYcsxWLCPoXXINxJ4/9enE3HQU0k7eUk/bMv7m/o68pGcsfiU8Bfl9x0o656M
         65zsQkYaUXo2NCf8rTymYy5qOqtkw/6neOt1uKEFF9qH/QFCJ8HrHcEkSm1vsdXTY4Ou
         pw4Sg+s74UNyIaIwPbdPbiQdWeVy7Ho+ZN0OxFpxqQL/4nuPknLp9rx1D97ZCWmL1BlE
         U89w==
X-Gm-Message-State: AOAM5323064JwdYNxPZiz8JVX9uZLW2H22P1P1cGt20KmoO5KaY+PSp/
        gu2Tfy85ZpcPBpSs/HHSmap9qTNpBox6597Mh+ZIMBA+MhNJ5Q==
X-Google-Smtp-Source: ABdhPJy0+ibaw11Q7emSwzI5ukpUMr3VSyxSS0930XvjW9jWP/Rb2/L8Dxj597Cpm1D/Qu1/jlyjWPQSeJjkBAOH9CU=
X-Received: by 2002:ac2:4d08:: with SMTP id r8mr13730547lfi.97.1618926170821;
 Tue, 20 Apr 2021 06:42:50 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 20 Apr 2021 14:42:39 +0100
Message-ID: <CACAyw9_66VctZZajdAUb0jhhn03nFkvbFLRMc=1_2zJ2_kr-aw@mail.gmail.com>
Subject: Behaviour of bpf_core_enum_value with missing value
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

The documentation for bpf_core_enum_value says that a missing
enum_value will make the macro return 0:

* 64-bit value, if specified enum type and its enumerator value are
* present in target kernel's BTF;
* 0, if no matching enum and/or enum value within that enum is found.
*/
#define bpf_core_enum_value(enum_type, enum_value)

However, the enumval___err_missing test asserts that
bpf_core_enum_value with a missing value will poison the result if I
understand correctly.

$ sudo ./test_progs -n 31/77 -vvv
...
libbpf: prog 'test_core_enumval': relo #9: kind <enumval_value> (11),
spec is [5] typedef anon_enum::ANON_ENUM_VAL2 = 32
libbpf: prog 'test_core_enumval': relo #9: non-matching candidate #0
[6] typedef anon_enum___err_missing::ANON_ENUM_VAL1___err_missing =
273
libbpf: prog 'test_core_enumval': relo #9: no matching targets found
libbpf: prog 'test_core_enumval': relo #9: substituting insn #48 w/ invalid insn
libbpf: prog 'test_core_enumval': relo #9: substituting insn #47 w/ invalid insn
libbpf: load bpf program failed: Invalid argument

What is the correct behaviour in this case?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
