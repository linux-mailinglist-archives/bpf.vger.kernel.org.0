Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC048611D
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 08:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiAFHrw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 02:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiAFHrw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 02:47:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2EC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 23:47:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z9so6225376edm.10
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phoorp7mSB86zkkPdm3B+uvykzJ7TvdRpuc4F63erPw=;
        b=Yf/utIxM1EFzmnYc6ucEyrIM7yQQtczbCjbP5ONPiGpj6PXAfyOTmMg5cGmDVHmhqW
         OvjLiJhFui1TKETjPmcX9O1IcjoFnZTuMg0gzoiKWbMspBZRHFWClrh6ye9UE/3uFWHu
         8Xd52aKNPlrHeVEVlrS3znTjlBJacWsKDtRqdbNute14AlWstTX6b/Q5giKa+WjioDKO
         ZiXm7570BP3i20sp42jJZzw1cIEWNFFlYoKConnVPdr8oiYqmG7UAtYJIA0YzQSQpyPR
         ufmFb9tLBMuC+FXQMbnxbBeo7nUI0AAYvO7DlCWVu+lMMuo9cyqu81elN4lkKIO2LoHa
         7UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phoorp7mSB86zkkPdm3B+uvykzJ7TvdRpuc4F63erPw=;
        b=xy5O/XXGwmvfPT1ZuXilJNw1LMFqemCzb6vkx68lgYhMr2/PDbVxYAb2uYG0jfkZyD
         KmirE3amfUfuq/TjVOA45Ku+F+hGXCXu5cGEBad8NTTaWIjYO8LNTf5+d9u2JWJv84hM
         kGzbWcDFmLC/V0k+S5SDeA4OIxZrXZCrAh3iQqWEhet3ivqQklz6VLPpxpfTJUyCWanp
         ZH4wgnTkjQAja5Mkx74/eGSKAXuK2TwxF/aL4khKbLEZtIIDdoBIAyl65OaZd96qvYZU
         NcsBQcVp7pgXhTNxym8X0eUl9wpWKJHPR6YYOnS6aHlIKokCa/AC9f3AcnPfMlYbQTM4
         ay6g==
X-Gm-Message-State: AOAM531g2t828EkkYiAZqu72zJcw6y8dQo8KGDLQ1HB9cwyjkU7ZTNH4
        KIymuVJ8vC85J1ZxKc9YSlgIPHfaI4oTi+2MZ6LRlQA0owU=
X-Google-Smtp-Source: ABdhPJyzfvZYpGKZBw8TQCsggM/e3L+m7jTxyTU9izcCpdyek+x5j6E/XornqQlp6iTtCM/E1eJAIY9IzDOp0NoJmRI=
X-Received: by 2002:a17:906:bcd6:: with SMTP id lw22mr509237ejb.114.1641455270659;
 Wed, 05 Jan 2022 23:47:50 -0800 (PST)
MIME-Version: 1.0
References: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
 <YdOYhsVwGu1p/SSu@pop-os.localdomain> <CAK7W0xezGaA1TZcsxkt_hf+b0LU+396CmetejFBEXjqtvbmDkA@mail.gmail.com>
 <CAK7W0xfX35NSKa_ExcpJkWoy1iX5mU7ogjHbr=T5sHJ9U+D0fQ@mail.gmail.com> <61d4b7a06ddea_460792081b@john.notmuch>
In-Reply-To: <61d4b7a06ddea_460792081b@john.notmuch>
From:   His Shadow <shadowpilot34@gmail.com>
Date:   Thu, 6 Jan 2022 10:47:39 +0300
Message-ID: <CAK7W0xe7QSW4F+tEneqMS26PdTgX83rURiSefnDbRu9WusPDaw@mail.gmail.com>
Subject: Re: Fwd: eBPF sockhash datastructure and stream_parser/stream_verdict programs
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>Alternatively, you can put the known sockets in the map from user
>space and then monitor for new sockets with some tuple/key and
>insert them based on whatever policy decides sockets need to
>be redirected.

I think that's what I did. I put socket fds into a normal HASH, with
keys being localip localport remoteip remoteport for the other socket,
then in verdict I looked up the value for that socket's key, and
redirected based on that. But that's exactly when I encountered that
problem. Or are you talking about something else?
