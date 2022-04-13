Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D054FEBF8
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 02:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiDMAt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiDMAt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 20:49:58 -0400
Received: from mail-pj1-x1061.google.com (mail-pj1-x1061.google.com [IPv6:2607:f8b0:4864:20::1061])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C691E22537
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 17:47:38 -0700 (PDT)
Received: by mail-pj1-x1061.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso4672876pjb.5
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 17:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6IW/UWJxXnzlXONhFMLUxMUpluOP3q1uzsrJZxFI4pw=;
        b=Aw9MAxQJ/o7BOHiQO10J7b74pS4zj7tBMWCGlPtyyVndiZVmUoyd74+qx/sQKfv5Jb
         vCyMMmqEey5SQtR/DaXEtg4HwIR4t45mcijbtSVckQakIsmzIBWaAZ4MpTn6ch4+u9pQ
         +C33U0QNUmgNcPGsbRi3iI7Vkn+otPIozNd4mjajzL1lSnB4fuHk0hfcX6072SQojkWw
         yFV3CJYP9MeQAVA8UnloV7MsFVuXa2ZG7VvFa8inS6qUfQnEJbY9C7wWAMOKXYtvBmPW
         CvHwBDlFgiAPD/RDTdeZp+e1CMt1b3Rc3QtaxVgBd/30nEEBYvUpxhVB7u5YwKwN9uwM
         Vp0g==
X-Gm-Message-State: AOAM532wOWJ06go+42esxMbNt1jJyqkLdN81PC0AjUBBzr5xDBZtKAxW
        +Yy+mEytACUASlxloa5U8FijYQkIxDpi+rSzVcZ7r1XMTrXl+g==
X-Google-Smtp-Source: ABdhPJw44wa4hdaDVfPswl+rmlWIpqfbZvJg1VX+nny08fVMmSo/8MLC/M27eKpVl8LT3VwznW2ZBfifnzuy
X-Received: by 2002:a17:902:8c96:b0:157:990:c9b7 with SMTP id t22-20020a1709028c9600b001570990c9b7mr28619908plo.118.1649810858360;
        Tue, 12 Apr 2022 17:47:38 -0700 (PDT)
Received: from netskope.com ([163.116.131.242])
        by smtp-relay.gmail.com with ESMTPS id o8-20020a17090a168800b001cb1143c68fsm120251pja.7.2022.04.12.17.47.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 17:47:38 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-pf1-f199.google.com with SMTP id h123-20020a62de81000000b005060c0dc509so324799pfg.18
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6IW/UWJxXnzlXONhFMLUxMUpluOP3q1uzsrJZxFI4pw=;
        b=nVmSlcl+Jsz0+HoJkB8Z5R+LU626GTjNBrX3bXOjKLJFMDq4kMPaIQh2Go5Uuux352
         odnn/JnumprNaf3hRTTrT7kfiG2C+RI1FdjLhrZl2YhlGksloOh8ILkpANRqp9NRQdRE
         KUXBBWLXO49lGyGN8sneRit17ZXHs3oqHIbh0=
X-Received: by 2002:a17:902:ef48:b0:156:8ff6:e2cc with SMTP id e8-20020a170902ef4800b001568ff6e2ccmr40614840plx.130.1649810857214;
        Tue, 12 Apr 2022 17:47:37 -0700 (PDT)
X-Received: by 2002:a17:902:ef48:b0:156:8ff6:e2cc with SMTP id
 e8-20020a170902ef4800b001568ff6e2ccmr40614825plx.130.1649810856864; Tue, 12
 Apr 2022 17:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
 <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com> <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com>
