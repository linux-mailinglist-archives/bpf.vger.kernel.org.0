Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3514F3DF
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 22:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgAaVgs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jan 2020 16:36:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43310 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgAaVgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jan 2020 16:36:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so8572195ljm.10
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2020 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6uj3VbiSr5ZHXg8N0ttBEy+51E5jA3BxEAKoEu6mNQ=;
        b=u1q9QlfoWEEECMmLla8HEMR19Gr5JZTBz/bu+VxsIGhDK1ah+IhOVJwPTNNrxfevti
         PQ7UkYzHb/l9fumUan9m0Fy8oY0b0LYI5HYRfvUQt6tqOvRQjOvgziNCdQzFcnbKKeAu
         GMMqBpJBkE1DyU3By75LGYyR5yFZ1Q5jEiYs8uU0qJ8whdMWb2m14bZSZu8wlE0ffbeZ
         jdFalb3RMNzgmWHGZ7nYes8uiGSzWgjCV+4mdiZgOM5UQXylsVzYtqA9qpLESIZ9SId5
         5+LDpQea+QP0NWXYSs6tTcfqPcAJ4Y0vmlOQL2MLHujoY9o2ZDcbSq/BTLJpHavy7yx3
         JlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6uj3VbiSr5ZHXg8N0ttBEy+51E5jA3BxEAKoEu6mNQ=;
        b=MU5BeFC5s/Zr2gusb9csLJRKJafgp9xmZC1eRw8URQnBBfzTlv7S8K/2SCCTawNJIx
         BYE3WsfmR6EWoLxbYbEVnTXeY3CeO6qtr8NCSjRzX/6j+FQ+XJ17dVtQ46pEWJCyJ0QR
         cf9ZanwOimsrMn+shZ48N95VwOCQ7h4z0rs5AeKRJNI89cwn/+GqZB8pBJs0QZu/oIwR
         ghlF4gXWz6thtsW8epUHiZK55m4WdhhRfm6k0zaLKC+/HTzVDInYjjaN+qlFkS37Y8lC
         rswIZF7G4cRPPkHWzCEVYlTBCTlc/qpPhr6UdSokphTsc6PxYom2ppnIxOsAZMuI1YPs
         jZQQ==
X-Gm-Message-State: APjAAAUXBqcLBQ51LpgvEPoLtM4SgP0AaTHyyPhv/KwnbVUesQ6XsLAU
        fNlkn6WsyCdDqwNxa48tzEvHk4HxUYIiq+HBIJU=
X-Google-Smtp-Source: APXvYqwK+eKkINPUo5igvFL4FykKg0ZgvSShqlSu40gCf62t9KIx8Agct3tHH4Hqa+/q18TMlblhwckjKBofLcZk+x0=
X-Received: by 2002:a2e:a404:: with SMTP id p4mr7247790ljn.234.1580506605981;
 Fri, 31 Jan 2020 13:36:45 -0800 (PST)
MIME-Version: 1.0
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net> <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net> <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp> <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp> <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com> <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
In-Reply-To: <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 31 Jan 2020 13:36:34 -0800
Message-ID: <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
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

On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Also don't mind to build pseudo instruction here for signed extension
> but its not clear to me why we are getting different instruction
> selections? Its not clear to me why sext is being chosen in your case?

Sign extension has to be there if jmp64 is used.
So the difference is due to -mcpu=v2 vs -mcpu=v3
v2 does alu32, but not jmp32
v3 does both.
By default selftests are using -mcpu=probe which
detects v2/v3 depending on running kernel.

llc -mattr=dwarfris -march=bpf -mcpu=v3  -mattr=+alu32
;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
      48:       bf 61 00 00 00 00 00 00 r1 = r6
      49:       bf 72 00 00 00 00 00 00 r2 = r7
      50:       b4 03 00 00 20 03 00 00 w3 = 800
      51:       b7 04 00 00 00 01 00 00 r4 = 256
      52:       85 00 00 00 43 00 00 00 call 67
      53:       bc 08 00 00 00 00 00 00 w8 = w0
;       if (usize < 0)
      54:       c6 08 16 00 00 00 00 00 if w8 s< 0 goto +22 <LBB0_6>
;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
      55:       1c 89 00 00 00 00 00 00 w9 -= w8
      56:       bc 81 00 00 00 00 00 00 w1 = w8
      57:       67 01 00 00 20 00 00 00 r1 <<= 32
      58:       77 01 00 00 20 00 00 00 r1 >>= 32
      59:       bf 72 00 00 00 00 00 00 r2 = r7
      60:       0f 12 00 00 00 00 00 00 r2 += r1
      61:       bf 61 00 00 00 00 00 00 r1 = r6
      62:       bc 93 00 00 00 00 00 00 w3 = w9
      63:       b7 04 00 00 00 00 00 00 r4 = 0
      64:       85 00 00 00 43 00 00 00 call 67
;       if (ksize < 0)
      65:       c6 00 0b 00 00 00 00 00 if w0 s< 0 goto +11 <LBB0_6>

llc -mattr=dwarfris -march=bpf -mcpu=v2  -mattr=+alu32
;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
      48:       bf 61 00 00 00 00 00 00 r1 = r6
      49:       bf 72 00 00 00 00 00 00 r2 = r7
      50:       b4 03 00 00 20 03 00 00 w3 = 800
      51:       b7 04 00 00 00 01 00 00 r4 = 256
      52:       85 00 00 00 43 00 00 00 call 67
      53:       bc 08 00 00 00 00 00 00 w8 = w0
;       if (usize < 0)
      54:       bc 81 00 00 00 00 00 00 w1 = w8
      55:       67 01 00 00 20 00 00 00 r1 <<= 32
      56:       c7 01 00 00 20 00 00 00 r1 s>>= 32
      57:       c5 01 19 00 00 00 00 00 if r1 s< 0 goto +25 <LBB0_6>
;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
      58:       1c 89 00 00 00 00 00 00 w9 -= w8
      59:       bc 81 00 00 00 00 00 00 w1 = w8
      60:       67 01 00 00 20 00 00 00 r1 <<= 32
      61:       77 01 00 00 20 00 00 00 r1 >>= 32
      62:       bf 72 00 00 00 00 00 00 r2 = r7
      63:       0f 12 00 00 00 00 00 00 r2 += r1
      64:       bf 61 00 00 00 00 00 00 r1 = r6
      65:       bc 93 00 00 00 00 00 00 w3 = w9
      66:       b7 04 00 00 00 00 00 00 r4 = 0
      67:       85 00 00 00 43 00 00 00 call 67
;       if (ksize < 0)
      68:       bc 01 00 00 00 00 00 00 w1 = w0
      69:       67 01 00 00 20 00 00 00 r1 <<= 32
      70:       c7 01 00 00 20 00 00 00 r1 s>>= 32
      71:       c5 01 0b 00 00 00 00 00 if r1 s< 0 goto +11 <LBB0_6>

zext is there both cases and it will be optimized with your llvm patch.
So please send it. Don't delay :)
