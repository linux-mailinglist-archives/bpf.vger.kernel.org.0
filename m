Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69BA40B09A
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhINO3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhINO27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:28:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DCC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 07:27:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id i28so24228068ljm.7
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/W1Q7I2sWfZF+03tHM6TXv8pifWGyQcPeCcSZN4rQUg=;
        b=IuSFSg4CoOlNtoEO3oxCdza4x7VXfJOQKc9GWTr5S/PJl6p05r29gUihtbUtvMJEWq
         8Qp28iVm+r9hm0JngAGYU1zgXDn3WV8L4jxLOJxk4pez9MiZT9KdEQA8u+9QDQPYTKT2
         t1KEB8xVxCJyCG904rvOmAmBOa1NWFW9Da1p89bmqEuZ0ZgbOuuL3Kr3KiDbAmB0HfpK
         gpNI019cdQIMuLtuPLQvIuKZIvXW63/prPvFuJxSUfw7RKwOKhOp6h5wuUPa4AzOPnyn
         mhGi1NWlo3rf08pLC5wb4TIASk8rljh1tkqiaR1wRAxO/kSSmNvME1uZUxyAmRC86iTm
         LWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/W1Q7I2sWfZF+03tHM6TXv8pifWGyQcPeCcSZN4rQUg=;
        b=cXY49yCCpmtoiJdSB9/rvNpiqMMPJHULyVzfWnpedbR2ASvMG1sgEPtcHjND8KhTCg
         AlOsnwUiT+O8PPlc9uxIESRd28bVN/u50AZrIaGjt5XwXJEdqpNJcpHA+OvDV8eQx5Eh
         Vb8/hJiBot+XiuRpLc5ZYo7G7NNJjCMDtBQtUKIM/wg8f/DvPnm4eAgUTIWr5s9A4Y9f
         sGCuKbs1FDS89S9xOtPnK4bK6h7FWsDxGkxQy6p85F4oe8tbxos9zsSqLiedQ3gMp9bb
         uc5SAnyCoL3cFpyql9snre0GlSPANNL0vMkDeSj6bADKGVxhmjWmk7I4w016hbOnrTqe
         HNNg==
X-Gm-Message-State: AOAM531GMkPVUcMSEgY+q9I2EAtPZM+cZrdrHPlSIywjZIb24srAYBnC
        q0Y4oJjUaXJTTdUFfip7jFqw6WyfWn03qNFthAy3li0ilQo/gA==
X-Google-Smtp-Source: ABdhPJw19gc7dUbTAJHk7ykhxLu3cnAM8G/LzNhxyRASRx+ls1CQyyevH1ynjlR6CJTozCeIgDUxdpMLhyZ+jtQSJ58=
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr15842854lje.148.1631629660644;
 Tue, 14 Sep 2021 07:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com> <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
 <1EEF48CB-0164-40B3-8D56-06EDDAFC5B1E@gmail.com> <CAEf4BzZYEi_FS_UT9Ypp5iNL60t07KT_8DyQaSzSCNN_nfC1NA@mail.gmail.com>
In-Reply-To: <CAEf4BzZYEi_FS_UT9Ypp5iNL60t07KT_8DyQaSzSCNN_nfC1NA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Tue, 14 Sep 2021 10:27:14 -0400
Message-ID: <CAJygYd3DZKv+2ee3_Bd=Pqa4j_C1UQ34Ga_0vNE7YmkfWz6X6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> +static int poke_kprobe_events(bool add, const char *name, bool retprobe,=
 uint64_t offset)
> +{
> +       int fd, ret =3D 0;

This patch introduced a warning/error in CI

libbpf.c: In function =E2=80=98poke_kprobe_events=E2=80=99:
648 libbpf.c:9063:37: error: =E2=80=98%s=E2=80=99 directive output may be t=
runcated
writing up to 127 bytes into a region of size between 62 and 189
[-Werror=3Dformat-truncation=3D]
649 9063 | snprintf(cmd, sizeof(cmd), "%c:%s %s",
650 | ^~
651 In file included from /usr/include/stdio.h:867,
652 from libbpf.c:17:
653 /usr/include/x86_64-linux-gnu/bits/stdio2.h:67:10: note:
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 4 and 258 bytes i=
nto a
destination of size 192
654 67 | return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1=
,
655 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
656 68 | __bos (__s), __fmt, __va_arg_pack ());
657 | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
