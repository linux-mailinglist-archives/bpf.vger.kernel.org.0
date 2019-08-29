Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E64A12C1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfH2HoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 03:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfH2HoV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 03:44:21 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E345C04959E
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 07:44:21 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id i10so1589019edv.14
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 00:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=syJ1qgGbb2nyLjAQ0BdovjtQf9fJ98FvbZ0asS0WfAc=;
        b=ViBXc1P3zw1++UMk7qf8ACku0yoT+cewvznJ6Qp7sahA8ayJIwZ55b2zh/9q1ErifL
         xo8kFakECG/vRJxDwlYlbEjG0gAO6WtHcASq9KC9MRIbXiu99OeckvAqStzTiq8Qc3LP
         yuKfzONC38BTZx5OvhPII+iSX00imNwNong67SYiefrCM1tkoOf4z6sldkbhoWtEt25S
         xTbzXF+RzZu3v0W0wsRkLNs5WVVFMqPNjkwrHtrItppqsW+CjWsDDY9l3LwnD4LR0Zeb
         SpnSx5Hg2q/xcyxJbqSUz5NYSrtBmlFLt6NhILNufsFI9tqths1z9dDiZsS4XYfpsY14
         9wWA==
X-Gm-Message-State: APjAAAUELmIcl/08twa6Sb4HAgqw6IpBNb2ANkdgw/2SAMDdQ434hsKl
        BZ5opMuFLsg24LRtADwAz+eOuC1Z+yOG35jcLnaL+Nyzbg8GKPkA4jRFJTuWP9Jzbu9ZxrF9r4l
        2lmH+jIAeTGvI
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr6877707ejx.181.1567064660258;
        Thu, 29 Aug 2019 00:44:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTEgOTmPL7C6gKeK+p4p3VDmj4jaAlWchwY4AG0qidGcwqilr8Hiqay9Scqq+u8hizc7+f4A==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr6877690ejx.181.1567064660112;
        Thu, 29 Aug 2019 00:44:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h9sm292089edv.75.2019.08.29.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 00:44:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C1F2181C2E; Thu, 29 Aug 2019 09:44:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, luto@amacapital.net
Cc:     davem@davemloft.net, peterz@infradead.org, rostedt@goodmis.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] capability: introduce CAP_BPF and CAP_TRACING
In-Reply-To: <20190829051253.1927291-1-ast@kernel.org>
References: <20190829051253.1927291-1-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Aug 2019 09:44:18 +0200
Message-ID: <87ef14iffx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> CAP_BPF allows the following BPF operations:
> - Loading all types of BPF programs
> - Creating all types of BPF maps except:
>    - stackmap that needs CAP_TRACING
>    - devmap that needs CAP_NET_ADMIN
>    - cpumap that needs CAP_SYS_ADMIN

Why CAP_SYS_ADMIN instead of CAP_NET_ADMIN for cpumap?

-Toke
