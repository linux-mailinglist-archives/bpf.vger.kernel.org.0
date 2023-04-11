Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE66DD82E
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDKKpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDKKoj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:44:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05946A0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dm2so19250271ejc.8
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6JbtruesiP7BwQ58kqgU83OcGnUNXNnTbXchDf9Wuk=;
        b=YT+RztS5s02tfjc3Xc95uvibedfXu+LCxRkwe92Ud4zmxdshukmzdgXynpFpQPwLWx
         D9pFS6aCzdPwD6nqNLo+ZKrB9ezg/QzgwvF+s6KesBVob17+sBeHQ/MJ1bUKicchSnR3
         AEF42FWvwiiFeYfhSnZGC0cP8ERthjrNJdb13JFuJJ3/ZKf1urBBjvrLvL6GWvKWljat
         WXpTIpz2/5jNjDgwuuOp5VYGsBgew8QqNophxmf3adF+iPSoJMXTcTHxTCg8vNJy79m5
         Qo01WYKD9EqllHGmYFL20lgTKwA/NeZq4TG6O0RnIUDNnifwTnMXqDK0reXY+bre2GVT
         iiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6JbtruesiP7BwQ58kqgU83OcGnUNXNnTbXchDf9Wuk=;
        b=Tov1f0O21zhi+rQNMaM6alHHY45BOdxxuBbL15lhloMfQQfBQoYOtQ3gs0RIHBuqVf
         9R/7DGHI+sLABzuo9q80dCOposjrNcEQ1CdVHfO6c1k5TD6wJRCRYC1qog86ZufJXDHx
         SX+oQI4GNGBhULGumVTr9bZzqd4V1m/SZ75fBgaICOo3FHJ7jI/5nala1kCj1Foi0BxP
         Q+RGUMDOP59vn1p2VF1JOZS7NVoDUTlhT7XWehdjGxWYablmBVJRd4rrtBlgnhKGKCn7
         pGnWfc+YzHB+6VkU1LzG65zYLmRq07A2DzpnxRQFx8JdPOOevf7wxJ+336xOhuJAH0lD
         TX/w==
X-Gm-Message-State: AAQBX9cm3bLFnlgb1XA2/f3NVMPOeCyb3+uqpdWF5kGRcJUj8QsQEpHO
        kqZE5RvYuYtOnHXbGJtxTDl0I1te5JPGTtRqRaezdw==
X-Google-Smtp-Source: AKy350aCezmnMKe+0NNO4wEUhvyhARFIvgXinwSkwj9BNOs0xx6kU/Co0+NgC9WBgBGmRGylytFbx0KFWAo+0HVxrC0=
X-Received: by 2002:a17:906:94c:b0:932:a33a:3754 with SMTP id
 j12-20020a170906094c00b00932a33a3754mr5168366ejd.14.1681209850517; Tue, 11
 Apr 2023 03:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-2-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-2-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:43:59 +0100
Message-ID: <CAN+4W8j7sEaHbaFQsTHqD_wm_YvkxR8PHB0oGd3R2P5yg4Hg5g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/19] bpf: split off basic BPF verifier log
 into separate file
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
> kernel/bpf/verifier.c file is large and growing larger all the time. So
> it's good to start splitting off more or less self-contained parts into
> separate files to keep source code size (somewhat) somewhat under
> control.
>
> This patch is a one step in this direction, moving some of BPF verifier l=
og
> routines into a separate kernel/bpf/log.c. Right now it's most low-level
> and isolated routines to append data to log, reset log to previous
> position, etc. Eventually we could probably move verifier state
> printing logic here as well, but this patch doesn't attempt to do that
> yet.
>
> Subsequent patches will add more logic to verifier log management, so
> having basics in a separate file will make sure verifier.c doesn't grow
> more with new changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
