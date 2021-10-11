Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8761F428C8A
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhJKMGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhJKMGn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 08:06:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9388C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 05:04:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so14697818pff.3
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=EggiArwUHdzlhhZ9X3Lz0fb6bTSzjLRY73Yy7pjfbDw=;
        b=lTzIqa9vZjsqexN5EkeLPJbOeFUyCBD1a0MHI0O8LY7S6TQyp0UGaTkFhJmTFUANgf
         Q3TCaUHVFh51pgazW18AtZv7bfKv7vnJYwr1RceAjvgnNZpzf502sqSwKMy6t6LLyPTq
         L8pM+pGgsLlCGWAcdB42XEhjUhLIY541pmmPr3ku+Z7GOcIjcswjdEqoaZfgQcDtCyd+
         BB9O2Q7eWu0frUSgGQzxHMhSZkV5JMBza91dw7R14A2NLz9cmIAxtZsZ1W5w2ZSwzxjh
         TSI4+sgOnIr/X+HKdQyNcj149ZGv3jk1YYDHN9ojNrSTOmTZh91EztlsCg3RPG9WyKCf
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=EggiArwUHdzlhhZ9X3Lz0fb6bTSzjLRY73Yy7pjfbDw=;
        b=ksLfkFV6WrCxRpAOuQWc3EiGt2fJub6MmmgJemdH+oeaRsYtEQyJqvbwU9CrTMvS7w
         WNm2ADLu2Lf4zUOCYlrU2FaVHpbtiO8vSz2sUxH0uYjgt/JFkvbhTpRx5k51rPsLqKCn
         ph8/CwtkD2QQiEfVYAz/WkHhr8fzOV/f6bV445O2agB6OoI1fLijIbLq9lHmtMPKVp5t
         M6zC6Rsy4PA5yYTUTgrAzghnsMs1GZ9TASBXaG7PhmUDmPALqZzxaKfSG9X6q9VF1UYq
         Sw9+DkI8rVwdY5egdu8+Q3fpSSJEZDI6WFF49bZkTR1qedQ5G5qgiaNdSS21cMdaS3Wz
         I7+A==
X-Gm-Message-State: AOAM532QgJqQsSxjRjz/H+OhjWweF+ynww7UvSbZSxST+BK9ukyBV18Y
        KSX7mUVDTUpA2j1qDgKqhuVusIx9WIrY1D9oriE=
X-Google-Smtp-Source: ABdhPJw2TXLhJ2x/gzgBmvOyRskNbsh3FfJfcPfebNCn345DoeXnrIHs5vHXCMApgmbzv7NZKILxz2kleCjOY3u0ZMU=
X-Received: by 2002:a62:6411:0:b0:44c:bf9f:f584 with SMTP id
 y17-20020a626411000000b0044cbf9ff584mr24201553pfb.29.1633953883158; Mon, 11
 Oct 2021 05:04:43 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.dorisdavid5@gmail.com
Received: by 2002:a05:6a10:68e:0:0:0:0 with HTTP; Mon, 11 Oct 2021 05:04:42
 -0700 (PDT)
From:   Anderson Theresa <ndersontheresa.24@gmail.com>
Date:   Mon, 11 Oct 2021 05:04:42 -0700
X-Google-Sender-Auth: Ws1Hra-HjQ2yaCfX0dgVs2eex5Y
Message-ID: <CA+=KUqysLZg0pNJk4LELp8_YDD3fv+yCZFpqD2Xyg7FLyTNHkg@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night without knowing if I may be alive to see the next day. I am
Mrs.Theresa Anderson, a widow suffering from a long time illness. I
have some funds I inherited from my late husband, the sum of
($11,000,000.00, Eleven Million Dollars) my Doctor told me recently
that I have serious sickness which is a cancer problem. What disturbs
me most is my stroke sickness. Having known my condition, I decided to
donate this fund to a good person that will utilize it the way I am
going to instruct herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs.Theresa Anderson.
