Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02B32EDE6
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCEPJR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCEPI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:08:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A169C061574
        for <bpf@vger.kernel.org>; Fri,  5 Mar 2021 07:08:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mj10so4106454ejb.5
        for <bpf@vger.kernel.org>; Fri, 05 Mar 2021 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjTJfcQAXeOWcp9QkQJCNvSpKl1Ds2qR5zvC+5VzgvI=;
        b=CpyWh+9m1kcl9bm6CS/WtsL7nEetdYXq/2VszRk50K4nPPdMtT736vpXI66iJE+BnP
         t8M5VYEFLqkXwIEad8lE8fLWYnkJMGaBvSLvWwSvibSg8gdi+vB6cm6o3ema3ymJDQCr
         eF5qaICjAyLicS6JRBJ5Q+SM4a9temU0s9hUkJtp/QsB3KWbgOJRQFC9XJr14GCTDkj8
         MsijxkYsXAqGstSCZWDAn3d9H/XiLJICOFqB2MaG/DRPPjEHUTt7cfphfPT0TdG1PRnF
         TFVOapdBPLFDGav+yFTXhp7qDZ/uuVWuH++U/k3g/b2dk2ztzQksQfKYu6AC3nr/AftS
         zG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjTJfcQAXeOWcp9QkQJCNvSpKl1Ds2qR5zvC+5VzgvI=;
        b=eixfTL0A8S532d/SQIYGlLbrbHKfeH8CozBpeGmwRvx2OJiYxp8PIjF09kY0bXcdiy
         ukcN4VBXYcKmMZ4Rv3N6QC3KMUQTngwR0RSIJmJ2Ye+4hLOTJ+O22nQ4GhjipHrBT6vi
         TFqlax3idTQMJd1kYULoVZwTFjqe/oweqSJkGr6RnpWRNly+92973Nl5DsAvt3jOpeqh
         YE6izsK4to9OHhu94V/pObREjjUbaZJHhv5W9q1X+IJyKH7InPomRofFBAgMKxsltGRF
         GeY2Jkx4g2qXt8DUnHsg0s4vlVg+tUdUEnHWrqpFYQVF3ABcZZUtb5IcsisnZRF5Ut+y
         xZlg==
X-Gm-Message-State: AOAM530xcPMcZ4FDKfz/HxIceVQ+K7tfXwQWUQRklLxT7iatnt1viPu6
        WV9NTKirBpiA5JkAeY0gkV+ySjwBlq4=
X-Google-Smtp-Source: ABdhPJwEPsy6WKFZ3XmIBeFiCW0o1EWj/CVE35pGDzXuy5CGGlRxkBPLomSDHGnYYoXSdH0Wl6t9Ag==
X-Received: by 2002:a17:906:c051:: with SMTP id bm17mr2523815ejb.21.1614956937501;
        Fri, 05 Mar 2021 07:08:57 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id gj13sm1580040ejb.118.2021.03.05.07.08.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 07:08:56 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id d11so2452287wrj.7
        for <bpf@vger.kernel.org>; Fri, 05 Mar 2021 07:08:56 -0800 (PST)
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9605831wru.327.1614956936586;
 Fri, 05 Mar 2021 07:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20210305123347.15311-1-hxseverything@gmail.com>
In-Reply-To: <20210305123347.15311-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 5 Mar 2021 10:08:20 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc_RDHb8dmMzfwatt89pXsX2AA1--X98pEGkmmfpVs-Vg@mail.gmail.com>
Message-ID: <CA+FuTSc_RDHb8dmMzfwatt89pXsX2AA1--X98pEGkmmfpVs-Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests_bpf: extend test_tc_tunnel test with vxlan
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 5, 2021 at 7:34 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> Add BPF_F_ADJ_ROOM_ENCAP_L2_ETH flag to the existing tests which
> encapsulates the ethernet as the inner l2 header.
>
> Update a vxlan encapsulation test case.
>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>


Please don't add my signed off by without asking.

That said,

Acked-by: Willem de Bruijn <willemb@google.com>
