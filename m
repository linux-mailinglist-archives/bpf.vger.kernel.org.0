Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812571413E4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgAQWDL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 17:03:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40350 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgAQWDL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 17:03:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so19468714lfo.7;
        Fri, 17 Jan 2020 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R3Ww6earNCtZebZRc9I5yA2IHJbRCUq0sChrfhPDZM=;
        b=FV3USbmXIYjOHA1i6XJ+MUUP92JtMmfzVKBIZZtlt00LOFL4fGpIJ78Y4d86nlR7G3
         sH47a+3DCTNswhjXYeHDCUfCQC+NdcfVw7h50KC3rHgzi+m0OBBiEqtve3jN+hLhHlaz
         ABwTFoDWsiUChRJ40eSVJvSENp4+7WS7Sbhb6wQyLAhP82TFJZiNrCHdBjFMPax+/8Ue
         nFNYhlgVlomc1tNTpsxrwdS+uRNspCbcFxRWkh5Oc57A0F7hHEdrmbJLfxRCB4ULY5Ls
         W8BoFJ7xXUcx9eMNK96OEsjFlGm/2KXv6sSsPLp09H2JKn+Su8IzCvS+QtruF/fq7DSU
         JafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R3Ww6earNCtZebZRc9I5yA2IHJbRCUq0sChrfhPDZM=;
        b=tnm98YB4cjv2tl1v5NVb4MAIziTG63ADkHTuDIMmtDt+BkZIcGln1Gb3m/+bTIq1l5
         5VohS0hVPRImuvZXdvK4Naoa9cNF+eXCKesFq7u6wlauJID8ZtCJ2A1A1vi4eDTzcszo
         BZOhaBJIPpltmJTyv3Z0/Zj91bWY0ts1IMzq8vHmiwkU6PXgC3LRJ+KHkeXJLQ8HRZUA
         nFw0Wst4fzlu/gSaa4n5/eoFl3ekLdk4JlS6RQ0CfOKGvlGD6dqBZdyRaJX4FgRUEe4D
         0h6MtvztwUqTelcNfmnggcR3XYgS7SQ5HVPVn5sB62xvehXOLZif5kZigktFi2Jmh8d1
         tWlg==
X-Gm-Message-State: APjAAAXcVgIm/CW/wDVfvrPNIjhzD0ujF17JcPC27lRc/8XSVlNlZuMF
        +9GrDOFONov84GT/74+yye91ktZVNidSh9fD3Kk=
X-Google-Smtp-Source: APXvYqy1//URi/l3A2TCsVlmrW8AuNR+fyzLB0N9QxT1g2GwmoaL3MeqQwGb1ucLp4z664LqNXsa5n8EE/+aIvECesY=
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr6500197lfq.157.1579298589568;
 Fri, 17 Jan 2020 14:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20200117212825.11755-1-kpsingh@chromium.org> <CAEf4BzZ1STEe-RvsLYBccXXLSip2N49cgjE1kE+PvnQaKipM5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1STEe-RvsLYBccXXLSip2N49cgjE1kE+PvnQaKipM5Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 17 Jan 2020 14:02:58 -0800
Message-ID: <CAADnVQJhooV_QKxx+yxu4vo=4+-ofxpPG-edPAuYAG-qyN3Sqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Load btf_vmlinux only once per object.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 17, 2020 at 1:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 17, 2020 at 1:28 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > As more programs (TRACING, STRUCT_OPS, and upcoming LSM) use vmlinux
> > BTF information, loading the BTF vmlinux information for every program
> > in an object is sub-optimal. The fix was originally proposed in:
> >
> >    https://lore.kernel.org/bpf/CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com/
> >
> > The btf_vmlinux is populated in the object if any of the programs in
> > the object requires it just before the programs are loaded and freed
> > after the programs finish loading.
> >
> > Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
>
> Looks great!
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
