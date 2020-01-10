Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946F5136F36
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgAJOWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 09:22:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727892AbgAJOWG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jan 2020 09:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578666126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=urCySf6YJf1J9Csu+0Hzz1tqBGlCmgSRwy2bLWcog7c=;
        b=DqMZ4tZ0gojddaeP0oXo7uJ0APWNSiT53QlBWrsBhxNWrDOf9v1iFu9cteYIAsDmrh/yXx
        rRGfbhgc6/V64q2BNySBgGC0Vj6eZDNj5oUlUbCPBOUmC7BHEwQLVOYbU47gNDZa8eFjvA
        4FwjYI+/OKxhYXcWvUkmDVgB17txSwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-0Hgwd9fCPUyX_J_9r9xElQ-1; Fri, 10 Jan 2020 09:22:05 -0500
X-MC-Unique: 0Hgwd9fCPUyX_J_9r9xElQ-1
Received: by mail-wm1-f69.google.com with SMTP id m133so452753wmf.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 06:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=urCySf6YJf1J9Csu+0Hzz1tqBGlCmgSRwy2bLWcog7c=;
        b=p/VpES2wotEx+rdWbRWBJ+ByC9Ppxu7rCyyh78xf18HjLeAVA5A8N7IoLFIUyMuO2U
         snFrJ4OwPmlG6uWWbBl0Isln5mY39tJpbppOiaZhTYQEPbus9r8O0jwUWBA9LhQl2+Rk
         nFzgkY9gubi4bqs9qIMWPVVFlADFTbWjpUyOUQ9y+KCYWXmVUruXhOjNK/mK5rE1lnqr
         RlKVKooV8haHroLh7DuVO36Perb+dR/TKgf9ct/yBcslq8TJL7GhuKwtooPUPxLwuhFm
         uXRnuSzPO8iSsu6HUiw9li3ZelQe4GpmyleDlC2PTfJAC/f4yHAhCdouovqE42DIlyO5
         WA6A==
X-Gm-Message-State: APjAAAU56iZPMOjZ9mLeEI98l+81cDS0EDHXha8b4RvWSJ3S41NwRSiv
        ZMEiqXdJ36/5laZBfKOsCrjo6SKG7FWtxPX5YFOwEX55FQirGOpVpxF8SH4Wf16FXXLizMBH1bl
        wtm777nisWfQl
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr4579702wma.139.1578666123398;
        Fri, 10 Jan 2020 06:22:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLphwQkpFNg2pP4KHeQMUQxuiPSTpCDOnjM7qg89kY/fmKHYQ2Dgd8WmM647a7+2pLgmse2Q==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr4579689wma.139.1578666123225;
        Fri, 10 Jan 2020 06:22:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e18sm2309005wrw.70.2020.01.10.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:22:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D3743180099; Fri, 10 Jan 2020 15:22:01 +0100 (CET)
Subject: [PATCH bpf-next 0/2] xdp: Introduce bulking for non-map XDP_REDIRECT
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Date:   Fri, 10 Jan 2020 15:22:01 +0100
Message-ID: <157866612174.432695.5077671447287539053.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 96360004b862 ("xdp: Make devmap flush_list common for all map
instances"), devmap flushing is a global operation instead of tied to a
particular map. This means that with a bit of refactoring, we can finally fix
the performance delta between the bpf_redirect_map() and bpf_redirect() helper
functions, by introducing bulking for the latter as well.

This series makes this change by moving the data structure used for the bulking
into struct net_device itself, so we can access it even when there is not
devmap. Once this is done, moving the bpf_redirect() helper to use the bulking
mechanism becomes quite trivial, and brings bpf_redirect() up to the same as
bpf_redirect_map():

                  Before:   After:
bpf_redirect_map: 8.4 Mpps  8.4 Mpps  (no change)
bpf_redirect:     5.0 Mpps  8.4 Mpps  (+68%)

After this patch series, the only semantics different between the two variants
of the bpf() helper (apart from the absence of a map argument, obviously) is
that the _map() variant will return an error if passed an invalid map index,
whereas the bpf_redirect() helper will succeed, but drop packets on
xdp_do_redirect(). This is because the helper has no reference to the calling
netdev, so unfortunately we can't do the ifindex lookup directly in the helper.

---

Toke Høiland-Jørgensen (2):
      xdp: Move devmap bulk queue into struct net_device
      xdp: Use bulking for non-map XDP_REDIRECT


 include/linux/bpf.h        |   13 +++++-
 include/linux/netdevice.h  |    3 +
 include/trace/events/xdp.h |    2 -
 kernel/bpf/devmap.c        |   92 ++++++++++++++++++++++----------------------
 net/core/dev.c             |    2 +
 net/core/filter.c          |   30 +-------------
 6 files changed, 66 insertions(+), 76 deletions(-)

