Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334066DDD31
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDKOEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDKOEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 10:04:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF7359D
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 07:04:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ga37so21007262ejc.0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681221844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ7v5B5nqoReNp8o9tUc2wF/l3h68/qE8V0/+aroSHk=;
        b=FIIpa5w8jthE1CIeiWjffna630LVfTr1m4Lohb6pX40/UC5OALt+cin71ujNeQ25ND
         UIbm4tV9aC7Oy/uXm6f9y3nYLF9Zy5n9GCn6zbe/uLgPExoxduCedQNkQgd2co4uW99W
         0WRhVVH/9FfUYiStdMuzMERfuJPf0F0TrbHgFg9tlIFwAyf7biIk0y3zxxZOrNc65pkC
         7hXfs7UHez0sVuxX35jcafkwn5Gjw6YacEqwSQ6oF9lvvaeR0gcvGc8Co2JQQkwei2g3
         jvqbMxgRcKVgxs7r7X/7Wc/1YICAB+b+tXKFi6qmjX6q6q/KWe9mOpRVJFZPP3CvVCGF
         PZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ7v5B5nqoReNp8o9tUc2wF/l3h68/qE8V0/+aroSHk=;
        b=rRdsJovHJ/6TGD7xOsSC8rQYI5igiESPJn6EkeHAesGILGSM6oSda5ZrpJKW/I1VjE
         qiy64F18ndps+CTWOtEOVPd9BfJKIYQE+BgJpxvEf2hMQjNsGVneyKt9plVT3m8pOscp
         wnrPCecaupWMwnjnjNCru1d7DFQrYTASQWPcy2dYjs5Jd4qJK3WbBysZEyKFZYvzELYD
         AKREGYzjWhz9ytTqNZLAYwxFbGu+MR7FSp/llraeSMp/QnPf49RkUTAeuikL8ipKJU4X
         v9GdqaRJvSnWqWP6l6YA5DpG6+dnWaR84AbYsJWRQNoqFJc7shyNawwKBcZ4BGV9cqLl
         aqiQ==
X-Gm-Message-State: AAQBX9eGTbrDbRHrFD+/8ofoqQTpClupFAHbM7cALFLr415R+/RM39k7
        fYRqN7P+JYlpTrkocadTDfcyKZ7ZehpU3WnQbSMNSrMAXY0Nl2lgqevXQg==
X-Google-Smtp-Source: AKy350aR9njkjyVZGK03yvdpyUDS6OZyRb/TkJZSk6TYTzKLXqpjSR/B0hZsFkGKhUfaq2hyIv+M/uAXXutwizDwRnQ=
X-Received: by 2002:a17:907:7f23:b0:94a:8300:7246 with SMTP id
 qf35-20020a1709077f2300b0094a83007246mr3353222ejc.14.1681221843857; Tue, 11
 Apr 2023 07:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 15:03:52 +0100
Message-ID: <CAN+4W8jdCiRXRLWrnEdGPg-o5fpYe0=ZmK6P=EL1CBbkfMCayA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/19] BPF verifier rotating log
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set changes BPF verifier log behavior to behave as a rotating =
log,
> by default. If user-supplied log buffer is big enough to contain entire
> verifier log output, there is no effective difference. But where previous=
ly
> user supplied too small log buffer and would get -ENOSPC error result and=
 the
> beginning part of the verifier log, now there will be no error and user w=
ill
> get ending part of verifier log filling up user-supplied log buffer.  Whi=
ch
> is, in absolute majority of cases, is exactly what's useful, relevant, an=
d
> what users want and need, as the ending of the verifier log is containing
> details of verifier failure and relevant state that got us to that failur=
e. So
> this rotating mode is made default, but for some niche advanced debugging
> scenarios it's possible to request old behavior by specifying additional
> BPF_LOG_FIXED (8) flag.

Thanks for your work, this is really nice!
