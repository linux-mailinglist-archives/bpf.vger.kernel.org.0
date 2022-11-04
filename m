Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C89618FA4
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKDEx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 00:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKDExo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 00:53:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7B28714
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:52:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so10482121ejc.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jnO5rChcrVcEFNvsuWUGEjI4P5+QqCyHMxtEnHq9pfk=;
        b=FDAwxRiUVhuB9NpLGCpNYyv4gOHJcGj4BlbVMkjx5IkiGNDR85o5dUaj3TpsELbTGQ
         aQCMxq0bbg1kkQ4pIFQ1BdXkBXcD/SXgXPg0r7anN1Lfe9dJyV3ZB9I+X61Srx378X3x
         iS20SrUZAuiCdRfqlsqHNTW6Lrm6wmlFj3q52ZmpPqZKQVTrrcu0Fck/yawmvDzBi+X8
         Vd4/yR9Awi5BiyZC69eCbgZDp+2mJY8bsWAcT7XFanvfuBhyyvujIdOoX1bsrIE3lk9j
         ROjXJYMgbrNlf16xnhn+hMp9ZrfHDHiUWhxFV9sctRVA3KcuQetr1pzpUXzZAG0l5Vei
         6HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnO5rChcrVcEFNvsuWUGEjI4P5+QqCyHMxtEnHq9pfk=;
        b=vg5ot4cbwRr2kGlZgWyZLLs3wMdzufF5fpjhkPaVweev2vEmIK9fhoiWmHauymwumq
         of3YUBnjtDm8LSvX0muUJFAi840fG3d/TnAn7TevbrolQA7gDO1deFvdkEkrneufLWdL
         dkBOAoAFRrcLKvaC8SmGMdBK+RDha8EKlSCdV+bbwxVkzivf98ZwsH2auFxDp5ggQha2
         WXj0bZBVThXXFlaLvx/IwQh7XsddGcMcbpl2t644CtWkg/kVctzuyFJQH+Wx10lGrZg/
         GohppcK28WFFuPwYboR1T+MM4vBGZXrVVTQ2pxXuJeYsd5o7VfD21wh+S9p8OoQZVLFG
         /z7A==
X-Gm-Message-State: ACrzQf2B5CZI/kZbdrfKArkYWOh8vOXEms87zrY0ugmRH8JvbBMX6o1S
        RE5MEYXw98fwArMqirQOSYkNhIWwLml123jVBWobso6E
X-Google-Smtp-Source: AMsMyM6S043ebVoLL/tHCeyn2kkNYA7dXvU+FwrVi6OXNIrsbPSi1j6nlkukjL8S1Abb6c1B3Mw6E8P5/SGNHrTjIKA=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr32826215ejb.633.1667537559432; Thu, 03
 Nov 2022 21:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-8-memxor@gmail.com>
In-Reply-To: <20221103191013.1236066-8-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Nov 2022 21:52:28 -0700
Message-ID: <CAADnVQJ22CO=E2vsJo4f-Y1W-9EoabiCZ4MfDkx55cwPHpwJ=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/24] bpf: Consolidate spin_lock, timer
 management into btf_record
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> +               rec->field_mask |= info_arr[i].type;
>                 rec->fields[i].offset = info_arr[i].off;
>                 rec->fields[i].type = info_arr[i].type;

I spent an hour to figure out that this hunk should have been
in the previous commit. Sigh.

Anyway, I fixed all the bugs I found in the patch 6 and
pushed the first 6 patches, since we really need to
make progress here quickly.
Too many people are waiting on this set.
