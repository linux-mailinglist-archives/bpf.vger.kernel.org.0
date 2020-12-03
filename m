Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB402CE294
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 00:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLCXVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 18:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgLCXVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 18:21:41 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB34C061A4F;
        Thu,  3 Dec 2020 15:20:55 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id t33so3684733ybd.0;
        Thu, 03 Dec 2020 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25ITGgyLfT0wP7ZTh/QW9d2jn5Se8Cwy9183U4JoZJQ=;
        b=AaUkMqufdPNFLW9ku3F5XALkmjNGlhlKGQD9ioMknniYi+cCLa1/jLxHPmsqw2z+hO
         dDSCp/aapjGrX0aPndPMnr6vxjfCI4w6CCJ1Ym0gqZjxuYLx9xcoIzCf1EZMi/mcbSaj
         XLDb85//H8pz4MHbmEmqrmLd/cw/wEG/vKeVJdOfKosS/L1rNGZCHtmqj9aYjcvy/Se3
         pTR2PYwK6wlLNVHLRYjRXgiQFqzIBdh6JeZ2pvzOT04A+bH4/B3D2Tqqzl9qY3Y8kBAm
         zoS4exImWeQ6nQLJJtanaQbdp5Di/tunwLkp9sJyf/xptLqrbl74wo/ubJ6ppbYgqdQc
         xHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25ITGgyLfT0wP7ZTh/QW9d2jn5Se8Cwy9183U4JoZJQ=;
        b=DyKfnCKpLln++M431mkqI70VJBRkFlKinb/2qaTLMafMMFovEULWWWM7N/DRaTSefO
         U4LldIzXfWXx8OJuv8mQ3rs6oB2KijanFnRrbbUPcBVOtIZqoX2unVcpp1gC6VK1zmFD
         d4Jlu4rhn7oPgfUwR0Dqdw7grxIzt34JkK/42s6g6AlFQclX1OzIxuL1Z/KKkKtxK7Yg
         6GF+Vhmmm7BvTGQvqXt+Ry9VJdtHG8wPat53peyzEcabKWc27FwBUL4CK+3Ubd1fGZu0
         gdtW1+0nkt+LvCXIHMzoOQX+MiNRNQJH/eY0G/S9wTIGYekjf8RH2zmmYBUUIw10X8/7
         ICJw==
X-Gm-Message-State: AOAM532wGeRMtmIZY3ItRaRF5AJsZ/B2b/8wY6ezezlB8Ihkgbrr9r+N
        jnJv3Xh8CLKL3fyn5j9HL7HMWtfitdgtDTnyYgY=
X-Google-Smtp-Source: ABdhPJwcJWEbd4UCWeuU27I30FCpJvL5pF/5D+cU1dGpwlUEEADsj6ltfmrqZGg1VKY59d8tiDGwzRCSUrfVyzjYCL4=
X-Received: by 2002:a25:c089:: with SMTP id c131mr2163792ybf.510.1607037654835;
 Thu, 03 Dec 2020 15:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20201203220625.3704363-1-jolsa@kernel.org> <20201203220625.3704363-2-jolsa@kernel.org>
In-Reply-To: <20201203220625.3704363-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 15:20:44 -0800
Message-ID: <CAEf4BzZ+eS=roOdzo0MP=2f2aDVNC=OYz8nHRjA7-Fv8wmQ8GQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] btf_encoder: Factor filter_functions function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 2:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Reorder the filter_functions function so we can add
> processing of kernel modules in following patch.
>
> There's no functional change intended.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 61 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
>

[...]
