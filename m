Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39B5295EC
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiEQAPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiEQAPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:15:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BA3A1
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:15:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h85so17737573iof.12
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxfUDsqLIehn4R5aV3Pw4l3oX63taSGmNwVixbJNX60=;
        b=Eg/fYrOcgQnmavVSkfFr0lPtkmFBMWQ3FhPq6oCjqwDXP+VIMt2VL3q8ZLcuTAs5a8
         zDMncADDjFW9ckoW3+fzMOB8mS9J40LjaDVmIDBaR+eZAl8p0IBL20dsUmP6SStVryBC
         hMhX2gWm4jWf59a0++78v5dq2oT74p+DPMwjgaOVpZTveBCdfaRCoTHB7RQhl8IkpgKr
         PXEQS24b204vZWy+vzkA/KX58u+xmZM++t5kCTvGFSSd7dg6Ti75hBSVU0Idh2QIjtCT
         Z/J6FCQ4Pzts1A/lKNkYiz9Nq5Zzasw/NXaNWDiQOTcpsI2qktf93/eT5cX11YyUdqBk
         E7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxfUDsqLIehn4R5aV3Pw4l3oX63taSGmNwVixbJNX60=;
        b=QdS5qIEf5b/o9CBXHPWqz+xWpUKk4s4O1cIaY0siXRVJHqBOOmfmvMJob+AxzDb2+v
         pTCOD4vpi7hsxtepNmvhCr8QX1LlEVuUi7ftlAmM0zpulSxDM58jHma5SnkmrljkG6ct
         HDETZ/D557ZoiPViQC4zFPtUn4yt+sg3GQrU/FY8OCzPiTOig2RKAWuf+Ppq6s2+t9qt
         LAehVPXA06WVGIITsqzDqdrPdTCBpfHPeeSQfdVcERRCZsUocaXM18tiTu0xUShqt5H6
         8Srjj6ITcyymkwsrNHW7rnbA6tWZH5Qn85dZd0wae1jPbJFyipFJyqEGhFfFHz1f3HDa
         xm6w==
X-Gm-Message-State: AOAM531y5EAA+0K+dEp0fcpT4v1cenG+u0PYn9PRZZdN4dGG8TzYtPST
        uzG1Im5qUa+errKhOBf4uWUZVpX2yXtXLzjwhkZhUd0WoRY=
X-Google-Smtp-Source: ABdhPJxJ2rQ3uRN8l27tOyH7NBBeF5C5tbecA31Ctw40sixdT5xTXQzrOhzNG4j+ZEVeePc9Og9ZnYBm2JmPEE1tCLo=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr8974160ioo.112.1652746541667; Mon, 16
 May 2022 17:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031242.3241673-1-yhs@fb.com>
In-Reply-To: <20220514031242.3241673-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:15:30 -0700
Message-ID: <CAEf4Bzbs04xkvOMvTqzTijJC5NnCRyDd4=y8mrGBFVh8aV1=fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/18] libbpf: Refactor btf__add_enum() for
 future code sharing
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> Refactor btf__add_enum() function to create a separate
> function btf_add_enum_common() so later the common function
> can be used to add enum64 btf type. There is no functionality
> change for this patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
