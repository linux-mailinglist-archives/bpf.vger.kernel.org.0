Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597681B940D
	for <lists+bpf@lfdr.de>; Sun, 26 Apr 2020 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZUyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Apr 2020 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgDZUyX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 26 Apr 2020 16:54:23 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7BC061A0F
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2020 13:54:22 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a7so7407023uak.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2020 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHvmvK16dxVZw6xg1c1UR5rBSf+5kVr8sJmjd9CEFaU=;
        b=g0iikt3mYmux7IwGv0TbadGw9Y6+jimMW6kFslUPJHz8ZfEaKjbAX7MM1TWAc2g19A
         jQq52LSsRFkDtP6uKd4Eh2cx49hDiAWC91zEK4xe91a0COcvxakOvJlG1VQWhfIQ3hhz
         cJlf0HElpFA5laQ8feNVA6pkJ6qgJHMDxwcDlISx3Fq3peJ+lRJVcVg3keI3dQastsKz
         vfcfwAyIDydBtZy8Kab7hMSKOoxiVgw/RUo6X1y/Dh/1wc9+pEpunq7E9EEKcqO7EhMB
         hvdvOb2Zuib6JqHtZgs8rWWahgIXvJtlcOhgn/xiQRzUrOHDUJeJd3bg4l+shdiA5Grw
         FOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHvmvK16dxVZw6xg1c1UR5rBSf+5kVr8sJmjd9CEFaU=;
        b=YTEggkAHFsotQsAXnz1Xpq3oye1yJiXTZVnOv+54WZz+qwrQyvZNPhi8GwyYiQVy3E
         bXrJaQDbv+LtEARmR5p5ULgDU/if9U1Kwp3lxsWXrJOJHp/sNTNuwdnQA9mydLlh22Ip
         p6X/59uz6kmQMs5cp/oSNcl9nt5qXibw+Ahw7yVCDKUErGoFELqpk+lrqIpQdhd1x3N+
         Tfe4zBqOYA3vv/YyEWht+b5H01sew0sggqc4IW3CmK2Xv/FIFzFU5UuPCS77sOb4+G5E
         MC0KpnbTxZSO4nXUMkQONjCm2pXboQVjgqMm5NR+4ue94Z4oIwA2C579oBtkbsntW684
         SKVQ==
X-Gm-Message-State: AGi0PuZmePcBCxKLPtEsRdhyN4YuDuHysQmHms5z4Ad886E1LbLoqF4K
        +hLJx1bWz550hCBl4V3OXXfswRYB+tMpfWtfLhJS2A==
X-Google-Smtp-Source: APiQypId8CuX+BVlYDBqShj5QXvD9DNxkAFHvl3ApU8OQndR7n1PGxIP4ZPoBVcEBdDymek/PW1GiZK5okEd6QgjhJA=
X-Received: by 2002:a67:f254:: with SMTP id y20mr15058958vsm.177.1587934461499;
 Sun, 26 Apr 2020 13:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200420202643.87198-1-zenczykowski@gmail.com>
 <20200426163125.rnxwntthcrx5qejf@ast-mbp> <CAADnVQ+FM2Rb2uHPMjXnSGmQo2WMfV7f_sikADHPhnHMq0aK9w@mail.gmail.com>
In-Reply-To: <CAADnVQ+FM2Rb2uHPMjXnSGmQo2WMfV7f_sikADHPhnHMq0aK9w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Sun, 26 Apr 2020 13:54:09 -0700
Message-ID: <CANP3RGexEgmeGHab5d0pP2QsR8yVqQ+kBi=2FW1rd2CtafyJUw@mail.gmail.com>
Subject: Re: [PATCH] net: bpf: add bpf_ktime_get_boot_ns()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > I fixed it up and applied. Thanks
> >
> > In the future please cc bpf@vger for all bpf related patches.

Will do so.

> The order of comments for bpf_ktime_get_boot_ns
> was also incorrect.
> Most selftests were broken.
> I fixed it up as well.

Thank you.
