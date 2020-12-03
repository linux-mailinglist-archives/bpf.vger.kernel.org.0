Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79C2CDDE6
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 19:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgLCSls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 13:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLCSls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 13:41:48 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E4C061A4E;
        Thu,  3 Dec 2020 10:41:08 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so1630701pjg.1;
        Thu, 03 Dec 2020 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iEmWoJviDlBg7vyvlF517uVadCNS9unCFDqTlvcgcyc=;
        b=AQXx2qWCfdI208jTlT7ebN78buAHzKseunYOS/GGuWnblfW0ncZ6LapDl3zFAw25uY
         irvQFebGMQ1c0EHHHBOut9okTgLnXGn2G2o9R9N+slTRHGkDOMohrILUcBUDDW6pdgFE
         wiQEfJ7QIBSZgkKjNmQEFo8xVbWtXiWHB2Fv1+bRfgEb1fyeEGvsNJS5FdPtW6gicvNU
         PLpq5tHX65hRtu4xSHAYYti8q3JGDAZnVn4Qzy57VppnbkotzLLHaOlq7Jdf+aBdrpf3
         KyxS6rAQl+tJad7MKSwmdB6Oy/VDel7MJYiF0TBNYDsK+4/xuZoHdVSHMmMK2kHlTA6T
         aRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iEmWoJviDlBg7vyvlF517uVadCNS9unCFDqTlvcgcyc=;
        b=L7q856WE9UHbOpJh7nSqZeJuhbMt1QXJhJ01wZFI45nJjKc5BGDkryJJCWoOiOHf6z
         sm0RnnTYmZfxRphxSRHBh2MXOU8FSWhLn7wxHogv6/C4SS7JdLE+ZjRhG66ZVooiocML
         m+4ccXCQd3WIhDPzgKFFizK+midW/RXgm/2frxU2+F3ilmDx2+5Xudr5Is8Bxl8ttW8P
         bpRdCMnTuE5+IJL+SLTseTegL5Unc2aq+5+V5IoGgSWinVobEivnL8hKiOM1L+P977YY
         aH5ljBRakRSjnnpD97qKtuHUb+DkXVhUm2WhJ28EuGqUHHvz/ChLTpI5TeEQ9cz2N/0n
         JLUQ==
X-Gm-Message-State: AOAM530HdToP1ma4oSN4+tb99O95/igpMt3jdPE9Kp87PFvWim/oxWwt
        ClJcUcCpq+CIrp8NLfbLbfk=
X-Google-Smtp-Source: ABdhPJwYo3X+uDI46Nge7gI5/pPBTz6brF/lAfkqk/r6xofqwNk5CFFOy2CG1uBU41nqADrD+44MjA==
X-Received: by 2002:a17:902:b90b:b029:da:97e2:722d with SMTP id bf11-20020a170902b90bb02900da97e2722dmr482296plb.3.1607020867749;
        Thu, 03 Dec 2020 10:41:07 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:a629])
        by smtp.gmail.com with ESMTPSA id az19sm128457pjb.24.2020.12.03.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:41:06 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:41:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Fix some error messages
Message-ID: <20201203184105.5i4plhakwllywkb2@ast-mbp>
References: <20201203102234.648540-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203102234.648540-1-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 10:22:34AM +0000, Brendan Jackman wrote:
> Add missing newlines and fix polarity of strerror argument.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Applied, Thanks