In-Reply-To: <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Tue, 12 Apr 2022 17:47:25 -0700
Message-ID: <CAC1LvL2VZoik563Z8N_o49hyTA37iLsHi+O-gM7x8_rfrWth=w@mail.gmail.com>
Subject: Re: Error validating array access
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 11:29 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 9.04.22 =D0=B3. 1:58 =D1=87., Andrii Nakryiko wrote:
> > On Wed, Apr 6, 2022 at 5:12 PM Nikolay Borisov <nborisov@suse.com> wrot=
e:
> >>
> >> Hello,
> >>
> >> I get a validator error with the following function:
> >>
> >> #define MAX_PERCPU_BUFSIZE (1<<15)
> >> #define PATH_MAX 4096
> >> #define MAX_PATH_COMPONENTS 20
> >> #define IDX(x) ((x) & (MAX_PERCPU_BUFSIZE-1))
> >>
> >> struct buf_t {
> >>       u8 buf[MAX_PERCPU_BUFSIZE];
> >> };
> >>
> >> struct {
> >>       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>       __uint(max_entries, 1);
> >>       __type(key, u32);
> >>       __type(value, struct buf_t);
> >> } buf_map SEC(".maps");
> >>
> >> static __always_inline u32 get_dentry_path_str(struct dentry* dentry,
> >>           struct buf_t *string_p)
> >> {
> >>       const char slash =3D '/';
> >>       const int zero =3D 0;
> >>
> >>       u32 buf_off =3D MAX_PERCPU_BUFSIZE - 1;
> >>
> >>       #pragma unroll
> >>       for (int i =3D 0; i < MAX_PATH_COMPONENTS; i++) {
> >>           struct dentry *d_parent =3D BPF_CORE_READ(dentry, d_parent);
> >>           if (dentry =3D=3D d_parent) {
> >>               break;
> >>           }
> >>           // Add this dentry name to path
> >>           struct qstr d_name =3D BPF_CORE_READ(dentry, d_name);
> >>           // Ensure path is no longer than PATH_MAX-1 and copy the ter=
minating NULL
> >>           unsigned int len =3D (d_name.len+1) & (PATH_MAX-1);
> >>           // Start writing from the end of the buffer
> >>           unsigned int off =3D buf_off - len;
> >>           // Is string buffer big enough for dentry name?
> >>           int sz =3D 0;
> >>           // verify no wrap occurred
> >>           if (off <=3D buf_off)
> >>               sz =3D bpf_probe_read_kernel_str(&string_p->buf[IDX(off)=
], len, (void *)d_name.name);
> >>           else
> >>               break;
> >>
> >>           if (sz > 1) {
> >>               buf_off -=3D 1; // replace null byte termination with sl=
ash sign
> >>               bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash=
);
> >>               buf_off -=3D sz - 1;

Isn't it (theoretically) possible for this to underflow? What happens if
sz > 1 and sz >=3D buf_off?

> >>           } else {
> >>               // If sz is 0 or 1 we have an error (path can't be null =
nor an empty string)
> >>               break;
> >>           }
> >>           dentry =3D d_parent;
> >>       }
> >>
> >>       // Add leading slash
> >>       buf_off -=3D 1;
> >>       bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
> >>       // Null terminate the path string, this replaces the final / wit=
h a null
> >>       // char
> >>       bpf_probe_read(&(string_p->buf[MAX_PERCPU_BUFSIZE-1]), 1, &zero)=
;
> >>       return buf_off;
> >> }
> >>
> >> Here are the last couple of instructions where off is being calculated=
.
> >>
> >> ; unsigned int len =3D (d_name.len+1) & (PATH_MAX-1);
> >> 54: (57) r9 &=3D 4095                   ; R9_w=3Dinv(id=3D0,umax_value=
=3D4095,var_off=3D(0x0; 0xfff))
> >> ; unsigned int off =3D buf_off - len;
> >> 55: (bf) r8 =3D r9                      ; R8_w=3Dinv(id=3D4,umax_value=
=3D4095,var_off=3D(0x0; 0xfff)) R9_w=3Dinv(id=3D4,umax_value=3D4095,var_off=
=3D(0x0; 0xfff))
> >> 56: (a7) r8 ^=3D 32767                  ; R8_w=3Dinv(id=3D0,umin_value=
=3D28672,umax_value=3D32767,var_off=3D(0x7000; 0xfff))
> >> ; sz =3D bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (voi=
d *)d_name.name);
> >> 57: (79) r6 =3D *(u64 *)(r10 -72)       ; R6_w=3Dmap_value(id=3D0,off=
=3D0,ks=3D4,vs=3D32768,imm=3D0) R10=3Dfp0
> >> 58: (0f) r6 +=3D r8                     ; R6_w=3Dmap_value(id=3D0,off=
=3D0,ks=3D4,vs=3D32768,umin_value=3D28672,umax_value=3D32767,var_off=3D(0x7=
000; 0xfff)) R8_w=3DinvP(id=3D0,umin_value=3D28672,umax_value=3D32767,var_o=
ff=3D(0x7000; 0xfff))
> >> ; sz =3D bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (voi=
d *)d_name.name);
> >> 59: (79) r3 =3D *(u64 *)(r1 +8)         ; R1_w=3Dfp-24 R3_w=3Dinv(id=
=3D0)
> >> ; sz =3D bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (voi=
d *)d_name.name);
> >> 60: (bf) r1 =3D r6                      ; R1_w=3Dmap_value(id=3D0,off=
=3D0,ks=3D4,vs=3D32768,umin_value=3D28672,umax_value=3D32767,var_off=3D(0x7=
000; 0xfff)) R6_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D32768,umin_value=
=3D28672,umax_value=3D32767,var_off=3D(0x7000; 0xfff))
> >> 61: (bf) r2 =3D r9                      ; R2_w=3Dinv(id=3D4,umax_value=
=3D4095,var_off=3D(0x0; 0xfff)) R9_w=3Dinv(id=3D4,umax_value=3D4095,var_off=
=3D(0x0; 0xfff))
> >> 62: (85) call bpf_probe_read_kernel_str#115
> >> invalid access to map value, value_size=3D32768 off=3D32767 size=3D409=
5
> >> R1 max value is outside of the allowed memory range
> >>
> >>
> >>   From what I gathered it seems that in the bpf_probe_read_kernel_str =
the validator is not
> >> able to prove that off+len is always going to be at most MAX_PERCPU_BU=
FSIZE - 1 which is well within
> >> the bounds of the buffer. My logic goes as following:
> >>
> >> buf_off is first set to 32767, we get the first dentry and calculate i=
ts len + null terminating char which is going to be at most
> >> 4095, afterwards 'off' is being calculated as buf_off - len and finall=
y access to the percpu array is performed via  IDX(off) which guarantees th=
e access is
> >> bounded by MAX_PERCPU_BUFSIZE - 1.
> >
> > IDX(off) is bounded, but verifier needs to be sure that `off + len`
> > never goes beyond map value. so you should make sure and prove off <=3D
> > MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for
>
> But that is guaranteed since off =3D buff_off - len, and buf_off is
> guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in the
> worst case MAX_PERCPU_BUFSIZE - len  so the map value access can't go
> beyond the end ?
>

If there's underflow in the calculation of buff_off (see above) then
buff_off > MAX_PERCPU_BUFSIZE - 1. Which makes off no longer bounded by
MAX_PERCPU_BUFSIZE - len, and it could exceed MAX_PERCPU_BUFSIZE.

> > you.
> >
> >>
> >> This code was originally based off https://github.com/aquasecurity/tra=
cee/blob/main/pkg/ebpf/c/tracee.bpf.c#L1721-L1777 however it seems
> >> that the way tracee author work around this is to simply start from th=
e middle of the buffer, i.e set buf_off initially to MAX_PERCPU_BUFSIZE>>1 =
and adjust the
> >> array accesses accordingly when doing the masking.
> >
