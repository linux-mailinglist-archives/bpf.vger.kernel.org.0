Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3166CDD2
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjAPRmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 12:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjAPRmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 12:42:19 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB912060;
        Mon, 16 Jan 2023 09:20:00 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4e4a6af2d99so70026297b3.4;
        Mon, 16 Jan 2023 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSDy5+Lu3Bo+DDYaqmVb/Pw3SBJ/v/yOU6HVZ56eNb8=;
        b=FbFSLfOaDxu8GpimKj/qFPooQ75YKaZQzRWFdRzw0GrSipr7Gm1UGDfAw8WlcbFw/p
         4VaYfym2giC5bEOv2OLuQeHEtjW84fHSAFPdCgpoWLQM5C0XIkYpqdA0D9OSJ/scHUxG
         XTppmRqnScx0c1IS/VXrszVkTm2l8ylbgiHTJ7h4KcNH0dXx130sLyAmW3CIN1Bdg8px
         6X/RKEqX4IZfuKhGu6mMP4Q8iMJJzlvs5wcD6gvecqgKYr5xJthmpVB7wMpA/X76oTOt
         wZp55gksDolb7U2R6Gs3YCgym977UovDYXTlqA1Vcml8KreaUUcH14LGu0mhaR9GHhfD
         qy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSDy5+Lu3Bo+DDYaqmVb/Pw3SBJ/v/yOU6HVZ56eNb8=;
        b=TvhyZ99O8TxdDIC2V+vXgu794gNCY6Xy7//VuUwumgVakOxUNUpYgov99wSd3MAxnz
         h/1FWsnsD7H7OI95mvtRfV97JG2DNcUmxCae5/X5idzd+UEG0xZXmDxE0DLgiEXtZzRa
         yC0rioHOf+NMWE35KpXY/dwhFcZbtE+K7FwmYRhSrSk6qcBfUvGVB2B4lcnrEDRqVeEw
         76pq2Q6goEm4dm4f9z2J8Qc7+JpyFWBmwvFXaRcQlQf+JC3kefNIoQLIv6l7xm2JVQx4
         ZAMxNh8rXHGBWrgqSXtd5CzTL6FMvWsC8v/KXZR4c/oT6+wFS5N0THbTJFqhey42srzy
         AFAg==
X-Gm-Message-State: AFqh2kqU7wPxPzxLjPgiwqaoO4st2Og7bXHUpfXSirETcdQREQVZOl6P
        fwzDHmMS1i+5DLRS0HkGfwikF7Z91sPX+bRGTK8=
X-Google-Smtp-Source: AMrXdXuzzOxS3w/R/+lF2IROyREub40igQxZ3He6eVZu21BAw26MbHR6S3tN1fWIPEQbXDi6oC9Cg4rgv6xxrf5SxkY=
X-Received: by 2002:a0d:c644:0:b0:3bc:7270:cb70 with SMTP id
 i65-20020a0dc644000000b003bc7270cb70mr13966ywd.83.1673889600151; Mon, 16 Jan
 2023 09:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com> <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
In-Reply-To: <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Jan 2023 18:19:49 +0100
Message-ID: <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Eric Curtin <ecurtin@redhat.com>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
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

On Mon, Jan 16, 2023 at 6:06 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Ok, if you could ack it for the rust bits, we can route it via bpf-next.

Of course:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
