Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C313B152153
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBDTzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 14:55:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37488 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgBDTzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Feb 2020 14:55:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so3242530pgl.4
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 11:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=u6dLlcyvSG6N1htoOGY19bn6Z8J0R0t6bUgMg2zoEAk=;
        b=t4g9FRf3ZzLTj2eBXeQJnZhdZH1PZdIPRz8So9kJ1UCRYwKw6hymz9QtkoCvLeUp2E
         gvPSGJhPlldM4ftGIRfoZtuBkrlrALX2eloKz/ncdbZwNG+KyHKIYZmpLZSHIrACnTe8
         rwWXx1cpVoqv7oDxWc6+qCxyr2Kjb7OnRExsuv+U6UoxOBIArnc/lYADxgg1WewAt/Cf
         TZSF10NMhdyNKMJinuVKFaxFZys5Hevi39TCULRP8bwty3OBJ5bQs4SSvFUPETi3oVlp
         AFbd6YYQZ5aQDUkl8+mL3QkLzHE9wCzkXgAxl1zCIZuVl+X9aqi4vk+AruIbGgORf45C
         oIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=u6dLlcyvSG6N1htoOGY19bn6Z8J0R0t6bUgMg2zoEAk=;
        b=X1eXWUKdqCol3VCUiU6rEV9+TX2TNOLlEFpxvYGX9XLPU3ibXxtdeirt1ICkhdBTDk
         cpW3drHGL/KRrBR14hQ81+ivaeqjCuhB/LAY+RkW7qN+Xm0E9QpcrFjGcKkHCP3tzJ/H
         94IRxpQP/367jeb3k8DPXWr1BgSur686nxqdwWtmIYYWlNobG33Ss+SPGZF9h8mX/PaE
         Nh+Ab5muQTVKzDDPjBdBeOqAH2m8t92oXPQm+tz1qdbESj8+7/TivRGBKJwm26i7YEXD
         aaZc1Y15eTZU/Of42SLoDBk3S9GwvqFSk6ptMV4Ga8NnrAFePtN02PBeuUE5jBynhIhM
         xP3g==
X-Gm-Message-State: APjAAAVWpT3M4kWv9bci8VmiI9/rpChvF89iCZfKTYUhhEdo+N4QAhE0
        mN5nht5Rk58jeZ1hUoMARu45SAuS
X-Google-Smtp-Source: APXvYqx9th8wQI3uF/JgrhQkaxCDgJnW65vWnstjyl0ZTs4cRtlaAvcdo6J6v5peCbD8HMWufZvUxA==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr32451688pfm.106.1580846146933;
        Tue, 04 Feb 2020 11:55:46 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id x21sm25779143pfq.76.2020.02.04.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:55:45 -0800 (PST)
