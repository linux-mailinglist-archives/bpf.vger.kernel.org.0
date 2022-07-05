Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E76656650C
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiGEIca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGEIcY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 04:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 922D79D
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657009938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGZRoN7EHBvepMcuQHMt3bqC6hyW9024ptQrr+mX7IE=;
        b=gcj6OTsJXwV/dVNE0kvf3v0Jubz2mo5LhoBlxUuzKl/jQtVr05rquC8P1/ffR5uZXK1KZQ
        UX0b7I0RekNQUZ/ZVlplpPrKgcSHdSvhDMHFtGk7SKsJ6/HR203QVLvFHZzeuUzxO74S3K
        WmzcDoZB407hdPgNo/NnSCK5oYKZJgs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-b4fBVrNHPfKrOg8ya0w6cw-1; Tue, 05 Jul 2022 04:32:16 -0400
X-MC-Unique: b4fBVrNHPfKrOg8ya0w6cw-1
Received: by mail-pl1-f197.google.com with SMTP id d10-20020a170902ceca00b0016bea2dc145so1905823plg.7
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 01:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGZRoN7EHBvepMcuQHMt3bqC6hyW9024ptQrr+mX7IE=;
        b=MO6JUqqBglM5cVRFBEswc1EKr4Ud/zEchM1Ow+qqtw5TrS5OesyZKO0E35gFnAH6gY
         HKSFRa0bhBdBiweFgiYeIXP2fD84W/sSpmPqJfrUp5IEhWY2NCIQ46skvQl2GhNMHbSv
         a+cD/RERGTiX2osFiLqupXtfK+lB6k8x+uZk0po3ez2eY09PFVfdBOD0nDVl18mXqrIq
         xPnPdLu5QvSBwdVCLS78NuGEH3vgW730ccFE2GIFlwKH3Wc2CoaxfbfL5gaWchG/2z4Z
         j43jW31b8EplZigs3PlCJsGq88bXnfNPC3dZlCe+PSZc3OQb+VeqqpvC6fcre1/FBzfV
         680A==
X-Gm-Message-State: AJIora+5EsMoT9bRjIpd1ledjIQhTWmqUpdrRzWlgr0e87YTw13Oi7Go
        4hsvWaDfTlmDttgT89azFGFtvsYGH1EO7GadqU39CmxsayWGsO2igbexSRSHTceWZE2oQdtY+RG
        hejRCrN1223FSuNpwMBt7H2xysmf+
X-Received: by 2002:a05:6a00:b8c:b0:525:6391:1139 with SMTP id g12-20020a056a000b8c00b0052563911139mr39710888pfj.80.1657009935150;
        Tue, 05 Jul 2022 01:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uUaDGsY7+TnzJghxlXsA77S7sFPvo+7W8qCvgKDgB6BIssAztlbrH+6w6Cgc3pBbuB11oHx2dwgc+9O+VO5RU=
X-Received: by 2002:a05:6a00:b8c:b0:525:6391:1139 with SMTP id
 g12-20020a056a000b8c00b0052563911139mr39710867pfj.80.1657009934870; Tue, 05
 Jul 2022 01:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
 <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net> <xunyr135ytxr.fsf@redhat.com>
 <CANoWswmar9ELFGiqNeG7SCuaciaoNWEq2E+YaRq5J4fwRqfuZg@mail.gmail.com> <CAM1=_QTEAA4vzVHJV3-fcLOGqAcef8q6U7bg5LbH-CKehuQLxw@mail.gmail.com>
In-Reply-To: <CAM1=_QTEAA4vzVHJV3-fcLOGqAcef8q6U7bg5LbH-CKehuQLxw@mail.gmail.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 5 Jul 2022 11:31:58 +0300
Message-ID: <CANoWswnQK4NfvmNjN9DZpeq5ry4qXra9m1hSrBexT83CzUuR0w@mail.gmail.com>
Subject: Re: test_kmod.sh fails with constant blinding
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Johan!

On Tue, Jul 5, 2022 at 11:06 AM Johan Almbladh
<johan.almbladh@anyfinetworks.com> wrote:
>
> On Mon, Jul 4, 2022 at 10:22 AM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
> >
> > Hi!
> >
> > On Fri, Jul 1, 2022 at 2:05 PM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
> > > >>>>> On Thu, 30 Jun 2022 22:57:37 +0200, Daniel Borkmann  wrote:
> > >
> > >  > On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
> > >  >> Hi!
> > >  >> test_kmod.sh fails for hardened 2 check with
> > >  >> test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime
> > >  >> err=-524
> > >  >> (-ERANGE during constant blinding)
> > >  >> Did I miss something?
> > >
> > >  > That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
> > >  > fails given the targets go out of range.
> > >
> > > I believe that, but how to fix the test? It should not fail.
> > >
> > >  > How do the generated insn look?
> > >
> > > The instruction when it fails is
> > >
> > > (gdb) p/x insn[0]
> > > $8 = {code = 0xb7, dst_reg = 0x0, src_reg = 0x0, off = 0x0, imm = 0x2aaa}
> > >
> > > And it's rewritten as
> > >
> > > (gdb) p rewritten
> > > $9 = 3
> > > (gdb) p/x insn_buff[0]
> > > $10 = {code = 0xb7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad0283}
> > > (gdb) p/x insn_buff[1]
> > > $11 = {code = 0xa7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad2829}
> > > (gdb) p/x insn_buff[2]
> > > $12 = {code = 0xbf, dst_reg = 0x0, src_reg = 0xb, off = 0x0, imm = 0x0}
> > >
> > > IIUC.
> > >
> >
> > Johan, what do you think?
>
> Hmm, I can take a look at it. What is the target arch?
>

It fails even on x86.

-- 
WBR, Yauheni

