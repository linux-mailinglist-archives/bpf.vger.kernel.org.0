Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C691014F129
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAaRQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jan 2020 12:16:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40570 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaRQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jan 2020 12:16:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so3655665pfh.7
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2020 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qL4qN52tdZUGmrnOOJvnkXqAqiFD59Pn9vqySC3AzSc=;
        b=QOJr04V++HoM09dc/KFAH9cREYKsERQv3JgZrVsHEk1sfjdg2GCeeCufYXt9nLykc5
         xjP5f+qPOxP4gH0+09/BY8LT91mdZI+/AZggJ+csEG7ih26YOyXFmhvAa25LAdarNY/F
         LpN27P2JKKMbnNxMjLxdSaY5LVcHL3MSU1qqy6HfA3qe45JEOlHCvV1Rf9K6tysZNVgi
         mG5X8nvrZEmUaVPKe9fBWl1Za2TP9ZUJGlBos4k/Cex83aRwXdapJtte7HhbKXN1Mz5u
         0/3BsD4kTdmFAxoz970hpj9L66vYLWHA6brCdmJOJSvZcBlXCyfe8uifvEKpnJd5+l+A
         ft1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qL4qN52tdZUGmrnOOJvnkXqAqiFD59Pn9vqySC3AzSc=;
        b=XO3BbS62LR6qHkpfPvecVPa1cOlK3MajbyVgwS6TM0K1AUOMB56gZ4bDVX8emd9fNm
         KmGxE5wH6XqK2Y8GpoNOAk81V7Bm05ELA8EAqghEzmLna4Gj+cV0nr3bE/i6HnDIVmq3
         Oa1MM8LgVYzRqkq3G3026jK1uPqhmMpV4AbOQFB6cGR/Om7lutxxvSOmVxh61B1dJlfy
         uneBuLn0ptK/KyHgUNYVOebzk9qqEUX8jrPmpj9EyA9NaAgLQgdDevPX3RV8MWRI+UPt
         QuUd8pRUGgYgPGyeKoNBv+IifJHtpY2VMWPLIZbbJ2f9Pr8Hw9Zqi4fgdhEklO0z5SqQ
         l8ww==
X-Gm-Message-State: APjAAAVR0CqTwfEK1B4tsQ/Kmi4zSAwigqSsxTtw8nvo4is8c0zqdLZ9
        hYVto7xq50rmhNfLb5TaUpoT+uVF
X-Google-Smtp-Source: APXvYqwKQiS6OY8/4Rs1XpCMoMfqshsqhlAip6GGnnnO4H9dcabUUv4qAl6CbO5S/qC7uUn0yRNnPQ==
X-Received: by 2002:a63:8e:: with SMTP id 136mr11136007pga.319.1580490965146;
        Fri, 31 Jan 2020 09:16:05 -0800 (PST)
Received: from localhost (198-0-60-179-static.hfc.comcastbusiness.net. [198.0.60.179])
        by smtp.gmail.com with ESMTPSA id y24sm2029726pge.72.2020.01.31.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 09:16:04 -0800 (PST)
Date:   Fri, 31 Jan 2020 09:16:03 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
 <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Thu, Jan 30, 2020 at 9:48 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > at the moment. I'll take a look in the morning. That fragment 55,56,
> > 57 are coming from a zext in llvm though.
> 

OK I see the disconnect now. I don't get the same instructions at all. I only
have the <<32 >> 32, no signed shift s>>32.

> I don't think so. Here is how IR looks after all optimizations
> and right before instruction selection:

Same llvm ir though

>   %call12 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32,
> i64)*)(i8* %ctx, i8* nonnull %call8, i32 800, i64 256) #2
>   %cmp = icmp slt i32 %call12, 0
>   br i1 %cmp, label %cleanup, label %if.end15
> 
> if.end15:                                         ; preds = %if.end11
>   %idx.ext70 = zext i32 %call12 to i64
>   %add.ptr = getelementptr i8, i8* %call8, i64 %idx.ext70
>   %sub = sub nsw i32 800, %call12
>   %call16 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32,
> i64)*)(i8* %ctx, i8* %add.ptr, i32 %sub, i64 0) #2
>   %cmp17 = icmp slt i32 %call16, 0
>   br i1 %cmp17, label %cleanup, label %if.end20
> 

 %26 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32, i64)*)(i8* %0, i8* nonnull %23, i32 800, i64 256) #3, !dbg !166
  %27 = icmp slt i32 %26, 0, !dbg !167
  br i1 %27, label %41, label %28, !dbg !169

28:                                               ; preds = %25
  %29 = zext i32 %26 to i64, !dbg !170
  %30 = getelementptr i8, i8* %23, i64 %29, !dbg !170


> and corresponding C code:
>         usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>         if (usize < 0)
>                 return 0;
> 
>         ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
>         if (ksize < 0)

same as well. But my object code only has this (unpatched llvm)

      56:       bc 81 00 00 00 00 00 00 w1 = w8
      57:       67 01 00 00 20 00 00 00 r1 <<= 32
      58:       77 01 00 00 20 00 00 00 r1 >>= 32

> 
> %idx.ext70 = zext i32 %call12 to i64
> that you see is a part of 'raw_data + usize' math.
> The result of first bpf_get_stack() is directly passed into
> "icmp slt i32 %call12, 0"
> and during instruction selection the backend does
> sign extension with <<32 s>>32.

Assuming latest bpf tree and llvm master branch? 

> 
> I agree that peephole zext->mov32_64 is correct and a nice optimization,
> but I still don't see how it helps this case.

Also don't mind to build pseudo instruction here for signed extension
but its not clear to me why we are getting different instruction
selections? Its not clear to me why sext is being chosen in your case?

.John
