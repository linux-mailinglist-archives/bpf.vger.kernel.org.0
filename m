Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578752289C1
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGUUXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUUXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 16:23:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E9C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 13:23:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so18053lfi.13
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVmYJGWAOhdLgT1INJPBrgzpsFS0tqIjZDlRWSjxvME=;
        b=qouiwDUX248m8k2I/mxj7KpUCQJZC6EhzbEDidKKttSd/GbzzLTgKBbSYDcK5//xIz
         kRBnjIGOPUegTOReQrE4+xTDzF9AAdoAhblzvOovfnQtuErhym6ZigKIxQaDErNETmTe
         NowZ2aeP2Sy6KbcnJQJRoRg12pocoapnIx4ae7aPCJJJ/MK8koIxUyqzR6ZKWjRq3KTU
         jUUD7R9RFnYn8zpXE9HCDp216kfwew9upCCsHcOUPY+2wI3x7ZCt1/2s4FyyKINzPdC1
         G7DygVK75TbRPWJT5C7gYP+6SaP7i1vHyognZFpKHXqTBmNmndVzCs8tm7G7ALc132tT
         5x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVmYJGWAOhdLgT1INJPBrgzpsFS0tqIjZDlRWSjxvME=;
        b=G/8PbnUmrGzbBo3rOa+1g/xmdt59BXxDMh2R6vacV0jIlrlEzTg5Uecf7zwVoLw3oe
         Rcc8AzQbBlNjuVZmGDop9MyCrLiIx5x0cK5GWkI7O+qS6ccn9Ki6IX+6wfOQ1/5Rbb4V
         /34sW0ngVi2eTvOzEcdiW5PeWxGCZ7GWZRLF8DC1mDmTvQEq725Gxtks1BX6OX7LbQXf
         jHTFp8DoyahB8WZkP0Prsa2roxiw+71pZ+oJbZuEvsjTFMYywJ0xAfZRosOtsRsYkvT8
         Mr8aJE/RQXDWKnixFI5uDGDWR1tDAS3LvIyTYaEslSYQR53/rbe/W8aSQuqPGchRBdtm
         q2Xw==
X-Gm-Message-State: AOAM530GOR1QosDpn1NuoGgpIfW5I2BpmTHH0eDjQV5gw7y2YgBLZ6Tx
        LQfsnzlJhA8QeNFRG32FQtRWQ2X5PAlwFxdNi2c=
X-Google-Smtp-Source: ABdhPJw6gObb4aPhJqWgXaAx59kW2rIxXId5o/+lxUBnU0E1lfiaAV6CkSNy9sKlbPgNzTwpqTNqpKRvIITQoAgyb8g=
X-Received: by 2002:ac2:425a:: with SMTP id m26mr14303021lfl.73.1595363010026;
 Tue, 21 Jul 2020 13:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200715233301.933201-1-iii@linux.ibm.com> <CAADnVQ+fbfAEarcjJCeF=7ssBG2rpxzLZkVT0ZW7k6HWcN1uBg@mail.gmail.com>
 <20200721201619.GA4070@osiris>
In-Reply-To: <20200721201619.GA4070@osiris>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jul 2020 13:23:18 -0700
Message-ID: <CAADnVQKaHRrw6V5bHCfNfHr9DAmJxbDEJ8n+CUfPpxgt0oOpkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] s390/bpf: implement BPF_PROBE_MEM
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 1:16 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Hi Alexei,
>
> On Tue, Jul 21, 2020 at 11:01:22AM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 15, 2020 at 4:38 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > >
> > > This patch series implements BPF_PROBE_MEM opcode, which is used in BPF
> > > programs that walk chains of kernel pointers. It consists of two parts:
> > > patches 1 and 2 enhance s390 exception table infrastructure, patches 3
> > > and 4 contains the actual implementation and the test.
> > >
> > > We would like to take this series via s390 tree, because it contains
> > > dependent s390 extable and bpf jit changes. However, it would be great
> > > if someone knowledgeable could review patches 3 and 4.
>
> You probably missed this part? It should go upstream via the s390
> tree, plus this version is broken since it crashes immediatly if KASLR
> is enabled.

Ahh. sorry. will drop.
