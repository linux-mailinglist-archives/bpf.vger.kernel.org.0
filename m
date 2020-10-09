Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7103288DB7
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgJIQGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 12:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 12:06:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CEC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 09:06:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t20so3582396edr.11
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PSQVoANN+hMFFBYk/bXlapAFud3jvd6ZFFde0zx7XPY=;
        b=W0SEzQwkjq5dsPcbV7MHRJOTJrI1sM7coMpsLhGx5NV0ogGltO30W0uxfvD2STM6ph
         Hk3GEytgp6u92dcd5GJcFzyKwias0unmO1ut/Kmd2OgLQH7JE14WMlTc1ZKhLK1NbFR3
         T4szK5pfeej2BVnBYvtiP+ezTuMxOKJdHzlTnvNd4nkrpVjBCQ/Ergm5OJ7XxYruHn8V
         puA1frXXVmP+8FKz7GUUMq5+oTns16bDY373MGjnxKzMif/QozWI+whxM/sWsxn+S8Q2
         CJ9ja+w2DcliZpdxYth94LcF0AKA1GxBF7eYXl3ZuLGjHH8twDS5V1hF9i4U17qcJ5sQ
         C2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PSQVoANN+hMFFBYk/bXlapAFud3jvd6ZFFde0zx7XPY=;
        b=rd5vGZqas8LGc6vvwXEc/+h9JQKAigyX/GiDkV/kCuzYpvoltFbQ+v/apSa4nWcSoD
         jJv90QOdd3ZFrWSeTgOoniYVEuTmWXqcfNGD2PzHqsjqGMM1homSlFypH+iD0V0lglty
         2BQOU1ldkMd6I1BgQ+kv+2tPN7a7aZp1P608Dbz2BxoT/QKDUhH40WpEqDr7FbsEiDqM
         T3q6x21TlxHclAJi3WhlVjBkJMPHWEa3tlqQjqjY3FLTsdlceeXqzB7f1QUUgruoawzw
         cfjRyt5UucTo4iw9mooZQG6Or2denoaEbEiMTiqQjh0lXKR/gCPbvne1+YYRMWe8bbgc
         SQfg==
X-Gm-Message-State: AOAM533O2IoUCCP2dFbg5IN/Tpb6HGAFZ4HS+NL5tqesJ0MOUCjRJ8qK
        pyF0m3RgjyAIuN+7W2bYD4XKrgxWFE5C/ochWU88oGAyppzjCyYh
X-Google-Smtp-Source: ABdhPJwyNwiLQG40498MwbceCAZ49XkFxBpVPJKMk00DyGMWlcdGS9Uycb13ZDG0zVZn0uWUevUer2J+glO7ENsbmvw=
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr15620538edw.331.1602259559916;
 Fri, 09 Oct 2020 09:05:59 -0700 (PDT)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 19:05:48 +0300
Message-ID: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
Subject: libbpf error: unknown register name 'r0' in asm
To:     bpf <bpf@vger.kernel.org>, daniel@iogearbox.net,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pulling the latest changes of libbpf and compiling my application with it,
I see the following error:

../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
unknown register name 'r0' in asm
                     : "r0", "r1", "r2", "r3", "r4", "r5");

The commit which introduced this change is:
80c7838600d39891f274e2f7508b95a75e4227c1

I'm not sure if I'm doing something wrong (missing include?), or this
is a genuine error

Yaniv
