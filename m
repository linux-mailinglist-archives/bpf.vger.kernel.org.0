Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B642EB6D74
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2019 22:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIRUWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 16:22:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34749 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIRUWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Sep 2019 16:22:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id h2so1288292ljk.1;
        Wed, 18 Sep 2019 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meIVwwcdmP/nxLwROeZNJKv2MKcCbPHX7tUkS9zAbzM=;
        b=Z7ucb399RGF9U9tQvgEYnaf/GVv/5O8JGgljOfEFbS59akeP8ua3MG96LGv6gp1/Bl
         FRSBFhV8554T6+PhvCNurUGqIj+l/5zx463jRffXiOBWGdWnibHtbhPZbIWJJYIFVLR8
         R7+Km/dNqvXLb24XWRPhA558QSW5AN4Q8vSFrSOQiNb7le2PSpSVDNHDQX+faujSuxDc
         galQGlc3OMS7mOrIOzPA+T9hOCj+UuiuYbICOnw1hnawKxFIpi8pmgiuDg65GPGc0HcY
         18rouYHLHbwxRZT4rY/1Zm6raqoxWfvkET9CUioERjOMJcE0WeLu/6fI89cdL29DmaZB
         M3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meIVwwcdmP/nxLwROeZNJKv2MKcCbPHX7tUkS9zAbzM=;
        b=Jd/XCGOieUU2vYzsiFhRa79qeBtDcdBZuvg0+E+Z2aw+y8JZ6X8kn8ezpjKfB+0KZ+
         4ldC7BX0WtR6HdaGSkoHCnKn7s+3zybkMesFVyUzxPZJInK6RbYKlLKCc+GUd5paZyd1
         cVXtJaKUfGGsTSiMwzZ9tVkrcIev8HpMgY6OMMVS2+V3bKtEma5INZoP75IRfeBnOy5U
         +REOi7CudX/ZbQ7ga9Aq2s7vEBKbCV6PKPIWgUzShqZ8i/vn1T4XfhP/elj8Q1R1bokI
         +3bBuXQqvPUMrNsctt+fNqWMzXuWBgShpl83xCpuZ/GTLpWnB+1mBhHf58V0Df0aPR2E
         SjyA==
X-Gm-Message-State: APjAAAUqnn9jmQBfhbCuc6BpABEJ/7Vcbe9CfH+Iv4zf+v7xZNIJ4XHU
        QbHnGvRIp/EkgoU/yMogFOnc5WrDs83SuIATT+A=
X-Google-Smtp-Source: APXvYqx/sOK9cpvYG89Tl6YDcE/lNs3l9ylwlvv9ugwHiO3AAV8UBwZYkdXxapXBp8WaXs7eqKDhElFzdrGjXl6++tg=
X-Received: by 2002:a2e:6a13:: with SMTP id f19mr3209725ljc.17.1568838150069;
 Wed, 18 Sep 2019 13:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190918052406.21385-1-jinshan.xiong@gmail.com>
 <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com> <20190918143235.kpclo45eo7qye7fs@ast-mbp.dhcp.thefacebook.com>
 <CA+-8EHRk6aAuDQ=S9O7h6T2fhyz2z+zQduN2yiDNWMOWt2-t_A@mail.gmail.com>
In-Reply-To: <CA+-8EHRk6aAuDQ=S9O7h6T2fhyz2z+zQduN2yiDNWMOWt2-t_A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 18 Sep 2019 13:22:18 -0700
Message-ID: <CAADnVQLsnFaFS+ZhRoL0QfDVcGiR2OSrqSqRsd5dci=rQ+Pb9A@mail.gmail.com>
Subject: Re: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
To:     Jinshan Xiong <jinshan.xiong@uber.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "jinshan.xiong@gmail.com" <jinshan.xiong@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 18, 2019 at 8:13 AM Jinshan Xiong <jinshan.xiong@uber.com> wrote:
>
> The problem with the current approach is that it would be difficult to filter cgroup, especially the cgroup in question has descendents, and also it would spawn new descendents after BPF program is installed. it's hard to filter it inside a BPF program.

Why is that?
bpf_current_task_under_cgroup() fits exactly that purpose.
