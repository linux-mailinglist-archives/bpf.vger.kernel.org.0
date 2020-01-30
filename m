Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6881514D446
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2020 01:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA3AEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 19:04:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40845 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3AEU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jan 2020 19:04:20 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so529125pjb.5
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 16:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhQWmRGw9NzeKT9pF43NjNZH5sI37mspHJ3vnJ1a7i0=;
        b=bi+SWuhwiAV5vir00cekqyHmP/NwAN0F1fLNtFUKxqYYaxrydb0tgJ1XPUxkXI9q5r
         jN4qgXDfugaDgq5omlzkAM76F3fOzXc9c0373g/h0e9bc+UbHFKuskFRnlKwqafjxYpN
         bnYD6uZfDuDo7soUmG+YPkCU6O1+TWTLEo89zN9liZBqRZkIZx4FexZbhF6WQapr50Mj
         T1Ll4zBoNdXpzAi40blXo5aYBHoIB5+NebTLTa1MFa6+EmlbfyLzKFMK7bvMEMFtgqMf
         ph6GMw9Frm66INdjjOSjjOAoBNgeuDeRFOlFYkMhIJTF34MS0UeV3T+ZFiK0i8FRQ3y+
         HL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhQWmRGw9NzeKT9pF43NjNZH5sI37mspHJ3vnJ1a7i0=;
        b=UHHR/jR13SP7GjDYXFVr3JfW5NHzbns87OInCVR7rBCbSyphs6rg02h6SZnSTTtX7X
         pDhyYSkL62iIhniurNpzsifwcF2BUjmj1bw0DBJs/FFoeEd5hB/I9CL5kCnXii9Swqwa
         R3UnULeLareTtKXSvWRIAYXgF8vzQdihY7aBrL4hcjk0ejgc2KHSaFNGxMQXaB6DyMtB
         8WAcYXrLd5AYiQr+nVXTVRMF9iOruVJGEeEDKKoyaZkrwPUVFWENZgeLeCKUnbmMKlOB
         EDUc7AVAVFPrZREAgAAxoY+0GxroEl3UAZy4fgVssyc41jUhrb/mfkUwOEC+iWt2tpxF
         2b0w==
X-Gm-Message-State: APjAAAURX8AZIYCdfD/IlCttLM39eb1paY4Q5nyGBQ/kfcIqNjdt37tp
        9i5NkEil5Iawv9f7NEZTqQs=
X-Google-Smtp-Source: APXvYqzY6zf9VNDoPvSxZm07uQsQ1GOp3LfYtC3tSan2L0LB/ec8tCgxuVxI+pNheYnt8tJAQI5L6A==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr1849752plo.51.1580342659525;
        Wed, 29 Jan 2020 16:04:19 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::3:efa4])
        by smtp.gmail.com with ESMTPSA id i66sm3943592pfg.85.2020.01.29.16.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 16:04:18 -0800 (PST)
Date:   Wed, 29 Jan 2020 16:04:17 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Message-ID: <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 29, 2020 at 02:52:10PM -0800, John Fastabend wrote:
> Daniel Borkmann wrote:
> > On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> > > On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >>>
> > >>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> > >>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > >>
> > >> Applied, thanks!
> > > 
> > > Daniel,
> > > did you run the selftests before applying?
> > > This patch breaks two.
> > > We have to find a different fix.
> > > 
> > > ./test_progs -t get_stack
> > > 68: (85) call bpf_get_stack#67
> > >   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> > > R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> > > 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> > > 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> > > R2 unbounded memory access, make sure to bounds check any array access
> > > into a map
> > 
> > Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> > tree since this needs to be addressed. Sorry for the trouble.
> 
> Thanks I'm looking into it now. Not sure how I missed it on
> selftests either older branch or I missed the test somehow. I've
> updated toolchain and kernel now so shouldn't happen again.

Looks like smax_value was nuked by <<32 >>32 shifts.
53: (bf) r8 = r0   // R0=inv(id=0,smax_value=800)
54: (67) r8 <<= 32  // R8->smax_value = S64_MAX; in adjust_scalar_min_max_vals()
55: (c7) r8 s>>= 32
; if (usize < 0)
56: (c5) if r8 s< 0x0 goto pc+28
// and here "less than zero check" doesn't help anymore.

Not sure how to fix it yet, but the code pattern used in
progs/test_get_stack_rawtp.c
is real. Plenty of bpf progs rely on this.
