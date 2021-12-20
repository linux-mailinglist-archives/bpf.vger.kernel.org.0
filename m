Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89F547B55D
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 22:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhLTVsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 16:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhLTVsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 16:48:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990BC061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 13:48:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so306642wmj.5
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lymMERGUnczrsTupEl0WxaOmUi/ayTOKrmwiICx0gsg=;
        b=phZa8LOiq2p7XpUtBo++t/e5TbTSTglGQuDKkNogO3xksbEnF6Md30yOdewF6PqZi1
         RV/oWwhIY1CkLlXdMnG+qm3Woxl5fpt33OridatPXzsJB3ktEGMyNDM5h8QXGZhOTa6E
         gN2Tlcu2QZv2CwcYvAJfDWlZgaLuBDIoHPIRs+BPEfFVO9CttJ5ohKUq3MfoMPihiimN
         asTyyVdcg5fthi/mNNdPfnXtx1M0X7Ov3K9kZUD68eJVrrBKA5XBlBkhT9OHwN8VmCob
         yk7SUkr6Vco9CHpO8JwnXOovq3CITNGwtwf4vUQdy3ry4vmNYADVCD++1hdtJzL1CGyp
         OyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lymMERGUnczrsTupEl0WxaOmUi/ayTOKrmwiICx0gsg=;
        b=hYW2GhQGFA/0aJdFlK2ashHR9hb7AkamFJrd9Zg+4r+J38PvEkONlHuxDHeEqajyn/
         MWSJPZk20jS7id+kKI/+Db6hrxCEdQXJLqgRwKu8m17AjriFvraTUAJyLS3XUyCbO4yH
         b17n5FdCkvJ3rKLgFcI1kRYaTBTvcHk699W12dB93dDVaAlKy9hy2+rzT1akDjB0tYn1
         1jbohlOQbNhdTsfLhXQqkl/ILjHw4TvxOib77Q6833ZmmpLGa+pInYEP2h2vNfFOuFja
         ybKClkCFT02u6rg7xD6yomxVvlOr+9f72w4qSRaSiD7RfdhgyAb5jrUEkwPTxuEGEoSs
         J6+Q==
X-Gm-Message-State: AOAM532b2y92sYyVbFM9Upifjpxy5rIOKLkqkv2i3P12QINvfOHJrIxs
        ZpI37XlkCvYv7ePJNbpztv4Dq8HW5rd3
X-Google-Smtp-Source: ABdhPJx9Hmd3Nty2ccfVXDH8eB7PzGz8UJGevwRma2oSQq93k00DIkgoJvXU4SNC8MXNe4f/4RLjMw==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr2224wmb.87.1640036897562;
        Mon, 20 Dec 2021 13:48:17 -0800 (PST)
Received: from Mem (2a01cb088160fc00f5af1551c2b57bb2.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:f5af:1551:c2b5:7bb2])
        by smtp.gmail.com with ESMTPSA id d1sm15959850wrz.92.2021.12.20.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:48:17 -0800 (PST)
Date:   Mon, 20 Dec 2021 22:48:15 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf v2] bpftool: Flush tracelog output
Message-ID: <20211220214815.GA11826@Mem>
References: <20211217141140.GA26351@Mem>
 <CAEf4BzYxLcZRq685reGkNRBWNpxLWnEt3u_J1pBCb1ptrU0z1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYxLcZRq685reGkNRBWNpxLWnEt3u_J1pBCb1ptrU0z1A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 08:51:01AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 17, 2021 at 6:11 AM Paul Chaignon <paul@isovalent.com> wrote:
> >
> > The output of bpftool prog tracelog is currently buffered, which is
> > inconvenient when piping the output into other commands. A simple
> > tracelog | grep will typically not display anything. This patch fixes it
> > by flushing the tracelog output after each line from the trace_pipe file.
> >
> > Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
> > Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Paul Chaignon <paul@isovalent.com>
> > ---
> > Changes in v2:
> >   - Resending to fix a format error.
> >
> >  tools/bpf/bpftool/tracelog.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
> > index e80a5c79b38f..b310229abb07 100644
> > --- a/tools/bpf/bpftool/tracelog.c
> > +++ b/tools/bpf/bpftool/tracelog.c
> > @@ -158,6 +158,7 @@ int do_tracelog(int argc, char **argv)
> >                         jsonw_string(json_wtr, buff);
> >                 else
> >                         printf("%s", buff);
> > +               fflush(stdout);
> 
> maybe it's better to
> 
> setlinebuf(stdout);
> 
> for the entire bpftool instead?

Makes sense. I've sent a v3 at
https://lore.kernel.org/bpf/20211220214528.GA11706@Mem/T/.

> 
> 
> >         }
> >
> >         fclose(trace_pipe_fd);
> > --
> > 2.25.1
> >
