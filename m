Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A237124D2EC
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHUKlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 06:41:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727979AbgHUKlQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 06:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598006475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmyozTjLu0qtA79SJgt15uZZiFXi20UBWDtreI80lDc=;
        b=PiBmXQA1EuVZmp1xgq4sUvlghE+IyNiwqOqocijJf041CBph/gnYKncFEwfzd+7QD42N1D
        5YdtSMs+DFXG52u8fkbk3tCzpKrJNckUAKxRu5UEJcf1kRIimJscUuQCxFEJmFu1GIGo3C
        0hqxszDpO3jTx83ELGRxBoLvkBe8pEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-Ut3sdXHuOI-rURiQZBetRg-1; Fri, 21 Aug 2020 06:41:13 -0400
X-MC-Unique: Ut3sdXHuOI-rURiQZBetRg-1
Received: by mail-wm1-f72.google.com with SMTP id b73so673283wmb.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmyozTjLu0qtA79SJgt15uZZiFXi20UBWDtreI80lDc=;
        b=dcsS8eD06QrJZ57sXAw87WhqO3rKLScNqIVi5BAAEJZzCB/rrwb5Tg4ro5dT0+GXlG
         gsRfmcZ5aF7FwwXECaBlB2uKcvODzEKhvv7dGgrnxboV1dAn3O6c0HhjaK6ur0cgQC/c
         LL+4+t+5xgx+tIzsiKTkwUlOTL26Z3PJAGmAgldwj8cepf2WU3Exi4ASqhI9i8QuWC+r
         afu4feFQdW8yz/kXJ2dmp1w4b/dMN988CEKEaFUS6eq35F2zqhPz99BlxiWn1eygZTHJ
         cguCeUYr0NM3bQbLKyxt+ruTsJoFuyF0BPTbx5KWpI3U3ACHcCqt1g0bbE5O3O56GdXj
         8Rvg==
X-Gm-Message-State: AOAM531UkaB0Ey/8g4Q/OcpgP67oDCPDUXecdVKSooIdwYAb61MRJ93d
        fpR92ZriwR4QhqIUXFbgQ0eAtcYmqVDpDS19RT+oul9JukNd+7pjl+ViM1j6fLeYHRwE91NDFbl
        FfZvz2R22o295m8KXEpPL3cB+6JUB
X-Received: by 2002:a7b:c845:: with SMTP id c5mr2574702wml.180.1598006472535;
        Fri, 21 Aug 2020 03:41:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbU0nCkmrzC/vepuy10ZGhV8r0Hht+a1RgdsZJQzjkyPGzmSEO/kTonzU9s3tgDa6zoX4miIT/dLa0NHqpmi8=
X-Received: by 2002:a7b:c845:: with SMTP id c5mr2574685wml.180.1598006472353;
 Fri, 21 Aug 2020 03:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200820115843.39454-1-yauheni.kaliuta@redhat.com> <CAADnVQJYXQ6bQ3gZJ+3wMc4W9dwyMP53PP2xQZXik=jkE+S72A@mail.gmail.com>
In-Reply-To: <CAADnVQJYXQ6bQ3gZJ+3wMc4W9dwyMP53PP2xQZXik=jkE+S72A@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 21 Aug 2020 13:40:56 +0300
Message-ID: <CANoWsw=0ubVRoLp2WHm=Ogs28-7g5R8p-=5mpwfO0Bp1Nb_E6Q@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: selftests: global_funcs: check err_str before strstr
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 12:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

[...]

> > -       if (strstr(log_buf, err_str) == 0)
> > +       if (err_str != NULL && strstr(log_buf, err_str) == 0)
>
> I got rid of '!= NULL', since it doesn't fit kernel coding style and
> applied to bpf tree. Thanks

Thank you!

-- 
WBR, Yauheni

