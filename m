Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB0276605
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIXBsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 21:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXBsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 21:48:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99090C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 18:49:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b19so1268586lji.11
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=U0a55Nob1GClSlOLKv+AAmyIAi7E4xNR0OBjgHljCiw=;
        b=Ucim/t/9bbbD7GlLCJ6fSHKO9r+ditl53ul/ZJ+jB1KDvPLkc6tSHWaVXwnpm7DHBs
         NKNFU9AdoRsNrtWL1oUicn6vA4RtMkTgDcWNbMotQniFH72baiAVMtdjrrAsL1q2zz2X
         m29VcPxzgZzLZ6t9FrtTpOGhhvSHjReXkKwosOs673F7a8CxobfRvt91dZo8NMPFoviF
         gW4H+u6x9FYxlgc3qmFdT6zjfgCIn86fKxFMu7yVoyt5mmQ8M6LTdnN//dnVjhCQksWG
         O1S/hrJd0bSvTG/0cjkk4/lCwanLpcf9HmGuOpPmQnmFMdNaLswGkQvQQcLhkjskYR7N
         Ff6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U0a55Nob1GClSlOLKv+AAmyIAi7E4xNR0OBjgHljCiw=;
        b=r0XkZf8i3Vbe6dn57kKOXEy3sAZWKnSgyIkqccW3ORMMDZmgt1IGDm1XeECKeJHJ/H
         sHoIhnQpZHbbYLRBllCjnziVHKSe6byjrXhgAeWH/RIkkBX1Tmg9dulLy66GE8TSM9lk
         vljblnHcPhspFQegHLJpMpQvi3qBqWcl/dPzneFzRYFS6icUK+9cScWEk44CIZWPCY4g
         PgGjaK7razyf+f1XzzUt8YS1npoe6L8jAxc6teI7D8TJ6bZzGnW3i0bVjH7dyEUGDSyw
         AftWpYfuZBUWU0Nn4qzj8PgDq6rYuFle/zEyv4OWq06vEJd0j+9xVf+68rrcrjoMzMjl
         Om+g==
X-Gm-Message-State: AOAM530ZZRuMZB0tdBtbgCot+hZzbGc+f16xpWUIy6hVJ549eVaTHY2A
        ny5mukw83op34RQ2PhOhmQhTn5eKWqB997N61T4=
X-Google-Smtp-Source: ABdhPJy2cY7efZ8Je1F/h2DgsCXc7f656wMhcE8Ww6cNU2OPodIW6GHv61BCTOwOUPBaq0iWzuxAvTz8+MtJA5KKKZ4=
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr828336ljj.450.1600912143936;
 Wed, 23 Sep 2020 18:49:03 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Sep 2020 18:48:52 -0700
Message-ID: <CAADnVQ+phbXaN-X5WDBWX7i5NZhs_acRhXBxea1ZFQrwK29bcQ@mail.gmail.com>
Subject: flow_dissector test is flaky
To:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stanislav,

looks like flow_dissector selftest got quite unstable recently.
test_link_update_invalid_opts:FAIL:340
bpf_link_create(prog1): Argument list too long
#33/25 flow dissector link update invalid opts:FAIL
test_link_update_invalid_prog:FAIL:400
bpf_link_create(prog1): Argument list too long
#33/26 flow dissector link update invalid prog:FAIL
#33/27 flow dissector link update netns gone:OK

It's failing for me half of the time with a random number of failures.
Not sure what happened. I think it was stable in the past.
To reproduce:
test_progs -t flow_dissector
