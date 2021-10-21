Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C93436D37
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 00:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhJUWHQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUWHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 18:07:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B2C061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:04:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso4216500pjm.4
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUvG4W/VWSV254sbPRsCLX18bHwKr+vIF4xfgUXRsz0=;
        b=ikM50Em3QsCw5ebjI8x8sTroFZq5NxEEQASqmqeR6KMdZX85hRw08EHzW49AQuwo3q
         ilmjxCK9QuP+e1k8JADiH32mug8PXImICbM/5Q0vSL0rUJrqZlORfHvvFR5V9TQ5lzjd
         gfY2nZcrtjEDNhvVtaBKcZ7D1fgFZy7YTIb7+qOQhpKO5j4DJhLo9vr1yRVf2v/lddH3
         R/4D6DoVdolWiMft7rAJuOxAG4YWwsYOixR+OWL3sUSNGoRxxQXPLNky3zoxG6Ic4Qos
         OQjMvWZbcNyZs9Hejch7aRcKJqiUunbXyHqYzPeuhFnJeesHcz3ezeE6PcGWdmOHGUXd
         1j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUvG4W/VWSV254sbPRsCLX18bHwKr+vIF4xfgUXRsz0=;
        b=n7OIEUh2b+QvwE5Wq6xCvcaz3QDBLMuPiUeFJH7UPn4KK722ywPU/aZfvtA2ZTQtlJ
         WerdATF+hodOjOhxdsgXoMQhQYrQgcw2xRiFedmTE65YDB08eOo5IDXu+7duxRc4ptUW
         Iz6nYCXOkiIJNEuBPgo5VP8LpTFZQo7z01lkDdy22qP7C8RFJupRM3zzIziKnMR92ymW
         U7jt8bcI8c0vb1fuA21gp4UFGx901ACmcj5KKJBUqdkOnsmy4NSUcNkQ7IaqEq4p/0Qi
         y11v0/BEYHrdqExHDWNLo7Wl6zJG+UDe157kkjkClSLLvH9A3ly++diPX67VEjXCWqsn
         ELNQ==
X-Gm-Message-State: AOAM5315d9s3DNx7n5H9K9BMMaQ6eOzbWL8Go6gyhj4/3jAKyNBv2Wvo
        vhQ8hJcP06WWww3r5ctdBOLSyXY1SybRbpNRMSo=
X-Google-Smtp-Source: ABdhPJzxTcKyQbdk+2iY/eVyI4YIQB4pI4GQrnaFK6YTeV752+tcoAMgZFOckoGCd+y/ZvlSrNvuc4PK6KkPZUUjQiI=
X-Received: by 2002:a17:90b:3148:: with SMTP id ip8mr9515015pjb.62.1634853899311;
 Thu, 21 Oct 2021 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211019032934.1210517-1-xukuohai@huawei.com>
In-Reply-To: <20211019032934.1210517-1-xukuohai@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 15:04:48 -0700
Message-ID: <CAADnVQLm_z5cdXOgUpt0e+YGzMcFUkgE-0c7xYsCERzScDOKuw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix error usage of map_fd and fdget() in generic_map_update_batch()
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 18, 2021 at 8:24 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> 1. The ufd in generic_map_update_batch() should be read from batch.map_fd;
> 2. A call to fdget() should be followed by a symmetric call to fdput().
>
> Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Ouch. Thanks for the fix. Applied.

Brian,
when your bugs are fixed please pay attention in the future and
review the fix with Reviewed-by or Acked-by.
