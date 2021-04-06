Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0B35583F
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhDFPix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhDFPiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 11:38:52 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074A6C061756
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 08:38:43 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d10so13469669ils.5
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEi9pkoyq0DRGmPdjuw9UVMkgpOddRxRIDpF7zpDfNM=;
        b=V8KKchNyj4AhE6nnF7/d2L6cVqqbVOM8Tle3VwM0W5rN2GBBB/S/1hnfwOZ3uUAK26
         8BriLy45W4wsntUZainZBukhOTz5ZUS8rhLesR80oJVp/7cpZeSw4huXuY3CRh9MZH3r
         B7OMUnNSox3cOoktdiGr3JKWineXWoGIth4UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEi9pkoyq0DRGmPdjuw9UVMkgpOddRxRIDpF7zpDfNM=;
        b=krCXxpPk+HMz9LYe8Gy9OrNS6EYUIUmyLL7jTSryxMxE1WdTlIKpsSCAkuzCRsLnMx
         ybQGA+z7jTXMd8VDWFpZrP/17QEV9qzYrN13etthcPRYcCoCn4ZudC8DGtwpbNV7MEdB
         6Z2ZCF5P8o6Cqg8lEI7+w/1IPN2EJY/l/BNiryzV/DKLjoL49mSb+CqlaENejXyQZTdp
         25eRtGU1Zq9ZfuyddMI2MlDS+JnOJhCYTUJzxwP5oDR3cILjWRctO6Ko5Hn5WeuoqMdd
         ziyxfoMT35F1fHocfxy91uZV8po84l0g6u1QboQT8MTsP2QCGipE66VIY4r7rJEwc0bu
         6bww==
X-Gm-Message-State: AOAM530UQUPMsTBbDhmGQxYZk/9xNlVtwxFOUoQu/qs8Gqb0jxMHRXl+
        0k1HSHN2TX4a+wvVexytx5qCeSmG+0oh8H5DZS/M1w==
X-Google-Smtp-Source: ABdhPJyuasAPHEnCviV1xX228L2aM9NIfQOvh6+nAE2oLo6llEE5yNzoE8dG1l35F+PCj4k7WUbbT8HhrvNHRCuHmp0=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr9629827ilq.42.1617723522485;
 Tue, 06 Apr 2021 08:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-3-revest@chromium.org>
 <CAEf4BzZEgHyodDqj7exrEo+eBOzHEnsvkc003vxq3dcRVZXE2A@mail.gmail.com>
In-Reply-To: <CAEf4BzZEgHyodDqj7exrEo+eBOzHEnsvkc003vxq3dcRVZXE2A@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:38:31 +0200
Message-ID: <CABRcYmKUQcRjQhLgpM6pb4oMWCB2=ov8iL1prxn3B54Or=aC=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 11:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > +
> > +               map_off = reg->off + reg->var_off.value;
> > +               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > +               if (err)
> > +                       return err;
> > +
> > +               str_ptr = (char *)(long)(map_addr);
> > +               if (!strnchr(str_ptr + map_off,
> > +                            map->value_size - reg->off - map_off, 0))
>
> you are double subtracting reg->off here. isn't map->value_size -
> map_off what you want?

Good catch!

> > +                       verbose(env, "string is not zero-terminated\n");
>
> I'd prefer `return -EINVAL;`, but at least set err, otherwise what's the point?

Ah yeah, absolutely.
