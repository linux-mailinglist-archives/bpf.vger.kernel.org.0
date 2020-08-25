Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85D251E99
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgHYRo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgHYRo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 13:44:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0CFC061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 10:44:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o8so8358893otp.9
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ntSHUt2a1B+2Yh8CUmxEf7rUTqElIS4Z7sAJfBd2sVw=;
        b=wuXPOrHiS8Aazy0634wDVH2jj7WRCZHcbLrzMpN7A75B01lDYpotMaeZFngCG6NH64
         ajsrpVyrEYkRi8Z+pbm/Jg6McpF/1hHEM3og2omkLkWpKf7/TLGzoBYE8wsn4SY+eQEX
         4DszqcRnSbs+KymoXYAcyP/8Lpve6SS7bUukI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ntSHUt2a1B+2Yh8CUmxEf7rUTqElIS4Z7sAJfBd2sVw=;
        b=F1B9zj/G4CojLblmzKHHfsvrOR1wLqIz05FeXaf/D80+IeOsa48Thsnh6sFxogi5eF
         IjuzLA2lCXIw3cp38coCvbZ1q8qe7s8DccaOCTmpDYxKAhiWSHzqspW6QS9ofDiOENkN
         7IOOut2g3uvNOzBTRwuzUsp2sO2rKZZzUNavmKWyk4cdyegLVDU6ev7dnEZRj8QHuQHv
         IW7UL4zEsEY/wx5VeT1rHp3uyBFPdLwTzwmDx8w9VHaDdDbiFCaUcxC3CaWTvuj1612D
         oq22+Mvt9GKuniEzhbxitiVqah5bNlgYgVN/Pm5lRr8A658dPR7VWPi3Xa4LZDXNWnPG
         hf7Q==
X-Gm-Message-State: AOAM530D3ZJrFQcdAETVPorvD+EcDC1nqgyDNavoYh82pyy6CINehaoX
        0jIVH/GJOCRQeMRZWgCZEbTkgq+FwHNWqQUJiZQsfe5es5sAeg==
X-Google-Smtp-Source: ABdhPJxKpzCP0iyqslTs4y69kt6wq2sqg/7tQQnUiTIsn5XdFjM69l05r9oP/kzs2DVCh4/ZUJ74KmX78Pr0PBCZ27o=
X-Received: by 2002:a9d:6e18:: with SMTP id e24mr7077357otr.132.1598377491709;
 Tue, 25 Aug 2020 10:44:51 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 25 Aug 2020 18:44:38 +0100
Message-ID: <CACAyw984Z3YiQPtVOZkSYzxOECHOhJKKe8d4=g9eDu0OK9Nq6Q@mail.gmail.com>
Subject: Adding sockmap element iterator
To:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

I'm currently looking at adding support to iterate sockmap elements.
For that purpose, the context passed to the iterator program needs to
contain PTR_TO_SOCKET, like so:

    .ctx_arg_info = {
        { offsetof(struct bpf_iter__bpf_map_elem, key),
          PTR_TO_RDONLY_BUF_OR_NULL },
        { offsetof(struct bpf_iter__bpf_map_elem, value),
          PTR_TO_SOCKET },
    },

This is in contrast to PTR_TO_RDWR_BUF_OR_NULL. I think I could just
add a separate bpf_sockmap_elem iterator, but I'm guessing that this
is counter to how you would approach this. What do you think is the
best way to achieve this?

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
