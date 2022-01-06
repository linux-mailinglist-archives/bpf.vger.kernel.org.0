Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609CA486DB5
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbiAFXZT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbiAFXZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 18:25:18 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298EC061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 15:25:17 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y70so5071357iof.2
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpTF4Rc8zt92fNCmizzNXbtTYUUcDhJEzx8Awb8C7uA=;
        b=Paa6hl3UCF1/iGiGKSoySWzo3D/xHMcN+0kQcwsn1aZI9400qLgMB87cSnPN63bmDr
         fkacslBMbl81WnNpKo7er+6JNwpdiTcbO2SdrHMbwA66W5NIFWTsVLuOJG/dihjH2hFl
         XLVRPXmOWzpzH3Oa1oGZn4qJHPb7en6CY9BXuU68Ud3c5lIt4Yzc3MHsNmBbb1KSrD9x
         KGrG6IKYhGtDaXniOYdSNwa3xupZPJsODcRM14pZnaJvcK5ziJlN6wDH++HPd14v+jkT
         wXeISe7+tjNv6+AbNOiapZUcIkcY7aGUUMHxWaafqBtMJTDizSkKSq0sKIwqUzCr5Rxk
         9OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpTF4Rc8zt92fNCmizzNXbtTYUUcDhJEzx8Awb8C7uA=;
        b=TqggIjvCZaf5G6dMv2sm0wz2RtLJw7AsGgv9im5uCd/EO/V0+fxG+VQK3eB8rDVJ7K
         i2qQbahR5uytXrZc6IKY/79kLAfx245V0/UkJeRRfjC5RhXSupMzkcf1AETlRH1ILPU0
         vZlpqGbL4xTvFjbLvXpZwmqauxaRvWbuDb3PVSuXF7yQ2T/7r58GZadJihsZv9qlINMz
         sAYRFn2BAD5z8gqv7yHrc4iDv23RSeQcVeF7LGvm/+02TV5SKYz4oGGqAM95bRrY9v46
         G6XdXBK8dcHakPZhKMoY3/KvXJAgjI9Av4pUwRtGNbVZp6aiGiNhXPkvTAQtIfu681oL
         zDkg==
X-Gm-Message-State: AOAM532oIk9PfJKRwear3j85yotuV+mJUMMi8hbQQ4oTGRzct6n9lnff
        qEIk+HJqBoVRi6HHDfqn7FmZcWdB6hnuIkjFyF6PhIQ4
X-Google-Smtp-Source: ABdhPJx6Ha5h5AA36oSD4wfYpiHIZb4U2qQ02ckBe9uEAEDMvNu1sUhu1A5Gk7OIs0b/rCyyGSEPjU0/80Xd/wGH0ng=
X-Received: by 2002:a02:ce8f:: with SMTP id y15mr23982922jaq.234.1641511517406;
 Thu, 06 Jan 2022 15:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20220106201304.112675-1-grantseltzer@gmail.com> <97f2dd15-91c4-5fe1-a706-c4433f9d68be@fb.com>
In-Reply-To: <97f2dd15-91c4-5fe1-a706-c4433f9d68be@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 15:25:06 -0800
Message-ID: <CAEf4BzbQEJLSk3+EwoovxWZzEWs0oJFwr5C82CrSLRWOZix9cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: Add documentation for bpf_map batch operations
To:     Yonghong Song <yhs@fb.com>
Cc:     grantseltzer <grantseltzer@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 1:57 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/6/22 12:13 PM, grantseltzer wrote:
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds documention for:
> >
> > - bpf_map_delete_batch()
> > - bpf_map_lookup_batch()
> > - bpf_map_lookup_and_delete_batch()
> > - bpf_map_update_batch()
> >
> > This also updates the public API for the `keys` parameter
> > of `bpf_map_delete_batch()`, and both the
> > `keys` and `values` parameters of `bpf_map_update_batch()`
> > to be constants.
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied to bpf-next, thanks.
