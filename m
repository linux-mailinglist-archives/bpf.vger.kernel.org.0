Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56987432F29
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhJSHTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSHTi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 03:19:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDFC061745
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 00:17:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r19so5272817lfe.10
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=0hq4Tlbo91+y+0zqBsTuPpmKbptA+N9cmy2gbN8eRq4=;
        b=vnfLq3Yc8U/XJ1qOY0excyPSohYmAlmoJxX0gpHHoM21GSALVim3qb3TX/BIL8XbSI
         aHmeBZRHhDWwQF4JFQI4c2leYtTxKLD5Df2XieY9QIQVw65qVKa4b3xs/+Z+bmgk9/2N
         U+U1KWX3OMgMPWLdrqtQeIbXFFsFNn+xlyZxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=0hq4Tlbo91+y+0zqBsTuPpmKbptA+N9cmy2gbN8eRq4=;
        b=L2mfMrush0/fpyLUmKntUxa90JuXRp1nXFJq8E/JtUHdPOWnJqMilfDQiOEEeNZWQH
         S6wV+rdnKZHs2OqRqLaCsob9aQOASa804M+06z4bnnXrrP1QKEnoJqnUCaikbG9bt7Dq
         eV07G3vShfL0ig7MfPGINqGQ1TCEtBt5u968kPmtb7KA/Pb3BdhPZ9wEPDsn1UbX8QzX
         jLUSGlfo1O4M98nQEA4nIhkCPHtYn8XffQAGfZEgXNk1fvws5zuwLD+6+jjm8tbcZJyC
         VeMOi2AW7x1fdhpME2Do+Sft0V/Qo9uOeKGvJ4HAHseDkZkVeWLGQmzP8j5Fw3Nvl7BP
         a5nw==
X-Gm-Message-State: AOAM5330eDuZx9NuGgFMDKfJk0iEVz5aX9HzIp5xIctgqj/dqwrllHJI
        Ur1hbx1abvx0i3Ip9Jt74XY0JQ==
X-Google-Smtp-Source: ABdhPJz0Q/XjobJw5wjjZGl8TqIHk+TI/75bAfuZxdexMA25kPCQNc+Z6hJHFftI2esMtCKE4jrKjA==
X-Received: by 2002:ac2:4ecf:: with SMTP id p15mr4585860lfr.289.1634627844676;
        Tue, 19 Oct 2021 00:17:24 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-480d-6f00-ff34-bf12-0ef2-5071.aa.ipv6.supernova.orange.pl. [2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id x2sm1593334lfr.307.2021.10.19.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 00:17:24 -0700 (PDT)
References: <20211011191647.418704-1-john.fastabend@gmail.com>
 <20211011191647.418704-2-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        joamaki@gmail.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH bpf 1/4] bpf, sockmap: Remove unhash handler for BPF
 sockmap usage
In-reply-to: <20211011191647.418704-2-john.fastabend@gmail.com>
Date:   Tue, 19 Oct 2021 09:17:23 +0200
Message-ID: <87tuhdfpq4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 09:16 PM CEST, John Fastabend wrote:
> We do not need to handle unhash from BPF side we can simply wait for the
> close to happen. The original concern was a socket could transition from
> ESTABLISHED state to a new state while the BPF hook was still attached.
> But, we convinced ourself this is no longer possible and we also
> improved BPF sockmap to handle listen sockets so this is no longer a
> problem.
>
> More importantly though there are cases where unhash is called when data is
> in the receive queue. The BPF unhash logic will flush this data which is
> wrong. To be correct it should keep the data in the receive queue and allow
> a receiving application to continue reading the data. This may happen when
> tcp_abort is received for example. Instead of complicating the logic in
> unhash simply moving all this to tcp_close hook solves this.
>
> Fixes: 51199405f9672 ("bpf: skb_verdict, support SK_PASS on RX BPF path")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Doesn't this open the possibility of having a TCP_CLOSE socket in
sockmap if I disconnect it, that is call connect(AF_UNSPEC), instead of
close it?
