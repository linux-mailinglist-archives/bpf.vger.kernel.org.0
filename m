Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250F414D131
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2020 20:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgA2T2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 14:28:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33204 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgA2T2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jan 2020 14:28:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so663319lji.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbL0LGmGRJ6xt7V029gwj6XNOKpXMx/70dlJZ9BfR+4=;
        b=Sn/EohEa+wiFLSA6mHCtMCuLYOwOIHgSEsCuWQB6vj8HHmqglbj4e4pKLTL1MW0zL4
         hcU4u/+INxCEGx0ggUmGDBAIeQhX8hf0aWKN38K2Pkk3VrlPUuHXXBhzRVnf8vU3QXSC
         aX5RkZcw7EYegu88426RglwtIM9ZILswKNln1rrALLUfNy/sIae5uY2sRstwPhXPgrPh
         M1mjh8Px8uU0POFpmQWnSr1GYoCwSh8dixTGJt+fLsSf8cVpXfrtu4EEyx0p33eoi32o
         bLFM2h2FdWU2PYfMEhZtKegIIMf0t1F5bL8VTb3evJ5fQ8fbSYqmh1zOLmi14TnWSuMm
         CD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbL0LGmGRJ6xt7V029gwj6XNOKpXMx/70dlJZ9BfR+4=;
        b=sia+qxPLm/cTiO61Oq/sugJ/3L3lYGk1iis1OAoeFqgM5rNHqKwmfHAYBqNwweKiaH
         vTSCjles9Gcnf5fVLgHm6avk1qEDemI4gQ0Cq56Uuu6S9tBJk9gZTZMNcowdBRC9JnH9
         yJ1Y4ao/r9kOEXme7rFaYliMp1G4KNUE8mYBw8ddbA83AEHoeyAUao4d4mpKCexlvbRe
         mD0x2bwcCr2EewsGAkbV3xVQu8n4Tua9hJxEvyoILRc/BaxFgrRpe0Ms7IH5oAe5M6Z2
         bWCNN1vCTOPkLg3EoB3vXa6PWEGBsGMZw3pYYFqNLIhCW7BtPyZzQhYwUbANCPZo3C69
         ihSQ==
X-Gm-Message-State: APjAAAXit0L0VFRk5aXkBZWrdimGTePbmeWw3f2WrdYKJGt3QDPlk80P
        b/583ItU8YhLgXyQHhTb4H/WWt5EgcDyB4iiDB8=
X-Google-Smtp-Source: APXvYqxeTZG99EQkm/Uu1oa0aYTptT70Z76Ojh06KxhvcHQHEBhZTF/Dul1+mLh/EoUgikdFNoCI+4yOp7+9fLJOTGU=
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr446287ljh.138.1580326091901;
 Wed, 29 Jan 2020 11:28:11 -0800 (PST)
MIME-Version: 1.0
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370> <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
In-Reply-To: <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Jan 2020 11:28:00 -0800
Message-ID: <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>
> Applied, thanks!

Daniel,
did you run the selftests before applying?
This patch breaks two.
We have to find a different fix.

./test_progs -t get_stack
68: (85) call bpf_get_stack#67
 R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
R2 unbounded memory access, make sure to bounds check any array access
into a map

John,
did you run the selftests?
