Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC23026C694
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgIPRzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgIPRyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:41 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1BEC061756
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:54:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 185so9042969oie.11
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXKcSOzjdCK4B5BXlsGD1zCnuPnnE9p46Vcp3HLBmsQ=;
        b=pn+psn9dCToflneQ6lbM+8EvvZepnCVZNcKfTCk+8wASWSCw6Mah7H5rIcv+eviR83
         fwxTrkqzAa6f0W8LGbj2pkIprBlwOPCba/J+iaM2hT7k9B4fNyeDDho9VN/OKkrFKy0r
         87px7QxFRzj0Ss4RhCcz4gfG6rw/izVvmvlsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXKcSOzjdCK4B5BXlsGD1zCnuPnnE9p46Vcp3HLBmsQ=;
        b=sN20valnn8Wf+jo+ocHOcV5dAGwUouYfx5SVe8sVglkQysmsP7yNcDyvj3yXEsnrPc
         +tbejI+8kBIvnhzSgwBRCienR8j62NrIa/ep2ymqknM/xgJRET9JxjR3lLGAhhDFNP1y
         BpoFCV8+AwDwM3vFEnmXmnW0jw8K5fLBsbNoBGnKzCwI7K+MeKQEjIuSPqCRangpx7Hw
         Mvb37ZUMC803D/Nf84XJi56LtC/cduOJl2fBz4xGLj8e96nvyATftAXFNQkfEGB1SWc5
         OSgnNgfDzcAu5HrJZHhoPsib0vtWuGtBjKfDKJJHfPDVAP+MmURGnV2OhjlVvCCcEb8w
         nNHA==
X-Gm-Message-State: AOAM533ooqtMVoH0ND++EbR916CQbQ7umbQCIKa7KGFwJa9RCrBRiyuv
        nhB/ya+/sENY3ku6Fm64YMlpkG2EEKg6EoLJxJd8vL7ZoY8=
X-Google-Smtp-Source: ABdhPJws3N5tY4+UROGrz/m6yY5RbexH3N2HDqNyLnjdKDVrYIn6xxQDhFh+C4XKCHYa8RvGcI9GRonqhUnAGszYhyU=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr4114585oid.110.1600278878000;
 Wed, 16 Sep 2020 10:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200910125631.225188-1-lmb@cloudflare.com> <20200916170052.6gw5md6hwxd6rsce@kafai-mbp>
In-Reply-To: <20200916170052.6gw5md6hwxd6rsce@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 16 Sep 2020 18:54:26 +0100
Message-ID: <CACAyw98Z69nT88mO5=VtTnU34vNXbUWLWJZf3RanEJ4NnaboKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] Make check_func_arg type checks table driven
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Sep 2020 at 18:01, Martin KaFai Lau <kafai@fb.com> wrote:
>
> This set is currently marked as "Changes Requested".  Since there is
> no other comment since then, can you respin v4?

I guess that explains why I was waiting for review :) Thanks for nudging me.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