Date:   Tue, 04 Feb 2020 11:55:37 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
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
 <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
 <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
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
> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Also don't mind to build pseudo instruction here for signed extension
> > but its not clear to me why we are getting different instruction
> > selections? Its not clear to me why sext is being chosen in your case?
> 
> Sign extension has to be there if jmp64 is used.
> So the difference is due to -mcpu=v2 vs -mcpu=v3
> v2 does alu32, but not jmp32
> v3 does both.
> By default selftests are using -mcpu=probe which
> detects v2/v3 depending on running kernel.
> 
> llc -mattr=dwarfris -march=bpf -mcpu=v3  -mattr=+alu32
> ;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>       48:       bf 61 00 00 00 00 00 00 r1 = r6
>       49:       bf 72 00 00 00 00 00 00 r2 = r7
>       50:       b4 03 00 00 20 03 00 00 w3 = 800
>       51:       b7 04 00 00 00 01 00 00 r4 = 256
>       52:       85 00 00 00 43 00 00 00 call 67
>       53:       bc 08 00 00 00 00 00 00 w8 = w0
> ;       if (usize < 0)
>       54:       c6 08 16 00 00 00 00 00 if w8 s< 0 goto +22 <LBB0_6>
> ;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
>       55:       1c 89 00 00 00 00 00 00 w9 -= w8
>       56:       bc 81 00 00 00 00 00 00 w1 = w8
>       57:       67 01 00 00 20 00 00 00 r1 <<= 32
>       58:       77 01 00 00 20 00 00 00 r1 >>= 32
>       59:       bf 72 00 00 00 00 00 00 r2 = r7
>       60:       0f 12 00 00 00 00 00 00 r2 += r1
>       61:       bf 61 00 00 00 00 00 00 r1 = r6
>       62:       bc 93 00 00 00 00 00 00 w3 = w9
>       63:       b7 04 00 00 00 00 00 00 r4 = 0
>       64:       85 00 00 00 43 00 00 00 call 67
> ;       if (ksize < 0)
>       65:       c6 00 0b 00 00 00 00 00 if w0 s< 0 goto +11 <LBB0_6>
> 
> llc -mattr=dwarfris -march=bpf -mcpu=v2  -mattr=+alu32
> ;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>       48:       bf 61 00 00 00 00 00 00 r1 = r6
>       49:       bf 72 00 00 00 00 00 00 r2 = r7
>       50:       b4 03 00 00 20 03 00 00 w3 = 800
>       51:       b7 04 00 00 00 01 00 00 r4 = 256
>       52:       85 00 00 00 43 00 00 00 call 67
>       53:       bc 08 00 00 00 00 00 00 w8 = w0
> ;       if (usize < 0)
>       54:       bc 81 00 00 00 00 00 00 w1 = w8
>       55:       67 01 00 00 20 00 00 00 r1 <<= 32
>       56:       c7 01 00 00 20 00 00 00 r1 s>>= 32
>       57:       c5 01 19 00 00 00 00 00 if r1 s< 0 goto +25 <LBB0_6>
> ;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
>       58:       1c 89 00 00 00 00 00 00 w9 -= w8
>       59:       bc 81 00 00 00 00 00 00 w1 = w8
>       60:       67 01 00 00 20 00 00 00 r1 <<= 32
>       61:       77 01 00 00 20 00 00 00 r1 >>= 32
>       62:       bf 72 00 00 00 00 00 00 r2 = r7
>       63:       0f 12 00 00 00 00 00 00 r2 += r1
>       64:       bf 61 00 00 00 00 00 00 r1 = r6
>       65:       bc 93 00 00 00 00 00 00 w3 = w9
>       66:       b7 04 00 00 00 00 00 00 r4 = 0
>       67:       85 00 00 00 43 00 00 00 call 67
> ;       if (ksize < 0)
>       68:       bc 01 00 00 00 00 00 00 w1 = w0
>       69:       67 01 00 00 20 00 00 00 r1 <<= 32
>       70:       c7 01 00 00 20 00 00 00 r1 s>>= 32
>       71:       c5 01 0b 00 00 00 00 00 if r1 s< 0 goto +11 <LBB0_6>
> 
> zext is there both cases and it will be optimized with your llvm patch.
> So please send it. Don't delay :)

LLVM patch here, https://reviews.llvm.org/D73985

With updated LLVM I can pass selftests with above fix and additional patch
below to get tighter bounds on 32bit registers. So going forward I think
we need to review and assuming it looks good commit above llvm patch and
then go forward with this series.

---

bpf: coerce reg use tighter max bound if possible
    
When we do a coerce_reg_to_size we lose possibly valid upper bounds in
the case where, (a) smax is non-negative and (b) smax is less than max
value in new reg size. If both (a) and (b) are satisfied we can keep
the smax bound. (a) is required to ensure we do not remove upper sign
bit. And (b) is required to ensure previously set bits are contained
inside the new reg bits.
    
Signed-off-by: John Fastabend <john.fastabend@gmail.com>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945d..e5349d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2805,7 +2805,8 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 		reg->umax_value = mask;
 	}
 	reg->smin_value = reg->umin_value;
-	reg->smax_value = reg->umax_value;
+	if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
+		reg->smax_value = reg->umax_value;
 }
 
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
