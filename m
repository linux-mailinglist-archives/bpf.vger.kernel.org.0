Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5B149667
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAYPrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 10:47:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44739 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYPrq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 10:47:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so5231462qkb.11;
        Sat, 25 Jan 2020 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGDKkzK7pZH1PmjbRgCXBtXFFSFzoo8Sm5ticdUWb/Y=;
        b=Ek6lLXLjzoJfwVim+l+BqHvXuPHoK0JuIYZ6CkmXG2gKo6+otdKOBuFOWaNi8D29vO
         cW/Ygi98XEOGQeQTYEtDhYpvaa/4E7oDlvFmrVAlhhr8s2ugd40EcBUsrJl4Pl9bnoSJ
         hQS3tdCZNfcbYkoHi3IPR4hO8Df1nPMBLDmwWHQxgNwECLxsDqWKlSp/dw8REerlbCGn
         BhbBaciLwhr0NmN0gsCQvs892OlrfkSXhgF33iNVy46f4SWZ2rhTP5C/7DaxRiEINnOo
         Pq2eiaQabZCp7bjqPQ9MY2pS7gyW8h/R5htaTSxAlMyBco52cPKQopjfQz6lUF4eKFhY
         rLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGDKkzK7pZH1PmjbRgCXBtXFFSFzoo8Sm5ticdUWb/Y=;
        b=kqMTeX9IN2DBmmqmwzyhqk3sfBXSc5I0jSi6WMqyc36R7A1Q8AbaZl7roP+QTduiJr
         BD6yeTWr8cSjmtFUxQ6fCeeB5D+U7bXBE8T/MVQRv3Lblt36RMWTfA2H9guJRq+dNMcC
         AD/lsXmI0Eq7SIE4sgV8aVNaowgINVqvV0rwdRlD0fojd8uk50ysk1Y31K1l1l/RHc/b
         p4UaiKKbpOqnwyLxZFNNsBIZmYqW/bTF+pvWGFuWULTdwA+SxZFHml5d7W/2rFTKs8Qq
         Yq7TTOMf6pNuqRcvZOB/SR7wtlrQwQqfbrLnsoP16P0BtZ3/F18xe2iWEcb57FgNeNMm
         RUMw==
X-Gm-Message-State: APjAAAWCc+m1hm7vG1y/pOOE/iNjgOYR+D2tz7FX4x5bHqRG1q5WhrfO
        izbkipcT1nVU4/lCLFn+epI=
X-Google-Smtp-Source: APXvYqxe40f442y6Yy/twjmskp3nwtpwelm7ROmTKIylcz9quGK4E33pHF6O79B21/VjpmUC/RGU+A==
X-Received: by 2002:a05:620a:1333:: with SMTP id p19mr8556368qkj.73.1579967265411;
        Sat, 25 Jan 2020 07:47:45 -0800 (PST)
Received: from ast-mbp ([2620:10d:c091:480::c331])
        by smtp.gmail.com with ESMTPSA id 13sm5305093qke.85.2020.01.25.07.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 07:47:44 -0800 (PST)
Date:   Sat, 25 Jan 2020 07:47:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Subject: Re: [PATCH v4 bpf-next 2/3] tools/bpf: Sync uapi header bpf.h
Message-ID: <20200125154739.jfsl4cubpkpciq56@ast-mbp>
References: <20200124211705.24759-1-dxu@dxuuu.xyz>
 <20200124211705.24759-3-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124211705.24759-3-dxu@dxuuu.xyz>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 01:17:04PM -0800, Daniel Xu wrote:
> Sync the header file in a separate commit to help with external sync.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/include/uapi/linux/bpf.h | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

fyi we don't have to split tools/ update into separate patch.
Feel free to squash into patch 3 or keep it as-is.
