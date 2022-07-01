Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240D5563229
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiGALF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGALF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 07:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 351F2804A1
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656673527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3Od3nS8KpYuMftPr6xH8hvpZ00UV6WicD3k50HKB7E=;
        b=bzWDZ51fSXmZud6R8X5q/K8o7j3o14Rk7W1O9lGPZiQsddm22a3Dancww/pgxBr2X7h4sR
        bKgy0FCBwmrdDtw0Rhq6YAEXdhL11prQXXDRZyuGQOEMHnk7RW7AXGjvCISCKNIgV6z0LV
        YzIy7IrGkKCtiGkklSPokDf2XBN+ydY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-vscgEpMDP4iB1u34gh_sVw-1; Fri, 01 Jul 2022 07:05:24 -0400
X-MC-Unique: vscgEpMDP4iB1u34gh_sVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB74285A581;
        Fri,  1 Jul 2022 11:05:23 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC4C6463DFB;
        Fri,  1 Jul 2022 11:05:22 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: test_kmod.sh fails with constant blinding
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
        <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net>
Date:   Fri, 01 Jul 2022 14:05:20 +0300
In-Reply-To: <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net> (Daniel
        Borkmann's message of "Thu, 30 Jun 2022 22:57:37 +0200")
Message-ID: <xunyr135ytxr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Daniel!

>>>>> On Thu, 30 Jun 2022 22:57:37 +0200, Daniel Borkmann  wrote:

 > On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
 >> Hi!
 >> test_kmod.sh fails for hardened 2 check with
 >> test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime
 >> err=-524
 >> (-ERANGE during constant blinding)
 >> Did I miss something?

 > That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
 > fails given the targets go out of range.

I believe that, but how to fix the test? It should not fail.

 > How do the generated insn look?

The instruction when it fails is

(gdb) p/x insn[0]
$8 = {code = 0xb7, dst_reg = 0x0, src_reg = 0x0, off = 0x0, imm = 0x2aaa}

And it's rewritten as

(gdb) p rewritten 
$9 = 3
(gdb) p/x insn_buff[0]
$10 = {code = 0xb7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad0283}
(gdb) p/x insn_buff[1]
$11 = {code = 0xa7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad2829}
(gdb) p/x insn_buff[2]
$12 = {code = 0xbf, dst_reg = 0x0, src_reg = 0xb, off = 0x0, imm = 0x0}

IIUC.





-- 
WBR,
Yauheni Kaliuta

