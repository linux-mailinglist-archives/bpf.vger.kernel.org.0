Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A13492221
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 10:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiARJHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 04:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbiARJG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 04:06:59 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EFDC061759
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 01:06:58 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g14so53622673ybs.8
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=AIHedDQeQ2nfeFyhlIY6iBZ7Eo/kAlP72EhStgPHV1I=;
        b=MwuXI9bo/bHhmwSiZow429zo8aSB+O2GLUej+IgcXI5RO/o3AqH4CSQ9NAWjmHtI2V
         CWHWHodvspT0TuHM5gPO3+DsIPBfj5I7xK86tBODXNXUNaTSYWM44YSISAFFoUBCT0Gg
         kUseC6gV2vHxvawS1hqRt36sr5ZHyfG2404GVbLMHZFIWJloN2l0uLLpE9xGpmX+gvFt
         T/SKBR85N56dXCUtLtefGn/VyQ5YHcl7r/PL/CN8dJjeVXQr6S8XtfLgDxWiWVeFp/uz
         rUPQ/vWjjy9uE0DFDcQNAXccnZrg9yq5ahPtbYdtOe2x2ilhAjqIuZxj1Am01Jk0eYRx
         TdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=AIHedDQeQ2nfeFyhlIY6iBZ7Eo/kAlP72EhStgPHV1I=;
        b=yvmZ8XcPAgeti2p/SDEDdTyvdFbHFzdBStOYnCpYhREpSGnEYibYNt7og8fdDuNJ6y
         yVZXGHzbtQIcwbvV2gXr1+3PynLU5FRedYlcLvX5ZyzY300NIgV/n42egvE5hYfQiSqH
         kCo3WYRR/lOTcLtmqJ2pEn6CGXlQnbrBGd9q7d0E/PYpyobYWLtUh40LyqpkapQ6mgda
         boEAOPn5XFkvoGdWGK+DFevYziWzGK5OGaHAOiannp5C3DlMx8lhoEuPFq2EDTlTN+nF
         XD+0k+y+nVokKvEAPCUM7WpXHbTwi0Czipo5Ynu7A0LeDNiHfIzuHsNHW6a7X1ZRpdj8
         PIng==
X-Gm-Message-State: AOAM532AGuYZ9iFfCi9/fh7vEdVUTetP+L5fCGU0ypi7WLRo4uRcL3su
        BTw5XtylZxFfAHhRnTssuixDdTqF0V8+z+xqg5Q=
X-Google-Smtp-Source: ABdhPJxA0wzoWLcZT1OxNrAcI8XNQh1NLzUcYEY6tZP9fJ+XZhak2v8hM5rDGFWcpfNwqZAdykwmchO/6gc3Jodrd8o=
X-Received: by 2002:a25:bb49:: with SMTP id b9mr31607636ybk.0.1642496817798;
 Tue, 18 Jan 2022 01:06:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:3655:0:0:0:0 with HTTP; Tue, 18 Jan 2022 01:06:57
 -0800 (PST)
Reply-To: asil.ajwad@gmail.com
From:   Asil Ajwad <graceyaogokamboule@gmail.com>
Date:   Mon, 17 Jan 2022 21:06:57 -1200
Message-ID: <CA+Yy_gCScGafLu0JmRT2o26eNt1J5S_DUo_G2xwuVh0p3r+Daw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Greetings,

I am Mr.Asil Ajwad, I work with United Bank of Africa, can you use
an ATM Visa Card to withdraw money at, ATM Cash Machine in your
country, if yes I want to transfer abounded fund the sum of $10.5million
US-Dollars, to you from my country, this is part of the money that was
abounded by our late old client a politician who unfortunately lost
his life and was forced out of power Du to his greedy act, the bank will

change the account details to your name, and apply for a Visa Card
with your details, the Visa Card will be send to you, and you can be
withdrawing money with it always, whatever any amount you withdraw
daily, you will send 60% to me and you will take 40%, the Visa Card
and the bank account will be on your name, I will be waiting for your
response for more details, thanks to you a lot for giving me your time.

regards,
Mr.Asil Ajwad.
