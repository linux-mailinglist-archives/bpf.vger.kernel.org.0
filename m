Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF3564F9F
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiGDIWQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiGDIWP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 04:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17D8B218F
        for <bpf@vger.kernel.org>; Mon,  4 Jul 2022 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656922931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i2+xnZOyWnYvRkZ76TZGuf2sgwzENKSLGvQ66QoNBss=;
        b=ImE47MFf2N14I0bmh1G/nLdccIxVeUWulqzO1Ms3NxeG8mb0kZFTb4t72OSmUnvwa3PsCg
        oUvdSDYwyyXirxM/6x5JKko9lC1EtPtyvOgg9lS859k4XJ99yqE29lTLyPOBhzxNDlqw/S
        s/O+hUCqfpEdsCCDkRduk944VB3o95I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-q7kEs9hcM8Wb5vpV-RAY7Q-1; Mon, 04 Jul 2022 04:22:05 -0400
X-MC-Unique: q7kEs9hcM8Wb5vpV-RAY7Q-1
Received: by mail-pl1-f198.google.com with SMTP id b13-20020a170902e94d00b001692fd82122so4763246pll.14
        for <bpf@vger.kernel.org>; Mon, 04 Jul 2022 01:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2+xnZOyWnYvRkZ76TZGuf2sgwzENKSLGvQ66QoNBss=;
        b=h+MhMUT5HtIgRr5MemV7+EL6dsfiutzQl/P2XxIVM/xZ8tJm+4iR/xOJ2p1dASsAlx
         DDUYMIAwWiEX/RVMC3mE2Bu3ySGNDTSkd4QKH3eLl/M0li4ODDn3qdr75HhJbC7GWYeU
         eoDrwL7wMRgAuO+sw34to5EBju2YSlavTw6Iz6y1j2ezXqXxysgyZxEdsSczxyS/hYT/
         Ke6CqNalHWSEqb5duyC6T3ZvR3kllTcPGWIJlpr0bm94ORQc1TynhV0yjB0ZF2X0aUom
         8zSYeAsvGo3krLP9qsNDdkRswAGv4ePUipiGfTL/KQCTn/LY8fJZDdW58PdQBy9yQOkJ
         tcLA==
X-Gm-Message-State: AJIora+GiTpSPz8Pwtnu0+8B7ehukzpMukreuS+5g3AvcyZA0dgSHgnz
        VukEdK1f1Jd5xur3jEkk7QN3UyOmwYj4ZLSrosBRVRCtD1xj2GMME99xNNT+MPBhx/biif6ABOw
        9pI8PwdJ3Bpln3b9b0lNcDgby25HK
X-Received: by 2002:a17:90b:4c48:b0:1ec:a20e:a9bf with SMTP id np8-20020a17090b4c4800b001eca20ea9bfmr33811498pjb.209.1656922924124;
        Mon, 04 Jul 2022 01:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTRGzM9fGusAon//2sTURiW2nteABJLo2vBh1TUcwPTptVHzMQEf2pji62j5V8qmezrAaQVJQuc/+LJrPaS+M=
X-Received: by 2002:a17:90b:4c48:b0:1ec:a20e:a9bf with SMTP id
 np8-20020a17090b4c4800b001eca20ea9bfmr33811479pjb.209.1656922923847; Mon, 04
 Jul 2022 01:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
 <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net> <xunyr135ytxr.fsf@redhat.com>
In-Reply-To: <xunyr135ytxr.fsf@redhat.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Mon, 4 Jul 2022 11:21:47 +0300
Message-ID: <CANoWswmar9ELFGiqNeG7SCuaciaoNWEq2E+YaRq5J4fwRqfuZg@mail.gmail.com>
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

Hi!

On Fri, Jul 1, 2022 at 2:05 PM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
> >>>>> On Thu, 30 Jun 2022 22:57:37 +0200, Daniel Borkmann  wrote:
>
>  > On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
>  >> Hi!
>  >> test_kmod.sh fails for hardened 2 check with
>  >> test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime
>  >> err=-524
>  >> (-ERANGE during constant blinding)
>  >> Did I miss something?
>
>  > That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
>  > fails given the targets go out of range.
>
> I believe that, but how to fix the test? It should not fail.
>
>  > How do the generated insn look?
>
> The instruction when it fails is
>
> (gdb) p/x insn[0]
> $8 = {code = 0xb7, dst_reg = 0x0, src_reg = 0x0, off = 0x0, imm = 0x2aaa}
>
> And it's rewritten as
>
> (gdb) p rewritten
> $9 = 3
> (gdb) p/x insn_buff[0]
> $10 = {code = 0xb7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad0283}
> (gdb) p/x insn_buff[1]
> $11 = {code = 0xa7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad2829}
> (gdb) p/x insn_buff[2]
> $12 = {code = 0xbf, dst_reg = 0x0, src_reg = 0xb, off = 0x0, imm = 0x0}
>
> IIUC.
>

Johan, what do you think?

-- 
WBR, Yauheni

