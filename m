Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2AB2287E4
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgGUSBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUSBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 14:01:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F9C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 11:01:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so12189499lfi.7
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECyVVXtzk/VW0uSr2zy8VKPQQtG8VWOUvElrwasMQGQ=;
        b=nub45hWIwYlW/AC44/NrR8x6+9DfxdrGT/hXhlWMfSB7uq7GMzC64e1KS9FYoaPcYi
         rjoymJbFxdAj6sOuR5TLC7PX46QVs12bv3qa3YzpCS4lTzXRDlNrVhsFpIum3zfHNp/9
         OzgUyW2AlfntRM8T3oIyuVdtvDx7+n8KJwo34SVG7lvkjVse/iZCUWs6r5IciPjTaWCX
         WqUm0E5XPxHJTI/CzXcnLRjZvFVaYHrQBelbAgYXY9d+tT83DLQwpcQGwf/4hbZ6Tv8w
         gdkk/ukxtiqJWoE0FK3S+csce9MOL7kr/9L+AcccbL58tHxyaUcZAUmUONBAyykFr2y/
         kHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECyVVXtzk/VW0uSr2zy8VKPQQtG8VWOUvElrwasMQGQ=;
        b=nHic7QWVFX0STNcII5RSSzVgFiTQiuSTWRssymvCZ4w6Rt62uW22/XUK2dGvPdJX2O
         UHExpGAtXs7MK90Gfx+Ft62b4sNCQDtEyXn3uFgDeTLNYwfezWaDnMOgRGWwPeOPr3B/
         C1+IlFGLhkBf6Wc2pJsVdjg/KDEKD9BKTleCpRxvtzkF9Lmr07Qg63bVvcIjnqdoOYru
         V50y+fKwhXrfn2gVrUFeVe714yNFRlJJc3EPIoq594hj8cEIVtmNnjVTdqe5pCyup5kA
         I3htKBZ7izvodujaobhkSJxSAFGaGBwN4Vii20i0ZoPoTqL0fci3GjDMILzBeWfDZ2NN
         ZoDQ==
X-Gm-Message-State: AOAM530e1amha+Oj2SYf/gfgcnLS4zPloGnBW+H2YpGCIGdYdXh39vLb
        tJwyDwUxEPzrgrEnreStlLnCZvIwPzgQGr80IJc=
X-Google-Smtp-Source: ABdhPJwzsSCIujxOUOycUU/3v0IWAHFC6TQynHWuJYIP/00Mh/qgkq/+5th3BnDSi7Ri5h5dQN7fmXbM3ZfqAAgcTUc=
X-Received: by 2002:a05:6512:49d:: with SMTP id v29mr14258428lfq.134.1595354494351;
 Tue, 21 Jul 2020 11:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200715233301.933201-1-iii@linux.ibm.com>
In-Reply-To: <20200715233301.933201-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jul 2020 11:01:22 -0700
Message-ID: <CAADnVQ+fbfAEarcjJCeF=7ssBG2rpxzLZkVT0ZW7k6HWcN1uBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] s390/bpf: implement BPF_PROBE_MEM
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 15, 2020 at 4:38 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> This patch series implements BPF_PROBE_MEM opcode, which is used in BPF
> programs that walk chains of kernel pointers. It consists of two parts:
> patches 1 and 2 enhance s390 exception table infrastructure, patches 3
> and 4 contains the actual implementation and the test.
>
> We would like to take this series via s390 tree, because it contains
> dependent s390 extable and bpf jit changes. However, it would be great
> if someone knowledgeable could review patches 3 and 4.
>
> v1 -> v2:
>
> - Add `jit->excnt = 0` in order to fix WARNINGs and fallbacks to the
>   interpreter when running extra_pass. This wasn't easy to spot on
>   bpf-next, since tests passed anyway. However, on v5.8-rc5 this led
>   to panics.

Applied. Thanks
