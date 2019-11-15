Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50C0FDFA9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKOOHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 09:07:49 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45487 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 09:07:48 -0500
Received: by mail-yb1-f196.google.com with SMTP id i7so4017563ybk.12
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42z/vN/ddc98lKOq1CrQyhubCI2S5NP9LWnyNiKPWxk=;
        b=nLefbRNHj5/Shr2PtahgWUegdQ/rJ1Elkczuy2ggEoMon0rguyVvdv5zG2g4GbWS22
         OKoqoHLjnz2BBXw6mw9LorWYAqDBialbZAo3pdWjuQiezMeqdXnL9zVWJcKnUh/jeXaz
         12pSlMxWFZf54uaw08IoqD2MkSSkl2J2YxZZsIKDWg7K5uBfXF1Eh2XOsUgGCenfvHLx
         RA5UxmckvhCoiP6L8YLtHOlFfJS6mYxlRpVs6BJrV4EiTapyfb2j4TFMuJhpf3FVvwj8
         sZpCikRN/qh1orYy9uyGebYzrxBDub8AAT2dgKwuc/7VqAMTNngS/YwVNZCTjGd9CSL7
         T2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42z/vN/ddc98lKOq1CrQyhubCI2S5NP9LWnyNiKPWxk=;
        b=PsGxM2VlBn/X+t6iLM7QBAQYNetEAsIuvQa/+hm+Yy9bJSXW+Pv/gZgfqRzMztKcXs
         REGmPJn4dTHpmi9MACRmemzg4imJ6z5TX63tqp7hJGDQjkgc+DjPJILC2ZyO4ppGt1Cl
         2xNlYJ25PgzeF5p15MxS4b/f9cMSAzO5zoyLsd5JAZKG/Q6YtPWGxvAJoMMaCDUFx7Pl
         6cJ3g1GS46jWny75nmfs8Qtie1/eviw2S7No9eBvTtSZutNKMGBfNYY6xEZAcRM3bVvr
         Ygm/4msPPNBVpfSZlMzmun4RXh7dQBRGFlDChDZsCkUizeYVAmT9iFgKHt3QXc41Zg+1
         zu1A==
X-Gm-Message-State: APjAAAX3eQoj3T11aOkjZ4L6lZUpjiyA3P65X0RckHjmraHThtTKorTY
        37y1zEHK+yUDpVt8FdjjP1C7uj94
X-Google-Smtp-Source: APXvYqz5FOQMnPquVS207dozRP86suAQ+kVigxRMObC93cZbghb4lzZnxbVFvdcGLJep0eQ3zlr2iw==
X-Received: by 2002:a25:3753:: with SMTP id e80mr11106043yba.361.1573826867251;
        Fri, 15 Nov 2019 06:07:47 -0800 (PST)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id 64sm3732722ywg.103.2019.11.15.06.07.45
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:07:46 -0800 (PST)
Received: by mail-yw1-f54.google.com with SMTP id g77so3098912ywb.10
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 06:07:45 -0800 (PST)
X-Received: by 2002:a0d:e808:: with SMTP id r8mr9316664ywe.275.1573826865311;
 Fri, 15 Nov 2019 06:07:45 -0800 (PST)
MIME-Version: 1.0
References: <60919291657a9ee89c708d8aababc28ebe1420be.1573821780.git.jbenc@redhat.com>
In-Reply-To: <60919291657a9ee89c708d8aababc28ebe1420be.1573821780.git.jbenc@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 15 Nov 2019 09:07:09 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeWU7Tfg1SKotM4+r1NH+CH=Xei3Ho209xYm+DvuAneHw@mail.gmail.com>
Message-ID: <CA+FuTSeWU7Tfg1SKotM4+r1NH+CH=Xei3Ho209xYm+DvuAneHw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests: bpf: fix test_tc_tunnel hanging
To:     Jiri Benc <jbenc@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 15, 2019 at 7:43 AM Jiri Benc <jbenc@redhat.com> wrote:
>
> When run_kselftests.sh is run, it hangs after test_tc_tunnel.sh. The reason
> is test_tc_tunnel.sh ensures the server ('nc -l') is run all the time,
> starting it again every time it is expected to terminate. The exception is
> the final client_connect: the server is not started anymore, which ensures
> no process is kept running after the test is finished.
>
> For a sit test, though, the script is terminated prematurely without the
> final client_connect and the 'nc' process keeps running. This in turn causes
> the run_one function in kselftest/runner.sh to hang forever, waiting for the
> runaway process to finish.
>
> Ensure a remaining server is terminated on cleanup.
>
> Fixes: f6ad6accaa9d ("selftests/bpf: expand test_tc_tunnel with SIT encap")
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Yes, I had missed that the server gets restarted even though the SIT
test has to bail instead of run the last, BPF decap, test.

Thanks Jiri.
