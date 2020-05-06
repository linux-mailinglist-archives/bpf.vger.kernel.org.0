Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11C1C763C
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEFQ2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729907AbgEFQ2G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 12:28:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB96C061A10
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 09:28:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f56so2974763qte.18
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=coxNnLbWPC326Mrpkn1JFdCLcBMx+ouIrI1YVFoqF0c=;
        b=a0GWbpNkcFlthlZUKxsEQ1fcB/kr//t8djblSVGO9rJW87DWdb2tmaYucPNPbUyRe+
         XgGJiJ+1fYY6UyN1VO7lI0lLKJoWyejwTkvEgpU7XlZ5vJCrqrz5WZfgOxirEBCsm2ff
         GvBKTir9SG380Tu+EG0SSdEjtQgsaI+loKANCwUwM7LmMD+v94XuJqwQZbTxrrEPCwMk
         T57f+thr5vlDoo4o95OVTXVsL0EXFSTGmL3KfgnBiiMA2Pm0nK2dWLD4Gf5UAt0qOeO5
         BqGWqdXqL3emJNYpkhOwuRGnKqGuOoIVxVKXE9D1shd7vgolmQiU0eW3zhblpeV+Ef22
         YlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=coxNnLbWPC326Mrpkn1JFdCLcBMx+ouIrI1YVFoqF0c=;
        b=egYMj317Vtl1XbGw8dNWiGm/TqOH+bEAe3q6F0EjamXWktts4w3vDZrXUkN7k9nbvL
         uaHXpOfh4uqgbxGhL6siml5EHPpB7hPxFvufw44PSnXaHy9M1I+cIwyzZRD2Gk2s9wtZ
         v2PMh2OS2g4MmqVq0k+S3IE987YhvmJcBLKn7KA0JeSU2EgRNoerDoCulgsFfXY77dD6
         VaHIrWeLCtmdWIBBJ8g68hhBdcnR7o40RCmkPYC9NQ5ap4eU7m6/L40KYtE4TTselt/B
         bc5z6aASEVvqUXqXK2KEQv2a4TBF7wZyVzZPs2Mhu8MgGwHSGbn1Y7Ir0VCLw/oXXaVO
         /jLg==
X-Gm-Message-State: AGi0PuaWF5U6+IfKgm1eIUoKgO/u4keDq8+sMqgKdf8Wr7+Z0LvsENhZ
        mcBuC2caPZIK2s2qq3D554+C9JA=
X-Google-Smtp-Source: APiQypJT2E7PiYaQxXqTvwXVfsxw+IiDVCw46UHt19BGqYT09z03mctdfjmXPlYQwV31hiMGSV+TH3U=
X-Received: by 2002:a0c:b604:: with SMTP id f4mr8783396qve.40.1588782484152;
 Wed, 06 May 2020 09:28:04 -0700 (PDT)
Date:   Wed, 6 May 2020 09:28:02 -0700
In-Reply-To: <20200506070025.kidlrs7ngtaue2nu@kafai-mbp>
Message-Id: <20200506162802.GH241848@google.com>
Mime-Version: 1.0
References: <20200505202730.70489-1-sdf@google.com> <20200505202730.70489-2-sdf@google.com>
 <20200506070025.kidlrs7ngtaue2nu@kafai-mbp>
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: generalize helpers to
 control background listener
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/06, Martin KaFai Lau wrote:
> On Tue, May 05, 2020 at 01:27:26PM -0700, Stanislav Fomichev wrote:
> > Move the following routines that let us start a background listener
> > thread and connect to a server by fd to the test_prog:
> > * start_server_thread - start background INADDR_ANY thread
> > * stop_server_thread - stop the thread
> > * connect_to_fd - connect to the server identified by fd
> >
> > These will be used in the next commit.
> The refactoring itself looks fine.

> If I read it correctly, it is a simple connect() test.
> I am not sure a thread is even needed.  accept() is also unnecessary.
> Can all be done in one thread?
I'm looking at the socket address after connection is established (to
verify that the port is the one we were supposed to be using), so
I fail to understand how accept() is unnecessary. Care to clarify?

I thought about doing a "listen() > non-blocking connect() > accept()"
in a single thread instead of background thread, but then decided that
it's better to reuse existing helpers and do proper connection instead
of writing all this new code.
