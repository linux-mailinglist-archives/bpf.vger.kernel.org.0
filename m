Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68AC14E8B6
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 07:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgAaGSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jan 2020 01:18:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41814 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAaGSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jan 2020 01:18:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so5893894ljc.8
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 22:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8uOXyJoggDIemZ+9XlkSU7/fgIs263yBX2IvnT2+8I=;
        b=uYwZpcaExnYZFNNmftsOEnwgUgfLBpJo5GIsOxBmHLDy5XijL5pI89lYHAGI9FR/yK
         h9RC0QCLyE5xJBmHSEjoL71KpXxkBaL7M5mcjrggl9C6ygcWV38DSwYRTSrGRTH8lzxf
         PcLlQwSIOoJevgX2Na3uF5+LhYX7vOc+qKIBk19Vs8o1xhhZ6ONeJiEje8VEDn9bAmLx
         5aAuVkFGoKPNsE3O2Mty9+tZuycV3u1wSlbRqWwerJ20SXWiwF/AOoA1eAzX1REOqo75
         2YukkXCm+Eb4TqdUX/kPKshBGQV7npT1pOsHuB77S77gqUWHg7xSxhf6ZmEgLmL3mEc6
         5+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8uOXyJoggDIemZ+9XlkSU7/fgIs263yBX2IvnT2+8I=;
        b=SwJ98ZKnoKx9xYQA8jVfbsMEfMbq1TT6CWatZoyuL5PWh/nUlbdkJiLum1xKqnUvcU
         mv/PZ7dZBYpeVBokwG665NSBA+2ZdWqGP4sDTreU1Vlncjg8HDz/h7ThFSiLxkPsst/m
         r7i/leEDEcnxknfvYCYSnlJL05S86J7sildoTZffHT5qZW2ovPnNOH07RSBC20/voNGB
         ufx+7/qu6nW6VdzE4IzgDnA4Rbu8Aqi31BI+/diD8j08ZSLyLGnjkwlW633RBnxI2JoB
         7DLFGdF7Akvvpwg6rLUuIHGpMVMkvnvaJcOC8CZSsOdY02MCdT8PDj1KNwEcgLKua3pD
         vu+g==
X-Gm-Message-State: APjAAAXdIL/7Qh7ydKDfUYPZYwbvQ5D7/9HShhvr//Jk7E6JpybEyZte
        UGuFbUowFom+L1+lUgO+uK6Gtl+gjtGU+8T+E/HtGuKN
X-Google-Smtp-Source: APXvYqzjDJ9iiEvVwXMVYUgZKXO+zmbuo/k1uzFX1nfq/JEKS5Hn31mIZBM/IaUZqsVei9rx33ZyCoowYgLA9Mu63dM=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr5045203ljg.144.1580451516528;
 Thu, 30 Jan 2020 22:18:36 -0800 (PST)
MIME-Version: 1.0
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net> <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net> <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp> <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp> <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
In-Reply-To: <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 30 Jan 2020 22:18:24 -0800
Message-ID: <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 30, 2020 at 9:48 PM John Fastabend <john.fastabend@gmail.com> wrote:
> at the moment. I'll take a look in the morning. That fragment 55,56,
> 57 are coming from a zext in llvm though.

I don't think so. Here is how IR looks after all optimizations
and right before instruction selection:
  %call12 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32,
i64)*)(i8* %ctx, i8* nonnull %call8, i32 800, i64 256) #2
  %cmp = icmp slt i32 %call12, 0
  br i1 %cmp, label %cleanup, label %if.end15

if.end15:                                         ; preds = %if.end11
  %idx.ext70 = zext i32 %call12 to i64
  %add.ptr = getelementptr i8, i8* %call8, i64 %idx.ext70
  %sub = sub nsw i32 800, %call12
  %call16 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32,
i64)*)(i8* %ctx, i8* %add.ptr, i32 %sub, i64 0) #2
  %cmp17 = icmp slt i32 %call16, 0
  br i1 %cmp17, label %cleanup, label %if.end20

and corresponding C code:
        usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
        if (usize < 0)
                return 0;

        ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
        if (ksize < 0)

%idx.ext70 = zext i32 %call12 to i64
that you see is a part of 'raw_data + usize' math.
The result of first bpf_get_stack() is directly passed into
"icmp slt i32 %call12, 0"
and during instruction selection the backend does
sign extension with <<32 s>>32.

I agree that peephole zext->mov32_64 is correct and a nice optimization,
but I still don't see how it helps this case.
