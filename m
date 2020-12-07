Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B005B2D1546
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 16:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLGP4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgLGP4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 10:56:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F68C061793
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 07:55:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s30so18792470lfc.4
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ns4l6DTJ6AHFucdrrlh89ycXS4RQATDPRF8fpv/tss=;
        b=Z7Gt8elzv7yMIf6fXrAuEAN0o955Dx7qICBcGktU3KsuYPCBES2WQrcixsnCro/yac
         aDdnNWmcFfClJwfJjtUaTYpFP+zxk+yuraLVIgbjdkWCkrTqo4ViYOxrzT3nug1Dp/ue
         SWocKXYRQ+6kS4P2gNBZwLRS4ez3+zUfn9DEZbz6nF+wX6xNV4MJYmywXx4yNanUb5eg
         Nw9/FJU1sS5MpuLRSYcT7qagTpkrPycEfg7FFODMGEmsFNUBNnQW/7Bd50r3gnRVU5ZN
         MWkQFICVKdT+Q9/tfBDxqdeAc8DiYD1sM6JCim3cOG02aWb6WX/ScPPwTwoxz3ywT8Dw
         4buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ns4l6DTJ6AHFucdrrlh89ycXS4RQATDPRF8fpv/tss=;
        b=OqTTWtD1YytBctUPzWi5hgTKUAX1lH57I+xOzVUDc3XX8lugvowNluEpJNc2Bi+oS6
         REQ/Q9U8saL+28k9/7g9h2edNJY+o5Nh1MGo5jfWIZwQzOpARdWtVFIG5hqVxZ2UazkJ
         CfN+zpTMfRIAUN8/6EF5JkKERB8pQDCDNB8Cr4AQ+5QAEeYGhKq/t5d+kT+fSEkOjOdH
         oP+CBl0rPidbmu4bPDIQXp0PayjQga9o3CPPKXhl+zXy7JIPTrgDln/nyt4QPiAJh5iR
         Mee1C4AiclvY2moV3NFlmdIQE5QZKIjGQenpYBhnKMvHrNgjpAbJoBfA5OsXcCH5Cox4
         YTCw==
X-Gm-Message-State: AOAM533EVXHP6Clt/bTN6Vm1Ufms1ynyG1DQCn6tbY+nurx2tlPw89or
        +feflx9RG7jbY/3wLR2jrotoyrWa5D/Qijjk3cQ=
X-Google-Smtp-Source: ABdhPJyVn90ZGeQ4Z9iqucHOBpRtkkm9pUM31bpGrKDhQ39Y62wXIA/3FsCRcK4VFNnCnOH79jsdU48/nWNkZUNcN5M=
X-Received: by 2002:a05:6512:3227:: with SMTP id f7mr9229109lfe.119.1607356536841;
 Mon, 07 Dec 2020 07:55:36 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com> <875z5d7ufl.fsf@toke.dk>
In-Reply-To: <875z5d7ufl.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 07:55:25 -0800
Message-ID: <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Wait, what? This is a regression that *breaks people's programs* on
> compiler versions that are still very much in the wild! I mean, fine if
> you don't want to support new features on such files, but then surely we
> can at least revert back to the old behaviour?

Those folks that care about compiling with old llvm would have to stick
to whatever loader they have instead of using libbpf.
It's not a backward compatibility breakage.

> I used "prog" because that's what iproute2 looks for if you don't supply

Please don't use iproute2 as a reason to do anything in libbpf. It won't fl=
y.
