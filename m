Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E31B114D
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfILOmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 10:42:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42239 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfILOmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 10:42:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so4695798lfg.9;
        Thu, 12 Sep 2019 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YVmroOmWsfbPZww9PGat/bavCeNmvQGcimrBhWBuy4=;
        b=K76FKy6ESnqOvkBCMCo6qwFBykl2HdgaTHRY3YvD94OEdMgn9uYrY/t3Kmifp0e0uD
         LKnNGAwBNrnpdLtTq9Y4/2qsIRatfXp4eGFn0qSiJZTHqhBN8a91HDkxHp/U7w44lQq9
         v1ggR0KcIzhSI+0MbaLJSfH2FWbpjSsGKPCyd2dAWcg9hKLHNSh5LIzcI74Gjc+/Ldyq
         saKzYeh0F20mLAZa06YrBLvngFBnrnuKNU7eq7UERSVLSk9yPQ6sz5lNpPe55yuHx61l
         ffgqplJqtREYfZa6YR5FZdkdKY3CFo9akYzMw+XUp0ASe2YSHqJL0Hitx9EuJrKhvtlr
         reVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YVmroOmWsfbPZww9PGat/bavCeNmvQGcimrBhWBuy4=;
        b=ajCnJFG6BI41+o0Sah45WeOUdfdE+OCf/md55NYgVWKtp84bUH+tD9891+tpyOG5UF
         Pk/Qr+8vkNnvCvk8YJQuSPJ7levB1HQmidBHjccYJRJxNfzDDomM1ino8QCcp7bTjGNv
         DRdWts4kMER55TOOY57iNHpMagXdmtslOI1ky9k87rZZuLn7ICFyN4gNUIU8zhV9zEgB
         Wu0i9eqNtPc4bddK0cTpVdp7/beum5eq0u8fp7b9Si04tjQfBGmrr+3vwQjNDx4517rW
         PvC/SS+d7HKtbGwpE6/B9k/dLyqQjgLfhJ2zv6lr89QfPk6/K2M3KuWlpnvuFReyJi6D
         J3OA==
X-Gm-Message-State: APjAAAV5iivRuCmn3mtJtQKvjiL92cDLb1gYSWqVhU1r0YlOXDmgnLcr
        IB230W1hum9hkBtFAKzHrC6YGIt0N3LxeRB+RRFqZa9J
X-Google-Smtp-Source: APXvYqy5v3NkZEjEMM7AwjSVopo8j9FGoJxzUq1NdqYhh5e1x0kmCJH4LPdki4NmHpjeLat+4zGNy30KUDyElmgw5l0=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr2286425lfl.131.1568299334764;
 Thu, 12 Sep 2019 07:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com> <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
In-Reply-To: <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Sep 2019 16:42:03 +0200
Message-ID: <CANiq72ntjDRyMBdVXLMV9h=3_jU47UA06LaGvR2Jw9aMZM3V3w@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Joe Perches <joe@perches.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 12, 2019 at 12:18 PM Joe Perches <joe@perches.com> wrote:
>
> I don't think that's close to true yet for clang-format.

I don't expect clang-format to match perfectly our current code style.

However, if core maintainers agree that it is "close enough now"
(specially with newer LLVMs, like 9), then there is a great benefit on
moving to automatically-styled code. The "con" is having to change a
bit our style wherever clang-format does not support exactly our
current style.

> For instance: clang-format does not do anything with
> missing braces, or coalescing multi-part strings,
> or any number of other nominal coding style defects
> like all the for_each macros, aligning or not aligning
> columnar contents appropriately, etc...

Some of these may or may not be fixable tweaking the options. Note
that there are conflicting styles within the kernel at the moment,
e.g. how to indent arguments to function calls. Therefore, some of the
differences do not apply as soon as we decide on a given style.

Furthermore, with automatic formatting we have also the chance to
review some options that we couldn't easily change before.

> clang-format as yet has no taste.
>
> I believe it'll take a lot of work to improve it to a point
> where its formatting is acceptable and appropriate.
>
> An AI rather than a table based system like clang-format is
> more likely to be a real solution, but training that AI
> isn't a thing that I want to do.

I don't think we need taste (or AI-like solutions), because
consistency has a lot of value too. Not just for our brains, but for
patches as well.

Note that clang-format is a tool used by major projects successfully,
it is not like we are experimenting too much here :-)

Cheers,
Miguel
