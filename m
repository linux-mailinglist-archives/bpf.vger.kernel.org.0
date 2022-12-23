Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC48654A7F
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 02:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiLWBju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 20:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWBjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 20:39:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628D15727;
        Thu, 22 Dec 2022 17:39:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e190so2431495pgc.9;
        Thu, 22 Dec 2022 17:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grzl5wIzDQdDuXEmubP5wY/8pPciPXQ5TjFtPH/aOJU=;
        b=YlgZZwb2q4WO0T97H2TVtzFn17PzmjwSz+ySBv7CcCd+sQd3HLuvTBK3ELNzILYdtI
         2/39zCu1P+qGDefnnBlp/TZ5Bc5pnVB5o2xpWrB+Nn2ww97aqIVkxz1VTR852RHA2J54
         FmCHsJHaibcq3mulYvYDQ4e1xwzVPixaeJqNxnN8y8cdJhbo3r724ASFK3yB9RaOCtPz
         qX6eHtiHW5X6U0OHBETwUfj0XtHsPrnry3PJuSBPjZ7D733tC/E1au9toZWpsBKRUqEK
         WVNyv2zVxBaczQAnsaPff1mGRsdXo6YYzIR5lFep2N5kTUH97/0MLfczJnRpaUxUkyWk
         ixIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Grzl5wIzDQdDuXEmubP5wY/8pPciPXQ5TjFtPH/aOJU=;
        b=B8vNGBx8jyOzdWQQb9teYMfSSEVyxpR4dfpH5tsPAhVFnwUFt1GvSKm9O/MF/31T7N
         s89hzT7rf3774h3EQ0dOCpYKFwU/M3KIxtLC1k28uXgdzpKTnLlhF3PSBzlaSUQ8F68K
         WKpCVYBtKONqlJ5a00YK1+idrfOniwcKBX/2ExE3MVX35mgPVCiFp4HpkiIL/Vx4roVm
         AuZlIS/1EsUOy/u7LNjsl5w9uMJneHhLVs8lkOFjKVwMEYY2LC4DnH33yc/CpSPfwmI5
         ySxdTzjMYuYp2cTrjbkctdAsDfUqgwdCGtoNX0htfv1q1Mbhp8Wzcn5U8JIwciCTIboq
         CYEg==
X-Gm-Message-State: AFqh2kraSeOFBrY7vEwIC93dLeAGKH7SAyEWAb1FutKjY8B/KBL+7994
        qMgkLn+y7cVpcqMf+5Lhb6hnoXrkyi2jpeykBQ==
X-Google-Smtp-Source: AMrXdXvQKWP0R8o0SdFyGvPNf7kfDpAhPC+tLKE0ctXJ9Ig/gK+YZAouc7Tn/nUkNupTDRi8LhXJvzuTDKVoDMcmVGI=
X-Received: by 2002:a63:f957:0:b0:477:98cc:3d01 with SMTP id
 q23-20020a63f957000000b0047798cc3d01mr382045pgk.505.1671759585816; Thu, 22
 Dec 2022 17:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20221222024414.29539-1-sunhao.th@gmail.com> <e46452f4-a274-1b9e-2b33-668cc0f258b5@linux.dev>
In-Reply-To: <e46452f4-a274-1b9e-2b33-668cc0f258b5@linux.dev>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 23 Dec 2022 09:39:34 +0800
Message-ID: <CACkBjsbqjxm_DA2gKhPN0Q7GeO+KbfX8aR50Aw9ac2e_i1X=gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: fix nullness propagation for reg to
 reg comparisons
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <martin.lau@linux.dev> =E4=BA=8E2022=E5=B9=B412=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 09:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/21/22 6:44 PM, Hao Sun wrote:
> > After befae75856ab, the verifier would propagate null information after
> > JEQ/JNE, e.g., if two pointers, one is maybe_null and the other is not,
> > the former would be marked as non-null in eq path. However, as comment
> > "PTR_TO_BTF_ID points to a kernel struct that does not need to be null
> > checked by the BPF program ... The verifier must keep this in mind and
> > can make no assumptions about null or non-null when doing branch ...".
> > If one pointer is maybe_null and the other is PTR_TO_BTF, the former is
> > incorrectly marked non-null. The following BPF prog can trigger a
> > null-ptr-deref, also see this report for more details[1]:
> >
> >       0: (18) r1 =3D map_fd             ; R1_w=3Dmap_ptr(ks=3D4, vs=3D4=
)
> >       2: (79) r6 =3D *(u64 *)(r1 +8)    ; R6_w=3Dbpf_map->inner_map_dat=
a
> >                                       ; R6 is PTR_TO_BTF_ID
> >                                       ; equals to null at runtime
> >       3: (bf) r2 =3D r10
> >       4: (07) r2 +=3D -4
> >       5: (62) *(u32 *)(r2 +0) =3D 0
> >       6: (85) call bpf_map_lookup_elem#1    ; R0_w=3Dmap_value_or_null
> >       7: (1d) if r6 =3D=3D r0 goto pc+1
> >       8: (95) exit
> >       ; from 7 to 9: R0=3Dmap_value R6=3Dptr_bpf_map
> >       9: (61) r0 =3D *(u32 *)(r0 +0)          ; null-ptr-deref
> >       10: (95) exit
> >
> > So, make the verifier propagate nullness information for reg to reg
> > comparisons only if neither reg is PTR_TO_BTF_ID.
> >
> > [1] https://lore.kernel.org/bpf/CACkBjsaFJwjC5oiw-1KXvcazywodwXo4zGYsRH=
wbr2gSG9WcSw@mail.gmail.com/T/#u
> >
> > Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to r=
eg comparisons")
> The "Fixes" tag has one more hex digit. I have corrected it and applied t=
o the
> bpf tree.  Thanks.
>
> Please run checkpatch.pl in the future:
>
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle
> line>")' - ie: 'Fixes: befae75856ab ("bpf: propagate nullness information=
 for
> reg to reg comparisons")'
> #35:
> Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to reg
> comparisons")
>

Noted, thanks!
