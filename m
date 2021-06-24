Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5C3B3107
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFXONf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXONe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 10:13:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1238C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 07:11:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j2so10492231lfg.9
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=MZznucNkzHCVtX06oF4YOKNt7j9X/CM4V2afDINg9phGeNwd0jfJPN5WXeK+ajhBGS
         avxY1N2fd06GecT4IhpLvJpsrSnfVkXl/WeDiV7YH7gHvxkcpKWnHx6O+wChMbNc3z50
         pjRV+rwD33KsPpyqdSPP6r3DQZ7WsgB769q1SmEGlRzY9MjYLCO/t5+6zmHvU06hJsrt
         KzwDYrRZY7J0Jw3hbeuokQYhUpAvq4pgTes+T0VnUm1n/ESmjeQTrYjvKKaLiY4mwLoU
         NUGbs7WDjA4Vf8MCK0BE89BvKFbO+gMEfPntU0dmOWlrebHTmJjpcVlpIZR7DueEEBbB
         faQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=YyX8T2qYNNAoNeDs+yldUlLMXL6RPpfTcX3NaNd+SCTGnzVmUaIBbFmhgEcZtCKbsM
         l9JbczZxfzibVIEJZgPdDrPkvy7EVvT08pRaD8HwDA2wK704C07YmoirQGJoQuLZmrvu
         ZpwFXigc8kcwvtecFKmTLiZisBXpQbWPjlopyVoMBelQ76cdlRk4w/6HpLu/zXuW+C/n
         DnJo1Qp9QUtdx4w4grHpSbrPY0PW9mqUxPpGf4MHfF/b5fLF7Qh81ka5+bS+uyNzwfLA
         TCAUp4/EjNlSUTqCTwhWfWSAq4r+fIbD/f4GY6HXVXZnPySJmMqAuHXTQpXUDj2T3RKx
         b6Dg==
X-Gm-Message-State: AOAM532zMZQkiiahm80f8pN/Dr9WPrMcc2AsaW4q/Q9YMcufo2ej5n2r
        PZmf8kZAh3jvFp8Oq/Y3FDwBy3f6asg7XsgNlFM=
X-Google-Smtp-Source: ABdhPJwpZejRlDqQAFV75zZ3THFwqC4TmYzpj/PG15BemWTayLmqmDn92xBoQLDjkWt3NKyKDMOOHrRQHDC6E3w/gWA=
X-Received: by 2002:ac2:4c36:: with SMTP id u22mr4161322lfq.218.1624543872993;
 Thu, 24 Jun 2021 07:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:1a1:0:0:0:0 with HTTP; Thu, 24 Jun 2021 07:11:12
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CACGGhyQDhNjM7pPW0wTzyn7LBiGmaBAqeP5L66y=E2TL4U9+PQ@mail.gmail.com>
References: <CACGGhyQDhNjM7pPW0wTzyn7LBiGmaBAqeP5L66y=E2TL4U9+PQ@mail.gmail.com>
From:   tuty woolgar <assihbernard6@gmail.com>
Date:   Thu, 24 Jun 2021 14:11:12 +0000
Message-ID: <CACGGhyRDWiuZgfCGUby9BHL0o7Tsav7CEDT+SZUBALajZk=Ahw@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
