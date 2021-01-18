Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A132FA5D0
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406012AbhARQPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406169AbhARP7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 10:59:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE4C061757
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:07 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u29so8545042wru.6
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tg+3NwgpjPXKCAU0OOKW/4MEsOw9C1yX+SHheX6GzNo=;
        b=OeEk33HaH6Hbiu6I+b1Q7FWYeeSPLEzZbksFKDPfTxJvMz2iziNXp8justgb+/qOO2
         BmCttwyKayBP3uDNYOUfVlj70h4U62BnyWDdecRhbaiNKeULfiq0So6sBAE6CsF/IOtW
         Yy6TW52Hv4v0RnU27FQzOf6ha3Ey7GE/vNnDFqJaPi1WSwUEzdaiRL3OPPHrEqYbLCDN
         VK8ebVEgHFqFH7Evop0hPWI/SmRGX0JcRkqwiX6zWXcPQXSI+/ZvW6zcdlux8HW2w5KZ
         TSdj/4ofx+XLW6B5MF+TKyrhDGKP5C47CVeyVsDxLS9F2b7KXXgQ9l+V6MIxdYtetGu+
         kzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tg+3NwgpjPXKCAU0OOKW/4MEsOw9C1yX+SHheX6GzNo=;
        b=HZgmeI7J1bF6jTiE29F9YlSVcQXDNtCZC+GgpFLMUz4OLSdHICCvLGecfa71UmcTCt
         b/naOokYizSh34fjezKqIP9UqGq0vuHHZaw6r48kWmCp3bh1wTQij33CXcgPuyBs369U
         2/87Wkv/gk0MW1EJ1xhMn/aK7EJhmPJXujb0NJFgoRi8JtT5zkGUuBbaXsguulNm2ild
         no+RlIB4Kal98tG9lyd0Nv0lfd9GEhpK37H/hL/EiIWGMDYPS0f/zHJ4I04LRhmpSaBf
         NxZuGlcOvMD0JwaKXY9BFfghmUmJIQYhFcP63a7zAdDpH8fNnIC7zFAWFro8k+blTske
         RD6w==
X-Gm-Message-State: AOAM533YqjMKMUr1NEOg674DbOjf9wIGFiWaRXnGwClAeHvQfrpMVDoJ
        ietRSbBMvuCnd9Gk7wmjTqKbEJPUdLkTILHeQWk5P/Da450fnm1P63Bhc4jysrEotg9M6n8emiC
        wbnUZfN+gZeiiJdIpsaJ7CKwxJ4oI4S6ZRpe+9BqHLzP/a4pkBLckaymxkwqEwck=
X-Google-Smtp-Source: ABdhPJzdYAbwQUMFF8aREpbLcgNopt2loRgSAlU+AdqVByyRoMPeOOxoouLImEHuyt7wAIwdpW2ivErXPiz1Gg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr54945wms.0.1610985545503; Mon, 18 Jan 2021 07:59:05 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:57:33 +0000
Message-Id: <20210118155735.532663-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v2 0/2] BPF docs fixups
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Difference from v1->v2 [1]:

 * Split into 2 patches

 * Avoided unnecessary ': ::' in .rst source

 * Tweaked wording of the -mcpu=v3 bit a little more

[1] https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t

Brendan Jackman (2):
  docs: bpf: Fixup atomics markup
  docs: bpf: Clarify -mcpu=v3 requirement for atomic ops

 Documentation/networking/filter.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


base-commit: 232164e041e925a920bfd28e63d5233cfad90b73
--
2.30.0.284.gd98b1dd5eaa7-goog

