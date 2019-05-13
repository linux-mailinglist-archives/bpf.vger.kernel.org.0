Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0F1BBB6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfEMRUc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 13:20:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46398 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEMRUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 13:20:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id a130so11585019ywe.13
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzlE1C/9CEd752qT6TyzNKD09iZhCYHjhs9N+LRYUio=;
        b=La1S7iKJohRQsDJXN+CYE0VCQ6uS9C/hK0TFTB/aPwvRDFygkyy8sTnq1g+BdalhCV
         9Wzt8q/s0lby37YPMcAWVmYnaE/R9ar10Kx+OTAxU6PwHUFEWnfVgJEUbnlNKji+VEHQ
         zuh8+m3Iw3Vblc0zeg77sKt7EBmW67jN/k4Nz1K0z1Dwbky1XWTJDSRpnF9ZizKXBPHo
         lRYnVxI2Nj2nj8qydjVNI1sZnHckRjsmnxTloiFMi6bNH+sYK9QPaUhh3wt1q/DAgTSn
         TkaKIwMiB6jufzei9kfL2rfnTbQzxaf636fePqCz5BunWIlF4tsdF5mLcEc85Tg1xniY
         ByxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzlE1C/9CEd752qT6TyzNKD09iZhCYHjhs9N+LRYUio=;
        b=JIOufhQvQL+caJ9IAuXYm3M1y3B7uw50R3k3vURRyxhsdFOQr35zGfpR5xcJO+/RB4
         HDnJfH2M6WSA4OhJlI1faDJzu77EuPftHK++w84rRiqgLFZzJZOUKodBaq2CnPbjNhSu
         JRB/aEetYyDLrSLR8VIeKAFjV3VnK8BZFoHLMB/j5UnKWy1EJH6FZq3V2Phh0bXdHvje
         zGVPcVtO3eYlpIVcnOHq5ieL1gpbRHKzjLi+hw1wsvSGK4U2FQ4RB7RWtVL7eJC3fc6A
         gw3cIp840WWXYt7iQSXXYfYJnjUa4qQ2QcQxONOXln3kA857hwBFJoWxUZxvjGGxrl+U
         IgoQ==
X-Gm-Message-State: APjAAAXx/ImvYXrojdOJAUaL5ZlHvmlPZWs9gXu0zo0uzHPNh3i4Vana
        qAPJXMAINpajLaq39WTQdiycw3i1wCxwKBFXab8OUw==
X-Google-Smtp-Source: APXvYqwpQNzukKh5uPOZlDtjCueo4XtN+i5Y1ee0qX0V1HftY8+QCQ0w44V54HA81yfzwbZbXpTeXiqE5OSfzLKFnDo=
X-Received: by 2002:a25:378f:: with SMTP id e137mr14632429yba.236.1557768030855;
 Mon, 13 May 2019 10:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190513163855.225489-1-edumazet@google.com> <20190513171745.GA16567@lakrids.cambridge.arm.com>
In-Reply-To: <20190513171745.GA16567@lakrids.cambridge.arm.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 May 2019 10:20:19 -0700
Message-ID: <CANn89iJzsUbLXB_M5UZr2ieNyQdGHsKPFzqeQFGtKtL8d9pu0Q@mail.gmail.com>
Subject: Re: [PATCH net] flow_dissector: disable preemption around BPF calls
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 13, 2019 at 10:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:38:55AM -0700, 'Eric Dumazet' via syzkaller wrote:
> > Various things in eBPF really require us to disable preemption
> > before running an eBPF program.
>
> Is that true for all eBPF uses? I note that we don't disable preemption
> in the lib/test_bpf.c module, for example.
>
> If it's a general requirement, perhaps it's worth an assertion within
> BPF_PROG_RUN()?


The assertion is already there :)

This is how syzbot triggered the report.
