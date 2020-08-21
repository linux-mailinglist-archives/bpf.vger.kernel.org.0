Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290DE24E03F
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHUTBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUTBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 15:01:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21AC061573
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:01:38 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a34so1559529ybj.9
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ggiLhmFYac8I9pc9Wcq/Ifd5o6+jwW1+8fQarNQUgzY=;
        b=HsMKOD6iJxF7FlaGD7ecSvkN9bnsNoApRobtseKNNXm1kfp15jxUWvRsBDwYnHQjAV
         V0nuu+OCluAndntlgR/Ji4wl54ImLeFPsDuMWe/5iovgN79FnELIl3iJEEj9r1JdKO89
         N3tpdfVASVxxNujNZ27cRiy8xRZ1PhajLbq2dC8Pk/MjuGD88Rz4g3JbsswfN4hk1b5D
         B44BVtGbyZ9JYV/n38BevxA50Xktsvi9GsaMlfagUCkd/4kyF7JGvtIT53wulOHdiHpK
         UqJZKAAxKOFIDk6/T0bHBtu9VLUX4HKCVdpOpg21Cy6uhXD9hi0K0KvEBGzEKmFGHaY3
         tr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ggiLhmFYac8I9pc9Wcq/Ifd5o6+jwW1+8fQarNQUgzY=;
        b=uOGv+kZxI/ws9z45Gf5GiUN61d/UmI9xEB8etErM6/2L2BJq5G0+bgTubef7ohFGbv
         XX859rFqi46Hxlr/tOQRMw3y8sz9HSYNst74OHZuQN7oMz7PfmIhT4o3BYDnnP1Z+JnQ
         EhXjznsz9soKLPkfbBgAauUD8+ssm809X3NoUf/tsPnSm4YguGNXDQC03T8mE+nLZgHx
         tR1PclXstY4/LIcAv3l8byUsryXSW0QImotYJ7UH5iVvoPuXfbvMhFa01xM6hZlcQcFb
         GwRol2aBIjlyaJl6oXYL5u5qRaucvCd539MRm7TWdqhthrEN1eduZroQWhZyRhZIABSN
         D9JQ==
X-Gm-Message-State: AOAM530aENhA38eNpp3Jg4u+JtY9kSh7JygPqZe28XtYEwrqrpoWWAK/
        IXvF9CfBoSZWe9GzPDVTb2O4cSmR6EwodXOq77fyUIareCU=
X-Google-Smtp-Source: ABdhPJxu8pldJqlFWOgxyIgE8RrLlYpyW6L+uKexgrr8HbQhcB0288LeLVl856pu1ptT/b9polDlsAKcV/alzEars8U=
X-Received: by 2002:a25:84cd:: with SMTP id x13mr5452729ybm.425.1598036495485;
 Fri, 21 Aug 2020 12:01:35 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Aug 2020 12:01:24 -0700
Message-ID: <CAEf4Bza-6HodUqcjv-TSrFejafixSsiBPeM9=0E4ofxZaX3KNg@mail.gmail.com>
Subject: libbpf v0.1.0 released
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just FYI, libbpf v0.1.0 was just officially released. You can see
overview of major new features/APIs/bug fixes at [0]. Please report if
you find any issues with the release. Thank you!

Feel free to subscribe to Github notifications to not miss next releases.

  [0] https://github.com/libbpf/libbpf/releases/tag/v0.1.0

-- Andrii
