Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766E034A0B0
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 05:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCZEtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 00:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCZEs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 00:48:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D36C0613E8
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 21:48:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z1so4623024ybf.6
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rY+ebAnfAaEyvW5R91DGl8iFp/nGact/0SlarHTc5c=;
        b=AilqQXxjNbyw5R2sQFdQzTrvThnl6AklLkbV63Lt6Kp+2yOwaGnzyL74XiBh+Ge1wY
         U5GmHMhdahG5hImKGSVVRPlO3grVGHh42mBKApUO/N0M7GowpLx//Pk4Wy6LA8v7tvz5
         f+pozOnG4KNffhgKRJhIq4BiD8wr44k3twoLY11i6rbf6WtF9FOK0GYIGcIdwwEroFJh
         a0F1labRivwvWx/jEaS3te6Qpr1DdzdbUV//61fA4Voyett0+QQPRRTzad+/G4oVyZSX
         v6JBkm/YYtt3RCb18c3krvKEkkaZxUFS1hBY5q+nzjnk0wLMUdeVOO2JVr/F4/Da7L/i
         b37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rY+ebAnfAaEyvW5R91DGl8iFp/nGact/0SlarHTc5c=;
        b=Amn5/F9Je/UhlJAXaSVjun3wyrrC2fQddAczlGsuI8oljWq+xpXcOpClenwUJiBn4T
         183jnVIrdGbZ0CD57/8FOk8+At7Mv54mnudgkS2IbPn4FTlJihiBAUlNlcBt1ZzkVSw3
         xAm7kKnNOQ457lB1XwT4/6HErwbWeNHlE8BgKlXz/BjedSgLeCPTroWISwjPfsap9hxE
         Tmp2nbszuzOhG/PjRVqerIEzy1jdefgFQqhVebPDC0PWV2hcsJTHrTBYz72aO0BQI7Sz
         BrvX7z1+pZQnIyoNwVcAZsL/ufMR/KvsaXu7ByXEewYMNLS3ffLK8qtAhnH+ri7q4QGF
         cgvg==
X-Gm-Message-State: AOAM531LwJNq4ymdW6QNz3R4UguGoqvOeVEMcrCvW6ihmTbiKrvACLo9
        za/ahJTPTQRmc05LHglY6kvM6aC2bAfQDIUuXitfcUya/Xt0uA==
X-Google-Smtp-Source: ABdhPJyfWdGr8tnUwA/wqLwRw8l90MrXyv0G75POAavqS33nh2jCVpsx2pt2yQWIu91IHrXSs2NvPdX8rrVi8Tp6/Jk=
X-Received: by 2002:a25:874c:: with SMTP id e12mr16112727ybn.403.1616734132423;
 Thu, 25 Mar 2021 21:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210323014752.3198283-1-kpsingh@kernel.org>
In-Reply-To: <20210323014752.3198283-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 21:48:41 -0700
Message-ID: <CAEf4BzY=VR4MbYiG4fPwNPVB3hKw4MckRv2sftk160H6TapMaQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add an option for a debug
 shell in vmtest.sh
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 6:47 PM KP Singh <kpsingh@kernel.org> wrote:
>
> The newly introduced -s command line option starts an interactive shell.
> If a command is specified, the shell is started after the command
> finishes executing. It's useful to have a shell especially when
> debugging failing tests or developing new tests.
>
> Since the user may terminate the VM forcefully, an extra "sync" is added
> after the execution of the command to persist any logs from the command
> into the log file.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

I run:

./vmtest.sh -s

And I get test_progs executed, not bash. What do I do wrong?...

>  tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>

[...]
