Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F336E8C4
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhD2Kai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhD2Kah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 06:30:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C5C06138B
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 03:29:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a13so21997514ljp.2
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z0WL9mbep7R2yKJjW7W085saQFdlDJbJ49j9X1pYJPQ=;
        b=eVyF9rlp4J40CT2wcdLb+qlo+fbdBGkekbXWCCR/BQGQlHFhSWwEMOwntirPeCS6E0
         NUhO3yv3fovlXDv44wj2dKms1c6IKhqlneZWK0jAz/uE0q91xo+AvJLqtvwB//Zv/zg1
         goR37ejE0B1xbWZqUdN4BMmQSx1UEYWwfGTYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z0WL9mbep7R2yKJjW7W085saQFdlDJbJ49j9X1pYJPQ=;
        b=GkQqJSealUj8fSjrqPWBImeztMZi9+1ok8cU4BRNORNiH/kpi/oXnTEx+WZgspYDW2
         5xUVK1PIqvb3P6cKoKIf9N8DFUQLANYnyYxu/f463vVaACVgur87grzzfjMhXKzvEWqf
         6P1TuH7knMtSuFtTtetVmw0uhkGPtGFQsoN345QNjxsRYyynE0Ze2gYhOfrAOwvF6gCf
         GAHEr/pY3huarc8t/kZzgqRVw/9DfP5WQm1foEdQsjyTmLrE2ieLe3FSXEZl+pqnMEmx
         x5loGhAcX9VExtLgGGNW9SkSyv4qLbA2OnXgQ/z0cu+YcIXgb4kMORIggLXyVG/tVj+E
         lMHQ==
X-Gm-Message-State: AOAM533VOgzHaqr8MNvdmyZ6VnucratloBt9y+KjCg4fTJg1DjmbMvU+
        ZHIm4hq4ygCYOHNIriIqkciGC2EMry2aFTzBsbH61g==
X-Google-Smtp-Source: ABdhPJwG3yUOvsC4xo/X1ZXnxCZHgVzHsD5qF7vSQoNKpsV1ogHDXJaRaUtvFh6O2YVbzSpeSDJmEvDs5e5CJGHJ7Xo=
X-Received: by 2002:a2e:9741:: with SMTP id f1mr24144895ljj.226.1619692189249;
 Thu, 29 Apr 2021 03:29:49 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 29 Apr 2021 11:29:38 +0100
Message-ID: <CACAyw99n-cMEtVst7aK-3BfHb99GMEChmRLCvhrjsRpHhPrtvA@mail.gmail.com>
Subject: CO-RE: Weird immediate for bpf_core_field_exists
To:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii and Yonghong,

This is probably a case of me holding it wrong, but I figured I would
share this nonetheless. Given the following C:

struct s {
    int _1;
    char _2;
};

typedef struct s s_t;

union u {
    int *_1;
    char *_2;
};

__section("socket_filter/fields") int fields() {
    struct t {
        union {
            s_t s[10];
        };
        struct {
            union u u;
        };
    } bar;
    return bpf_core_field_exists((&bar)[1]);
}

clang-12 generates the following instructions:

0000000000000000 <fields>:
;     return bpf_core_field_exists((&bar)[1]);
       0:    b7 00 00 00 58 00 00 00    r0 = 88
       1:    95 00 00 00 00 00 00 00    exit

The weird bit is that the immediate for instruction 0 isn't 1 but 88.
Coincidentally sizeof(bar) is also 88 bytes.

$ clang-12 --version
Ubuntu clang version
12.0.0-++20210126113614+510b3d4b3e02-1~exp1~20210126104320.178

I've tried clang-13 as well, same result.

Best,
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
