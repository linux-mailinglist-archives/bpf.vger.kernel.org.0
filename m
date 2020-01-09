Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FFF135F80
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 18:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgAIRl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 12:41:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43006 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgAIRl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 12:41:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so5801680lfl.9
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGlYWgAGF8qoUquyRtx90hCoUVsvvIgSFud8ncEZfoo=;
        b=Reuu3EC3UTGCFyoHH+Fuluy3COFmN61EN1Y3Hlqny6bKH7N0sFwswWyCxTqQm3rYt5
         ej26glTP7Cnq5kSJ0ZyIxM9++BMoJC7meq7i2EKK29HnHdtrjf43zJtdHPDwi3/jkrXN
         s7OHWF/ehaZvPZxCGmOYgRGkEWC9ropBYabJdPAVIvFrGZNAjk3bnNigdzaAjYh/LAPF
         wuNox2EaHg4WcNcQ81MBgOF8cIq+n337z6O82VsxJNblExDDQ1APPCDhCnoyFGO2WqYB
         /LjVFaDniOXPMhjU9bDKhZ6mpnKpFKZ6kVWDYQLBrpSsuCNuvEMT/dj9tqeaeEzunP3R
         6tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGlYWgAGF8qoUquyRtx90hCoUVsvvIgSFud8ncEZfoo=;
        b=oeES8/RePmsKeyFqfNrAgfTwl58jjc1H3naL+RcS7y5n99ocr3Ef66edCjtrN5j7vr
         J2RnQzkA36/IdAePQfLlfUJx/zLVb39yBuuZ7nQd8enIvD97v57uPtY0xLNnwYxnCxLP
         GxsLSBWTUpAI/hQJGRFPzpeBf19WShxhs0IHNiiRHyd42pqQPgXDJsyRQyXq8DWbT6rv
         hmIrSFGHckV2Dl3Uiq1YjXdxNnT4RzgEpY+u2f8L79f8+imStl+sUJToWxONJEuELWgI
         SH7fJlt2plqYVykFDBCeJbsFBTbvcBdmVzC6YR22YQ3pPSiGhPe4HKDICMzri9O0gyB8
         bvCg==
X-Gm-Message-State: APjAAAXtrMroF8E+QZbIV+wW8bYejaCJKRYxnhsaqMGPXWMrpk+ILBL8
        /HEUn0bEExv3d99DVkzf66sFiPmx87PO0TpoQBA=
X-Google-Smtp-Source: APXvYqw3DvB/1jWz8Vjtf65otMhdJVxNNF+sVtIc6TH9vEsVk1ChL4VGcK31bSU6nMYclA8I+izuTHDseRAIOO6XfHQ=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr7044247lfa.100.1578591716252;
 Thu, 09 Jan 2020 09:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20200108014006.938363-1-rdna@fb.com> <67C42A60-A9C3-4B3D-9F27-C38827EDA73B@fb.com>
 <20200108171949.GA96819@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200108171949.GA96819@rdna-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 Jan 2020 09:41:44 -0800
Message-ID: <CAADnVQJOZK380e8=vbkfNuG3xu375CJfrPmWH6Pf7ptB1LngYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 8, 2020 at 9:20 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Song Liu <songliubraving@fb.com> [Wed, 2020-01-08 08:31 -0800]:
> [...]
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 7df436da542d..dc4b8a2d2a86 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -357,7 +357,12 @@ enum bpf_attach_type {
> > > /* Enable memory-mapping BPF map */
> > > #define BPF_F_MMAPABLE              (1U << 10)
> > >
> > > -/* flags for BPF_PROG_QUERY */
> > > +/* Flags for BPF_PROG_QUERY. */
> > > +
> > > +/* Query effective (directly attached + inherited from ancestor cgroups)
> > > + * programs that will be executed for events within a cgroup.
> > > + * attach_flags with this flag are returned only for directly attached programs.
> >
> > This line is more than 75 byte long, I guess ./scripts/checkpatch.pl would
> > complain about it?
>
> I run checkpatch.pl before sending it but it didn't complain:
>
>   % scripts/checkpatch.pl p/0001-bpf-Document-BPF_F_QUERY_EFFECTIVE-flag.patch
>   total: 0 errors, 0 warnings, 26 lines checked
>
>   p/0001-bpf-Document-BPF_F_QUERY_EFFECTIVE-flag.patch has no obvious style problems and is ready for submission.
>
> I haven't debugged why, but this header has plenty of lines like this:
>
>   % awk 'length($0) >= 75' include/uapi/linux/bpf.h | wc -l
>   74

Applied. Thanks
