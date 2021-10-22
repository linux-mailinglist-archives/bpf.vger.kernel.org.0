Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8189D436EE1
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 02:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhJVAia (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 20:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVAia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 20:38:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF8C061766;
        Thu, 21 Oct 2021 17:36:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so1537449plr.13;
        Thu, 21 Oct 2021 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NyLIt9iLg6rZ1QK5VsbahId9/COsWCMPmtuER6RfUg=;
        b=bplMtp7hlQ2ltpCHyZDdZlhsDlgsw1Es32HK+cub4W72PQrTpsxbebomL2a0G7o/tU
         Qhfuwg/SoWG5U1/bi62Z6YHhMkqV8nnrYIYZiYn4R/jFbdxxKpAGiRNHdJJ49ieqoevf
         XZ7mkuig5cINTG8YkAyzLG3RIygG6V4gikqyUkDwJEM9kIcF9rg0z8Yfk3++atPCE20Y
         goMdglQAlDaw1IgrKVPJjBLtLsvpOlchs/b1/g1+tztNH0SAesb0W8v8S/JxfTQl9jHB
         rMvIzW8V4QEj0gEVgAhAYuARQHNGWN9uvoRCF4EhPzuGiosPZ0K8gIDbO6inUiSdvYJU
         fIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NyLIt9iLg6rZ1QK5VsbahId9/COsWCMPmtuER6RfUg=;
        b=Marb2D6QCccHUnZtaeGWgFN35rV9ecOaNGCaughtOHxzxv/B9zcIkBudZUkRSScbPH
         CBx1SGY08jWuLxDwZm5qqo0OS0iG5grdkxy6earyR7b0ktf/4QZre9+seDmh80fo7v8q
         exrk4PZ6xyKz3cFErWGOLILZAwINRud7hkTQGBJbD9q4pu7KCQfKMogUQRVbVt9stOQH
         oJBvCsp/wR5hWs678xYuNU+CUxFuD9sHLAGOYuCAdNuqn4mWOSZaRgncSwWlZ+h/DYye
         9xEz1WVjbdHMM9vxrVeJIFoRU6ldRayatuY1F9MAD+LXtISK8KOw7RrxmHWwVxsD0EjY
         ipHg==
X-Gm-Message-State: AOAM530PphpD0sl3j6+or9JJXHpvoiSC2DwPuFBsYi6uuA3QDMWQDbRr
        +3TiE9WjsnKu6EGXdhh7GP23JVm+L/19geOhwas=
X-Google-Smtp-Source: ABdhPJzx+ge6JKoDTskH6nB+UW4cv10c4x1D7XvWUxpTXRXFXz1xIiK+P2rRY2QiNoMDW/dHjczEOmKroX9vu7zCYew=
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr9954808pjb.122.1634862973288;
 Thu, 21 Oct 2021 17:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211019125856.2566882-1-zhudi2@huawei.com>
In-Reply-To: <20211019125856.2566882-1-zhudi2@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 17:36:02 -0700
Message-ID: <CAADnVQ+MLy8Ub8FL4ak92Wh+LqUg5npfHc_u3bgDqk-U7LB3Ww@mail.gmail.com>
Subject: Re: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
To:     Di Zhu <zhudi2@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 5:59 AM Di Zhu <zhudi2@huawei.com> wrote:
> +               break;
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +       case BPF_SK_SKB_STREAM_PARSER:
> +               *prog = READ_ONCE(progs->skb_parser);

skb_parser?
Please don't submit patches that don't even build.
