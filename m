Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6C15FB5E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2020 01:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBOAP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 19:15:26 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:50575 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOAP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 19:15:26 -0500
Received: by mail-wm1-f54.google.com with SMTP id a5so11707704wmb.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2020 16:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mYoij7/0PpaPJGbReo/cChSNDS2iUj8CyCrcTA9q/QI=;
        b=QbDkJLRKiyG1zmdk1X+IGdDmXMko9Zkd1NZKukdtTB7SJbDY4sFcVJGw8GLpo8WOS3
         yVOZzOgSemuJdvtm3C+J9fVU4HmR4QmvaSr3KtqEuaHQ7qDDndUD+nPYKe42JH+YWzNr
         kYRooWriYYd9N5dHUawsWXCsnZqMpDagxpzf7DKqoaloeVPOMjxDkT77lnx25SC3oD8c
         egkHSEtAQjrfyQ0BlQvveqnr805TJeXitgosjdP7TlJXEGUZ82vaE/lQyLdfWJh+Wt8s
         0mxF6THn+MOurGyZHG6RSgCidjHr2XhGXDRAbe72nT8BmFJDOfQMfDYolEo8CW7WTOWt
         S93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mYoij7/0PpaPJGbReo/cChSNDS2iUj8CyCrcTA9q/QI=;
        b=WpETpKx54rnOZ3YGUDHZcscJujIC9zojNA2163kAYhUz9I3AEhv7ae+3BSttrHOPms
         CjaOR8+Z/G7/aoNOhNjsa+T6pgtKJG3prrV/WvXTEMCbcUARUtzBs4JWEJJsjbduWIAZ
         97ZRZ59kbDKlXEp7IbxmI21dI5af50zUU5xK1LdtWjC3nTWDr7YNVkq6OYiUKVJIeE1E
         e5SHTdHF7U9GwcPF+bwbBeYpKWzH7+m8UxebMALm1cZoNgtb6v0RfvH2+gpap+w2S3d3
         Wr9jR9g6w7RmtAkm0MDs7Bscs63lGNxMqFbrPyykjmf2V1ByIt8+kckzQYk7p27ZQBbS
         h24Q==
X-Gm-Message-State: APjAAAXOK+Q2kt7SzNCU7Bej/G4mhiaq0+d5dmhcStQ90vOdH9/ahYrx
        +l9pft78/VUzCtRxxjCo0EpMb6QXGoO8AqnBywgTdpsR
X-Google-Smtp-Source: APXvYqybHV0v0pxdLQfq4AfU07beMiYZaEQ6XY4Lf5MIt6r5mv2f1jtE1tl4m7XZX2AzM8eyCFdb4EeRoF4H54u08D8=
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr7546420wmf.189.1581725724133;
 Fri, 14 Feb 2020 16:15:24 -0800 (PST)
MIME-Version: 1.0
From:   Joe Stringer <joestringernz@gmail.com>
Date:   Fri, 14 Feb 2020 16:15:13 -0800
Message-ID: <CAOftzPiUcD3mSdM+GhJ3ma0LRmnifEJVK9RfyH_iX+CcdWY2Sw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] BPF: Various topics
To:     bpf@vger.kernel.org
Cc:     lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'd be interested to participate in the BPF track to discuss the
following topics on BPF, motivated from recent experiences in building
Cilium and a Go eBPF library.

* Improving verifier friendliness. Cilium generates complex BPF
programs which can trigger poor verifier behaviour, eg. a program
would be rejected unless we provided a log buffer of 64MB[0]. Would
like to discuss improvements here like allowing the verifier to treat
the user buffer as a ring buffer via opt-in flag, so that users can
bound the verifier log size and capture only the last N relevant bytes
of verification failure.
* Improving the map iteration interactions. During development of
cilium/ebpf go library, we hit issues defining a clean API providing
guarantees around iteration bounding and completeness of dump[1].
These could be improved via kernel extension, such as opt-in ability
to detect when dumping next key leads to iteration reset to beginning
of map. Also interested in potential for kernel assistance on LRU
eviction handling.
* Development of pure-Go eBPF library. Depending on the audience
appetite this could be hallway track but syncing on library status,
next steps, kernel API pain points.
* Any further updates on socket redirection following LPC discussions.
Detail unclear given that this is in flux.
* Future of BPF interaction with other subsystems / unstable BPF
helpers API per recent discussion on the list.[2]

[0] https://github.com/cilium/cilium/issues/9809 ,
https://github.com/cilium/cilium/issues/7770#issuecomment-558343180,
other PRs.
[1] https://github.com/cilium/ebpf/pull/11
[2] https://www.spinics.net/lists/netdev/msg628451.html
