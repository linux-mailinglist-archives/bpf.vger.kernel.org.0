Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A892E0F4E
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 21:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLVUSe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgLVUSe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 15:18:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4DC0613D3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:17:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y5so13113849iow.5
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zLJLP7tCAUwtOH7bnIcDYFQtzmD3kgV+pxzg546b1k=;
        b=XC6Br8D+89r1c0JcPMrO3nO6KaRrr8ocyrLF47pEfYQUJe3E1u/P6NZigHGMMumbIK
         HCdQ77TvBkYou2+v7emwbJdr7rc4fVDh2qnGN/1YRKfbuGAcnhh3b9sBd3fOg/TW/8B5
         k1YCh2Gzk/m/wddzgZnfSjui9OSQhIdclFkY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zLJLP7tCAUwtOH7bnIcDYFQtzmD3kgV+pxzg546b1k=;
        b=Tf/3S3W25a0BGT4W+Wj5ZrvzrR2Pwwj07NWMY50YMZKsXBFE+XE+Vj9N+0qlZaSOUr
         ihPQDn79MxlwfTNMh+YXOGHtQNQsalL/GD56xIb16N+oHiEHQcBNxPm2HQxt6l2N2UiH
         nFMwoWQglyfbNRyojjpbaowP1sL2NmVnsQ8zT/vFKNknTBQ5EU1DUvdtjObeefBuZvMI
         iJ4qtS2C0QVEUBRvt52evPfI5hRID0zYj19bPOYy9R1KEFoirnA8T6lBAjwgP+a+Gqsr
         WjaKOXS++GkgxRdF+7zMGwPIcHvPh+3DkLhISPvDtX1CY8rJT1wrJGhSTmngXtaQz8m9
         X21A==
X-Gm-Message-State: AOAM533ifBq7UERF2pQXA/+RJrZZEFDSyFh0E02VSysEawICVjbk5reV
        Oz7WW7K3tL7jG1olxgpctbQP1a/i5AewBNFi6vUQlg==
X-Google-Smtp-Source: ABdhPJxodNAzCORMWfMCbsvvW5DAgOp02Nbq+NPpU5r0VLJ57U4m1OtSsaDEzp4qiIHerc0HSaKfUi6EmT4jhIFkZU8=
X-Received: by 2002:a6b:8b88:: with SMTP id n130mr19051497iod.122.1608668273230;
 Tue, 22 Dec 2020 12:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com> <20201222141818.GA17056@infradead.org>
In-Reply-To: <20201222141818.GA17056@infradead.org>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 22 Dec 2020 21:17:41 +0100
Message-ID: <CABRcYmKBgQYHezKVaLCVwUvksFaVuU7RHW8VVjM6auOC_GOr+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 22, 2020 at 3:18 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> FYI, there is a reason why kallsyms_lookup is not exported any more.
> I don't think adding that back through a backdoor is a good idea.

Did you maybe mean kallsyms_lookup_name (the one that looks an address
up based on a symbol name) ? It used to be exported but isn't anymore
indeed.
However, this is not what we're trying to do. As far as I can tell,
kallsyms_lookup (the one that looks a symbol name up based on an
address) has never been exported but its close cousins sprint_symbol
and sprint_symbol_no_offset (which only call kallsyms_lookup and
pretty print the result) are still exported, they are also used by
vsprintf. Is this an issue ?
