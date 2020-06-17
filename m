Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498C1FC5DF
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQF4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgFQF4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 01:56:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BAC061573
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 22:56:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s18so1441711ioe.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BatxUGW26zyjldygz4MJ73W8gOjgWpvH5rQXjqft+nk=;
        b=OFbAzYJJowAki63zSq+ReV//urhYbTd5lVEdQ0dTszHlb/No4QahMGWQ/ORC/DyLb6
         YcKT9aWV6PiPtDIpGf6THmR22MSzh57iap+ZifEv6TYUcKvxmF5JzfhXK6n0xIVAxnge
         A1xXJ0NMBCw2Lhkuf02CYph0BAnczLohVQLcWxI2CvLeeYsOyRyxD8V1tn6mWibbaFMj
         pNL8ZDWtLxeD7EynA50yrvr6dnqkaN9Y1X72OwE5HkU/2Io/MDYSBobUq3NeGxmsjdo8
         YUAhxp32sQM0ZzTxQJ1W55O/vdIocZYn1Tp4Pg2prIQ7qBQcQ1ds13PRfvrJ/s/iFpGs
         97cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BatxUGW26zyjldygz4MJ73W8gOjgWpvH5rQXjqft+nk=;
        b=eWhjAaN863t6ZTKhOHX11jLJXowNJjoMKIEmd2sGEncRil3yO5pQNBYfVzmLIX3vgs
         n8t9S2QEN+tIFiQqWzfq9eZATDGRQWCD5U77MQaeq8sm5Tl9bp60tWDrN/KScxNEdXZK
         LayVGJEFMY7/T7k47d5HGVVl8ecm9XsX24PB163GyrBJ6UiBMFHjoThQFiCXPORXZOtj
         SX6RjFtxMo3qtqPkq2CW3KC4oOPt9gM2eMrTpWmnt77SPXAvasCeXA5eETwukmG/BDZy
         PX4iV1/phMLrzTi3JGwSd+zoGPULP2596Tf80/1iuWcZneWrUfJuz6nshs7PppQZuKHZ
         8urA==
X-Gm-Message-State: AOAM531GcCmF5p/HgHBOUrjq1FoF1qEDw7mOl4dTI4cjzTeaTfMRn6PZ
        +QpQsb6b/ap+ETvvysezf7w=
X-Google-Smtp-Source: ABdhPJzGNrMvTR5tPNSbmsOgm27rhPBF/OLO9TOzSpWD0/HZl6XkUvUWCOpt5CfQGVyBdOrvravZDg==
X-Received: by 2002:a02:1443:: with SMTP id 64mr29224239jag.43.1592373400461;
        Tue, 16 Jun 2020 22:56:40 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id f5sm10827513iog.49.2020.06.16.22.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 22:56:39 -0700 (PDT)
Date:   Tue, 16 Jun 2020 22:56:31 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Message-ID: <5ee9b08f486cc_1d4a2af9b18625c4b7@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzaHy9t473htHUv5znxZRMieN3ECk5Jx4O9ZX3A47ONA-Q@mail.gmail.com>
References: <20200616113303.8123-1-tklauser@distanz.ch>
 <CAEf4BzaHy9t473htHUv5znxZRMieN3ECk5Jx4O9ZX3A47ONA-Q@mail.gmail.com>
Subject: Re: [PATCH bpf] tools, bpftool: Add ringbuf map type to map command
 docs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Tue, Jun 16, 2020 at 4:34 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > Commit c34a06c56df7 ("tools/bpftool: Add ringbuf map to a list of known
> > map types") added the symbolic "ringbuf" name. Document it in the bpftool
> > map command docs and usage as well.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> Thanks!
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> >  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
> >  tools/bpf/bpftool/map.c                         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> 
> [...]


