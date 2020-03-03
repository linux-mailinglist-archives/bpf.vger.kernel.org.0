Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD427176F21
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 07:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgCCGK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 01:10:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46123 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCCGK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 01:10:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id h18so2094157ljl.13;
        Mon, 02 Mar 2020 22:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L44R33MZfBo7EJfh7yHeMAVpYiCz+bW7Ff5nJ/4YCbA=;
        b=mDGa3l0iB+Fa9PTGs6OTbYeBy/ampfYZk7C1RYlTpL5OoFt8b+uXUEpUEXcHVdqIva
         SRzcCxP4HA2y5CE4D9xgZexYgTdAIt8ewGax5jf2aorMSiYG1xJuKodHR9cK8/K9JGld
         zB5zLyi96CN4BPi4qGNMSu5ctyHtYFVehiLxBW8BdT58O91MwPqFrbTkwA4ES48rsOSV
         U68bhRgJwqRBi0KuLkhVyFr8xQlrt20MWM4Sil0TwVXHrO5SWRVmpBSCdOM8GecUKa7t
         xWJ15KBZhcS0wuSrm0PnZT90T6dD0oMNJeFqW8AJflIDNb1vIuwPweEM8CS5Yij5QuIG
         8hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L44R33MZfBo7EJfh7yHeMAVpYiCz+bW7Ff5nJ/4YCbA=;
        b=tupakajuELr6tfiGRSrrg9zs2Tkgb24Z4zswurm8lIyP7XZjVlvdajv2kUZTKxcbWU
         PDUPczdRZ/mkIkivamlzOivZYoZSPWUKL+VZYAP/Pykza7WpCJxxcOi+pruSoA3Wwzti
         OH9ZzizFNq2MjWaaZJeJ86Q9ViSURYD3vLe2LOM8LNYrCJKHh6ZYYM/k1ZAN6syWoxSo
         eWR5VOhka2IseYyN1AZYMRAMtq7aRt6NFcygGAWZRXPepRK2JxxzinNZ7ivcWCKIA7kD
         e8FeuKhP0VO1q0TZW5wmNAnWbKiL5D8KVasSpFVAP4+1L/xNt82SVwgQMRx8mSV+Bh64
         JbCg==
X-Gm-Message-State: ANhLgQ3pL15e00vOPUNMJHQOB3uYHzf0ez9G39XeGWCT3EiO4bd8aBDA
        eEDxw26jB52GiI6NoOeYYrUDS2zNcdnqLzeYm2wfYOga
X-Google-Smtp-Source: ADFU+vvBKj4kk/DGPu4e3EEo1JpMgvtQZJ67R+QKzPSOu5NVGyjMBBheD6boVCTDo8w0Yjt+bdDfmDw8ZFlvl+4PJz4=
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr1492785ljh.138.1583215854320;
 Mon, 02 Mar 2020 22:10:54 -0800 (PST)
MIME-Version: 1.0
References: <202002242114.CBED7F1@keescook> <202003022046.4185359A@keescook>
In-Reply-To: <202003022046.4185359A@keescook>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 2 Mar 2020 22:10:42 -0800
Message-ID: <CAADnVQKgQWmMgcxynzTRhGv1dZ=6oJDB79txrc8tmGy5sPejTg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove debug info from kallsyms linking
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 2, 2020 at 8:48 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 24, 2020 at 09:16:17PM -0800, Kees Cook wrote:
> > When CONFIG_DEBUG_INFO is enabled, the two kallsyms linking steps spend
> > time collecting and writing the dwarf sections to the temporary output
> > files. kallsyms does not need this information, and leaving it off
> > halves their linking time. This is especially noticeable without
> > CONFIG_DEBUG_INFO_REDUCED. The BTF linking stage, however, does still
> > need those details.
> >
> > Refactor the BTF and kallsyms generation stages slightly for more
> > regularized temporary names. Skip debug during kallsyms links.
> >
> > For a full debug info build with BTF, my link time goes from 1m06s to
> > 0m54s, saving about 12 seconds, or 18%.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Ping. Masahiro what do you think of this? It saves me a fair bit of time
> on the link stage... I bet the BPF folks would be interested too. :)

The build time improvement sound great.
Could you please resubmit for bpf-next tree?
So we can test and apply properly?
Thanks!
