Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10DC5A93C8
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiIAKBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiIAKBo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 06:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB46138585
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662026497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCyusxCgfcy9bKbcJepw5A3h/Tdy2+9y1ipbMaeeuyg=;
        b=AE63p5HX2Td/y/qm8B1CHKj2kl5ihBD3jup58pFuYCfZ3gpcBpcZaAtDoz8qRrA2aQa4SG
        zBseq2P4CZUqfw8nJqhyCij/j9HK8qdRZrbieteiY1TBywL/1nt3eMVZo1uANkNf3/fZW5
        OU8bSUN/Na+C12jgkCTkH8Bw4CtKR9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-1Wcl6Do7PJmRBKnFtaqpLw-1; Thu, 01 Sep 2022 06:01:34 -0400
X-MC-Unique: 1Wcl6Do7PJmRBKnFtaqpLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D58C0185A7BA;
        Thu,  1 Sep 2022 10:01:33 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 242402026D64;
        Thu,  1 Sep 2022 10:01:32 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: test_kmod.sh fails with constant blinding
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
        <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net>
        <xunyr135ytxr.fsf@redhat.com>
        <CANoWswmar9ELFGiqNeG7SCuaciaoNWEq2E+YaRq5J4fwRqfuZg@mail.gmail.com>
        <CAM1=_QTEAA4vzVHJV3-fcLOGqAcef8q6U7bg5LbH-CKehuQLxw@mail.gmail.com>
        <CANoWswnQK4NfvmNjN9DZpeq5ry4qXra9m1hSrBexT83CzUuR0w@mail.gmail.com>
Date:   Thu, 01 Sep 2022 13:01:31 +0300
In-Reply-To: <CANoWswnQK4NfvmNjN9DZpeq5ry4qXra9m1hSrBexT83CzUuR0w@mail.gmail.com>
        (Yauheni Kaliuta's message of "Tue, 5 Jul 2022 11:31:58 +0300")
Message-ID: <xuny7d2ne7lw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Johan!

>>>>> On Tue, 5 Jul 2022 11:31:58 +0300, Yauheni Kaliuta  wrote:

 > Hi, Johan!
 > On Tue, Jul 5, 2022 at 11:06 AM Johan Almbladh
 > <johan.almbladh@anyfinetworks.com> wrote:
 >> 
 >> On Mon, Jul 4, 2022 at 10:22 AM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
 >> >
 >> > Hi!
 >> >
 >> > On Fri, Jul 1, 2022 at 2:05 PM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
 >> > > >>>>> On Thu, 30 Jun 2022 22:57:37 +0200, Daniel Borkmann  wrote:
 >> > >
 >> > >  > On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
 >> > >  >> Hi!
 >> > >  >> test_kmod.sh fails for hardened 2 check with
 >> > >  >> test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime
 >> > >  >> err=-524
 >> > >  >> (-ERANGE during constant blinding)
 >> > >  >> Did I miss something?
 >> > >
 >> > >  > That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
 >> > >  > fails given the targets go out of range.
 >> > >
 >> > > I believe that, but how to fix the test? It should not fail.
 >> > >
 >> > >  > How do the generated insn look?
 >> > >
 >> > > The instruction when it fails is
 >> > >
 >> > > (gdb) p/x insn[0]
 >> > > $8 = {code = 0xb7, dst_reg = 0x0, src_reg = 0x0, off = 0x0, imm = 0x2aaa}
 >> > >
 >> > > And it's rewritten as
 >> > >
 >> > > (gdb) p rewritten
 >> > > $9 = 3
 >> > > (gdb) p/x insn_buff[0]
 >> > > $10 = {code = 0xb7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad0283}
 >> > > (gdb) p/x insn_buff[1]
 >> > > $11 = {code = 0xa7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad2829}
 >> > > (gdb) p/x insn_buff[2]
 >> > > $12 = {code = 0xbf, dst_reg = 0x0, src_reg = 0xb, off = 0x0, imm = 0x0}
 >> > >
 >> > > IIUC.
 >> > >
 >> >
 >> > Johan, what do you think?
 >> 
 >> Hmm, I can take a look at it. What is the target arch?
 >> 

 > It fails even on x86.

Did you have a chance to look?

-- 
WBR,
Yauheni Kaliuta

