Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE272DB942
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 03:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgLPCkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 21:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgLPCkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 21:40:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72670C0613D6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 18:39:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w6so15697417pfu.1
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WihTtWSK13WeM4QZofF23PbvygOEifc1zNH8XBMSO8E=;
        b=QIDYc6LWlNVj0mU6X+o5alLtlkuSq4P0Zxm7bzYXZbu7EiQcQECoU+M0xo2tZoRp1n
         x2oIbKlkiVvQLe3oUqxbk3tjwgZbEAgDULfZJnZxEUZMNBKYlbrCy6TvuHQGutubd8q4
         V/kEIsxBT2tMCJUnd7pHeTIiJpmbPYMWQmyhOr2A+pkLA9cgH1bemkKXTCRbQmltQmVZ
         OpwfhPDT7Y5cwwcUNPqkvfI23HJX40JuPoEA+CMP5RoJl063cFBgYwhasHbqwbQ0Q/tx
         xmo1d/Sq9jzcqpV90P99jufyo7mFmfT8M77dEC9y9bjUPT2jzaLmvAfIvl8Jy6BNLJDD
         5dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WihTtWSK13WeM4QZofF23PbvygOEifc1zNH8XBMSO8E=;
        b=M+z+ogwm4+IZq83Nlm9iO6Ax5+2C2Wj+XWjPhLq9N6Z6hvaByLF6q53lwma3EA1Uq2
         5pr1NghXABOaZYhszX60+3MOgQmvFBEKpUFEe3/94YWsaGMvK2DsbtVVbs650ipE7Qhc
         ZA+u4KDhla3rxxzAcsys8vRgbtj7IbWuzZDvSE+rmucNdEw4QEdlHxUfFZaCVEWXKRfY
         zrNPIyB6HBrYWZN5Hfw3hidPG52uQbarxzMY+/VcNRjFwDK626z93pq9XUtO+sdMQTfA
         Y3KeTXBcubgYbYK+C/vhcDmt51Jh+CeeuJtkei71ttmsL1WYvOfhagiT4Z0IIMWCd5O2
         O3bQ==
X-Gm-Message-State: AOAM5332RMQkvcK/5nACh/Zcu9CRNvkcb5V+NwLlaKxgG94iENlHb/Na
        CfOfRAtwLGD04/YkXF6BLW0OkfteTXedyAVbzhs=
X-Google-Smtp-Source: ABdhPJzWgp98KgLbzSAOmVmiiFERoZbAy9xQb7EW8Py/Kz2VikhxK0K8T18k0/+LPMiv5lv2fesoQLYbxkDIEvwoy40=
X-Received: by 2002:a63:5114:: with SMTP id f20mr29085182pgb.5.1608086377682;
 Tue, 15 Dec 2020 18:39:37 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
 <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com>
 <CAM_iQpX8HU1RPHb+vXRH2qqFLETOJHR91dNxjN-y88v-bcNh+Q@mail.gmail.com> <CAADnVQ+RHnrhTAb84aEoqpjy-ez5Hdr5BwroNskj7AfVS7v6Kg@mail.gmail.com>
In-Reply-To: <CAADnVQ+RHnrhTAb84aEoqpjy-ez5Hdr5BwroNskj7AfVS7v6Kg@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 15 Dec 2020 18:39:26 -0800
Message-ID: <CAM_iQpWb_rHVdxT1H-TwE5Tp=w_G-ZYaG5Ynb4FtJ_79J1La0g@mail.gmail.com>
Subject: Re: Why n_buckets is at least max_entries?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 6:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 5:55 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 5:45 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Any reason why we allocate at least max_entries of buckets of a hash map?
> > > >
> > > >  466
> > > >  467         /* hash table size must be power of 2 */
> > > >  468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
> > >
> > > because hashmap performance matters a lot.
> >
> > Unless you believe hash is perfect, there is always conflict no matter
> > how many buckets we have.
> >
> > Other hashmap implementations also care about performance, but none
> > of them allocates the number of buckets in this aggressive way. In some
> > particular cases, for instance max_entries=1025, we end up having almost
> > buckets twice of max_entries.
>
> Do you have any numbers to prove that max_entries > 1024 with n_buckets == 1024
> would still provide the same level of performance?

No, I assume you had when you added this implementation?

Also, it depends on what performance you are talking about too, the
lookup path is lockless so has nothing to do with the number of buckets.

The update path does content for bucket locks, but it is arguably the
slow path.

Thanks.
