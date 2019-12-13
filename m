Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803A111EBF7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMUlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 15:41:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMUlg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 15:41:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so61832lji.11
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwtBfxljK+marrwbQ0NULSp27IRMHfScK8gXlrj596s=;
        b=EjxLI9wq4Jh0Gh+YXKpI+qzi4PNgdcj8+hGlxDV2gxWKCApcI3odGuvMtMqixwSnTl
         px9h1HN4F1kooFk3JO2U3WheXBA6ss9sphWc57fWX+eDV4WV98UooYwvdwBkLpXKZ9O3
         F7An0bChQsWI77IHKq7zKs+NEsK5+yaiVgQ/6H4nAIXgAcrLQCNaD3fPhBmOspy7Zemn
         fdpPycF9umQugckymjOeOpUUXV3h03SbL3k7ne6H7qVIn5IcLdwpDvdobx0a9a2a7oIg
         cqGqdYDwXKLGlgcBRldpTWjRrBFYkiq+ININFurvhvikH5m6/Rkv7k6oLutmkEpK/JLl
         UC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwtBfxljK+marrwbQ0NULSp27IRMHfScK8gXlrj596s=;
        b=TD1qmph1yNsBnGhqbga7lhtbV0dDL+/GAJsF/6GqTspP6SYBmqUmOCbSSe84kD8ged
         0/+wo0rvk0yAIqaLH0LwQtVexeo1nAfnPh3uTwYZ1Vz4Xdwl2fOtO4DqHx2C0Hot/9Cu
         M9QFncSYGKg+Hgp8ZGkeFAeMKAaWNvpIyGN9Sp7Xv4cFyr8YDr8iBpjbxPwSps3AUwBt
         NAXHP5MwF9rmu3Y1+cs7b2Gq+oe4LpodA1kb72vvW9dYsuhiVCHSoypTLKHEZvzzqChy
         fE35WQJnx2uDdS3/5tHP7Hx2Mnvgc0g7u8KQPwE7o+Pv/XxLNLgviKzgG1r+iTP3haZw
         9I2Q==
X-Gm-Message-State: APjAAAWwuKrX2f2KE5HbgAF0s8hpy7DHCNMV8WL0EbyVdDPNv0Ml/f7C
        aj426fEWidyv5fOf5v+dXBKvhIvG2Coc4LtZUrU=
X-Google-Smtp-Source: APXvYqxjiWMIkhQWR1mG02HcBiRqXZNGb9UkrHVXlaHljXvDS5qUPFXAtFvJZGrgnUhdFYzB10RUeWr2qIhgjKcVDq8=
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr7190189ljj.51.1576269694700;
 Fri, 13 Dec 2019 12:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20191212102259.418536-1-jakub@cloudflare.com> <20191213053635.4k42db43u6jbivi5@ast-mbp>
 <20191213163035.res63motipcpkbqz@kafai-mbp>
In-Reply-To: <20191213163035.res63motipcpkbqz@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 13 Dec 2019 12:41:23 -0800
Message-ID: <CAADnVQ+_4gCavtPnArq3RMWB4ZQNefEZeBMft8+6aSXJqwSAeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] Switch reuseport tests for test_progs framework
To:     Martin Lau <kafai@fb.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 13, 2019 at 8:31 AM Martin Lau <kafai@fb.com> wrote:
>
> On Thu, Dec 12, 2019 at 09:36:36PM -0800, Alexei Starovoitov wrote:
> > On Thu, Dec 12, 2019 at 11:22:49AM +0100, Jakub Sitnicki wrote:
> > > This change has been suggested by Martin Lau [0] during a review of a
> > > related patch set that extends reuseport tests [1].
> > >
> > > Patches 1 & 2 address a warning due to unrecognized section name from
> > > libbpf when running reuseport tests. We don't want to carry this warning
> > > into test_progs.
> > >
> > > Patches 3-8 massage the reuseport tests to ease the switch to test_progs
> > > framework. The intention here is to show the work. Happy to squash these,
> > > if needed.
> > >
> > > Patches 9-10 do the actual move and conversion to test_progs.
> > >
> > > Output from a test_progs run after changes pasted below.
> >
> > Thank you for doing this conversion.
> > Looks great to me.
> >
> > Martin,
> > could you please review ?
> Looks awesome.  Appreciate for moving this to test_progs!
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
