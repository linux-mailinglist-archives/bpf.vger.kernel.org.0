Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6094FFF17
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiDMTZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiDMTZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 15:25:37 -0400
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com [IPv6:2607:f8b0:4864:20::d61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19068993
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:23:14 -0700 (PDT)
Received: by mail-io1-xd61.google.com with SMTP id k25so3018860iok.8
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=THRwZZ4EtlSHX84+sbQkom5QfyfnClqaCp7prWCnxQw=;
        b=uW+19iDFQQmm1qIlCA5FqvCeAx7IjjrXdS/Abn8wZ6p22cKPVX2JwTI9BDQC85an7Q
         Y+iHFDF20/nl9QyseYS+tWX9xVOops75OOjeLGXANCyigdsYhpF/4rhz2t53PqqGIcxT
         D0EwNmq8+3RVu9M4844/apYKIMG9KruuCsDsLBOgxyqnsUyhMLu34aWtpzzdl6a4ombF
         mNCxA3kP25syk5vLKkIx3E4/G5yfdXxRmpZa7BN7Eg+pCuln+E4osUlvtWJ4cridZdOK
         EWNR78juuwdMNrMJvMkwffNwSdtH4f6vZx8vISG6IAFrBlMzPfyU+Ch/OwD+8cS/Ltsv
         ycmQ==
X-Gm-Message-State: AOAM530quEmB9QM/Qe18WzAFKLxNAvkAYtNM+eVFSKE/OBTxusNmmBha
        /zzwyy99ruUn9vSzBvgvjC/SXmBHZeV19Higil0ddvRRQWFhoQ==
X-Google-Smtp-Source: ABdhPJxJyKhkkBZIE2deyYPKLxiiONUTMZshhyh49HVa6iZXlGpOOncaRQg05KCRwA43b2YfyOR7vId0PNuv
X-Received: by 2002:a05:6638:3588:b0:323:bf36:4624 with SMTP id v8-20020a056638358800b00323bf364624mr21474667jal.8.1649877794396;
        Wed, 13 Apr 2022 12:23:14 -0700 (PDT)
Received: from netskope.com ([163.116.128.204])
        by smtp-relay.gmail.com with ESMTPS id x16-20020a056638161000b00326632dab3bsm121546jas.47.2022.04.13.12.23.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:23:14 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-pj1-f69.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so4204260pjb.4
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THRwZZ4EtlSHX84+sbQkom5QfyfnClqaCp7prWCnxQw=;
        b=YQ81UzCQW71krE3hQdx3dCOBQqCrvPO5QK2PqKdDa1OMlY5OgeM+JlSXNrwEum0Kuo
         la/hygTsURhVfh0j8XmC2hiuErl6UgeWheJGZ2BNP8GK8VtDwS0NHohStdG60OLz21Z7
         YGOzz7T7UjwLwgqdP77tv1jNcky9tFQztF9Qs=
X-Received: by 2002:aa7:88c2:0:b0:4fa:ba98:4f6f with SMTP id k2-20020aa788c2000000b004faba984f6fmr305926pff.41.1649877792783;
        Wed, 13 Apr 2022 12:23:12 -0700 (PDT)
X-Received: by 2002:aa7:88c2:0:b0:4fa:ba98:4f6f with SMTP id
 k2-20020aa788c2000000b004faba984f6fmr305907pff.41.1649877792403; Wed, 13 Apr
 2022 12:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
 <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
 <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com> <CAC1LvL2VZoik563Z8N_o49hyTA37iLsHi+O-gM7x8_rfrWth=w@mail.gmail.com>
 <28743474-02be-950f-a0ed-cd8fec42ca85@suse.com> <CAC1LvL2YpBZxt33bnmHsTYRDbZwSwvPxLP251YrPZRQXDOANOA@mail.gmail.com>
 <960ea765-5c2c-c21d-5c8c-4f9bb26d5536@suse.com>
In-Reply-To: <960ea765-5c2c-c21d-5c8c-4f9bb26d5536@suse.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 13 Apr 2022 12:23:01 -0700
Message-ID: <CAC1LvL08LGEgQLsPpEvU8-6_C=39MTmfpro1cDrJRB1CpcrkrA@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 12:04 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 13.04.22 =D0=B3. 20:29 =D1=87., Zvi Effron wrote:
> > On Wed, Apr 13, 2022 at 12:08 AM Nikolay Borisov <nborisov@suse.com> wr=
ote:
> >>
> >> <snip>
> >>>>>> // Add this dentry name to path
> >>>>>> struct qstr d_name =3D BPF_CORE_READ(dentry, d_name);
> >>>>>> // Ensure path is no longer than PATH_MAX-1 and copy the terminati=
ng NULL
> >>>>>> unsigned int len =3D (d_name.len+1) & (PATH_MAX-1);
> >>>>>> // Start writing from the end of the buffer
> >>>>>> unsigned int off =3D buf_off - len;
> >>>>>> // Is string buffer big enough for dentry name?
> >>>>>> int sz =3D 0;
> >>>>>> // verify no wrap occurred
> >>>>>> if (off <=3D buf_off)
> >>>>>> sz =3D bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (v=
oid *)d_name.name);
> >>>>>> else
> >>>>>> break;
> >>>>>>
> >>>>>> if (sz > 1) {
> >>>>>> buf_off -=3D 1; // replace null byte termination with slash sign
> >>>>>> bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
> >>>>>> buf_off -=3D sz - 1;
> >>>
> >>> Isn't it (theoretically) possible for this to underflow? What happens=
 if
> >>> sz > 1 and sz >=3D buf_off?
> >>
> >> No, because sz is bounded by len since bpf_probe_read_kernel_str would
> >> copy at most len -1 bytes as per description of the function. Since
> >> we've ensured len is smaller than buff_off (due to off <=3D buf_off ch=
eck)
> >> then sz is also guaranteed to be less than buf_off.
> >>
> >> <snip>
> >>
> >
> > That's in a single iteration, though. Each iteration, sz can be 4095 (w=
hen
> > len =3D PATH_MAX - 1). buff_off can be reduced by up to 4095 (1 + sz - =
1). Your
> > loop allows 20 iterations, which would be a total adjustment to buff_of=
f of
> > 77,786 before the last iteration. This would cause buff_off to underflo=
w (it
> > starts at 32767).
>
> But in the last iteration it would result in an underflow which means
> we'd go into the else arm and break.
>

