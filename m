Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6C6DA933
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 09:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjDGHDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 03:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjDGHDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 03:03:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A8230F8
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 00:03:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jw24so6516341ejc.3
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680851024; x=1683443024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb0EWeOcNxNlzqOyyOyDIUs0Ru4xSIrBTqjgbe36lPY=;
        b=qlWCz8QW4CoJsN6gBKQKBGC+MfbIffdhlPV9480Uno6nNMgp6bTihlt66LJFt6BAXY
         MabSTPOmt+fMB5ucTfKUYhPqr8fgZ9wskJlRjGtcYb5S6dAvultGlQL79SCEK4KikmvK
         zmYJit9fRGtdGOsAx9Gx2E/rFnf+obqj4Eo1PKWIBqouIlZQ/wfCfLLLIuKZlgncGkw/
         MhMceeWOB4wRWbSnCLSeOW/9avfRi3x3omX9A+VBcfcLzVB6w2V7gARH3bSk3Tn6R8CY
         /FlE9QJkCSGbCPPwDcZ1DAYoEHULIcOj9V8KmJDn4jxudBW71yp41J7u/aqGIyUwDCX5
         6EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680851024; x=1683443024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb0EWeOcNxNlzqOyyOyDIUs0Ru4xSIrBTqjgbe36lPY=;
        b=FX68FlD7lMbjCoty7OMl7tEsGP/8izK/yIoSkuxU1BUIwnh9JCxn2C5xkJxuIqpbvo
         fKEIS17AX8wMA2JmhN/OxRI8GSikZ/jr26ChHjqs122Twx/UVSAKTaMWZcRCvGwA9ROZ
         BX88G3xwht+KlYSxrF91k1rA9p5r7EEqQttH1DR7ag6ywV/J6Es/YGnD/Eb3GwsVsgBw
         4YZtSz5zGb/avJLv9WbCrrUlAQM+Q3NrLrtAMZqyZ8twPHCDZxGp7ZWGrENhm/sqqMQ0
         BvczDR/aX+GG2OupGsZlQAIq1CmxyQKRRIexaLF3x41J/IssdIEy5Mg165tDZyR/7lEf
         41vQ==
X-Gm-Message-State: AAQBX9crmurV12bCJhwqelGOK1n59q64ZXWwTJYKhFmLp3I1p1fqwdqg
        KRRlN5CRlT2KfWiV93hrfXpOowEBhFduAnE0Al1pjHz9
X-Google-Smtp-Source: AKy350bkhmXSWDuetCo3vVhaiiA0f2t4dhY7OVDRxl6yz6bfagmn5Fvt+Y+K8QtKcDR20uS8hBXQkHsTc/My0+6JN6g=
X-Received: by 2002:a17:907:9626:b0:92a:581:ac49 with SMTP id
 gb38-20020a170907962600b0092a0581ac49mr625993ejc.3.1680851023697; Fri, 07 Apr
 2023 00:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230407064837.32015-1-zhongjun@uniontech.com>
In-Reply-To: <20230407064837.32015-1-zhongjun@uniontech.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Apr 2023 00:03:32 -0700
Message-ID: <CAADnVQ+Qbow49gGhQ5KjwYUvFg39MPJj0qr1JLnb5N96dsvmxg@mail.gmail.com>
Subject: Re: [PATCH] BPF: replace no-need function call with saved value
To:     zhongjun@uniontech.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 11:53=E2=80=AFPM <zhongjun@uniontech.com> wrote:
>
> From: zhongjun <zhongjun@uniontech.com>
>
> The var 'is_priv' is already there, needn't call bpf_capable()
> again.
> Applying this patch, to refine the codes making it robust and optimal.
>
> Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
> base-commit: 919e659ed12568b5b8ba6c2ffdd82d8d31fc28af

Please stop spamming us.
All of your patches are auto-rejected from now on.
