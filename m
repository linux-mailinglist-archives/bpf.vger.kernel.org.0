Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AB1F6D21
	for <lists+bpf@lfdr.de>; Thu, 11 Jun 2020 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFKSCq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFKSCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 14:02:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B9C03E96F
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 11:02:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so6500678qkh.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii6TqQ51Bobpe8G3ammikyCmEQx/uy00ewub+gCjREc=;
        b=LvUKenyVcNLtWEoyq4u0NB/OQ5bXNK6Faq2+hpWqa57OF/nu0o51XP8naJMgRdMFa5
         Qkgmg5UMz6Fz9owx61N3VKyfm1emKrVEpw9IGFgDJHJc4x5iuutAis0sh8dgLeJdFvUj
         ImPAyZg7neS2/wFxD0EWGpdXClibLCKQkc2yYKyaqOWdxQJWHF6C5WixIvYl8pQs8pw5
         aIH2oOeYw22RDkNQzBQIBJre0Cx2NS+iLMz31SCSqdtNOHoZpxQnE0wXXVAvLuAsdfrE
         cjMQFDlbJqWxhitkIU9F/p83zoYVgI2w+2bUOqrBf/sYT04IgCCHtUZGsmH0Obmf4Lca
         IlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii6TqQ51Bobpe8G3ammikyCmEQx/uy00ewub+gCjREc=;
        b=F7q1FsWK/xC1IJ53+swEEI6VJMgRiZkXpJfhTsYdv2RjuGk7Q9NOUOaGdTxZmwrbEY
         Q1D4xkuNpsMv27SDQ0gMZ+AbCDcYO4JwUZvxLQKnEmvVr5Mn/vnSdaSRPSnLX1lgiDFr
         VLW548Tmoqql9meUkbvvlP5n30yAuRcYGCY0bf6Jz3YtzCf/P1s+FiMlhAT84HRRdlr1
         EtLLX4p/KNiOvOIxeIfCk1AOOGRRiGav2B2WsUpbF3zvU9SmNl+/W+oeIXvW2m0q3u0z
         N16rZO6nSnTiT/+IJ3PGWqhicHq5XqBJCmIzoTRCvjjnkYoaplqfUCjPwBzWkznKMz6X
         h7Bg==
X-Gm-Message-State: AOAM532I2Q9MtqQObuJ/m2hEnE/FySiwe/wSaKRH5cxB03IDZO2uqwsy
        zdZyCBcq580CxS0zCgklu3aLH8b9ES+OCusSDK9TRJxb
X-Google-Smtp-Source: ABdhPJypt7zIlNPdXV+ME1s6LUv/S1YzZyI+Qn2o0dh/UKMx1ZTJkoWjkyI/Nt9QgKx2nOuIv3MyqObIXnK9yr2dhC8=
X-Received: by 2002:a37:a89:: with SMTP id 131mr9384865qkk.92.1591898565493;
 Thu, 11 Jun 2020 11:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200610130807.21497-1-tklauser@distanz.ch> <20200611103341.21532-1-tklauser@distanz.ch>
In-Reply-To: <20200611103341.21532-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Jun 2020 11:02:34 -0700
Message-ID: <CAEf4BzaHaHKSVuNt7kgFm53-byDro1ijADD+Q-i39yMfT9pT-g@mail.gmail.com>
Subject: Re: [PATCH] tools, bpftool: Exit on error in function codegen
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 11, 2020 at 3:33 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Currently, the codegen function might fail and return an error. But its
> callers continue without checking its return value. Since codegen can
> fail only in the ounlikely case of the system running out of memory or
> the static template being malformed, just exit(-1) directly from codegen
> and make it void-returning.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

LGTM. Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