You might be in a case where the verifier does not track what's required to
prove correctness here. In order to prove correctness, relations between
len, sz, off, and buff_off must be tracked. The verifier does not track
relations between variables, just current state of registers.

You can see this when looking at how the verifier is validating via its out=
put.

When it validates IDX(off), all it knows is the register being used has a
minimum value of 28672 and a maximum value of 32767. Similarly, it knows th=
at
len has a maximum value of 4095. It does not know about the relation betwee=
n
len and off. So when it compares off to buf, it sees that the maximum value=
 of
IDX(off) (32767) plus the maximum value of len (4095) can exceed the size o=
f
buf (32768).

To prove this isn't possible, it would need to know that as IDX(off) varies
upwards, len varies downwards by the same amount. But the verifier does not
track relations between variables (in fact, it doesn't even know about
variables) so it does not know this.

> >
> >>>>> IDX(off) is bounded, but verifier needs to be sure that `off + len`
> >>>>> never goes beyond map value. so you should make sure and prove off =
<=3D
> >>>>> MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug =
for
> >>>>
> >>>> But that is guaranteed since off =3D buff_off - len, and buf_off is
> >>>> guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in th=
e
> >>>> worst case MAX_PERCPU_BUFSIZE - len so the map value access can't go
> >>>> beyond the end ?
> >>>>
> >>>
> >>> If there's underflow in the calculation of buff_off (see above) then
> >>> buff_off > MAX_PERCPU_BUFSIZE - 1. Which makes off no longer bounded =
by
> >>> MAX_PERCPU_BUFSIZE - len, and it could exceed MAX_PERCPU_BUFSIZE.
> >>
> >> As per my rationale above I don't think buf_off can underflow.
> >>
> >>>
> >>
> >> <snip>
> >
