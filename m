Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C194D9A03
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 12:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiCOLKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiCOLKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 07:10:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C55434B1
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 04:09:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09BC0210DD
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647342546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y8oZY/KmL9X8t4G2xyHbnEp88ljJ8b/jGrfqZntkcrM=;
        b=VDnVYi3Rq1g6UDZHbbI5KMfWS7LpwkdWs9kCh5pw1PI4Gxf7AyPMrC3Ozct3RTYhr3TyCS
        U8GJMnOG5G5SY/02PiPG5A05TRNMLM8XCgX4nxBHl4l8OyLE+B5Jtcxtm6uPEQxZiuhsqv
        9WAXSBQG+mjmYFMfkUH7HRwBa6QZ9JM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1FEF13B4E
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lBYUMNFzMGIMLwAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:09:05 +0000
Message-ID: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
Date:   Tue, 15 Mar 2022 13:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     bpf@vger.kernel.org
From:   Nikolay Borisov <nborisov@suse.com>
Subject: direct packet access from SOCKET_FILTER program
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

It would seem direct packet access is forbidden from SOCKET_FILTER 
programs, is this intentional ?

I.e I'm getting:

libbpf: prog 'socket_filter': BPF program load failed: Permission denied
libbpf: prog 'socket_filter': -- BEGIN PROG LOAD LOG --
0: R1=ctx(id=0,off=0,imm=0) R10=fp0
; int socket_filter(struct __sk_buff *skb)
0: (bf) r6 = r1                       ; R1=ctx(id=0,off=0,imm=0) 
R6_w=ctx(id=0,off=0,imm=0)
1: (b7) r0 = 0                        ; R0_w=inv0
; uint8_t *tail = (uint8_t *)(long)skb->data_end;
2: (61) r2 = *(u32 *)(r6 +80)
invalid bpf_context access off=80 size=4
processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0


Regards
